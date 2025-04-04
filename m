Return-Path: <linux-pm+bounces-24820-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5DA7BEBC
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 16:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798F53BA9D0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 14:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E541F2B94;
	Fri,  4 Apr 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhXqLqpa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DA1F0E33;
	Fri,  4 Apr 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775832; cv=none; b=rlUJPj3OKROTl7DVSgDnA1X52xaoYnrMHCQdK+EWQ9F/wDITqd7oICnKi6dSPnquMbKIj4DC3s/RpkI8D3mIhMZkl6q32erhexdu9IPx0A1qBmIjc7FZYP1dKn4kK9QjrFGRqVZwi/qEx2cwpMYKPY96ZzdD+wOHtqSFM2QTvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775832; c=relaxed/simple;
	bh=l2lzsNRrga+hAwlZPw2hZyVI7hOngQ48zjWgc72CGr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiChbc9rbv0oAZYXxsogvYs5aVUgEs0rbX+lxzlKrd8DAD6mm9JAQSIBkMf4XMIkZcHfR+Z1f81agX0MBuFQmF0F96aSPmOFQ+B2NTmRC9yGE2GXF/mc+cmlUZp38vE5w0nUNONnCUkT12TYBDVCP15p53grUQuOUX1Kz5/kOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhXqLqpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB8FC4CEEA;
	Fri,  4 Apr 2025 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743775831;
	bh=l2lzsNRrga+hAwlZPw2hZyVI7hOngQ48zjWgc72CGr4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MhXqLqpa43mJjzUE+SiXJTbXwmVJ/HY6gBTctJU9FfRezIv1qLjartTS85rOgNg9a
	 ZhN4HzOepVa85NDLlDWJODei3AOF6LINQBifXsj/9vcNkRNTNwOPyODWr//oY7SEXN
	 pqbYfSz27XnI8DD+h0GaWdbcrDerOqpp+11Vuj4JYUOWKhgGITX67L3hbAOFtsPvzb
	 xSZsVs/S+Pr54A87UysNCn/RkaXJaFv8XaW0L8BHyTXXNGj+g0awaZqTwq7UI8BMyg
	 xtscO/vdTlk2M4zdjpWE5iml8FERUp0D7y1vv/91pL6IP0dkPhJrxNVtmC/K/73oRz
	 naujA3WQObjpA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so3930496a12.1;
        Fri, 04 Apr 2025 07:10:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/HYiGx+FtNlR0TJnhe7+dbJvVvv7BYPCwwZZo9fMVyvGbkX9tfWUnNX9BRkWoEprg6QftNlycD/s5TKXbgA==@vger.kernel.org, AJvYcCUos1Wh+k96Mi1ay6x95OdBl2SSUiCVU6x1cIGINxc6URxwBLL27rGQN1VpTyTRXHqw/spppzw0BZvgka7M@vger.kernel.org, AJvYcCVXPYNlFRTU02+YVTQxTRvhY5j2eViWk+Ovzog7Ace3rtWp7gqtkEIJ52spXoszvWLm/2RLVBt7TXAhOA==@vger.kernel.org, AJvYcCWNuIi+rmAmwcOj9DrGjyfQmNW/qTFhmN+spqonpP2xpoqWsllRlFQtmOp5Ii2+ZmcJJiQ+/LGok3Y=@vger.kernel.org, AJvYcCXtyMtivy0pcEqlmg0HQOgccg+nhvSVoIcPCPep5ZVvMwJNavu7fEFoLrq4aHHe2K9thFum/xrdpHNDLrAP7g/kq/I=@vger.kernel.org, AJvYcCXwxksWcrYmHTidxE/WhYC+nvwzz2VVYWJY2GQhpxm64w/jlm5iRi9UkZtIrUwFbjkfzqhHcMdmYPuH@vger.kernel.org
X-Gm-Message-State: AOJu0YwplwxXZQtHN5Tufv1r0UvtwQjoAVFhjReRqL4FlNwQErvoQ07w
	vCfAQb3Qh0Dn4NUnMZCpw+BvMbvyf36umQj8+Y/4wtF5vRYr1eNWx2gJVX41k5hdVw3IWZxN6AO
	3NsIg60Bo42Ay0iiFS8/F0ExQKw==
X-Google-Smtp-Source: AGHT+IGYXjl+q1G3Ghk1zMOjaKXndZfqYp9hiiK7OTWs/zAZNM/+0QVdqEQQ+zuW4YRtKHDm+WaT1WT3knVA25eifPc=
X-Received: by 2002:a05:6402:3481:b0:5ed:921a:ded6 with SMTP id
 4fb4d7f45d1cf-5f0b657862emr2694084a12.18.1743775830233; Fri, 04 Apr 2025
 07:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-6-076be7171a85@kernel.org> <Z-_K2XDEcbtcCMVM@linaro.org>
 <CAL_JsqJT-0gwvJnMb63izy6WwJpBVsswkauL8OMLCrF08q9HYQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJT-0gwvJnMb63izy6WwJpBVsswkauL8OMLCrF08q9HYQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Apr 2025 09:10:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJDkoj4d-aKvZ92kZ1mikqjJV4J4w=-3eNk3z6q6g0ssw@mail.gmail.com>
X-Gm-Features: ATxdqUGgk50-VgqfiN2r-WHP1-0cyp1Dem4hGHbf6672N4-b5gggSNdLRbwnjDg
Message-ID: <CAL_JsqJDkoj4d-aKvZ92kZ1mikqjJV4J4w=-3eNk3z6q6g0ssw@mail.gmail.com>
Subject: Re: [PATCH 06/19] arm64: dts: qcom: msm8939: Fix CPU node
 "enable-method" property dependencies
To: Stephan Gerhold <stephan.gerhold@linaro.org>
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

On Fri, Apr 4, 2025 at 8:18=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 4, 2025 at 7:04=E2=80=AFAM Stephan Gerhold
> <stephan.gerhold@linaro.org> wrote:
> >
> > On Thu, Apr 03, 2025 at 09:59:27PM -0500, Rob Herring (Arm) wrote:
> > > The "qcom,acc" and "qcom,saw" properties aren't valid with "spin-tabl=
e"
> > > enable-method nor are they used on 64-bit kernels, so they can be
> > > dropped.
> > >
> >
> > The bootloader we currently use on these devices reads these properties
> > to set up the spin-table, so removing these will break booting secondar=
y
> > CPU cores.
> >
> > The motivation for implementing it that way was that 32-bit vs 64-bit
> > kernel shouldn't be relevant for the describing the hardware blocks in
> > the device tree. The code in the bootloader is generic and handles
> > different SoCs (e.g. msm8916 with 4 cores and msm8939 with 8 cores, the
> > enable sequences are identical).
> >
> > Can we keep this in somehow? To be fair, I'm not sure what property we
> > could match on to check if these properties are allowed ...
>
> Yes, we can keep them. We'll have to allow them with "spin-table" and
> "psci" I guess.

I came up with something like this instead:

- if:
  # 2 Qualcomm platforms bootloaders need qcom,acc and qcom,saw yet use
  # "spin-table" or "psci" enable-methods. Disallowing the properties for
  # all other CPUs is the best we can do as there's not any way to
  # distinguish these Qualcomm platforms.
    properties:
      compatible:
        not:
          const: arm,cortex-a53
  then:
    properties:
      qcom,acc: false
      qcom,saw: false

Not ideal as there are lots of A53s, but better than enabling for
every 64-bit platform.


Also, is adding the cpu-release-addr fine? It could trip up a
bootloader tests if the property is already present and doesn't update
it in that case.

Rob

