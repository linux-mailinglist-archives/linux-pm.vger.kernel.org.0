Return-Path: <linux-pm+bounces-36491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FEBF2B54
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 882493451AA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E832860D;
	Mon, 20 Oct 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcSnKK4i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82658221FC8
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981318; cv=none; b=X0bl51sVbPbtwVmJHGmOSMAvSDHbmfgEtRu/uyQoA9dKboNagA+WwtPKc90J90WSeH6todb/VuF8qoFluQ181NYt0Zs2ElYAOYnOzBbQiz0Kn9nU9fTTYs32tgQwebNsaPqkr/0V30Ug8EiwdA9oUv51rCFYFwMp0dEL2xrzS7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981318; c=relaxed/simple;
	bh=XoBtTVIfyCks+3vvS0y9uJAoDlapnqVQpQnuzzSfF34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRJ9LNBUJDKt1MhuIZZ8lj3ojFguBHTWtb8yC514TT6ph1cvvpPNSVAlE0QoSkjtoyuISylQXupyoKp2rRPsafcA1bT+orhhZ1L34bwWHdLQH2/nuodj0sJQuRxJcJRJodSFATlvswZhyBVR98Z7rREfR4m7obaY5An3dTyw1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcSnKK4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D63C4CEF9;
	Mon, 20 Oct 2025 17:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760981318;
	bh=XoBtTVIfyCks+3vvS0y9uJAoDlapnqVQpQnuzzSfF34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WcSnKK4iDS6gPA+JCDA/Z1VumuFkDT4duTisGd1ZPAtcbjeztp7eAmEx6CxakyzNo
	 lDKwiRz/S6EPF9pYjk+RBRtiKxE5JdH+cfaOPqFd5MrGoCGsjmlDEoQ0KFgv9jLT/5
	 NRnESVeL2/kBb9s6u9ITQ36EKBP6gg6J0NnDHAXlQFb6hwZREmu336yBqWAoi41O+h
	 jH2Je8EZ1tOoA0VOw0acAmyWKtOUMNUH7qaM/8+QyMK5FGVhOHY5Bu35km62417HZG
	 2NaXyg6/3tkPI1joejAKNBJLCE+Lpji1QQ/U9eRX4etPmUzWQnr17rpRZSJCmzILfT
	 Z/1VrmtoO4/Mw==
Message-ID: <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
Date: Mon, 20 Oct 2025 12:28:36 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] drm/amd: Return -EBUSY for amdgpu_pmops_thaw() on
 success
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mario.limonciello@amd.com, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dakr@kernel.org, gregkh@linuxfoundation.org,
 lenb@kernel.org, pavel@kernel.org, simona@ffwll.ch,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org
References: <20251020165317.3992933-1-superm1@kernel.org>
 <20251020165317.3992933-4-superm1@kernel.org>
 <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gsdmfXUJuLW8Ogt2jKDunx4g51LqCfSVMWQ6WHXBw_zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 20, 2025 at 6:53 PM Mario Limonciello (AMD)
> <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The PM core should be notified that thaw was skipped for the device
>> so that if it's tried to be resumed (such as an aborted hibernate)
>> that it gets another chance to resume.
>>
>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 61268aa82df4d..d40af069f24dd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>>
>>          /* do not resume device if it's normal hibernation */
>>          if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>> -               return 0;
>> +               return -EBUSY;
> 
> So that's why you need the special handling of -EBUSY in the previous patch.

Yup.

> 
> I think that you need to save some state in this driver and then use
> it in subsequent callbacks instead of hacking the core to do what you
> want.
> 

The problem is the core decides "what" to call and more importantly 
"when" to call it.

IE if the core thinks that something is thawed it will never call 
resume, and that's why you end up in a bad place with Muhammad's 
cancellation series and why I proposed this one to discuss.

We could obviously go back to dropping this case entirely:

if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())

But then the display turns on at thaw(), you do an unnecessary resource 
eviction, it takes a lot longer if you have a ton of VRAM etc.


