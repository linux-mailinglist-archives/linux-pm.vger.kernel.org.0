Return-Path: <linux-pm+bounces-9794-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD99912F06
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 22:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B41C21047
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B2F17B518;
	Fri, 21 Jun 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Er+gBcbg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B501607B3
	for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003410; cv=none; b=blgNTMqgKGsIcaDganExtpdVUq1dSdfTcsySZqMj9Ndj/duFGMOnx08vHmHxhtTreQXpSRArvopAUWp9qnopDtAqWK3zWMHEwerZnoV3eIqqjgBZtGDqEZYs/oZLuVCib+FBLokWb71kiASggf9/Ay9/OhLzWmF1Ywaw95SdG6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003410; c=relaxed/simple;
	bh=5st63SI9GsmLxPdfiAGP6Hn4GJN1GJ3y8psezivCzq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjk7vZCsnO7+HQZ3RxjRovu/56wXsDP+VGt1mXMcWviQt9fbCqmEY9EXFMBlheWQBG2NcGhNzPgJRIQn4QJiuTPxQhVAZh2xyLz/+L1v6UvkD3QBqbSZU5sjuozDOz2MLOgOW4qzU6uRmcwQXRnw4YRQifXwj8e4xbRdp1rwHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Er+gBcbg; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so28948931fa.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Jun 2024 13:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719003407; x=1719608207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCXZHO5jGlp2bYUbK8OUm7s9KsnQfmaNZmifsjWFRsU=;
        b=Er+gBcbgvOAcPry2qbdN3mvo7njHiIdd6eV6V04cz/8BTivRnfDRnS3sUN7PuzuMFB
         YdJDAMhRqEX7u1Dp5cD8SWv2b2s+pLT6eCkRJZ3OaReV/tGdYOTKoH1sy9AcynIr2/RG
         Tbm18tYQVYKgzz+3hmd8xnhqLPf4uvma/Baga+r8BW1XOY+JDjxjnd2wTQKkhHC9BoOM
         C1sTZXcIVQnxVo+gjv34Fkks4Vdbr/vqukdlr55Mub5IQhvWrb0AdYnLTGbA45yjipkD
         aihLXT5VTOzCbYKVumCLMKNfmORusIwQi74DyvLVQXjTVM6CxXZb1b1TXAh4dljsKzTz
         JjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003407; x=1719608207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCXZHO5jGlp2bYUbK8OUm7s9KsnQfmaNZmifsjWFRsU=;
        b=k0C9VWVnYmt0WTQGojDHe359JHxtKgWblijCWle/Owu8mLsoXuGaE661wa22Sv58wu
         MkYXGEkKirXRkhhBUMGR8V9fAsWxWMkfcZk4jqCnREAe+dJpBWh1L/JX2yVgIOq9fvoF
         WbWgQx6rGhAdHydZmn8JF/X4eOkZ1UhbwzPf11ea5qclLDQw0RnBW3CZRufg875gsZAK
         0abT4EaGG+yaCZgy5KMXGcBczDn3GhDZaTB/Mig/gp+v0qbFh17qOs6YZXBN4Nd6eHw8
         NtwCQbCI03RceTXjJD8WHx8B33Bc0Ujocb7Klef6s5sCz+7pGGSsYDeGVIyQlG1QWzsE
         X7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHJC/1pGFNHoFW/kuwrEuOEXI8VxkZJ8i+mznoXGDAl8nKmyweCQ6vpIu5XvcUlfPwI+zFhT04Uc5GaVyodmmVp7psYtc5yuo=
X-Gm-Message-State: AOJu0YyWVjYQY9Q4Hi30yt2TfcTyKA831ijOEY8D3DZDR8cFDaWVJ3pB
	56d+YdmJ7kVaJMF6JvFdRoG4OiDVD3ZjIGAfES/UPUQzU+cjLkWorZBGYtn46KQ=
X-Google-Smtp-Source: AGHT+IGMBqADkA6Kc5SklaTSzDMTsOlB2IIkSb7HlCkzxfs6AbKDf7unm5UgoSB2TqULwUhH6n3F0g==
X-Received: by 2002:a2e:9ecf:0:b0:2eb:e634:fee6 with SMTP id 38308e7fff4ca-2ec3ce93f8emr60717111fa.18.1719003406685;
        Fri, 21 Jun 2024 13:56:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d788590sm2938421fa.137.2024.06.21.13.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:56:46 -0700 (PDT)
Date: Fri, 21 Jun 2024 23:56:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Johan Hovold <johan@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: Enable battery support on
 x1e80100
Message-ID: <3n2qq3ggv2t6t3v475oscp7zvofq5ggy4nhxaygqbalsqc3ixs@serhvz77kyan>
References: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-x1e80100-power-supply-qcom-battmgr-v1-1-40cb89a0c144@linaro.org>

On Fri, Jun 21, 2024 at 10:16:35AM GMT, Abel Vesa wrote:
> The x1e80100, being a compute platform, provides functionality for the
> exact same power supplies as sc8280xp. Add the compatible and assign
> the sc8280xp match data.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/power/supply/qcom_battmgr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index ec163d1bcd18..46f36dcb185c 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1308,6 +1308,7 @@ static void qcom_battmgr_pdr_notify(void *priv, int state)
>  static const struct of_device_id qcom_battmgr_of_variants[] = {
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },
> +	{ .compatible = "qcom,x1e80100-pmic-glink", .data = (void *)QCOM_BATTMGR_SC8280XP },

Do we have a bindings patch somewhere? If these devices are compatible,
what about using a fallback entry instead?

>  	/* Unmatched devices falls back to QCOM_BATTMGR_SM8350 */
>  	{}
>  };
> 
> ---
> base-commit: 2102cb0d050d34d50b9642a3a50861787527e922
> change-id: 20240522-x1e80100-power-supply-qcom-battmgr-83442b7cce60
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
With best wishes
Dmitry

