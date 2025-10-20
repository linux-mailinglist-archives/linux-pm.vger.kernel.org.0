Return-Path: <linux-pm+bounces-36510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F13BF325E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE14FB240
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2414330B15;
	Mon, 20 Oct 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdO9f2Ec"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA2330304
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987677; cv=none; b=dTnNvUmNBNnlx1bxpsgz3hu1CMnLzxQULtwqdbEuXQaRm85RsFnfUWaPEWrVBLEKRxXfTSrceZQ7E9lXPi3cOHtic6FpmHF/ZcM4nlMjKVBZnQyBq9qLZZkseIZV56Raavk90pGBRZNJclBzRsVokIQUNyqlIdjsB+kXrVkWniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987677; c=relaxed/simple;
	bh=9M0BHZ3nExydxpktPwnXYGAvJEnTxX08SEEwNssUUbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKmHDxOUC2E0DIhx05hS2IYNe/RS1a2383t3JK450x82dt8tVbgxCQdiEvGpZhs7U0+OLGSffFu6HuMUlKUCpLEpq4e8fbygD6sdkDZx3egpiqRcpvfQpj2S0m5hRhrUHZMxmMM9OPwOJN+Ox2oYmTBqWm4IVeSf2hEsYf++ZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdO9f2Ec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3197DC113D0;
	Mon, 20 Oct 2025 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760987677;
	bh=9M0BHZ3nExydxpktPwnXYGAvJEnTxX08SEEwNssUUbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdO9f2EcMl7Zs3ORrBGnh35UoNo1oKrKUtSMhLbMwi5lqFXsxw0Nf3LVuAAkIcocb
	 lAjOJumckLZLS2j4+/aU6LP8jatm1NTbIrpFIIey4qX+Tx6+ccKoi6B9Ip5TCNoGOT
	 lize916Sxdhcqkw7HOPmT+eu21MkI0qNhZpvqNYF2Y4aXRcjkWCHlcHu5Gsvi80Fqo
	 b6xfCaH2maA/iZOA+L5uf8YjhUjZ93Jl2BOETkBz6su50cwbGfS2bp5JmC8D2zqjS3
	 vCC3GJK78Kt5fRGXU098GKwlFmjx30mJ2hTSIEZjrbkcGgioyo73TDsEq7r/ce+JUK
	 Ya60z1kGmV5oA==
Message-ID: <aa04dea5-d35b-46c9-9501-0a2e79ecbd79@kernel.org>
Date: Mon, 20 Oct 2025 14:14:34 -0500
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
 <85c039ef-e189-48c1-8bf7-50ac0c2484e2@kernel.org>
 <CAJZ5v0gT9BG5QPcwg6jJ1Jghny2YxC9_HY542LTBy-aVc_2T_w@mail.gmail.com>
 <aec8fc6c-3f9f-4ec1-a929-7a0be6026a3d@kernel.org>
 <CAJZ5v0gMf-qMGa6iBL2NdRXd-Mt5cpsoVQ90y+rSyK5xoYEf8A@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gMf-qMGa6iBL2NdRXd-Mt5cpsoVQ90y+rSyK5xoYEf8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/2025 1:50 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 20, 2025 at 8:32 PM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 10/20/2025 12:39 PM, Rafael J. Wysocki wrote:
>>> On Mon, Oct 20, 2025 at 7:28 PM Mario Limonciello (AMD) (kernel.org)
>>> <superm1@kernel.org> wrote:
>>>>
>>>>
>>>>
>>>> On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
>>>>> On Mon, Oct 20, 2025 at 6:53 PM Mario Limonciello (AMD)
>>>>> <superm1@kernel.org> wrote:
>>>>>>
>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> The PM core should be notified that thaw was skipped for the device
>>>>>> so that if it's tried to be resumed (such as an aborted hibernate)
>>>>>> that it gets another chance to resume.
>>>>>>
>>>>>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index 61268aa82df4d..d40af069f24dd 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>>>>>>
>>>>>>            /* do not resume device if it's normal hibernation */
>>>>>>            if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>>>>>> -               return 0;
>>>>>> +               return -EBUSY;
>>>>>
>>>>> So that's why you need the special handling of -EBUSY in the previous patch.
>>>>
>>>> Yup.
>>>>
>>>>>
>>>>> I think that you need to save some state in this driver and then use
>>>>> it in subsequent callbacks instead of hacking the core to do what you
>>>>> want.
>>>>>
>>>>
>>>> The problem is the core decides "what" to call and more importantly
>>>> "when" to call it.
>>>>
>>>> IE if the core thinks that something is thawed it will never call
>>>> resume, and that's why you end up in a bad place with Muhammad's
>>>> cancellation series and why I proposed this one to discuss.
>>>>
>>>> We could obviously go back to dropping this case entirely:
>>>>
>>>> if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>>>>
>>>> But then the display turns on at thaw(), you do an unnecessary resource
>>>> eviction, it takes a lot longer if you have a ton of VRAM etc.
>>>
>>> The cancellation series is at odds with this code path AFAICS because
>>> what if hibernation is canceled after the entire thaw transition?
>>
>> Muhammad - did you test that specific timing of cancelling the hibernate?
>>>
>>> Some cleanup would need to be done before thawing user space I suppose.
>>
>> I agree; I think that series would need changes for it.
>>
>> But if you put that series aside, I think this one still has some merit
>> on it's own.  If another driver aborted the hibernate, I think the same
>> thing could happen if it happened to run before amdgpu's device thaw().
>>
>> That series just exposed a very "easy" way to reproduce this issue.
> 
> Device thaw errors don't abort anything AFAICS.
> 

You're right; it doesn't abort, it just is saved to the logs.
The state is also not maintained.
> What can happen though is that another device may abort the final
> "power off" transition, which is one of the reasons why I think that
> rolling it back is generally hard.

That's exactly the reason for the first patch in this series.  The state 
of whether it succeeded isn't recorded.  So if thaw non-fatally fails 
and you've saved state to indicate this then any of the other calls that 
run can try again.

