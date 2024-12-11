Return-Path: <linux-pm+bounces-19032-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AB49ECF33
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06A518874A8
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C851A2872;
	Wed, 11 Dec 2024 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqUSXot9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98419F116;
	Wed, 11 Dec 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929159; cv=none; b=OOLm07ja1fc6gPzPsagLSOUIvyvhmXPfp0U2EBrXuCYH/4kR1phuHyqQpXBHQFft2SxX1l82Y70idi9p+V/g6vjZHC4wddAdIg4qQf9Bd+Wlo6xKmwXo4hJmAEt8RV3btv2YG5lZ8KTXKgqjdLFJ8Gb5YM0K2GG69Xsu+GK07Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929159; c=relaxed/simple;
	bh=tm+XYf5eyhi5AgwnwhFjnz+5HTDe+tvhTnN4isbxBIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGIDRLO8RPGKfzIxOFSPG+BFmCI1sXG9+mXyHUUzOCA7SNELzgbT1lbJ0Ljs9WIL28vejv8xuGIXJ90+xO7V1tcz8bJjLdggiQIpjWjWEyNW2iOMTnu5jemQoJpAy7EGF2Y1iOb6Nyacar3B4SaU1T0Epq73upUjiipR6vqZc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqUSXot9; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c4c9349b3so1157916241.3;
        Wed, 11 Dec 2024 06:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733929156; x=1734533956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qISq7GajMdBCcxBbvv6KzdEHLpfNlyE+uR1h/30xNC8=;
        b=ZqUSXot9D9GoFGHIHt1/f2mzBl3Qz/F7E3gi6c6ZX961It8TFEfAye8FzQ1REylUKr
         xQ0V6i2HY2exMKDui/Db/F7CuiovehjgLhrpQ7R99oNezzENInG/37vYI1FdeNcRRBgz
         Bxx7rGhwOv7yp6mbadGcD/qlgtrJzVIFCiJn1iVyK8y7rFFJnXfJceObzDfphVpmQLVz
         WZpmeqXOuMMuKHcqhPDUW1PghCbWjZcUDKqkaX0+WBj1uo0UdkHaWBfCbvcBZvstWHhc
         p8aPwGxrUJLaNUzMAZdsjBFTEEgX0nExGi3WQFL4jHwoVTm3r2mmnHjWdLV8E0E0t2Pn
         vANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929156; x=1734533956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qISq7GajMdBCcxBbvv6KzdEHLpfNlyE+uR1h/30xNC8=;
        b=NUf4u3Sn1ySkD96jGCd2Hg1aokUiCtSqtphPMNfIHc1BBYEaOfPUnDa7mt2ZT2FAL9
         9c0Va5DkAorQfmPLQuK0e0hv13Ubfriaj2i5Mgk5PPgWBZ8dE6ATPE7zQ9my0Nc6Tii2
         PQqRaHvTaXHOXPkAYHESuru59VlEso6tI6IejQT46EcGsnDjq+lMvbZV3wS5ZWi1F/kn
         x7B0qNtdAnDx0HZVXTTu8JkLCJDXd7rHwtwHdffMxlbs9V1jN+yBtBr+LYc6gg02c1tz
         DZKSRY/g2BsRrE2T9yphwUkF/NWbcsU7P3gTDCiyBgO6mDaNT8DXnsee4uRMAwyFdFRy
         acXA==
X-Forwarded-Encrypted: i=1; AJvYcCUpKBy3c6Sz4+FGaUdCS0Ky2lRyTXZZcAlB+Uk0XqVZ+D75FFDv8qmu3hpMfUA6cuc6o1LDjxZOScoXJRE=@vger.kernel.org, AJvYcCUr2FjC6hAl0V4BMiXERVj4+A+ZlxyILcS1OdJa8fIQZfR8Pp1TahwGxKeNSZD8F19jStldfZcv+A1s@vger.kernel.org, AJvYcCV7aiQHcIPt58QyBIvCLLhw7bV0BF1tKyzMJOgtirs9fbj+z61EcI3GLKhLe++qrfqhm/rcBW4AGiQ=@vger.kernel.org, AJvYcCXMLfuSndeIf1xrCk2CWofc0lrgfWPlJJd45+P3NDqVmI/sRuTVXkxERZWoUjcZd0u6JyqU3gg7/mtFLA==@vger.kernel.org, AJvYcCXgsLj7cO28HHgKWMMMQGlhLDvLKKnY3wRZgbPzgg1syUs/5il25cSCVc2DxvQbYc2Up/GLZLXbsLX+nFJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YyBeUW/4HrBXYqZ7EH7J+pzu3Il52GK/uBT43wAfGWjPLY8ufxw
	4uPvymC899tJXyyog7g9mK9fpY/0m3HmLo8+0b3T+G6yBHgu+fexGsXGlx7TPgr5H9rceaB+BRT
	4mUGq0vdUy1fdk4zBVrtJrLPfrWw=
X-Gm-Gg: ASbGncuaynHAHfdk43aktfedFN7cAwQ2qtHnRFua6h4NtO1DhcKVkWff6O3V0SFvkNe
	+aAOTvR7qQ2EGIuCm7JLyRGtkndRaqMK2CQ==
X-Google-Smtp-Source: AGHT+IFDABXEejeuf1IKWb+Gu9FePZZpIgNOQ4IYdnMw3Kzd/38DL0IjJiFWqIpwT6VMj6TTqmfk4vxvTsyrCXE6AH8=
X-Received: by 2002:a05:6102:4b89:b0:4b1:5cc5:8ffd with SMTP id
 ada2fe7eead31-4b15cc59238mr3092106137.11.1733929156563; Wed, 11 Dec 2024
 06:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-starqltechn_integration_upstream-v11-0-dc0598828e01@gmail.com>
 <20241209-starqltechn_integration_upstream-v11-3-dc0598828e01@gmail.com> <7qt7thbuh5mvoaknxaiteusbmcmiusc23k2oiyvq3bwn4l6wsw@p4qid73hmiry>
In-Reply-To: <7qt7thbuh5mvoaknxaiteusbmcmiusc23k2oiyvq3bwn4l6wsw@p4qid73hmiry>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Wed, 11 Dec 2024 17:59:05 +0300
Message-ID: <CABTCjFD4ipvapWX9gJF1KXWpzj_jhL9pYB0z+Q4sEi-cu6mx7Q@mail.gmail.com>
Subject: Re: [PATCH v11 3/9] dt-bindings: power: supply: max17042: split on 2 files
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Hans de Goede <hdegoede@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 10 =D0=B4=D0=B5=D0=BA. 2024=E2=80=AF=D0=B3. =D0=B2 10:38, Krz=
ysztof Kozlowski <krzk@kernel.org>:
>
> On Mon, Dec 09, 2024 at 02:26:27PM +0300, Dzmitry Sankouski wrote:
> > Move max17042 common binding part to separate file, to
> > reuse it for MFDs with platform driver version.
> >
> > Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/power/supply/maxim,max17042-base.yam=
l | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml    =
  | 49 +------------------------------------------------
> >  MAINTAINERS                                                           =
  |  2 +-
> >  3 files changed, 68 insertions(+), 49 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17=
042-base.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max170=
42-base.yaml
> > new file mode 100644
> > index 000000000000..1653f8ae11f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042-bas=
e.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/supply/maxim,max17042-base.ya=
ml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim 17042 fuel gauge series
> > +
> > +maintainers:
> > +  - Sebastian Reichel <sre@kernel.org>
> > +
> > +allOf:
> > +  - $ref: power-supply.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxim,max17042
> > +      - maxim,max17047
> > +      - maxim,max17050
> > +      - maxim,max17055
> > +      - maxim,max77705-battery
> > +      - maxim,max77849-battery
>
> Shared schemas define only shared properties, not compatibles. But the
> main problem is you did not answer nor resolve my previous concerns -
> either this device has separate address and probably is a separate
> device on the same or different bus.
>
> Plus this was not tested and does not really work, but anyway let's
> focus on my previous concerns first.
>

Ah, indeed, the device tree in this and previous patches doesn't
reflect hardware wiring.

MAX77705 fuel gauge has a separate i2c address, i.e. I may move it out of t=
he
MAX77705 MFD node. However, the device on that address has additional featu=
res,
like measuring system and input current, which is out of fuel gauge
responsibility.

So I guess I should create another MFD for fuel gauge, i. e. max77705 examp=
le
would look like:

...
  pmic@66 {
    compatible =3D "maxim,max77705";
...
  };

  meter@36 {
    compatible =3D "maxim,max77705-meter";

    // max17042 fuel gauge driver in platform mode
    fuel-gauge {
      power-supplies =3D <&max77705_charger>;
      maxim,rsns-microohm =3D <5000>;
      interrupt-parent =3D <&pm8998_gpios>;
      interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
    };
  };

--=20
Best regards and thanks for review,
Dzmitry

