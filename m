Return-Path: <linux-pm+bounces-10069-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F907918E46
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 20:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC1A28CA12
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7493319066F;
	Wed, 26 Jun 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFnHDyoW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78E190489
	for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426203; cv=none; b=AWT9XO+SGDrxZ2onRoRB29Lqja41AoF6wbDZ7pMkAitb/8q9QHFaGFl3S0NNdxk+T9JigECIha4EBv077EpNRzRGiGel+UiivGmzhw3XJFgv7NDlPM0pJO4tz3JHSSi34rYbtHGFCAD5/VClu0IAda7nUej4yzjKA8NeeyE2Wuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426203; c=relaxed/simple;
	bh=+O9+3Tj5o1+8awe97/tVFlTIjZPsuMt7DNFJlAt9VHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPv6IkTOpQFM9+HInKxjjC69QGQi2A4on2K38nLrAeJusVRZw0xp60DwQDnk+zpRjCB613ZxNtdFh9+wBsjVNwNBbb1Y7v4SS3NF0UolEgUdin3zeYfKkCrBOdOzqH9XRNvS0DjSHli09BL4GDtNT8KivK7f4vuQxDlY7TwyvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RFnHDyoW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec59193468so7553291fa.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Jun 2024 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719426200; x=1720031000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9eJH6Q1RShlmHM1ZlQieGvydRc7/ZyO2tJLDZW0TZMA=;
        b=RFnHDyoWmTepmXhf3PPRlED/xXnC+Ib8BINctnr5fYZs7f2oSb/w3XZTQlItq39bd1
         KZUO3WQoaFuLAGcqUhfhd4Sv2uTMW0fLZ5wC0Tq0NYV6p3RYb49t6l0bY/3crm4jwnrB
         md6RyJWEzoNvrQu7g89N9aWEfF7/eZa5o8kNo9gMkB5wlXxc1KILKG/IoROlA4xgUwdr
         4PFtDybxIPgeClAsJXxqiIlU0aALX3QDoecshAYbP4TyXNZJsVsgzrq3/lryI1IPsECU
         AfCiTG1auF3id9a1gByU7b+Db9ntdlozD0jcr4ucMCecvM0+bb3Enu9tppzopBnrBhIe
         bsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426200; x=1720031000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eJH6Q1RShlmHM1ZlQieGvydRc7/ZyO2tJLDZW0TZMA=;
        b=GEDWuZ8b53N2QvhL8L2gaSfqBd8Czu5TrcgXe2KmAJoJHVtz6AaI5kAu1A0sq8NLGC
         Li1DkQziZihpSo1xxuaelcRfig0cOq8rlAz9mIjPtFeFvZp9CAlGD3dBgodapdPDXBal
         0XHxmhMKDxmkcPv0u5ahD0mboRAzjq7WbcLsGrVrq3JDKbj44XDl5WgeaJFP6BklM/XW
         kNUNbqsxp2+HdHkOeUpOaH79xHmTUIj66tFwGQgKW5Sldt0am5gGKXkQwX2FmlbvniPA
         zkFNFNsfT2miSR8WC025R+3/W4sHyedtd7hmertNsPzl1698e74LCgSea9rE5Xffcptz
         KHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuqSNUp8viuUaRyIkHfVpjhF7M6ZRW6w/g8jBg00DR6ka5pJl4s2qCzQ5KUSGkC1v4A4fFuarIcZAyP3LIhGmGX3TCZerUQjg=
X-Gm-Message-State: AOJu0YwbTKg54qg1rRIlB7s3VtMRJNtVyBBM+rCAS8YTzxFa9JDB+T16
	0jG2xYxugbVkb82oS93HS/6hOlPxqU+SPtapcW4gdq4YkRw9Q33GtI+QbVpbXBI=
X-Google-Smtp-Source: AGHT+IFXCqFuajLOraGQqNzbZlp4TTxQraecaBDsIDB6TAAsyKR8HxVaBp9DwXY5qUzkh+wVwAAMMQ==
X-Received: by 2002:a2e:81cc:0:b0:2ec:4deb:482f with SMTP id 38308e7fff4ca-2ee48040234mr1088621fa.8.1719426199846;
        Wed, 26 Jun 2024 11:23:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec53b7c876sm12791181fa.62.2024.06.26.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:23:19 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:23:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ilia.lin@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	otto.pflueger@abscue.de, neil.armstrong@linaro.org, luca@z3ntu.xyz, abel.vesa@linaro.org, 
	danila@jiaxyga.com, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/9] cpufreq: qcom-nvmem: Add genpd names to
 match_data_kryo
Message-ID: <za7t6ltttq2o5qwahfrzftsb7xfzbzdtg4zx3bvnf3fewhfeqf@vjrq7na5ioqm>
References: <20240626104002.420535-1-quic_varada@quicinc.com>
 <20240626104002.420535-3-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104002.420535-3-quic_varada@quicinc.com>

On Wed, Jun 26, 2024 at 04:09:55PM GMT, Varadarajan Narayanan wrote:
> This is used for tying up the cpu@N nodes with the power domains.
> Without this, 'cat /sys/kernel/debug/qcom_cpr3/thread0'
> crashes with NULL pointer access.

Add the interesting part of the backtrace, please.

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 939702dfa73f..5e6525c7788c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -399,6 +399,7 @@ static const char *generic_genpd_names[] = { "perf", NULL };
>  
>  static const struct qcom_cpufreq_match_data match_data_kryo = {
>  	.get_version = qcom_cpufreq_kryo_name_version,
> +	.genpd_names = generic_genpd_names,

This forces that every Kryo SoC has "perf" genpd, which obviously isn't
corret (at least from the upstream support point of view).

>  };
>  
>  static const struct qcom_cpufreq_match_data match_data_krait = {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

