Return-Path: <linux-pm+bounces-3251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D37847575
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 17:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2DB71C2152B
	for <lists+linux-pm@lfdr.de>; Fri,  2 Feb 2024 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B711487E4;
	Fri,  2 Feb 2024 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUpUeVEn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC51468E7
	for <linux-pm@vger.kernel.org>; Fri,  2 Feb 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893062; cv=none; b=qMfNgeZ5ss0aHix7Ud/n73JtvU/XET8MSkpRKMWbuS0rp2+DbzJZ8ZaijA8Xzss/hxqz5lahEmTRxjKEQtqh79QstYAnLOsunKKaByZ1Zvit0VqR289SSnv7NhEHqg9ivpw8MekpNOgK/4uQRjza+GaSi2zHWjvOg4frO1Dw6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893062; c=relaxed/simple;
	bh=BTsigi4db6wzD2KxV1kjIqZyumwhMxK2PLRCX71n8lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuTVs2UwYoPiP4Lw+iEDFF3Iu7TFK8SFwz8MQxZrwycbb/zqjwGYE7EREYkIhpSLan745yGLxmjH3f74hOOavppB1Hchqpnjlx+CCVojjF0U0a+4/+lJZtiECST8Se8VCe8Q6omie9LYI8BtyfPMbforp/2YnyaoaryzoRr5Y/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUpUeVEn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so288523366b.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Feb 2024 08:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706893059; x=1707497859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOMmKU2ojRpucv2LvIq5EXqCC2JsZUhlB+SBvo1nc0g=;
        b=iUpUeVEn1HbE1Sc9LDcHFgMLAzT0Isyx3//JSbFBrfOKOmj+LxUBfvq3UbimJFeUNK
         FBuFukXs9YTWlFYgXNkx2dPV72ICo7hZ6VEWaEQVMDkEMPdsqnY5CeEGkgmGviIuMu/t
         BGSMRoUTsD1lcMnqorCJve2GV9eIuE6CaI3hR34msw8fT3NHbH93BfmqZ0sic9fD+Acx
         0brvc1nnBaL3/1StzXlF5wBxZn255kwS5pXccu02KMli164TOs5z2Ng3yl+Br3eVQvCP
         uRpYz4Y5q3zgE25jZXq9FFx33D0oIUqO9MkpOqTOFZI5fiIrGKXPTTBlszqZBy0CWr/A
         mGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893059; x=1707497859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOMmKU2ojRpucv2LvIq5EXqCC2JsZUhlB+SBvo1nc0g=;
        b=kVcuqN9TS9cPvqIKlARCbFVAgmLfgS/Cl74c60S5yMCD2KvZjHzHQYxK7GO/SvoptU
         HmEFfWyIWBpZH6nkfQ/zNkQyVvAiQ97JKKxXRGGZwIhhkp3Lv8AMtP2B3V0sjwdgwAjM
         DsDjXPDZ1LmUZDxAMOGlP7tWkPrGZKzqZVVfl49/jCqg/OnnWsqu3vp45Y+RhTrfdCMx
         dOv7BVkRjSWzWOcq5qhTL1YPZx1aVUv0hymTijHNCPpM/isW+6TFJVvqXb0Du19dnWhd
         GpmCUw+hmvDiZo0NyApb62yYmJGyoP68iAkiJy/h+EjoBF0tBBeHN/QmXONgujUQEMbV
         qkyQ==
X-Gm-Message-State: AOJu0Yx+qLZhaXJ1olG/SoeGMeTVchAgD4IBH9tB41dnXnWCbk1nG0eU
	5iFfavSvu/Vnku3jVRHRgLJN9gb/NOPmlAJsd6x164Vr7nCCtxBmpEev/e0yqbU=
X-Google-Smtp-Source: AGHT+IGrVNwLvQ7Qd2H25HKvVgps2pgoVubc0Ao0qrH4dAW2aOxdnQVXdvSLRHFLk6kH2p2hCaFBMw==
X-Received: by 2002:a17:906:6857:b0:a35:5b6:1e0f with SMTP id a23-20020a170906685700b00a3505b61e0fmr6339017ejs.71.1706893059324;
        Fri, 02 Feb 2024 08:57:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVfrK/V22UF7mLDeAOiCdHIwfUXdKosWBUWCt4q+cZHOIa01WXuHFSjk5yfqdMDUcYBUOWGKOE2WHaIF/jq4KG7QamhuYr+SKJuThfrjl6ScPNl4eHX8O4kGwHwxCFgnArSyQLOMWG+rAtyWhEVWyOypIXREN2cTqjHRqxJbSZafEoO8yCh5mQxgmwNyy0RqhlwityX+YM7R46CPq1FIJLljgPbGJ+HyUh4erULI2RB2jlCdEBYsKjwjjNJiWAlWtwfDOdbZSDIpggWjeZ/ZDo+gs8RVK2k1HJJnqgd4lyj+jVvW8uyovOjoeHIJAvbMtWamA0sljEqkbEG+7Y+5LI=
Received: from linaro.org ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id tb11-20020a1709078b8b00b00a370d76b0b4sm734523ejc.71.2024.02.02.08.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:57:38 -0800 (PST)
Date: Fri, 2 Feb 2024 18:57:37 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
	neil.armstrong@linaro.org, quic_rjendra@quicinc.com,
	quic_sibis@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] interconnect: qcom: x1e80100: Add missing ACV
 enable_mask
Message-ID: <Zb0fASo+PsmAaXaS@linaro.org>
References: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
 <20240202014806.7876-3-quic_mdtipton@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202014806.7876-3-quic_mdtipton@quicinc.com>

On 24-02-01 17:48:06, Mike Tipton wrote:
> The ACV BCM is voted using bitmasks. Add the proper mask for this
> target.
> 
> Fixes: 9f196772841e ("interconnect: qcom: Add X1E80100 interconnect provider driver")
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>

Tested-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/interconnect/qcom/x1e80100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/interconnect/qcom/x1e80100.c b/drivers/interconnect/qcom/x1e80100.c
> index 5b2de9c3a1d6..281295a9a077 100644
> --- a/drivers/interconnect/qcom/x1e80100.c
> +++ b/drivers/interconnect/qcom/x1e80100.c
> @@ -1372,6 +1372,7 @@ static struct qcom_icc_node qns_aggre_usb_south_snoc = {
>  
>  static struct qcom_icc_bcm bcm_acv = {
>  	.name = "ACV",
> +	.enable_mask = BIT(3),
>  	.num_nodes = 1,
>  	.nodes = { &ebi },
>  };
> -- 
> 2.17.1
> 

