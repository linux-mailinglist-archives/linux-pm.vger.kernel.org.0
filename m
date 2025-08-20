Return-Path: <linux-pm+bounces-32727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A48B2E30E
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 19:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B8E1BC7F50
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC7334709;
	Wed, 20 Aug 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dt6BpLVU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCD36CDE5
	for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709856; cv=none; b=YroioFLOcq+ma5R0xLnTAiMrt6mFvzxlTs8MqRK0RvbjjRdWhGckzYedf0lM23v8enNSWeT52WzCgMqMLScVKmE2iW/LogKz5OLm4bX1Vo/gAy5RE4cTQfD3rb/Y8yWz8ncLJApwkHKAX0+JnpQMXkotDPPRhrPt2B6Xg5WyE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709856; c=relaxed/simple;
	bh=hG8SxVO+5AdfLJQh4Ugi3YNkNI9qHS2bc2aupXJCtSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpodYAduuSZEfresNl78YWZcEOYg7gLAJFG2KmwGZDYVxivGWvvTZVwQphv7uylyaRKE5TW7cijzIMx2O2ZKldvJOeEz/MXrLlROSmL6ERKgOok5gDZDpUzXkmw19QPa6F51US6QyoL9BfK4+HaHGjDYtmmt7dJoW0gOWhfFcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dt6BpLVU; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71fb85c4b59so9430407b3.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2025 10:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755709852; x=1756314652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=727UKZSKS9UwGe6aim6XorGjWW+I61+OozHvio/cjhs=;
        b=dt6BpLVUopBd6rT89t63P5PgQIiF2+wrayKgd8MCrHPlBDf6QR10HjiFZK4fC40dfO
         LbLuYG5Tz7+JrD+bFpD6Qm14XR46zYl6qVbsrgLAQDcKRz++xHavmUtnLwywDSOUnI+P
         DBdmS8hZ3zu9U9BcTUjW5TTlT4YtNctDufasVQhs/Btj5aQTw4g0tp/UPYKB3ljQcdin
         mTraIbTQPUso6IJBL6kSJT+noeCHYA1UesrN/6gaIHb6TJaVQmyH6dJE50rykIj6l7zJ
         qJmUHLAvUnUmjj59A7UVyiLCz0gkili1uRBA8lMN73Qq+XZ8HPx1QN/HbxNkFGJxvmKu
         OSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755709852; x=1756314652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=727UKZSKS9UwGe6aim6XorGjWW+I61+OozHvio/cjhs=;
        b=EQS10uDBoR0xHxQ5ZoSDGyVqpHjkIt1VtNLBmPFLL357k4afAhlxWMEwbY/Bch9A3x
         nNqFxHwtRU0apEoTGGNn1IZEEoy7G2a+Wq2XUB05qYLcPUliclCxXU/8jh5BFOy3kSV8
         4SptthIr2qmfWqp3VKIDZBEDkpAxTXadkEU8mjHfNJQo6juIB0BSZ7TMNQzsCkl+k3IO
         hgtMu/pXQja9zNMDEwqMyxd1SwVtFXIKujqDiYldcOK+KInDPO/SABG5ELIzFFZdQk4l
         aIYtOPeLcc04k02RmTzoZ7bo19oaStZq9OdUDiS+EPt2rtrnVA9u5GU1fwvFicIlQHEq
         I1Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXsT1FgVhe/i5Zx2a3By9aVPjZCuyN7y4KtYWqesEZ4bONAG6yyXXB1OsRx2f1t0pGxZQnOoYxigg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJLeDW9dLI4z6JPEcY1oLmTK1NSu0B84b6x1nDASA4IqUlue18
	Q/c0N5nXzj51LxzhF42+bGgA0nyc4MZUbP+Z7go5nElmFQ2qZKloPcqVwYN9pXj9KbQD3lONmWg
	nw59S9gDT0IzEsfhz07msIewyple2N0pXd20akeR9Rg==
X-Gm-Gg: ASbGncuhHn/kT4Cd3ZBO8fhkuCOPHHzJbJRxWu7rimHATISr/mvVNBAqJjjf79d8OQR
	CwmgVgiRFxUt8afIrEdT39oo506nfjjBTmiHmqjauzcZZB8LI1yh3waYMEMtZoaACRgHKVvKYge
	HSD3vPSAZq2H4iCglAcxXXdkfC6BLrY7KK4UJq+yH9oIQ2wXRSx25IpNXiaQngwUB7GbGoj9TOs
	/yyvzwe
X-Google-Smtp-Source: AGHT+IEpDwtZVI6H+GfGnTfQIwUyY5UUZdBfiqI97/jjpj/Lpw9zMkd2OWo35A3c2Mc0ZAvXui6OtqnR/RLurFK8aDA=
X-Received: by 2002:a05:690c:4b8d:b0:71b:f419:2099 with SMTP id
 00721157ae682-71fc6380a74mr4423317b3.21.1755709852320; Wed, 20 Aug 2025
 10:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250820085609eucas1p25d7c6d67318b6c332e3f238705544b19@eucas1p2.samsung.com>
 <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com> <20250820-apr_14_for_sending-v12-2-4213ccefbd05@samsung.com>
In-Reply-To: <20250820-apr_14_for_sending-v12-2-4213ccefbd05@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 19:10:15 +0200
X-Gm-Features: Ac12FXxCH2ttqXRbmi_2dmdMWE4eeauuwFrI7EIdSSvrawO-ealoi74PXSk4RH8
Message-ID: <CAPDyKFrjHdASRUDxR+KROovV0sherhqdkOgHC9hoA6dhdMr39A@mail.gmail.com>
Subject: Re: [PATCH v12 2/4] dt-bindings: gpu: img,powervr-rogue: Add TH1520
 GPU support
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Drew Fustini <fustini@kernel.org>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 10:56, Michal Wilczynski
<m.wilczynski@samsung.com> wrote:
>
> Rework the PowerVR Rogue GPU binding to use an explicit, per variant
> style for defining power domain properties and add support for the
> T-HEAD TH1520 SoC's GPU.
>
> To improve clarity and precision, the binding is refactored so that
> power domain items are listed explicitly for each variant [1]. The
> previous method relied on an implicit, positional mapping between the
> `power-domains` and `power-domain-names` properties. This change
> replaces the generic rules with self contained if/then blocks for each
> GPU variant, making the relationship between power domains and their
> names explicit and unambiguous.
>
> The generic if block for img,img-rogue, which previously required
> power-domains and power-domain-names for all variants, is removed.
> Instead, each specific GPU variant now defines its own power domain
> requirements within a self-contained if/then block, making the schema
> more explicit.
>
> This new structure is then used to add support for the
> `thead,th1520-gpu`. While its BXM-4-64 IP has two conceptual power
> domains, the TH1520 SoC integrates them behind a single power gate. The
> new binding models this with a specific rule that enforces a single
> `power-domains` entry and disallows the `power-domain-names` property.
>
> Link: https://lore.kernel.org/all/4d79c8dd-c5fb-442c-ac65-37e7176b0cdd@linaro.org/ [1]
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Even if you already have the necessary ack, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml | 37 +++++++++++++++++-----
>  1 file changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index 4450e2e73b3ccf74d29f0e31e2e6687d7cbe5d65..c87d7bece0ecd6331fc7d1a479bbdaf68bac6e6d 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -21,6 +21,11 @@ properties:
>            # work with newer dts.
>            - const: img,img-axe
>            - const: img,img-rogue
> +      - items:
> +          - enum:
> +              - thead,th1520-gpu
> +          - const: img,img-bxm-4-64
> +          - const: img,img-rogue
>        - items:
>            - enum:
>                - ti,j721s2-gpu
> @@ -77,14 +82,18 @@ required:
>  additionalProperties: false
>
>  allOf:
> -  # Constraints added alongside the new compatible strings that would otherwise
> -  # create an ABI break.
>    - if:
>        properties:
>          compatible:
>            contains:
> -            const: img,img-rogue
> +            const: img,img-axe-1-16m
>      then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: Power domain A
> +        power-domain-names:
> +          maxItems: 1
>        required:
>          - power-domains
>          - power-domain-names
> @@ -93,13 +102,20 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: img,img-axe-1-16m
> +            const: thead,th1520-gpu
>      then:
>        properties:
> +        clocks:
> +          minItems: 3
> +        clock-names:
> +          minItems: 3
>          power-domains:
> -          maxItems: 1
> -        power-domain-names:
> -          maxItems: 1
> +          items:
> +            - description: The single, unified power domain for the GPU on the
> +                TH1520 SoC, integrating all internal IP power domains.
> +        power-domain-names: false
> +      required:
> +        - power-domains
>
>    - if:
>        properties:
> @@ -109,9 +125,14 @@ allOf:
>      then:
>        properties:
>          power-domains:
> -          minItems: 2
> +          items:
> +            - description: Power domain A
> +            - description: Power domain B
>          power-domain-names:
>            minItems: 2
> +      required:
> +        - power-domains
> +        - power-domain-names
>
>    - if:
>        properties:
>
> --
> 2.34.1
>

