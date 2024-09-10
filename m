Return-Path: <linux-pm+bounces-13925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85279972CAB
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F4E1C21312
	for <lists+linux-pm@lfdr.de>; Tue, 10 Sep 2024 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B618785A;
	Tue, 10 Sep 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8LM8sO0"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B785816F27E
	for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958719; cv=none; b=Qaw1TGXNI4kDdj/BnxyBo8+weANandER9keLRf38BxNl9M6IBoS4SVLxOA5iwW8PS2ZAdmWRmteZPtADF4OLkXkvA/NzD4fcbaU6UK2gfBjveMW1v44sUGK6jW/WWKAJ7M3htskIdZxCZsrZyRbxX29iL8ZefyC/q0x3h7BjbYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958719; c=relaxed/simple;
	bh=wj10f5L5Wns2vhKnqNbO9AbzsGu/jBhFA2sX1CYqkPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fh861F3LQSErbY2xm858aQOznP75TwIzjBc5ANb53yaYv6mrZNwCPKR4jn9JU5d2mPwzEbGxe74eB0U2nfyQgtM/ZxkOTWpLezZWTnw/sbA7YG6wfV6byP3oZVN0iwuXzi4poTuHMRLjiZd1qTAXVPxPbqw3nUQO2iv3wcp8v0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8LM8sO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725958716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly3LxhkuPW+RkMjeSwFB2spg7yLSAYV4L7yhhC7D1n0=;
	b=U8LM8sO0DYjGsVwCi9r7XrWwTj3aoGsti7+0evdAJVuVUkWF+iGckFSNiPn0w6DLtd20rU
	fIa79HtMbT7wchyoSwqIo8sZ/daRcx2fqEwlt2f1Sx8BkNjxfIsRUTUtlwXSqZjkVwdXmO
	U7Xx9j6PIRa9WAe8fbnayC6YzlNtxaw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-qTC_hKdnP9Ou5_EGFVd9Hg-1; Tue, 10 Sep 2024 04:58:35 -0400
X-MC-Unique: qTC_hKdnP9Ou5_EGFVd9Hg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8d3085ab6fso145827966b.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Sep 2024 01:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958714; x=1726563514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly3LxhkuPW+RkMjeSwFB2spg7yLSAYV4L7yhhC7D1n0=;
        b=nUZbNZDdQ+XcjI/nzDkiyKoFveP84At3MkKa/ypTeoV6EP3guWixJP1b6Wk0eg6vvC
         exwjBKIkhxbc/7uOL+LI63XGjkLAlwlQ7r3bMks80zSXgiLZxLOiLrRwhEqzzXg0LTl9
         Fveh5U9p+ChJjaeWu93ErE09Zu9824bj0exTGjtIUpHiDNEkAQRuSQMvBjn1cqMapwtN
         R5AoVuGcEQJb6RiP/HuUp+crs3mXkpWcjdHHp5T1xYXj1qc8gMAaPpdOj1rtqy6AYnmJ
         l7L3lGJwFTmh1qDyYoTGREA7Do3dBM7ar2ctNF2XCskDgF7ZWwsMW/gJ/9vs4mPbhTnm
         yseQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1TKBUzW3x2ubFUUEA1JYymBFCtuQW8b0p6B9dp8vIgiWsQfLQza6pdNB07L1KfbbMwlhH9UO4BA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSYmshfLDDimEKz3IZdmD8X0tGxeWbIDEe8TXfz9g1t5yAyr+
	nDixf5WUhqPDocsXEK803l/X27pLlphQU8r3qFkWBT3UR7KTjgObMsqzhJHja1YQ9ELmaiZgloO
	RQ9lUYWlrEZOjIq12JCIaoP+0cm1G3lYeeaRbplD5oOMI6DiRsmRjG5Xh
X-Received: by 2002:a17:907:3682:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a8ffa837442mr11324466b.0.1725958713979;
        Tue, 10 Sep 2024 01:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOATzVlVe9TSjQp3hFYFYav34Qj0CrLgfC0JraVHH3EpXlFAH0T1vBiZAHXvImfhs2CW7iZQ==
X-Received: by 2002:a17:907:3682:b0:a77:c30c:341 with SMTP id a640c23a62f3a-a8ffa837442mr11321666b.0.1725958713398;
        Tue, 10 Sep 2024 01:58:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce96d9sm446948066b.157.2024.09.10.01.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 01:58:32 -0700 (PDT)
Message-ID: <303e4691-dc06-400f-8b74-6f9386ffe216@redhat.com>
Date: Tue, 10 Sep 2024 10:58:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86:intel/pmc: Ignore all LTRs during suspend
To: Xi Pardee <xi.pardee@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: irenic.rajneesh@gmail.com, david.e.box@linux.intel.com,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org
References: <20240906184016.268153-1-xi.pardee@linux.intel.com>
 <15d08ff3-6787-7042-8afc-3a64f1ebc756@linux.intel.com>
 <2d8249a2-22a0-4785-9eea-a2d59c1d9b1a@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2d8249a2-22a0-4785-9eea-a2d59c1d9b1a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Xi,

On 9/10/24 2:43 AM, Xi Pardee wrote:
> Hi,
> 
> On 9/9/2024 1:07 AM, Ilpo Järvinen wrote:
>> On Fri, 6 Sep 2024, Xi Pardee wrote:
>>
>>> From: Xi Pardee <xi.pardee@intel.com>
>>>
>>> Add support to ignore all LTRs before suspend and restore the previous
>>> LTR values after suspend. This feature could be turned off with module
>>> parameter ltr_ignore_all_suspend.
>>>
>>> LTR value is a mechanism for a device to indicate tolerance to access
>>> the corresponding resource. When system suspends, the resource is not
>>> available and therefore the LTR value could be ignored. Ignoring all
>>> LTR values prevents problematic device from blocking the system to get
>>> to the deepest package state during suspend.
>>>
>>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> Signed-off-by: Xi Pardee <xi.pardee@intel.com>
>>>
>>> v2:
>>> - Add more details to commit message
>>> - Fix format: ltr->LTR, S0IX->S0ix, space between name and email
>>>
>>> ---
>>>   drivers/platform/x86/intel/pmc/core.c | 53 +++++++++++++++++++++++++++
>>>   drivers/platform/x86/intel/pmc/core.h |  2 +
>>>   2 files changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>>> index 01ae71c6df59..0ec703af16a4 100644
>>> --- a/drivers/platform/x86/intel/pmc/core.c
>>> +++ b/drivers/platform/x86/intel/pmc/core.c
>>> @@ -714,6 +714,49 @@ static int pmc_core_s0ix_blocker_show(struct seq_file *s, void *unused)
>>>   }
>>>   DEFINE_SHOW_ATTRIBUTE(pmc_core_s0ix_blocker);
>>>   +static void pmc_core_ltr_ignore_all(struct pmc_dev *pmcdev)
>>> +{
>>> +    unsigned int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
>>> +        struct pmc *pmc;
>>> +        u32 ltr_ign;
>>> +
>>> +        pmc = pmcdev->pmcs[i];
>>> +        if (!pmc)
>>> +            continue;
>>> +
>>> +        guard(mutex)(&pmcdev->lock);
>>> +        pmc->ltr_ign = pmc_core_reg_read(pmc, pmc->map->ltr_ignore_offset);
>>> +
>>> +        /* ltr_ignore_max is the max index value for LTR ignore register */
>>> +        ltr_ign = pmc->ltr_ign | GENMASK(pmc->map->ltr_ignore_max, 0);
>>> +        pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, ltr_ign);
>>> +    }
>>> +
>>> +    /*
>>> +     * Ignoring ME during suspend is blocking platforms with ADL PCH to get to
>>> +     * deeper S0ix substate.
>>> +     */
>>> +    pmc_core_send_ltr_ignore(pmcdev, 6, 0);
>>> +}
>>> +
>>> +static void pmc_core_ltr_restore_all(struct pmc_dev *pmcdev)
>>> +{
>>> +    unsigned int i;
>>> +
>>> +    for (i = 0; i < ARRAY_SIZE(pmcdev->pmcs); i++) {
>>> +        struct pmc *pmc;
>>> +
>>> +        pmc = pmcdev->pmcs[i];
>>> +        if (!pmc)
>>> +            continue;
>>> +
>>> +        guard(mutex)(&pmcdev->lock);
>>> +        pmc_core_reg_write(pmc, pmc->map->ltr_ignore_offset, pmc->ltr_ign);
>>> +    }
>>> +}
>>> +
>>>   static inline u64 adjust_lpm_residency(struct pmc *pmc, u32 offset,
>>>                          const int lpm_adj_x2)
>>>   {
>>> @@ -1479,6 +1522,10 @@ static bool warn_on_s0ix_failures;
>>>   module_param(warn_on_s0ix_failures, bool, 0644);
>>>   MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
>>>   +static bool ltr_ignore_all_suspend = true;
>>> +module_param(ltr_ignore_all_suspend, bool, 0644);
>>> +MODULE_PARM_DESC(ltr_ignore_all_suspend, "Ignore all LTRs during suspend");
>>> +
>>>   static __maybe_unused int pmc_core_suspend(struct device *dev)
>>>   {
>>>       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>> @@ -1488,6 +1535,9 @@ static __maybe_unused int pmc_core_suspend(struct device *dev)
>>>       if (pmcdev->suspend)
>>>           pmcdev->suspend(pmcdev);
>>>   +    if (ltr_ignore_all_suspend)
>>> +        pmc_core_ltr_ignore_all(pmcdev);
>>> +
>>>       /* Check if the syspend will actually use S0ix */
>>>       if (pm_suspend_via_firmware())
>>>           return 0;
>>> @@ -1594,6 +1644,9 @@ static __maybe_unused int pmc_core_resume(struct device *dev)
>>>   {
>>>       struct pmc_dev *pmcdev = dev_get_drvdata(dev);
>>>   +    if (ltr_ignore_all_suspend)
>>> +        pmc_core_ltr_restore_all(pmcdev);
>>> +
>>>       if (pmcdev->resume)
>>>           return pmcdev->resume(pmcdev);
>>>   diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
>>> index ea04de7eb9e8..e862ea88b816 100644
>>> --- a/drivers/platform/x86/intel/pmc/core.h
>>> +++ b/drivers/platform/x86/intel/pmc/core.h
>>> @@ -372,6 +372,7 @@ struct pmc_info {
>>>    * @map:        pointer to pmc_reg_map struct that contains platform
>>>    *            specific attributes
>>>    * @lpm_req_regs:    List of substate requirements
>>> + * @ltr_ign:        Holds LTR ignore data while suspended
>>>    *
>>>    * pmc contains info about one power management controller device.
>>>    */
>>> @@ -380,6 +381,7 @@ struct pmc {
>>>       void __iomem *regbase;
>>>       const struct pmc_reg_map *map;
>>>       u32 *lpm_req_regs;
>>> +    u32 ltr_ign;
>>>   };
>>>     /**
>>>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Thanks for the Reviewed-by tag! I wonder if I need to send another version with the Reviewed-by tag for this patch to be accepted.

There is no need for a v3. I'll merge this patch into
my review-hans branch (and from there on it will move
to for-next) soon.

Regards,

Hans



