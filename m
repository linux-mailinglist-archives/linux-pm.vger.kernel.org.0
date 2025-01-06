Return-Path: <linux-pm+bounces-19979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FF2A02062
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 09:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D21C3A52E5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2025 08:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00C81D7E45;
	Mon,  6 Jan 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViMH81LL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72F81D6DB1;
	Mon,  6 Jan 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150915; cv=none; b=bTvvppr6Qxs/N/avigLqyBG+01UYIfX6PH8d/CgGzBhiBtnuTVK8xtUYbWhrufX/pE7ckiiJWbuOpnhPVdEy4pvsf0LNyHdYprvbuXGSIxpAH6azqehnnsHA8oRIhVUIAeW2WewXM6y5jcvyF0USG1EjY1JtR1NM3mWbQrousOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150915; c=relaxed/simple;
	bh=wHGu/oSSwQUbQ328emg5bZckBobIHSpMg0a2PmUbvwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkXZzDIoTpRANBffRoRox4EXRBygbkKX6judNWOafbLw6JKyf59twMCl4PjsbgiME7ZOaQ9laXCa/H6Zk9dmwkqOmjaw1b6nFTuuMWgJpsqPIeqQvWMGcSqcJ6xu+ap6Fhx81mF1bRLtLd9WNiUywZrV6hmDPW/5FC3ONBqRuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViMH81LL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso16165867a91.1;
        Mon, 06 Jan 2025 00:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736150909; x=1736755709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miofxZI6eA3394zdcfXv5+YqJvoJUfGSz5V6LgQvf58=;
        b=ViMH81LLGD3HHJYUMeVONlG1cf/a0FxNl9KiT+WkyBNtScMj1vUwRwhaRPTxNh/c1A
         IMQ3LwKaVW25ZozeGa0sENsn+Nitl4fqGJe51oQHd3FIf57zS41KGEG7HdtEkpu2cu+m
         2mkPSprjaU8QbcGBWpyQgcUD7yoyV1QobA8ypXSKEC71dUREuIndo1lBcbSDoYzc8ZWk
         57wUkiaQ462k5VPT9rpWjLwGS6uTMlgItyTqADSIEptG/VM0FmPqSvQspDNzeTxyQiBK
         NlV90tcb1I7BDTpaA0Yd1tGsy+wT8BzFGXEb9ujcd7RAQRUdLw381man/FOGvGfF7YWH
         Efxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736150909; x=1736755709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miofxZI6eA3394zdcfXv5+YqJvoJUfGSz5V6LgQvf58=;
        b=M9JRmBV0axYBDBentYAZM/8bhDkvFw4Xv8dvJnDm+iWuSvI0A5BbAB4KXqMjkoa0Jd
         23DBenR+XZu69G5SH6DttTFOZOhDM/mvMkB/xO8+UV3JDet+YWIGFU5w1gw0VFhy/m8N
         kAwirGZutUxhdSRCWHD83wnBgsqM4ya8DUZMhTWiiQCFUX/OLMssDgijN0doZmZXAc7C
         jG4OcxmQLc3MD27hnEctzPoohSogvFXJdN6Io1IE7sSkEvvmW5+5sj2reEoN69oWTqVy
         2Uz9vsiOfJyEcCOYDoZLDW2gIAELQ3Vfrz7iZcna/qviDfwVp9O70pGT2iEpR2+5RZU7
         HJ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVBArqLorEi5SKER+3e4BeUAZqzj0AjrlrqTHwFvP8xYhBvKWL8az/uec6w8oImw28Yp0fUjCIldFw=@vger.kernel.org, AJvYcCVb+pASWhmj+ExFvzEo52OgbIcVXrdtWdKe0V7K71igOvPdDwpe673KandRh9T131x4mFksRIyf0lR6@vger.kernel.org, AJvYcCW6sgn/c0paROiQbxxSBYpo4aelnPPB+sohbMh7EOh0BxIRYXESsaMYiRFX2QwRBx5/nGRaF6w4vDwX++s=@vger.kernel.org, AJvYcCWDctfJlbZTZ8Zmi3A/xNuxqT9sjkQVsrCZsNubakA+LVcnbkZOk3NYT46wX6dlOxxVPldjv2ZM7EHRxFdYwg==@vger.kernel.org, AJvYcCWMbWrnGHrrMtgVJG/33QA0mnGXemeC/ywOqtMMEI4nRiy0bODm6STqwoxa2o0habjDEkQjr5ZK9wKYj6XvDM5LNpOafg==@vger.kernel.org, AJvYcCXYXcdyBDmFEKD5HSbfeTr6SOPH5Ufxmf3EID6oYtxOKW0yrD+cuiB1f0OQr3pnrvpRs+504/g2b3Yf@vger.kernel.org, AJvYcCXzLk7yjHUkJcB4fjp+ECmqhuQIg4ZsEMYAeBKamNSFfdVgOT1GXqPS1aAd0L4QdrPs4x1hgJ7vCS2gGXzk@vger.kernel.org
X-Gm-Message-State: AOJu0YwwbPDH2sZtTSph9a7GdiF3aQgZXdov4KXiXTmA+ocG42ZXtXHs
	HcHOP1FOs6wlk5j4xxSyK6+/V4djrKVX3cCsXVoYBJ01Csj0G4xt
X-Gm-Gg: ASbGncuxreFZPvoUozfhyASodh9aXYi8EnnwwiE+p64BMv32kvVYa43tGUG6V+OCuJR
	r3GHbgg9ldVQABg+tla9UvhZPDT2ekpqNdAb2MfWIr0ZqDEkxzYKe1Pk+4Qlwidt5jOb3621IVh
	pyFZZvDkW7zhCEmIkGrNw+ySZ7AOIcBFQxRdUeFPYvt+uXO/Jphb7Jx/At+GxsGZswrYE4BADKw
	O/7zgWU11OTw+BbR92+BM6r4wqrwx6ImRWMPMjrgWmh5I8AbxN7P9g=
X-Google-Smtp-Source: AGHT+IGAiCuLKBYIm5kxkrIB5POZheZeFzEP+YXQx/K+Y9+0ooTv3Jv3BCORj3F89XQMRfCWUOpLwg==
X-Received: by 2002:a17:90b:134b:b0:2ef:316b:53fe with SMTP id 98e67ed59e1d1-2f452e4d0e5mr73686828a91.22.1736150908695;
        Mon, 06 Jan 2025 00:08:28 -0800 (PST)
Received: from nuvole.. ([144.202.86.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477ec330sm36530772a91.24.2025.01.06.00.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 00:08:27 -0800 (PST)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: krzk@kernel.org
Cc: andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	gregkh@linuxfoundation.org,
	hdegoede@redhat.com,
	heikki.krogerus@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	konradybcio@kernel.org,
	krzk+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux@roeck-us.net,
	mitltlatltl@gmail.com,
	platform-driver-x86@vger.kernel.org,
	robh@kernel.org,
	sre@kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: platform: Add Huawei Matebook E Go EC
Date: Mon,  6 Jan 2025 16:06:56 +0800
Message-ID: <20250106080657.240974-1-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <md45rp2dmv7aibez2sxwzyjayfi4wbujshlc46hxi6v4jzlhfr@tpbtqv46hrlh>
References: <md45rp2dmv7aibez2sxwzyjayfi4wbujshlc46hxi6v4jzlhfr@tpbtqv46hrlh>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jan 6, 2025 at 3:11 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Jan 06, 2025 at 01:41:55AM +0800, Pengyu Luo wrote:
> > +maintainers:
> > +  - Pengyu Luo <mitltlatltl@gmail.com>
> > +
> > +description:
> > +  Different from other Qualcomm Snapdragon sc8180x and sc8280xp-based
> > +  machines, the Huawei Matebook E Go tablets use embedded controllers
> > +  while others use a system called PMIC GLink which handles battery,
> > +  UCSI, USB Type-C DP Alt Mode. In addition, Huawei's implementation
> > +  also handles additional features, such as charging thresholds, FN
> > +  lock, smart charging, tablet lid status, thermal sensors, and more.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - huawei,gaokun2
> > +          - huawei,gaokun3
>
> Missing "-ec", because gaokun2/3 is the name of the board, apparently. You cannot
> duplicate compatibles with different meanings and if you tested this you
> would see errors.
>
> I think I might mislead you during last talk, where I questioned what is
> "gen2" etc.
>

Agree

> > +      - const: huawei,gaokun-ec
>
> There is no support for gaokun2 here, so I assume you checked and you
> know these are compatible. What's more, you claim there is a generic
> piece of hardware called gaokun-ec and everything in this family will be
> compatible with it. Well, that's my standard disclaimer and disapproval
> of using generic compatibles.
>
> So in general what you want here is *only one* compatible called
> huawei,gaokun3-ec
>

I agree with you. If there is a generic rule to follow, I am not familiar
with this. I have seen some bindings, using like this, so I followed it
recently.

properties:
  compatible:
    items:
      - enum:
          - vendor0,device0
          - vendor1,device1
      - const: generic-device


> > +
> > +  reg:
> > +    const: 0x38
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  '^connector@[01]$':
> > +    $ref: /schemas/connector/usb-connector.yaml#
> > +
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |+
>
> Drop +
>

Agree


Best Wishes,
Pengyu

