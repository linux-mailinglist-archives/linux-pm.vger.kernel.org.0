Return-Path: <linux-pm+bounces-27411-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA3ABD852
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 14:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A97B01D2
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8B1A254E;
	Tue, 20 May 2025 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z68jTGdF"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27160E573
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744980; cv=none; b=Lw6eqrXUbVDJjBAFTe0f9TqI2OGKZJE0+U3GcUlbdAU1yTBsDDcIirIh3db3DTv0PReJ387eLVBV+LwOOkc7HGqGu/sFmddyz8a+HoX/+jEUaOUZ9mTPpSWL0/68l/0VwYJPwsSZ92jUt9Ow91j69F12Q0iAtPsLgvIr0kjapm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744980; c=relaxed/simple;
	bh=kAYBhgA7SbgPwIuhLi3KNN6TuETDW3sCCCLPjUs9KLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWwjvuO1klpaRgtM9SeKQhI/YUUX9Mur8Q8df7SjFEHVSVMIIPAZ4YpX52nO06DnaGemlrfjiMnXDPsO3l+Fw4V3bY+qPKiv9vtax5ewJpr4OYR4TCVARFGRQidgN61CYS18bMCihCjeq9Pbi+NQ1Rz0d3ihuNHCvqzm+7DFgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z68jTGdF; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e694601f624so4083370276.1
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 05:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747744978; x=1748349778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=88lOLN3//BdORRDyk/6LjlOBy9fkXDogVmGs1sgPhyI=;
        b=z68jTGdFqiP6o81qhSPfWRQRBkTV68YKQY5rKGT9CAo0H+HjAXa4IDbhPYQLD/0m/A
         szy5ZbxzUoFCGFcXm+9cseyJm8i2GVo+Bl0W/SlByNxBlKXNu7uCRh4au012ZLSHVJpq
         hvyXUGGQT7tYWXQLFERvM8QFyzQAjwAA1aSqjeh9kWWYTRUltZE5Z6/VD8MQCWk7jL8C
         uF5/wjjpyZRDo+Aj7xAODjjf44F8fpNVXOOGDNUcxoxaVSfSLt3AtkN4aF5XGfmz6VNa
         GsevA4kQw122PHEaY4UBLaHW76GvyvyJUG7EX+/zCFtXswtE/T5t98OoKMgBWess8xRV
         3lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744978; x=1748349778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88lOLN3//BdORRDyk/6LjlOBy9fkXDogVmGs1sgPhyI=;
        b=J0T87emBLKgsRQ4ZnrkR3GtAwxn1Zy5gPvg7UNIApsUo9H5o0AC6F6rz6FO2laaxe3
         BFLz9ctGFS0ltgLa1pBozuAYcAz/KO2sdoFg6WeTbNW6zFF9oPHYwcx3DnOpOk5qlaO6
         iBOOCiYYcekIsopWj2xTO57urHChbOIfifqNTGlfDju108YP4uGUqBPqXdkBUftirK3y
         VHCJK8k9WMM34aoMzjEgQl0p2y2+pc9Qtd+4XtTsVm1Gj3Vw1Q9yNesvnTpVBfAIX2LQ
         oqbdctdlGfxj/74ExIlCcKUzEhqM36kGIp0ok2BNE81kiiTJvDuLgMqwJHklvda5s7Rn
         Rluw==
X-Forwarded-Encrypted: i=1; AJvYcCV3l0NBu1E3IUI7yvCcsGiKYGCYk5pBPW+Qoyy0yaCYgK1jmBJR0hJ9Q2rZErq+eADl+su7bupxgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6OEhuDWJGVELM9MD572WON7YOqmjrvBsdjLdlJFzQ3uSGIWqa
	Zby8sRxqRBpfG5ug+Ii7gNEwZmoqss8JMnuKaDBkta5a0nnaWxaqhFBdYL4MW2IT7Q6ONcHKQ0W
	wvSorAAXt4ss5KzP6DM0kSI5vewSFAjHAyuWHX0auJQ==
X-Gm-Gg: ASbGnctkrN7p2PWm7j4WpfrT5+DNBfo51p6O17VUmthT+3aRIK4GSz15raj7TpTLDQ5
	W/rciZjv9abkHkAlos7cwfIuOoXsVC0pLHtvutNXLt/TQZmpNXdsi31HYfA+bJuWk6dTeVvgdkR
	28jHYSF30/SFuuRg1ZP5rnR4G85wqGEVT0cg==
X-Google-Smtp-Source: AGHT+IGhT+v8r+0GZsiYhs7CHph95cb2P8MRGP6RGC8fZ7dFYUwqCE9+mfUsNw7SyUvETHMbFtvpOAcTqK/Ng1hl+qE=
X-Received: by 2002:a05:6902:1201:b0:e79:774:866f with SMTP id
 3f1490d57ef6-e7b69e80915mr20083103276.17.1747744978059; Tue, 20 May 2025
 05:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518220707.669515-1-jonas@kwiboo.se> <20250518220707.669515-6-jonas@kwiboo.se>
In-Reply-To: <20250518220707.669515-6-jonas@kwiboo.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 May 2025 14:42:20 +0200
X-Gm-Features: AX0GCFs3Un2EF18YwTSrDKI84LtGeBLBa79SYyXbjLKaJiwIZzX41KzumIQh4bM
Message-ID: <CAPDyKFqu-ox90dEnK8L0C8CqXJDsvgGwH00__nfQcOYu8hNM9Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a power-domain
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>, 
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 00:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The commit 7e856617a1f3 ("dt-bindings: mmc: Add support for rk3576
> eMMC") limited use of power-domains to Rockchip RK3576.
>
> Remove the power-domains: false to allow use of power-domains with more
> controllers, e.g. with SDHCI on Rockchip RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 5fb347167004..f882219a0a26 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -120,10 +120,6 @@ allOf:
>        required:
>          - power-domains
>
> -    else:
> -      properties:
> -        power-domains: false
> -
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.49.0
>

