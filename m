Return-Path: <linux-pm+bounces-36513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C8EBF33A0
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 21:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C09C334F369
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B229E2D7802;
	Mon, 20 Oct 2025 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCILA293"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC732D7393
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 19:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988877; cv=none; b=sqPjVJ/LFL5Sj7popkWHO6LMa5IWU4ydUl3RzKscIE+sma/xjaxB8DvsLJ5Jnx0k0rFOlqIRhZRZO9ORHgfSSAPFxPhJn1kkP56o7LVemVh+FaATSNcrHngJ3ILqBEw31tHAPT75xXjadAC7SOAScIbiJPUSaHlPgNyhvUYNBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988877; c=relaxed/simple;
	bh=ce41EwvX7dD7W0/LsFG6veEwyGXRxn+MPUlthCv8V5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xqo0MARgJ//rxii9TkZ2hLrn3rZeS23tgThND2/a6PwVNJFbx3NNVeSrmJDpN3mndyWoLqPQil4f/drj2j+p6phmtqQfnk7hiKiFbcdwmvm2hSWVHPnNH0MzbahFfWaNyWZnxcIhDiqu4VXTRJJI4Idg3U+U84ZEAYpDtighoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCILA293; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895B1C113D0;
	Mon, 20 Oct 2025 19:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760988877;
	bh=ce41EwvX7dD7W0/LsFG6veEwyGXRxn+MPUlthCv8V5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fCILA293TsK2s2+rIxMoqUwQ3A2jzJbRnvjyJSMIP+mQnXnFmjVl4wm0ssLuXaBlh
	 HU6SIZxUkF7XuljD7yrXdGrgTmeLQxgjkze88BeJKw+Z7UgQl7HuBc2LhW3racAps1
	 0dLeBh8nx5VCcBunW8nUBSj+ZM5EXd88h5mOBvcN4aohFkLxJnH9HKx2pyFxI4QEM2
	 b29JEpPiBZbfhGQC142e5D0+t2px6NmoHDwaD83h2IbiCLeALG+geARReBhc/mxmSi
	 eOY3HCNQ5HrSgRmdUOQrwV77Sfs+Kx7yfLEo5lPB9NOd16XFHdIBhXErzhm2mQOMqb
	 VpMNIGDse3iFg==
Message-ID: <57f073e8-f600-4bdf-b3b9-a34df882cbdb@kernel.org>
Date: Mon, 20 Oct 2025 14:34:34 -0500
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
 <aa04dea5-d35b-46c9-9501-0a2e79ecbd79@kernel.org>
 <CAJZ5v0j=sw9X3mV2ddOD_-qJwxveXQ1faD6HWtStLo9xOpwYKA@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAJZ5v0j=sw9X3mV2ddOD_-qJwxveXQ1faD6HWtStLo9xOpwYKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/2025 2:18 PM, Rafael J. Wysocki wrote:
> On Mon, Oct 20, 2025 at 9:14 PM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 10/20/2025 1:50 PM, Rafael J. Wysocki wrote:
>>> On Mon, Oct 20, 2025 at 8:32 PM Mario Limonciello (AMD) (kernel.org)
>>> <superm1@kernel.org> wrote:
>>>>
>>>>
>>>>
>>>> On 10/20/2025 12:39 PM, Rafael J. Wysocki wrote:
>>>>> On Mon, Oct 20, 2025 at 7:28 PM Mario Limonciello (AMD) (kernel.org)
>>>>> <superm1@kernel.org> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 10/20/2025 12:21 PM, Rafael J. Wysocki wrote:
>>>>>>> On Mon, Oct 20, 2025 at 6:53 PM Mario Limonciello (AMD)
>>>>>>> <superm1@kernel.org> wrote:
>>>>>>>>
>>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>
>>>>>>>> The PM core should be notified that thaw was skipped for the device
>>>>>>>> so that if it's tried to be resumed (such as an aborted hibernate)
>>>>>>>> that it gets another chance to resume.
>>>>>>>>
>>>>>>>> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>>>>>>>>      1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> index 61268aa82df4d..d40af069f24dd 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>>>> @@ -2681,7 +2681,7 @@ static int amdgpu_pmops_thaw(struct device *dev)
>>>>>>>>
>>>>>>>>             /* do not resume device if it's normal hibernation */
>>>>>>>>             if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>>>>>>>> -               return 0;
>>>>>>>> +               return -EBUSY;
>>>>>>>
>>>>>>> So that's why you need the special handling of -EBUSY in the previous patch.
>>>>>>
>>>>>> Yup.
>>>>>>
>>>>>>>
>>>>>>> I think that you need to save some state in this driver and then use
>>>>>>> it in subsequent callbacks instead of hacking the core to do what you
>>>>>>> want.
>>>>>>>
>>>>>>
>>>>>> The problem is the core decides "what" to call and more importantly
>>>>>> "when" to call it.
>>>>>>
>>>>>> IE if the core thinks that something is thawed it will never call
>>>>>> resume, and that's why you end up in a bad place with Muhammad's
>>>>>> cancellation series and why I proposed this one to discuss.
>>>>>>
>>>>>> We could obviously go back to dropping this case entirely:
>>>>>>
>>>>>> if (!pm_hibernate_is_recovering() && !pm_hibernation_mode_is_suspend())
>>>>>>
>>>>>> But then the display turns on at thaw(), you do an unnecessary resource
>>>>>> eviction, it takes a lot longer if you have a ton of VRAM etc.
>>>>>
>>>>> The cancellation series is at odds with this code path AFAICS because
>>>>> what if hibernation is canceled after the entire thaw transition?
>>>>
>>>> Muhammad - did you test that specific timing of cancelling the hibernate?
>>>>>
>>>>> Some cleanup would need to be done before thawing user space I suppose.
>>>>
>>>> I agree; I think that series would need changes for it.
>>>>
>>>> But if you put that series aside, I think this one still has some merit
>>>> on it's own.  If another driver aborted the hibernate, I think the same
>>>> thing could happen if it happened to run before amdgpu's device thaw().
>>>>
>>>> That series just exposed a very "easy" way to reproduce this issue.
>>>
>>> Device thaw errors don't abort anything AFAICS.
>>>
>>
>> You're right; it doesn't abort, it just is saved to the logs.
>> The state is also not maintained.
>>> What can happen though is that another device may abort the final
>>> "power off" transition, which is one of the reasons why I think that
>>> rolling it back is generally hard.
>>
>> That's exactly the reason for the first patch in this series.  The state
>> of whether it succeeded isn't recorded.  So if thaw non-fatally fails
>> and you've saved state to indicate this then any of the other calls that
>> run can try again.
> 
> So long as they are called.
> 
> But as I said before, I would save the state in the driver thaw
> callback and then clear it in the driver poweroff callback and look at
> it in the driver restore callback.  If it is there at that point,
> poweroff has not run and hibernation is rolling back, so you need to
> do a "thaw".

Are you suggesting that the device driver should directly manipulate 
dev->power.is_suspended?

I'll do some testing but; I suppose that would work as well without 
needing to make core changes if you don't see a need for other devices 
to do this.

