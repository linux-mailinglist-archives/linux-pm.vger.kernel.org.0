Return-Path: <linux-pm+bounces-34960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20FCB84BAE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 15:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED6FE7A4F9A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 13:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0C72882A9;
	Thu, 18 Sep 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXxzNZJl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2293064A2
	for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 13:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200581; cv=none; b=BqhYKt93SvBelJ1sPBbHWcyBJFXSfvM14LfhWcw/5WAUpDdsccNQ7ZouDCELEgsgbTJynz0VGRNOOez8S1DTkuSkuqnZapqCmY574LN0y6E1hJE4feAbrmG/djWTfHV8oHhQlYfK4Kjxeihx/c7yQKg1seODnd7l/w/trWavQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200581; c=relaxed/simple;
	bh=xFgFQQBU+eaUTlmzE+vuY2J0SoHpSu7LpdqT0cdq3tI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNwzo4LQCv/NDiXdh8WEBgXUBchYhGKK8DYkbZWJh/DPlQK7q24djfhqjkNsv6W2r8Di9O1D/OSBuFcXKsxoT4/wWXwfseaaj/GHo7PZdIBOAyOzBt5TsgdpzG5xBer/CZlNZYQhCwGCyLYnOcy0nLlt7YUDKi64zBZxGk1jk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXxzNZJl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1100217f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Sep 2025 06:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758200577; x=1758805377; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xFgFQQBU+eaUTlmzE+vuY2J0SoHpSu7LpdqT0cdq3tI=;
        b=UXxzNZJlYwxqS2aMQJXXt8XjFFN2AyuJBeVxiD7DURnzmV79/h1WTluOjRLohmzf5t
         EMbQbp4uPeHECQ6mfYvFdyiBqAU6fLodUxyHBgRAjSKOCUMsXevchLbkz4GXUwJbj2Ms
         l4zBeTvBvCsn7+vcdKFymJGzR5NRNiCaqLV07fjpem4HY9kCtT1I930N+DxS3A5ZVHj1
         E235VkEc834jUZozXnMbXVJC7wACBfGjCN6H+rDDtAhpKMJmQHJdr+m5trzZ8gX7s/8h
         oD+C2Ch5aJLs7kK0I4/LinfIOVvcuR3QFxiQdOWuIadva57XtxpwnFHt+ssJe4+E6oc+
         9JcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758200577; x=1758805377;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFgFQQBU+eaUTlmzE+vuY2J0SoHpSu7LpdqT0cdq3tI=;
        b=La6aM5z8WOWC/3URTSMUww8mlNRKlZdYDjFMQfZ6DN4bQH2uhgKNqQ7Ti/n2IS9Vf8
         qXWffJ5KFq5DJ/ryteafi8ifn+Esq+PguRY3Oy2jKwj6QgzWiP6L0tQ+lZndV+Takoa7
         Am9S6CoObPkY0dKgrhrZjp2EBqKIZwzGCl49IRcZYgOsJLMygm81ezy+jiePPw5039Sb
         ubDGuPSp3g5cWQBTsGAqREbZLS0Bqec0H77mwNNEd8Pj+ULogYbgyDyoRrkn5H5q3ycO
         ur9gTIL5fylxN7SfXyfFbFSbB0ovkm5NNy80Rac6JxyUJGi9nuCI9j7i/XsXjWU62btH
         WBPg==
X-Forwarded-Encrypted: i=1; AJvYcCWy00BMOeoyC/ZCcYkvxoSsjzHlrcDw09M8bAir4gktLksUnAr20nD57fjQunEKMnSmUfyNuGUXXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2qQ/FgVBTu5FhKnLB4upLzRuR74kpVluhRxTgzocBxdT7371
	i9KmHTllJ7kqxNW3C4YmeKignI3Bw3jHSbgo1O6jET4RRrXFzJ80ZFvAxIW9ByGWs14=
X-Gm-Gg: ASbGncsJWtkWuBTR03mYTV36R4MvqpaF76d3rUtnvkpb9IhRdyPLWkuFVu+NUtEjulO
	HDglUGcym9QQHRCirADB/ZsrkEYby62bW5xq4nsDqyV9suwP57KXHkPUUgbm6K8FWEcXNAtCNWv
	hWbJdYarRUhIDpdi7h1YnCI2OhA5yj/25X1lZtMioX4kC5psc/wET/NWaSzi3Buyp+XkoxwaXsy
	IXmSQoPAIi/8Ga1wG0032BtQV04Tenbz+Yi3UhNl2PFBovccEGEOZLEn/MGOOUfPoip9Uqe6NB/
	kmmIw2DqhT+TfaOzK30Bu2uo+/LuzZHuYWDiKrlziZ6Ks9x5dJmBxEe8XSOZzKpwKxJLEHdCdYK
	2B9Groyfh/v/AKP7/DQ/hWvJEJS9WPlWObgKTyzYCVnlvSOXhvPI+pn4=
X-Google-Smtp-Source: AGHT+IH4qQOMI9kRkElC4uk5etAMC5b6ho5cgmHk+GAS+1rAKNDqsnHvTpg/dVWhQwEl7v3wwQvq3g==
X-Received: by 2002:a05:6000:2501:b0:3ed:8e48:640f with SMTP id ffacd0b85a97d-3edd43b5ffbmr2760931f8f.8.1758200577315;
        Thu, 18 Sep 2025 06:02:57 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d0asm3646419f8f.17.2025.09.18.06.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:02:56 -0700 (PDT)
Message-ID: <a55d7e6e6d9515293ca735f25ffd5c925a6ec617.camel@linaro.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: power: supply: add support for
 MAX77759 fuel gauge
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Thomas Antoine <t.antoine@uclouvain.be>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Peter Griffin	 <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 18 Sep 2025 14:02:55 +0100
In-Reply-To: <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
	 <20250915-b4-gs101_max77759_fg-v6-2-31d08581500f@uclouvain.be>
	 <20250915-presoak-answering-2df6fca532ad@spud>
	 <c5f2e6e8-2ada-476a-8557-85273b9a93b7@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2025-09-18 at 14:36 +0200, Thomas Antoine wrote:
> Hello,
>=20
>=20
> On 9/15/25 7:31 PM, Conor Dooley wrote:
> > On Mon, Sep 15, 2025 at 12:14:11PM +0200, Thomas Antoine via B4 Relay w=
rote:
> > > From: Thomas Antoine <t.antoine@uclouvain.be>
> > >=20
> > > The Maxim MAX77759 is a companion PMIC for USB Type-C. It contains
> > > Battery Charger, Fuel Gauge, temperature sensors, USB Type-C Port
> > > Controller (TCPC), NVMEM, and additional GPIO interfaces
> > >=20
> > > Use max77759-fg compatible to avoid conflict with drivers for other
> > > functions.
> > >=20
> > > The battery node is used to pass the REPCAP and ICHGTERM values
> > > needed for the initialization of the fuel gauge.
> > >=20
> > > The nvmem cells are used to get initialization values and to backup
> > > the learning and the number of cycles. It should work out of the box
> > > with gs101-oriole and gs101-raven which were previously running
> > > Android.
> > >=20
> > > Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> > > ---
> > > =C2=A0.../bindings/power/supply/maxim,max77759.yaml=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 78 ++++++++++++++++++++++
> > > =C2=A01 file changed, 78 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max=
77759.yaml
> > > b/Documentation/devicetree/bindings/power/supply/maxim,max77759.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..4d45739fcaf26273ec57b=
60049d6d0421df38efb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759.y=
aml
> > > @@ -0,0 +1,78 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/power/supply/maxim,max77759.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Maxim Integrated MAX77759 fuel gauge
> > > +
> > > +maintainers:
> > > +=C2=A0 - Thomas Antoine <t.antoine@uclouvain.be>
> > > +
> > > +allOf:
> > > +=C2=A0 - $ref: power-supply.yaml#
> > > +
> > > +properties:
> > > +=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0 const: maxim,max77759-fg
> >=20
> > Compatible doesn't match the filename, why?
> > I assume the "fg" is fuel-gauge, but can this device be anything else?
>=20
> The max77759 is a multifunction chip.
> The following compatibles are already used for some of those functions:
> - maxim,max77759 (for the pmic)
> - maxim,max77759-gpio
> - maxim,max77759-nvmem
> - maxim,max77759-tcpci
>=20
> The fuel gauge functionality that is added with this patch is very simila=
r
> to the functionality of the max1720x which is why the filename was chosen
> to fit other maxim fuel gauge chips pattern.
>=20
> Maybe it would be better to use the maxim,max77759-battery compatible to
> match the filename? It would also fit with the already existing
> maxim,max77705-battery and maxim,max77849-battery compatibles.

It also has a (battery) charger, a -battery compatible could be misleading.
The datasheet refers to these subblocks as FG (for fuelgauge) and CHARGER.
I'd suggest keeping those terms.

Additionally, the FG block can also measure temperature and battery ID. For
those, a combination of (top-level) PMIC and FG registers are needed
unfortunately. Which means that the FG should probably be an MFD child
device, even though the FG itself doesn't depend on the top-level. Otherwis=
e
it'd be hard to access the top-level PMIC register.


Cheers,
Andre'


