Return-Path: <linux-pm+bounces-13904-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC49721A0
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 20:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A44B22722
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6926817C9E8;
	Mon,  9 Sep 2024 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ginkel.com header.i=@ginkel.com header.b="ZUzoomFc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752B224F6
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905360; cv=none; b=TVKHfdzzIiIn8qgwqU1XXAMBin2im2bMYNCh+Gf7uiHCIW9+f8sAiU52YEbiIFqhhHVszVSWvvtC49aMACI5DfG+tSJWR/vUnYZQwFVYDj4ivNLXW3Qnw1Z5RIfYV+z30kFNe4pi96yvwRGKC8aeHYjxaNiefR7uw+LgYBQW73Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905360; c=relaxed/simple;
	bh=zcd5E8wTxqCGcoqw24XxWa781zpChwdUw/3dalR1TtI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UXFi1shhyqf+h3hAqXVkENLdY2RqpHiPJtvvwcGcKOiv986lKuz4TDdawM88Z2RgLqshN/aCDRTv20oVcq2YD2zsgeVOsP9GRhrNKtFd/YIolQTvy/vYEzMkX4zSrvBknWtpPTHYuRSC981+8vBE7yjnBOdKiVRcJBERcJZ3XCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ginkel.com; spf=pass smtp.mailfrom=ginkel.com; dkim=pass (1024-bit key) header.d=ginkel.com header.i=@ginkel.com header.b=ZUzoomFc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ginkel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ginkel.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so54900555e9.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ginkel.com; s=google; t=1725905356; x=1726510156; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rLPa6Ae5+nXgexcXZ/amWgKdFAntXj9xFf6qSanqzWQ=;
        b=ZUzoomFcL1QwNj3Rk5VjFY7IpQALDZks4PZHHqbFG68kNuZEZWw73esN6vfO4ffcui
         ZQd3DeCXUy09wcyo3CfDGvzWtXCQ3qZt4PsmeQVfAXUbicA2d7wgmkZd7XYygZY+5Pkh
         MX3buat5so404w5YIpMC1L3YMahu4PuixH0eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725905356; x=1726510156;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLPa6Ae5+nXgexcXZ/amWgKdFAntXj9xFf6qSanqzWQ=;
        b=TTtYB18AhN8DJZPmSeWbWihBN/w5gwEeJvO9UNJ5SgtAR/YzSwoyxqbzVcEnKvylY7
         OXvZ7AZbCVxBFvQI3aOIR2m25ehDHbkKzRc8OZiIlpCCCvQP9TJfWzM31YkQSVf27FiV
         tEUSFqbPoj10kRecAsP5THF2xoU/NHBmFoWZFzBCHIkHOiFgr9slY1qAmz9pfpVGPidK
         AlDKdN+cG8cx+N46ZeoDS7iNBEuq6wjAH+h18/NlZizRbVmZcfGNDr8LsaEAcFaLHIQr
         vfU7DBlXhvPnii/UxL9ylEskXW2T72N0+xrKcnHZEt1uymDZPfi8XE4Z942wKpGrl05B
         L0LA==
X-Forwarded-Encrypted: i=1; AJvYcCVie+pOrQ9M9K9WlMUWMnjsiwN44bszT/XqFUL8Mq3uGU90CMpIjnh7bAVWCBsxoZ/mfiK2lCqtaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ujBxZp6fTjpKYGkMTLESmfPf/5RZkdmcMsBrWCPkJUDlsE0U
	ZqsNge9b1RdcUFB/1o7HhpjEc56tgN9a/7K2We6SZyvZ1YwFvjd7jeah3XboNCI7b0ij9vtEkSv
	i1JFkIDLNwZ7jpKtKkDItZkMFOTnQHOksusUSWLH6lW4eihuaRrRLHA==
X-Google-Smtp-Source: AGHT+IGkv4EMl1f2yoelHvkgIxmfeu36lpsGUnjDTNEwDIaeoh0BJYIZmAT69ClRbYDAM8G8FVVRzfndKsbmDtQht7s=
X-Received: by 2002:adf:a457:0:b0:374:c318:2190 with SMTP id
 ffacd0b85a97d-37892466d2emr6888269f8f.59.1725905356126; Mon, 09 Sep 2024
 11:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Thilo-Alexander Ginkel <thilo@ginkel.com>
Date: Mon, 9 Sep 2024 20:09:00 +0200
Message-ID: <CANvSZQ__77y_x=VPmLGrP4sWNHpZ0oTLW=M5uCbJ598WhCvQhQ@mail.gmail.com>
Subject: Attaching Ryzen 7 7840HS laptop to Lenovo Thunderbolt 4 Dock causes
 high CPU load
To: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I recently got a Framework 16 laptop (based on AMD Ryzen 7 7840HS).
When the laptop is placed on my desk, I am docking it using a Lenovo
Thunderbolt 4 Dock (via Thunderbolt), to which an 8K monitor (via
USB-C) and various USB peripherals are connected.

Recently I noticed that my laptop's load is > 4 while docked although
the system is mostly idle.

This seems to be caused by a few kworker/0:x+pm tasks spending plenty
of time in "uninterruptible sleep" ("D"). A few random stack traces
captured for them look like this:

[<0>] rpm_resume+0x25f/0x700
[<0>] rpm_resume+0x2d3/0x700
[<0>] rpm_resume+0x2d3/0x700
[<0>] pm_runtime_work+0x70/0xb0
[<0>] process_one_work+0x17b/0x330
[<0>] worker_thread+0x2e2/0x410
[<0>] kthread+0xcf/0x100
[<0>] ret_from_fork+0x31/0x50
[<0>] ret_from_fork_asm+0x1a/0x30

or

[<0>] pci_power_up+0x144/0x190
[<0>] pci_pm_runtime_resume+0x33/0xf0
[<0>] __rpm_callback+0x41/0x170
[<0>] rpm_callback+0x55/0x60
[<0>] rpm_resume+0x4d3/0x700
[<0>] rpm_suspend+0x5db/0x5f0
[<0>] pm_runtime_work+0x84/0xb0
[<0>] process_one_work+0x17b/0x330
[<0>] worker_thread+0x2e2/0x410
[<0>] kthread+0xcf/0x100
[<0>] ret_from_fork+0x31/0x50
[<0>] ret_from_fork_asm+0x1a/0x30

Fast-forward, I isolated the cause of this to be related to the power
management of the following AMD Thunderbolt PCI devices:

00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 19h
USB4/Thunderbolt PCIe tunnel (prog-if 00 [Normal decode])
        Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1453
        Flags: bus master, fast devsel, latency 0, IRQ 40, IOMMU group 4
        Bus: primary=00, secondary=03, subordinate=61, sec-latency=0
        I/O behind bridge: 6000-9fff [size=16K] [16-bit]
        Memory behind bridge: 78000000-8fffffff [size=384M] [32-bit]
        Prefetchable memory behind bridge: 7800000000-87ffffffff
[size=64G] [32-bit]
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot+), IntMsgNum 0
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc.
[AMD] Device 1453
        Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Capabilities: [150] Advanced Error Reporting
        Capabilities: [270] Secondary PCI Express
        Capabilities: [400] Data Link Feature <?>
        Kernel driver in use: pcieport

00:04.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 19h
USB4/Thunderbolt PCIe tunnel (prog-if 00 [Normal decode])
        Subsystem: Advanced Micro Devices, Inc. [AMD] Device 1453
        Flags: bus master, fast devsel, latency 0, IRQ 41, IOMMU group 5
        Bus: primary=00, secondary=62, subordinate=c0, sec-latency=0
        I/O behind bridge: a000-efff [size=20K] [16-bit]
        Memory behind bridge: 60000000-77ffffff [size=384M] [32-bit]
        Prefetchable memory behind bridge: 6800000000-77ffffffff
[size=64G] [32-bit]
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot+), IntMsgNum 0
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [c0] Subsystem: Advanced Micro Devices, Inc.
[AMD] Device 1453
        Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Capabilities: [150] Advanced Error Reporting
        Capabilities: [270] Secondary PCI Express
        Capabilities: [400] Data Link Feature <?>
        Kernel driver in use: pcieport

c3:00.5 USB controller: Advanced Micro Devices, Inc. [AMD] Pink
Sardine USB4/Thunderbolt NHI controller #1 (prog-if 40 [USB4 Host
Interface])
        Subsystem: Framework Computer Inc. Device 0005
        Flags: bus master, fast devsel, latency 0, IRQ 86, IOMMU group 26
        Memory at 90800000 (64-bit, non-prefetchable) [size=512K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [64] Express Endpoint, IntMsgNum 0
        Capabilities: [a0] MSI: Enable- Count=1/16 Maskable- 64bit+
        Capabilities: [c0] MSI-X: Enable+ Count=16 Masked-
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Capabilities: [2a0] Access Control Services
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt

c3:00.6 USB controller: Advanced Micro Devices, Inc. [AMD] Pink
Sardine USB4/Thunderbolt NHI controller #2 (prog-if 40 [USB4 Host
Interface])
        Subsystem: Framework Computer Inc. Device 0005
        Flags: bus master, fast devsel, latency 0, IRQ 107, IOMMU group 27
        Memory at 90880000 (64-bit, non-prefetchable) [size=512K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [64] Express Endpoint, IntMsgNum 0
        Capabilities: [a0] MSI: Enable- Count=1/16 Maskable- 64bit+
        Capabilities: [c0] MSI-X: Enable+ Count=16 Masked-
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1
Len=010 <?>
        Capabilities: [2a0] Access Control Services
        Kernel driver in use: thunderbolt
        Kernel modules: thunderbolt

As soon as I disable power management for those in powertop
(internally doing echo 'on' >
'/sys/bus/pci/devices/0000:c3:00.5/power/control') the load falls
below 1 back to normal levels.

I originally spotted this behavior in 6.10.8-arch1-1 (using the LTS
kernel based on 6.6.49 makes no difference), but have since also been
able to reproduce it using the 6.11.0-rc6 mainline kernel.

Complete lspci -v output: https://paste.tgbyte.io/jrTVSJJk
dmesg output: https://paste.tgbyte.io/upgaEFzP

I'd appreciate any hints on how to further isolate the root cause of this issue.

Thanks,
Thilo

