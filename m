Return-Path: <linux-pm+bounces-24819-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5411CA7BEAD
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 16:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9732F3B3B40
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCC1F152A;
	Fri,  4 Apr 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCGf3I9t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CDDF49;
	Fri,  4 Apr 2025 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775515; cv=none; b=bfGJWspo00jZbTmRtiloJRWM5x0o4/QWvuEFOnj+KdnykVyu6CoBxIu/XIxNJ59g1XYVftvRc+x3Jr99VCbt6vkUh7QcgSQioQvCLhHve/1Nq5uSLjJkoTtMJSkKzKYnTDQmE8Fy3A3YCgXp9+2WTYPKnUNfGJWlDjlSnkF0NO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775515; c=relaxed/simple;
	bh=sXc59e9oCS1JyARzmEkCFC/sWd+6b3k5Zd9xARKgKhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scQwsL74DJ9i8ZLDmSbqb/IsDF5s0KRrVcQA6rC+d/2eEjitOggss8bzUrnBrDoNSfp/5nq0ji4xjFW87GKYMphDMvCy208g882mwp5Fafapr5jOY/1icgQcA53ye/b8TmYYHDTO1CTYryg8OR8WfvtC2n4whhIC5HolPeXZP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCGf3I9t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209A1C4CEDD;
	Fri,  4 Apr 2025 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743775515;
	bh=sXc59e9oCS1JyARzmEkCFC/sWd+6b3k5Zd9xARKgKhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nCGf3I9tEmCSvB0E76/BUXH6Nk1Q786Smv1KYQf7QmCCD9o9Vf7Jhiuw+t0LRBV69
	 fCQDUgY4uJnXj9Qtye3sGi5fSmLjQJjXNRK/EEEdrFO4FIOnMma7eAkGuyZRmfOSfg
	 hldrIX+bb9WXeeI5iiR1rh1rVUuQqiXwgbhatKkxVl4shFjEMD6B/1hgd5VDxXk3s1
	 2GLoeerZIcXyrkvsszXm+iKisJa7hv/VYq64834LR35wmHqQST9N7TujpLPgk8EdVT
	 UcAJ9djGAUQ/qu7XPoq1vjZ58Lh+q8niDbtBdREOB9J7EnKo65uRZQ9qCRO90Gcjnk
	 R08WFLmx941ew==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso4063969a12.0;
        Fri, 04 Apr 2025 07:05:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2zrgHEjqwRrk4VXO36IPQmUmdER/8GZEVHa43SWCov61RXGD24EBs9evYOqa8yra/7F28qQtc6ysEXOUZ@vger.kernel.org, AJvYcCU45wrw8nqttRz5PGcXQUAXucqrGzoTQ09xhlLy6tCjBUR2hsChEkwzZw/NsPHYl4TCY84+JnDU6nqbSw==@vger.kernel.org, AJvYcCUDT6aJqNRpGmWR2MDxiAJR3V8TYjdYaY3HuXmxESGCv1h8cz3fqKp3BrM0eql3rhdtvv99j06Y+BEO@vger.kernel.org, AJvYcCXfejW4WlIQOZ2wvbtvBUAr63p5knnISrwyByDANPqXmUclKeojJIHcezJQpVrAxsfkvndERgjyPYnmEGVxFg==@vger.kernel.org, AJvYcCXkxbntwdHCtE9dJD2l/SuN126GkpHAnQ3RlfOyGwYaK+TpOC22n01ZbV1OWn8cOK+Abyvy2KnlsKSNGtH0CtkkGcE=@vger.kernel.org, AJvYcCXliRt5smrn9iCUHiiSnlgpFOaTv0MgB9Ju8WjWTQ1fQXjFGZTtLV9IGTEn9r/NinbMIXhsgnHql5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpcDNlrtUWN9LHNAO7w3tOOqlzydZCTLDt/SVzBgkaHtO7p6S
	DI+295zicmM5UwERhi1Wb6fF3YZvEnUW5bcDaqSrmuLO1tZ6BWM+7U6g/66RQwM2+kQx3I/0/hC
	E+V21n4DYGGZqfh62t61OdOfGYA==
X-Google-Smtp-Source: AGHT+IGvjzmo+S0oZ7wclO731FKO/yFH3v6rfa52+MwQrSf/9tdEEQ9A/kWSXMLtJKL4wmLWRjaXPrcr+vGPnUPbJIE=
X-Received: by 2002:a05:6402:5112:b0:5e7:8be5:d189 with SMTP id
 4fb4d7f45d1cf-5f0b3b62317mr2699905a12.4.1743775513430; Fri, 04 Apr 2025
 07:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-9-076be7171a85@kernel.org> <CAPDyKFoEEp8AZ7aJ8-wwp8=n+T4gbij15oYaCNhF1Bd-E1nMbg@mail.gmail.com>
In-Reply-To: <CAPDyKFoEEp8AZ7aJ8-wwp8=n+T4gbij15oYaCNhF1Bd-E1nMbg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Apr 2025 09:05:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLB7SpVNTVruAb98YEPC5sRpssjsSP=NkqdON6qP+74fw@mail.gmail.com>
X-Gm-Features: ATxdqUGVc4_Mt0PqKKmf21CRVRmw-a_zuqLCxbME19ZuBODzSy1GgUUs6hNAKo0
Message-ID: <CAL_JsqLB7SpVNTVruAb98YEPC5sRpssjsSP=NkqdON6qP+74fw@mail.gmail.com>
Subject: Re: [PATCH 09/19] arm: dts: qcom: sdx55/sdx65: Fix CPU power-domain-names
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

On Fri, Apr 4, 2025 at 5:31=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Fri, 4 Apr 2025 at 05:02, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > "rpmhpd" is not documented nor used anywhere. As the enable-method is
> > "psci" use "psci" for the power-domain name.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
> >  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts=
/qcom/qcom-sdx55.dtsi
> > index 39530eb580ea..64d9858b4248 100644
> > --- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> > +++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
> > @@ -57,7 +57,7 @@ cpu0: cpu@0 {
> >                         enable-method =3D "psci";
> >                         clocks =3D <&apcs>;
> >                         power-domains =3D <&rpmhpd SDX55_CX>;
> > -                       power-domain-names =3D "rpmhpd";
> > +                       power-domain-names =3D "psci";
>
> As I understand it, this isn't for cpu-power-mgmt but for
> cpu-performance-scaling.
>
> I have been thinking of adding a common power-domain-name for this,
> but never reached to do it. I think the last one we added was the
> Airoha SoC [1] which uses "perf", which seems to be the most common
> one. Still I don't see that being documented.

It's all a mess and abuse of the power-domains binding...

"perf" is documented. I can add "rpmhpd" I suppose, but I don't see
anything using the name. Or I can remove it.

Rob

