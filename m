Return-Path: <linux-pm+bounces-34657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E3BB5753A
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 11:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B031188BE8B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 09:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA12FABE8;
	Mon, 15 Sep 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4LuR0YO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1EF2C3257
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929718; cv=none; b=d/WqR6Iy3S31Yq/5JNImSRWIghyeuAZh6/uVp+ggtAV6og0OrVnUGDTruo5plGwtoYMJPy964DD7c5gpYyGlSPVsdFgoHOWNhx2P3iqRJfGBrqjlFNOytuxc6ffHdpi4iTGXDVRax5G4mcqOK8oLfz9hlEzi3e7ZTCzIUWKDZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929718; c=relaxed/simple;
	bh=/LYSOpOOPqvNcXEEZn5XwCOqw0wWb07v6/+f7MdgBos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCji6fHi8sExSL6k8Gn5c0LmLprLmh6DolI2DMzLeKE+LAMbYGTFUtJJQ295Tz3v69dqY5oZP30Tv7PCtsTxyNIhTjx12msz9lf9rauO3bZoteILc5YnVWkfmpAI8LJZVLvRKtqVM89oDyPNiVaDiTHqkpGGHzzCs5ms/9M3d+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4LuR0YO; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so7574276a12.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757929713; x=1758534513; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fGusVWyXCqe6ZR64zsDRe9g6dv6szqe6e9/gXZqBwGw=;
        b=f4LuR0YO7vpmUv708BOaG0ruD191kjv3oOC9g7Zqr+w7AOuwrbBhxohMys+MjIP9ok
         TRfGr/sOvanku/o7em1flBmtgpfoWNqY5sOTy/dNVapCsu0Hr+Ph0LNh7gJJaNa9Xrzk
         ZM5ioFO1kl/auUYaJGV+l+KJHl7Ost1cozUJnHhRcpSwUIQsdLZbtRH/4H70BFq4oWff
         v7u6RJen4atF8wIz/Yh1UIoKXARzT+xZ/dEfZfTv1QNbeweavsFqjhBV4r6KuLO2VaFl
         iunXrMgXAzFQ+wqnabUsHL4w0oynz0tfEEaoEF99131Gmh913EGkHjRknykKVWErJ7xW
         3Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757929713; x=1758534513;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGusVWyXCqe6ZR64zsDRe9g6dv6szqe6e9/gXZqBwGw=;
        b=OnvTbko0maYn84W2yp5AT2ecsQVIlvoj5HWRfW2P1db2jyCtVOSVKofa9JH+l0Af9j
         8/bhgEIsDfdl+Y0t5t4hJ4L5VNt9/Wgrs7X5lVXXL4NhuHxVh7tQD0xiD36ItqAuq2OM
         AYRa5/q5XS/Y7A5IrSgpNcuLhIVnzEA5lX+lo7h55NZLdsOzIRWTKjfY/hiXH92J1FtD
         647fRAahhuEA0yIJMUqIPSegdM3f/3GObrQoSexBPDMKMvjseA4Y3WAiCDfIhNKiMpQk
         vEk+dZLMat2XkN4rov5CR/vhrlAu0fYGMfAobhOVekICshtlqPOvt6t/psj/D2UBlkxR
         NdEw==
X-Forwarded-Encrypted: i=1; AJvYcCUdeYVIWyTAm0z1wYcyWYS09+CCXiciarr11E2+lIyPYGC2k/zrYQrntGdwGqz2Br7pFI2plPIN4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ15qbWr+TLB7/NQCFQiKBs+jwMiCXAmogz4ddEx0G1yTpvjAJ
	wkLklimi9x8UrvLJGLAlYwfI3RGWmia2hdNBlHjmQ7XdKjvGCeKgg9XnY1NE1OWwjOQ=
X-Gm-Gg: ASbGncuXZZhhirfeArzJTFtcBs6rOX9LYHljL8OP6gFfoshqJI03yO5AkgiaUFUbhbM
	/Nu8FRAWiCbblAbq5a+KZMefjz0kvUOUQSvx41ZNKCOfJtvQDeKg6XhzT1TMF3JOJO/il6KsIrx
	z1b7yMvXOSTqNHfEtiuH33RJmOoB7e5lyFvKl/N+cqkKtXvAY6lBUbvvvBt/bCA2ZOVvhPWHzZs
	0AilxZcz51MCx/Uo7Gaqi9ZZAhWF6Koo9iHdajbQwT8isN6E3LH4t6TJ7RTloPWL3kDhe07ehuz
	w/Ve7xMvayuzsQLdwh+mHVaGrEV0leL1jPenaewnbA7Ys62lnf1TctVm20NY6aDpj68vZH4OCmA
	BbAzIET47C5RYOPdFu+xPMAGjtRDHWxGKPCjjSE1yX7o=
X-Google-Smtp-Source: AGHT+IF+NlznyOGggwQj3KyFsitg1+o/PgvLt2K+8mej1rfCe1KkaHTdY/LMOod7hUMEDatMyfUGkw==
X-Received: by 2002:a17:907:3c8e:b0:b04:6412:95ec with SMTP id a640c23a62f3a-b07c3554da5mr1217317266b.10.1757929713359;
        Mon, 15 Sep 2025 02:48:33 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:ab20:75dc:ab3e:bbb9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b3333e81sm915322866b.94.2025.09.15.02.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:48:32 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:48:28 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
	David Collins <david.collins@oss.qualcomm.com>,
	=?iso-8859-1?Q?Gy=F6rgy?= Kurucz <me@kuruczgy.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
	devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/8] power: supply: qcom_battmgr: update compats for
 SM8550 and X1E80100
Message-ID: <aMfg7O2qmpKCiq18@linaro.org>
References: <20250915-qcom_battmgr_update-v4-0-6f6464a41afe@oss.qualcomm.com>
 <20250915-qcom_battmgr_update-v4-5-6f6464a41afe@oss.qualcomm.com>
 <aMfWKobwM5bhJEAd@linaro.org>
 <3559cbe4-b2e2-42d4-85ad-554258fc9dec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3559cbe4-b2e2-42d4-85ad-554258fc9dec@oss.qualcomm.com>

On Mon, Sep 15, 2025 at 05:44:40PM +0800, Fenglin Wu wrote:
> 
> On 9/15/2025 5:02 PM, Stephan Gerhold wrote:
> > On Mon, Sep 15, 2025 at 04:49:57PM +0800, Fenglin Wu via B4 Relay wrote:
> > > From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > > 
> > > Add variant definitions for SM8550 and X1E80100 platforms. Add a compat
> > > for SM8550 and update match data for X1E80100 specifically so that they
> > > could be handled differently in supporting charge control functionality.
> > > 
> > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Thinkpad T14S OLED
> > > Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> > > ---
> > >   drivers/power/supply/qcom_battmgr.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> > > index 008e241e3eac3574a78459a2256e006e48c9f508..174d3f83ac2b070bb90c21a498686e91cc629ebe 100644
> > > --- a/drivers/power/supply/qcom_battmgr.c
> > > +++ b/drivers/power/supply/qcom_battmgr.c
> > > @@ -19,8 +19,10 @@
> > >   #define BATTMGR_STRING_LEN	128
> > >   enum qcom_battmgr_variant {
> > > -	QCOM_BATTMGR_SM8350,
> > >   	QCOM_BATTMGR_SC8280XP,
> > > +	QCOM_BATTMGR_SM8350,
> > > +	QCOM_BATTMGR_SM8550,
> > > +	QCOM_BATTMGR_X1E80100,
> > >   };
> > >   #define BATTMGR_BAT_STATUS		0x1
> > > @@ -1333,7 +1335,8 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
> > >   static const struct of_device_id qcom_battmgr_of_variants[] = {
> > >   	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> > >   	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> > > -	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> > > +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)QCOM_BATTMGR_SM8550 },
> > > +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_X1E80100 },
> > >   	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
> > >   	{}
> > >   };
> > I think you need to squash this with "[PATCH 7/8] power: supply:
> > qcom_battmgr: Add charge control support", or move the modified checks
> > for
> > 
> > 	if (battmgr->variant == QCOM_BATTMGR_SC8280XP ||
> > 	    battmgr->variant == QCOM_BATTMGR_X1E80100) {
> > 
> > into this patch.
> > 
> > With this patch right now, I would expect that your series is not
> > bisectable: The wrong code paths are chosen if you only apply this patch
> > because e.g. X1E doesn't use the QCOM_BATTMGR_SC8280XP code anymore.
> > 
> > Thanks,
> > Stephan
> 
> I see.
> 
> I was making it this way to address the review comment from Bryan in patch
> v2 about separating the compats change. See here:
> https://lore.kernel.org/all/7f001134-e099-492d-8ce5-4122d83a3de3@linaro.org/
> 
> If I revise it according to your 2nd suggestion, would it conflict with
> Bryan's feedback?
> 

I would expect that Bryan had my second suggestion in mind - separating
the refactoring (without functional change) from the new feature
addition.

You need to add the new cases to the if statements in this patch, or you
will (temporarily) change and break functionality.

Thanks,
Stephan

