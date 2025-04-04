Return-Path: <linux-pm+bounces-24811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936F9A7BD43
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 15:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C163B93B1
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1951EEA3D;
	Fri,  4 Apr 2025 13:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDd3H0n4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C81DA53;
	Fri,  4 Apr 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772169; cv=none; b=DOJiP3UWeAMufjg0uKO4aamRya32iuuLfZYrfLtCTvCpa81Zv+kzBTayLEphoEmY19NeJ0qhFw2rOEy1JKZGZf7/CcdB4wqlKYsyzoIYhjYLRFtdWGs9vqakaHjSzwprrZUUqplhFP0xIOaGLhIPMNOeIkMvmjT3TV2p+5cTOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772169; c=relaxed/simple;
	bh=dXvLo65uum190+DYUNNlALy+j1eqU6jZE1YhXB2VRzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0C38h8UEJzIXSS/9JOIPJiJ6AB+cj8YLrkPrMKqB7h4qfOqC8nPG7puMNDrd2W4Dq6dyluCNQTX/FuNno8sX+WZeBsbz8z0/1Yb/xNAqLTiWlozLxLJ2GzV3CsTfRshfpbnHI074deaV0xSgy+HJnhjtC48ZsCOM4wUevbLdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDd3H0n4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84B1C4CEF4;
	Fri,  4 Apr 2025 13:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743772168;
	bh=dXvLo65uum190+DYUNNlALy+j1eqU6jZE1YhXB2VRzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GDd3H0n4Z0vbzhOAKBtX4aBm2VvNF3+IHAlBZcY+prFuXi8cUpHIAmcgMJANZtdgc
	 SadmKjqoeeP3emGC4LnYFxHT6I2Z5k4Qigi/ixTpN0IjDgoC2YwqzWaLtiFw6MVdWY
	 R51uqx4Vo1nBKrHVzBG0y29dCta48Jc5BLa59kSTc1THSL1yXM0eoSE65ifw4Hc4m9
	 SWymD+qBgYbMWGz01AIzxcp4EAbHrwklRmWGHBAZsGAPODfBKuc22jPpwnuD0PsKUb
	 4WzCQ8fABsmztu+A1EYwZSW/Iy8dxRsSFMwWpTf8Ntbimo0rh1MzNq8RAHcck28ns7
	 PlZqBwK10PG0Q==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac297cbe017so586263666b.0;
        Fri, 04 Apr 2025 06:09:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1oqbiGOfR79B3pmInEqVgP4qtwzVaONtkQARqp+uC81Mft8Xu8Osog9axGNsecaFxr6b8tpQ5Du3RDg==@vger.kernel.org, AJvYcCUP71WUkuxcxwSxEihnpmmgyJ69Y9v00U8+PEYZlnocMAkXkyjJ9+U0edMJAuili0g8BJpBmNplAxs=@vger.kernel.org, AJvYcCUnoidDpJ/6539fzb9oaeM6wd+Tu1qirHEVErwfUIaBM8P9JHTK87n9jyIDc73qqRPPRKyIkkQ28dc++woP@vger.kernel.org, AJvYcCWG+VknflL4bK0dOwFOCrJKVwn6g10VFM08IqFozGz3+cAgJDDe7gZgSn+f3IryoFQ06o9NJgoHItTlIDR1eoIqPnY=@vger.kernel.org, AJvYcCWUdpY/s8HvtRX6B72Yfafu95gfhVjTex1OcG3J4VBCyOwXaB459pygIrF0HRaCMQqEjw5IIxpgdr7I@vger.kernel.org, AJvYcCXnxWf2Yx+EFpzGuWfPkKaX1RVOICB1aJVDmboz4giWOIjye1YB/IMW+tjq+5bYJFPim6WkoQHssf1ZCmvd/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCVZaL7XGX5y50cubVmjjZlDPhU8H2yc1ZKh9vKw2qFcyVvcj
	pP0m5emXt5B1XtQ82KNkFITbdP/UsstiLqSDSqyUEtSgMj6EvOWaIO/a0hrPo5lF9SVWu3i8rxW
	STXg2O5Ayg75vLd95FHcGr5uUHA==
X-Google-Smtp-Source: AGHT+IFIyAD0iksJ2rEYwVDKxfXp9paMa26qoweWItquite8ZOPf4g5g6GK5SE+pbTwu/1QEMoBYtzOxpeaG2eY6PCU=
X-Received: by 2002:a17:907:6e8e:b0:ac2:d5d3:2b77 with SMTP id
 a640c23a62f3a-ac7d2e1b9c5mr344142866b.8.1743772167150; Fri, 04 Apr 2025
 06:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-18-076be7171a85@kernel.org> <CAPDyKFrFRrPVJ_t0JrAE1VTbS02hwr=L-EHtqb7CQiWzB1MnQg@mail.gmail.com>
In-Reply-To: <CAPDyKFrFRrPVJ_t0JrAE1VTbS02hwr=L-EHtqb7CQiWzB1MnQg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Apr 2025 08:09:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKygxhcQ=PZW84sfiW7BVXKF839vfNyxS9GwAXuqmN=8g@mail.gmail.com>
X-Gm-Features: ATxdqUFqb3GyPW1xY4MYIKArvKkAjEGffj80G84cX0XvObx4_cAf9jnDsr6emp0
Message-ID: <CAL_JsqKygxhcQ=PZW84sfiW7BVXKF839vfNyxS9GwAXuqmN=8g@mail.gmail.com>
Subject: Re: [PATCH 18/19] dt-bindings: arm/cpus: Add power-domains constraints
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
	Conor Dooley <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mips@vger.kernel.org, 
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 5:37=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 4 Apr 2025 at 05:06, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > The "power-domains" and "power-domains-names" properties are missing an=
y
> > constraints. Add the constraints and drop the generic descriptions.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.yaml | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Document=
ation/devicetree/bindings/arm/cpus.yaml
> > index 6f74ebfd38df..5bd5822db8af 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > @@ -313,19 +313,15 @@ properties:
> >      maxItems: 1
> >
> >    power-domains:
> > -    description:
> > -      List of phandles and PM domain specifiers, as defined by binding=
s of the
> > -      PM domain provider (see also ../power_domain.txt).
> > +    maxItems: 1
>
> There are more than one in some cases. The most is probably three, I thin=
k.

Unless I missed it, testing says otherwise. What would the names be if
more than 1 entry?

Rob

