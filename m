Return-Path: <linux-pm+bounces-36318-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2ABE5E0A
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 02:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C126354D81
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 00:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232291F418D;
	Fri, 17 Oct 2025 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="D79WFygh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA661C2BD;
	Fri, 17 Oct 2025 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760660713; cv=none; b=dkLiPheVoE+iZpWZOlaqXBKeUybqh4J1LbGOjx3B4RfJJYGjoMvrhKnyXedt3a55VhiMJHiE+WY60J5KhmPKNrutHrQx8ZXefvpbHAfPXqEOe6+5eLd04XK6vlzcn0l7S5wwwzWpwXSAZKdjVcyKB+8KsoATB8VJAzjmCLRd11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760660713; c=relaxed/simple;
	bh=1JeKVVanfJCaQzFtko9uKMb8cNbbykSsHePnd5FBO/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNbIJ3RryJOKNGMI2YPZMifOwOCi3NNCJ8q3ZBl7XGcbOXlaIB27+VfEvYyZzp20ovK4rRrCeaLCpGf9gvtn8gh8dTNmqPY6eOhFd8QJ04QzWIQnXtOD8umD87YOeNLXQuh1GFLgbyekmta2w6y0c6xXafJyM1gaQhtMHgSKj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=D79WFygh; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cnlvk4PYvz4F07;
	Thu, 16 Oct 2025 20:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1760660707; bh=1JeKVVanfJCaQzFtko9uKMb8cNbbykSsHePnd5FBO/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D79WFyghWkyEVwQQuyO57GmnvUnAvbiHkUQvefgOC16s7jQlU30vbdZSnsZ6aXeUv
	 aAzl1yjdxe2PfIt4b1VLpw8ih/NUdhY6+gaBhA0hfr46zYx0d4+T80OFY3X96mLaNi
	 wN7r4GEU6AUs6EY6yBbP0m+YVcUYuuHu8FG5A288=
Message-ID: <d5650477-1c9c-4d87-a4c4-7bf7b3c20f5d@panix.com>
Date: Thu, 16 Oct 2025 17:25:03 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] UCSI Power Supply Updates
To: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kenneth C <kenny@panix.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, bleung@chromium.org,
 gregkh@linuxfoundation.org, akuchynski@chromium.org,
 abhishekpandit@chromium.org, sebastian.reichel@collabora.com,
 linux-pm@vger.kernel.org
References: <20251016235909.2092917-1-jthies@google.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251016235909.2092917-1-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Tested-By: Kenneth R. Crudup <kenny@panix.com>

On 10/16/25 16:59, Jameson Thies wrote:
> This series includes the following minor changes to power supply
> handling by the UCSI driver.
> 
> 1) Adds the "Status" property to power supplies registered by the UCSI
> driver.
> 2) Updates ucsi.c to report a power supply change all power opmode
> changes. Currently this only gets reported when opmode is PD.
> 3) Updates ucsi.c to report a power supply change when the PPM signals
> a sink path change.
> 
> v2 changes
> - Removed patch adding support for reporting DRP power supply types.
>    It led to spam in dmesg and needs further debug.
> - Removed patch to report 0 max current when a port is not connected.
>    This is a bug fix and should be reviewed separately.
> - Removed patch to refresh connector status after PR swaps. This is
>    not directly related to the power supply and should be sent up
>    separately.
> - Updated patch notify the power supply class of sink path status
>    changes. It now uses a single bit mask for checking both sink path
>    status changes and battery charging status changes.
> 
> Jameson Thies (3):
>    usb: typec: ucsi: psy: Add power supply status
>    usb: typec: ucsi: Report power supply changes on power opmode changes
>    usb: typec: ucsi: Report power supply change on sink path change
> 
>   drivers/usb/typec/ucsi/psy.c  | 26 ++++++++++++++++++++++++++
>   drivers/usb/typec/ucsi/ucsi.c |  5 ++++-
>   drivers/usb/typec/ucsi/ucsi.h |  4 ++++
>   3 files changed, 34 insertions(+), 1 deletion(-)
> 
> 
> base-commit: e40b984b6c4ce3f80814f39f86f87b2a48f2e662

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


