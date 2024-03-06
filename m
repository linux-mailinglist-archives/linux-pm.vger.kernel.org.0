Return-Path: <linux-pm+bounces-4734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D8873680
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 13:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A56BB24442
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0AB12D74A;
	Wed,  6 Mar 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="L/uQhg5l"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0012D1E7
	for <linux-pm@vger.kernel.org>; Wed,  6 Mar 2024 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728331; cv=none; b=LdUXk8smTsLAH+eo8NAvUdt+1AZSFlFz6RRMvkmM2ux7J/4iIE8K7WfRP6C6XWmlryMVo3L5dEXEc9DcDn8XD725DbN9Lhx/AZoFY5WlwclNB42iPse97/UvZPMl8X8DBWwLuGDTHOuO9OfMtPUxlaSwJONe4/QdEXkHEAoldDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728331; c=relaxed/simple;
	bh=iGI1Rd7t+ElR/yXpbkHx3UrRJ6iinVN7gJmSIOtE19I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWexSri+pJdG5Zaut1co3IU7MoGdPjJJz8P54KhLP0oCbIJNIvxeOH0UTAHKRTl1aWE854+gnCzzkSHRl/VAczYQ8wxf53q366t+scZSqIsYmO7ysXoEatHzdBDgKHX2Iw7g+kctxDsFBXSd/85gL1qk99ly6T2icvnXxbTIBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=L/uQhg5l; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51326436876so1099093e87.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Mar 2024 04:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709728328; x=1710333128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N7wsawU0QywA8PeQeD4REBFLUG2+XXkcSQZKArCvB04=;
        b=L/uQhg5lM/qWD/nssGueRDBO7TVRDXsh/U+0Jubr5XZzkEWoe5JTAyGaFM6a+kH9N8
         VM1BPLEACowLejonxrduIwwD8RT+JMkJ/Ylk4hRzxBiZtvv1554KGfRAJcTXB8lKwdvY
         kNz8/WhHsi++pHXQOchJYFxW8pJ6JeeJunqp80sl7mXji5DhwO7iDYC4BEOoW9wkHzJ2
         m0cZurYmTHZ/Cua2T4gDOMZXEci/zlAFC/j2PxLhAqhQygmUVu8tMgSsv2tuKveYZVHI
         wN0rqQsYBVO2RwgwW9l7iLTKnTEg90b1IyO/MF+jsBeyzA9gAbHAQVRYxJ7/QTfYCSp8
         8WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709728328; x=1710333128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7wsawU0QywA8PeQeD4REBFLUG2+XXkcSQZKArCvB04=;
        b=lJ241DHJ72FabDU/JJ5r3f2LDnZ5+HyIHhjLxqIjOWBSMtLh//W5q+Nak8JxyhJEks
         FkK5umk+WLp5ETt8YhCPJbQFlQU+5f5qmwAUxZNw1nDTyc2MSiJ6XyoLypf+JsmWc9bW
         K/FJkwH9Ka8iPRv5qcRpalV3zEnAny/DpM+yimtBdpIItJd/Rt9bwnWOj/f/YUrnsfAb
         gfr9mK+qP+8uIHKMQ/hhhpNkH89oypgo8gXPjFu8XEhh/Qgynu5jCscvhZ9k0Va5BuLF
         22V5IjH9b8+txny8jHDK+T8vQvrQLANBnnWNXm6f1vHk2+bQ8v5AAniOTCcLSlbomkBR
         SKkw==
X-Forwarded-Encrypted: i=1; AJvYcCXZkrL5IlGX781+jJYRpO/5PMePhOm/tqBbHGm2Mcll+0BstGRakrsOZDmyrYYy9P4/TjG65MyrS5TTTj6f3vp7qDw5n/lRvg8=
X-Gm-Message-State: AOJu0Yz1F/AAmYdoeH37K4TJRctFHZl5CT0cqCi3jK7x5+ZhrL6ppJNn
	TB6zciflUZeIpO3Ck2FnPorv8Q7YDW5FHdGyaoZK9U30E/kWUGO+Qd0DG65IqaM=
X-Google-Smtp-Source: AGHT+IEmSlpIlRejKZw+IJ2mh5Modwm09ASNEx8wkXWmbJ9dEYA/KfDM0cOBgf325X3jbOsQsJOLGA==
X-Received: by 2002:a05:6512:3ba0:b0:513:3f16:25d6 with SMTP id g32-20020a0565123ba000b005133f1625d6mr4303821lfv.34.1709728328032;
        Wed, 06 Mar 2024 04:32:08 -0800 (PST)
Received: from localhost (h-46-59-36-113.A463.priv.bahnhof.se. [46.59.36.113])
        by smtp.gmail.com with ESMTPSA id n24-20020a056512311800b005133c8fab9dsm1814257lfb.108.2024.03.06.04.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:32:07 -0800 (PST)
Date: Wed, 6 Mar 2024 13:32:07 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, Duy Nguyen <duy.nguyen.rh@renesas.com>
Subject: Re: [PATCH 1/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779h0 support
Message-ID: <20240306123207.GB3396349@ragnatech.se>
References: <cover.1709722342.git.geert+renesas@glider.be>
 <b3d135f8b63b9fe2d0f0aa2e48c8a2211b2e947e.1709722342.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3d135f8b63b9fe2d0f0aa2e48c8a2211b2e947e.1709722342.git.geert+renesas@glider.be>

Hi Geert,

Thanks for your work.

On 2024-03-06 11:56:02 +0100, Geert Uytterhoeven wrote:
> From: Duy Nguyen <duy.nguyen.rh@renesas.com>
> 
> Document support for the Thermal Sensor/Chip Internal Voltage
> Monitor/Core Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car V4M
> (R8A779H0) SoC.
> 
> Just like on other R-Car Gen4 SoCs, interrupts are not routed to the
> INTC-AP (GIC) but to the Error Control Module (ECM).
> 
> Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Changes compared to the BSP:
>   - No interrupts property, as interrupts are routed to the ECM.
> ---
>  .../devicetree/bindings/thermal/rcar-gen3-thermal.yaml          | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> index ecf276fd155cfb27..6a81cb6e11bc1e14 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -29,6 +29,7 @@ properties:
>        - renesas,r8a779a0-thermal # R-Car V3U
>        - renesas,r8a779f0-thermal # R-Car S4-8
>        - renesas,r8a779g0-thermal # R-Car V4H
> +      - renesas,r8a779h0-thermal # R-Car V4M
>  
>    reg: true
>  
> @@ -90,6 +91,7 @@ else:
>              enum:
>                - renesas,r8a779f0-thermal
>                - renesas,r8a779g0-thermal
> +              - renesas,r8a779h0-thermal
>    then:
>      required:
>        - interrupts
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund

