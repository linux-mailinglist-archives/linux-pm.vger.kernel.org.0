Return-Path: <linux-pm+bounces-1159-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE967813642
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B36D281B78
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F835FF07;
	Thu, 14 Dec 2023 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/cff3YD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD0F11A;
	Thu, 14 Dec 2023 08:30:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso53140185e9.1;
        Thu, 14 Dec 2023 08:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702571418; x=1703176218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xE01ZdGgOUbKW6jdSRaQsPD8axcaxCU7gBZ6Hb9nfkU=;
        b=L/cff3YDzj6C2mbR+/fzmUGpyZC7gKHAssDecjnplxSCcuE/amK9Tp7DaxiA+XQFot
         m+jbAlkbYkTD49+lLhpdavtItQFqZ4XQkzaXHSWqO2mZW+OFf/KptZ+ixTSYcjBbJH71
         CIVBYnhQf0kJh4dRoXRPq4bzKhHI4S/PvdmhPGs4iizecfUakSGoDPXU34kQnmpHR5YK
         ufomRqsNbzfInHDJQzu18cI45sYP/nnBFfFXn72h3BR4ZtnqcPgOuoU83DK0jz7pj8eX
         1T2YPSmUaK4mxbhaE2DC22oPPoOYmbsWnETkgqyz8eA5rFyBnGJEieCRBdS+qZhVAQYz
         Q9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571418; x=1703176218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xE01ZdGgOUbKW6jdSRaQsPD8axcaxCU7gBZ6Hb9nfkU=;
        b=xU6U0rBByXfcrD5NR9fQkjzips1mdPdPRjhheS8uA7m0asxYohu1p50ybjY2bo6pFa
         BiBf4jOZTdvIQnrbfTK0ibQ1+I9R/Pj+ThoGA6ev9QChW0oI3+bp4A4tBTkU98FK7b8W
         18dzNP73tB4gasOadoqdkFRnZhs5iFBMCgS3uG5dHNVyh+NwsDojuKww4YAfZvLXgyuX
         SYXpB3io0+iGfus2/WLFcHXQ7PVdO8Z9g4xXAabxKN9YrXDQs41aO56MlNZS39iu7XT/
         b2VsQKRguilxHWzJ/Co5f9WxaUCkBDej9AET3utoUTdVaTvZggkzBmEvpFlshSpwkTif
         L2IQ==
X-Gm-Message-State: AOJu0Yy0+IevCr75sf+gnMCj1YNSwE+OEnDZirMYaQeKS95aBUIKbSDw
	Mju/eEQ2M0aWgxcvAgWeG0s=
X-Google-Smtp-Source: AGHT+IEt3Nf2FCXCesN3uRpXrcfJ59x2f6UcAcLrd557rYe94mku6UBCBQZa/o3m9hOoz7r2BA5Z3A==
X-Received: by 2002:a05:600c:1392:b0:40c:55c4:45ec with SMTP id u18-20020a05600c139200b0040c55c445ecmr2704032wmf.46.1702571417702;
        Thu, 14 Dec 2023 08:30:17 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c354100b0040c411da99csm19770588wmq.48.2023.12.14.08.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:30:17 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject:
 Re: [PATCH 3/5] cpufreq: dt-platdev: Blocklist allwinner,sun20i-d1 SoC
Date: Thu, 14 Dec 2023 17:30:15 +0100
Message-ID: <3459481.QJadu78ljV@archlinux>
In-Reply-To: <20231214103342.30775-4-fusibrandon13@gmail.com>
References:
 <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214103342.30775-4-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 14, 2023 11:33:40 AM CET Brandon Cheo Fusi wrote:
> The Allwinner D1 uses H6 cpufreq driver. Add it to blocklist
> so the "cpufreq-dt" device is not created twice.
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index bd1e1357c..2febcfc2c 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -104,6 +104,7 @@ static const struct of_device_id allowlist[] __initconst = {
>   */
>  static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "allwinner,sun50i-h6", },
> +	{ .compatible = "allwinner,sun20i-d1", },

This should not be needed since you're using H6 variant for a fallback.

Best regards,
Jernej

>  
>  	{ .compatible = "apple,arm-platform", },
>  
> 





