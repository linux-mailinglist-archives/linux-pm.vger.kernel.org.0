Return-Path: <linux-pm+bounces-25000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84658A82284
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 12:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA4C1BA69D7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Apr 2025 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20CB25DD00;
	Wed,  9 Apr 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGXkogIk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B025D521
	for <linux-pm@vger.kernel.org>; Wed,  9 Apr 2025 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195315; cv=none; b=XQuMq6QXu2maIvy1PAp9sAbC2GVxPew0Dj7MtQ1//J3b/68IpPlLFlVTzPOnf+X11Eg7M85gITUn6r0cYlyKv3D24HHzZH0qDFkIMcBSDc/L5iHqc2UhRHpgBXJREHirVtI6wR82AQYDdzCmAqp1C/0MyLctXFYaS433gUwymGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195315; c=relaxed/simple;
	bh=u4imxXMhWH+lE0stnEdXi80NbKFnl0KzUsQSbsGJErk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Py78TCnbXlI5ehLPvV3BNwRRA2zwVZPoiBpQEZV/n9CLGwTwV1ERl/D+r1svkcB8w+iTsOXgn/hY1vWF2plo59SA1I+H3SDPmFwuz/R6NhwVuW4cLpwAoBxPTKKXVo7Q5klKqO/kOrfXHX6LRx8iu/NECtlhVqDhzjNXgtWqXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vGXkogIk; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-700b17551cdso65329777b3.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Apr 2025 03:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744195312; x=1744800112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbx/nnTrG6Q4jtzUnp3dgghp62oCSk+raqpc9aCKiZs=;
        b=vGXkogIkxu7sqj+W+yucDQ0EzdgVKFBipazVeSrcRjkp9nGViIB27x/6BFHebfVZ9j
         5LS913tTymyCQUFL2kseOUI4xUCb+nChHAfT/bfOiXzEVOnp0TEXTAXOY8+oLDyJdKuP
         utA8OzzKjcLaSXnw9g3aXo2uc/wd6z+X0getZcoWZJ3qkiNWx1RX5D3js6fWkuMr9/bM
         HTmsg0JBUUxxO6pcsF8vwZ/Iq4YT1JMpW8pQDpT2hoT68HWXyrpuJoa/aVzQ6Md0RMfI
         3MfTkB6r8G8YyWvqeRhDx4MpTLhv/lq7Aoh4Qtiu1H3B1F3TZ78N5arOh9Fkm7SnzucQ
         az/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744195312; x=1744800112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbx/nnTrG6Q4jtzUnp3dgghp62oCSk+raqpc9aCKiZs=;
        b=CecCOlIKE7IaqSr3RWzlCugwCz7uDkBLCA4QsUHxpOyIAypThULeyV4BGpvCdY1bzj
         jdPcJ3BDzgrp0gcY/INNKIceZy+QgUB6kLSh3Yk9vAhyO8VfglDtM6cT6gExFRS0jo9u
         hfRjNyM/hVSJzaeY0trkGEONOEmMSSppWl6pL6YwrGioqQtoweH87P7HamYYxRKu2wjJ
         xLHpoJGN2rrGmUQayTJQ8ANL7pNX9SgyGfCpXDCanbZrhASt3CP1p9j+UNEKngi5CDLS
         27WjrKeTbVJQa3KOAPJ4sO3GLEMx7hxipvKN5jpr7AUy5XXKhPudtuioRfCrnKCs4adr
         YHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYLHaVlw60HCbxHo+TcMTvOX89279/WtYmLA7WpmV6hcGbngsKel6unI8+wclW5b6S7Hmf7083NQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfAJxjsPSmpJWvk/TvYl1P7djwI/UJm9ZjS6VjnICow+YPqOTx
	y5gYha0AauskivoAdOcqJJE7kljuCiN3OUVaYRfjJk2MDezKSGRUI9WdtwGpCeyQMEd523qDeRT
	gs9tnD6c/clmj7IgYguci/pLe8my22zZXGsqiAw==
X-Gm-Gg: ASbGnctWHE8j2MjTCwzu/GRidWDV/nJKXgKr6i81L8N6/ez8VTXKra638t7MbW8Qq96
	0iesf0ZsF4RQWR7AqKPnpk8SWtVlPgN9BmVDMtww0v9mq4BQbamOsdjdkRpIcAPCidCoPg9RpcY
	53/kJAAKIcXcwozSgcjzcQryOaHl6TpLhzrg==
X-Google-Smtp-Source: AGHT+IFcW3dVYG/NllcMUbiQFPsaC2kMGwBB25zgb5C4LoLaPrqyxQ+CvN8joNvk0vnecmPTbBGtAkQPDSjYEggyHcE=
X-Received: by 2002:a05:690c:4889:b0:6fd:4485:9255 with SMTP id
 00721157ae682-7053ae70affmr35816427b3.24.1744195312358; Wed, 09 Apr 2025
 03:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250409093031eucas1p2222e9dc4d354e9b66b7183922c0fb3cf@eucas1p2.samsung.com>
 <20250409093025.2917087-1-m.wilczynski@samsung.com> <20250409093025.2917087-2-m.wilczynski@samsung.com>
In-Reply-To: <20250409093025.2917087-2-m.wilczynski@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Apr 2025 12:41:16 +0200
X-Gm-Features: ATxdqUGWw59JsfUXBmewm_-nQPR1HPGJKXnfN1JdqM3oC2wFfjOLFi3_5CNvBz8
Message-ID: <CAPDyKFpoSwKAmiWyvNt1fVyu6=NU1oVOmQLVuzX_bG=-5KrM2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: firmware: thead,th1520: Add clocks
 and resets
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, 
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de, 
	m.szyprowski@samsung.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 11:30, Michal Wilczynski <m.wilczynski@samsung.com> wrote:
>
> Prepare for handling GPU clock and reset sequencing through a generic
> power domain by adding clock and reset properties to the TH1520 AON
> firmware bindings.
>
> The T-HEAD TH1520 GPU requires coordinated management of two clocks
> (core and sys) and two resets (GPU and GPU CLKGEN). Due to SoC-specific
> requirements, the CLKGEN reset must be carefully managed alongside clock
> enables to ensure proper GPU operation, as discussed on the mailing list
> [1].
>
> Since the coordination is now handled through a power domain, only the
> programmable clocks (core and sys) are exposed. The GPU MEM clock is
> ignored, as it is not controllable on the TH1520 SoC.
>
> This approach follows upstream maintainers' recommendations [1] to
> avoid SoC-specific details leaking into the GPU driver or clock/reset
> frameworks directly.
>
> [1] - https://lore.kernel.org/all/38d9650fc11a674c8b689d6bab937acf@kernel.org/
>
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/firmware/thead,th1520-aon.yaml   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> index bbc183200400..8075874bcd6b 100644
> --- a/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> +++ b/Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
> @@ -25,6 +25,16 @@ properties:
>    compatible:
>      const: thead,th1520-aon
>
> +  clocks:
> +    items:
> +      - description: GPU core clock
> +      - description: GPU sys clock
> +
> +  clock-names:
> +    items:
> +      - const: gpu-core
> +      - const: gpu-sys

These clocks don't look like they belong to the power-domain node, but
rather the GPU's node.

Or is this in fact the correct description of the HW?

> +
>    mboxes:
>      maxItems: 1
>
> @@ -32,13 +42,27 @@ properties:
>      items:
>        - const: aon
>
> +  resets:
> +    items:
> +      - description: GPU reset
> +      - description: GPU CLKGEN reset
> +
> +  reset-names:
> +    items:
> +      - const: gpu
> +      - const: gpu-clkgen
> +

Ditto for the reset.

>    "#power-domain-cells":
>      const: 1
>
>  required:
>    - compatible
> +  - clocks
> +  - clock-names
>    - mboxes
>    - mbox-names
> +  - resets
> +  - reset-names
>    - "#power-domain-cells"
>
>  additionalProperties: false
> @@ -47,7 +71,11 @@ examples:
>    - |
>      aon: aon {
>          compatible = "thead,th1520-aon";
> +        clocks = <&clk_vo 0>, <&clk_vo 1>;
> +        clock-names = "gpu-core", "gpu-sys";
>          mboxes = <&mbox_910t 1>;
>          mbox-names = "aon";
> +        resets = <&rst 0>, <&rst 1>;
> +        reset-names = "gpu", "gpu-clkgen";
>          #power-domain-cells = <1>;
>      };
> --
> 2.34.1
>

That said, it's still possible to make both the clocks and reset being
managed from the genpd provider. I will comment on that separately for
patch2.

Kind regards
Uffe

