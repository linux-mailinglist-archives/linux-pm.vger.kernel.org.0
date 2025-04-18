Return-Path: <linux-pm+bounces-25684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C882EA931AD
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 07:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D698F4640EC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 05:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB8222DFA7;
	Fri, 18 Apr 2025 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWdxi/HI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6B1CF8B
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744955937; cv=none; b=XWOsU8IKiQl0dgEDe9M4HIvWs9YVu9o/CO1WlD2OVPxAqhchKd+ExSyLsXbwEFUI8DWOsPqzVkWcmoG0WMZKmBHwEIZT/Ec3g/1GnNBWvuQS+2khhO+klaFJbtdAEKQMEurDcKQE0K+4WXZ9VZWPghWBw5xGqpKA/hlWPJUnC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744955937; c=relaxed/simple;
	bh=9vzQM3t5vp/0pOozAYzw8sT/kUPRS92tdRYnfzsM3ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CD+TEsZxa4dUtyyol4da2mFYHRn4Ho7iLlzc2QYSCueCZfis/OsdVAWVyVjgbFtfVZbmmfas48GeF93pL0k6ANd+lVC8+UK/+aNi/DbxsSRa4MjjjpjDcOfv9jG41bXL85NpmktL/VWpeALJh7Gt/ChhZP6X8QeHTG6ygeabeJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWdxi/HI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso2765570a12.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744955933; x=1745560733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rFhmOeXgIAlpgdzXmkuAFZPhvLmDKS09kQhKDPs7SSw=;
        b=QWdxi/HISx2YFfJGrAMKYH2CIctgux9CvDakPaZRtqMYIvIC+haank58pLqduZPA8D
         bbQZnDbNnJFEav/GmeMgvoTbVF81KIOD6dIYIYvwIv6vsAzBHqjfKwLc3k9p4qZTiuCZ
         /3n/q1NGU4duTRAJ40RII2D6TIdwaDSK9qXLFE7f2mf7lfgG2iLNoU8BKwieQE7j+dLV
         wlsbkixrRwvPos1/BwslU15lx/x2MgsCtVZgz1inUGHbo76G3RbLWsr6jzMwINElxtZp
         Q3npsuK4QR/wZyHNWG1XiWePPWUtJnxyVHGmuiUEEzCmw4dtdcV08g4nKWqcXhQskx0Y
         Xuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744955933; x=1745560733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFhmOeXgIAlpgdzXmkuAFZPhvLmDKS09kQhKDPs7SSw=;
        b=lLSsDsmAf9raQu9yLtPsr1Fb92GU1+WSiUOI2kskGK6+2AoOEOVszQEVxiN/Yud9Uh
         Xn14fJZt1aRAPuphxHX5KvzuZc+aGv1HQMt96ojTc2jD4NQY3KP0igFqa3S0xm0+lVEt
         pu3WXDvARU+v6k0SvsmF9om1vkGMXFIypSgM4n7dBmmB58ZRc5R3w2AyaVV6yOAdo3pj
         ZszoVvmQlYH7hX6Im1XAsRzGnb7mbd5jzdKJibux+qMjqJYlUXjwjO4HY1BxpSMAb9Dv
         AdMI9sedEfRlwvHWNDYRNtDUj8r92m0PRE2JLuoiSUySSZ7nUWfGP9MGHKYENoBnJ0fe
         bSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx+Ri4iP1g50ceXWHq7jAyFZyuMkDd7CHRIdjEI/u/J3dq5nnJuhY/Bf68SO+JjxkioFLrYY4jdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oYvw9mYCO8oV1szcpJNBhDEMy9MdmVtWPwWKoiw/32xsNSSF
	MgRuTmqJTzF5RPTB5QDLLNEtwvT+798Ebyvfo/7uP0d/gZSx2Jaak8kZO7zYjPcYP/lZIyNbTgM
	SIpuqSjqNDlMm6FPF16XS58s2Ye4J4mEEkAH4Iw==
X-Gm-Gg: ASbGncvQSwB+bGKAUs2EYv2o9/QIaD91yyEwdkSgIch5AuWHWasI5k+b8vMa+iLZe1c
	88sFMfBs5yknes6zpOHEuVLal2CCizTfGifDhmUc78pHjPss0dlbGSVt74CRd+7o3bSNJod3Yhn
	ZUwNMuesuWB6U+6Vg1BIl8gDIrJSDPh8k9
X-Google-Smtp-Source: AGHT+IHh85joDb2VeapV3maVEqgQe9L9tm8FqA2mZKy01E0HnbaGNJfQUJ+nqSYGMzINt6uLO0DslAKNblccoGq618A=
X-Received: by 2002:a17:907:9712:b0:ac7:16ef:e994 with SMTP id
 a640c23a62f3a-acb74e19569mr100020766b.56.1744955933480; Thu, 17 Apr 2025
 22:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com> <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7> <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 18 Apr 2025 11:28:49 +0530
X-Gm-Features: ATxdqUEgPyyaV3xmQOk0XfmWdfy0ew_P7jRJpbFnpMXANh3GgdaCIR7Xj1vkn-o
Message-ID: <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Nicholas Chin <nic.c3.14@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, 
	vincent.guittot@linaro.org, zhenglifeng1@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 21:23, Rafael J. Wysocki <rafael@kernel.org> wrote:
> But the changelog isn't because the patch really doesn't address the
> issue at hand, which is most likely related to the platform firmware
> clearing the "boost disable" bit.

I think the patch and changelog were still correct as the driver was also
enabling the boost at exit(). So it fixes the problem, but not fully.

> Frankly, I'd rather get back to the state from before commit
> 2b16c631832d ("cpufreq: ACPI: Remove set_boost in
> acpi_cpufreq_cpu_init()") and start over with the knowledge that the
> platform firmware may scribble on the MSR before the kernel gets
> control back.
>
> On a way back from system suspend the MSR needs to be put back in sync
> with the boost settings in the kernel.

What about something like this instead ? Nicholas, can you give this a try
along with the $Subject patch (both patches should be applied) ?

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314cdeebc..71557f2ac22a 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -909,8 +909,10 @@ static int acpi_cpufreq_cpu_init(struct
cpufreq_policy *policy)
        if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
                pr_warn(FW_WARN "P-state 0 is not max freq\n");

-       if (acpi_cpufreq_driver.set_boost)
+       if (acpi_cpufreq_driver.set_boost) {
                policy->boost_supported = true;
+               policy->boost_enabled = boost_state(cpu);
+       }

        return result;

