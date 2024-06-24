Return-Path: <linux-pm+bounces-9879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCFF91441F
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CA62836B7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4A49636;
	Mon, 24 Jun 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yirp48Dc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BC5482DD
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216160; cv=none; b=vF5TRMuIRot5oyClzvkT9anQBUBE/JTDvgdcGQr5b/5hSUyFF8MlO9XQs5sTQPSoEWnKy0E2pvfRDWGyYsQ14wTgmFXDmNG2kw5wxEkZaDCjeTS2BQZnH+oGXRWEboHRL9+a3kSBAoNMQH0v52BwlFFm+VN1Nn7VOmq2H/Es01M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216160; c=relaxed/simple;
	bh=G5Qn//KYJurhujRB11lPeB8e+EIAyHg7xty7HjrrFDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjOrZhHwGyJ87nLWHKmvbwRmLyRiOqfYpZgGZGGFpvLbgMLkPOhQFhInYHCC6ouxYkVu9i4yXIr16Af2n5Y+huz65uM039AJg0e01gKf0WsVLvky9wCEEXXAxdZ68RC9Bqe9+nZDjcPCg1benS4tCPIMThtuTZi0x4j35pFF4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yirp48Dc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cd80e55efso4286675e87.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719216157; x=1719820957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmUODOqAFhfu/TumPgiUij2c8ZErNXIfL1HAYn6wNUQ=;
        b=Yirp48DcwotwFBZnapV0dbXOhIx4EeObQr5BiFCnvOJhHDgtvZNsi01jpwtYnw1eIc
         byDOjlIINAfpMs2Bm2nGMxjnHQvMhfmAcMM1FAkplIV/Ex9U+9hI0gxjegjA04oOizfC
         fE1cOLtKHL9SPtr8fnh74cJITt43bO9WFq/cgahcrR8NT4Cv+G2hUioLg/ygZSgwfx8+
         E/qpV2ErHPH1HZHuE5ylwgoYUP907iR8Zof6xAuJztttze2R94d/Yu5RfYKTDn2YfJPg
         f61IO6behS/MaqOoPlmy5trN/vyqXlAwhn7lo1Y9fFLb/sqhYs53EsRkKr7ooMrZBYXb
         nI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216157; x=1719820957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmUODOqAFhfu/TumPgiUij2c8ZErNXIfL1HAYn6wNUQ=;
        b=OxBnH0Kxn6r9xmfynbtc2uC9ak9JbI8WwGT/riRRoQgqwUjLpwl14i92dcK5yzOwOe
         RvxHfSoftf5d/xKukK9ceQgakFTEyYnByFp6YkPdYh8jJt6wpoNXHZYakX1yrCYKA9gx
         eRpd4FKYykDBTASYaTLPsHf2UZI7TMmFxESBwmOOhzhtaRYSwjjyCFok89Kgcr/m0Gii
         C/0jFsVNa0YgykTJNSKCiJ86pn/S12C8DE+YyqGanZRyQ7nxhOZTAkGjiNi7z7uOih4K
         tzQKUP0o/4uF38/UKOccdyrTQ6F35WYE9TS8gct/y1TXC0kYH6QsF7pTUmJyli3VUvT7
         F/KA==
X-Forwarded-Encrypted: i=1; AJvYcCW9bO/sfIU+4l0p5nL2HqFvMt3yf9cZLHgLj11zG9tfPZdpWOqXxpZ9Ed1Mtzia3BL/XSk6KkVTUy6vYnxoPtmTSvLgO2QlrLM=
X-Gm-Message-State: AOJu0YzUkc0HcQ7zifD4fBuAGD65KasY+ZQvzKW/zx2wJdrtbYQ7BhBI
	maGY4yDugmyvkGiSWHmLwotx+n/3euhFnO/JxPfsVohg1E+v0dj2Yrma/UWDU+A=
X-Google-Smtp-Source: AGHT+IHkDR7XBX6FoBLurUZw+DeDGbXBvdgJUBU72fiBcGOXOwufGii4v3W5X9cULdPxdwBw73ZBfw==
X-Received: by 2002:a05:6512:158f:b0:52c:e091:66e4 with SMTP id 2adb3069b0e04-52ce18523ecmr3410756e87.44.1719216157179;
        Mon, 24 Jun 2024 01:02:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63bcef1sm920765e87.72.2024.06.24.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:02:36 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:02:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	abel.vesa@linaro.org, otto.pflueger@abscue.de, quic_rohiagar@quicinc.com, 
	luca@z3ntu.xyz, quic_ipkumar@quicinc.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Enable CPR for IPQ9574
Message-ID: <ncfhv75xjnuz4bdkhzqmiqrg3khez57bwcvrhp6unmwxrlol7o@etkokfnjuuru>
References: <20240624050254.2942959-1-quic_varada@quicinc.com>
 <5xgjszacvtnjftygwvtonb4npspaceutnvnnniebxntii4tmud@xag2c6j2svqa>
 <ZnkXJWXI/mfP/vG+@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnkXJWXI/mfP/vG+@hu-varada-blr.qualcomm.com>

On Mon, Jun 24, 2024 at 12:20:13PM GMT, Varadarajan Narayanan wrote:
> On Mon, Jun 24, 2024 at 08:39:55AM +0300, Dmitry Baryshkov wrote:
> > On Mon, Jun 24, 2024 at 10:32:47AM GMT, Varadarajan Narayanan wrote:
> > > This series tries to enable CPR on IPQ9574, that implements
> > > CPRv4. Since [1] is older, faced few minor issues. Those are
> > > addressed in [2].
> > >
> > > dt_binding_check and dtbs_check passed.
> > >
> > > Depends:
> > > 	[1] https://lore.kernel.org/lkml/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org/T/
> > > 	[2] https://github.com/quic-varada/cpr/commits/konrad/
> >
> > Please include [2] into your patchset.
> 
> Did not include them because Konrad has agreed to post them this week.
> And, I don't have an MSM8998 target to test those changes.

At least CPRh-related patches should have been included, so that we
could review and comment them.

-- 
With best wishes
Dmitry

