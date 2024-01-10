Return-Path: <linux-pm+bounces-2056-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAC1829A18
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 13:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC20E1F23398
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84E47F74;
	Wed, 10 Jan 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="O4T5LONJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D146F433BA
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso4335109e87.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1704888205; x=1705493005; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4aE8XRJFVb6wLbpZjivLGMPDq1Y9NbMq1Kn1ckULjg=;
        b=O4T5LONJedAC4oShwr5IDo7kluNZ+CceA1xjdTG1nCx6HLG5VvEYTpwRDrNZuRZofz
         Dgfn2fGAwAVDArdNcM3FA5UlUiHEZYHLtFvctPqszMUqG8jnwZuUB1T+ZDXNPtKfR296
         9Gx4ufYKTSe5o5un60Pj510+mLqo2pGX/GK38dbUeKqK9uajqgtd7z10dBwEfAADkpoY
         AduL6y+JphkD9heLX353hHdw2grhlDUpUtlbWgxyh2byd86HVeQVe4qNcTMuwrTcVoX8
         YXk0V337pyo5iMLId38giLV+I/HSx8jBDLNtmYvlFGn/FJx4RuXeDpGbNe4tmpGQmzJm
         krbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704888205; x=1705493005;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4aE8XRJFVb6wLbpZjivLGMPDq1Y9NbMq1Kn1ckULjg=;
        b=duRhKoNpQqfEy4EG9w6lfPxmmd4BCn72upW2EDJsIxGDFXYN5uF4FX8h90bHVxm8Fd
         72UeIexBBJLJq+PNzi/yG1D4XoK5Z04y6XQW2OuJhX0CocQ7Xz3ibXtb8FuJ1OuaSv00
         t7gYeMp6t3J0JH8TcHXFSZVkLMWzFOUiVdYJ78ri6B5h1czLj8wl7LvRNIzC04WV4RMX
         C0pYX5W67FB/rVKP1m8+ekpM0E1EEStn3yknXLpHpJhN6u5679s6VqoYyguDSFni8CRI
         6DAiyLK21KGfSjv5WORj6jNu1oD9K1EzMiO8N9zTcKHgUdJJxIT8CYNAQpT1lyXrW7Z3
         xxdw==
X-Gm-Message-State: AOJu0Yyzms1OAJ5TonLzHvihZa/C+tfnMHKh0IVU1pMQYVVJpicQScPL
	Vvh8mszzKFBthZNgMO1cpoXKggbCe5NYHubtSar9HgQ43e3YrarZ
X-Google-Smtp-Source: AGHT+IE02uV2zRThTZGL3R6zPqzZAt8gheDSJ86CIt+OFLoYxfwKexl131UgsDs7cF2fSWr6YjF1iQ==
X-Received: by 2002:ac2:4436:0:b0:50e:b19c:94d7 with SMTP id w22-20020ac24436000000b0050eb19c94d7mr290826lfl.106.1704888205089;
        Wed, 10 Jan 2024 04:03:25 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id q22-20020a19a416000000b0050eb207ab58sm631572lfc.74.2024.01.10.04.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:03:24 -0800 (PST)
Date: Wed, 10 Jan 2024 13:03:24 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cong Dang <cong.dang.xn@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Hai Pham <hai.pham.ud@renesas.com>,
	Linh Phung <linh.phung.jy@renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 03/15] dt-bindings: power: renesas,rcar-sysc: Document
 R-Car V4M support
Message-ID: <20240110120324.GC1625657@ragnatech.se>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1196419f3ade9a27b3c7906b6a898376b817601d.1704726960.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your work.

On 2024-01-08 16:33:42 +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> 
> Document support for the System Controller (SYSC) in the R-Car V4M
> (R8A779H0) SoC.
> 
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> index 0720b54881c2c87a..e76fb273490ff588 100644
> --- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> @@ -45,6 +45,7 @@ properties:
>        - renesas,r8a779a0-sysc # R-Car V3U
>        - renesas,r8a779f0-sysc # R-Car S4-8
>        - renesas,r8a779g0-sysc # R-Car V4H
> +      - renesas,r8a779h0-sysc # R-Car V4M
>  
>    reg:
>      maxItems: 1
> -- 
> 2.34.1
> 
> 

-- 
Kind Regards,
Niklas Söderlund

