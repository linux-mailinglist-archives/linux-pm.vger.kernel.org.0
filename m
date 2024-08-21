Return-Path: <linux-pm+bounces-12689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2A595A851
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 01:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261BC1F21CF6
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 23:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2791741CB;
	Wed, 21 Aug 2024 23:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UiBdbbfS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95726ACB;
	Wed, 21 Aug 2024 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283106; cv=none; b=eJAGM1HVg5ozfO/hXjPS2SofdqB64NV7qKAnffU9ZQciKYX05m06ZVYGlBnlcnoU/ClNuX++omyCnpA38KlBcVt4o95Q1FkcM23F7HfgFdtCr0nuzEQtiKNgHlNe28+qjvj4njQ2K15P6Y+KKsBYhSMsQKFisXEukvAmzLP0ltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283106; c=relaxed/simple;
	bh=/1ierzCrV2XHO5Z7bfegHIj87yjQormZfA1vFPqNJmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2ZfoQGT7CLrS2jFy24BwLiGXFcgQpL7SNvG4AXGVAMkZ3+VwUatGkj2rf0ZS7qDeo/KrKXfaL+PdkV2FDdtphwanLo9PnAVKiVIob+Ju6YXnT500xXEMMmn5PiLSddotTSQMm1GftnqRcOJ1Xssr10wUyg45UkXlHInShicFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UiBdbbfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7538CC32781;
	Wed, 21 Aug 2024 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724283105;
	bh=/1ierzCrV2XHO5Z7bfegHIj87yjQormZfA1vFPqNJmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UiBdbbfSVhsZsX5dpZtj3qeu6sFXK+al5rhwWRYHfiVbP2Qn+/YxX5fPQ8bTQvsbr
	 kwDe4vMTtRBJA8Tux5Nqz0XjTs622Ty/WiOewwgT2IQFff2cUwNJcW5HgUc5H9BeNl
	 OEdgiiGlATgqW3xPugQVk9SIfhvslDZI2wel94N8=
Date: Thu, 22 Aug 2024 07:31:43 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>
Subject: Re: USB-C adapter like Dell DA300 using > 5 W
Message-ID: <2024082207-foothill-swirl-0ad0@gregkh>
References: <38b871f7-8583-4b9a-940b-ee33a1b6206d@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38b871f7-8583-4b9a-940b-ee33a1b6206d@molgen.mpg.de>

On Wed, Aug 21, 2024 at 11:32:04PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the Intel Kaby Lake laptop Dell XPS 13 9360 with Debian sid/unstable and
> *powertop* 2.15-3, connecting a USB-C adapter like Dell DA300 or LMP USB-C
> mini Dock (P/N 15954) [1] and connecting only an Ethernet cable (module
> r8152 is used), the adapter gets very hot, and according to PowerTOP it uses
> over 5 Watts – almost more as the laptop idling.
> 
>     $ lsusb
>     Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     Bus 001 Device 002: ID 0cf3:e300 Qualcomm Atheros Communications QCA61x4
> Bluetooth 4.0
>     Bus 001 Device 003: ID 04f3:2234 Elan Microelectronics Corp. Touchscreen
>     Bus 001 Device 004: ID 0c45:670c Microdia Integrated Webcam HD
>     Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>     Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>     Bus 003 Device 002: ID 2109:2820 VIA Labs, Inc. VL820 Hub
>     Bus 003 Device 003: ID 06c4:c412 Bizlink International Corp. DELL DA300
>     Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>     Bus 004 Device 002: ID 2109:0820 VIA Labs, Inc. VL820 Hub
>     Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153
> Gigabit Ethernet Adapter
> 
> With `LANG= sudo powertop --auto-tune` it stays high.
> 
> PowerTOP:
> 
> ```
> The battery reports a discharge rate of 6.01 W
> The energy consumed was 146 J
> The estimated remaining time is 3 hours, 51 minutes
> 
> Summary: 384.6 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and
> 8.5% CPU use
> 
> Power est.              Usage       Events/s    Category       Description
>   5.94 W      0.0%                      Device         Display backlight
>   5.23 W    100.0%                      Device         USB device: USB
> Optical Mouse (Logitech)
>   4.62 W     66.1%                      Device         USB device: USB
> 10/100/1000 LAN (Realtek)
>   205 mW    100.0%                      Device         USB device: Fujitsu
> Keyboard (Fujitsu)
>  14.1 mW     13.5 ms/s       0.9        kWork intel_atomic_commit_work
> ```
> 
> At another time:
> 
> ```
> The battery reports a discharge rate of 10.5 W
> The energy consumed was 235 J
> The estimated remaining time is 2 hours, 20 minutes
> 
> Summary: 395.8 wakeups/second,  0.0 GPU ops/seconds, 0.0 VFS ops/sec and
> 23.8% CPU use
> 
> Power est.              Usage       Events/s    Category       Description
>   7.13 W    100.0%                      Device         USB device: USB
> 10/100/1000 LAN (Realtek)
>   3.92 W     15.8%                      Device         Display backlight
>   320 mW      0.0 us/s      0.00        Process        [PID 1349]
> /usr/bin/pipewire
>  63.6 mW     65.4 ms/s       0.5        Process        [PID 4982]
> /usr/lib/thunderbird/thunderbird
>  24.9 mW     25.6 ms/s       6.7        Process        [PID 37753]
> /usr/lib/firefox-nightly/firefox-bin -contentproc -isForBrowser -prefsLen
> 36793 -prefMapSize 265654 -jsInitLe
>  14.7 mW     15.1 ms/s       0.5        kWork intel_atomic_commit_work
> ```
> 
> The heat of the USB-C adapter might suggest, that it draws that much power.
> What is your experience? Can you suggest something?

Buy a different adapter?  That seems like something is really wrong with
it.  Does other devices also suck that much power from that port on the
laptop?

thanks,

greg k-h

