Return-Path: <linux-pm+bounces-25649-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F754A9228A
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F7719E59B5
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA088254AE9;
	Thu, 17 Apr 2025 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PKPq8ewP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAC254867
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744906796; cv=none; b=YGxf594F515dpNV29fmfz60wVBFeG+q5fmCq0my1l2vw8mtsX4Gnb/ys2ejN08xXZtysvvP8nsq53TdJ7H2LfIpolY+hpynMZ2d43nIf3yl5nNb2WFCfn0KU8k8OkuYrR1uNtDCGZZ8gy1tbBT6BVxVnndHKpHR1D2UcZ+0xlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744906796; c=relaxed/simple;
	bh=MrQxyJvjQpqjhpJsuUx0wX2MeMafxOP5d+nwMKiVPZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=J7P90U96w3zOx7E9YupljsknIT7qrJTkOLSD0ceL9sL1ImAjOFtmwO/d+uozMAxcMsMO4RRidSFaAJLYpkuLibV859reDvCTGdhuqYnTI6Idl61PK96HvVVWestH2BuMdIghOj4dXlpH5MjZKS2t2FFcHFvJc1bNqhOZzorqJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PKPq8ewP; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250417161946euoutp02192717de984e977239f109f470650142~3J3o8b2qI1394513945euoutp02I
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 16:19:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250417161946euoutp02192717de984e977239f109f470650142~3J3o8b2qI1394513945euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744906786;
	bh=oPNYposj2RIUYXcr0CzhTfZgNwKAiGoZO09uENovZ0o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=PKPq8ewPVt6pMxMYe+Bds6pvXOzzPJlLkGwmJnMMw5Y9eXNmr5zvFHXh2lARILJRa
	 3KvGMaGYYiu+MW3VVNJGHzlPpjjtOCDXGgkVfHQ2K1Lj0/NXQDEqzwu3ZOFl4+H1Wr
	 bUbQHECd+9lFbwMKkmzBy5snoPoSrHCIZoicJjiQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250417161946eucas1p26446fa499deeff99304f2db478e3bacf~3J3obvPjf0483304833eucas1p2g;
	Thu, 17 Apr 2025 16:19:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E1.4A.20821.12A21086; Thu, 17
	Apr 2025 17:19:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250417161945eucas1p23e93fd38c156de5e64315f434d8ad485~3J3oDSt9M0482704827eucas1p2w;
	Thu, 17 Apr 2025 16:19:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250417161945eusmtrp21d660e403c8939a3d03517eb34aaa655~3J3oCXHIc0454504545eusmtrp2j;
	Thu, 17 Apr 2025 16:19:45 +0000 (GMT)
X-AuditID: cbfec7f2-b09c370000005155-dd-68012a21d519
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.AA.19920.12A21086; Thu, 17
	Apr 2025 17:19:45 +0100 (BST)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250417161944eusmtip25ece8054e728a3de2b8497d00ba9c001~3J3m6Z0nX2334423344eusmtip28;
	Thu, 17 Apr 2025 16:19:44 +0000 (GMT)
Message-ID: <cbf20469-02ab-403a-8db7-2b66e9936b4f@samsung.com>
Date: Thu, 17 Apr 2025 18:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PM: device: Introduce platform_resources_managed
 flag
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Frank
	Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <CAJZ5v0gE0anjW_mDSwNXY8xoZ_0=bDDxiSbUq1GP7-NycDojrQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2cPs8HjRPc9FYWd7IqKX0V+70KPrrp7vK6MqDTOq1Y8
	DhLG2kAx8xzH4ICwhCTHABmDUDHUG9say8Ed7dg8aEc1jCOHsyQYpIggYAnEeLT47/X58f6+
	P5/PfSlcpCM3UlmKPFalkGVLSAFh7bnveSYqBmTGf1eBkPtXI4a+dXgwNPH1HRI1OD08NPyz
	GUPee5MkujDSz0djjkICBfTDJPrFXkei6eNOgKzTWhK1OX181DhlIVCzzQ5QSVkLD/mG3QQq
	ndTgqH6mGkdLl218VHu7i4/Mf1XykKttD9J2nSRSIOOYNRBMh97HZyo6+gBjai0jmWtXL5PM
	6SupzPXPXRjT3nyM0bb1YMyXC/HMZOcAyXxhbgVMe+8RZtq05Y3QdEFyBpuddZBVxe38QJBp
	0Z3Dlea4gqrf/LgG3JOWgxAK0s9Bx+/1eJBF9FkAfyrbXw4EyzwD4Ez1RZILpgH85p8e8EjR
	d6MK5wpnALTMj/C54BaATdqTywFFCemd8I+5hKCAoKNh51KAF2QhvRZeqblJBHk9vRVeH9Lx
	g7yOToOX5mbJIIfTT8Fm48CKAU5fImFVYcuKGKfFcOhmAxZkkk6E/jMNvKBXCJ0KfY5UrmUr
	LLLUrmgh3SiA3tFTfG7ql2FJ2zzB8To47jI/zG+GSx3cm5DOhX7LXZzjz2BHheshvwCvef4m
	g144/SS8aI/j0i/CQOHoygiQDoWDt9ZyI4TCKuspnEsLYWmJiOuWwuqK4/+Zes5asRNAol91
	FP2qHfWrltH/72sARCsQs/nqHDmrTlCwh2LVshx1vkIe+1Fujgksf97eRdddG6gfn4rtBhgF
	ugGkcEm40LN9US4SZsgOf8qqct9X5Wez6m6wiSIkYqGxq1guouWyPPYAyypZ1aMqRoVs1GBN
	ueFvjeGmosiB7Vvson1v+sV3ope0ptrIZ93bzvvio/mVxpxK9s8T7wliKFeJ4bUerPfwbN1X
	O5rUD06nNIUOJmaZPg6j5mt2ja2RvvtAPFdXn5KWWKBMk+2Ku73/vGH9ocIU1zBuSWK/fyVS
	VPtJvG7B0HfDtqMm76WCve0b1K4fzaODYa3jYuOxg/bi3X7l1IXyzBHdpok1ewMZ6Y8lmYbs
	nYTH++G+zWpnpfvxxYgIp9D7vIId++HVSo+0jiyVHonKmR+xJEcthDX0NWgO+Bs1EclK726b
	M9Df35h+9fU9T/gqnt52tOXokMJtPXe/2DRT2lz1TpK0aANvnJp4W0KoM2UJMbhKLfsXxkjJ
	/ysEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsVy+t/xe7qKWowZBm37pS1OXF/EZLFm7zkm
	i9fTPrBZzD9yjtXi3qUtTBZXvr5ns1j39AK7xYu9jSwWL2fdY7O4vGsOm8Xn3iOMFts+t7BZ
	rD1yl91i4cetLBZLduxitGjrXMZqcffeCRaLjvcNzBZzv0xltvi/Zwe7xex3+9kttryZyGpx
	fG24Rcv+KSwOEh57vy1g8dg56y67R8/OM4wem1Z1snncubaHzWPeyUCP+93HmTw2L6n3aFl7
	jMmj/6+Bx/t9V9k8+rasYvTYfLra4/MmuQC+KD2bovzSklSFjPziElulaEMLIz1DSws9IxNL
	PUNj81grI1MlfTublNSczLLUIn27BL2MrTNWMhds0a+YdPsBcwPjV7UuRk4OCQETiTMPJzGD
	2EICSxklNlzNgYjLSFzrfskCYQtL/LnWxdbFyAVU85pRonHTGqAGDg5eATuJx98NQWpYBFQl
	9v1/yQpi8woISpyc+QSsV1RAXuL+rRnsILawQLDEhu/f2EBsEQFtiSWLrjKDzGQW2MQmsWrl
	fHaII+YwSzy4Ww9iMwuIS9x6Mp8JxGYTMJJ4sHw+K8heToFAibt7A0FMZgF1ifXzhCCq5SWa
	t85mnsAoNAvJFbOQDJqF0DELSccCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgWlm27Gf
	m3cwznv1Ue8QIxMH4yFGCQ5mJRHec+b/0oV4UxIrq1KL8uOLSnNSiw8xmgJDYiKzlGhyPjDR
	5ZXEG5oZmBqamFkamFqaGSuJ87pdPp8mJJCeWJKanZpakFoE08fEwSnVwJR3aoJgsw3DpW4x
	g5M3S59u8o1tUp6eqSX07nV91NGEFxMFFu3dutRpzracN1fSOTVufXvy7fy7nDyWc6IODR1m
	q++1mDidKFC5/ubYnYxDpmYZG5wPP18d4dJ2Nmv6zjyH58ufTQo/Jy8/+coHxWPvVdunvg9+
	fO7wvsfGPCwOau/C3tVWPIsK+36uasXxW8218S0rplknbnq9b4/59meROxUt3rWEf9AvbzDc
	3K0eOuvXVbcNrvpPnx9RTTpzbfbpuJYZbtaM99mTK9wmXwxl5TI9dLLyeeNEoavKfxv32QmU
	R88orY/LF3nMf2pOxVl7To9AFrvsAzlJs107D1l+Xsagev/C0l3sk+XPz3ugxFKckWioxVxU
	nAgAT3t7ErwDAAA=
X-CMS-MailID: 20250417161945eucas1p23e93fd38c156de5e64315f434d8ad485
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028
References: <CGME20250414185314eucas1p1ae57b937773a2ed4ce8d52d5598eb028@eucas1p1.samsung.com>
	<20250414-apr_14_for_sending-v2-0-70c5af2af96c@samsung.com>
	<20250414-apr_14_for_sending-v2-1-70c5af2af96c@samsung.com>
	<CAJZ5v0irRq8_p35vf41_ZgomW0X=KZN+0HqwU2K9PvPRm8iZQA@mail.gmail.com>
	<b9c4182d-38c2-4173-a35a-0e1773c8f2ed@samsung.com>
	<CAJZ5v0gE0anjW_mDSwNXY8xoZ_0=bDDxiSbUq1GP7-NycDojrQ@mail.gmail.com>



On 4/16/25 16:48, Rafael J. Wysocki wrote:
> On Wed, Apr 16, 2025 at 3:32 PM Michal Wilczynski
> <m.wilczynski@samsung.com> wrote:
>>
>> On 4/15/25 18:42, Rafael J. Wysocki wrote:
>>> On Mon, Apr 14, 2025 at 8:53 PM Michal Wilczynski
>>> <m.wilczynski@samsung.com> wrote:
>>>>
>>>> Introduce a new dev_pm_info flag - platform_resources_managed, to
>>>> indicate whether platform PM resources such as clocks or resets are
>>>> managed externally (e.g. by a generic power domain driver) instead of
>>>> directly by the consumer device driver.
>>>
>>> I think that this is genpd-specific and so I don't think it belongs in
>>> struct dev_pm_info.
>>>
>>> There is dev->power.subsys_data->domain_data, why not use it for this?
>>
>> Hi Rafael,
>>
>> Thanks for the feedback.
>>
>> You're right — this behavior is specific to genpd, so embedding the flag
>> directly in struct dev_pm_info may not be the best choice. Using
>> dev->power.subsys_data->domain_data makes more sense and avoids bloating
>> the core PM structure.
>>
>>>
>>> Also, it should be documented way more comprehensively IMV.
>>>
>>> Who is supposed to set it and when?  What does it mean when it is set?
>>
>> To clarify the intended usage, I would propose adding the following
>> explanation to the commit message:
>>
>> "This flag is intended to be set by a generic PM domain driver (e.g.,
>> from within its attach_dev callback) to indicate that it will manage
>> platform specific runtime power management resources — such as clocks
>> and resets — on behalf of the consumer device. This implies a delegation
>> of runtime PM control to the PM domain, typically implemented through
>> its start and stop callbacks.
>>
>> When this flag is set, the consumer driver (e.g., drm/imagination) can
>> check it and skip managing such resources in its runtime PM callbacks
>> (runtime_suspend, runtime_resume), avoiding conflicts or redundant
>> operations."
> 
> This sounds good and I would also put it into a code comment somewhere.
> 
> I guess you'll need helpers for setting and testing this flag, so
> their kerneldoc comments can be used for that.
> 
>> This could also be included as a code comment near the flag definition
>> if you think that’s appropriate.
>>
>> Also, as discussed earlier with Maxime and Matt [1], this is not about
>> full "resource ownership," but more about delegating runtime control of
>> PM resources like clocks/resets to the genpd. That nuance may be worth
>> reflecting in the flag name as well, I would rename it to let's say
>> 'runtime_pm_platform_res_delegated', or more concise
>> 'runtime_pm_delegated'.
> 
> Or just "rpm_delegated" I suppose.
> 
> But if the genpd driver is going to set that flag, it will rather mean
> that this driver will now control the resources in question, so the
> driver should not attempt to manipulate them directly.  Is my
> understanding correct?

Yes, your understanding is correct — with one minor clarification.

When the genpd driver sets the flag, it indicates that it will take over
control of the relevant PM resources in the context of runtime PM, i.e.,
via its start() and stop() callbacks. As a result, the device driver
should not manipulate those resources from within its RUNTIME_PM_OPS
(e.g., runtime_suspend, runtime_resume) to avoid conflicts.

However, outside of the runtime PM callbacks, the consumer device driver
may still access or use those resources if needed e.g for devfreq.

> 
> Assuming that it is correct, how is the device driver going to know
> which resources in particular are now controlled by the genpd driver?

Good question — to allow finer-grained control, we could replace the
current single boolean flag with a u32 bitmask field. Each bit would
correspond to a specific category of platform managed resources. For
example:

#define RPM_TAKEOVER_CLK	BIT(0)
#define RPM_TAKEOVER_RESET	BIT(1)

This would allow a PM domain driver to selectively declare which
resources it is taking over and let the consumer driver query only the
relevant parts.

> 
> Also "rpm_takeover" may be a better name for the flag in that case.

Sounds good, bitmask could also be named like that

> 
>> [1] - https://lore.kernel.org/all/a3142259-1c72-45b9-b148-5e5e6bef87f9@samsung.com/
>>
>>>
>>>> This flag enables device drivers to cooperate with SoC-specific PM
>>>> domains by conditionally skipping management of clocks and resets when
>>>> the platform owns them.
>>>>
>>>> This idea was discussed on the mailing list [1].
>>>>
>>>> [1] - https://lore.kernel.org/all/CAPDyKFq=BF5f2i_Sr1cmVqtVAMgr=0FqsksL7RHZLKn++y0uwg@mail.gmail.com/
>>>>
>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>>> ---
>>>>  include/linux/device.h | 11 +++++++++++
>>>>  include/linux/pm.h     |  1 +
>>>>  2 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>>> index 79e49fe494b7c4c70d902886db63c4cfe5b4de4f..3e7a36dd874cfb6b98e2451c7a876989aa9f1913 100644
>>>> --- a/include/linux/device.h
>>>> +++ b/include/linux/device.h
>>>> @@ -881,6 +881,17 @@ static inline bool device_async_suspend_enabled(struct device *dev)
>>>>         return !!dev->power.async_suspend;
>>>>  }
>>>>
>>>> +static inline bool device_platform_resources_pm_managed(struct device *dev)
>>>
>>> Could this function name be shorter?
>>
>> Maybe:
>>
>> static inline bool dev_is_runtime_pm_delegated(struct device *dev);
>> static inline void dev_set_runtime_pm_delegated(struct device *dev, bool val);
> 
> What about
> 
> dev_pm_genpd_rpm_delegated()
> dev_pm_genpd_set_rpm_delegated()
> 
> respectively (or analogously with the "takeover" variant)?

Right sounds good, so if you also like a bitmask idea they could look
like this:

static inline bool dev_pm_genpd_rpm_takeover(struct device *dev, u32 flags);
static inline void dev_pm_genpd_set_rpm_takeover(struct device *dev, u32 flags);

Regards,
Michał

> 

