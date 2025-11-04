Return-Path: <linux-pm+bounces-37355-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA89FC30D8A
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 13:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 381AD4605BB
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 12:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60392EBB83;
	Tue,  4 Nov 2025 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQ7pMc7E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88EB21ABD0
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257600; cv=none; b=HQ0wB8F3Jbd0r1HjNa5ZL9cy/6FoeES0BRjleX6GlHNsXpqewgjZNVOqCC7nsso50FcsncTJjiCj0lS9nPhOojRu0LTyOAMKnLBdP+j2PFI3VI2k2AjjkSrhpyFaqdOWdQzBeTONYnNgA8Ww4lzRiX9Sfq21ZcZECqWT8oAYznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257600; c=relaxed/simple;
	bh=6c8g/ZYuiMRbAXxCY6J1PXEVbRw5F54c9Htwc4BoMEk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BI0wVFgdhLRzgaMQgymYufVItjoErhPga7L7/6rjH/EPxVXf2JiVK6ts9WrZObYMAstqEajuVSXKbKVh9hYgZyLM40V0BMsrY9A4lkVjzlWEjfprYUODFrC5BATXgloJHAlPJxiYO43W5Ygy/9VwETgTFdDGGMml4wcA0XBI1Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQ7pMc7E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47755a7652eso5078685e9.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 03:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762257597; x=1762862397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CRDsESs7bHanH8A88qsmRD3YZo8DiYehUnYoS0PE/dY=;
        b=FQ7pMc7EVU02JgHkwnntA0bsxQ4N9WhVx+4G+XKKZd0qVT9XXnJGbqc+VFLDblbUYJ
         eDQcaUG5CiQTTEXxzCMtA4OhsbJKR9N1DSwbbvlLXIFavvhv/0gk7BtYd8okvTSiyhcf
         fVLXJcMwpK+FeODEJknJBvA35GjaOfGaSEoVZ0qcp25E+GOjV0Gk2SVIMh94KL8S6PSs
         LEXl4Rmkf6DjsbjI4AFb0fX8N1dDC9a11sxerLaXDnaIwHKgt5UTZDLxdi/rkKmK65OG
         QbezhlrJSsEKBpmWTjiCjXefJAccyx9nTxAWFq7HYpjzI6EoAxkC0KyJKWi6BU4/iyH+
         Jf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257597; x=1762862397;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRDsESs7bHanH8A88qsmRD3YZo8DiYehUnYoS0PE/dY=;
        b=DNaxmD8BNI3dwEQ4mSZYuCLFOw1HPCeW6ZKw8XZwqnpHXYUWqxhBrLuY2is95OJCE2
         0YPQqsdL8AaLVIVDVPvdwQX9/aSO6L4gXYhIwCecGGPiQ2Rui8aaQzul3VTzGv0PPjZD
         13LI9FvxkSQFkZrDFRnYXTTJ5n2P93+nIna7K5j6v6NHE5t6TxDnMWUWQZs4+C71qqtA
         GL3tw3DrVPBO4NIrmsJJiAY+T/tDpckVkaRsOIJowhb5+WisgrU2ekKBMXmQ4KApx8QO
         a2ZO0lj+Z8jYBqI6w0sRt7rDbIPtCttJf3DZGDDdTZ6+WNUIR5fYRjtPm1e4OWFL/JAz
         AOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkx0Kj1nL/6PRBZSaYY7TzxNQvBRvd5yr2PayFOnvWXAh888B5/ABTLABMKbgIROvBffuUHfoItg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHNQm378fkb257kSUJ653TTTuzle2CgRGdVX1PLcfog1m1ijlg
	bvNyXyqS+Wczc4HLh3lb/ySJH2mSl8XgGv88dKTexZ9zY5WBuQVm6coH
X-Gm-Gg: ASbGncuRkvjVKNHjhdmttC0N3akyS4feAazrdNuhvs48e9Yug5LPWVGZzllcGqeXa1h
	OyM8vEWp+FyF8QaXHGN7cuP5wkPjRQPLEgHn2bWGpEk86z7D0prus1L6Pe404K480wxMAr/zPCu
	CB5kKeUNhUtUCUAaIewOXe5+HErpq1EAkXsrw06L/UwFkBLppemISHngrJq9B9olnsVmo+bzjmK
	rE2aeJLJ3EICph9s0II01YtSShDTBu0ClIfKDiv4Pn0MKOSDVp+qyK5YfmbOJpFOoBHstdVzkBp
	bJCe+aIcQzF4ski/MpeBtBPrLirruCTeVTRkOWDyY5MOL3K4yRISAH07XZ43DzFFJpga22mckSt
	2FD+A5HFtXqmGwrzOgR+2yx0dT3eJ/z9qrIAMG3UGvOnMzNrb7oh1+DVM2DfOLNobUc70uzZ6px
	LJk7FynwpS0Ys1EenjItqG86twRAM7
X-Google-Smtp-Source: AGHT+IHO+t3FoXc2lmkwuUhyA4zyPzNY8ffbVGOeuhpveHqkdWRdaJHtFzSS0tkKwjisgxNuxB9PgA==
X-Received: by 2002:a05:600c:8185:b0:475:da13:2566 with SMTP id 5b1f17b1804b1-477308a690dmr149519255e9.35.1762257596943;
        Tue, 04 Nov 2025 03:59:56 -0800 (PST)
Received: from Ansuel-XPS. (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm4509841f8f.3.2025.11.04.03.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:59:56 -0800 (PST)
Message-ID: <6909eabc.050a0220.54944.cd03@mx.google.com>
X-Google-Original-Message-ID: <aQnqugwQrqL0WHRU@Ansuel-XPS.>
Date: Tue, 4 Nov 2025 12:59:54 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cpufreq: qcom-nvmem: add compatible fallback for
 ipq806x for no SMEM
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
 <20251031130835.7953-4-ansuelsmth@gmail.com>
 <qael7opoqary2n5iqefxxp42v3qoudfhfvcgjyxfe3t7353zge@ahgvniscxl7v>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qael7opoqary2n5iqefxxp42v3qoudfhfvcgjyxfe3t7353zge@ahgvniscxl7v>

On Sat, Nov 01, 2025 at 12:42:55PM -0500, Bjorn Andersson wrote:
> On Fri, Oct 31, 2025 at 02:08:34PM +0100, Christian Marangi wrote:
> > On some IPQ806x SoC SMEM might be not initialized by SBL. This is the
> > case for some Google devices (the OnHub family) that can't make use of
> > SMEM to detect the SoC ID.
> > 
> > To handle these specific case, check if the SMEM is not initialized (by
> > checking if the qcom_smem_get_soc_id returns -ENODEV) and fallback to
> > OF machine compatible checking to identify the SoC variant.
> > 
> > Notice that the checking order is important as the machine compatible
> > are normally defined with the specific one following the generic SoC
> > (for example compatible = "qcom,ipq8065", "qcom,ipq8064").
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> And as mentioned in v1, this (cpufreq) patch can be merged independently
> of the first two patches. So please merge it through the cpufreq tree.
> 

I will send a new revision just for this patch so I can use
of_match_node()

Should be ok since it hasn't been picked right?

> 
> > ---
> >  drivers/cpufreq/qcom-cpufreq-nvmem.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index 3a8ed723a23e..5a9bd780a4f3 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -257,8 +257,8 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> >  					     char **pvs_name,
> >  					     struct qcom_cpufreq_drv *drv)
> >  {
> > +	int msm_id = -1, ret = 0;
> >  	int speed = 0, pvs = 0;
> > -	int msm_id, ret = 0;
> >  	u8 *speedbin;
> >  	size_t len;
> >  
> > @@ -275,8 +275,21 @@ static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> >  	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
> >  
> >  	ret = qcom_smem_get_soc_id(&msm_id);
> > -	if (ret)
> > +	if (ret == -ENODEV) {
> > +		/* Fallback to compatible match with no SMEM initialized */
> > +		ret = 0;
> > +		if (of_machine_is_compatible("qcom,ipq8062"))
> > +			msm_id = QCOM_ID_IPQ8062;
> > +		else if (of_machine_is_compatible("qcom,ipq8065") ||
> > +			 of_machine_is_compatible("qcom,ipq8069"))
> > +			msm_id = QCOM_ID_IPQ8065;
> > +		else if (of_machine_is_compatible("qcom,ipq8064") ||
> > +			 of_machine_is_compatible("qcom,ipq8066") ||
> > +			 of_machine_is_compatible("qcom,ipq8068"))
> > +			msm_id = QCOM_ID_IPQ8064;
> > +	} else if (ret) {
> >  		goto exit;
> > +	}
> >  
> >  	switch (msm_id) {
> >  	case QCOM_ID_IPQ8062:
> > -- 
> > 2.51.0
> > 

-- 
	Ansuel

