Return-Path: <linux-pm+bounces-26664-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69854AA9BCF
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 20:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32471189E6E8
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4A270565;
	Mon,  5 May 2025 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM5uAJcP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCA12701D8;
	Mon,  5 May 2025 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470637; cv=none; b=hERkmeu1cYFUIWBkyecuGermvMifQjKAxjVnXvY3k1bCgQJtmxFcmt4lngnQkTHlYJ6+nfkEwJqz8zAI8j9Urd4PHfe75SsgPVHpgs3wE3pIVFr4DLbZBj2iCgQ52oYRssPGEwYFRvVCFKVlFLMqFEfGKd15Hj5yh4DSHTFt1ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470637; c=relaxed/simple;
	bh=tF04Fns79sH1yaJ5H8T/Hh5MDrmddyRBb/f3XQX4pgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwS4lP2agYoi/gFrZ1LxlgjZIPpOfulnkvKK2uOa8Bg3oRHgXmKdUD0shy6+PewuwV902DCEyYEjxIMS8HCaXqaxGf1tLFVOv4vaUeBl0q5LkUZoSsBlT/jkg+QqXtHQxNvQuXjSPTIjRO24OtB/w2VaXC3+GDH5kEtW0c52We0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM5uAJcP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C6BC4CEFD;
	Mon,  5 May 2025 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746470636;
	bh=tF04Fns79sH1yaJ5H8T/Hh5MDrmddyRBb/f3XQX4pgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uM5uAJcP15BVWhuXYww/5TrKz+DfcC4Wt8xaxG7HsFpPtzKQfbc6udt6k+YnHlgKN
	 5SN9QZm8uO3QVhWg9/l5fZtVkO1yL9OkEe8D12NEM6fEMA5lzBFAyQ0h/81PJ0S0hX
	 ihSnE9ZT/VhKnO1I0dLPoOtlu/z7Zg2HBZO2zymhVW2q/BTYfZFH/mlguYwIKWF6WY
	 FacKgX9MVq1Z5yaEvjXqujbOxlsyBEESK0LYZqNJFrbyKdb9/YWanCoAf9U2W6HEMO
	 xqGSvNKKruYaDI75hjoTYS5pbyG9jxSrx9nL/YGCQ1/tuzUYEI24eDhOMhmPBHzXxO
	 hP/CRbTUM54RQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acb615228a4so1115071566b.0;
        Mon, 05 May 2025 11:43:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHN+PTcqhd47NtZtbly8iL/Kxch5n2+kovY6i3tTmzv8eUbjbFnVHzK2aZPsTF0D8JVC4sRIzLGCKBfj9mNJdcgyM=@vger.kernel.org, AJvYcCUh/3E2KeHLxwPI2rup6SLCEwt0dfwvnGKiBi+lCtRrYm8T1LSBKHU5Bgk+yRlQn3Na3VEvjGvBR+CEzKW+@vger.kernel.org, AJvYcCUzxShDmwaDtLZgFL3QKFxx1fD22fbKMLVyS39QbQMV17m/c08qKNWbWDjDN/HymwFAzEpFbfxbQ8n8/A==@vger.kernel.org, AJvYcCVsWmQi9WtZ1ZSFIdnipI6JyHdj4iznDvg0Q7bWQsY5IWcm7Jxv6Bxnj36zexPNmov1MRA1z7kjwzg=@vger.kernel.org, AJvYcCW5tjlg/05IQij+AdcS0kTmckWXXs9F2aXdJqNFMVnU6Za6QaXRgBbWZcnHx5e1dHDlkQUaloDniDQU5SEz@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJgIxyWJVTDQdYwlbZjToTp4D/LOXD2p37Mk3rNMBJ4lPQuZJ
	Jl+XTvZ3dIiIYusrU1h6W1OaJmXZ20unVwJJmXAKd/goCMDYBowYlSZbed/EYRwEJf4HCLx9XSn
	VyXI+bB+w2CyZM8UprqbEyJaICA==
X-Google-Smtp-Source: AGHT+IE07Ly6dyu8Y+aF9BlZdIf7+P37J2qLB07/RiqfMFZ0ipjDBLk74RTbDrbdYckFkuO0cf7wPwVCCZB9ROIhhI4=
X-Received: by 2002:a17:906:c144:b0:acb:2050:c105 with SMTP id
 a640c23a62f3a-ad1d2f5cadbmr46457866b.21.1746470634738; Mon, 05 May 2025
 11:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org> <20250410-dt-cpu-schema-v2-11-63d7dc9ddd0a@kernel.org>
In-Reply-To: <20250410-dt-cpu-schema-v2-11-63d7dc9ddd0a@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 May 2025 13:43:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLGHQ4YBqGGEdyirtgaBnJKRxOxOKTaQLv2jm-g8TNndA@mail.gmail.com>
X-Gm-Features: ATxdqUH6daJs7nOd8Y48rS3eP2-1poIs0MGdxfDe75Fd100QvIPr8Ytk27ZE1_w
Message-ID: <CAL_JsqLGHQ4YBqGGEdyirtgaBnJKRxOxOKTaQLv2jm-g8TNndA@mail.gmail.com>
Subject: Re: [PATCH v2 11/17] arm64: dts: amlogic: Drop redundant CPU "clock-latency"
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Conor Dooley <conor@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>, 
	UNGLinuxDriver@microchip.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Andy Gross <agross@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:50=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org=
> wrote:
>
> The "clock-latency" property is part of the deprecated opp-v1 binding
> and is redundant if the opp-v2 table has equal or larger values in any
> "clock-latency-ns". Add any missing "clock-latency-ns" properties and
> remove "clock-latency".
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Ping!

>  arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts             | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts         | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts             | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts               | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts            | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi                   | 1 +
>  arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi             | 2 ++
>  arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi      | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi          | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi       | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts    | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi            | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts        | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi             | 2 ++
>  arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi              | 6 ------
>  arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi              | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi           | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts        | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi             | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts              | 4 ----
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi                    | 1 +
>  23 files changed, 6 insertions(+), 92 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts b/arch/arm=
64/boot/dts/amlogic/meson-g12a-fbx8am.dts
> index 9aa36f17ffa2..d0a3b4b9229c 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-fbx8am.dts
> @@ -267,28 +267,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &ethmac {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts b/arch=
/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> index 952b8d02e5c2..4353485c6f26 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dts
> @@ -220,28 +220,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cvbs_vdac_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm=
64/boot/dts/amlogic/meson-g12a-sei510.dts
> index 52fbc5103e45..f39fcabc763f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
> @@ -314,28 +314,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cvbs_vdac_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts b/arch/arm64=
/boot/dts/amlogic/meson-g12a-u200.dts
> index 5407049d2647..b5bf8ecc91e6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
> @@ -407,28 +407,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &clkc_audio {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/ar=
m64/boot/dts/amlogic/meson-g12a-x96-max.dts
> index 01da83658ae3..5ab460a3e637 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
> @@ -263,28 +263,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cvbs_vdac_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boo=
t/dts/amlogic/meson-g12a.dtsi
> index 543e70669df5..deee61dbe074 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -62,6 +62,7 @@ cpu_opp_table: opp-table {
>                 opp-1000000000 {
>                         opp-hz =3D /bits/ 64 <1000000000>;
>                         opp-microvolt =3D <731000>;
> +                       clock-latency-ns =3D <50000>;
>                 };
>
>                 opp-1200000000 {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dt=
s b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
> index adedc1340c78..415248931ab1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-libretech-cc.dts
> @@ -76,42 +76,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &pwm_ab {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi b/arch/arm=
64/boot/dts/amlogic/meson-g12b-a311d.dtsi
> index 8e9ad1e51d66..8ecb5bd125c1 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
> @@ -14,6 +14,7 @@ cpu_opp_table_0: opp-table-0 {
>                 opp-1000000000 {
>                         opp-hz =3D /bits/ 64 <1000000000>;
>                         opp-microvolt =3D <761000>;
> +                       clock-latency-ns =3D <50000>;
>                 };
>
>                 opp-1200000000 {
> @@ -54,6 +55,7 @@ cpub_opp_table_1: opp-table-1 {
>                 opp-1000000000 {
>                         opp-hz =3D /bits/ 64 <1000000000>;
>                         opp-microvolt =3D <731000>;
> +                       clock-latency-ns =3D <50000>;
>                 };
>
>                 opp-1200000000 {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/a=
rch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> index 92e8b26ecccc..39011b645128 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> @@ -155,42 +155,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &ext_mdio {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi b/arch/=
arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> index 54663c55a20e..1b08303c4282 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi
> @@ -263,42 +263,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &ethmac {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/ar=
ch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> index 48650bad230d..fc737499f207 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
> @@ -51,42 +51,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &pwm_ab {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b=
/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> index e21831dfceee..d5938a4a6da3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> @@ -281,42 +281,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  /* RK817 only supports 12.5mV steps, round up the values */
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi b/arch/ar=
m64/boot/dts/amlogic/meson-g12b-odroid.dtsi
> index 7e8964bacfce..3298d59833b6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi
> @@ -227,42 +227,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu_thermal {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts b/arc=
h/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
> index fc05ecf90714..1e5c6f984945 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-radxa-zero2.dts
> @@ -259,42 +259,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu_thermal {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm=
64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> index 44c23c984034..19cad93a6889 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
> @@ -14,6 +14,7 @@ cpu_opp_table_0: opp-table-0 {
>                 opp-1000000000 {
>                         opp-hz =3D /bits/ 64 <1000000000>;
>                         opp-microvolt =3D <731000>;
> +                       clock-latency-ns =3D <50000>;
>                 };
>
>                 opp-1200000000 {
> @@ -59,6 +60,7 @@ cpub_opp_table_1: opp-table-1 {
>                 opp-1000000000 {
>                         opp-hz =3D /bits/ 64 <1000000000>;
>                         opp-microvolt =3D <771000>;
> +                       clock-latency-ns =3D <50000>;
>                 };
>
>                 opp-1200000000 {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm6=
4/boot/dts/amlogic/meson-g12b-w400.dtsi
> index a7a0fc264cdc..9b6d780eada7 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
> @@ -213,42 +213,36 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table_0>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu100 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu101 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu102 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu103 {
>         cpu-supply =3D <&vddcpu_a>;
>         operating-points-v2 =3D <&cpub_opp_table_1>;
>         clocks =3D <&clkc CLKID_CPUB_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cvbs_vdac_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi b/arch/arm6=
4/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> index a3463149db3d..9be3084b090d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-ac2xx.dtsi
> @@ -147,28 +147,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU1_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU2_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU3_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cvbs_vdac_port {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi b/arch/a=
rm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
> index 40db95f64636..538b35036954 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi.dtsi
> @@ -185,28 +185,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU1_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU2_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU3_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &ext_mdio {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arc=
h/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> index 5d75ad3f3e46..a3d9b66b6878 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
> @@ -51,28 +51,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU1_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU2_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU3_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &pwm_AO_cd {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm=
64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index ad8d07883760..c4524eb4f099 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -250,28 +250,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU1_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU2_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU3_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &ext_mdio {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dt=
s b/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> index 537370db360f..5daadfb170b4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-s905d3-libretech-cc.dts
> @@ -64,26 +64,22 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU1_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU2_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu_b>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU3_CLK>;
> -       clock-latency =3D <50000>;
>  };
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm6=
4/boot/dts/amlogic/meson-sm1-sei610.dts
> index 37d7f64b6d5d..024d2eb8e6ee 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
> @@ -359,28 +359,24 @@ &cpu0 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu1 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU1_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu2 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU2_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &cpu3 {
>         cpu-supply =3D <&vddcpu>;
>         operating-points-v2 =3D <&cpu_opp_table>;
>         clocks =3D <&clkc CLKID_CPU3_CLK>;
> -       clock-latency =3D <50000>;
>  };
>
>  &ethmac {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot=
/dts/amlogic/meson-sm1.dtsi
> index 97e4b52066dc..966ebb19cc55 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -100,6 +100,7 @@ cpu_opp_table: opp-table {
>                 opp-1000000000 {
>                         opp-hz =3D /bits/ 64 <1000000000>;
>                         opp-microvolt =3D <770000>;
> +                       clock-latency-ns =3D <50000>;
>                 };
>
>                 opp-1200000000 {
>
> --
> 2.47.2
>
>

