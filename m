Return-Path: <linux-pm+bounces-24890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D4A7E681
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 18:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C823BF398
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 16:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACDB2135D7;
	Mon,  7 Apr 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkZNiVdg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C353520A5F0
	for <linux-pm@vger.kernel.org>; Mon,  7 Apr 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042732; cv=none; b=hz1cWTLux+1Y8Hk1ZAYhkOJppR4NT1yKb5kzY3b6y2ZljVaBTZJGn4FaBOgO8S/kpwBFXQ9pYVAql7i036YeCh4/n/WsPE4/JxDWGEFtsHwWcLTc8Z+zHXysVLoSQBoYSPf2kfk9L+HMr48bYNsED7FGuGaMzMO1Sgz6JXldX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042732; c=relaxed/simple;
	bh=UlaJZxSieBbasfgzz7gGd3ssb1FnKZpa7pEFR1lSHB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLvDYUmKyLqd6pJxZdnGP40TaOC54Wv7LG1k+gnjGGtzq2nqLvw0+0eaiTU86x+JH9SANFJAJ3hGOB3Lh7pUtXVbfhw9uvOPC8qfHBy02JYAhN6wgrkmEMz07GJUAPCUD+sESq7djS5XYZJMroJhjl/+RaNJIFvnD4z0fI2E0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GkZNiVdg; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff2adbba3fso42155037b3.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Apr 2025 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744042728; x=1744647528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JX/CsfcApiydwjMPAUinCGMDhAd2IhhoMg3Tp/JQvVw=;
        b=GkZNiVdgoYrCt4GLU6a3BxGNy+0nOhwhc93/g7IXLv8qM1QFN4qQrQQV3ifhdyKS8x
         rhJcW4WHrF8x70BvUqJt3tusIYRLq0VxUGdiqzs5mX+KmQ36vJCnNOR/ACHAcb43IHxF
         tMYmMWoO4e1x5G/G/zC5C5Ae/YKGpVqG35AZGMZNyjWxgs9eRlyAHDM1LrWwPxhZ2GIY
         QjiX+K1T0CnbATnM3FP/4aYCz+BKHESYs+FL2XbjYGzrtPHl9H2e7x5SHDqzFNN/2LIr
         +ktrOK+lRIcNMlhTkrtOh29EdpiHHBjni56aJBvdC1n1XJ/a41t3n5j7EN0ixexzPoyC
         vb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744042728; x=1744647528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JX/CsfcApiydwjMPAUinCGMDhAd2IhhoMg3Tp/JQvVw=;
        b=pUoOUjAA6anwShiG2bjK+AkbGTTDcksbDpP9H960kBRi0pxodocsuy50+QHrjnWwmP
         p0knAOrqxwuxPNBPra2C38X3mUI2LhNOT6aOYu4WpJbcuquS+t5/WIB7c4JKweLJw9RB
         C1UW+SWtGmWZkMdyOjohToAewYwLq63O0qzy3xsuRWewRxPfUmFo/xPMQboWPCsRf8fL
         CfUCN4jMT8o8FSt35+hgNfzVrIP7gBS1xzfiZiK6dn0NEfJLlS9bmu9MUvTu9CTS8CbD
         DF80yh8FgY6uh3P9O5E7nKbz4ikwV7cWmBHZeL018s1FYbkxge9tD/SdzAQC/zfUY5/a
         BCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUfpsDFkU+ph+LNuy0Th0ynY3avO69qmrlUyg4IXKGJb7WByIrMQucpUwD9lIbD509puq2Wx1SoMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp43InHetkN/waBqD1OHXvRRT+tN8LGUyuqa7Y4C+BF0nijiS6
	lUx1bjacl2xSrcgNwNazl+vMRBRQHa4Oyof/XmCWsToPiud584g6/n1fbvo363+0FiXU4t/a4Sz
	GDHzWyFJLXGF4uzhQVEaks4P41xbNPNxm0je9pQ==
X-Gm-Gg: ASbGncta06xUAvVDtJoAZJuojQv0vPkZW3QgdXotCMQQcyhBkIEcJOkPNjoAHBmHbPh
	FnIYjUVpElLImfkuPHS69YPEXpoCsk/Yg/HsAZ3Fl8xmdi+awkNPGIlqCvAj7BEXOj5c6bKX6Gc
	NqvJntzdr2tz21R7b0HzoU5D4lwcs=
X-Google-Smtp-Source: AGHT+IHKMX4Ob6QTTm80PFpdHe5OW6JJqpgeMbRrvzhWKoI17ZKitrO/G0aPEV6gKHvE71Av+QnfoRhbc/Xsg7bIvR4=
X-Received: by 2002:a05:690c:640b:b0:6fb:1c5a:80ea with SMTP id
 00721157ae682-703f42fc252mr178401657b3.32.1744042728667; Mon, 07 Apr 2025
 09:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-18-076be7171a85@kernel.org> <CAPDyKFrFRrPVJ_t0JrAE1VTbS02hwr=L-EHtqb7CQiWzB1MnQg@mail.gmail.com>
 <20250407-aloof-fox-of-relaxation-62963a@sudeepholla> <CAL_Jsq+6GG3j3_S94SYLwdGN7x8fjf5WuGL4uHfmgW-fFb=dKQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+6GG3j3_S94SYLwdGN7x8fjf5WuGL4uHfmgW-fFb=dKQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Apr 2025 18:18:12 +0200
X-Gm-Features: ATxdqUF_J2qNh9UdMVJ6Dqqt88GUYfovrcMe53xm4tXJ8-94vrSIdDD4MBgiib8
Message-ID: <CAPDyKFpX7aqcme9c=TZ3JT_DssRatvXPFWSNN-3k5K8pUZvgeg@mail.gmail.com>
Subject: Re: [PATCH 18/19] dt-bindings: arm/cpus: Add power-domains constraints
To: Rob Herring <robh@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

On Mon, 7 Apr 2025 at 14:49, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Apr 7, 2025 at 7:30=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
> >
> > On Fri, Apr 04, 2025 at 12:36:33PM +0200, Ulf Hansson wrote:
> > > On Fri, 4 Apr 2025 at 05:06, Rob Herring (Arm) <robh@kernel.org> wrot=
e:
> > > >
> > > > The "power-domains" and "power-domains-names" properties are missin=
g any
> > > > constraints. Add the constraints and drop the generic descriptions.
> > > >
> > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/cpus.yaml | 8 ++------
> > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Docu=
mentation/devicetree/bindings/arm/cpus.yaml
> > > > index 6f74ebfd38df..5bd5822db8af 100644
> > > > --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> > > > @@ -313,19 +313,15 @@ properties:
> > > >      maxItems: 1
> > > >
> > > >    power-domains:
> > > > -    description:
> > > > -      List of phandles and PM domain specifiers, as defined by bin=
dings of the
> > > > -      PM domain provider (see also ../power_domain.txt).
> > > > +    maxItems: 1
> > >
> > > There are more than one in some cases. The most is probably three, I =
think.
> > >
> >
> > +1, there are users using "perf" and "psci" together now.
>
> Where? That's just wrong.

For SCMI for example, but other QC platforms use it too.

"psci" is for CPU power management - we discussed the bad name "psci"
before, but as it's already widely deployed maybe leave it as is? A
better name would be "power", or something along those lines.
"perf" is for CPU performance scaling.

Kind regards
Uffe

