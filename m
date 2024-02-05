Return-Path: <linux-pm+bounces-3377-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DC84964E
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 10:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AFF284695
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F312E72;
	Mon,  5 Feb 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi3VjbOL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C4134AE;
	Mon,  5 Feb 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124835; cv=none; b=Z8A7ImNT8DD8PM9CiY17wPav9VjnnR54gjeeSysMSPq/7I/QYVBN3PsKVY7gOHsYQznQMpeuzZKohzrVmyuy2RuNY7kTJVfCIubAxuyOF5tlUXqPNXAqKowcI7wOKvjTu6nYeE9FP4HwDzM4fKAX8p6WhgWtPKUBdEJnMKMN2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124835; c=relaxed/simple;
	bh=jqinj0ut/CqI57smR63XG2qy6eom91utqBZVLxA/thk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTM+B/0tjO1MhhoaDUEWxItr9ciYCP1JfzKyMf7Pw/BVcDReNWprovuLgOEtn6s8FEIX7JrbfvL03w2hgXerdaj32iUB5Nij6WQCBFWiEQrZRGCtXmNl4wiPODSDPcQ3eDqykCMCxC6U2zNN2oym8phv1Y1yiIhZbeT0AmSua+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi3VjbOL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0a4e8444dso10999761fa.2;
        Mon, 05 Feb 2024 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707124832; x=1707729632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4bQlWx9leMvsqboETb8wKN8mW2NDq+Tu6eiQDRS+co=;
        b=Xi3VjbOLiO3D+rLNUJM8Nrq/T5OMMn4xQdEMpcdq7ZXhWKsEZgAcy8sjUgguNtZfKk
         mtHQeL6WEMBMDXlkSErTAB9mNo0cv53LwLtH6XTOCLs40ZOYQse4NZxKCmIuUQtueWhp
         3mfymTcU2CN194hEh3sCVZQW8KdFO6ASoH/0TFnqxp6I0iBj3HDV2znq0tBqPNgqJTIX
         EjxCR0GfEHrwspm+djKz+mEBp3if/6xr29AP4ORSWg3URRFwG1wqlhjVTMydR76qnbUr
         d0g8MQFli4wjjBDManpQ8fh7foCD0MD94NVmLs4HpTYV0J+Bu0aanolwkKT1KX8ymrsJ
         gOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707124832; x=1707729632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4bQlWx9leMvsqboETb8wKN8mW2NDq+Tu6eiQDRS+co=;
        b=bfcwyBOQj9iECuUHiy++hTS9hLK3T9OEz3+75a3QpakeFN5PHGQsqNEJYqAv5lDU4I
         E7U0kToYgIK0ZXzrKUk45xjFgIGRbruPxpXKCJZDHSbJfeniQsunemQCJGfaScmLAOXv
         zKHYgIkOxx3runUhHU0jOFzjbCtcV5BMyvOSmO0H16AYxxbgcnkxxaZ8icj1JbZyoUMS
         vQbPZ5c6QbwDve7A9qy1I/uGWnvitzFQw4Q438YiwIzHF4IpC/sWFuw0Y8i4mJ7+MtcM
         uLolG4b5V/hl+spUfviYycqFHfR2OalTEfROT+c1ApnHyTsF56XM67Es5EutD+8yxvNS
         DG6Q==
X-Gm-Message-State: AOJu0Yyx1hWF0WRr5cXsjLXvPz/f/mP64EDMpU0t+IXIaKw3F/4Kys6J
	adPYYvYsxilpMF0hkPYRrUD4WFBj5k+c7BZd1NhACz3La4niKzzyFzkr0o0IgIQxsgkWOSeJrLY
	8kBugWTPOodhCsFgiZv1wb1nJUN5yTM0QUMZbjQ==
X-Google-Smtp-Source: AGHT+IEJBT8ynxGibd17Lu89o7u2txt2p6bmk1fews8w5O1Em49BfLoxyO5zalLY1E0WHxr3uMNWq5eTFX7VrrjFbos=
X-Received: by 2002:a05:651c:1582:b0:2d0:4c65:f09f with SMTP id
 h2-20020a05651c158200b002d04c65f09fmr10039835ljq.7.1707124831853; Mon, 05 Feb
 2024 01:20:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131102656.3379-1-biju.das.jz@bp.renesas.com> <20240131102656.3379-5-biju.das.jz@bp.renesas.com>
In-Reply-To: <20240131102656.3379-5-biju.das.jz@bp.renesas.com>
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 5 Feb 2024 09:20:20 +0000
Message-ID: <CADT+UeAatuHFe+-Fo9xQaqApF7rOGPuMZSRjVN9GbgHhaxZAGA@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND 4/6] dt-bindings: thermal: Convert da906{1,2}
 thermal to json-schema
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Support Opensource <support.opensource@diasemi.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee Jones and Daniel,

On Wed, Jan 31, 2024 at 10:27=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.c=
om> wrote:
>
> Convert the da906{1,2} thermal device tree binding documentation to
> json-schema.
>
> Update MAINTAINERS entries and description by referring to
> dlg,da9062-thermal.yaml binding file.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I missed adding Ack from  Daniel[1] for v6 version. So adding here.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[1]  [v5,6/8] dt-bindings: thermal: Convert da906{1,2} thermal to
json-schema - Patchwork (kernel.org)

Cheers,
Biju

> Acked-by: Lee Jones <lee@kernel.org>
> ---
> v6->v6 resend:
>  * Added Ack from Lee Jones.
> v5->v6:
>  * No change.
> v4->v5:
>  * No change.
> v3->v4:
>  * Restored the patch from v2.
>  * Dropped example
>  * Replaced enum->const for compatible property.
>  * Added Rb tag from Rob and retained Rb tag as changes are trivial.
> v2->v3:
>  * Fixed bot errors related to MAINTAINERS entry, invalid doc
>    references and thermal examples by merging patch#4.
> v2:
>  * New patch
> ---
>  .../devicetree/bindings/mfd/da9062.txt        |  2 +-
>  .../bindings/thermal/da9062-thermal.txt       | 36 -------------------
>  .../bindings/thermal/dlg,da9062-thermal.yaml  | 35 ++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 37 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/da9062-ther=
mal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/dlg,da9062-=
thermal.yaml
>
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documenta=
tion/devicetree/bindings/mfd/da9062.txt
> index 154c31fa4443..c8a7f119ac84 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -88,7 +88,7 @@ Sub-nodes:
>
>  - watchdog: See ../watchdog/dlg,da9062-watchdog.yaml
>
> -- thermal : See ../thermal/da9062-thermal.txt
> +- thermal : See ../thermal/dlg,da9062-thermal.yaml
>
>  Example:
>
> diff --git a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt=
 b/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> deleted file mode 100644
> index e241bb5a5584..000000000000
> --- a/Documentation/devicetree/bindings/thermal/da9062-thermal.txt
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -* Dialog DA9062/61 TJUNC Thermal Module
> -
> -This module is part of the DA9061/DA9062. For more details about entire
> -DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da9062=
.txt
> -
> -Junction temperature thermal module uses an interrupt signal to identify
> -high THERMAL_TRIP_HOT temperatures for the PMIC device.
> -
> -Required properties:
> -
> -- compatible: should be one of the following valid compatible string lin=
es:
> -        "dlg,da9061-thermal", "dlg,da9062-thermal"
> -        "dlg,da9062-thermal"
> -
> -Optional properties:
> -
> -- polling-delay-passive : Specify the polling period, measured in
> -    milliseconds, between thermal zone device update checks.
> -
> -Example: DA9062
> -
> -       pmic0: da9062@58 {
> -               thermal {
> -                       compatible =3D "dlg,da9062-thermal";
> -                       polling-delay-passive =3D <3000>;
> -               };
> -       };
> -
> -Example: DA9061 using a fall-back compatible for the DA9062 onkey driver
> -
> -       pmic0: da9061@58 {
> -               thermal {
> -                       compatible =3D "dlg,da9061-thermal", "dlg,da9062-=
thermal";
> -                       polling-delay-passive =3D <3000>;
> -               };
> -       };
> diff --git a/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal=
.yaml b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> new file mode 100644
> index 000000000000..206635f74850
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/dlg,da9062-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dialog DA9062/61 TJUNC Thermal Module
> +
> +maintainers:
> +  - Biju Das <biju.das.jz@bp.renesas.com>
> +
> +description: |
> +  This module is part of the DA9061/DA9062. For more details about entir=
e
> +  DA9062 and DA9061 chips see Documentation/devicetree/bindings/mfd/da90=
62.txt
> +
> +  Junction temperature thermal module uses an interrupt signal to identi=
fy
> +  high THERMAL_TRIP_HOT temperatures for the PMIC device.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: dlg,da9062-thermal
> +      - items:
> +          - const: dlg,da9061-thermal
> +          - const: dlg,da9062-thermal
> +
> +  polling-delay-passive:
> +    description:
> +      Specify the polling period, measured in milliseconds, between
> +      thermal zone device update checks.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2aab4f5d634a..f4a7bd8a1a04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6171,7 +6171,7 @@ F:        Documentation/devicetree/bindings/regulat=
or/da92*.txt
>  F:     Documentation/devicetree/bindings/regulator/dlg,da9*.yaml
>  F:     Documentation/devicetree/bindings/regulator/dlg,slg51000.yaml
>  F:     Documentation/devicetree/bindings/sound/da[79]*.txt
> -F:     Documentation/devicetree/bindings/thermal/da90??-thermal.txt
> +F:     Documentation/devicetree/bindings/thermal/dlg,da9062-thermal.yaml
>  F:     Documentation/devicetree/bindings/watchdog/dlg,da9062-watchdog.ya=
ml
>  F:     Documentation/hwmon/da90??.rst
>  F:     drivers/gpio/gpio-da90??.c
> --
> 2.39.2
>

