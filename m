Return-Path: <linux-pm+bounces-12660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3343E95A6AB
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA2B8B224D7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 21:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDEA178CE2;
	Wed, 21 Aug 2024 21:32:21 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7317B501;
	Wed, 21 Aug 2024 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724275941; cv=none; b=TxH9r2iVgcXtNJH9hugnCzE14ltzTQcc7DCkslKebaj7qEWLL7YlmOW6uPWT9UIKFkp+MMBeCc2L/RJm2NWICziPJacXK82Km6HVeNuVi4qwy2xXa9ujHMH5B7JP+g16Y2OuK8YNIKQS0Ups+fmiyASKk9IWS0maDR71TYdzPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724275941; c=relaxed/simple;
	bh=x7G1HPWBcIlhyvYZes/Omld/2DwH+wIwRenyzvJjB2A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=cGOddxHloePxhkwoEzykl8Xz87j21oby2CNhffcjhF1qZva3xNcf0PNV+PYBtFUPEdTQJmjkh1lbWmBpI6YCJct2GmbI504xi0erCRzdXos95gibjiw4T0CGYVDxeDchUBB+i3fZzRw+hSNQqv0l+GZqE3PMU+Nk8brtPMPLTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4d2.dynamic.kabel-deutschland.de [95.90.244.210])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E569161E5FE07;
	Wed, 21 Aug 2024 23:32:05 +0200 (CEST)
Message-ID: <38b871f7-8583-4b9a-940b-ee33a1b6206d@molgen.mpg.de>
Date: Wed, 21 Aug 2024 23:32:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: USB-C adapter like Dell DA300 using > 5 W
Content-Language: en-US
To: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On the Intel Kaby Lake laptop Dell XPS 13 9360 with Debian sid/unstable 
and *powertop* 2.15-3, connecting a USB-C adapter like Dell DA300 or LMP 
USB-C mini Dock (P/N 15954) [1] and connecting only an Ethernet cable 
(module r8152 is used), the adapter gets very hot, and according to 
PowerTOP it uses over 5 Watts – almost more as the laptop idling.

     $ lsusb
     Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
     Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications 
QCA61x4 Bluetooth 4.0
     Bus 001 Device 003: ID 04f3:2234 Elan Microelectronics Corp. 
Touchscreen
     Bus 001 Device 004: ID 0c45:670c Microdia Integrated Webcam HD
     Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
     Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
     Bus 003 Device 002: ID 2109:2820 VIA Labs, Inc. VL820 Hub
     Bus 003 Device 003: ID 06c4:c412 Bizlink International Corp. DELL DA300
     Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
     Bus 004 Device 002: ID 2109:0820 VIA Labs, Inc. VL820 Hub
     Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. 
RTL8153 Gigabit Ethernet Adapter

With `LANG= sudo powertop --auto-tune` it stays high.

PowerTOP:

```
The battery reports a discharge rate of 6.01 W
The energy consumed was 146 J
The estimated remaining time is 3 hours, 51 minutes

Summary: 384.6 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 
8.5% CPU use

Power est.              Usage       Events/s    Category       Description
   5.94 W      0.0%                      Device         Display backlight
   5.23 W    100.0%                      Device         USB device: USB 
Optical Mouse (Logitech)
   4.62 W     66.1%                      Device         USB device: USB 
10/100/1000 LAN (Realtek)
   205 mW    100.0%                      Device         USB device: 
Fujitsu Keyboard (Fujitsu)
  14.1 mW     13.5 ms/s       0.9        kWork intel_atomic_commit_work
```

At another time:

```
The battery reports a discharge rate of 10.5 W
The energy consumed was 235 J
The estimated remaining time is 2 hours, 20 minutes

Summary: 395.8 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and 
23.8% CPU use

Power est.              Usage       Events/s    Category       Description
   7.13 W    100.0%                      Device         USB device: USB 
10/100/1000 LAN (Realtek)
   3.92 W     15.8%                      Device         Display backlight
   320 mW      0.0 us/s      0.00        Process        [PID 1349] 
/usr/bin/pipewire
  63.6 mW     65.4 ms/s       0.5        Process        [PID 4982] 
/usr/lib/thunderbird/thunderbird
  24.9 mW     25.6 ms/s       6.7        Process        [PID 37753] 
/usr/lib/firefox-nightly/firefox-bin -contentproc -isForBrowser 
-prefsLen 36793 -prefMapSize 265654 -jsInitLe
  14.7 mW     15.1 ms/s       0.5        kWork 
intel_atomic_commit_work
```

The heat of the USB-C adapter might suggest, that it draws that much 
power. What is your experience? Can you suggest something?


Kind regards,

Paul


[1]: 
https://lmp-adapter.com/product/lmp-usb-c-mini-dock/?attribute_pa_color=silver
      "LMP USB-C mini Dock (P/N 15954)"

