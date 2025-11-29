Return-Path: <linux-pm+bounces-38910-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C9C93684
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ED93A9165
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62D1DE8BF;
	Sat, 29 Nov 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRZkYE7b"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B351C5D6A
	for <linux-pm@vger.kernel.org>; Sat, 29 Nov 2025 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764382131; cv=none; b=M6Smhl58n/Hr5Ecy+cAouJ2S8eV/H8L1FknpXYEC4e7yTzO2mZw6HXZjUrLs/poTQM4bfQITkqRzsjFxpFtj5VhL8g6fG7+xpbC0Rm4Op3x6cd/dvn9E+wKHoRW50e43a0gy271yjvuKHy8CAZYdkp9YQPpYHxjOyLaPbp07c7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764382131; c=relaxed/simple;
	bh=oBxJ2w2VOtO0+57VyHYW6cgGEruyJXK9Hau4rzbWm/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFBeAKuLPk7SM0TrNVIJD03kYf7Na7EMeNmi38wygZOxX2Nb6rQF6sL23pclqQJZfLfYAAKJ7d9i7PQiX8gnK+nD9PgRTwuOAJ1sbcJzaYYke+RzNtkkT+jyebADUw5+Fm4+DM15G3yyymkb5cFda1xBcTTvwNTQFeTE/SB6GMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRZkYE7b; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4ee2014c228so19506721cf.2
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2025 18:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764382126; x=1764986926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w4Vai8cPq+jOaSoz/hxjTO+wFvCmSXVlGUIKlR54toc=;
        b=eRZkYE7binmHN8pBX3Gk019b9BrFLrbfz8viYkGayY4ukhe7lAy7bfAOj51SFIPvyM
         Wulan5PXWbXTwNr8ywCgZpBlMupJ2gHEa78npI9b7ttw1linYOJ5akrgZNBNeKIsWAvw
         MOjN7X1M6fMpE331WfeztmFEO3jD5gs31jINPthRg9rGjCrh32LwcuCoXKKJ5pWPVUNU
         YP+GwxsTWuer48GZLKbnV0HNUclWtreVNUynnS8uPJUDnSd3daOrz0/dngtpeeGvf2rF
         vt2OVOAudXW58VHzdfUXs9z7Q6JLw3UQJzb2M3sGy4nu8QP7HklaxQD071JJknto9JgS
         92HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764382126; x=1764986926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4Vai8cPq+jOaSoz/hxjTO+wFvCmSXVlGUIKlR54toc=;
        b=hjHVia8LFtFfboZPHnB+Kbk8aVWotsKRjLWZWtWn8qAF4KHqseMntzo2xnoKfHGAFx
         hky1l8ojUy1DbC4z9dmzrursFEHJ0o7W6wBkGCpK9Fz5QxLCY69LQBU3mfnIMpA7pJEV
         5fc7dUdOHfBIqXrziCKE8A+ExuSbiGXdcbBPzNaB7XEv3Z1JJK1OTP+5F7ulp/3xw7f4
         5NjsRaDUWdvw+x71AqOBAaBQ5BwfrXFnGWtaT51VQZnASnYFnh+96xZnW6q0R2MAibmo
         S9zZW1Ccp7LFNrC+uGuR4jki0Isjz5b1PLK8Tp0JpjVMweY6k0g+DuubzKr3k4qqEyq6
         hVOA==
X-Forwarded-Encrypted: i=1; AJvYcCX5Q4ff2rm92RRJg7rtrU0mFamqb7y0HqdT4L3+PvU3cCJ/Ww+xN12bC6D0y0nZHfaqAycGvYYY4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8tXjwEfKfvHdUBMI0bYdp8ZtYNfHAM+JE5x4tyrXmxIRH9Fk
	L7q630mGqaMbtcx3KYqF2aMXRC/19zIDN3Gb6BaArtshLZErKJaENAYw
X-Gm-Gg: ASbGncugq1+CpbMDZjlCsRcVLL8Tw+IurzieUloNnSD0gEIFy9JtNl+m8BL9kcsYy1X
	WNTk8JWccUyW6cZoBhXgvCyDJJkLmdfCaheiRCRquUAgH18dmRjhMdt/mokb4gb1xtw3O8ZyZdz
	ZrL6jntENdy8n6y+vtsuoI80giHy3/Atb4JFRIJOh64OPc8deO0RP6lNZxDFZowI3pjvrAFEc7O
	AbQBducKey3A3sqdA7F5fg4eQ00Xwvwe8PHdJvs88tMjmowIlVQYCLsW/7pBoPnKSe/7MkqWyE1
	OtqLLsFfoo/5jlrAPCbLQ5GrYXSSOmxyXughzNNHRyUxOyjuneJPGTCkgsm6th8ieXaimONA6ms
	yR7NmJWP733chRHX8oQJqqvnlcTI5WnePexuaIq6e9MjcXO0smTTr0oEt/pactHCD6T/af7g5ur
	6S4LKVpMl/lQDt2OvpZkT4QTtzNh+mzgRrRV8Ia5blR5uy6cCtU3g/uh+hZIz2nI4QOaNh/oLDo
	1I=
X-Google-Smtp-Source: AGHT+IEZgPEjTcttOVwQuI2zaiEzMLw7Nq+/ixHEvgh4ba7Mmdm+GtjXkVRK7MvkYpKdURpuWdRJtg==
X-Received: by 2002:a05:622a:256:b0:4ee:1527:cae0 with SMTP id d75a77b69052e-4efbd715e29mr244377011cf.0.1764382126117;
        Fri, 28 Nov 2025 18:08:46 -0800 (PST)
Received: from localhost (bras-base-toroon21-grc-75-184-144-58-243.dsl.bell.ca. [184.144.58.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4efd2fbfa6csm35209561cf.11.2025.11.28.18.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 18:08:45 -0800 (PST)
Date: Fri, 28 Nov 2025 21:09:03 -0500
From: Richard Acayan <mailingradian@gmail.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: david@ixit.cz, Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Casey Connolly <casey@connolly.tech>,
	Joel Selvaraj <foss@joelselvaraj.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Alexander Martinz <amartinz@shiftphones.com>,
	=?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
	Alexey Minnekhanov <alexeymin@postmarketos.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] arm64: dts: qcom: pmi8998: Add fuel gauge
Message-ID: <aSpVv_a6uRhr8opu@rdacayan>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz>
 <20251124-pmi8998_fuel_gauge-v1-3-dd3791f61478@ixit.cz>
 <a9ba3370-ddff-4b69-b2b9-9244f759b6f0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ba3370-ddff-4b69-b2b9-9244f759b6f0@linaro.org>

On Thu, Nov 27, 2025 at 06:53:38PM +0100, Casey Connolly wrote:
> On 24/11/2025 22:53, David Heidelberg via B4 Relay wrote:
> > From: Casey Connolly <casey.connolly@linaro.org>
> > 
> > Introduce the fuel gauge node for pmi8998.
> > 
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> > index cd3f0790fd420..ab3bc66502657 100644
> > --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> > @@ -44,6 +44,17 @@ pmi8998_rradc: adc@4500 {
> >  			reg = <0x4500>;
> >  			#io-channel-cells = <1>;
> >  		};
> > +
> > +		pmi8998_fg: fuel-gauge@4000 {
> > +			compatible = "qcom,pmi8998-fg";
> > +			reg = <0x4000>;
> > +
> > +			interrupts = <0x2 0x40 0x3 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names = "soc-delta";
> 
> I think it makes sense to add all the interrupts here, even if thr
> driver only uses one of them currently.
> 
> 			interrupts = <0x2 0x40 0x0 IRQ_TYPE_EDGE_BOTH>,
> 				     <0x2 0x40 0x1 IRQ_TYPE_EDGE_BOTH>,
> 				     <0x2 0x40 0x2 IRQ_TYPE_EDGE_RISING>,
> 				     <0x2 0x40 0x3 IRQ_TYPE_EDGE_RISING>,
> 				     <0x2 0x40 0x4 IRQ_TYPE_EDGE_BOTH>,
> 				     <0x2 0x40 0x5 IRQ_TYPE_EDGE_RISING>,
> 				     <0x2 0x40 0x6 IRQ_TYPE_EDGE_BOTH>,
> 				     <0x2 0x40 0x7 IRQ_TYPE_EDGE_BOTH>;
> 			interrupt-names = "soc-update",
> 					  "soc-ready",
> 					  "bsoc-delta",
> 					  "msoc-delta",
> 					  "msoc-low",
> 					  "msoc-empty",
> 					  "msoc-high",
> 					  "msoc-full";
> 
> https://github.com/LineageOS/android_kernel_oneplus_sdm845/blob/lineage-22.2/arch/arm64/boot/dts/qcom/pmi8998.dtsi#L292
> 
> Not sure what the difference is between bsoc-delta and msoc-delta, maybe
> Richard or Yassine can recall? DT bindings would need updating too.

Well I don't remember, but the downstream kernel seems to reference bsoc
as battery SOC and msoc (used for the battery percentage) as
monotonic SOC. Maybe msoc is based on bsoc and scaled based on battery
health, but that's just from skimming the downstream driver.

