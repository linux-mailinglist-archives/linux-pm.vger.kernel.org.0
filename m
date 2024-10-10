Return-Path: <linux-pm+bounces-15439-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EB997FE7
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91BBA2822B2
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3EA2040A7;
	Thu, 10 Oct 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP9OunQk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349F1C9EB9;
	Thu, 10 Oct 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728547187; cv=none; b=iz23qndNC/1XSDVd3IqcGONe1JL/vScmqpueSCPs17APN365BS9l8XOpqk3391ZNywUk/7Xuy6528NDgBU3qUBvvSepAKCy88sB/XdTRqfZwtLxGcR8XqGOpzUVnYQNs3xaHXgLhmjVqZqlvVoArDHq9XzweRJpsmwVNWk7Wllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728547187; c=relaxed/simple;
	bh=muAZMRI2tDj1V89m2T/NIkcrnu4Jh9FJ/nPtQfwy6IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIUYYdNwVsFBVE9Qdyi3U38+9JffLo4MCkTYPEujwn8UHJRRiWnNqUAdh22fVUzF2S9P5kLWe/47dCeRIztDGqzrZSu1vstaOIvUtO9HbMCds1SXQys93YJZvWN7HYW4vszV1VIvQDjH5RpIEzQk/zhtOcqdY0Jo6rpEIhdlYr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP9OunQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF73C4CEC6;
	Thu, 10 Oct 2024 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728547186;
	bh=muAZMRI2tDj1V89m2T/NIkcrnu4Jh9FJ/nPtQfwy6IU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uP9OunQkBW/U65qnU87GN4IQbU7KnkafbVL2ig6xHssv99uGSyDFSgu2cGdMmNwsp
	 9ySfQEhzPlSTVyCnIg+/SF/HPUfOaNrKM5qqTSXV1hCQqLyFtThxZl49hFG5Pym7gY
	 0OtG/XC12H+GF5VZAHAc2lOgqXi3rNdw/ogRAIMctKBoC5kKyr8j0eKHarO3RiDl8b
	 KzUBRVjYP1zVFRk59CFKgPYvYlgiruzlAkZFn1oQgJl9TN8wwT5WlkaxtOlzautaIZ
	 gPl5eUDDyMV/fNL33HgY1U67C3KdZ0Awdi2La52Xr4H5xQ0TZCp7rMCY7zzWLuoq2x
	 E93e8j6d8S2iA==
Message-ID: <9d8fe284-a746-4dfe-aab0-37c6b151f216@kernel.org>
Date: Thu, 10 Oct 2024 10:59:40 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/5] firmware: ti_sci: Introduce system suspend
 support
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Kamlesh Gurudasani <kamlesh@ti.com>,
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
References: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241007-tisci-syssuspendresume-v13-0-ed54cd659a49@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Markus

On 07/10/2024 09:08, Markus Schneider-Pargmann wrote:
> Abstract
> ********
> 
> This series introduces necessary ti_sci driver functionality to support
> various Suspend-to-RAM modes on TI AM62 family of devices. These Low
> Power Modes include Deep Sleep and MCU Only as described in section
> "6.2.4 Power Modes" of the AM62P Technical Reference Manual [0].
> 
> Summary
> *******
> 
> This series is a restructuring and rebase of the patch series by
> Dave Gerlach [1] and Dhruva Gole [2]. It applies on top of Linux
> 6.12-rc1.
> 
> The kernel triggers entry to Low Power Mode through the mem suspend
> transition with the following:
> 
> * At the  bootloader stage, one is  expected to package the  TIFS stub
>   which then gets  pulled into the Tightly coupled memory  of the Device
>   Mgr  (DM) R5  when it  starts up.  If using  U-Boot, then  it requires
>   tispl.bin to contain the TIFS stub. Refer to documentation in upstream
>   u-boot[3] for further details. The  supported firmware version is from
>   TI Processor SDK >= 10.00 ie. tag 10.00.04 from ti-linux-firmware [4].
> 
> * Use a TF-A binary that supports PSCI_SYSTEM_SUSPEND call. This causes
>   system to use PSCI system suspend as last step of mem sleep.
> 
> * We add support for the TISCI_MSG_QUERY_FW_CAPS message, used to retrieve
>   the firmware capabilities of the currently running system firmware [6].
>   Sysfw version >= 10.00.04 support LPM_DM_MANAGED capability, where
>   Device Mgr firmware now manages which low power mode is chosen. Going
>   forward, this is the default configuration supported for TI AM62 family
>   of devices. The state chosen by the DM can be influenced by sending
>   constraints using the new LPM constraint APIs. (Patch 1)
> 
> * The firmware requires that the OS sends a TISCI_MSG_PREPARE_SLEEP
>   message in order to provide details about suspend. The ti_sci driver
>   must send this message to firmware with the above information
>   included, which it does during the driver suspend handler when
>   PM_MEM_SUSPEND is the determined state being entered. The mode being
>   sent depends on whether firmware capabilities have support for
>   LPM_DM_MANAGED feature. Legacy firmware or those supporting other
>   modes can extend the mode selection logic as needed. (Patch 2)
> 
> * We also add the remaining TISCI Low Power Mode messages required for
>   inquiring wake reason and managing LPM constraints as part of a new PM
>   ops. These messages are part of the TISCI PM Low Power Mode API [5].
>   (Patch 3)
> 
> * Finally if any CPUs have PM QoS resume latency constraints set, we
>   aggregate these and set the TISCI system-wide latency constraint.
>   (Patch 4)
> 
> Testing
> *******
> 
> This series can for example be tested with a am62a-lp-sk board.

Tested on am62-sk.

Tested-by: Roger Quadros <rogerq@kernel.org>

> 
> For am62a-lp-sk all usb nodes have to be disabled at the moment (usbss0,
> usb0, usbss1 and usb1). There is currently an issue with USB Link Power
> Management and turning off the USB device which is being worked on.

Or you can this patch [1].

[1] https://lore.kernel.org/all/20241009-am62-lpm-usb-v2-1-da26c0cd2b1e@kernel.org/

cheers,
-roger
-- 
cheers,
-roger

