Return-Path: <linux-pm+bounces-32776-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF93B2EE7E
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A69AA05697
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8862244692;
	Thu, 21 Aug 2025 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXujOBQa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3119047F;
	Thu, 21 Aug 2025 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758763; cv=none; b=PhVlBI+k9+4nHCbxY7O2ZpXlaJ4KMTP4hGwiAW8/8R8s1w4NCWNuy2TRzVyoI7xKtBhoeGMJr9yIM9diKHUmsJto4kCX36/AaJFSS8hrQIcoD49E6DzTQhCbY8AeTMOravKEw+qKOErLmSV7PgxTWkyMY1+zJXQH8+m10PWUQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758763; c=relaxed/simple;
	bh=oBwPDZXX3KOkpIoUmCaMcfZGJPlZNWTmlwvi8mY8yv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0uDIkLC+CRc8MOR7C3CQTf65C1gC9T3pKt4+9BjT6wIHrpC74B7Kp2I9BrN6GXN7Bo6jmk89fdwSrZ7/1ofMJdv8y1kWE/bcj1o7wHbgAPbbB6mYXO1YjVpGA+84JNTCWgq8QHPP2rhmB+reGruKDLFyMq0LL2yxeJ+r2A7Dwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXujOBQa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so11358505e9.1;
        Wed, 20 Aug 2025 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755758760; x=1756363560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vySJJlycB8sAhA00gy1auHre6+C0cbwZ/xtdefFT+k8=;
        b=SXujOBQag3Lzuh7c7nibUyBm/mL2eT4gFaPqcCVI56alwiKmAwwNqsx/F85svQ9qL8
         NK+ICk7o8DuRpPPZHQ+rqG43i6qgySbqYJ1m9GrE5vvzAp62z1Z7CdhXJLR+YAiejIS8
         Cj7p05abRE4MT/i5WVZNbbOd2PZt7YDli5L1FYl0P9cjF1l4BR/JBL5FwD6IhAr9qQ3P
         s5/5czRVC56pu+9piZACf1d+ZtmrMLZtn/d2PtcrYu+65Od0iWSl0eKkamOPEjtfepBB
         sP7TZhnnNgd0gyMUR1HcaCFrLjQ15H4wYAv5diJcOogW7riZJlnISpkEBA6gvsw0AxC0
         ubXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755758760; x=1756363560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vySJJlycB8sAhA00gy1auHre6+C0cbwZ/xtdefFT+k8=;
        b=l8KptdLW+w45GrvnuFvj4hMDRHBR8gksna+LsbIqFz3l20x1wImnLKiapfsjxbHVjU
         zaAtjJgOZS6pJKRneQsUDUQwdQJBIYaraTuWRNieMpJbg9TnRCrW1RKsmXukhk9E1UgX
         9UKGUIsE8LFRJ6Duf1tRxvHyo357K8556ox9ybkYchPC4F+wxk+PXnObNMLo6RE51Yjv
         aWQOZC/AqeiPoTkwg/rYe1xLWip8h47ZMoY9ZJ4SqbINciTRUlFHrwkAcFkiUph2lTVk
         UFAuvJQdwN4/cg78r5RmvaWmzNVo/yB590sHJaeVuP1dazfZSrFkUxPjhgW3ZLoPjNdF
         mr1A==
X-Forwarded-Encrypted: i=1; AJvYcCU0I/Tw1nFBedwgxz4Br1tWs+3PhCrweOTEDLCa6bx9kaC8k0FJPazoRFvHbnraLA9FVPEH4BbCzszdXKFO@vger.kernel.org, AJvYcCUuec2yfNtIcQTOSwwRY/fFXmQiYpRgaW9wYZglIC9I6iO+VBmculJqXLir93u1Qr6CnQj4DcuAdnP3Xps=@vger.kernel.org, AJvYcCVcQOl5/fPhN7bAYuGvNfXa3xX2wciN+DfHVMB4Z4rrWq2dThwIK4Gzj0/9Tt/t3uQQxzaSBJVODaw=@vger.kernel.org, AJvYcCWPlX6ekCxI5vk8gy5bNgJPVptNuD3aVXSOqLVP5AR/FW+ewMjIjalqrQ9IjeVhRB+tOjxIEmGkSapo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+qdGr3OviF01zqCgrC9Z1IavTsoWYkEbjw8PlpICj7I3yV3y
	otbwtWom1g+68PGHy7WLmcTQwqg8/3ORIdl0QXjllEdXi8/cwAOUWHBeOPHlJybC40KdMopyb+0
	jXa2nn5fL/rERD5BPTAt4RhII2Ym+iBw=
X-Gm-Gg: ASbGnctuA3LLd9GLA89xdpaU2spDJZkIJz9FheYzWL76zi6pnuZxblSZ8QvBUiFbgH/
	XeypOKRLOmk3Z6rA3Mnecv/pNN38vho/f3tsBzNniu7rmy+m79ZWNtVUwLC59hSIW/CQkvs7S8o
	DCfnBqvNPhE9lStL1+497C40OaecAod6KNYOrLefjm9f1Cu2BpSDwdAw1MZnea/RFoG0MQBCQGU
	Ljj3LVA
X-Google-Smtp-Source: AGHT+IGXWzA0eS0R61Nf3Ndtr7L0dAU4ibk8l1naE99zl3Xmp3m5QQ7zPsDbMVQxHdfBBrCs0Rs7rWmMy9G6zGgH5X0=
X-Received: by 2002:a05:6000:440b:b0:3b9:53b:ee91 with SMTP id
 ffacd0b85a97d-3c4b50e1e6amr586739f8f.17.1755758759776; Wed, 20 Aug 2025
 23:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820114231.150441-1-clamor95@gmail.com> <20250820114231.150441-5-clamor95@gmail.com>
 <4683661.LvFx2qVVIh@senjougahara>
In-Reply-To: <4683661.LvFx2qVVIh@senjougahara>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 21 Aug 2025 09:45:48 +0300
X-Gm-Features: Ac12FXzzH6qdl35BE9pgAbfUkoPCC90SJxU_f0DKbt596WihCit9QQ_DfDsklT8
Message-ID: <CAPVz0n3pfaY9SboHhiG6NqPBjwvA4KvSeOvfadjH2DQJtcpcjw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] dt-bindings: thermal: tegra: add Tegra114 soctherm header
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Thierry Reding <treding@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 21 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 09:3=
9 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wednesday, August 20, 2025 8:42=E2=80=AFPM Svyatoslav Ryhel wrote:
> > This adds header for the Tegra114 SOCTHERM device tree node.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  .../dt-bindings/thermal/tegra114-soctherm.h   | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 include/dt-bindings/thermal/tegra114-soctherm.h
> >
> > diff --git a/include/dt-bindings/thermal/tegra114-soctherm.h
> > b/include/dt-bindings/thermal/tegra114-soctherm.h new file mode 100644
> > index 000000000000..b605e53284fe
> > --- /dev/null
> > +++ b/include/dt-bindings/thermal/tegra114-soctherm.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> > +/*
> > + * This header provides constants for binding nvidia,tegra114-soctherm=
.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> > +#define _DT_BINDINGS_THERMAL_TEGRA114_SOCTHERM_H
> > +
> > +#define TEGRA114_SOCTHERM_SENSOR_CPU 0
> > +#define TEGRA114_SOCTHERM_SENSOR_MEM 1
> > +#define TEGRA114_SOCTHERM_SENSOR_GPU 2
> > +#define TEGRA114_SOCTHERM_SENSOR_PLLX 3
> > +#define TEGRA114_SOCTHERM_SENSOR_NUM 4
> > +
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_NONE 0
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_LOW  1
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_MED  2
> > +#define TEGRA_SOCTHERM_THROT_LEVEL_HIGH 3
>
> Please use the TEGRA114 prefix for these as well. I see that it's missing=
 in
> the Tegra124 header, which is unfortunate.
>

Sure. I assume decision not to use TEGRA124 was intentional since
these defines are used in Tegra124, Tegra132 and Tegra210 device
trees.

> > +
> > +#endif
>
>
>
>

