Return-Path: <linux-pm+bounces-35361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E6B9FD31
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD71C26612
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23EE2857EF;
	Thu, 25 Sep 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="YQ7bWrZK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78498285C99
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808625; cv=none; b=qGu/Nd9B0jvJisz9Wd4SHA5TCfcQiIPE4BGAXyENwfT1xvAnA1CoeLxwN6dSX6aQ+A30n/Xq2XnxoLHpOqiLStJxt5yA4gsPq5inkYqIFJYnJyYy8v87P9b7gX+Ufr7yYePlf/ZJU8a3SMwRCcrY4Xbkcdrix5iD5GTUwc74Ol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808625; c=relaxed/simple;
	bh=zD/GEPGDzJUMByTyc0bl9Qr0XzWfns0yley3ONY2SGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSUOavkLgG1sAilkXeD0hXeuL/o+JeHrqFQbMG5C+diCZAQ7WA3jU44ADlAAThjFGoiChsKc9rC4ocCl4nI6nu/6t7TnL2n9gCAxUGgRQiVH+gLE62s3hv6WREHtyT9HBhJlky68FoNB/Ss3G84DELjGjLy1C9NQbs9/e2qj8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=YQ7bWrZK; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cXZyZ0Wfnz4J6r;
	Thu, 25 Sep 2025 09:56:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1758808614; bh=zD/GEPGDzJUMByTyc0bl9Qr0XzWfns0yley3ONY2SGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YQ7bWrZK8jG5TG+L8XsV2GsSTgoJdb2Nfcjrmuri+ycRc+88Efl+UY0THIXPZQIL0
	 wDuiuk2Bh9ChTZ3m/kpM+g3tDqxJyu+7PM9H9fopOn+mTevexZLl39oFwadFfegW5f
	 3IgeM9zqz0Pe3zboNkZUM+YC7qqLW/uDWpU+VbeE=
Message-ID: <3ee88489-278c-477a-9bfa-61e40070148f@panix.com>
Date: Thu, 25 Sep 2025 06:56:52 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fixes for hybrid sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Samuel Zhang <guoqing.zhang@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Ionut Nechita <ionut_n2001@yahoo.com>
References: <20250924205211.1059571-1-superm1@kernel.org>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20250924205211.1059571-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(Thanks Mario for the hint re: replying via Lore!)

On 9/24/25 13:52, Mario Limonciello (AMD) wrote:
> Ionut Nechita reported recently a hibernate failure, but in debugging
> the issue it's actually not a hibernate failure; but a hybrid sleep
> failure.
> 
> Multiple changes related to the change of when swap is disabled in
> the suspend sequence contribute to the failure.  See the individual
> patches for details.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573

I just wanted to say that the non-AMD-display bits of this patch were 
tested by me and seem to have fixed a problem I'd had where if I had an 
NFS share mounted on suspend/hibernate, that ~50% of the time when 
resuming the machine would be up, but disk I/O would be deadlocked (so I 
really couldn't do anything except SysRq-S/U/B).

Still going to test a few more suspend/resume/hibernate cycles, but it 
does seem to have fixed that issue for me. There was a corresponding 
patch in linux-pm earlier along the same lines, but that one only had a 
limited success rate.

I have "hybrid sleep" enabled, where systemd will go into full 
hibernation after 4 hrs, BTW.

>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  2 +-
>   include/linux/suspend.h                 |  2 ++
>   kernel/power/hibernate.c                | 13 ++++++++++++-
>   3 files changed, 15 insertions(+), 2 deletions(-)
> 

Tested-By: Kenneth Crudup <kenny@panix.com>

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


