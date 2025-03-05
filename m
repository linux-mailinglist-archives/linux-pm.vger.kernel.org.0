Return-Path: <linux-pm+bounces-23488-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5D2A502EF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA18178269
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03AE2475C8;
	Wed,  5 Mar 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/FodS+J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBB230BC6
	for <linux-pm@vger.kernel.org>; Wed,  5 Mar 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186442; cv=none; b=lSNMmLygBHPP1m0WeS9u8uYETR0BhDun5qvpcuohfE4PtQ+ve3z5Kfsh8Juga/SaGgG+s39gRt2KUN28sn5os5Rn3nTWXHFTzzxE3IVMyCJvavY8RBYh8PUMjo6Ahndvtvjd64nRldkLKUtc0XGi7yYfMJJuFmvlcB6ZwufOc/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186442; c=relaxed/simple;
	bh=jTkplcEsWFR/ytitWc/gZ9Jgm54mf9GXdauo+Q8kRBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpTj9K4tQykRzXdf2INJavu6N+O2p/AVfyqywYKwtiNo8vWkRwe3Z3LBMOsUXzVk1QB5cGSK11VGJuRMDW0TaM+EYHXL609meFM+Lhu9ChsOZQlxFCZzegS53Z9gRBmR3XHHB5fJaiU1kS9vv03hc2TeLgXq1rySUjXg1y9pwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/FodS+J; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f77b9e0a34so55318897b3.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Mar 2025 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741186440; x=1741791240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/8e1NK0iHuTNXsrRQMu1Rap5op5xIoO/iE7QbD4E6K4=;
        b=Y/FodS+J30C868V4Ywnu/qvS5RyRM7GvU7UH3gxg4aosQS+35Zz9gGhTj2bA6QY/hN
         hJbLf3cd8k/mKfoFIxt1cCy2kSG4X5l2s+0SZaCJERv4LDnn2hvsQZ1LpYF/LKMOzaPw
         ztnyU8DtXbnanSy5Q/7eI9f8ysQ0Qmp+8SRkie3HJZRaANHFXkN6hn048lfRNcRKYU0a
         rQQbmtW54mUdVjEL0UbXrLYZ/9r90/g8PWZ5J8thB/to1Rzq8yxvYbSVQzIXlkT5Gnk6
         bkWz+lP3PwtZ559klAsS1zpTSqTDk8fLgODAUh3uCXYBqWpZSUFWgKuK2aruAZr4Pteg
         jgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186440; x=1741791240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8e1NK0iHuTNXsrRQMu1Rap5op5xIoO/iE7QbD4E6K4=;
        b=xI8lqlkUxXal9WulSeAyoB25d041rlA2swd7BawDpvaMIF8DrR3qiqwZtnhFmUF4bB
         iw8a5ZfVZad4fdGsRjyDPsC0hNwTj2c/49+uhFk+GOf94ZbGEFscABRZ6LUB1OtCNj8+
         DVGjtyuPzN2ziAGwvoyqobYurPtxeBybkX1vz63cT5lJwhZMOqZpAz3recbZvdKbdlT/
         Lnk3vSSlh+ZxvEaIXfp+mrGzXd+ZuyuFQeOCLX/Xctx+o+Ner/Kxj+qwTYofUP/c5jHC
         jPet+N8TufIqGrSSeYh41dP6EimvZ68FzJm7F4vI4HkqXoxVIjHuQgcW6EYYx7XefEom
         MvNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMo5+k9G2y0e05Uduje8ZaHVpnmSNOGYk+Toy+6Lhoil+bv8uW2Wuzowdii33zS0x04O4lJKTkrA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2NZXdh2C+XK4FPTrZx1hxvfAs9+epoN8gefesWUQ0eXqjReg
	VeE6xANHZKtKN9lC1V/4agnO9p4whTKF2dgfQLDlbLGIY1oFchHprn4eEdF/oV9rEiBLMX6YKoc
	re0ndmIvMwr3ByldHd/UheRT44ErB8UvZzFhrqQ==
X-Gm-Gg: ASbGnctqo5fgAVje8SGpPMMhTxYOTMOoYunFMBOosXAvbSPb3L9jQAD3PKY6cdFfI6l
	1NjqlY0PCdVczjeDGEVwnqi5LGn8rjj8l7LsSJypkkC5otB/rHCGx5HB/iJkWwr4RX5zdPkMfMb
	cCT16FeCstWvGL2l7FskwCM6CIcCU=
X-Google-Smtp-Source: AGHT+IHVMDgrxpiMAMts0+d6pAHMmbs+DKlyOlsJcQRgBdUnM1Arh/L/Y1HIIcETYwiUqxFlkWz35mNO77MdJGM7YEc=
X-Received: by 2002:a05:690c:750d:b0:6f9:e609:6a4b with SMTP id
 00721157ae682-6fda30be95dmr42050127b3.23.1741186440140; Wed, 05 Mar 2025
 06:54:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304142803.689201-1-arnd@kernel.org>
In-Reply-To: <20250304142803.689201-1-arnd@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 5 Mar 2025 15:53:24 +0100
X-Gm-Features: AQ5f1Jop9maVmyVlQa4pDNjDZNA9U2rexGCX4_vVPocLK9GIMh5i3XadhUynJ5Y
Message-ID: <CAPDyKFo79xyTOKxN7A52J2Et50++fifdosUpyb2mm3NMc+EC1Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: rockchip: add regulator dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 15:28, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_REGULATOR is disabled, this pmdomain driver fails to build:
>
> drivers/pmdomain/rockchip/pm-domains.c:653:30: error: implicit declaration of function 'devm_of_regulator_get'; did you mean 'devm_regulator_get'? [-Wimplicit-function-declaration]
>   653 |                 pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
>       |                              ^~~~~~~~~~~~~~~~~~~~~
>       |                              devm_regulator_get
> drivers/pmdomain/rockchip/pm-domains.c:653:28: error: assignment to 'struct regulator *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   653 |                 pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
>       |                            ^
>
> Add a Kconfig dependency.
>
> Fixes: db6df2e3fc16 ("pmdomain: rockchip: add regulator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/rockchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
> index 7e4f9b628f0b..218d43186e5b 100644
> --- a/drivers/pmdomain/rockchip/Kconfig
> +++ b/drivers/pmdomain/rockchip/Kconfig
> @@ -5,6 +5,7 @@ config ROCKCHIP_PM_DOMAINS
>         bool "Rockchip generic power domain"
>         depends on PM
>         depends on HAVE_ARM_SMCCC_DISCOVERY
> +       depends on REGULATOR
>         select PM_GENERIC_DOMAINS
>         help
>           Say y here to enable power domain support.
> --
> 2.39.5
>

