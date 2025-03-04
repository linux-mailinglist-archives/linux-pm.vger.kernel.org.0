Return-Path: <linux-pm+bounces-23365-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2D0A4E04F
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 15:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B866169609
	for <lists+linux-pm@lfdr.de>; Tue,  4 Mar 2025 14:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC51204F60;
	Tue,  4 Mar 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFZKL57U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1E204C0C;
	Tue,  4 Mar 2025 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097286; cv=none; b=g+ixyJS40SFp7vPW1MGPRX7T1zWZuxuvYsUbRH7UXXisElcEPp7k29ZV4rmckAjl3iinqdxY7bQN+XZPKBwC0Ojk3p0CR1K2MThMcGo1+tFDQmj+7JNjISG1/wXtpIMGbwTB2LkmO9eMAZOjKc7+huwbPzBIhMv+WBvQhKg1IqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097286; c=relaxed/simple;
	bh=Cg/Ftvcq4g405J0nOC5nO8bWo5QhMY6QKiYmQy3B+aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9PrT04LVFr2/P0t7Gt7hfsehI2RHFYizEFPZTEIM4+Swq8/wWX+WGqoGcdAoqeeJELqxHXg2bsu2FKbdPylRHwcyCek1aB4kkLgkO2zlfQs/CU19NuNOhnVaW7SIi8bcwY9/fIGGQ0k9BUvdHPWUwhqOGjK/ilwjnxVJnVnK9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFZKL57U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so3962190f8f.1;
        Tue, 04 Mar 2025 06:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741097282; x=1741702082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvjkoB4ZG7Joej4FKL3r9K9R6HaP9ipwwekkbFSDZQQ=;
        b=SFZKL57UvQv5H/OW++HlQIS35zFt7J1Yn66cwtv1SO2PMdsBAOw0LjKAFob3IfQKQP
         MSEbpjkzREr7tWDWb8/w6aIOP1oewpbFcfG8G9lm2oQxMNw/Z8ielNRMru/03IcsuhPQ
         bqFMXzv8XIegtgVNbbzkZTHP3f+ETOT/9ATxjIQbwyq5iNhkgPpbenWohz2kil4xlBHo
         ufEYlANm8+vgNNXN956cjlR0kA8O0ClVqg/pCvHi98ZL6eYCKgW/yP07U0Ejq3Qwe62Y
         6uGxr+H+8Md0RQztqcX6m6BmKkUZxXUHGPwcLIpNGnyURT7Yh2ViY4y/ZRbCCTjoAIvm
         PHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741097282; x=1741702082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvjkoB4ZG7Joej4FKL3r9K9R6HaP9ipwwekkbFSDZQQ=;
        b=ufXbr9Z6rKLqqa/Ob/9+Zm/KLUkxkvDfpoKZ0Bp7AMuOGttCRwt/34zsIQAznwwTsT
         IbP3yEHuYZkCih4EfG5psAAOQw58GL/rRD7dujAN8JC2kF5ucf79zI7qSgU2KBhxd+ZF
         dJbx5eej9LpJ/BVp4AgX27AH1IeCpiYi3hIXGyRQ/sbAEj3aqAU9e/kNDE8vPmQBAAWP
         zNaO+JaKgRv7027tnp9DTfJHXPhS3KyanYmGP7WMqgV9+GfZGQnph5pJeIW0Xqi4MBqI
         j8GFSnbdIUtB/pVrguRRPotYx+C/KF3QAtOabdMQXXmLVgn5CsJpb8gXEKYpHd1Rtes7
         LRmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6TqALus7seOHnLD2gpiLNyGXtihiAcqWtoWLvj1VurE989FR3gaitdEvlH4KVv8jyYxnmr29smU1XIZnj@vger.kernel.org, AJvYcCWUOgnIPxoPNsGqbNL45a///fi4/3mrfwp89A0tSKdnrXFdunT6/XovMsi5g8+bsGrb4xpeJf1Hd+Fw@vger.kernel.org, AJvYcCXMyC3FhlSeA1kLWEiDDI74QIEfd3q5t2Od4qvNFMeGzSdp4IA26zC2kvdmDug8TyOKp7yFR8cXAC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9U1ZuVZ82dL16M6JxdpqgQNh6wwntE2+VbSG7A78wN4DKvSa
	QvcMsOfx1LSyR0Do33qUd2jiqUPSCYh5bY77g6peEOzc3bTEWAFgtWb1J4lSeglLBXlRiNXQrND
	5zxvq0OjLP3xTd4LJj6L3/8dNoCY=
X-Gm-Gg: ASbGncsikDdUbzjTZQPM2QdlUU5d5soUdX5HV25AJSgT3w5ENI+yOMU8leVJoA6Uako
	DVm9Y4AhqEk7icdqxXcik2Lh+KJRe/wP/OlPBltI3DUf7J+F0JujsxKNf64kZugSY7DN24M21lm
	08BZwRCbbMYLSOjKBR6Q5c4P+wUNw=
X-Google-Smtp-Source: AGHT+IFjv5TSTzhlcWSOBo1x1W1IcoLqGnROypgybAmJGbAPlBuUel3SrpfN9aEUG/VwQ+frtIfmeqFR42TJ9PNvRqc=
X-Received: by 2002:a5d:588f:0:b0:391:1388:64b7 with SMTP id
 ffacd0b85a97d-39113886653mr4119463f8f.46.1741097282206; Tue, 04 Mar 2025
 06:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303115502.89457-1-clamor95@gmail.com> <20250303115502.89457-2-clamor95@gmail.com>
 <20250304135806.GA2503334-robh@kernel.org>
In-Reply-To: <20250304135806.GA2503334-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 4 Mar 2025 16:07:51 +0200
X-Gm-Features: AQ5f1Jp3ZVuELgXhuLdb11TgLn2mVZx5owqHAFTutB4Rua3nn4b59h4RukfJHGM
Message-ID: <CAPVz0n1gHycREMywHYtJWJ=Juk14bk3_pU_8Bhzu0kvXeiZ41Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 4 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:58 Rob H=
erring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Mar 03, 2025 at 01:55:01PM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for Maxim MAX8971 charger.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/power/supply/maxim,max8971.yaml  | 68 +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/maxi=
m,max8971.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max89=
71.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > new file mode 100644
> > index 000000000000..2244cc3d45a6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/maxim,max8971.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim MAX8971 IC charger
> > +
> > +maintainers:
> > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > +
> > +description:
> > +  The MAX8971 is a compact, high-frequency, high-efficiency switch-mod=
e charger
> > +  for a one-cell lithium-ion (Li+) battery.
> > +
> > +allOf:
> > +  - $ref: power-supply.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: maxim,max8971
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  monitored-battery: true
> > +
> > +  port:
> > +    description:
> > +      An optional port node to link the extcon device to detect type o=
f plug.
> > +    $ref: /schemas/graph.yaml#/properties/port
>
> extcon as a binding is pretty much deprecated in favor of connector
> bindings.
>
> The OF graph is an overkill here too. You should just need a phandle to
> the connector node.
>

What if extcon controls the connector? Why OF graph is not suitable,
it fits trends in supply bindings and it is optional anyway.

> Rob

