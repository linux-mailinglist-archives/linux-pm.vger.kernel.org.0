Return-Path: <linux-pm+bounces-24797-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DEA7BA2B
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 11:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22592189D677
	for <lists+linux-pm@lfdr.de>; Fri,  4 Apr 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E21B393C;
	Fri,  4 Apr 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mNjoFrze"
X-Original-To: linux-pm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F711B0F17;
	Fri,  4 Apr 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759850; cv=none; b=bDbSzPw3zijrnqsNiYlMzp1DQnB4AfliaFWvHcf5xcW2jPu7MkkGtHaJNJ8MJ18gwoPLk0o1t1dJpbOmjoZYJ9G0iwjwX39pGAT49T+5juMFc5wcIb7Va4XTdsGiAvOD33lgRalWsPqx2GgvQC4BGmHKVaoyK5x247EM6+qPCX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759850; c=relaxed/simple;
	bh=/1xoPsKQlQBWMpLcgEjKZ/hJOcJIL0rM7P/QyChG6kU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyjSC2dE3NTpw6GpRbuEL2ON1euWWEjJKtYswTOG28SxdmgxOAueZ5WBQKvPfeEvPweiYlvyxGK5k3C5oe0ej8C22JIWesPgrH/xXZZmOeJ1wIbCmVfDcVM1NHg5c68YCTxhlUwpdR5oSeCM1VqOCGWtsHa4n5fQNKudwmXk324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mNjoFrze; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1743759848; x=1775295848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1xoPsKQlQBWMpLcgEjKZ/hJOcJIL0rM7P/QyChG6kU=;
  b=mNjoFrzeWd8peTAG5WC9J3+Cc9JqBm8ldSXpV+imLvRQa9XccuyrirYM
   nkYPQMBk5V71KPnKqpR8U8AiKSFq9hQv9n+oNFp23OZBX6i1G/OF5ZK5L
   UBgiTzLC55B3GqDdIm2BY4TtZ4C4fz57sSgpgknLcAAB9+ITjauwCzBXd
   6DLdRDeYGLV439g196KXc1L5fp9M4mkCeRNcNpQhl/vg1cj0wI6JChAa1
   OJMeivD6LvAyKUmQxrSTOHpQIMvWWSvUbgi7yDxL5V7C39d8EbA4bM3pW
   /KsjuJVOCRQOTRICsz1Fl9OmsYeD7k72OUGq7faC5SqEYgFNn9/VHpHUa
   g==;
X-CSE-ConnectionGUID: CCbOwbOjQ2SseDv2d8Zv6w==
X-CSE-MsgGUID: TTSMcQbYQG2UnIfQGa0ggw==
X-IronPort-AV: E=Sophos;i="6.15,187,1739862000"; 
   d="scan'208";a="39641646"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2025 02:44:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 4 Apr 2025 02:43:37 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Fri, 4 Apr 2025 02:43:28 -0700
Date: Fri, 4 Apr 2025 09:43:28 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Vincenzo Frascino
	<vincenzo.frascino@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Viresh Kumar
	<vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>, <zhouyanjie@wanyeetech.com>, Conor Dooley
	<conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Claudiu
 Beznea" <claudiu.beznea@tuxon.dev>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-msm@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
	<linux-amlogic@lists.infradead.org>, <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 04/19] arm64: dts: microchip: sparx5: Fix CPU node
 "enable-method" property dependencies
Message-ID: <20250404094328.cojaf5cxrotnetln@DEN-DL-M70577>
References: <20250403-dt-cpu-schema-v1-0-076be7171a85@kernel.org>
 <20250403-dt-cpu-schema-v1-4-076be7171a85@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250403-dt-cpu-schema-v1-4-076be7171a85@kernel.org>

> The "spin-table" enable-method requires "cpu-release-addr" property,
> so add a dummy entry. It is assumed the bootloader will fill in the
> correct values.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> index 32bb76b3202a..83bf5c81b5f7 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi
> @@ -12,10 +12,12 @@ &psci {
> 
>  &cpu0 {
>         enable-method = "spin-table";
> +       cpu-release-addr = /bits/ 64 <0>;
>  };
> 
>  &cpu1 {
>         enable-method = "spin-table";
> +       cpu-release-addr = /bits/ 64 <0>;
>  };
> 
>  &uart0 {
> 
> --
> 2.47.2
>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>
 

