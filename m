Return-Path: <linux-pm+bounces-22809-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D295A42202
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3C03A4EDE
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B424887B;
	Mon, 24 Feb 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GymbdWTY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F780157A48
	for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 13:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404737; cv=none; b=F6IXnSVhAwqgRgln9yU7Ah33jAjP1MNYPLOBfrHu2EgII8AB+qJx9xWuHVY4S70zsWGiJuMpj9FYl08b49Eq0cPvJdj2oyTdv6N/sMTErlD3otYQBuS+M3uPXbPpvYhd720h9GBU2V38r7zbkkjPi3wJE3tcx0E8Xa3t2KEWMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404737; c=relaxed/simple;
	bh=YxFGfTzbpsU2Ndkj72fW5M98h/iyMTLKmwsYCZh39AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAimaYYJSq4UTNx1YzeZae+UccpqNU5XxaSwFSGvAP7v1IR//ILKtGCeQX47NK+712GNWDuvOdwxCOfIVd//Rs1p/ob/1dHUp0g8XuhF9prdB0wKR1GHuywWlPohy58G2zKkuNOYtJe3am5TIGydDwINt67R8KmvYifHeTGdnlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GymbdWTY; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54622940ef7so5051428e87.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Feb 2025 05:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740404734; x=1741009534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQtxIikjRYVU2YE1FfJsa2nPhFSgRqTZXI/yYof9sW8=;
        b=GymbdWTYsed/RydxRDc9aOdFhthWOBvWn+l0gJyIVc1Q45R3CyPuxj1Ir130IysQcN
         PwgLsuya/GkJfUu0PMIczUqPmVgR8N+Jk5UE1SbcaYXKxMtUCNVlToRKV0Yw0ZKr1g9G
         A7YhtjcjARi76uP9QYmZxe3akXY3bGjD2ZJkTt1x24b8Ld0xW49NPevgNnJpF4qnGR65
         pcFgTFAqz9KaIl/xwf32OJkhGQ00Uoi86alN3kddllPC4YUXygyOMJInNyfu3Qg8qhqJ
         8jPpc9dnB43AD5zZzP7edF7yEqCW2p3b6ACuVRtXVP3b01pMboaARIilGo+L/qTuB7EH
         vdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740404734; x=1741009534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQtxIikjRYVU2YE1FfJsa2nPhFSgRqTZXI/yYof9sW8=;
        b=ujEmoA8ld/D+3dEz8BuTtRtMQuvbWHflaUIvT6TO8xMNFfHRP9YLnvwCdjVwYqGyMT
         sAjrjKyuPoDL8qkqJe/Z7olVtS3slenXeKvORDM6YaFCCiKXkCQKKE6UAWmtONDlTElp
         oee6aVF4lajqZdXpkQBmnZVFXRW9V+9B12P6EyrJ7CdjUYMXhp8RkIOMCqV6L5c3R3MX
         P4nMIePLYHkGzDxqjjuLMGq8ilZMcjcJ+gpE52Rq/eLM7KQpwuTJkcbORA62T625qUh2
         luwoHv/IaOoT0jYinKiyAx86icMXyiZXIUrxak7LJRQ2Ac9gwCEFAsWROqehPoFBZph3
         RjoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqcumYsAG8x++I0EiPs1fs2z2Fsvpt5GBfhs9Ab0JU/PUTTH6F6RVvV/5/7Aam1eE4gotTIhEG9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxM2E9sfm/kt1YHlDZ8uTBClz2aXfsTsm7CLnxqPTn2ynEeJPyY
	nPR02CAvvp/ew5NlRVCwGsdmPkBAH+CS7W1p9PT2kTJViyovP7BnpfcyKGdc1dA=
X-Gm-Gg: ASbGncsgy/qUbN+gVnk5T3NXlxfkPOAAoF0E0zDIKlgJBuGjihuz0OmtBylwkbfKDuG
	ZEPzfUkJFbFlo/GbcDeUzcUuq3kKLHga4CxbfuqOqi9CKUqK3HGzeZiNkNo3WAfofrKQ1oDYtbp
	gFc3jKf6l/V+otcxpKsjY5I5SDnpGr7Mmwa4QaXOM2IaxjyRHnG+KRXdRf3cVHqjKkaTEMNepqF
	JY7bqTBQEOIKwK1LbGAw4EbDQ7lIxLg0YowXY7CvkYxAI6me2b8pgUfCUarw+gy4zrJqBXTgaKb
	JuhOj35HpVmhdczjw5muDlYBBqQky1jKLBpwjH21B8NHjdEPNJwiaTVBPdIVld6PoOuTGn0pbMV
	OfLJC5w==
X-Google-Smtp-Source: AGHT+IEOHs/ggD9ekbq8Mt/oGjuToBiu/aq901Ne4MqUwh5GjjUsqmuKg0uvV17mLepWLhRrNwcWHw==
X-Received: by 2002:a05:6512:3ca5:b0:545:381:70a with SMTP id 2adb3069b0e04-54838ee8ae6mr5302777e87.15.1740404733603;
        Mon, 24 Feb 2025 05:45:33 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452eda31acsm2966821e87.119.2025.02.24.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 05:45:32 -0800 (PST)
Date: Mon, 24 Feb 2025 15:45:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: George Moussalem <george.moussalem@outlook.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	amitk@kernel.org, thara.gopinath@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	quic_srichara@quicinc.com
Subject: Re: [PATCH v6 3/5] thermal: drivers: qcom: Add new feat for soc
 without rpm
Message-ID: <n7twid3k2ykwjviidngxnl3tdy27uxx6uhfh6hj2tpztufagwn@6zd7vre6dnqt>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
 <DS7PR19MB88837D7AE30CE306B8F71F3E9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
 <be872be1-dd0a-481b-abe0-57ed2bf50c22@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be872be1-dd0a-481b-abe0-57ed2bf50c22@quicinc.com>

On Mon, Feb 24, 2025 at 02:38:24PM +0530, Manikanta Mylavarapu wrote:
> 
> 
> On 2/24/2025 11:42 AM, George Moussalem wrote:
> > From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > 
> > In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
> > enable tsens would not be done. So add a flag for that in feat
> > and skip enable checks. Without this, tsens probe fails.
> > 
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> > Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> > ---
> >  drivers/thermal/qcom/tsens.c | 2 +-
> >  drivers/thermal/qcom/tsens.h | 3 +++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 3aa3736181aa..a25ca17adf1a 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
> >  	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
> >  	if (ret)
> >  		goto err_put_device;
> > -	if (!enabled) {
> > +	if (!enabled && !(priv->feat->ignore_enable)) {
> 
> Please drop 'ignore_enable' and use 'VER_2_X_NO_RPM' instead.

It is not possible, since IPQ5018 is 1.x. But I agree, a similar concept
should be used.

> 
> >  		dev_err(dev, "%s: device not enabled\n", __func__);
> >  		ret = -ENODEV;
> >  		goto err_put_device;

-- 
With best wishes
Dmitry

