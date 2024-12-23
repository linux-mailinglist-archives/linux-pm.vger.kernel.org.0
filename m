Return-Path: <linux-pm+bounces-19723-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CA9FB5CD
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58E218842F0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Dec 2024 20:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978641D63F3;
	Mon, 23 Dec 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSOCwWnL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627851CD205;
	Mon, 23 Dec 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734987062; cv=none; b=fQoRz4HKGVyK56TDmdpjxmUEd+q39338qNtFQiQocYNjaG2634lH9S1H8yOXe597bi+eAFzYPeTHQMrBmLmDl/V8QOcIZkAyLwk88hFeI/InGBFnwqPXWrn5mnSmHLX2CVEtHVTEixNhaC17rDyeRewdKNVoWrnaoDCn8IOlS+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734987062; c=relaxed/simple;
	bh=7vXp6bg3mIjFXJtB/znIi7nXzs2VzEStHvDISKqmwas=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=SNhGYQJhxBbaAYRP2MmEE32RnK9YScjC+cP8tK89bv/dQ1IXndn/rkx4LbKH6xA3FMx/IoRE8ix+s0Aaglw6rXh8+FqMTOjoxbJOJefZ4wUc4b6TOZ3OkeLhXsF8kNP10eSZ8mfbT+pBsilLB3Yhklw/ZsSej4aXw2Xh9+peKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSOCwWnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4109C4CED3;
	Mon, 23 Dec 2024 20:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734987061;
	bh=7vXp6bg3mIjFXJtB/znIi7nXzs2VzEStHvDISKqmwas=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sSOCwWnLvbLB7dADE52q5aALdUxvb09wMkoarI/KHYD6xnMZCS9HA0QgYGvJeVPvC
	 4jT9A4kyA/stK3cZITP0N3WB1YFxk0FDAs2fglyqg3HwQK2tV727ewQ4MGed2Rg4RY
	 btCD6CqdOm2cdAUrdryVpUklmsJXvW4awF0LN6dV2FgK7dQwxof3qdeH93xKvie8NL
	 XBizgv1/9TFlJ9Ws9wiSeJQJ3aCRcOoLRUA2103q171a3ojEi8sinaB6XYqOKxk8aq
	 QmuXfwf5aH893lR84Uqqq742Wfkw5Wq/EEYRZkMhxFQShUQ2o1xHQK7eYNc6X8xB8u
	 ds4jlVT/frsPg==
Message-ID: <2cd0c34fbd14a0d69e689d04c2241938.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241223125553.3527812-2-m.wilczynski@samsung.com>
References: <20241223125553.3527812-1-m.wilczynski@samsung.com> <CGME20241223125601eucas1p1d274193122638075dc65310a22616bae@eucas1p1.samsung.com> <20241223125553.3527812-2-m.wilczynski@samsung.com>
Subject: Re: [RFC PATCH v2 01/19] dt-bindings: clock: Add VO subsystem clocks and update address requirements
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski <m.wilczynski@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>, airlied@gmail.com, aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com, frank.binns@imgtec.com, guoren@kernel.org, jassisinghbrar@gmail.com, jszhang@kernel.org, krzk+dt@kernel.org, m.szyprowski@samsung.com, maarten.lankhorst@linux.intel.com, matt.coster@imgtec.com, mripard@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de, ulf.hansson@linaro.org, wefu@redhat.com
Date: Mon, 23 Dec 2024 12:50:59 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Michal Wilczynski (2024-12-23 04:55:35)
> The T-Head TH1520 SoC=E2=80=99s AP clock controller now needs two address=
 ranges
> to manage both the Application Processor (AP) and Video Output (VO)
> subsystem clocks. Update the device tree bindings to require two `reg`
> entries, one for the AP clocks and one for the VO clocks.
>=20
> Additionally, introduce new VO subsystem clock constants in the header
> file. These constants will be used by the driver to control VO-related
> components such as display and graphics units.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
[...]
> diff --git a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.=
yaml b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> index 0129bd0ba4b3..f0df97a450ef 100644
> --- a/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> +++ b/Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
> @@ -47,7 +54,9 @@ examples:
>      #include <dt-bindings/clock/thead,th1520-clk-ap.h>
>      clock-controller@ef010000 {
>          compatible =3D "thead,th1520-clk-ap";
> -        reg =3D <0xef010000 0x1000>;
> +        reg =3D <0xef010000 0x1000>,
> +              <0xff010000 0x1000>;

I don't get it. Why not have two nodes and two devices? They have
different register regions so likely they're different devices on the
internal SoC bus. They may have the same input clks, but otherwise I
don't see how they're the same node.

> +        reg-names =3D "ap-clks", "vo-clks";
>          clocks =3D <&osc>;
>          #clock-cells =3D <1>;
>      };

