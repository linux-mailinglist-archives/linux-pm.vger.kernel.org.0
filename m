Return-Path: <linux-pm+bounces-26834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A97FFAAEC18
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CB97A7CBA
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15421214201;
	Wed,  7 May 2025 19:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPblTw3d"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468F1F7586
	for <linux-pm@vger.kernel.org>; Wed,  7 May 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746645480; cv=none; b=Bk1eUWOU54bHUPPPKdOtvzst2qf86vJusm+f36odJqjdBDp1wis6XocOw9Fo/SEcIYGtnjLKVNjmkF39IYAU1P173v438i72DWH2rOKh1p/QDwwhFBzgrfH7C3H3RAzt56I2kz/Hdbgzt1sC5vbCIiqcp/eRUaAyy/nIM7YjI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746645480; c=relaxed/simple;
	bh=DCZi3XO0F+/kU4KNVocM08wcTKdcxjH7Jm0mP/3gZP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oheDCfc00VH2I1nCaOxrtOUF2GII0AgAsYUr7goqn8A5LtPLuCfzzb4nbcJhvlvvVVkOGOykfibBI7jq5WtCXlP/EoW+k0uYyfa3PuL8WBXDOWv50znxeVKQ4jEVBdqEQNM7Vb2CQ1guWOIbQBnFcNGeeiUfK3If5RKNUBV09gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPblTw3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DC8C4CEE2;
	Wed,  7 May 2025 19:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746645479;
	bh=DCZi3XO0F+/kU4KNVocM08wcTKdcxjH7Jm0mP/3gZP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QPblTw3dUWdBnvdaq0izKafCuCBm01Xk5wtBaCX6WEUf76mAdlMlLqYlPZY3/rMLJ
	 3IAHdxgrETvdab3o7MVP/ofXiuf0yOBRrrqa1LUYbpfiwI+Wr1pzfWJhCm/a4YxLE1
	 WYQvYWhhsI/Dc2w0A4DSQn0sY1NC6Ll0FFp/SX30t6YEdhB1Nvncrzs7kCUfLwE8p1
	 jz3IVgAewRb6ZeY5HV6SfJvLTgiHBlbFnyPmIYIckAJ56CYDMzcNgj2HDMLIQhbNCa
	 ++3yAYeLE9mFvPuEMOCnjkKiTqUqGgC0SHHZ/mAtpkEeHgOXIRkfLqsr//TEUZq1gR
	 upOyAoQze5P2Q==
Message-ID: <98d527c6-a185-40f9-8ce3-46f5d7a67e81@kernel.org>
Date: Wed, 7 May 2025 14:17:57 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] drm/amd: Use suspend and hibernate post freeze
 notifications
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 "open list:HIBERNATION (aka Software Suspend, aka swsusp)"
 <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250501211734.2434369-1-superm1@kernel.org>
 <20250501211734.2434369-3-superm1@kernel.org>
 <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0jwO9nv+mnuHy7fbdf4rNW1VW-zLp611ywppzFt3vzy1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/2025 2:14 PM, Rafael J. Wysocki wrote:
> On Thu, May 1, 2025 at 11:17 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification
>> callback support") introduced a VRAM eviction earlier in the PM
>> sequences when swap was still available for evicting to. This helped
>> to fix a number of memory pressure related bugs but also exposed a
>> new one.
>>
>> If a userspace process is actively using the GPU when suspend starts
>> then a deadlock could occur.
>>
>> Instead of going off the prepare notifier, use the PM notifiers that
>> occur after processes have been frozen to do evictions.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
>> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 7f354cd532dc1..cad311b9fd834 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4917,10 +4917,10 @@ static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mo
>>          int r;
>>
>>          switch (mode) {
>> -       case PM_HIBERNATION_PREPARE:
>> +       case PM_HIBERNATION_POST_FREEZE:
>>                  adev->in_s4 = true;
>>                  fallthrough;
>> -       case PM_SUSPEND_PREPARE:
>> +       case PM_SUSPEND_POST_FREEZE:
>>                  r = amdgpu_device_evict_resources(adev);
>>                  /*
>>                   * This is considered non-fatal at this time because
>> --
> 
> Why do you need a notifier for this?
> 
> It looks like this could be done from amdgpu_device_prepare(), but if
> there is a reason why it cannot be done from there, it should be
> mentioned in the changelog.

It's actually done in amdgpu_device_prepare() "as well" already, but the 
reason that it's being done earlier is because swap still needs to be 
available, especially with heavy memory fragmentation.

I'll add more detail about this to the commit for the next spin if 
you're relatively happy with the new notifier from the first patch.

