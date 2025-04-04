Return-Path: <linux-pm+bounces-24813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023D3A7BDA0
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18B33BA305
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 13:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5A41EE7B3;
	Fri,  4 Apr 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKW8BkEP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3EB82D98;
	Fri,  4 Apr 2025 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743772724; cv=none; b=ldpW0QR9ASWFCyZCaY+k+g+cSEDGJmTg/WMqVVmB7oQvrJpxoQe+CleuUO3p2GLd+L55hotAVA/sLYAwhMb15XdK5EPZAbpkYUx6DbL4TbqJ3yztA7sPiph67zK+93edPx96EilX3CAcVDXS4s3L8UVNnRLS7jSqOjCyVJF+l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743772724; c=relaxed/simple;
	bh=8p+c4MB2Vz2NLD+RiN8PNGA7Pc+YAFAuwCP+/mMX5Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syr+2X+tTBERF6utb9ugcFi2InI1tPTBhVhyRyP4oQBMDOHpBR0zxWXH9Esj7PNjLpc/ckdJQ1iPBO9zMOhfON9tqZV6YOc4yyCAeitZRQ/YrRW5AQt1cJSXgNuLm0UV4P4D4F31NcZP6af1YqMgzW/MHdvEy1Yi+yfZAS2tTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKW8BkEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBDCC4CEDD;
	Fri,  4 Apr 2025 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743772723;
	bh=8p+c4MB2Vz2NLD+RiN8PNGA7Pc+YAFAuwCP+/mMX5Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eKW8BkEPXJzBEfA6eyTODP0H96m9hqR98uXmWJ+NQbzBwEXHrdYrjtSd1C8RWZmfz
	 2rcbpHdZXLJRVcFaE9n5Kp4yS8ugzHBQqGEDWJS2qXvoobc+wP2LpgFooZ3AZGa3xa
	 6bKGGVFi85i5+b/AfCt8XkZRJhnqVnGqQ0ftCT5vqRVzGTuQFelxLx7V8tqxC1gZv7
	 u1xcnhxGxabJM0V87wUWYVqmKLm/TNRviJGpd0rTUcnJlFhcHwhwwXhdKoE4G2UVgz
	 pjRM+2K+IxITVbj+DgcmSYFJK28J91/7Ppto2N1C+xXzQUFvu+zdmpvR8Gf7606QS7
	 J6mnKZPky2aVw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so311005966b.0;
        Fri, 04 Apr 2025 06:18:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU74/AFkwfml4gbLJgq9B9nT7NigzWroHm/O7v4+JSE0HLq4cZFyhHESaVr+F/jFy+qajPMTwncmn3v@vger.kernel.org, AJvYcCVca6V00CRoBKtmUtOIWtOWE5bY3mOa0M3AJPEMAT/M4vh5VjsFQPQ45bzqYVVQj1v7jl0dK/wssQnFMWW1hw==@vger.kernel.org, AJvYcCVt6RIcvH0oORKvmL8WVdavu8J9SIIBSl6so57Ms21AUG21xMzChc5O1PjM/fy6+n2yMjWJ+zWNRmg=@vger.kernel.org, AJvYcCWElHLSNXK4GYCk3a16tcR6mVf0iXDTjD+tQu8rLGZk1JoGx7Eh4+5gpu5FcfCTBzXW/mL8+/iG8bTY4xPW@vger.kernel.org, AJvYcCWTtfUlgX6ca+PColQA4KXdHY/u7g/lLUiAbFptm2aFsFc/00VHmr5O94tToY1z2tK9KyL0ld/Nhi8BFyN6s/E2Cag=@vger.kernel.org, AJvYcCWfxWgSkvrs/iJ68oR2IeT8oaObM1OA9mAL2rutoTP5TKuARVZyrJvsl7CBRfJCbJGKvh3QvOQ76MujuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YR5iHRp2Qh7Z2jWkc5AaOgn5a34dBGvx+jVMh3ExHPtM5C+8
	1pBb3M464xHdP+wExqQ0UhfhXaJiaMywYle0yjI90bJfXs6BIaLsHy2yExCeS/8YZYyTAI8fTnJ
	rvAVb4Zmpo/AYxO4iWIW6k+XLhw==
X-Google-Smtp-Source: AGHT+IGeMGvCEeK8AclL93nVBIzL9ZaOIe89VJXnsQlCY86LywWmTQFiXrpurfnLdBj4EjlXLbq/bSkPsN9UQIZ0bQ0=
X-Received: by 2002:a17:907:7209:b0:ac3:45c6:a1ec with SMTP id
 a640c23a62f3a-ac7d6d5dff4mr229454566b.25.1743772721929; Fri, 04 Apr 2025
 06:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-6-076be7171a85@kernel.org> <Z-_K2XDEcbtcCMVM@linaro.org>
In-Reply-To: <Z-_K2XDEcbtcCMVM@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 4 Apr 2025 08:18:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJT-0gwvJnMb63izy6WwJpBVsswkauL8OMLCrF08q9HYQ@mail.gmail.com>
X-Gm-Features: ATxdqUHOgMca65CFxOkpc1GwFhcina94zKtpSzj7uSzh0WZ2vI4WGj4U0KjYQTw
Message-ID: <CAL_JsqJT-0gwvJnMb63izy6WwJpBVsswkauL8OMLCrF08q9HYQ@mail.gmail.com>
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

On Fri, Apr 4, 2025 at 7:04=E2=80=AFAM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Thu, Apr 03, 2025 at 09:59:27PM -0500, Rob Herring (Arm) wrote:
> > The "qcom,acc" and "qcom,saw" properties aren't valid with "spin-table"
> > enable-method nor are they used on 64-bit kernels, so they can be
> > dropped.
> >
>
> The bootloader we currently use on these devices reads these properties
> to set up the spin-table, so removing these will break booting secondary
> CPU cores.
>
> The motivation for implementing it that way was that 32-bit vs 64-bit
> kernel shouldn't be relevant for the describing the hardware blocks in
> the device tree. The code in the bootloader is generic and handles
> different SoCs (e.g. msm8916 with 4 cores and msm8939 with 8 cores, the
> enable sequences are identical).
>
> Can we keep this in somehow? To be fair, I'm not sure what property we
> could match on to check if these properties are allowed ...

Yes, we can keep them. We'll have to allow them with "spin-table" and
"psci" I guess.

Rob

