Return-Path: <linux-pm+bounces-10320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCDF9237E0
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 10:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F051F22BC5
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3914F106;
	Tue,  2 Jul 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXD0xa1r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF4114E2E9
	for <linux-pm@vger.kernel.org>; Tue,  2 Jul 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909793; cv=none; b=E9Q84c6Pj/oqntk7MOJ1dIZDMJfMiGvw83T1sV7Gd4vuqiJFIUd7PavsRtPBp8ZA4SjMVQV2Vuhi4inOg47AYUJ9+6a4xI97cpd6F7z69EIhUSnbz7w+EXR0yTolvrovnKG1y3YZZE0X/2zbH/KY3eBbJZDFCdi/TN7hEeh4bN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909793; c=relaxed/simple;
	bh=SJHlZBOSA+3+lnPuviGQpdlU9rY3FwzL6Gu9MvuAZco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2S5yBkbQRXOwzXAQ7gyY7X69xklRYeaY1pPyzgK9Rd+mYv4bVUJf41awMKL1YUGahfL4xt1u8yOO8wZssv2PmL9Z45yxC9f6Vsa7eT/po7I75aoFM+FVJC5at6jNj9ZIupyrXP22YV825dtZQEnOtM1Qt59chWcbg3R/OI9TbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PXD0xa1r; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb05b0be01so577885ad.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Jul 2024 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719909790; x=1720514590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vQ8zplKEvkyqs0AhE9LwFp0KDkZC+KF7mrGUufJk6Ng=;
        b=PXD0xa1rPRriMku4erUF1QY2TBZ4Ug44pJOPVVj6Nhcl5bh/1LW1m9lDSaKCyKqKP1
         Bnsub1BlfqJSddD1x1AZ6flScuiXvDwhpF2yElbbc63Qbs9iUAmjxK3z+fWxpGCyDFJa
         mayt8fyCKIB/OMIy4cP3T227SvHHKm0JQkWV/4DEWjoQvq0r6URwXJDraD76Y5FRnXcM
         laJvpvVdUOoxhJJ5ZvqWzgMKhZ+F9ZIXFKMssCnUuYnCa5m5W9ZxrkV8cAKkk0UDnmUC
         z3WEE9d6FEwa3n+jHxHe7KSCl9o10zjGTk9aW+nCZ2ZMvr/H/rN1YPpEH+ACrxL0Dc9A
         4D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719909790; x=1720514590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ8zplKEvkyqs0AhE9LwFp0KDkZC+KF7mrGUufJk6Ng=;
        b=iQS6QJVhTXmCxo73b4sRWFi3m5Bp1QWPDvMIqAw+0zZ+4JfajmsoX6qGK01rjgcWcm
         JHyFwhSEKuj4LDPkhbBuH8o7Tu/mZ9WeSeK5WlPQbC3ZSIL7bm7Oi7Lz5XBrYfgp+qnG
         dIoRAByk/M9jboH24srU1fHjfZrjBtRJbKPhzkfuCuMXjd4DjIHIpokfRJFf6ac3A39h
         +X4KQvnBzWoQx0MKgZix9iugIEaBUAY1wThv3RIN3TziFQEajBFn/KPLOOTBYMQqPaa3
         gvZn7EQ67fZ6ezYpNU22OoMPPKt5aVwtPcHQ6YLfhUEGiKAwWagRbP+SeukopYNFgt9M
         p0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKR5aJ27NrKw8WjBvS/tnOslYU6gwyrwupvGjBk6OH7Ldu6dZSDhDE4Gjcoo9Y48RzrMXSeOdBdEgOejfW6NJFFpT6xG4KSww=
X-Gm-Message-State: AOJu0Yy2vfN59PL/yfkpvfxsI+U+zYIz2FnU3cf3zUBCmIejI7OJgULH
	3zKhXyDZdqSS6Eh34fPiC6O8Qi+poBcl+3p2gtmM9yD/3/snpgu1ZV6+NHzvv9Y=
X-Google-Smtp-Source: AGHT+IEmIv2vGdHXLm2ZvbXST6X7Il1ZBsG0xUxf3z1Ipxyow451EWanRYVGWaC0ZCem1Pikt0Jlng==
X-Received: by 2002:a17:902:d488:b0:1fa:a68:47a8 with SMTP id d9443c01a7336-1fadbca042dmr72974405ad.28.1719909789985;
        Tue, 02 Jul 2024 01:43:09 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156957fsm78805885ad.228.2024.07.02.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 01:43:09 -0700 (PDT)
Date: Tue, 2 Jul 2024 14:13:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>

On 02-07-24, 10:26, AngeloGioacchino Del Regno wrote:
> Il 02/07/24 07:57, Viresh Kumar ha scritto:
> > On 28-06-24, 15:48, Nícolas F. R. A. Prado wrote:
> > > diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> > > @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> > >   	int cpu, ret;
> > >   	data = dev_get_platdata(&pdev->dev);
> > > -	if (!data) {
> > > -		dev_err(&pdev->dev,
> > > -			"failed to get mtk cpufreq platform data\n");
> > > -		return -ENODEV;
> > > -	}
> > > +	if (!data)
> > > +		return dev_err_probe(&pdev->dev, -ENODEV,
> > 
> > What's the point of calling dev_err_probe() when we know for sure that
> > the error isn't EPROBE_DEFER ?
> > 
> 
> Logging consistency, that's all; the alternative would be to rewrite the dev_err()
> messages to be consistent with what dev_err_probe() says, so that'd be
> dev_err("error %pe: (message)");

That would be better I guess. There is no point adding inefficient
code.

> > > +				     "failed to get mtk cpufreq platform data\n");
> > >   	for_each_possible_cpu(cpu) {
> > >   		info = mtk_cpu_dvfs_info_lookup(cpu);
> > > @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
> > >   		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> > >   		if (!info) {
> > >   			ret = -ENOMEM;
> > > +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");
> > 
> 
> By the way, forgot to point that out in my former review: to make it shorter,
> instead of "ret = -ENOMEM; dev_err_probe()" you can write it as...
> 
> ret = dev_err_probe(&pdev->dev, -ENOMEM, ".... message");

`ret` will be  be used I guess with the `goto` statement to return
error and so the change was like this.

-- 
viresh

