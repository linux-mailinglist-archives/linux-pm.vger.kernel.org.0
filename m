Return-Path: <linux-pm+bounces-17293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C89C3744
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 05:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD41C20AEE
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2024 04:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A21494DF;
	Mon, 11 Nov 2024 04:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwt50/J5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA96335D3
	for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2024 04:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298268; cv=none; b=kuNyLNvPjlhvM/dvjS/O3dpXU9K5xTBfm5yBiK+yyt3vknFIzg8M5l804dS1vTCusjm77Kxldn1lP9mVcM3KjeGAKiJkosUIOu/6j6s08jvSNDGbxWaWxMbOHnHcKZD/gkiWiDvDiP1af9sLrBOtumnEP5/RH0FDg99qHJlzm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298268; c=relaxed/simple;
	bh=ytkqzmxvwKpxZEwBtyFIRhXqEMAvdvtQybyYLYu65U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCueKqwHJhqn+58kKUfpnl6zILeqLKoTuNwmwtD4UbvnHHVPFPYWfiif+hOUjUAMdYQkbBnMZkxSW4DZHm3sNMIuxwbWUZZOHPbA6YCjPWjcb/FbzUemadf7OnimqajIVJUdFO33OMhvTegD2D0HRNsXMyiBOakVOVzAXaaxq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dwt50/J5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c8c50fdd9so34455205ad.0
        for <linux-pm@vger.kernel.org>; Sun, 10 Nov 2024 20:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731298267; x=1731903067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctH8t+j4ut9lhSE/gmof2Pt3Enum2gsVdHRiz0klkzA=;
        b=dwt50/J53/qb7NhZVYvggOfQtW12pfjX5Krxwutd/SSkKx3nknMIgDxJcW9kaaUoie
         eRXM0uSQPqLo7sW0K5pHMJ+j3rrPdp8/dx471FLnC3xiyw/mrER5vbpHsnt1wB3wunqH
         5p9cgezQnCo1issXbceAmAICFZaTIpSHW4k6+NRS8yBlZPJlfB7oB6BmZuvl/kVzTcaX
         3k0Bt7MI1+XiomNtnntH5w8giwPoNq7rkF8jP+uMNRRtLaXYed+n+UH9ULbkMwLiuwIT
         6ijogQ/Z5YxghpZeTN5JoeXB0VhVPkC/YykTdrJjSeWZ2uKlq9TSd62lbO8LO7wCjna2
         x16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731298267; x=1731903067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctH8t+j4ut9lhSE/gmof2Pt3Enum2gsVdHRiz0klkzA=;
        b=t96CzzRU4/5WEI07R7jsmAGY+xTcThAdlRctsnyeiqrOac7O9Pw3r6tLU2uEe4+wXn
         YJf9mC7lNBfp2y7VrR2oHaLbLeekUifN+gd+YGs3GaKj/NKKsHwJoAQrN+b8hML7xxHx
         8PA1ysUo3bURuukW95FEABX5qyF0RrcV+jjLDl5edTjbFina7zQjkdXhTf9F/JLZjGUi
         hB7vqm1ZK/ddHPxn01blYlAngkmDgr6FPki/X2N61xvqECDRjyw0+j98pbiiaxLruq3d
         rrly6+nFeX32gK/wXcjaoUpXJPuFx/TNX/OPEiBp/FVy1ireirevz45GfnQMgLQgLFFH
         co/A==
X-Forwarded-Encrypted: i=1; AJvYcCXZaGkilar7lSLz7qsCRPConZ77JVsuPcO5ndwCp0CrT7wZN84G7Sk9x9bfoin/sXgNQvdksNP5WA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3USQrXFpaot9D/HQ9GAOxkiOC58gOE4uY2P63kPh0rf484OMz
	Ps7WSWY08jGbxGeUvmnwey3u0RdJq+HilWPmiJqOWRWtKUx2wrOMpdzXPkGzkeI=
X-Google-Smtp-Source: AGHT+IFubI0BiE6KUfLJ0py24LTyD/KjdzxzHwV6n/RQ++K7sXtjjfVIWoq+ZzOvhHe3GI8kMUqAng==
X-Received: by 2002:a17:902:f60f:b0:20b:723a:cba1 with SMTP id d9443c01a7336-2118215cc8amr178953965ad.1.1731298266670;
        Sun, 10 Nov 2024 20:11:06 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e44812sm66595515ad.144.2024.11.10.20.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 20:11:06 -0800 (PST)
Date: Mon, 11 Nov 2024 09:41:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
	zhoubinbin@loongson.cn, loongarch@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: loongson3: Check error for devm_mutex_init()
Message-ID: <20241111041104.c3bfz5yukz7ahxlg@vireshk-i7>
References: <20241105032053.1782082-1-ruanjinjie@huawei.com>
 <20241111035804.zc3gwtg5ms3bz34h@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111035804.zc3gwtg5ms3bz34h@vireshk-i7>

On 11-11-24, 09:28, Viresh Kumar wrote:
> On 05-11-24, 11:20, Jinjie Ruan wrote:
> > devm_mutex_init() may return error, and the avoidance of checking
> > the error code from devm_mutex_init() call diminishes the point of
> > using devm variant of it. Add the missed check.
> > 
> > Fixes: ccf51454145b ("cpufreq: Add Loongson-3 CPUFreq driver support")
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  drivers/cpufreq/loongson3_cpufreq.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> > index 6b5e6798d9a2..a923e196ec86 100644
> > --- a/drivers/cpufreq/loongson3_cpufreq.c
> > +++ b/drivers/cpufreq/loongson3_cpufreq.c
> > @@ -346,8 +346,11 @@ static int loongson3_cpufreq_probe(struct platform_device *pdev)
> >  {
> >  	int i, ret;
> >  
> > -	for (i = 0; i < MAX_PACKAGES; i++)
> > -		devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> > +	for (i = 0; i < MAX_PACKAGES; i++) {
> > +		ret = devm_mutex_init(&pdev->dev, &cpufreq_mutex[i]);
> > +		if (ret)
> > +			return ret;
> > +	}
> >  
> >  	ret = do_service_request(0, 0, CMD_GET_VERSION, 0, 0);
> >  	if (ret <= 0)
> 
> Applied. Thanks.

Rather applied the one from Andy as he posted it first.

https://lore.kernel.org/all/20241031134719.2508841-1-andriy.shevchenko@linux.intel.com/

-- 
viresh

