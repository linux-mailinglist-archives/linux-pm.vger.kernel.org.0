Return-Path: <linux-pm+bounces-29851-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2EAEE6A4
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F37C3BEFE8
	for <lists+linux-pm@lfdr.de>; Mon, 30 Jun 2025 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758921F3D56;
	Mon, 30 Jun 2025 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9siFlH6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83D1C5D57
	for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307437; cv=none; b=klxS29D5TtIQh5yaOjHgshy4sWc/Tru+3jyPTnaUIp4CMhYiFeHXqAaOXuHejiPj8ctSEtltuglMnoUSmOSCsLyk6j20xd4NxzDmC/yVKbg09B4xMmBAg30EnWj2EIQO38GZdO8KOco9lot+9+t6WvbMZRwxQdaDCRkDyQimnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307437; c=relaxed/simple;
	bh=XzYE0ggpzi/xWgQAv+8GzWJs6sZVm5N0XHvtxn3e7g8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gLXQUyhUTxbcLF+e+7+objUcnae2t53dLipRR82TCa4l8Wked1y3S54xb85sxUaTRrrrttSXK54Q7E7cDp5moi0QdmwZAjbQR0QuM6SKsE86mE2gF7TUktQCgZHVDV/AFoIrSH2XB2ZlJY/6Sr/O0ap3Ye0/gZyqb3KAAqCqiGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k9siFlH6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so4583043b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Jun 2025 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751307434; x=1751912234; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yBjVRv/LWhtEYGg3uh+SYefd6WbGxbfazNc3AwALFSQ=;
        b=k9siFlH6wyfr9RLxXvJHUnczNqaw+Kd5aILCUq3H3ZXypPZU0A/GZ0dVlJ5kj8IVnw
         DfMxBy2OUV4RrSnP9z3zEeYERanHVn2WVDLltw3LauUDA7glCi8x2FS8D8WSoTQI1g5t
         D09iE/fUN4v6d28dKQ+nP4doQdUDvnqLrukp1FD8AFVsAAJO5emaETgv+2yidruhOZRM
         AtZl0qrd9h+/Sy6xs8G1gI9KCdZLsCIZtO4tTY9XrinkCT3yLcQNF1YmGhzeKns0ajUR
         6zG9KaxgLopsgwi4TxSJPxyTNkP99kM6PClzGcRQwwYb4sp8l6+38WDrsSd9e937ihcY
         /YMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307434; x=1751912234;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBjVRv/LWhtEYGg3uh+SYefd6WbGxbfazNc3AwALFSQ=;
        b=OeXZeAyNmVReubnEdPHTosq97KoPFi8rGT2uIUU2OxXxixRztDxdjQ+hCA+nEhRJUf
         sLT7jWmwTPzcNwV0fzBYelzfOul0pYW/HF7jee4uVvi7YLCWCH858K8elRmCLZlhOHoo
         liMKaLtkUOIXinr2tyw4sIcbcKMo6rxDytRLoRNi6Udi1ZoATDAmf62dhXqY3IYv9H05
         FQ9Okj4s5cUaJQh0gv+ysnToMO9pqaGilpEnXLZYwsNVMt6hSq90dkE5NnWj6Q0Mj6DG
         pNfX/IiCEDWfhQF3gpBpybKYtY9FPmdB5LXuvYky55evRpfZ46CFkWKmSK3ocuudUsU8
         IZ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWM62TBgbdyKBmyA8jYymgN+n8tZqcwzRfBtpVaIAmHpLiBvJrgVViNja/gvASexliD67UEUIbKPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQKMjqV4kCyKwnxVsv/V8x9Ab6phwTuQe0UkVJhTwpoAZrZD5j
	30qHG+pgehvaKm9oybcF9ZOar/UNmAktZ6tkxa3NCXUjVnIDCFLEaoc7dCcfe+CVMYE=
X-Gm-Gg: ASbGncsx2Ng/bZ5vWRHqzQStOzcQf4PBr27DCSZQ5s5xBkNQOpaKSKJ+PBkKdcffCfU
	MWqaL60n2PqMFTeklLTW3Kba/sc37O54LmRHA9g/ByrKm8FNdFacwhlaUwrTzkEh5dimW3IKQs9
	lzMhie08ba9dwoTc13Gba3bOQauJrKZzpzgYdEZWdy0DRLhJEG0cK27W3GwQc1MoRpJngqyl8Rt
	0kt61gwznWDTbnP5kD6SG/oyiGYofkz2MvGHdB0E2R/5BRGLp+t/KOnoFJxf/xzLSqjcFuMS15t
	kvOsHhVE+Nhr5aGhUkC0bxGwbmO6SygJ/KyBe0fRBHSU1y6VV7ywJcaYVOuayqqDeH8YL0o=
X-Google-Smtp-Source: AGHT+IGQOXcusfsnRzzu9tTsp4bqdnB978cAzt96coGY3e06638Az0cSdJ5vM52cbySItmU05CF2DQ==
X-Received: by 2002:a05:6a00:4b11:b0:748:a0b9:f873 with SMTP id d2e1a72fcca58-74b3bc8da15mr742566b3a.9.1751307433908;
        Mon, 30 Jun 2025 11:17:13 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540ae4csm9398150b3a.34.2025.06.30.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:17:13 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
In-Reply-To: <CAPDyKFpTgAmLBq2ZExPoxWM0wL756zH96vW7M6wHSA1MTTG1wA@mail.gmail.com>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
 <7hsejzp4xg.fsf@baylibre.com>
 <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
 <7hcyb1os9y.fsf@baylibre.com>
 <CAPDyKFpTgAmLBq2ZExPoxWM0wL756zH96vW7M6wHSA1MTTG1wA@mail.gmail.com>
Date: Mon, 30 Jun 2025 11:17:13 -0700
Message-ID: <7hjz4tnlg6.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> [...]
>
>> I've done an implementation with struct device_node *.  This works
>> better (IMO) than struct of_phandle_args * because the caller (in my
>> case scmi_pm_domain.c) already has device nodes, but not phandle args.
>>
>> The result will be that the pmdomain helper will call
>> pm_genpd_add_subdomain() instead of of_genpd_add_subdomain().
>>
>> Below[1] is the current working version, which includes adding the
>> helper to the PM domain core and showing the usage by the SCMI provider.
>>
>> How does this look?
>
> It's a lot better in my opinion. Although, I have a few comments below.
>
>>
>> Note that doing this at provider creation time instead of
>> <genpd>->attach_dev() time will require some changes to
>> of_parse_phandle_with_args_map() because that function expects to be
>> called for a device that has a `power-domains = <provider>` property,
>> not for the provider itself.  But I have it working with some local
>> changes to make that helper work if called for the provider directly.
>> If you're OK with the PM domains approach, I'll post another rev of this
>> series which includes the OF changes for review by DT maintainers.
>>
>> Kevin
>>
>> [1]
>> ---
>>  drivers/pmdomain/arm/scmi_pm_domain.c | 12 ++++++++--
>>  drivers/pmdomain/core.c               | 34 +++++++++++++++++++++++++++
>>  include/linux/pm_domain.h             | 11 ++++++++-
>>  3 files changed, 54 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
>> index a7784a8bb5db..8197447e9d17 100644
>> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
>> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
>> @@ -54,7 +54,7 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
>>
>>  static int scmi_pm_domain_probe(struct scmi_device *sdev)
>>  {
>> -       int num_domains, i;
>> +       int num_domains, i, ret;
>>         struct device *dev = &sdev->dev;
>>         struct device_node *np = dev->of_node;
>>         struct scmi_pm_domain *scmi_pd;
>> @@ -115,7 +115,15 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
>>
>>         dev_set_drvdata(dev, scmi_pd_data);
>>
>> -       return of_genpd_add_provider_onecell(np, scmi_pd_data);
>> +       ret = of_genpd_add_provider_onecell(np, scmi_pd_data);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* check for (optional) subdomain mapping with power-domain-map */
>> +       for (i = 0; i < num_domains; i++, scmi_pd++)
>> +               of_genpd_add_subdomain_map(np, domains[i], i);
>> +
>> +       return ret;
>>  }
>>
>>  static void scmi_pm_domain_remove(struct scmi_device *sdev)
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 88819659df83..3ede4baa4bee 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -3220,6 +3220,40 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>>  }
>>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
>>
>> +int of_genpd_add_subdomain_map(struct device_node *np,
>> +                              struct generic_pm_domain *domain,
>> +                              int index)
>
> Providing the struct generic_pm_domain *domain as an in-parameter for
> the child-domain seems unnecessary and limiting to me.
>
> Instead I think we should parse the power-domain-map DT property at
> 'index', to find the corresponding child-domain's specifier/index and
> its corresponding parent-domain.
>
> In other words, we don't need the struct generic_pm_domain *domain as
> an in-parameter, right?

I'm not sure I follow.  The `struct generic pm_domain *domain` is the
SCMI child domain.  From the map, we use the index to find the parent
domain.  And then we add the child as a subdomain of the parent.

Are you suggesting that I (re)parse the DT for to find the child domain
also? 

Thanks for the review & guidance,

Kevin

