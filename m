Return-Path: <linux-pm+bounces-24880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D798BA7DE30
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 14:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2CA172F5F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC53224EAA6;
	Mon,  7 Apr 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK15qn+4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA224888D;
	Mon,  7 Apr 2025 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030162; cv=none; b=rBIcdq3FZyRiY2cntIolExl5MmQjiEczOu9aOhwMcFBv43jLl6hR0TP9hdBRzLyPS6UKnODueLeCmJ5VxQaE5Tc5mHEyWgu05rHWuFrUg+9NB5L7Tyl2XauPATAIo3GyJPT5/79dYzeUN7Sh9qNYOrjniSc8ooYeCz54VVz0GzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030162; c=relaxed/simple;
	bh=+B7zKeUdb4vhO3I+2ufYAN6NeJofvMlAuG64Ted7aW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baNs5PO/pZgXFLU8VFb1Ef4qPRX47S2VwwzpKCKncyuPKHZKLaSpbGvfzfvuUifz72ox0/WrNK9ZFJ8w5Di7BKiPSYFqZ0dSNa1sK9Yn7GkxXDfMXRl58H0UapMki+hAjJ0AjbkjcGYiaDAut1/bhs0UFtTCT2S6TYjhnbKiYPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK15qn+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915FBC4CEF3;
	Mon,  7 Apr 2025 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744030162;
	bh=+B7zKeUdb4vhO3I+2ufYAN6NeJofvMlAuG64Ted7aW4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qK15qn+4XDBux6uFbNeNhwEi2hTl9qrQlhxa+iPQu3pfCNYk0TGSpt6kV7em1bTJM
	 vUljZeXsRzR7Jj8NuzkMZTYi/9u3Yh2lORMvrA2WvRMeyyoBzIohPTgjigRudqmNPN
	 WCmBlDx+nk5sKJyfK9ktF0xU8btt+NV60wmriw/nmO6i89bCszDcDKQbX7pX1j6TC0
	 Xd/3FGyHAth4HgZCQUn37Zqh6wg+Ro8M103g9aum/kNYd1KAOExeFkxcGRv+EeHVZ3
	 0RBql7KPbo+Oc3mCIikCkfjSG2W2lDAgrpUCmM33RaND4LwR3y6IonYd3dKod/jNWr
	 FKe526FHkDDIA==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso694862266b.2;
        Mon, 07 Apr 2025 05:49:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/qKQw6RNCFaZk9vtB6ZqHQx72sFrPat3RMBElSgAdR3sAaXHajezRSTOm5C+HdCxzff7Oj50cSstlf6KgN85LB5M=@vger.kernel.org, AJvYcCUbGZGLeVhhuYQayEE+YYxV+/A6T93w+BFmVwJzKKDEKJgJTVlG3ThwMuXiMHrw4ILltyl1PLj9plwxw09V8w==@vger.kernel.org, AJvYcCVZlj3c41QNNOPXQGcbSTHDjcISgpBK1ad9JASV1e8kLshMv2G4f14ZeXzTO2PSBY0KTQ+jZr/Bnig=@vger.kernel.org, AJvYcCVkoXNZI4C9Nu1HRKFmI3VSSDgjOXHznQuysWuSneY4Fo/pUIuzJQMsPcLHIawW3k1N7qsBTq2T/gCoSw==@vger.kernel.org, AJvYcCX1oML6q5iGI8a88sRAP+7kSx3UftJHpou6Qio9Dga6KXkBto9ETjRPuIIAhviOMgp6bqn/fp9ZRRFUdaHW@vger.kernel.org, AJvYcCXBu35nCMFofo17fU+eE9IiDFldYrnFPEcvlpxgfrZ77QtBb2byHawe6C1S+NeNCqT2KFgUE+8AvlHJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0ZCi7Su+ce0Yz1INh3SW9BV3pFz5Eru4yFvJG7jYAg3EhnDy
	0JqxEEbD+UzXPyOyuJ2YLo+FehX/duJM/BbyVOok2YEotxWvlBHLcM/ecEbpiznSnVPlWD13IZp
	6d+kpKccae6bsnhhr1Dn4MX8JIw==
X-Google-Smtp-Source: AGHT+IHDXKnPQLm3ONu11Ll77borMYreC4A7vgRQSv5YVZin37244aX9wUO7LUzP2WcSyOBSKvvGgd7SCFS9hjbiqWA=
X-Received: by 2002:a17:907:7f0f:b0:ac7:3323:cfdc with SMTP id
 a640c23a62f3a-ac7e7120321mr823783266b.10.1744030161025; Mon, 07 Apr 2025
 05:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-18-076be7171a85@kernel.org> <CAPDyKFrFRrPVJ_t0JrAE1VTbS02hwr=L-EHtqb7CQiWzB1MnQg@mail.gmail.com>
 <20250407-aloof-fox-of-relaxation-62963a@sudeepholla>
In-Reply-To: <20250407-aloof-fox-of-relaxation-62963a@sudeepholla>
From: Rob Herring <robh@kernel.org>
Date: Mon, 7 Apr 2025 07:49:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+6GG3j3_S94SYLwdGN7x8fjf5WuGL4uHfmgW-fFb=dKQ@mail.gmail.com>
X-Gm-Features: ATxdqUG97FKlHBXmze0JeAjms2C3uLqc9HHI86LZOz8ldRdp0AMtBpiWM_qROsw
Message-ID: <CAL_Jsq+6GG3j3_S94SYLwdGN7x8fjf5WuGL4uHfmgW-fFb=dKQ@mail.gmail.com>
Subject: Re: [PATCH 18/19] dt-bindings: arm/cpus: Add power-domains constraints
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	zhouyanjie@wanyeetech.com, Conor Dooley <conor@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
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

On Mon, Apr 7, 2025 at 7:30=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Fri, Apr 04, 2025 at 12:36:33PM +0200, Ulf Hansson wrote:
> > On Fri, 4 Apr 2025 at 05:06, Rob Herring (Arm) <robh@kernel.org> wrote:
> > >
> > > The "power-domains" and "power-domains-names" properties are missing =
any
> > > constraints. Add the constraints and drop the generic descriptions.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/arm/cpus.yaml | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Docume=
ntation/devicetree/bindings/arm/cpus.yaml
> > > index 6f74ebfd38df..5bd5822db8af 100644
> > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > @@ -313,19 +313,15 @@ properties:
> > >      maxItems: 1
> > >
> > >    power-domains:
> > > -    description:
> > > -      List of phandles and PM domain specifiers, as defined by bindi=
ngs of the
> > > -      PM domain provider (see also ../power_domain.txt).
> > > +    maxItems: 1
> >
> > There are more than one in some cases. The most is probably three, I th=
ink.
> >
>
> +1, there are users using "perf" and "psci" together now.

Where? That's just wrong.

Rob

