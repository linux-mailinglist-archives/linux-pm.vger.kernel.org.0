Return-Path: <linux-pm+bounces-5255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024F887961
	for <lists+linux-pm@lfdr.de>; Sat, 23 Mar 2024 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6383C1C20C28
	for <lists+linux-pm@lfdr.de>; Sat, 23 Mar 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9867405F9;
	Sat, 23 Mar 2024 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iF9sKcAI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747723BF
	for <linux-pm@vger.kernel.org>; Sat, 23 Mar 2024 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711211297; cv=none; b=NKH0pUr6YbEabIhUyUvyOgzc44J9DjqlXK2gyoBclcMVRSaowsOCtZoQJLUE5f8UTSxIrcF/BynvMzoTG6HetmEYrqgPiVFO+rsh+vrxEWjove2Kf9pKYhgfDmgK2AVg/DXFoJJQtOW2itEpjH8WsWSzQ1oBjCSBSkmmdoe8rcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711211297; c=relaxed/simple;
	bh=CyyqByDkaPQJvp/7IJzQAWs8VO73NPGT3b7aq9nhGVE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l9gy+390NSFimlrPipiGoKlcyNDE0XrkX6rTXQ4G3+U+4uVK8lUmjivWRU1BfvCTr2hIUQ7DRSXE2feDakuhhQJg/doWNJ++9LctWBI+RGdQia3YZDVx+L/SI+C4NiW7LKeE7FOyu6aG/LAmKM9sUMTfeGuN9CVADkK5qD15r9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iF9sKcAI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e162b1b71so2441088f8f.1
        for <linux-pm@vger.kernel.org>; Sat, 23 Mar 2024 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711211294; x=1711816094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+uXTWxk/Ts67qUY8wq5ntI76SSBTMqDCcpmbEqPO+U=;
        b=iF9sKcAIEQCqQZQmUMRfd6WWUx2j6yI5x8UGyKF9YECD6IRlWlNIzAnl1hhk+xdUqi
         CFi9P4ONo5OF0eQfMotluwvDCM3+jiRUWNFWS/P/AlgPoB4sHziNHMh5j8x5D/IJBuHc
         1cA81Sq/S6byKy7vl4r3ELjMZUNQGdASm2sQca/cTqwpN6bXe1gE8ceUvVGECz2RvK+j
         z+QvTvFdGb0+GlmW3BlGgqgQWxfs2j/2tiyOqit2QbJke2AtL/vx8GWknRjSPIlaEiux
         JNJNzDPqFGOOw/Ov+IvWASNOPwxqUn6dWzZZbTuYN9326QZReKsLZzhv0MnGI6si7zCm
         /dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711211294; x=1711816094;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+uXTWxk/Ts67qUY8wq5ntI76SSBTMqDCcpmbEqPO+U=;
        b=AhhYfeQoo8kGJZnYLqImPKarnk6WWim5vyLZ+QaGqL8c34drQ0FKxAj/YWq8LpWKZU
         U67/QEowUBGP2X8dl+bk/UzAl2spOhvOQEWdVH8mVcU3kCjAo4UeBKPgnCFwjVyLfmfX
         xo/3krxzJcC6QUR1V3d/hfbYXX3XBuSFvseKOFS86EYBfJnl5vUAwIVlOlV9jRwglAzC
         KybQ0zp2f21GzQDoVP0CGg6X8mazldEFGZSBca8XfcZy4vmUXzWQPr2SNvpPlpItvQcI
         zvvT/T5Z5+ijI8qUxlNjnUAy5qXSCFA3KMekT5swpp92PuwQAFJvHnVJeo9rO1g0RmHO
         tMAg==
X-Gm-Message-State: AOJu0YwWiejIRgVdzH44HkNIoNLq4ITfD1j7yUy0G5afPnmgMoEBLL8g
	vWBd273lIRK2OC9DwNrXSA5ZXoBelfvGlfWYlRvl1kYm4/dhUenuOjEtrVEs
X-Google-Smtp-Source: AGHT+IERKvuxs6uqwqtsgTCIkgohAVVnjcjWCKUzZkKVIpIQOPoLBas5MhwSTa+ewMa/p7oSk8OllA==
X-Received: by 2002:adf:cd0c:0:b0:33e:8ba7:e53d with SMTP id w12-20020adfcd0c000000b0033e8ba7e53dmr1635821wrm.7.1711211294221;
        Sat, 23 Mar 2024 09:28:14 -0700 (PDT)
Received: from aquecedor-3-0.lan ([2001:818:e81c:ce00:7193:3bd:90d8:9d8])
        by smtp.gmail.com with ESMTPSA id en6-20020a056000420600b00341b451a31asm4548676wrb.36.2024.03.23.09.28.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 09:28:13 -0700 (PDT)
Date: Sat, 23 Mar 2024 16:28:10 +0000
From: =?iso-8859-1?Q?Jos=E9?= Relvas <josemonsantorelvas@gmail.com>
To: linux-pm@vger.kernel.org
Subject: Need help diagnosing why some RPL platform devices don't suspend
Message-ID: <Zf8DGgJH-u5BsChp@aquecedor-3-0.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hey folks, I had some questions about power management on my Raptor Lake laptop, a Thinkpad P1 Gen 6.

There's a few devices which are always on, according to Powertop, and I was trying to 
see if I could get them to suspend.
```
            100,0%        PCI Device: KIOXIA Corporation NVMe SSD Controller XG8
            100,0%        PCI Device: Intel Corporation Alder Lake-P PCH SPI Controller
            100,0%        PCI Device: Intel Corporation Raptor Lake PCH CNVi WiFi
            100,0%        PCI Device: Intel Corporation Raptor Lake PCIe 4.0 Graphics Port
            100,0%        PCI Device: Intel Corporation Raptor Lake Dynamic Platform and Thermal Framework Processor Participant
            100,0%        PCI Device: Intel Corporation Raptor Lake-P 6p+8e cores Host Bridge/DRAM Controller
            100,0%        PCI Device: Intel Corporation Raptor Lake LPC/eSPI Controller
            100,0%        PCI Device: Intel Corporation Raptor Lake-P [Iris Xe Graphics]
            100,0%        PCI Device: Intel Corporation GNA Scoring Accelerator module
```

The first thing I thought about doing was obviously going to the Tunables section
and enabling power management for every device with it off.
```
>> Bad           VM writeback timeout                                                                                   
   Bad           NMI watchdog should be turned off
   Bad           Runtime PM for PCI Device KIOXIA Corporation NVMe SSD Controller XG8
   Bad           Runtime PM for PCI Device Intel Corporation Raptor Lake-P 6p+8e cores Host Bridge/DRAM Controller
   Bad           Runtime PM for PCI Device Intel Corporation Raptor Lake PCH CNVi WiFi
   Bad           Runtime PM for PCI Device Intel Corporation Raptor Lake Dynamic Platform and Thermal Framework Processor Participant
   Bad           Runtime PM for PCI Device Intel Corporation Raptor Lake LPC/eSPI Controller
   Bad           Runtime PM for PCI Device Intel Corporation GNA Scoring Accelerator module
```

The following devices were affected:
- `Intel Corporation GNA Scoring Accelerator module`
- `Intel Corporation Raptor Lake LPC/eSPI Controller`

Every other device remained on, with no signs of being able to suspend.
```
            100,0%        PCI Device: KIOXIA Corporation NVMe SSD Controller XG8
            100,0%        PCI Device: Intel Corporation Raptor Lake Dynamic Platform and Thermal Framework Processor Participant
            100,0%        PCI Device: Intel Corporation Raptor Lake PCIe 4.0 Graphics Port
            100,0%        PCI Device: Intel Corporation Raptor Lake-P 6p+8e cores Host Bridge/DRAM Controller
            100,0%        PCI Device: Intel Corporation Raptor Lake-P [Iris Xe Graphics]
            100,0%        PCI Device: Intel Corporation Raptor Lake PCH CNVi WiFi
            100,0%        PCI Device: Intel Corporation Alder Lake-P PCH SPI Controller        
```

I'd like to understand what's preventing these devices specifically from suspending:

- `Intel Corporation Raptor Lake PCH CNVi WiFi`:
  I was not able to get this device to suspend, even with rfkill disabling all radios, 
  shouldn't it be able to suspend if no radio is being used?
  
- `Intel Corporation Alder Lake-P PCH SPI Controller`:
  I'm not flashing or reading anything to the PCH SPI, so that can't be it, 
  however, Intel's datasheet seems to suggest that this also controls the
  TPM. I'm guessing it doesn't suspend because the TPM must be accessible at
  all times?
  
- `Intel Corporation Raptor Lake PCIe 4.0 Graphics Port`:
  This is the port where my dgpu is connected to. Although the dgpu itself
  is suspended, this port remains powered on. I'm assuming the
  port can't suspend while there's something connected to it?
  
- `Intel Corporation Raptor Lake Dynamic Platform and Thermal Framework Processor Participant`:
  I stopped thermald, but that had no effect. Probably being used by something else?
  
- `KIOXIA Corporation NVMe SSD Controller XG8`:
  This has the root filesystem. You probably can't suspend a drive 
  with the root filesystem, but asking just in case :)

Some of these device-specific questions might be better suited for the mailing lists of their
respective drivers, but it seemed like a good idea to ask here first.

--
PS: 
The GNA accelerator should probably be suspended by default. Of all
devices listed here, it was the only one that had no driver. Also,
it's supposed to be put in D3 on MTL/ARL according to these patches:

https://lore.kernel.org/all/20230408022629.727721-1-david.e.box@linux.intel.com/
https://lore.kernel.org/all/20240227190134.1592072-3-david.e.box@linux.intel.com/

...so, given that there's no driver for it, it should be put in D3 on ADL/RPL too.
--

Thanks in advance for reading!
José Relvas

