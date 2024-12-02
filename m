Return-Path: <linux-pm+bounces-18363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD859E07DE
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 17:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7B85170B27
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F53A8D2;
	Mon,  2 Dec 2024 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zze8m65W"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA03BB48;
	Mon,  2 Dec 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154323; cv=none; b=rOFj50UO1yqzoAq2tCPwq5+KPiKdsaFgPNgvugV53OcknpZoE2KX1iW9L4ek/jl4WKzO4kcnSxvysOfL75uagd1+jQuSDhE2dBPDFrR46FeopWyf7ZPk4FQ5EIYSHiEpEXGkM4pFpFH3LRxKwyIOsKC1KcuGhmg9TNnZMeHJ3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154323; c=relaxed/simple;
	bh=IfPb5EUoYdJYs1hy5/eHs2puOOO/sRNQcEJYmuuvUXE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmwnTijU0bdGW38UBRvssG+Qu+s25vx111grEmc5Vlb7gHgTTXnmEg09ntyFXm1x/SZ597Tjw/k2K714bWY/agLvI1WbrT6+XTN1xOMWy+1R8o9/UoT3gkTwt6Su6bk3q1I6Ly8dHDL+bJ8p9/JblWAp/aAUmo4/jXRgthI8mfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zze8m65W; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a2f3bae4so41582245e9.3;
        Mon, 02 Dec 2024 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733154320; x=1733759120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MoUizhuqEAXgVu/0YeOyha2OmR9oGnm0hqMAD2OhirU=;
        b=Zze8m65W1Y0Wz8qJSPvTKdiakk5QDYE2fuR2pzcQI7a2yhJoVdvErICGJKZ5P+LYdT
         JtK3faSP+9zhm4jz8JI0zyGFoUqrwI2h+dZkp9jgqifidjuQPJa5rK1/S6xPB/lxiJnU
         EI2VaKpdtQ+r6NLACQULzcyN6MYr3SRhT147yxoIba8j81jT2BGdM6HSzP04v9It4dPI
         fYqyuhnJ0LPlEr6xVLZHPh4kmCOVnKV4bQZtvG60AOOlZXWh5FpF4wzfRobJnYMxMh1V
         C1UdPE3ioh7pOy4iwSmzMeYPQPO9U8dJvzNqJe9mj8J7DA7roxkzO+yJEKDpoNRuojNw
         unWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733154320; x=1733759120;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoUizhuqEAXgVu/0YeOyha2OmR9oGnm0hqMAD2OhirU=;
        b=Z/KPMT+Jao1zDOIMLBRxpL+QE4M8iSyYjBtlpPH7juOxse9rYURE+hyQ+lwmflPl0J
         FgJfrwwCSH6hGZ+U6XP/qcZC2OlgJh81hmkP0/0ajkhFnjLE8CNoAWwgSzcthyEmK/c3
         CKOdEBgczemd29idBZ/2qouW926aXDvipzp7aXXrZkNUCDjSQWHPHBzOxNvNgR8DYfpo
         /3D5ovXpkgjmNYH3f/MFqftU9Qat7LI8CG112DVq646hAOzNFAYCF3vJWjHYe3cZCLNL
         bnTnmGTjqQc0gSVK1Zh/MFlAj3sIA7ntmQAtqI+eI4B7Vn1TCOOiwZsOD9QAaJI3a7La
         2WjA==
X-Forwarded-Encrypted: i=1; AJvYcCX+W/BxNBodnRy65P0mt1ycf8GyWb8wz5ITHmHs57+EHSG29LhtIsXmgOvqBKty5ROa2cyC8zzW2lA=@vger.kernel.org, AJvYcCX/ySlqEMeepNB/kbtwKJhuLQdkJjnkh6BQdRC00s9J0bD+J4H4ZxVP92qonSwKlqHZdi4Wg0eSc6hJ@vger.kernel.org, AJvYcCXZuP7qOFKXyNziV0cRzpnm/VvrovoqEGGHrGPiHcOoEDMMzs0IJuSgeVIIn+OZ0p4xo8RX77D8+QMe8Wnl@vger.kernel.org
X-Gm-Message-State: AOJu0YxbzUQVGuK0/jyVa8V7v/0NKmNxrjyOc1XE8Nll+Gb4LQGvAv85
	3bthGtA0DVpYd+t4xVlKHu0WGuNCBpC5QAHoLlfXdLMQyKtTjdre
X-Gm-Gg: ASbGnctUMl8IETDnlwRSK00+xiboyLgBE2aMjKge9Z9AEZ7DOssxHuXOS2HR/T+GSFy
	T+3NKFxsuMqanGTabNP8SrXdeDtveQUOHJbCCnVYXnrZeuYbJzHmiWKdUk9mLs8bNbt8ARQyggA
	YVfvYI+I4MX6xmBM6Ew2GNKN5v8m/hP1eXmQWdu8HxXUu+gYJiWn6yt/aHCJxHUgmqW1waLS6hz
	dWzexY2HP/enwECYCyJ3+HVtfDUgBYiH9QgjYb/2tK2IIQ+Gj9fxzfo6hUGROwcqkZVYkewHkPH
	EurdEA==
X-Google-Smtp-Source: AGHT+IHtub8MZwmpbSi8cbBQN+W9HkJP6rT/9hlN4QVwtkTVtRbw9Ou100Gw25JfII1BdilNaat2zQ==
X-Received: by 2002:a05:600c:3b16:b0:434:a4fe:cd6d with SMTP id 5b1f17b1804b1-434a9dc02c5mr218940475e9.12.1733154319958;
        Mon, 02 Dec 2024 07:45:19 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78120dsm186781435e9.24.2024.12.02.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:45:19 -0800 (PST)
Message-ID: <674dd60f.7b0a0220.2ba255.7b7a@mx.google.com>
X-Google-Original-Message-ID: <Z03WDRk4dKxQZokO@Ansuel-XPS.>
Date: Mon, 2 Dec 2024 16:45:17 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
References: <20241202151228.32609-1-ansuelsmth@gmail.com>
 <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqrY7uLD8ATqH0LghmkHgApQSsGtvGkOTd8UVazGu0_uA@mail.gmail.com>

On Mon, Dec 02, 2024 at 04:42:33PM +0100, Ulf Hansson wrote:
> On Mon, 2 Dec 2024 at 16:20, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Document required property for Airoha EN7581 CPUFreq .
> >
> > On newer Airoha SoC, CPU Frequency is scaled indirectly with SMCCC commands
> > to ATF and no clocks are exposed to the OS.
> >
> > The SoC have performance state described by ID for each OPP, for this a
> > Power Domain is used that sets the performance state ID according to the
> > required OPPs defined in the CPU OPP tables.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v4:
> > - Add this patch
> >
> >  .../cpufreq/airoha,en7581-cpufreq.yaml        | 259 ++++++++++++++++++
> >  1 file changed, 259 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> > new file mode 100644
> > index 000000000000..a5bdea7f34b5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> 
> [...]
> 
> > +examples:
> > +  - |
> > +    / {
> > +        #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +        cpus {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            cpu0: cpu@0 {
> > +                device_type = "cpu";
> > +                compatible = "arm,cortex-a53";
> > +                reg = <0x0>;
> > +                operating-points-v2 = <&cpu_opp_table>;
> > +                enable-method = "psci";
> > +                clocks = <&cpufreq>;
> > +                clock-names = "cpu";
> > +                power-domains = <&cpufreq>;
> > +                power-domain-names = "cpu_pd";
> 
> Nitpick: Perhaps clarify the name to be "perf" or "cpu_perf", to
> indicate it's a power-domain with performance scaling support.
> 

Will change to cpu_perf. Thanks a lot for the review!

> > +                next-level-cache = <&l2>;
> > +                #cooling-cells = <2>;
> > +            };
> > +
> 
> [...]
> 
> Other than the very minor thing above, feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Kind regards
> Uffe

-- 
	Ansuel

