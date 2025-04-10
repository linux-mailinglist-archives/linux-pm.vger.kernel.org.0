Return-Path: <linux-pm+bounces-25113-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211CA845ED
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD459C1A72
	for <lists+linux-pm@lfdr.de>; Thu, 10 Apr 2025 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04528A40E;
	Thu, 10 Apr 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh3AMolo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E192857EA;
	Thu, 10 Apr 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294296; cv=none; b=S5XdxZ0F5GS+T5S6mybs8BP0Mr0tiNrdELLlW/iyY2CtE+STfCv4s26kGb5UWwUL8bhW1muHRTXDbqchsclzeGR1ce/SjoHpk39Ccuc9bPyvMl7iSMDa9FDlihg1Eit9zap0tm26EbUDDhZ92X1gKYGtouC5Dp7wXgy8kIWYdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294296; c=relaxed/simple;
	bh=rco72FMDY4JgO03QNoKdCEdvvo+YwCaCCrx/8pDGOPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0i9obL9ebakpL9RWEgZUbMf69FkcgMJRYH8mCDoYKnqlUDzjK194LEpVhrTG0BqZ1GsXn/kTjoaH/U+QhdncwUQWZFithu8UM9PHEWEGVDkNK929IRuMw73tnT8LrJakDnOxb+ZL5xIUI15jz5Bbh5JoePL9jTDWLBqw15kY+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh3AMolo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E95DC4CEF8;
	Thu, 10 Apr 2025 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744294296;
	bh=rco72FMDY4JgO03QNoKdCEdvvo+YwCaCCrx/8pDGOPE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nh3AMoloI1t+LD8Ko3tMReWxUwT9noBnNah/gSGDtpqZfRKgXVdEinNMTanYL+n9u
	 j+p0TfWH2vu1IJ5Nn7Wcr4GzayTrkjGXr2J3B4jWQY2hq+6UwmQkn3Tuk/AmVidpZZ
	 FUsZk7+SKUUfZnLu0JVKiqSekt4+tuomUZUJEAloOJrWkXTeslsBU637LCZQTi0SZS
	 ck84EenDGtIJGnEPcQVQlZBRTYey4xeQMADZ5VFxQa0BkvRutj3hRRgFlSiQ/RZjeJ
	 JmFZl+RMIyIKs1JzC592bPghjDmcBByBkCLeOHyr8WBLiU1YWSdN5SIRCJ0iXCIcCZ
	 ks3h1FHJm+jKA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so1404880a12.0;
        Thu, 10 Apr 2025 07:11:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUSDYqMThB0n2jya/kDZSMtjvWqvWsxCy+53ytFKYf6Jk5MsbasuhNceUwsRT+sSvFMHH8afH01Q2s+GPjYmQ==@vger.kernel.org, AJvYcCUhLHFaigQUOrFmjpmHhMuuWzU21+2rtobCm8uPbD0OXcrmJUzUJRvhiYdtWQRhbXPFTo3tK/uqrwAkxA==@vger.kernel.org, AJvYcCV1LJ3nTK9Tu01YF5kllTYqjbGt/K11I+K/tmN0hOqoqfF06WsxBhYhm05CyWAly3/TF2j0P3MJxkU=@vger.kernel.org, AJvYcCW8TJbms89+VCCmFJvveDhIM7YhzmVLG3epzwIR+MGxfnC9k7t8pAjpoMt4q7MubDlJAIS5hyxwq5U/04qY@vger.kernel.org, AJvYcCWGFFvsApGM8VVSYv0rcua4g02Bm7Q6yVKo14PHFtmf1eHK8y11TPz2z/3/z0UZ9WF7EzP/G/I427oH@vger.kernel.org, AJvYcCXBeHILg+04FGhBJMhEWVIPSE95c83uDooMScthM/yK9wFBncx/vllSzlEPBlxAbVNK7GyE4jPrwXHOLAKoAuMwWLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbVO/ZpPz8w1qC6xRUKK/7TG53eCSQ3qJ5wfLW/v7ij3729pY
	srsuwYmb87+WevwUjDXuh3A0G0nW2WeEkvsxN+N5oprn/Pjh3n/qT+VpgwhEETnCwBuztS6hQz3
	sE/bRLarlICpZS5KnjY3Vv36yAA==
X-Google-Smtp-Source: AGHT+IGlh97um6SMQiGxBgsgdbsviDx65SZRgGYwOH79oWcJKJOpcvjinlVEV2oCvrCbvL9uHlFPqdqxcM1fMXmRyBY=
X-Received: by 2002:a05:6402:42c3:b0:5e4:d2c9:455c with SMTP id
 4fb4d7f45d1cf-5f3292682cfmr2701509a12.10.1744294294406; Thu, 10 Apr 2025
 07:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-14-076be7171a85@kernel.org> <174377856145.1313232.11316769002552655294.robh@kernel.org>
In-Reply-To: <174377856145.1313232.11316769002552655294.robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 10 Apr 2025 09:11:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiduJBRBuRS364_bSjEfC_cvgyicZX1BwvNyb1+GVc3w@mail.gmail.com>
X-Gm-Features: ATxdqUEvfSUaWUzPsxy3ohcumibpamjDRmILBf-6gs6fjUtKKg1MwCu-Qt45NOQ
Message-ID: <CAL_JsqKiduJBRBuRS364_bSjEfC_cvgyicZX1BwvNyb1+GVc3w@mail.gmail.com>
Subject: Re: [PATCH 14/19] dt-bindings: arm/cpus: Add schemas for
 "enable-method" dependencies
To: "Rob Herring (Arm)" <robh@kernel.org>, Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>, 
	linux-rockchip@lists.infradead.org, 
	Daniel Machon <daniel.machon@microchip.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, UNGLinuxDriver@microchip.com, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, linux-sunxi@lists.linux.dev, 
	Liviu Dudau <liviu.dudau@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Fabio Estevam <festevam@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Stephen Boyd <sboyd@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-renesas-soc@vger.kernel.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Magnus Damm <magnus.damm@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Viresh Kumar <vireshk@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, zhouyanjie@wanyeetech.com, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, linux-pm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, 
	linux-mips@vger.kernel.org, imx@lists.linux.dev, 
	Samuel Holland <samuel@sholland.org>, Sudeep Holla <sudeep.holla@arm.com>, Nishanth Menon <nm@ti.com>, 
	devicetree@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-arm-msm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	linux-amlogic@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 9:56=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
>
> On Thu, 03 Apr 2025 21:59:35 -0500, Rob Herring (Arm) wrote:
> > Replace the prose for properties dependent on specific "enable-method"
> > values with schemas defining the same requirements.
> >
> > Both "qcom,acc" and "qcom,saw" properties appear to be required for any
> > of the Qualcomm enable-method values, so the schema is a bit simpler
> > than what the text said. The references to arm/msm/qcom,saw2.txt and
> > arm/msm/qcom,kpss-acc.txt are out of date, so just drop them.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.yaml | 82 +++++++++++++++--=
--------
> >  1 file changed, 49 insertions(+), 33 deletions(-)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/s=
oc/qcom/qcom,saw2.example.dtb: cpu@0: 'qcom,acc' is a required property
>         from schema $id: http://devicetree.org/schemas/arm/cpus.yaml#

Any Qcom folks want to tell me whether both qcom,acc and qcom,saw are
required or not? All the actual users have both.

Rob

