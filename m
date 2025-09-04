Return-Path: <linux-pm+bounces-33862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E25B44271
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2F724E5CD7
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8B1F3BA9;
	Thu,  4 Sep 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gw8efOoS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056227713
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002549; cv=none; b=PZemsxz46f5pjabz7kRvfZv3E7MfEVfwABH9Qmkm5010DG0TA/K/PGMp2oziKnUsej9bY03rSoqfFzI9kgYQBXKBfa3NZAX+uljkDoVqU4nRA/hrtvIGxnOmP90lNIzxbUl7lvI2RIkLVBMaAiJwh8aKEb58uFKRVYk3U+SINps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002549; c=relaxed/simple;
	bh=vze/ZlwTd5ppR7XiRhFX6wHetjbPSzhXTCHbwjcjWzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKM0fKIn1PeY6aztsz2fa0TVNdH9ONrtcX5DNL/LekfNpdniwdniwS8YEV9WNoXLSbusptPj1lZ1fequ6bLMYsD/PNa83XLQ7Bf+j9SIICz1bUnXe4XkIcoONTmdx+83Y2LLaregEC3oSnPgpCsH/DGxDiTsEGBicWkObQvap/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gw8efOoS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603b60cbso11680347b3.1
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757002547; x=1757607347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uo0RISLwmkgLCYh2IN11pINVWBVogTF0MXL6fRzX8kM=;
        b=gw8efOoSP0x2Bgv8VWhapuQ/gqlnXnPhm+T83NCk1694qd1QYa1Cnxw+75t1NgmQNc
         3Z5IGc1ANFKPVBH5IfrANYp98vENSbhF11/yPTji9x6X/lcZV3bpTXYM0/JN5zSmFmvU
         zlxdpdhgkG9OxN7aLRHHv5wwGxyaY4kMrk1gMLG9ZTs6fUPifcOdfL6KbVpgEU76JnDY
         tZrB5tq0kP4fRJLX+KXtpv2KgnVNEud4e3QIjsJayG6RIm9XBXZ+w3wJHgpd2bRalN/W
         qOpv0ibOv1N/3CbtnTx8SyhQTMzLCT5YtrdOwNYog1FsTdJKdxF2ZVoq0giPwYOIBcK8
         0N0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757002547; x=1757607347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo0RISLwmkgLCYh2IN11pINVWBVogTF0MXL6fRzX8kM=;
        b=BGvML+eO0+7v7xSas3GkH8v/+6omR/N26hZuG/ikBu5jrAQZOMi0RfKUHA1+HkeVbE
         1wsWGwQHg9XUUoGP276AwNpneT0LTHUFucmiY/TVdokvyBVywff6fZ5POYOyi30xeNNj
         FwHtfoS2w7lh4/Ecz2v2O2mEWMuKI5mYUH4PGYWFDWSp6YjqxGtI2nEJmc86Z7KeMLb8
         lfGYR+gDKdy3ECOzGAy+bSSWiC3JFQXngzH0z/ybWJlGQtrQT1OPlLa4k9/wipyvD4zw
         ILHeSC9iSH094YlBXMt1hfZTXyxdKvAucdZ4sSrMf7i1mOKNCPfoV9A4zM28WIcAVfPW
         ZP3g==
X-Forwarded-Encrypted: i=1; AJvYcCWp7wBDpGwYMw4vYaLZ9aRSwqHybrCN5x/WMo2OaSTzrCbTQM+5/Sn5CXeFP+ynLh/gKc4Z/j91jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpAeKx430/IlbVw9QlziSYj7W6b9ySFHPNQ2A7T8OOJbVnAYD
	5MQX7oOseO+Wfs0eT0pQLsbRepitsNl/StWo5B1XY5Gt3klCcYKaqdoGF6c8SUoGrrlmGOzcjQw
	fXXRjEMKq12WvlsJVjjHfwL6Hvuww3O8g6bQDQgghLQ==
X-Gm-Gg: ASbGnctQO0CqYCPstSg9lUyyL+KEznvY+KgaycbY9GfDde21SxH8KThnvIUtf+8l9Hb
	5NUXDp5tgt4n3yeRVEwXJu6vaOkBnktSGMIE8D474YOxi8ve3iCk6TMS/jmRD45c5nQ6x+aIHt3
	P5Rqao5eO7IDq/0cpkzCWjmHIQ9j/3X+aAvfNghcFxHTBArZeS6UvvopJc40EI1cdUyREjwT8F2
	aUxZh7e
X-Google-Smtp-Source: AGHT+IGSXAOQmOoToso0IfgUWvRUsTdb+WXo9AwnFjKjAqk7EZwQu7nr5DaxVSxNz2rwNfbQNvsp9DSe55yaj+5joiM=
X-Received: by 2002:a05:690c:3602:b0:71f:efa8:587a with SMTP id
 00721157ae682-7227656b2e1mr198475327b3.44.1757002546924; Thu, 04 Sep 2025
 09:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
 <20250822-pm-s6-s7-s7d-v1-1-82e3f3aff327@amlogic.com> <cce649b1-511b-4895-84be-2c85e748cfa8@kernel.org>
In-Reply-To: <cce649b1-511b-4895-84be-2c85e748cfa8@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 18:15:10 +0200
X-Gm-Features: Ac12FXzPPHOEhHKW5z-O62jRJm47PZ-fsc3O4NGHgJmoH8G2XEru5vbAJkJqx1g
Message-ID: <CAPDyKFrE8CafoKDkdHQKf=yxJjNcJUu9vFrpAASQYXhtUg6cVA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: power: add Amlogic S6 S7 S7D power domains
To: xianwei.zhao@amlogic.com, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jianxin Pan <jianxin.pan@amlogic.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "hongyu.chen1" <hongyu.chen1@amlogic.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 13:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 22/08/2025 07:39, Xianwei Zhao via B4 Relay wrote:
> > From: "hongyu.chen1" <hongyu.chen1@amlogic.com>
> >
> > Add devicetree binding document and related header file for
> > Amlogic S6 S7 S7D secure power domains.
> >
> > Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
> > Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> > ---
> >  .../bindings/power/amlogic,meson-sec-pwrc.yaml     |  3 +++
> >  include/dt-bindings/power/amlogic,s6-pwrc.h        | 29 ++++++++++++++++++++++
> >  include/dt-bindings/power/amlogic,s7-pwrc.h        | 20 +++++++++++++++
> >  include/dt-bindings/power/amlogic,s7d-pwrc.h       | 27 ++++++++++++++++++++
> >  4 files changed, 79 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> > index 15d74138baa3..12b71688dd34 100644
> > --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> > +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> > @@ -24,6 +24,9 @@ properties:
> >        - amlogic,a5-pwrc
> >        - amlogic,c3-pwrc
> >        - amlogic,t7-pwrc
> > +      - amlogic,s6-pwrc
> > +      - amlogic,s7-pwrc
> > +      - amlogic,s7d-pwrc
>
>
> If there is going to be new version:
> Please keep alphabetical order.

I have just applied this, so please send a fixup patch on-top.

Kind regards
Uffe

