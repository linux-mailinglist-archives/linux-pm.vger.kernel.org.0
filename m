Return-Path: <linux-pm+bounces-3734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C247F850491
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 15:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8259C2836BC
	for <lists+linux-pm@lfdr.de>; Sat, 10 Feb 2024 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E4D53E12;
	Sat, 10 Feb 2024 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4C9fR3s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834736B02
	for <linux-pm@vger.kernel.org>; Sat, 10 Feb 2024 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707573862; cv=none; b=WnbysY0NFXOCYGViD2Znx3s4cUFgZsqAc4/JZc/wxP6+sBc6sDvWn9EePzkttD48wsQOMAzxFBkRavfFqmXgnjAs/P7ioq7lzkv3rqiEuH+mddPNdXGevhrloI7gHEk6eRDrTr0CYwSQ9xsBzjTAEFEeAVaBcY0Fbk+yIt8/Lh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707573862; c=relaxed/simple;
	bh=z1QZT/TK8w9uxvErZSIWX6SDs9tcYou7gZWkU8oN/qU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/Zsbzm8UwPnEZ7qGUqJOahjayGqtmnwVwbPGlkEl69svALnZR+MohQwbP8G5GL9bLE3XZ6dGkgswAB3IivNJwRA0fAYLBx9ekBK1tnC3Tpgvb/sTxmWNjS7/ugrBMevXupJD+NLkTgA79eTRmoQnjfOum5OTPr1cS53f5blj3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4C9fR3s; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783eb452e01so169013585a.1
        for <linux-pm@vger.kernel.org>; Sat, 10 Feb 2024 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707573858; x=1708178658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpkMXdsNrnfR6SYo5t/q3UCzDdYDpyweIAnboPb8Fis=;
        b=v4C9fR3sSUyNihU8hbP+/xnxvAcMYSFLzL+jnMnvIrkb6RYPv8vNXj1uFxixvqzhrg
         V10zETRrSZuYCWZSI5xh00KZE6c7InsmTHq9WuPIdfnlX5tJpP0MUGpaUBlPl2cJqQas
         a8+TpVv+Y4emliP2XFRf4sEH52ru1BhYq1qwBlxDO52074dTjEop9XaVMZCgwe4oDotM
         ViIWgt07Gdc4rjeCQUb1Vbvk+7FLVFseqIJHuHpRrFpEIj9kW2GQZxmdfIQhNxomAtjY
         g0YtDVhKQirHa2RYczaPjY6lm02SQe7SV50h02IYv/D6XBQeck8Wel0UMfzOWLECAcfO
         m9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707573858; x=1708178658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpkMXdsNrnfR6SYo5t/q3UCzDdYDpyweIAnboPb8Fis=;
        b=NJKRvz7j8Q7FcHZJRKJnNAdfULwS7dC5/+sVyDy2xX2/rcGpe86zn5jWbwJ0bSXfNr
         dsqqcCSmu0tp8XkU20sKrflb/LYVx4WPCBOEpnIP+62+vXItCOLSRSHzDTN/ANTmSBVH
         Cpt9snIACq2Q9YyHznz1zSB5kF/oZW6kk6A2HUGanPQ13BkNV4hp2x1I9LZ4nO1pU1qI
         sXl+3tZrtFcwtFxbd/4fyzxA/F1nvw63R/FJzWHSqi/WH0XWDoVfMag9zNSyMTonuI6w
         ae/6q1GnPBBPXf4eXx2tYyhroGiBIOWBPIgTTx+Gjvaz3aN7cBreTtaGX+2a0R9eEegc
         xOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU+Mib4Elzg8ZFNn+pf3CnfQHLhrvo/i88m98vuI62Fbx6tCGBGUDluevWT6HSaUkHVHEntAOkqrf8LOtSz4Z2jqL6T4gs6IU=
X-Gm-Message-State: AOJu0YwMhy6KQAKrNxk3gktbh7sdZUKo+3fS25w+UmzJVFb3ea0Jy4pI
	x0mNfJFDinISmur8RXwGDq5Mu0ZjH7VtvURUOhp3Pnw6quDoj9cczlPflu47aEc=
X-Google-Smtp-Source: AGHT+IFILjB+Ri+0N26fz0PGKcL/J0/1ZTjxqMYDXchvj6Ey6r2dRgNzpCC8WYpQeD1W+EqP8ocGBQ==
X-Received: by 2002:a05:620a:2907:b0:785:cb5f:127e with SMTP id m7-20020a05620a290700b00785cb5f127emr1176266qkp.18.1707573858498;
        Sat, 10 Feb 2024 06:04:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGgM0RJwCk9tkxWEv2i8N8ZRtDx81HAxfi1zs8rnhLsibQe3WA2ikyymvLqSiFStwvwLcd2lMDUJPKjv0AZ+WRW8Khw84gDGzMtiVQWafIRVJ/xAh5+rKK4bbS8KiFjciT0jlLwRisVFwPLogSu2K2dmRLGMlDmJhN9Fng0WjVSugEXK5dAewXKY9mICVYpC+MRVpn8blCr/Zl4WyUBB9NuLVB8BIbVE6Uk+AJU2ylW4tUnJioLE9GcIYNsGu+E0Uo+m485S5tQrUwh45pUyyu1y4BARYoOfK0BGjK9Nxfjb8sIwAQ9eILoNc6I5ozoAH9Ze2UHDBzyfZZnrzyPOX5iPB+EqMXOdPfjcHBbeJKGm0yEvMVorqdlIo/Wx5HTtGq3zwnqrYO/iDePw/EVY0QYgmlcxTHpYfyaeG+/l7rVOFiyEtkkL+UTbnkcbEdAQ==
Received: from [192.168.1.116] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id l24-20020a05620a211800b007857e7b35d0sm600333qkl.114.2024.02.10.06.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 06:04:17 -0800 (PST)
Message-ID: <dde25579-2f6e-4357-bce2-108061460431@linaro.org>
Date: Sat, 10 Feb 2024 15:04:08 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com,
 kernel-team@meta.com, Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
 <10423008.nUPlyArG6x@kreacher>
 <708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
 <CAJZ5v0g7VNdRtYsjAf-X24KtmnLzSXqgroReXAOeOQ+Myi2_Rw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAJZ5v0g7VNdRtYsjAf-X24KtmnLzSXqgroReXAOeOQ+Myi2_Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/7/24 11:59, Rafael J. Wysocki wrote:
> On Wed, Feb 7, 2024 at 11:31 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>>
>> Dear All,
>>
>> On 09.01.2024 17:59, Rafael J. Wysocki wrote:
>>>    From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Before commit 7839d0078e0d ("PM: sleep: Fix possible deadlocks in core
>>> system-wide PM code"), the resume of devices that were allowed to resume
>>> asynchronously was scheduled before starting the resume of the other
>>> devices, so the former did not have to wait for the latter unless
>>> functional dependencies were present.
>>>
>>> Commit 7839d0078e0d removed that optimization in order to address a
>>> correctness issue, but it can be restored with the help of a new device
>>> power management flag, so do that now.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> This patch finally landed in linux-next some time ago as 3e999770ac1c
>> ("PM: sleep: Restore asynchronous device resume optimization"). Recently
>> I found that it causes a non-trivial interaction with commit
>> 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement
>> for unbound workqueues"). Since merge commit 954350a5f8db in linux-next
>> system suspend/resume fails (board doesn't wake up) on my old Samsung
>> Exynos4412-based Odroid-U3 board (ARM 32bit based), which was rock
>> stable for last years.
>>
>> My further investigations confirmed that the mentioned commits are
>> responsible for this issue. Each of them separately (3e999770ac1c and
>> 5797b1c18919) doesn't trigger any problems. Reverting any of them on top
>> of linux-next (with some additional commit due to code dependencies)
>> also fixes/hides the problem.
>>
>> Let me know if You need more information or tests on the hardware. I'm
>> open to help debugging this issue.
> 
> So I found this report:
> 
> https://lore.kernel.org/lkml/b3d08cd8-d77f-45dd-a2c3-4a4db5a98dfa@kernel.org/
> 
> which appears to be about the same issue.
> 
> Strictly speaking, the regression is introduced by 5797b1c18919,
> because it is not a mainline commit yet, but the information regarding
> the interaction of it with commit 3e999770ac1c is valuable.
> 
> Essentially, what commit 3e999770ac1c does is to schedule the
> execution of all of the async resume callbacks in a given phase
> upfront, so they can run without waiting for the sync ones to complete
> (except when there is a parent-child or supplier-consumer dependency -
> the latter represented by a device link).
> 
> What seems to be happening after commit 5797b1c18919 is that one (or
> more) of the async callbacks get blocked in the workqueue for some
> reason.
> 
> I would try to replace system_unbound_wq in
> __async_schedule_node_domain() with a dedicated workqueue that is not
> unbound and see what happens.

Thanks Rafael for helping connect the dots!

I did the laziest things imaginable to switch to a WQ that's
not unbound:

diff --git a/kernel/async.c b/kernel/async.c
index 97f224a5257b..37f1204ab4e9 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -174,7 +174,7 @@ static async_cookie_t __async_schedule_node_domain(async_func_t func,
         spin_unlock_irqrestore(&async_lock, flags);
  
         /* schedule for execution */
-       queue_work_node(node, system_unbound_wq, &entry->work);
+       queue_work_node(node, system_wq, &entry->work);
  
         
..and the system can now suspend/resume all day long again!

Konrad

