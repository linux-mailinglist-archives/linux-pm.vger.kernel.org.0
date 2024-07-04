Return-Path: <linux-pm+bounces-10571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42963926DF8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 05:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6D31F219F8
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 03:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083D817BAB;
	Thu,  4 Jul 2024 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEnzbZSz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7971755B
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062936; cv=none; b=hae7GfMUFWzRvRIzTB3f9DsYjEgyyIJ5/42mQ1uxDwArjtJdyBrYs+m28L7frt5Tw9OfQqzO2zX8rVRqTQpC5Wndve3p7wHz1sgpkeBVYM3UsPJEh34D+UTtbynr73tYQNDDfF4hCyt7EJ9R1PGnKMntm45Pxsd+8yjUl4uBnzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062936; c=relaxed/simple;
	bh=84LAN5AvodIdD2krtRzJJ7eWWZkwf62ts7mCfwmL7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP9Jm9kvDqqN1Q3y77yiFKRwzjR9x1ddb7w8/zxUSK5HQE1KqRI8AnNK8NuZUiOhfR22SKXH5o4QRQJKn0Nlf3yDR2uzPNjm4SESTNWG2O9BEEJy7mTuUhlCXKNosuEpkGgYA198HD26pkFoMI2lZ/0YO+mak9Ve2iva2yTZGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KEnzbZSz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f9ffd24262so949605ad.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 20:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720062935; x=1720667735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OxpOKbSyZF+WftZDHrhQeUp38zw13Z/EQZYlL8Cj7SM=;
        b=KEnzbZSzD8RZpTej8qQ9WBkJnq7zVchogjXk9condEAbuOUq0hHI3eyfalpA7SmSES
         jtoSslTCwjR53NSrJPhC/5O4nA4jUcGcOJCOpNiMLrv0s1Whex+AJPY5VuwlzLW/TcWI
         AUjgpitdDl7xHsslew/YtdoD1Mr8QuekaCjzuMQH0WCGggmUBjm+2yAl5a5NyQahDlnv
         ovJCVHUf5TPWHvQHt/nERJ9gaFXuzjhybchalEgbGzl48+n86Bi9HYJIH/bQZsJrkQym
         CMC5akyqFVVFT9Ap7zJUydAzuEdFcuy1b7cZ5fOawmP7fVUfYyxJF5gY/ogtCdHbcNBq
         h+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720062935; x=1720667735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxpOKbSyZF+WftZDHrhQeUp38zw13Z/EQZYlL8Cj7SM=;
        b=fDm6ROqQVZUocCu0rwrZHlmX3678GRam3iVdgUD5X7nR0ccunFKhBcYN2TaBRuTtVf
         WqNHRpw0VZowxnTejFWAEDlE4NkPDKJm+Q84X0s/WQB95+AgrNKrpkIpuKeNUM2Z76eA
         U2OVXthjJf4U92Rm1VuZUcrJhv7Rmt4RoNsFaXP20mKAeBMDKC0/rU8JgbQDJcIP9SBY
         EK/qF6/79Rm4jLJ/NafcR41rJ59RuIaS98qJMKzLcRAZ3xfw7tT0C43ekTBQI7w/h0MD
         zMikbHLcqgKjVM5XZbk0DuvaGKpXFzBpFUUo+Vgxt5uaWTOuJQw/4Sa2Cza1YwNYUTDs
         QDYA==
X-Forwarded-Encrypted: i=1; AJvYcCUkvsKobkIPyKLoHCXk8yuex3MTmIEHkbj9OvENdIuPiXVUrN5oLx+scmAb3H+JqNA3NoP8YsV+DphniDKM5I5pkHY7il8egto=
X-Gm-Message-State: AOJu0YyQY0n/DGmXNK50xE+cKXivaWMTVVj6l1otALt4iZtvHHz2jAa2
	xSOR8aSu/RJfW4j51K24iDE0m0JpLlHX036/hSnbCu3nZDY26/sRkcGdoRI7VC+fyXzlUP2+nPy
	J
X-Google-Smtp-Source: AGHT+IHuvXn0DSewmFV1N4IkbJv5j3w21MonR1q2vZlGPKXP1aEu9fzii35l9bVOl2J1zNs0Kby9/g==
X-Received: by 2002:a17:90a:eb15:b0:2c9:5c7c:815d with SMTP id 98e67ed59e1d1-2c99c57ed63mr312263a91.22.1720062934777;
        Wed, 03 Jul 2024 20:15:34 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd3e7sm307714a91.39.2024.07.03.20.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 20:15:34 -0700 (PDT)
Date: Thu, 4 Jul 2024 08:45:32 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V2 2/2] cpufreq: Add Loongson-3 CPUFreq driver support
Message-ID: <20240704031532.5bkh4nr7d3vcvzwq@vireshk-i7>
References: <20240702152737.1184244-1-chenhuacai@loongson.cn>
 <20240702152737.1184244-3-chenhuacai@loongson.cn>
 <20240703101850.dtck223pleiiwfxp@vireshk-i7>
 <CAAhV-H74HJr0=8g0GtHj=zZH5nJijRpc90zLLRY_sXJfKFVtHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H74HJr0=8g0GtHj=zZH5nJijRpc90zLLRY_sXJfKFVtHA@mail.gmail.com>

On 03-07-24, 22:37, Huacai Chen wrote:
> On Wed, Jul 3, 2024 at 6:18 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > +static int loongson3_cpufreq_target(struct cpufreq_policy *policy, unsigned int index)
> > > +{
> > > +     /* setting the cpu frequency */
> > > +     return loongson3_cpufreq_set(policy, index);
> >
> > Why use a separate function for calling do_service_request() ? Just
> > open code it here.
> Hmm, there is a loongson3_cpufreq_get() function, so I make a
> loongson3_cpufreq_set() function, too.

The counterpart of _get is _target and so a separate set function
isn't required at all. Just get rid of it.

> > > +static int loongson3_cpufreq_get_freq_table(int cpu)
> > > +{
> > > +     int i, ret, boost_level, max_level, freq_level;
> > > +     struct cpufreq_frequency_table *table;
> > > +
> > > +     if (per_cpu(freq_table, cpu))
> > > +             return 0;
> > > +
> > > +     ret = do_service_request(cpu, 0, CMD_GET_FREQ_LEVEL_NUM, 0, 0);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     max_level = ret;
> > > +
> > > +     ret = do_service_request(cpu, 0, CMD_GET_FREQ_BOOST_LEVEL, 0, 0);
> > > +     if (ret < 0)
> > > +             return ret;
> > > +     boost_level = ret;
> > > +
> > > +     freq_level = min(max_level, FREQ_MAX_LEVEL);
> > > +     table = kzalloc(sizeof(struct cpufreq_frequency_table) * (freq_level + 1), GFP_KERNEL);
> >
> > devm_kcalloc(pdev, ...) instead ?
> I remember you told me this in V1, but devm_kalloc() needs a pdev
> instance, which doesn't exist here, so I keep kzalloc().

See how drivers/cpufreq/brcmstb-avs-cpufreq.c stores the pdev in
cpufreq_driver's driver_data and reuses later on.

-- 
viresh

