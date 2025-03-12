Return-Path: <linux-pm+bounces-23900-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB582A5D5D8
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 07:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF38516B873
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 06:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B11E1A31;
	Wed, 12 Mar 2025 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvIF7ate"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4D1487ED;
	Wed, 12 Mar 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759394; cv=none; b=sPc8w433SXfO1I+N+4jUGVUHGpuHg/q5q2VAQTPUKQ74dfuKCKSDIGN00rym2GVqdZhHQ92rA+TqIHbGv+1dxgbEU9gMbm+WfMRPypZ5f+K/1mcx5nPz5oW534OMiqsAMzVrWn+62f91Li3FtGi49JI7dKUAWWDeQM1vPSxlNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759394; c=relaxed/simple;
	bh=mFfg66gviZajD4Q1ws4MjdZwN34o3ioAoOTCBaDRiQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raxe+q17D2EdIdVCnXGiR2DsXH4xtPHzYMNOtZcpVVI2kb5DX9IT39t9WRryJRLa5veuBjMMLlzHTFwvRIou5KeWngcN+R3TihVW5v9lnATcyek3WfpZ56z1Rgc0tcBFY//t5Er9FmXEIscAtY7AotwSt+H7SfkjQL6IXCIK5rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvIF7ate; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso34767955e9.0;
        Tue, 11 Mar 2025 23:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741759391; x=1742364191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhZ2CoPd7uOnW/0f/tXunvBKPKyWXuFKYoLFAcHNHms=;
        b=dvIF7ategN3J0K9XUEVoZTeEKf0ykNwF1uo9CkE0zlTrxr9tis8kamekzNY3SxU0BJ
         M9NhcOhAMHszFyt6qsOIaV8tfIlBBei016MzE2sJr4UEKpm7Z/xBMlqGzkdhACuJccjk
         JWJ/eVVGgpH+PlqMMvc6DiLwqneKwseswERvZ4iUI/7YAMgu0ZQCooq5nceTRH+HFM55
         ujjmQU7GR4bjZ8owSP0QCee667rs3F5VAVyJ+CW9jENe4pB91gy3Plcae7d0MYXx7Sep
         qOyZ9WJuiVc9BB38qSVGD9c+HLBDkxl8nF5MV4qSDAz9RBVdvXZDXUdbyFFd2vz+iNSm
         k4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741759391; x=1742364191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhZ2CoPd7uOnW/0f/tXunvBKPKyWXuFKYoLFAcHNHms=;
        b=F1HwZfVgtliNtapGR+bXZ6o51L9oSwR61I0NnnsknJm5b0+jOesDtVZBoYHE7JAyLU
         0yH6AXgPiXeftixgQ/evne8CoZpKylSd1jSNJ5lS0eFC3spiwr5U92PZLv3sWgRfAfSx
         aYt5QjsZmKB+gjOqebEgg2uXL/MqFkmCoxUxGVirbjE1LFvbmQlTC2X8updVaAl0cuND
         i200VHCcKIgWk4D5xuWixnavJwBfKpQPKbKi9PmFMbJwkcCsyW3n07DMhOcMsC+kwQ+C
         3alJd1/oNMrJxB0/pnUyZvw522myq+tl3y9O863oZhKwrfvQ/cBgPo4DyNRRAWov9xFA
         he3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9YL+FV+wl7fgzan6hfhdpaQG648qdYcxj6N5VteGmM5NnBiP8H4HcRHVcqUJDrk1PJSYkORW1Zo/z@vger.kernel.org, AJvYcCUvyidfjI53y+C9LRrELalkbeUNwRZLSskpxf0zwnJnjumnLLYe5vzPnElBGvwi9FpD/C9b17IuJmk=@vger.kernel.org, AJvYcCVEUAmgjVIqO2nkOa1l4pEb8Izfg0yA6RN97r629qPpHkuGzbjodu2zd4kIjkx1kQJPhaXKmZBcUIPbApkr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5cyBRaOqrJ4jdScbF7Kt4Jnkbf/1ioqI2cQahjgaQ/gJWNHKC
	MLAo4PFL5VRsW6RCnyeQLzhaWfHzyZUg1Nw5sGSMKrSQUg75SvcKlVbTn4JTNaHAiAG+I+xKq4N
	MkmPo3KUvfMMQkdnDbkKPYjY2+0I=
X-Gm-Gg: ASbGncsDXU44Towh1cYW9FAdik7BnCe5oQYvUga151ovk0dT+WyNp+IwqykvZ2es5ct
	FXmdllibeP4ktGK8xE+PtpTw4jsvndsvnlTR9oC5cHj28WY6AUT+e3D4xZhIZD/6WA6vingO38s
	SpZNoBDbomlfwE8QQPsuVMv3F/2ejUmPm2WUnaTQ==
X-Google-Smtp-Source: AGHT+IGFacyRluW++PzGE9TWO9sc3w7FuFcdHB+OsQjorkm9i7HRtW4JOS/V14B8J2AgwovvfT5Ll+F6R6C4a2aAJlQ=
X-Received: by 2002:a05:6000:1fa9:b0:391:253b:404a with SMTP id
 ffacd0b85a97d-39132d30c5bmr14787515f8f.8.1741759391111; Tue, 11 Mar 2025
 23:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310080237.7400-1-clamor95@gmail.com> <20250310080237.7400-2-clamor95@gmail.com>
 <20250311193732.GA4183071-robh@kernel.org>
In-Reply-To: <20250311193732.GA4183071-robh@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 12 Mar 2025 08:02:59 +0200
X-Gm-Features: AQ5f1JrTY6sQtO0jSmZm7bBRkqQ2y-Jrr7Sqsw4oOyLF0-6lpmkV9smnWOdfZBM
Message-ID: <CAPVz0n09ZP1i2tasdTvnt8RvjhALvUYjv9u_EGRtnXPOYQtuqQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Document Maxim MAX8971 charger
To: Rob Herring <robh@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 11 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 21:37 Rob =
Herring <robh@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Mar 10, 2025 at 10:02:36AM +0200, Svyatoslav Ryhel wrote:
> > Add bindings for Maxim MAX8971 charger.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../bindings/power/supply/maxim,max8971.yaml  | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/maxi=
m,max8971.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max89=
71.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > new file mode 100644
> > index 000000000000..d7b3e6ff6906
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8971.yaml
> > @@ -0,0 +1,64 @@
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
> > +  maxim,usb-connector:
>
> Just 'connector', so when we have a 3rd case, we don't have a 3rd
> vendor.
>

Please, please be explicit and specific, you could not tell me this in
v3, you could but you decided to fuck up v4 as well. So wise.
Additionally, if you want a generic 'connector' which can be
referenced as 'connector: true' then add one, ATM this is classified
under your own terms as 'vendor property' and needs a vendor prefix.

> > +    description:
> > +      Phandle to a USB connector according to usb-connector.yaml. The =
connector
> > +      should be a child of the extcon device.
>
> 'extcon' is a Linuxism. Is there an actual requirement here that's not
> *current* Linux requirements (which could change)? I assume the
> requirement is to have vbus or some supply?
>

Pardon me, this schema is part of Linux kernel, no? I have no clue why
you collectively decided to just ignore external connector detection
devices. Ignorance does not affect the fact that such devices exist.

And no, it does not need vbus not supply, it needs EXTCON

> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        charger@35 {
> > +            compatible =3D "maxim,max8971";
> > +            reg =3D <0x35>;
> > +
> > +            interrupt-parent =3D <&gpio>;
> > +            interrupts =3D <74 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +            monitored-battery =3D <&battery>;
> > +            maxim,usb-connector =3D <&usb_con>;
> > +        };
> > +    };
> > +...
> > --
> > 2.43.0
> >

