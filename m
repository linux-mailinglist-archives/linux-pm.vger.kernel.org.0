Return-Path: <linux-pm+bounces-25727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E8A93BA5
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 19:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DF746455E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50D713C9B3;
	Fri, 18 Apr 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9iFGPM/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA94CB5B;
	Fri, 18 Apr 2025 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995991; cv=none; b=DEv5ZrF2iDWAxgvlZNz2zEmZOwAfxhqv9QKaAQn+3PsgyqaNPOnUKVVm4EdLZ4MgxQY7NaBQ3c2FJmCscmEtlTwDr0eOFTBmpRek7pDxFCef+/8sHPza7RRWwRfNlTW2h/CQbd/1QUyw7utaJLDdrSdyWziaxl4xm44BiZqBoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995991; c=relaxed/simple;
	bh=0xaQA2UVPSMEQ/VUc9Kat7LSW/u7wajNcLtjdcne0Fs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DJWce1cjngpIN7TOPvGQUGmOExcstTLxWX97DWgwW06eQbhFB5GIGzqkIIIo7N8HDaAPG0iJynvZen3sMZu9nPzMh5hgYxoAlIenfazADCEDwtvNmKEp6tKwMC8Mn00xxqs5G7OG5VOPX4nelaukhEOAvAJatQs4v8rrjDFAjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9iFGPM/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so25055235ad.1;
        Fri, 18 Apr 2025 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995989; x=1745600789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sIIrP2GWMceGfoIdHrl13ZbJpeHgpgMGCD6jo5DlDHs=;
        b=k9iFGPM//21QuG6K7+ktqyHIs8wmGCLsKudJJ/esE6Jx9hJXctOUTLPJAluqNetwjx
         n2QDOxBlbhfaBZVyxfuYGNZb7qaNLgNjpqvS997daDeUCinhEvmL+MqEOdIiKiIKPAi9
         Hp1lYWeh8DR/9RaWscy7tMKsbi6nvZnECHPgCius8QlungDTY3tT/8O8vZ0MpSPAqePr
         CdlZ7zs5rDTvAVToOx2Jvw3ukUgdqDe++EeOtQFPeLXLbyNJsjJ58odNWAufpsfsEjRV
         1H6OA4EFZO9iNpvIQSGoJiwamuLE1xT9x+QbCtWNo+TIHrYGhDIkL64wWtFii+cmj1Xr
         Uhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995989; x=1745600789;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIIrP2GWMceGfoIdHrl13ZbJpeHgpgMGCD6jo5DlDHs=;
        b=TppiLdMW6TJ48M3kI+NPtzp5HJGgJkXybkFKOPPlx6rhgeS3UzF11/KgKgrDLnjiUx
         uaRDP81P64YNoDSmXLIqFUJBV38WNlE9HOI3KPLHJPflwXWoN+YKgRhoLYTXlr/jwF02
         H+ki9/tRULoK8ro3VmKq2VJewG31QaPgXb2pB+lYoaIYjvPLE2I0HxAqsQcy9B1L5mto
         uQnR0lQNSGseQ5oMFvjqsziBXzGMwExkvwSuV6Hqqim6wd4uCzfW6p5Nyfyyq6jVTkQd
         OF53mHMXBSFbAnm2E/Xbn5Zq5r5TjIPcleHwqS6p0xeYOnEcG1Ujy2Vpq4y0GF0L7prA
         06xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcicBHsraIB67z9VPxfI9fcivz4CGhYZx+/iVSjHilPF2PU+eZszuobLivcgn8MM2oznJcI/8UDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhje/Hk3WTtyFfKVQ/5jOf/nEskMWGq6MVjDlyD/68HHq8STak
	mnC2KN3+UcVSFEIW0tJtf2O2siUD/KVOgQheb3P7qvhPSbQdvTML
X-Gm-Gg: ASbGncvqTayIdZS9N/jzE+yS1WCn1GJVO/YOBYCDjfmzCK2EkFYSBbLsACegB5wCcHz
	21sLPdT1LEq6ZNfuhbS/c3X1vg9ouVfCKXFpSmLHl9VXNCBY48Ib8VFHzP4rtIB566m/z8AUxK/
	OQQ84+wNcPIIgHWxo2VCN5W7hdI0lW2qK3QRzJWutsW7bj6I/xgScqr3q/lyBR01Ptv6BnTFxvx
	8oAVJ6dVhVGuqm2KD1SyXYE/Ur40dva/DL7oI5suYW9V9mVhHr23WmoRuCrOzeoTauu+GeE/dIn
	Msx6woa9l5VT4DUJAt2qT7W9icOhoLoBkN4sPPCoCsZ7/K3a1izZObFWLVZ9GVk5NtneB724Duo
	foXwUoiGv0ijd
X-Google-Smtp-Source: AGHT+IGQyOQ65RlpomzpcZOJ9QzXfspcdfjcXi21Dl1hveqlFjswYKY02ubfm8vgFM5lq/ULceH6tg==
X-Received: by 2002:a17:903:3202:b0:220:faa2:c917 with SMTP id d9443c01a7336-22c53611075mr52624155ad.34.1744995989330;
        Fri, 18 Apr 2025 10:06:29 -0700 (PDT)
Received: from ?IPV6:2001:56a:f6b2:4a00:7181:6803:4a12:f331? ([2001:56a:f6b2:4a00:7181:6803:4a12:f331])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bdac04sm19250275ad.32.2025.04.18.10.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 10:06:29 -0700 (PDT)
Message-ID: <978bc0b7-4dfe-4ca1-9dd5-6c4a9c892be6@gmail.com>
Date: Fri, 18 Apr 2025 11:06:27 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicholas Chin <nic.c3.14@gmail.com>
Subject: Re: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
To: Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, vincent.guittot@linaro.org,
 zhenglifeng1@huawei.com
References: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
 <20250417015424.36487-1-nic.c3.14@gmail.com>
 <20250417050226.c6kdp2s5du3y3a3j@vireshk-i7>
 <20250417050911.xycjkalehqsg3i6x@vireshk-i7>
 <CAJZ5v0iO4=nHcATzPyiKiWumdETFRR32C97K_RH=yhD--Tai=g@mail.gmail.com>
 <CAJZ5v0gcf07YykOS9VsQgHwM0DnphBX4yc9dt5cKjNR8G_4mAQ@mail.gmail.com>
 <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKohpomN1PYn1NPSsxCxqpMfg-9nYgCRQD6dFGQ30B+76vneQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-04-17 23:58, Viresh Kumar wrote:
> What about something like this instead ? Nicholas, can you give this a try
> along with the $Subject patch (both patches should be applied) ?
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 924314cdeebc..71557f2ac22a 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -909,8 +909,10 @@ static int acpi_cpufreq_cpu_init(struct
> cpufreq_policy *policy)
>         if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
>                 pr_warn(FW_WARN "P-state 0 is not max freq\n");
> 
> -       if (acpi_cpufreq_driver.set_boost)
> +       if (acpi_cpufreq_driver.set_boost) {
>                 policy->boost_supported = true;
> +               policy->boost_enabled = boost_state(cpu);
> +       }
> 
>         return result;

Thanks, applying this patch along with the $Subject patch works.

