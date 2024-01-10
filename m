Return-Path: <linux-pm+bounces-2059-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7C829A33
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC871F289F7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jan 2024 12:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAA481A5;
	Wed, 10 Jan 2024 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="QMYs2aLE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A547A7D
	for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7b273352so4250093e87.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2024 04:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1704888632; x=1705493432; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1vs93voPphmUSrk2JQhfVFtWYmTelzpIqdk59FOvao=;
        b=QMYs2aLE7xzgifiLZj6NvTH7E3Pb+SSyvHKgHn7mF257r5hrCx/v5wG0spQirpoeFL
         Rq0HhMggWXhqk9MmIg6d8vtdwyfu3Jj78x7QKwDSuHHfXl74wAb6BEMDdiZb1VKODs88
         vNqMLlz6Xnv/wsK05cKTm0H/CLESFiL/Vdvc7B4rzF3SWadQjC3Y2dDm0XxIi2n118sU
         OKnigSebZYL07XHiwagRlfPNKorMnrKpBXPALDNMuX9LwsrRWVkNf9u1uwGcWMwxZa4Q
         z5Yi/yCQa5hjImoe2j/8n9JTx1W461vSTq4p1ECexoKw1J34MPvXsUDOC+VQMGA7ZK8h
         zEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704888632; x=1705493432;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1vs93voPphmUSrk2JQhfVFtWYmTelzpIqdk59FOvao=;
        b=sYsFbeLa9aVEk3Ckg38jbLG9qEnoGPhHjxsnD6M35GM6xpEUqD2x4/dFwab/mkvyXh
         Do5tEoWVlXfAy94O2KX0/1QGebxBR+qiK+q90AXJKy266JSqprHL9ap0GicrIe2dZpsB
         J9O/hqll9JT/7lfxSe3By3q2jtG5F/XpkJuEnkDcnmmDx2AMAykbHKlvpsTdTnl1iQuF
         pjaK9CU2FIrgQrkhd0tytyS2q39y518w1qZDqYqswdTIrlOFGxp8pMpoB1DbEflrEwS3
         fSEOD+3nhplFpZnzWNsnCPI5Uz+Z5zNCNydC4dcgBP6cFApCyXY0EKMUthmK6nRH7NHg
         w3xg==
X-Gm-Message-State: AOJu0YwYvHikeLOYH6EmDAkr1Tr0cmWdcRJXLsACiOAnhNdX7vTJ/q0X
	ZdFp28Y+FuAvjfdpB/kAqhjN1WV4/SB8aA==
X-Google-Smtp-Source: AGHT+IETYaVgjTsjg3iwXxE+C8ZKYcKM+s8pNHcKfrCbNbtPGnG7fgSUjYhCAwtRUVrT2MWx4hVlyw==
X-Received: by 2002:a05:6512:10c2:b0:50e:b234:623c with SMTP id k2-20020a05651210c200b0050eb234623cmr486015lfg.83.1704888631703;
        Wed, 10 Jan 2024 04:10:31 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id u2-20020a196a02000000b0050e9dab7ca8sm639237lfu.150.2024.01.10.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:10:31 -0800 (PST)
Date: Wed, 10 Jan 2024 13:10:30 +0100
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
Subject: Re: [PATCH 06/15] dt-bindings: soc: renesas: Document R-Car V4M Gray
 Hawk Single
Message-ID: <20240110121030.GF1625657@ragnatech.se>
References: <cover.1704726960.git.geert+renesas@glider.be>
 <3b1baf0eaf9f483308a6df1340dae51d4b88a337.1704726960.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b1baf0eaf9f483308a6df1340dae51d4b88a337.1704726960.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your work.

On 2024-01-08 16:33:45 +0100, Geert Uytterhoeven wrote:
> Document the compatible values for the Renesas R-Car V4M (R8A779H0) SoC
> and the Renesas Gray Hawk Single development board.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The Gray Hawk Single board is an integrated variant of the (not yet
> supported) Gray Hawk board stack, which is very similar to the White
> Hawk board stack.
> 
> The schematics call it '"Gray Hawk"(1Board)'.
> The Setup Manual calls it 'Gray Hawk Single Board'.
> 
> Alternative naming candidates would be 'Gray Hawk S' and/or
> 'renesas,gray-hawk-s'.
> ---
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> index 16ca3ff7b1aea146..1c8f5122bccdb5c8 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> @@ -354,6 +354,12 @@ properties:
>            - const: renesas,white-hawk-cpu
>            - const: renesas,r8a779g0
>  
> +      - description: R-Car V4M (R8A779H0)
> +        items:
> +          - enum:
> +              - renesas,gray-hawk-single # Gray Hawk Single (RTP8A779H0ASKB0F10S)

nit: Should that not be 'Single Board' or '1Board'? I see both in the 
documentation but not just "Single".

> +          - const: renesas,r8a779h0
> +
>        - description: R-Car H3e (R8A779M0)
>          items:
>            - enum:
> -- 
> 2.34.1
> 
> 

-- 
Kind Regards,
Niklas Söderlund

