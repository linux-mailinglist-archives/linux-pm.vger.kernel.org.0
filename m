Return-Path: <linux-pm+bounces-23478-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CEA4FB24
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 11:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D862188B124
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD38205AAB;
	Wed,  5 Mar 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW/QLoWn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10C4200115;
	Wed,  5 Mar 2025 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169015; cv=none; b=iq0Z5BZGk2WDlS1oMxzYrIkrXrhi3uJLrOFL/aQn1pMj7tfCX/KU2Gyk2qgTbyTVKJyeEANfaK9v72EUHaeWiB/kKakCaEkK5D4eSxrPRjsg8fdGRy02Ob+GmynisBMG+gEJIU37Z45TzKCfJ2U2HDdTquBGn/oCvr0pFztQ040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169015; c=relaxed/simple;
	bh=aPO9RIxkIdPPlvg9pyNhJAW0yHevN9pV1Ngaf4quIxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWoDAPQUaNgKYIsTXibUVjY/tEkDWm6EjXVOdGKLBi8/3lUvZD5jxqxircgdx+9qy5G2qKtbiVftXdPevzNxkuWbYzGBiCQqeffE1S9cEtv01S62Vd4PtWKlKkOhY+OXZuPewOZC8Ifc+hfZg4qW8AgcPFtU53w+dh1Ka9Z+3hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW/QLoWn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43996e95114so44594895e9.3;
        Wed, 05 Mar 2025 02:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741169012; x=1741773812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jm2urNCVqHoRd5wzReBKDuMQJhyZ7sqv+hIxAxQv+aQ=;
        b=lW/QLoWnzZQSlr/F7JYj4JMQ3j9lOu2fHhczkla6Uv/2LvIWv791IvXTBhW+70NpED
         eH3w7J4hgTOc7C2ggKNzyjldZZMHs7m5E1mI9Q/uo6NWM3A4G3OF8TJyBpavNuGas+KM
         Gf6+jScheijOb/C4+7Ud3IvdQSro33QhAxKGbeE3otTN5PZTjyG8rpduTpjDCYoAuxAm
         /ruGr5Hkj/3ee04IrvxIjN77hkSGamoSv+abMUMi/IAQNIPz9dGsnyoIjnCAKNTZA492
         EfXKPNMN7KYyu5Cbe7XNG9TTYUsxGiFVDVdOLgnpxBYdzy3deQMdsyA13mYEH1ITB+X3
         MNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741169012; x=1741773812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jm2urNCVqHoRd5wzReBKDuMQJhyZ7sqv+hIxAxQv+aQ=;
        b=arNQHO6c0i+c8glAm/wb4RNFyrR6PQ5H3JMjTPoJsuoolTzyswXz17SM1UYm1I8KjC
         8WKa6aKFtYvsKGq/cwdRZBoEi2F0rUt1GO7nt5UJ8UdmHK8m9eu4o7lWOpvrsw5NJDxF
         J51XJc/0mx3MjFz9owZby6enXmsbbNFTt3Tz5HlnGkRsDQK5yJDbaiv5r5lNJNwHcuxQ
         W7/Iz96+0Kj/5Kyq3a2P9H92jUUj6thNWVRZ6UpDSvDK0TkKnhVV8dK5oXrWZnJqHdF6
         GZvcmNef/l/HZZk6KbGDHuLj9A7RDTofdte6Apc4oaRI44IuSlGvb35yYmZ83fwewI0l
         cflA==
X-Forwarded-Encrypted: i=1; AJvYcCWcdk/KuA4x3eUAV8DPtacOU0qKauLy6cezjx2PHcdG2m42JtlAAjaL1UlS5A1kUiO9waNFJPdCopWzLL9o@vger.kernel.org, AJvYcCWrcJa1udJ6fKBVQvO+zgamk9XB059VZ4KjykCQvtBEjJeyLT7Orc311TwZIacXbkHRNbV0VgUS4vuI@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYuw5ymO5PSfnrkUGHKtje6LnfXGPWtt7/4yCna2zV8a3NnWA
	EDQhWUKsvAumXPuba0oMB8fr1x4wLmRQGYUx82CkO2EtHmQzCTMt+13GptIbIB/RXIZzFEnojeo
	VRTsxyf8g6hI6BK3CL2jK4qVXi68=
X-Gm-Gg: ASbGnctC8PnjG0yChpAZlCyTfRjk7OIkvD1PghmbddRlUEQh3lairM4yihjKal9PG4A
	HWlUxN86iMUzRnFuYWftIPqYsVKiDBAeZOgJBmeQLXHb1/3d2tjFRRfN5FHLcDySimjmvjqhMxd
	TBksDiVzSnkNdC74gisV/MKY0GeqQ=
X-Google-Smtp-Source: AGHT+IEyE65DoXnnzoaY6Dd+bifIHkN+aBqHyvN9ORkP7Eg8LfPANJc22dF9nbVoro3kxEoOzWoqCz33vSTiT8uZe5I=
X-Received: by 2002:a05:6000:1f8c:b0:390:f116:d230 with SMTP id
 ffacd0b85a97d-3911f74bc14mr2432921f8f.16.1741169011692; Wed, 05 Mar 2025
 02:03:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303122151.91557-1-clamor95@gmail.com> <20250303122151.91557-2-clamor95@gmail.com>
 <08f305fa-0dbe-4ed9-bec5-cf8b5bbecfdb@arm.com>
In-Reply-To: <08f305fa-0dbe-4ed9-bec5-cf8b5bbecfdb@arm.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 5 Mar 2025 12:03:20 +0200
X-Gm-Features: AQ5f1JoUlqaP2Ry2sjnxepz1PGhvPG05_H2GZBUkF7PlNMR63DMRDp_U0g1avRQ
Message-ID: <CAPVz0n0G+0_f3MONV0Y-tYAb1KOwkUNiY2Pms8CZ6ZGtxRmFFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	Laxman Dewangan <ldewangan@nvidia.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 12:00 Lukas=
z Luba <lukasz.luba@arm.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
>
>
> On 3/3/25 12:21, Svyatoslav Ryhel wrote:
> > This implements a mechanism to derive temperature values from an existi=
ng ADC IIO
> > channel, effectively creating a temperature IIO channel. This approach =
avoids adding
> > a new sensor and its associated conversion table, while providing IIO-b=
ased temperature
> > data for devices that may not utilize hwmon.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >   .../devicetree/bindings/thermal/generic-adc-thermal.yaml      | 4 +++=
+
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-ther=
mal.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.ya=
ml
> > index 12e6418dc24d..4bc2cff0593c 100644
> > --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yam=
l
> > +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yam=
l
> > @@ -30,6 +30,9 @@ properties:
> >     io-channel-names:
> >       const: sensor-channel
> >
> > +  '#io-channel-cells':
> > +    const: 1
> > +
> >     temperature-lookup-table:
> >       description: |
> >         Lookup table to map the relation between ADC value and temperat=
ure.
> > @@ -60,6 +63,7 @@ examples:
> >           #thermal-sensor-cells =3D <0>;
> >           io-channels =3D <&ads1015 1>;
> >           io-channel-names =3D "sensor-channel";
> > +        #io-channel-cells =3D <1>;
> >           temperature-lookup-table =3D <
> >                 (-40000) 2578
> >                 (-39000) 2577
>
> Do we really need this change in the DT?
> Won't the code in the thermal driver that registers a new iio device
> would just be enough?
>
> I agree with Rob that it looks odd.

Building tree will complain on missing cells property if you try to
bind it. It is not in required category anyway.

