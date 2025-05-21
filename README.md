# WatchPartyThingy

A containerized streaming party solution that allows you to watch content together with friends through a web browser. This project creates a virtual desktop environment with Chrome running in either kiosk or debug mode, accessible via VNC.

## Features

- 🎥 Virtual desktop environment with XFCE4
- 🌐 Chrome browser with custom extension support
- 🔒 VNC access with password protection
- 📺 HLS streaming support
- 🎮 Debug mode for development
- 🎵 Audio support via PulseAudio

## Prerequisites

- Docker
- Bash shell
- At least 5GB of shared memory (--shm-size=5g)

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/jacobmobley/watchpartythingy.git
cd watchpartythingy
```

2. Run in kiosk mode (default):
```bash
./run_watchparty.sh
```

3. Run in debug mode:
```bash
./run_watchparty.sh debug
```

## Accessing the Environment

- **VNC Access**: Connect to `localhost:5900` with password `watchparty`
- **Web Access**: Open `http://localhost:6080` in your browser
- **HLS Stream**: Available at `http://localhost:8080`

## Ports

- `5900`: Raw VNC
- `6080`: noVNC (HTML5)
- `8080`: HLS web server

## Development

### Debug Mode

When running in debug mode:
- Chrome runs without kiosk mode
- Environment variable `DEBUG_MODE=true` is set
- Useful for development and testing

### Building from Source

1. Build the Docker image:
```bash
docker build -t watchparty .
```

2. Run the container:
```bash
docker run -d \
    --name watchparty \
    --shm-size=5g \
    -p 5900:5900 \
    -p 6080:6080 \
    -p 8080:8080 \
    -v wp-data:/data/chrome \
    watchparty
```

## Configuration

### Environment Variables

- `DEBUG_MODE`: Set to "true" for debug mode, "false" for kiosk mode

### Supervisor Configuration

The project uses supervisor to manage processes. Configuration can be found in `supervisord.conf`.

## Troubleshooting

1. If Chrome fails to start:
   - Check supervisor logs: `docker exec watchparty supervisorctl status`
   - View Chrome logs: `docker exec watchparty cat /var/log/supervisor/chromium.log`

2. If VNC connection fails:
   - Ensure ports are properly exposed
   - Check if the container is running: `docker ps`

## License

[Your License Here]

## Contributing

[Your Contributing Guidelines Here]
