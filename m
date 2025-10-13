Return-Path: <linux-pm+bounces-36008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DABD651D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 23:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A4664F33DE
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684902DF144;
	Mon, 13 Oct 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ph+PKv3F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314E1D88A4;
	Mon, 13 Oct 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389360; cv=none; b=j3goYUE1YAaY1YuC1TbArXRh/TvGR/czs+w3JrKxYGef4Mf6vAdqytRihf50Rwx2PohZj1nYcfp8wb976q+YJ+NnEBiUbuCVu9oDqOXhD6iQYrBGedFy2c/SN2Fia6BAlSd7laKHkmsYW8PQXP42VdanEUm10I4sYWrQltC4vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389360; c=relaxed/simple;
	bh=xOw+8rf7Uh7lk0P09CSU4b2NGtz9QYyBNMYwsaRgbWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7DKRz231YhDw2gDgbi2yK4M7ita6uGBS75Jl2Dla3G+X58zobgV9bXz1G9cklCpVYMhqDeZH2Nj22YumuI5YGKLS1Jkf32ZpsFPqNN18+hw4JjS9qGN6PiKPz6TWhxrZmyUo+k+MNkNsuZM+Yndydzey/MjsDBzavZ3aTSBusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ph+PKv3F; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4clqYK27cCz4Pdk;
	Mon, 13 Oct 2025 17:02:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760389350; bh=xOw+8rf7Uh7lk0P09CSU4b2NGtz9QYyBNMYwsaRgbWA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ph+PKv3FDXmPptWPX6iu36czKuB3qqyxN8Fyw18C5xVULNb6O33wQsgdOX8cG6F1X
	 IO8lnbwqlWnay1qWDYG4r33kjoOiZYE5n7l13+9jI6GSkWgtbafY2L5j61f9V3g6hd
	 NMLXvMmoiHYtPc/o7DGs85Uqfrm8Dc4JjLo4Yp80=
Message-ID: <92c821fb-537a-40e6-98fc-616941b57778@panix.com>
Date: Mon, 13 Oct 2025 14:02:26 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] UCSI Power Supply Updates and Bug Fixes
To: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
 gregkh@linuxfoundation.org, akuchynski@chromium.org,
 abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
 linux-pm@vger.kernel.org, Kenneth C <kenny@panix.com>
References: <20251007000007.3724229-1-jthies@google.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251007000007.3724229-1-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/6/25 17:00, Jameson Thies wrote:

> This series includes the following minor changes to power supply
> handling by the UCSI driver.
...
> base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662

I wanted to let you know that on my Dell XPS-9320, this patchset ended 
up spamming (i.e., hundreds) my dmesg with the following:

power_supply ucsi-source-psy-USBC000:002: driver reporting unavailable 
enum value 7

... which I believe to be POWER_SUPPLY_USB_TYPE_PD_DRP .

In my case it was coming from the call to 
power_supply_show_enum_with_available() on/around line 380 in 
.../drivers/power/supply/power_supply_sysfs.c ; I'd tried adding 
POWER_SUPPLY_USB_TYPE_PD_DRP to con->psy_desc.usb_types in 
ucsi_register_port_psy() in
.../drivers/usb/typec/ucsi/psy.c thinking that may fix it with no success.

LMK if you need any further info,

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


