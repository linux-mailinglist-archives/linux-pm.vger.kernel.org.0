Return-Path: <linux-pm+bounces-33229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03179B3981C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732B71B276ED
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 09:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D22E1C6B;
	Thu, 28 Aug 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="BZyx3/bF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GmGoNlX2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F082C031E;
	Thu, 28 Aug 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372886; cv=none; b=TDUkjpFvrvRlYjT2mObtFtrel+KvnYEg2DmL3vmQDsEk0sZynaCj9pvo5ytxhDx1mUGidk3EIARJEAQVOpDymA7BycFg7vPmVKT95CJpAhJ80KKVjRH7HoDoUA7SrbuRARLdLt9T0qQim1C7Np+3iW++fh5Vm5kHkPHzFlMwcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372886; c=relaxed/simple;
	bh=wTkTt/ldhc4sfmoSdt91MceT6nKR32wbk6o3EFQOyqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMt21BOo/p1GQYkC1uOyY3hKvX6ijRexGs6U+idLvoDVrverpF9pJ/oQvb3l9er54OFglOFQ1SkoHCqjuCqb8FlrNGcQSN3xTS1qVz2M27VvorWsAJULOZLKLiVv0ZP2JiSJ33HTUySiFzlR/g4M579aDmwBFaUhpEvhejOh26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=BZyx3/bF; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GmGoNlX2 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756372880; x=1787908880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RE5GcdmvfAj9afyuTQ0l00VwFL859vafL7wfQ9Z4O68=;
  b=BZyx3/bF1ak8SvpxoVC/JcDf/0Xrxt8qSjuyd+vj/URkQl3hSti48yht
   xils/7rOjIU+hgaDprFUE7hT5qbLlbmxzWAnOZSA11liA77TrzTQvja0P
   7ZbT+UcssT8NHjJgUnmU4SGZ9RsmYx1jjvXKNggrX0524zML6TXqkHF/g
   VgVPKCxWlOtgmDWiA9M+hTbqbNEEGpTv10h6psubjOYLvm/T3edH5+fdK
   qtgmxGKSel3/pBrINue0Mdm2SlrkFwwyAFZ29j3Pw4kCGHW8iRFo3RDz4
   Fof1Xi6taSI/n7Doi6MZBtV5N3NXS3GxOXX3mPl/mU1vnTtJHnlCbiYAB
   g==;
X-CSE-ConnectionGUID: XM+Xr/ofQgyoizrUpFOBqQ==
X-CSE-MsgGUID: +1dfV7X1TPyIrjv2rYOm7A==
X-IronPort-AV: E=Sophos;i="6.18,217,1751234400"; 
   d="scan'208";a="45952343"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2025 11:21:12 +0200
X-CheckPoint: {68B01F88-29-AD8F5F64-F0EACAA5}
X-MAIL-CPID: C5080894F2C06572176F785FF51B5723_1
X-Control-Analysis: str=0001.0A002126.68B01F20.00A6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAC29160D3C;
	Thu, 28 Aug 2025 11:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756372868;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RE5GcdmvfAj9afyuTQ0l00VwFL859vafL7wfQ9Z4O68=;
	b=GmGoNlX2naReYo+Ai56zE9Z4zKxBS3by2QGG05+9OdooRJuP30ej16D8yrN55OOfK0ZP3A
	s7v1N2VOmCr+PHrekfGRyJZVIBl94/zh5QVzojCX9T+N++KD3c0NnzeJTWA6vuLgUZUKqF
	1hbIDWGNM9VQWYQ60AmXA4BbqN9aTD/R1kBrbJx/q1ueI0e95hikwB9HodfOJ2Yh7efIX8
	i+KB87QSClAvsQ71mLon8ZpF0Fp94B09Je9TAY2Rsve4N+30jVT36PBVu/IQLVvE9THY3m
	XJTEElgQ6vfN+wx5LtTHX715ghqRe0nxmDiv502/oKwR4gJbkbhKk+eSBWjfsA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 frieder.schrempf@kontron.de, primoz.fiser@norik.com, othacehe@gnu.org,
 Markus.Niebel@ew.tq-group.com, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux@ew.tq-group.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
 Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v9 3/6] arm64: dts: imx91: add i.MX91 dtsi support
Date: Thu, 28 Aug 2025 11:21:01 +0200
Message-ID: <6086482.MhkbZ0Pkbq@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250825091223.1378137-4-joy.zou@nxp.com>
References:
 <20250825091223.1378137-1-joy.zou@nxp.com>
 <20250825091223.1378137-4-joy.zou@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Montag, 25. August 2025, 11:12:20 CEST schrieb Joy Zou:
> The i.MX 91 family features an Arm Cortex-A55 running at up to 1.4GHz,
> support for modern LPDDR4 memory to enable platform longevity, along
> with a rich set of peripherals targeting medical, industrial and
> consumer IoT market segments.
>=20
> The mainly difference between i.MX91 and i.MX93 is as follows:
> - i.MX91 removed some clocks and modified the names of some clocks.
> - i.MX91 only has one A core.
> - i.MX91 has different pinmux.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

=46or both TQMa93 and the upcoming TQMa91 boards:
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Changes for v8:
> 1. modify the commit message to keep wrap at 75 chars.
>=20
> Changes for v7:
> 1. remove temperature sensor description from commit message.
>=20
> Changes for v6:
> 1. remove tmu node due to dtb-check warning.
>=20
> Changes for v5:
> 1. modify the imx91.dtsi to use imx91_93_common.dtsi.
>=20
> Changes for v4:
> 1. modify the references in imx91.dtsi.
> 2. modify the code alignment.
>=20
> Changes for v2:
> 1. change ddr node pmu compatible.
> 2. remove mu1 and mu2.
> 3. change iomux node compatible and enable 91 pinctr.
> 4. refine commit message.
> 5. change hex to lowercase in pinfunc.h.
> 6. ordering nodes with the dt-format tool
> ---
>  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx91.dtsi      |  71 ++
>  .../boot/dts/freescale/imx91_93_common.dtsi   |   2 +-
>  3 files changed, 842 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
>  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx91-pinfunc.h b/arch/arm64/b=
oot/dts/freescale/imx91-pinfunc.h
> new file mode 100644
> index 000000000000..3e19945f5ce3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> @@ -0,0 +1,770 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef __DTS_IMX91_PINFUNC_H
> +#define __DTS_IMX91_PINFUNC_H
> +
> +/*
> + * The pin function ID is a tuple of
> + * <mux_reg conf_reg input_reg mux_mode input_val>
> + */
> +#define MX91_PAD_DAP_TDI__JTAG_MUX_TDI                                  =
         0x0000 0x01b0 0x03d8 0x00 0x00
> +#define MX91_PAD_DAP_TDI__MQS2_LEFT                                     =
         0x0000 0x01b0 0x0000 0x01 0x00
> +#define MX91_PAD_DAP_TDI__CAN2_TX                                       =
         0x0000 0x01b0 0x0000 0x03 0x00
> +#define MX91_PAD_DAP_TDI__FLEXIO2_FLEXIO30                              =
         0x0000 0x01b0 0x0000 0x04 0x00
> +#define MX91_PAD_DAP_TDI__GPIO3_IO28                                    =
         0x0000 0x01b0 0x0000 0x05 0x00
> +#define MX91_PAD_DAP_TDI__LPUART5_RX                                    =
         0x0000 0x01b0 0x0488 0x06 0x00
> +
> +#define MX91_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS                            =
         0x0004 0x01b4 0x03dc 0x00 0x00
> +#define MX91_PAD_DAP_TMS_SWDIO__FLEXIO2_FLEXIO31                        =
         0x0004 0x01b4 0x0000 0x04 0x00
> +#define MX91_PAD_DAP_TMS_SWDIO__GPIO3_IO29                              =
         0x0004 0x01b4 0x0000 0x05 0x00
> +#define MX91_PAD_DAP_TMS_SWDIO__LPUART5_RTS_B                           =
         0x0004 0x01b4 0x0000 0x06 0x00
> +
> +#define MX91_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK                           =
         0x0008 0x01b8 0x03d4 0x00 0x00
> +#define MX91_PAD_DAP_TCLK_SWCLK__FLEXIO1_FLEXIO30                       =
         0x0008 0x01b8 0x0000 0x04 0x00
> +#define MX91_PAD_DAP_TCLK_SWCLK__GPIO3_IO30                             =
         0x0008 0x01b8 0x0000 0x05 0x00
> +#define MX91_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B                          =
         0x0008 0x01b8 0x0484 0x06 0x00
> +
> +#define MX91_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO                         =
         0x000c 0x01bc 0x0000 0x00 0x00
> +#define MX91_PAD_DAP_TDO_TRACESWO__MQS2_RIGHT                           =
         0x000c 0x01bc 0x0000 0x01 0x00
> +#define MX91_PAD_DAP_TDO_TRACESWO__CAN2_RX                              =
         0x000c 0x01bc 0x0364 0x03 0x00
> +#define MX91_PAD_DAP_TDO_TRACESWO__FLEXIO1_FLEXIO31                     =
         0x000c 0x01bc 0x0000 0x04 0x00
> +#define MX91_PAD_DAP_TDO_TRACESWO__GPIO3_IO31                           =
         0x000c 0x01bc 0x0000 0x05 0x00
> +#define MX91_PAD_DAP_TDO_TRACESWO__LPUART5_TX                           =
         0x000c 0x01bc 0x048c 0x06 0x00
> +
> +#define MX91_PAD_GPIO_IO00__GPIO2_IO0                                   =
         0x0010 0x01c0 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO00__LPI2C3_SDA                                  =
         0x0010 0x01c0 0x03f4 0x01 0x00
> +#define MX91_PAD_GPIO_IO00__MEDIAMIX_CAM_CLK                            =
         0x0010 0x01c0 0x04bc 0x02 0x00
> +#define MX91_PAD_GPIO_IO00__MEDIAMIX_DISP_CLK                           =
         0x0010 0x01c0 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO00__LPSPI6_PCS0                                 =
         0x0010 0x01c0 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO00__LPUART5_TX                                  =
         0x0010 0x01c0 0x048c 0x05 0x01
> +#define MX91_PAD_GPIO_IO00__LPI2C5_SDA                                  =
         0x0010 0x01c0 0x0404 0x06 0x00
> +#define MX91_PAD_GPIO_IO00__FLEXIO1_FLEXIO0                             =
         0x0010 0x01c0 0x036c 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO01__GPIO2_IO1                                   =
         0x0014 0x01c4 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO01__LPI2C3_SCL                                  =
         0x0014 0x01c4 0x03f0 0x01 0x00
> +#define MX91_PAD_GPIO_IO01__MEDIAMIX_CAM_DATA0                          =
         0x0014 0x01c4 0x0490 0x02 0x00
> +#define MX91_PAD_GPIO_IO01__MEDIAMIX_DISP_DE                            =
         0x0014 0x01c4 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO01__LPSPI6_SIN                                  =
         0x0014 0x01c4 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO01__LPUART5_RX                                  =
         0x0014 0x01c4 0x0488 0x05 0x01
> +#define MX91_PAD_GPIO_IO01__LPI2C5_SCL                                  =
         0x0014 0x01c4 0x0400 0x06 0x00
> +#define MX91_PAD_GPIO_IO01__FLEXIO1_FLEXIO1                             =
         0x0014 0x01c4 0x0370 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO02__GPIO2_IO2                                   =
         0x0018 0x01c8 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO02__LPI2C4_SDA                                  =
         0x0018 0x01c8 0x03fc 0x01 0x00
> +#define MX91_PAD_GPIO_IO02__MEDIAMIX_CAM_VSYNC                          =
         0x0018 0x01c8 0x04c0 0x02 0x00
> +#define MX91_PAD_GPIO_IO02__MEDIAMIX_DISP_VSYNC                         =
         0x0018 0x01c8 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO02__LPSPI6_SOUT                                 =
         0x0018 0x01c8 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO02__LPUART5_CTS_B                               =
         0x0018 0x01c8 0x0484 0x05 0x01
> +#define MX91_PAD_GPIO_IO02__LPI2C6_SDA                                  =
         0x0018 0x01c8 0x040c 0x06 0x00
> +#define MX91_PAD_GPIO_IO02__FLEXIO1_FLEXIO2                             =
         0x0018 0x01c8 0x0374 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO03__GPIO2_IO3                                   =
         0x001c 0x01cc 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO03__LPI2C4_SCL                                  =
         0x001c 0x01cc 0x03f8 0x01 0x00
> +#define MX91_PAD_GPIO_IO03__MEDIAMIX_CAM_HSYNC                          =
         0x001c 0x01cc 0x04b8 0x02 0x00
> +#define MX91_PAD_GPIO_IO03__MEDIAMIX_DISP_HSYNC                         =
         0x001c 0x01cc 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO03__LPSPI6_SCK                                  =
         0x001c 0x01cc 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO03__LPUART5_RTS_B                               =
         0x001c 0x01cc 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO03__LPI2C6_SCL                                  =
         0x001c 0x01cc 0x0408 0x06 0x00
> +#define MX91_PAD_GPIO_IO03__FLEXIO1_FLEXIO3                             =
         0x001c 0x01cc 0x0378 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO04__GPIO2_IO4                                   =
         0x0020 0x01d0 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO04__TPM3_CH0                                    =
         0x0020 0x01d0 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO04__PDM_CLK                                     =
         0x0020 0x01d0 0x0000 0x02 0x00
> +#define MX91_PAD_GPIO_IO04__MEDIAMIX_DISP_DATA0                         =
         0x0020 0x01d0 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO04__LPSPI7_PCS0                                 =
         0x0020 0x01d0 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO04__LPUART6_TX                                  =
         0x0020 0x01d0 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO04__LPI2C6_SDA                                  =
         0x0020 0x01d0 0x040c 0x06 0x01
> +#define MX91_PAD_GPIO_IO04__FLEXIO1_FLEXIO4                             =
         0x0020 0x01d0 0x037c 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO05__GPIO2_IO5                                   =
         0x0024 0x01d4 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO05__TPM4_CH0                                    =
         0x0024 0x01d4 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO05__PDM_BIT_STREAM0                             =
         0x0024 0x01d4 0x04c4 0x02 0x00
> +#define MX91_PAD_GPIO_IO05__MEDIAMIX_DISP_DATA1                         =
         0x0024 0x01d4 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO05__LPSPI7_SIN                                  =
         0x0024 0x01d4 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO05__LPUART6_RX                                  =
         0x0024 0x01d4 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO05__LPI2C6_SCL                                  =
         0x0024 0x01d4 0x0408 0x06 0x01
> +#define MX91_PAD_GPIO_IO05__FLEXIO1_FLEXIO5                             =
         0x0024 0x01d4 0x0380 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO06__GPIO2_IO6                                   =
         0x0028 0x01d8 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO06__TPM5_CH0                                    =
         0x0028 0x01d8 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO06__PDM_BIT_STREAM1                             =
         0x0028 0x01d8 0x04c8 0x02 0x00
> +#define MX91_PAD_GPIO_IO06__MEDIAMIX_DISP_DATA2                         =
         0x0028 0x01d8 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO06__LPSPI7_SOUT                                 =
         0x0028 0x01d8 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO06__LPUART6_CTS_B                               =
         0x0028 0x01d8 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO06__LPI2C7_SDA                                  =
         0x0028 0x01d8 0x0414 0x06 0x00
> +#define MX91_PAD_GPIO_IO06__FLEXIO1_FLEXIO6                             =
         0x0028 0x01d8 0x0384 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO07__GPIO2_IO7                                   =
         0x002c 0x01dc 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO07__LPSPI3_PCS1                                 =
         0x002c 0x01dc 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO07__MEDIAMIX_CAM_DATA1                          =
         0x002c 0x01dc 0x0494 0x02 0x00
> +#define MX91_PAD_GPIO_IO07__MEDIAMIX_DISP_DATA3                         =
         0x002c 0x01dc 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO07__LPSPI7_SCK                                  =
         0x002c 0x01dc 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO07__LPUART6_RTS_B                               =
         0x002c 0x01dc 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO07__LPI2C7_SCL                                  =
         0x002c 0x01dc 0x0410 0x06 0x00
> +#define MX91_PAD_GPIO_IO07__FLEXIO1_FLEXIO7                             =
         0x002c 0x01dc 0x0388 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO08__GPIO2_IO8                                   =
         0x0030 0x01e0 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO08__LPSPI3_PCS0                                 =
         0x0030 0x01e0 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO08__MEDIAMIX_CAM_DATA2                          =
         0x0030 0x01e0 0x0498 0x02 0x00
> +#define MX91_PAD_GPIO_IO08__MEDIAMIX_DISP_DATA4                         =
         0x0030 0x01e0 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO08__TPM6_CH0                                    =
         0x0030 0x01e0 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO08__LPUART7_TX                                  =
         0x0030 0x01e0 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO08__LPI2C7_SDA                                  =
         0x0030 0x01e0 0x0414 0x06 0x01
> +#define MX91_PAD_GPIO_IO08__FLEXIO1_FLEXIO8                             =
         0x0030 0x01e0 0x038c 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO09__GPIO2_IO9                                   =
         0x0034 0x01e4 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO09__LPSPI3_SIN                                  =
         0x0034 0x01e4 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO09__MEDIAMIX_CAM_DATA3                          =
         0x0034 0x01e4 0x049c 0x02 0x00
> +#define MX91_PAD_GPIO_IO09__MEDIAMIX_DISP_DATA5                         =
         0x0034 0x01e4 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO09__TPM3_EXTCLK                                 =
         0x0034 0x01e4 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO09__LPUART7_RX                                  =
         0x0034 0x01e4 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO09__LPI2C7_SCL                                  =
         0x0034 0x01e4 0x0410 0x06 0x01
> +#define MX91_PAD_GPIO_IO09__FLEXIO1_FLEXIO9                             =
         0x0034 0x01e4 0x0390 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO10__GPIO2_IO10                                  =
         0x0038 0x01e8 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO10__LPSPI3_SOUT                                 =
         0x0038 0x01e8 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO10__MEDIAMIX_CAM_DATA4                          =
         0x0038 0x01e8 0x04a0 0x02 0x00
> +#define MX91_PAD_GPIO_IO10__MEDIAMIX_DISP_DATA6                         =
         0x0038 0x01e8 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO10__TPM4_EXTCLK                                 =
         0x0038 0x01e8 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO10__LPUART7_CTS_B                               =
         0x0038 0x01e8 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO10__LPI2C8_SDA                                  =
         0x0038 0x01e8 0x041c 0x06 0x00
> +#define MX91_PAD_GPIO_IO10__FLEXIO1_FLEXIO10                            =
         0x0038 0x01e8 0x0394 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO11__GPIO2_IO11                                  =
         0x003c 0x01ec 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO11__LPSPI3_SCK                                  =
         0x003c 0x01ec 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO11__MEDIAMIX_CAM_DATA5                          =
         0x003c 0x01ec 0x04a4 0x02 0x00
> +#define MX91_PAD_GPIO_IO11__MEDIAMIX_DISP_DATA7                         =
         0x003c 0x01ec 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO11__TPM5_EXTCLK                                 =
         0x003c 0x01ec 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO11__LPUART7_RTS_B                               =
         0x003c 0x01ec 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO11__LPI2C8_SCL                                  =
         0x003c 0x01ec 0x0418 0x06 0x00
> +#define MX91_PAD_GPIO_IO11__FLEXIO1_FLEXIO11                            =
         0x003c 0x01ec 0x0398 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO12__GPIO2_IO12                                  =
         0x0040 0x01f0 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO12__TPM3_CH2                                    =
         0x0040 0x01f0 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO12__PDM_BIT_STREAM2                             =
         0x0040 0x01f0 0x04cc 0x02 0x00
> +#define MX91_PAD_GPIO_IO12__MEDIAMIX_DISP_DATA8                         =
         0x0040 0x01f0 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO12__LPSPI8_PCS0                                 =
         0x0040 0x01f0 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO12__LPUART8_TX                                  =
         0x0040 0x01f0 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO12__LPI2C8_SDA                                  =
         0x0040 0x01f0 0x041c 0x06 0x01
> +#define MX91_PAD_GPIO_IO12__SAI3_RX_SYNC                                =
         0x0040 0x01f0 0x04dc 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO13__GPIO2_IO13                                  =
         0x0044 0x01f4 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO13__TPM4_CH2                                    =
         0x0044 0x01f4 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO13__PDM_BIT_STREAM3                             =
         0x0044 0x01f4 0x04d0 0x02 0x00
> +#define MX91_PAD_GPIO_IO13__MEDIAMIX_DISP_DATA9                         =
         0x0044 0x01f4 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO13__LPSPI8_SIN                                  =
         0x0044 0x01f4 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO13__LPUART8_RX                                  =
         0x0044 0x01f4 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO13__LPI2C8_SCL                                  =
         0x0044 0x01f4 0x0418 0x06 0x01
> +#define MX91_PAD_GPIO_IO13__FLEXIO1_FLEXIO13                            =
         0x0044 0x01f4 0x039c 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO14__GPIO2_IO14                                  =
         0x0048 0x01f8 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO14__LPUART3_TX                                  =
         0x0048 0x01f8 0x0474 0x01 0x00
> +#define MX91_PAD_GPIO_IO14__MEDIAMIX_CAM_DATA6                          =
         0x0048 0x01f8 0x04a8 0x02 0x00
> +#define MX91_PAD_GPIO_IO14__MEDIAMIX_DISP_DATA10                        =
         0x0048 0x01f8 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO14__LPSPI8_SOUT                                 =
         0x0048 0x01f8 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO14__LPUART8_CTS_B                               =
         0x0048 0x01f8 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO14__LPUART4_TX                                  =
         0x0048 0x01f8 0x0480 0x06 0x00
> +#define MX91_PAD_GPIO_IO14__FLEXIO1_FLEXIO14                            =
         0x0048 0x01f8 0x03a0 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO15__GPIO2_IO15                                  =
         0x004c 0x01fc 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO15__LPUART3_RX                                  =
         0x004c 0x01fc 0x0470 0x01 0x00
> +#define MX91_PAD_GPIO_IO15__MEDIAMIX_CAM_DATA7                          =
         0x004c 0x01fc 0x04ac 0x02 0x00
> +#define MX91_PAD_GPIO_IO15__MEDIAMIX_DISP_DATA11                        =
         0x004c 0x01fc 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO15__LPSPI8_SCK                                  =
         0x004c 0x01fc 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO15__LPUART8_RTS_B                               =
         0x004c 0x01fc 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO15__LPUART4_RX                                  =
         0x004c 0x01fc 0x047c 0x06 0x00
> +#define MX91_PAD_GPIO_IO15__FLEXIO1_FLEXIO15                            =
         0x004c 0x01fc 0x03a4 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO16__GPIO2_IO16                                  =
         0x0050 0x0200 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO16__SAI3_TX_BCLK                                =
         0x0050 0x0200 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO16__PDM_BIT_STREAM2                             =
         0x0050 0x0200 0x04cc 0x02 0x01
> +#define MX91_PAD_GPIO_IO16__MEDIAMIX_DISP_DATA12                        =
         0x0050 0x0200 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO16__LPUART3_CTS_B                               =
         0x0050 0x0200 0x046c 0x04 0x00
> +#define MX91_PAD_GPIO_IO16__LPSPI4_PCS2                                 =
         0x0050 0x0200 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO16__LPUART4_CTS_B                               =
         0x0050 0x0200 0x0478 0x06 0x00
> +#define MX91_PAD_GPIO_IO16__FLEXIO1_FLEXIO16                            =
         0x0050 0x0200 0x03a8 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO17__GPIO2_IO17                                  =
         0x0054 0x0204 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO17__SAI3_MCLK                                   =
         0x0054 0x0204 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO17__MEDIAMIX_CAM_DATA8                          =
         0x0054 0x0204 0x04b0 0x02 0x00
> +#define MX91_PAD_GPIO_IO17__MEDIAMIX_DISP_DATA13                        =
         0x0054 0x0204 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO17__LPUART3_RTS_B                               =
         0x0054 0x0204 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO17__LPSPI4_PCS1                                 =
         0x0054 0x0204 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO17__LPUART4_RTS_B                               =
         0x0054 0x0204 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO17__FLEXIO1_FLEXIO17                            =
         0x0054 0x0204 0x03ac 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO18__GPIO2_IO18                                  =
         0x0058 0x0208 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO18__SAI3_RX_BCLK                                =
         0x0058 0x0208 0x04d8 0x01 0x00
> +#define MX91_PAD_GPIO_IO18__MEDIAMIX_CAM_DATA9                          =
         0x0058 0x0208 0x04b4 0x02 0x00
> +#define MX91_PAD_GPIO_IO18__MEDIAMIX_DISP_DATA14                        =
         0x0058 0x0208 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO18__LPSPI5_PCS0                                 =
         0x0058 0x0208 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO18__LPSPI4_PCS0                                 =
         0x0058 0x0208 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO18__TPM5_CH2                                    =
         0x0058 0x0208 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO18__FLEXIO1_FLEXIO18                            =
         0x0058 0x0208 0x03b0 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO19__GPIO2_IO19                                  =
         0x005c 0x020c 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO19__SAI3_RX_SYNC                                =
         0x005c 0x020c 0x04dc 0x01 0x01
> +#define MX91_PAD_GPIO_IO19__PDM_BIT_STREAM3                             =
         0x005c 0x020c 0x04d0 0x02 0x01
> +#define MX91_PAD_GPIO_IO19__MEDIAMIX_DISP_DATA15                        =
         0x005c 0x020c 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO19__LPSPI5_SIN                                  =
         0x005c 0x020c 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO19__LPSPI4_SIN                                  =
         0x005c 0x020c 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO19__TPM6_CH2                                    =
         0x005c 0x020c 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO19__SAI3_TX_DATA0                               =
         0x005c 0x020c 0x0000 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO20__GPIO2_IO20                                  =
         0x0060 0x0210 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO20__SAI3_RX_DATA0                               =
         0x0060 0x0210 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO20__PDM_BIT_STREAM0                             =
         0x0060 0x0210 0x04c4 0x02 0x01
> +#define MX91_PAD_GPIO_IO20__MEDIAMIX_DISP_DATA16                        =
         0x0060 0x0210 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO20__LPSPI5_SOUT                                 =
         0x0060 0x0210 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO20__LPSPI4_SOUT                                 =
         0x0060 0x0210 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO20__TPM3_CH1                                    =
         0x0060 0x0210 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO20__FLEXIO1_FLEXIO20                            =
         0x0060 0x0210 0x03b4 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO21__GPIO2_IO21                                  =
         0x0064 0x0214 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO21__SAI3_TX_DATA0                               =
         0x0064 0x0214 0x0000 0x01 0x00
> +#define MX91_PAD_GPIO_IO21__PDM_CLK                                     =
         0x0064 0x0214 0x0000 0x02 0x00
> +#define MX91_PAD_GPIO_IO21__MEDIAMIX_DISP_DATA17                        =
         0x0064 0x0214 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO21__LPSPI5_SCK                                  =
         0x0064 0x0214 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO21__LPSPI4_SCK                                  =
         0x0064 0x0214 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO21__TPM4_CH1                                    =
         0x0064 0x0214 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO21__SAI3_RX_BCLK                                =
         0x0064 0x0214 0x04d8 0x07 0x01
> +
> +#define MX91_PAD_GPIO_IO22__GPIO2_IO22                                  =
         0x0068 0x0218 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO22__USDHC3_CLK                                  =
         0x0068 0x0218 0x04e8 0x01 0x00
> +#define MX91_PAD_GPIO_IO22__SPDIF_IN                                    =
         0x0068 0x0218 0x04e4 0x02 0x00
> +#define MX91_PAD_GPIO_IO22__MEDIAMIX_DISP_DATA18                        =
         0x0068 0x0218 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO22__TPM5_CH1                                    =
         0x0068 0x0218 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO22__TPM6_EXTCLK                                 =
         0x0068 0x0218 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO22__LPI2C5_SDA                                  =
         0x0068 0x0218 0x0404 0x06 0x01
> +#define MX91_PAD_GPIO_IO22__FLEXIO1_FLEXIO22                            =
         0x0068 0x0218 0x03b8 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO23__GPIO2_IO23                                  =
         0x006c 0x021c 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO23__USDHC3_CMD                                  =
         0x006c 0x021c 0x04ec 0x01 0x00
> +#define MX91_PAD_GPIO_IO23__SPDIF_OUT                                   =
         0x006c 0x021c 0x0000 0x02 0x00
> +#define MX91_PAD_GPIO_IO23__MEDIAMIX_DISP_DATA19                        =
         0x006c 0x021c 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO23__TPM6_CH1                                    =
         0x006c 0x021c 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO23__LPI2C5_SCL                                  =
         0x006c 0x021c 0x0400 0x06 0x01
> +#define MX91_PAD_GPIO_IO23__FLEXIO1_FLEXIO23                            =
         0x006c 0x021c 0x03bc 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO24__GPIO2_IO24                                  =
         0x0070 0x0220 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO24__USDHC3_DATA0                                =
         0x0070 0x0220 0x04f0 0x01 0x00
> +#define MX91_PAD_GPIO_IO24__MEDIAMIX_DISP_DATA20                        =
         0x0070 0x0220 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO24__TPM3_CH3                                    =
         0x0070 0x0220 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO24__JTAG_MUX_TDO                                =
         0x0070 0x0220 0x0000 0x05 0x00
> +#define MX91_PAD_GPIO_IO24__LPSPI6_PCS1                                 =
         0x0070 0x0220 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO24__FLEXIO1_FLEXIO24                            =
         0x0070 0x0220 0x03c0 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO25__GPIO2_IO25                                  =
         0x0074 0x0224 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO25__USDHC3_DATA1                                =
         0x0074 0x0224 0x04f4 0x01 0x00
> +#define MX91_PAD_GPIO_IO25__CAN2_TX                                     =
         0x0074 0x0224 0x0000 0x02 0x00
> +#define MX91_PAD_GPIO_IO25__MEDIAMIX_DISP_DATA21                        =
         0x0074 0x0224 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO25__TPM4_CH3                                    =
         0x0074 0x0224 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO25__JTAG_MUX_TCK                                =
         0x0074 0x0224 0x03d4 0x05 0x01
> +#define MX91_PAD_GPIO_IO25__LPSPI7_PCS1                                 =
         0x0074 0x0224 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO25__FLEXIO1_FLEXIO25                            =
         0x0074 0x0224 0x03c4 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO26__GPIO2_IO26                                  =
         0x0078 0x0228 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO26__USDHC3_DATA2                                =
         0x0078 0x0228 0x04f8 0x01 0x00
> +#define MX91_PAD_GPIO_IO26__PDM_BIT_STREAM1                             =
         0x0078 0x0228 0x04c8 0x02 0x01
> +#define MX91_PAD_GPIO_IO26__MEDIAMIX_DISP_DATA22                        =
         0x0078 0x0228 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO26__TPM5_CH3                                    =
         0x0078 0x0228 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO26__JTAG_MUX_TDI                                =
         0x0078 0x0228 0x03d8 0x05 0x01
> +#define MX91_PAD_GPIO_IO26__LPSPI8_PCS1                                 =
         0x0078 0x0228 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO26__SAI3_TX_SYNC                                =
         0x0078 0x0228 0x04e0 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO27__GPIO2_IO27                                  =
         0x007c 0x022c 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO27__USDHC3_DATA3                                =
         0x007c 0x022c 0x04fc 0x01 0x00
> +#define MX91_PAD_GPIO_IO27__CAN2_RX                                     =
         0x007c 0x022c 0x0364 0x02 0x01
> +#define MX91_PAD_GPIO_IO27__MEDIAMIX_DISP_DATA23                        =
         0x007c 0x022c 0x0000 0x03 0x00
> +#define MX91_PAD_GPIO_IO27__TPM6_CH3                                    =
         0x007c 0x022c 0x0000 0x04 0x00
> +#define MX91_PAD_GPIO_IO27__JTAG_MUX_TMS                                =
         0x007c 0x022c 0x03dc 0x05 0x01
> +#define MX91_PAD_GPIO_IO27__LPSPI5_PCS1                                 =
         0x007c 0x022c 0x0000 0x06 0x00
> +#define MX91_PAD_GPIO_IO27__FLEXIO1_FLEXIO27                            =
         0x007c 0x022c 0x03c8 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO28__GPIO2_IO28                                  =
         0x0080 0x0230 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO28__LPI2C3_SDA                                  =
         0x0080 0x0230 0x03f4 0x01 0x01
> +#define MX91_PAD_GPIO_IO28__CAN1_TX                                     =
         0x0080 0x0230 0x0000 0x02 0x00
> +#define MX91_PAD_GPIO_IO28__FLEXIO1_FLEXIO28                            =
         0x0080 0x0230 0x0000 0x07 0x00
> +
> +#define MX91_PAD_GPIO_IO29__GPIO2_IO29                                  =
         0x0084 0x0234 0x0000 0x00 0x00
> +#define MX91_PAD_GPIO_IO29__LPI2C3_SCL                                  =
         0x0084 0x0234 0x03f0 0x01 0x01
> +#define MX91_PAD_GPIO_IO29__CAN1_RX                                     =
         0x0084 0x0234 0x0360 0x02 0x00
> +#define MX91_PAD_GPIO_IO29__FLEXIO1_FLEXIO29                            =
         0x0084 0x0234 0x0000 0x07 0x00
> +
> +#define MX91_PAD_CCM_CLKO1__CCMSRCGPCMIX_CLKO1                          =
         0x0088 0x0238 0x0000 0x00 0x00
> +#define MX91_PAD_CCM_CLKO1__FLEXIO1_FLEXIO26                            =
         0x0088 0x0238 0x0000 0x04 0x00
> +#define MX91_PAD_CCM_CLKO1__GPIO3_IO26                                  =
         0x0088 0x0238 0x0000 0x05 0x00
> +
> +#define MX91_PAD_CCM_CLKO2__GPIO3_IO27                                  =
         0x008c 0x023c 0x0000 0x05 0x00
> +#define MX91_PAD_CCM_CLKO2__CCMSRCGPCMIX_CLKO2                          =
         0x008c 0x023c 0x0000 0x00 0x00
> +#define MX91_PAD_CCM_CLKO2__FLEXIO1_FLEXIO27                            =
         0x008c 0x023c 0x03c8 0x04 0x01
> +
> +#define MX91_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3                          =
         0x0090 0x0240 0x0000 0x00 0x00
> +#define MX91_PAD_CCM_CLKO3__FLEXIO2_FLEXIO28                            =
         0x0090 0x0240 0x0000 0x04 0x00
> +#define MX91_PAD_CCM_CLKO3__GPIO4_IO28                                  =
         0x0090 0x0240 0x0000 0x05 0x00
> +
> +#define MX91_PAD_CCM_CLKO4__CCMSRCGPCMIX_CLKO4                          =
         0x0094 0x0244 0x0000 0x00 0x00
> +#define MX91_PAD_CCM_CLKO4__FLEXIO2_FLEXIO29                            =
         0x0094 0x0244 0x0000 0x04 0x00
> +#define MX91_PAD_CCM_CLKO4__GPIO4_IO29                                  =
         0x0094 0x0244 0x0000 0x05 0x00
> +
> +#define MX91_PAD_ENET1_MDC__ENET1_MDC                                   =
         0x0098 0x0248 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_MDC__LPUART3_DCB_B                               =
         0x0098 0x0248 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_MDC__I3C2_SCL                                    =
         0x0098 0x0248 0x03cc 0x02 0x00
> +#define MX91_PAD_ENET1_MDC__HSIOMIX_OTG_ID1                             =
         0x0098 0x0248 0x0000 0x03 0x00
> +#define MX91_PAD_ENET1_MDC__FLEXIO2_FLEXIO0                             =
         0x0098 0x0248 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_MDC__GPIO4_IO0                                   =
         0x0098 0x0248 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_MDC__LPI2C1_SCL                                  =
         0x0098 0x0248 0x03e0 0x06 0x00
> +
> +#define MX91_PAD_ENET1_MDIO__ENET_QOS_MDIO                              =
         0x009c 0x024c 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_MDIO__LPUART3_RIN_B                              =
         0x009c 0x024c 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_MDIO__I3C2_SDA                                   =
         0x009c 0x024c 0x03d0 0x02 0x00
> +#define MX91_PAD_ENET1_MDIO__HSIOMIX_OTG_PWR1                           =
         0x009c 0x024c 0x0000 0x03 0x00
> +#define MX91_PAD_ENET1_MDIO__FLEXIO2_FLEXIO1                            =
         0x009c 0x024c 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_MDIO__GPIO4_IO1                                  =
         0x009c 0x024c 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_MDIO__LPI2C1_SDA                                 =
         0x009c 0x024c 0x03e4 0x06 0x00
> +
> +#define MX91_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3                          =
         0x00a0 0x0250 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_TD3__CAN2_TX                                     =
         0x00a0 0x0250 0x0000 0x02 0x00
> +#define MX91_PAD_ENET1_TD3__HSIOMIX_OTG_ID2                             =
         0x00a0 0x0250 0x0000 0x03 0x00
> +#define MX91_PAD_ENET1_TD3__FLEXIO2_FLEXIO2                             =
         0x00a0 0x0250 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_TD3__GPIO4_IO2                                   =
         0x00a0 0x0250 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_TD3__LPI2C2_SCL                                  =
         0x00a0 0x0250 0x03e8 0x06 0x00
> +
> +#define MX91_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2                          =
         0x00a4 0x0254 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_TD2__ENET_QOS_CLOCK_GENERATE_CLK                 =
         0x00a4 0x0254 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_TD2__CAN2_RX                                     =
         0x00a4 0x0254 0x0364 0x02 0x02
> +#define MX91_PAD_ENET1_TD2__HSIOMIX_OTG_OC2                             =
         0x00a4 0x0254 0x0000 0x03 0x00
> +#define MX91_PAD_ENET1_TD2__FLEXIO2_FLEXIO3                             =
         0x00a4 0x0254 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_TD2__GPIO4_IO3                                   =
         0x00a4 0x0254 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_TD2__LPI2C2_SDA                                  =
         0x00a4 0x0254 0x03ec 0x06 0x00
> +
> +#define MX91_PAD_ENET1_TD1__ENET1_RGMII_TD1                             =
         0x00a8 0x0258 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_TD1__LPUART3_RTS_B                               =
         0x00a8 0x0258 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_TD1__I3C2_PUR                                    =
         0x00a8 0x0258 0x0000 0x02 0x00
> +#define MX91_PAD_ENET1_TD1__HSIOMIX_OTG_OC1                             =
         0x00a8 0x0258 0x0000 0x03 0x00
> +#define MX91_PAD_ENET1_TD1__FLEXIO2_FLEXIO4                             =
         0x00a8 0x0258 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_TD1__GPIO4_IO4                                   =
         0x00a8 0x0258 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_TD1__I3C2_PUR_B                                  =
         0x00a8 0x0258 0x0000 0x06 0x00
> +
> +#define MX91_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0                          =
         0x00ac 0x025c 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_TD0__LPUART3_TX                                  =
         0x00ac 0x025c 0x0474 0x01 0x01
> +#define MX91_PAD_ENET1_TD0__FLEXIO2_FLEXIO5                             =
         0x00ac 0x025c 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_TD0__GPIO4_IO5                                   =
         0x00ac 0x025c 0x0000 0x05 0x00
> +
> +#define MX91_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL                    =
         0x00b0 0x0260 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_TX_CTL__LPUART3_DTR_B                            =
         0x00b0 0x0260 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_TX_CTL__FLEXIO2_FLEXIO6                          =
         0x00b0 0x0260 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_TX_CTL__GPIO4_IO6                                =
         0x00b0 0x0260 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_TX_CTL__LPSPI2_SCK                               =
         0x00b0 0x0260 0x043c 0x02 0x00
> +
> +#define MX91_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK          =
         0x00b4 0x0264 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_TXC__ENET_QOS_TX_ER                              =
         0x00b4 0x0264 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_TXC__FLEXIO2_FLEXIO7                             =
         0x00b4 0x0264 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_TXC__GPIO4_IO7                                   =
         0x00b4 0x0264 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_TXC__LPSPI2_SIN                                  =
         0x00b4 0x0264 0x0440 0x02 0x00
> +
> +#define MX91_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL                    =
         0x00b8 0x0268 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_RX_CTL__LPUART3_DSR_B                            =
         0x00b8 0x0268 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_RX_CTL__HSIOMIX_OTG_PWR2                         =
         0x00b8 0x0268 0x0000 0x03 0x00
> +#define MX91_PAD_ENET1_RX_CTL__FLEXIO2_FLEXIO8                          =
         0x00b8 0x0268 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_RX_CTL__GPIO4_IO8                                =
         0x00b8 0x0268 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_RX_CTL__LPSPI2_PCS0                              =
         0x00b8 0x0268 0x0434 0x02 0x00
> +
> +#define MX91_PAD_ENET1_RXC__ENET_QOS_RGMII_RXC                          =
         0x00bc 0x026c 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_RXC__ENET_QOS_RX_ER                              =
         0x00bc 0x026c 0x0000 0x01 0x00
> +#define MX91_PAD_ENET1_RXC__FLEXIO2_FLEXIO9                             =
         0x00bc 0x026c 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_RXC__GPIO4_IO9                                   =
         0x00bc 0x026c 0x0000 0x05 0x00
> +#define MX91_PAD_ENET1_RXC__LPSPI2_SOUT                                 =
         0x00bc 0x026c 0x0444 0x02 0x00
> +
> +#define MX91_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0                          =
         0x00c0 0x0270 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_RD0__LPUART3_RX                                  =
         0x00c0 0x0270 0x0470 0x01 0x01
> +#define MX91_PAD_ENET1_RD0__FLEXIO2_FLEXIO10                            =
         0x00c0 0x0270 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_RD0__GPIO4_IO10                                  =
         0x00c0 0x0270 0x0000 0x05 0x00
> +
> +#define MX91_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1                          =
         0x00c4 0x0274 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_RD1__LPUART3_CTS_B                               =
         0x00c4 0x0274 0x046c 0x01 0x01
> +#define MX91_PAD_ENET1_RD1__LPTMR2_ALT1                                 =
         0x00c4 0x0274 0x0448 0x03 0x00
> +#define MX91_PAD_ENET1_RD1__FLEXIO2_FLEXIO11                            =
         0x00c4 0x0274 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_RD1__GPIO4_IO11                                  =
         0x00c4 0x0274 0x0000 0x05 0x00
> +
> +#define MX91_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2                          =
         0x00c8 0x0278 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_RD2__LPTMR2_ALT2                                 =
         0x00c8 0x0278 0x044c 0x03 0x00
> +#define MX91_PAD_ENET1_RD2__FLEXIO2_FLEXIO12                            =
         0x00c8 0x0278 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_RD2__GPIO4_IO12                                  =
         0x00c8 0x0278 0x0000 0x05 0x00
> +
> +#define MX91_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3                          =
         0x00cc 0x027c 0x0000 0x00 0x00
> +#define MX91_PAD_ENET1_RD3__FLEXSPI1_TESTER_TRIGGER                     =
         0x00cc 0x027c 0x0000 0x02 0x00
> +#define MX91_PAD_ENET1_RD3__LPTMR2_ALT3                                 =
         0x00cc 0x027c 0x0450 0x03 0x00
> +#define MX91_PAD_ENET1_RD3__FLEXIO2_FLEXIO13                            =
         0x00cc 0x027c 0x0000 0x04 0x00
> +#define MX91_PAD_ENET1_RD3__GPIO4_IO13                                  =
         0x00cc 0x027c 0x0000 0x05 0x00
> +
> +#define MX91_PAD_ENET2_MDC__ENET2_MDC                                   =
         0x00d0 0x0280 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_MDC__LPUART4_DCB_B                               =
         0x00d0 0x0280 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_MDC__SAI2_RX_SYNC                                =
         0x00d0 0x0280 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_MDC__FLEXIO2_FLEXIO14                            =
         0x00d0 0x0280 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_MDC__GPIO4_IO14                                  =
         0x00d0 0x0280 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_MDC__MEDIAMIX_CAM_CLK                            =
         0x00d0 0x0280 0x04bc 0x06 0x01
> +
> +#define MX91_PAD_ENET2_MDIO__ENET2_MDIO                                 =
         0x00d4 0x0284 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_MDIO__LPUART4_RIN_B                              =
         0x00d4 0x0284 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_MDIO__SAI2_RX_BCLK                               =
         0x00d4 0x0284 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_MDIO__FLEXIO2_FLEXIO15                           =
         0x00d4 0x0284 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_MDIO__GPIO4_IO15                                 =
         0x00d4 0x0284 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_MDIO__MEDIAMIX_CAM_DATA0                         =
         0x00d4 0x0284 0x0490 0x06 0x01
> +
> +#define MX91_PAD_ENET2_TD3__SAI2_RX_DATA0                               =
         0x00d8 0x0288 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_TD3__FLEXIO2_FLEXIO16                            =
         0x00d8 0x0288 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_TD3__GPIO4_IO16                                  =
         0x00d8 0x0288 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_TD3__MEDIAMIX_CAM_VSYNC                          =
         0x00d8 0x0288 0x04c0 0x06 0x01
> +#define MX91_PAD_ENET2_TD3__ENET2_RGMII_TD3                             =
         0x00d8 0x0288 0x0000 0x00 0x00
> +
> +#define MX91_PAD_ENET2_TD2__ENET2_RGMII_TD2                             =
         0x00dc 0x028c 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_TD2__ENET2_TX_CLK2                               =
         0x00dc 0x028c 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_TD2__FLEXIO2_FLEXIO17                            =
         0x00dc 0x028c 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_TD2__GPIO4_IO17                                  =
         0x00dc 0x028c 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_TD2__MEDIAMIX_CAM_HSYNC                          =
         0x00dc 0x028c 0x04b8 0x06 0x01
> +
> +#define MX91_PAD_ENET2_TD1__ENET2_RGMII_TD1                             =
         0x00e0 0x0290 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_TD1__LPUART4_RTS_B                               =
         0x00e0 0x0290 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_TD1__FLEXIO2_FLEXIO18                            =
         0x00e0 0x0290 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_TD1__GPIO4_IO18                                  =
         0x00e0 0x0290 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_TD1__MEDIAMIX_CAM_DATA1                          =
         0x00e0 0x0290 0x0494 0x06 0x01
> +
> +#define MX91_PAD_ENET2_TD0__ENET2_RGMII_TD0                             =
         0x00e4 0x0294 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_TD0__LPUART4_TX                                  =
         0x00e4 0x0294 0x0480 0x01 0x01
> +#define MX91_PAD_ENET2_TD0__FLEXIO2_FLEXIO19                            =
         0x00e4 0x0294 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_TD0__GPIO4_IO19                                  =
         0x00e4 0x0294 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_TD0__MEDIAMIX_CAM_DATA2                          =
         0x00e4 0x0294 0x0498 0x06 0x01
> +
> +#define MX91_PAD_ENET2_TX_CTL__ENET2_RGMII_TX_CTL                       =
         0x00e8 0x0298 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_TX_CTL__LPUART4_DTR_B                            =
         0x00e8 0x0298 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_TX_CTL__SAI2_TX_SYNC                             =
         0x00e8 0x0298 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_TX_CTL__FLEXIO2_FLEXIO20                         =
         0x00e8 0x0298 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_TX_CTL__GPIO4_IO20                               =
         0x00e8 0x0298 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_TX_CTL__MEDIAMIX_CAM_DATA3                       =
         0x00e8 0x0298 0x049c 0x06 0x01
> +
> +#define MX91_PAD_ENET2_TXC__ENET2_RGMII_TXC                             =
         0x00ec 0x029c 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_TXC__ENET2_TX_ER                                 =
         0x00ec 0x029c 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_TXC__SAI2_TX_BCLK                                =
         0x00ec 0x029c 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_TXC__FLEXIO2_FLEXIO21                            =
         0x00ec 0x029c 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_TXC__GPIO4_IO21                                  =
         0x00ec 0x029c 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_TXC__MEDIAMIX_CAM_DATA4                          =
         0x00ec 0x029c 0x04a0 0x06 0x01
> +
> +#define MX91_PAD_ENET2_RX_CTL__ENET2_RGMII_RX_CTL                       =
         0x00f0 0x02a0 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_RX_CTL__LPUART4_DSR_B                            =
         0x00f0 0x02a0 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_RX_CTL__SAI2_TX_DATA0                            =
         0x00f0 0x02a0 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_RX_CTL__FLEXIO2_FLEXIO22                         =
         0x00f0 0x02a0 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_RX_CTL__GPIO4_IO22                               =
         0x00f0 0x02a0 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_RX_CTL__MEDIAMIX_CAM_DATA5                       =
         0x00f0 0x02a0 0x04a4 0x06 0x01
> +
> +#define MX91_PAD_ENET2_RXC__ENET2_RGMII_RXC                             =
         0x00f4 0x02a4 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_RXC__ENET2_RX_ER                                 =
         0x00f4 0x02a4 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_RXC__FLEXIO2_FLEXIO23                            =
         0x00f4 0x02a4 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_RXC__GPIO4_IO23                                  =
         0x00f4 0x02a4 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_RXC__MEDIAMIX_CAM_DATA6                          =
         0x00f4 0x02a4 0x04a8 0x06 0x01
> +
> +#define MX91_PAD_ENET2_RD0__ENET2_RGMII_RD0                             =
         0x00f8 0x02a8 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_RD0__LPUART4_RX                                  =
         0x00f8 0x02a8 0x047c 0x01 0x01
> +#define MX91_PAD_ENET2_RD0__FLEXIO2_FLEXIO24                            =
         0x00f8 0x02a8 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_RD0__GPIO4_IO24                                  =
         0x00f8 0x02a8 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_RD0__MEDIAMIX_CAM_DATA7                          =
         0x00f8 0x02a8 0x04ac 0x06 0x01
> +
> +#define MX91_PAD_ENET2_RD1__ENET2_RGMII_RD1                             =
         0x00fc 0x02ac 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_RD1__SPDIF_IN                                    =
         0x00fc 0x02ac 0x04e4 0x01 0x01
> +#define MX91_PAD_ENET2_RD1__FLEXIO2_FLEXIO25                            =
         0x00fc 0x02ac 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_RD1__GPIO4_IO25                                  =
         0x00fc 0x02ac 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_RD1__MEDIAMIX_CAM_DATA8                          =
         0x00fc 0x02ac 0x04b0 0x06 0x01
> +
> +#define MX91_PAD_ENET2_RD2__ENET2_RGMII_RD2                             =
         0x0100 0x02b0 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_RD2__LPUART4_CTS_B                               =
         0x0100 0x02b0 0x0478 0x01 0x01
> +#define MX91_PAD_ENET2_RD2__SAI2_MCLK                                   =
         0x0100 0x02b0 0x0000 0x02 0x00
> +#define MX91_PAD_ENET2_RD2__MQS2_RIGHT                                  =
         0x0100 0x02b0 0x0000 0x03 0x00
> +#define MX91_PAD_ENET2_RD2__FLEXIO2_FLEXIO26                            =
         0x0100 0x02b0 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_RD2__GPIO4_IO26                                  =
         0x0100 0x02b0 0x0000 0x05 0x00
> +#define MX91_PAD_ENET2_RD2__MEDIAMIX_CAM_DATA9                          =
         0x0100 0x02b0 0x04b4 0x06 0x01
> +
> +#define MX91_PAD_ENET2_RD3__ENET2_RGMII_RD3                             =
         0x0104 0x02b4 0x0000 0x00 0x00
> +#define MX91_PAD_ENET2_RD3__SPDIF_OUT                                   =
         0x0104 0x02b4 0x0000 0x01 0x00
> +#define MX91_PAD_ENET2_RD3__SPDIF_IN                                    =
         0x0104 0x02b4 0x04e4 0x02 0x02
> +#define MX91_PAD_ENET2_RD3__MQS2_LEFT                                   =
         0x0104 0x02b4 0x0000 0x03 0x00
> +#define MX91_PAD_ENET2_RD3__FLEXIO2_FLEXIO27                            =
         0x0104 0x02b4 0x0000 0x04 0x00
> +#define MX91_PAD_ENET2_RD3__GPIO4_IO27                                  =
         0x0104 0x02b4 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD1_CLK__FLEXIO1_FLEXIO8                               =
         0x0108 0x02b8 0x038c 0x04 0x01
> +#define MX91_PAD_SD1_CLK__GPIO3_IO8                                     =
         0x0108 0x02b8 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_CLK__USDHC1_CLK                                    =
         0x0108 0x02b8 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_CLK__LPSPI2_SCK                                    =
         0x0108 0x02b8 0x043c 0x03 0x01
> +
> +#define MX91_PAD_SD1_CMD__USDHC1_CMD                                    =
         0x010c 0x02bc 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_CMD__FLEXIO1_FLEXIO9                               =
         0x010c 0x02bc 0x0390 0x04 0x01
> +#define MX91_PAD_SD1_CMD__GPIO3_IO9                                     =
         0x010c 0x02bc 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_CMD__LPSPI2_SIN                                    =
         0x010c 0x02bc 0x0440 0x03 0x01
> +
> +#define MX91_PAD_SD1_DATA0__USDHC1_DATA0                                =
         0x0110 0x02c0 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA0__FLEXIO1_FLEXIO10                            =
         0x0110 0x02c0 0x0394 0x04 0x01
> +#define MX91_PAD_SD1_DATA0__GPIO3_IO10                                  =
         0x0110 0x02c0 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA0__LPSPI2_PCS0                                 =
         0x0110 0x02c0 0x0434 0x03 0x01
> +
> +#define MX91_PAD_SD1_DATA1__USDHC1_DATA1                                =
         0x0114 0x02c4 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA1__FLEXIO1_FLEXIO11                            =
         0x0114 0x02c4 0x0398 0x04 0x01
> +#define MX91_PAD_SD1_DATA1__GPIO3_IO11                                  =
         0x0114 0x02c4 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA1__CCMSRCGPCMIX_INT_BOOT                       =
         0x0114 0x02c4 0x0000 0x06 0x00
> +#define MX91_PAD_SD1_DATA1__LPSPI2_SOUT                                 =
         0x0114 0x02c4 0x0444 0x03 0x01
> +
> +#define MX91_PAD_SD1_DATA2__USDHC1_DATA2                                =
         0x0118 0x02c8 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA2__FLEXIO1_FLEXIO12                            =
         0x0118 0x02c8 0x0000 0x04 0x00
> +#define MX91_PAD_SD1_DATA2__GPIO3_IO12                                  =
         0x0118 0x02c8 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA2__CCMSRCGPCMIX_PMIC_READY                     =
         0x0118 0x02c8 0x0000 0x06 0x00
> +#define MX91_PAD_SD1_DATA2__LPSPI2_PCS1                                 =
         0x0118 0x02c8 0x0438 0x03 0x00
> +
> +#define MX91_PAD_SD1_DATA3__USDHC1_DATA3                                =
         0x011c 0x02cc 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA3__FLEXSPI1_A_SS1_B                            =
         0x011c 0x02cc 0x0000 0x01 0x00
> +#define MX91_PAD_SD1_DATA3__FLEXIO1_FLEXIO13                            =
         0x011c 0x02cc 0x039c 0x04 0x01
> +#define MX91_PAD_SD1_DATA3__GPIO3_IO13                                  =
         0x011c 0x02cc 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA3__LPSPI1_PCS1                                 =
         0x011c 0x02cc 0x0424 0x03 0x00
> +
> +#define MX91_PAD_SD1_DATA4__USDHC1_DATA4                                =
         0x0120 0x02d0 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA4__FLEXSPI1_A_DATA4                            =
         0x0120 0x02d0 0x0000 0x01 0x00
> +#define MX91_PAD_SD1_DATA4__FLEXIO1_FLEXIO14                            =
         0x0120 0x02d0 0x03a0 0x04 0x01
> +#define MX91_PAD_SD1_DATA4__GPIO3_IO14                                  =
         0x0120 0x02d0 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA4__LPSPI1_PCS0                                 =
         0x0120 0x02d0 0x0420 0x03 0x00
> +
> +#define MX91_PAD_SD1_DATA5__USDHC1_DATA5                                =
         0x0124 0x02d4 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA5__FLEXSPI1_A_DATA5                            =
         0x0124 0x02d4 0x0000 0x01 0x00
> +#define MX91_PAD_SD1_DATA5__USDHC1_RESET_B                              =
         0x0124 0x02d4 0x0000 0x02 0x00
> +#define MX91_PAD_SD1_DATA5__FLEXIO1_FLEXIO15                            =
         0x0124 0x02d4 0x03a4 0x04 0x01
> +#define MX91_PAD_SD1_DATA5__GPIO3_IO15                                  =
         0x0124 0x02d4 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA5__LPSPI1_SIN                                  =
         0x0124 0x02d4 0x042c 0x03 0x00
> +
> +#define MX91_PAD_SD1_DATA6__USDHC1_DATA6                                =
         0x0128 0x02d8 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA6__FLEXSPI1_A_DATA6                            =
         0x0128 0x02d8 0x0000 0x01 0x00
> +#define MX91_PAD_SD1_DATA6__USDHC1_CD_B                                 =
         0x0128 0x02d8 0x0000 0x02 0x00
> +#define MX91_PAD_SD1_DATA6__FLEXIO1_FLEXIO16                            =
         0x0128 0x02d8 0x03a8 0x04 0x01
> +#define MX91_PAD_SD1_DATA6__GPIO3_IO16                                  =
         0x0128 0x02d8 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA6__LPSPI1_SCK                                  =
         0x0128 0x02d8 0x0428 0x03 0x00
> +
> +#define MX91_PAD_SD1_DATA7__USDHC1_DATA7                                =
         0x012c 0x02dc 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_DATA7__FLEXSPI1_A_DATA7                            =
         0x012c 0x02dc 0x0000 0x01 0x00
> +#define MX91_PAD_SD1_DATA7__USDHC1_WP                                   =
         0x012c 0x02dc 0x0000 0x02 0x00
> +#define MX91_PAD_SD1_DATA7__FLEXIO1_FLEXIO17                            =
         0x012c 0x02dc 0x03ac 0x04 0x01
> +#define MX91_PAD_SD1_DATA7__GPIO3_IO17                                  =
         0x012c 0x02dc 0x0000 0x05 0x00
> +#define MX91_PAD_SD1_DATA7__LPSPI1_SOUT                                 =
         0x012c 0x02dc 0x0430 0x03 0x00
> +
> +#define MX91_PAD_SD1_STROBE__USDHC1_STROBE                              =
         0x0130 0x02e0 0x0000 0x00 0x00
> +#define MX91_PAD_SD1_STROBE__FLEXSPI1_A_DQS                             =
         0x0130 0x02e0 0x0000 0x01 0x00
> +#define MX91_PAD_SD1_STROBE__FLEXIO1_FLEXIO18                           =
         0x0130 0x02e0 0x03b0 0x04 0x01
> +#define MX91_PAD_SD1_STROBE__GPIO3_IO18                                 =
         0x0130 0x02e0 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD2_VSELECT__USDHC2_VSELECT                            =
         0x0134 0x02e4 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_VSELECT__USDHC2_WP                                 =
         0x0134 0x02e4 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_VSELECT__LPTMR2_ALT3                               =
         0x0134 0x02e4 0x0450 0x02 0x01
> +#define MX91_PAD_SD2_VSELECT__FLEXIO1_FLEXIO19                          =
         0x0134 0x02e4 0x0000 0x04 0x00
> +#define MX91_PAD_SD2_VSELECT__GPIO3_IO19                                =
         0x0134 0x02e4 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_VSELECT__CCMSRCGPCMIX_EXT_CLK1                     =
         0x0134 0x02e4 0x0368 0x06 0x00
> +
> +#define MX91_PAD_SD3_CLK__USDHC3_CLK                                    =
         0x0138 0x02e8 0x04e8 0x00 0x01
> +#define MX91_PAD_SD3_CLK__FLEXSPI1_A_SCLK                               =
         0x0138 0x02e8 0x0000 0x01 0x00
> +#define MX91_PAD_SD3_CLK__LPUART1_CTS_B                                 =
         0x0138 0x02e8 0x0454 0x02 0x00
> +#define MX91_PAD_SD3_CLK__FLEXIO1_FLEXIO20                              =
         0x0138 0x02e8 0x03b4 0x04 0x01
> +#define MX91_PAD_SD3_CLK__GPIO3_IO20                                    =
         0x0138 0x02e8 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD3_CMD__USDHC3_CMD                                    =
         0x013c 0x02ec 0x04ec 0x00 0x01
> +#define MX91_PAD_SD3_CMD__FLEXSPI1_A_SS0_B                              =
         0x013c 0x02ec 0x0000 0x01 0x00
> +#define MX91_PAD_SD3_CMD__LPUART1_RTS_B                                 =
         0x013c 0x02ec 0x0000 0x02 0x00
> +#define MX91_PAD_SD3_CMD__FLEXIO1_FLEXIO21                              =
         0x013c 0x02ec 0x0000 0x04 0x00
> +#define MX91_PAD_SD3_CMD__GPIO3_IO21                                    =
         0x013c 0x02ec 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD3_DATA0__USDHC3_DATA0                                =
         0x0140 0x02f0 0x04f0 0x00 0x01
> +#define MX91_PAD_SD3_DATA0__FLEXSPI1_A_DATA0                            =
         0x0140 0x02f0 0x0000 0x01 0x00
> +#define MX91_PAD_SD3_DATA0__LPUART2_CTS_B                               =
         0x0140 0x02f0 0x0460 0x02 0x00
> +#define MX91_PAD_SD3_DATA0__FLEXIO1_FLEXIO22                            =
         0x0140 0x02f0 0x03b8 0x04 0x01
> +#define MX91_PAD_SD3_DATA0__GPIO3_IO22                                  =
         0x0140 0x02f0 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD3_DATA1__USDHC3_DATA1                                =
         0x0144 0x02f4 0x04f4 0x00 0x01
> +#define MX91_PAD_SD3_DATA1__FLEXSPI1_A_DATA1                            =
         0x0144 0x02f4 0x0000 0x01 0x00
> +#define MX91_PAD_SD3_DATA1__LPUART2_RTS_B                               =
         0x0144 0x02f4 0x0000 0x02 0x00
> +#define MX91_PAD_SD3_DATA1__FLEXIO1_FLEXIO23                            =
         0x0144 0x02f4 0x03bc 0x04 0x01
> +#define MX91_PAD_SD3_DATA1__GPIO3_IO23                                  =
         0x0144 0x02f4 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD3_DATA2__USDHC3_DATA2                                =
         0x0148 0x02f8 0x04f8 0x00 0x01
> +#define MX91_PAD_SD3_DATA2__LPI2C4_SDA                                  =
         0x0148 0x02f8 0x03fc 0x02 0x01
> +#define MX91_PAD_SD3_DATA2__FLEXSPI1_A_DATA2                            =
         0x0148 0x02f8 0x0000 0x01 0x00
> +#define MX91_PAD_SD3_DATA2__FLEXIO1_FLEXIO24                            =
         0x0148 0x02f8 0x03c0 0x04 0x01
> +#define MX91_PAD_SD3_DATA2__GPIO3_IO24                                  =
         0x0148 0x02f8 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD3_DATA3__USDHC3_DATA3                                =
         0x014c 0x02fc 0x04fc 0x00 0x01
> +#define MX91_PAD_SD3_DATA3__FLEXSPI1_A_DATA3                            =
         0x014c 0x02fc 0x0000 0x01 0x00
> +#define MX91_PAD_SD3_DATA3__LPI2C4_SCL                                  =
         0x014c 0x02fc 0x03f8 0x02 0x01
> +#define MX91_PAD_SD3_DATA3__FLEXIO1_FLEXIO25                            =
         0x014c 0x02fc 0x03c4 0x04 0x01
> +#define MX91_PAD_SD3_DATA3__GPIO3_IO25                                  =
         0x014c 0x02fc 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SD2_CD_B__USDHC2_CD_B                                  =
         0x0150 0x0300 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_CD_B__ENET_QOS_1588_EVENT0_IN                      =
         0x0150 0x0300 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_CD_B__I3C2_SCL                                     =
         0x0150 0x0300 0x03cc 0x02 0x01
> +#define MX91_PAD_SD2_CD_B__FLEXIO1_FLEXIO0                              =
         0x0150 0x0300 0x036c 0x04 0x01
> +#define MX91_PAD_SD2_CD_B__GPIO3_IO0                                    =
         0x0150 0x0300 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_CD_B__LPI2C1_SCL                                   =
         0x0150 0x0300 0x03e0 0x03 0x01
> +
> +#define MX91_PAD_SD2_CLK__USDHC2_CLK                                    =
         0x0154 0x0304 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_CLK__ENET_QOS_1588_EVENT0_OUT                      =
         0x0154 0x0304 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_CLK__I2C1_SDA                                      =
         0x0154 0x0304 0x0000 0x03 0x00
> +#define MX91_PAD_SD2_CLK__I3C2_SDA                                      =
         0x0154 0x0304 0x03d0 0x02 0x01
> +#define MX91_PAD_SD2_CLK__FLEXIO1_FLEXIO1                               =
         0x0154 0x0304 0x0370 0x04 0x01
> +#define MX91_PAD_SD2_CLK__GPIO3_IO1                                     =
         0x0154 0x0304 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_CLK__CCMSRCGPCMIX_OBSERVE0                         =
         0x0154 0x0304 0x0000 0x06 0x00
> +#define MX91_PAD_SD2_CLK__LPI2C1_SDA                                    =
         0x0154 0x0304 0x03e4 0x03 0x01
> +
> +#define MX91_PAD_SD2_CMD__USDHC2_CMD                                    =
         0x0158 0x0308 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_CMD__ENET2_1588_EVENT0_IN                          =
         0x0158 0x0308 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_CMD__I3C2_PUR                                      =
         0x0158 0x0308 0x0000 0x02 0x00
> +#define MX91_PAD_SD2_CMD__I3C2_PUR_B                                    =
         0x0158 0x0308 0x0000 0x03 0x00
> +#define MX91_PAD_SD2_CMD__FLEXIO1_FLEXIO2                               =
         0x0158 0x0308 0x0374 0x04 0x01
> +#define MX91_PAD_SD2_CMD__GPIO3_IO2                                     =
         0x0158 0x0308 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_CMD__CCMSRCGPCMIX_OBSERVE1                         =
         0x0158 0x0308 0x0000 0x06 0x00
> +
> +#define MX91_PAD_SD2_DATA0__USDHC2_DATA0                                =
         0x015c 0x030c 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_DATA0__ENET2_1588_EVENT0_OUT                       =
         0x015c 0x030c 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_DATA0__CAN2_TX                                     =
         0x015c 0x030c 0x0000 0x02 0x00
> +#define MX91_PAD_SD2_DATA0__FLEXIO1_FLEXIO3                             =
         0x015c 0x030c 0x0378 0x04 0x01
> +#define MX91_PAD_SD2_DATA0__GPIO3_IO3                                   =
         0x015c 0x030c 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_DATA0__LPUART1_TX                                  =
         0x015c 0x030c 0x045c 0x03 0x00
> +#define MX91_PAD_SD2_DATA0__CCMSRCGPCMIX_OBSERVE2                       =
         0x015c 0x030c 0x0000 0x06 0x00
> +
> +#define MX91_PAD_SD2_DATA1__USDHC2_DATA1                                =
         0x0160 0x0310 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_DATA1__ENET2_1588_EVENT1_IN                        =
         0x0160 0x0310 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_DATA1__CAN2_RX                                     =
         0x0160 0x0310 0x0364 0x02 0x03
> +#define MX91_PAD_SD2_DATA1__FLEXIO1_FLEXIO4                             =
         0x0160 0x0310 0x037c 0x04 0x01
> +#define MX91_PAD_SD2_DATA1__GPIO3_IO4                                   =
         0x0160 0x0310 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_DATA1__LPUART1_RX                                  =
         0x0160 0x0310 0x0458 0x03 0x00
> +#define MX91_PAD_SD2_DATA1__CCMSRCGPCMIX_WAIT                           =
         0x0160 0x0310 0x0000 0x06 0x00
> +
> +#define MX91_PAD_SD2_DATA2__USDHC2_DATA2                                =
         0x0164 0x0314 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_DATA2__ENET2_1588_EVENT1_OUT                       =
         0x0164 0x0314 0x0000 0x01 0x00
> +#define MX91_PAD_SD2_DATA2__MQS2_RIGHT                                  =
         0x0164 0x0314 0x0000 0x02 0x00
> +#define MX91_PAD_SD2_DATA2__FLEXIO1_FLEXIO5                             =
         0x0164 0x0314 0x0380 0x04 0x01
> +#define MX91_PAD_SD2_DATA2__GPIO3_IO5                                   =
         0x0164 0x0314 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_DATA2__LPUART2_TX                                  =
         0x0164 0x0314 0x0468 0x03 0x00
> +#define MX91_PAD_SD2_DATA2__CCMSRCGPCMIX_STOP                           =
         0x0164 0x0314 0x0000 0x06 0x00
> +
> +#define MX91_PAD_SD2_DATA3__USDHC2_DATA3                                =
         0x0168 0x0318 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_DATA3__LPTMR2_ALT1                                 =
         0x0168 0x0318 0x0448 0x01 0x01
> +#define MX91_PAD_SD2_DATA3__MQS2_LEFT                                   =
         0x0168 0x0318 0x0000 0x02 0x00
> +#define MX91_PAD_SD2_DATA3__FLEXIO1_FLEXIO6                             =
         0x0168 0x0318 0x0384 0x04 0x01
> +#define MX91_PAD_SD2_DATA3__GPIO3_IO6                                   =
         0x0168 0x0318 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_DATA3__LPUART2_RX                                  =
         0x0168 0x0318 0x0464 0x03 0x00
> +#define MX91_PAD_SD2_DATA3__CCMSRCGPCMIX_EARLY_RESET                    =
         0x0168 0x0318 0x0000 0x06 0x00
> +
> +#define MX91_PAD_SD2_RESET_B__USDHC2_RESET_B                            =
         0x016c 0x031c 0x0000 0x00 0x00
> +#define MX91_PAD_SD2_RESET_B__LPTMR2_ALT2                               =
         0x016c 0x031c 0x044c 0x01 0x01
> +#define MX91_PAD_SD2_RESET_B__FLEXIO1_FLEXIO7                           =
         0x016c 0x031c 0x0388 0x04 0x01
> +#define MX91_PAD_SD2_RESET_B__GPIO3_IO7                                 =
         0x016c 0x031c 0x0000 0x05 0x00
> +#define MX91_PAD_SD2_RESET_B__CCMSRCGPCMIX_SYSTEM_RESET                 =
         0x016c 0x031c 0x0000 0x06 0x00
> +
> +#define MX91_PAD_I2C1_SCL__LPI2C1_SCL                                   =
         0x0170 0x0320 0x03e0 0x00 0x02
> +#define MX91_PAD_I2C1_SCL__I3C1_SCL                                     =
         0x0170 0x0320 0x0000 0x01 0x00
> +#define MX91_PAD_I2C1_SCL__LPUART1_DCB_B                                =
         0x0170 0x0320 0x0000 0x02 0x00
> +#define MX91_PAD_I2C1_SCL__TPM2_CH0                                     =
         0x0170 0x0320 0x0000 0x03 0x00
> +#define MX91_PAD_I2C1_SCL__GPIO1_IO0                                    =
         0x0170 0x0320 0x0000 0x05 0x00
> +
> +#define MX91_PAD_I2C1_SDA__LPI2C1_SDA                                   =
         0x0174 0x0324 0x03e4 0x00 0x02
> +#define MX91_PAD_I2C1_SDA__I3C1_SDA                                     =
         0x0174 0x0324 0x0000 0x01 0x00
> +#define MX91_PAD_I2C1_SDA__LPUART1_RIN_B                                =
         0x0174 0x0324 0x0000 0x02 0x00
> +#define MX91_PAD_I2C1_SDA__TPM2_CH1                                     =
         0x0174 0x0324 0x0000 0x03 0x00
> +#define MX91_PAD_I2C1_SDA__GPIO1_IO1                                    =
         0x0174 0x0324 0x0000 0x05 0x00
> +
> +#define MX91_PAD_I2C2_SCL__LPI2C2_SCL                                   =
         0x0178 0x0328 0x03e8 0x00 0x01
> +#define MX91_PAD_I2C2_SCL__I3C1_PUR                                     =
         0x0178 0x0328 0x0000 0x01 0x00
> +#define MX91_PAD_I2C2_SCL__LPUART2_DCB_B                                =
         0x0178 0x0328 0x0000 0x02 0x00
> +#define MX91_PAD_I2C2_SCL__TPM2_CH2                                     =
         0x0178 0x0328 0x0000 0x03 0x00
> +#define MX91_PAD_I2C2_SCL__SAI1_RX_SYNC                                 =
         0x0178 0x0328 0x0000 0x04 0x00
> +#define MX91_PAD_I2C2_SCL__GPIO1_IO2                                    =
         0x0178 0x0328 0x0000 0x05 0x00
> +#define MX91_PAD_I2C2_SCL__I3C1_PUR_B                                   =
         0x0178 0x0328 0x0000 0x06 0x00
> +
> +#define MX91_PAD_I2C2_SDA__LPI2C2_SDA                                   =
         0x017c 0x032c 0x03ec 0x00 0x01
> +#define MX91_PAD_I2C2_SDA__LPUART2_RIN_B                                =
         0x017c 0x032c 0x0000 0x02 0x00
> +#define MX91_PAD_I2C2_SDA__TPM2_CH3                                     =
         0x017c 0x032c 0x0000 0x03 0x00
> +#define MX91_PAD_I2C2_SDA__SAI1_RX_BCLK                                 =
         0x017c 0x032c 0x0000 0x04 0x00
> +#define MX91_PAD_I2C2_SDA__GPIO1_IO3                                    =
         0x017c 0x032c 0x0000 0x05 0x00
> +
> +#define MX91_PAD_UART1_RXD__LPUART1_RX                                  =
         0x0180 0x0330 0x0458 0x00 0x01
> +#define MX91_PAD_UART1_RXD__ELE_UART_RX                                 =
         0x0180 0x0330 0x0000 0x01 0x00
> +#define MX91_PAD_UART1_RXD__LPSPI2_SIN                                  =
         0x0180 0x0330 0x0440 0x02 0x02
> +#define MX91_PAD_UART1_RXD__TPM1_CH0                                    =
         0x0180 0x0330 0x0000 0x03 0x00
> +#define MX91_PAD_UART1_RXD__GPIO1_IO4                                   =
         0x0180 0x0330 0x0000 0x05 0x00
> +
> +#define MX91_PAD_UART1_TXD__LPUART1_TX                                  =
         0x0184 0x0334 0x045c 0x00 0x01
> +#define MX91_PAD_UART1_TXD__ELE_UART_TX                                 =
         0x0184 0x0334 0x0000 0x01 0x00
> +#define MX91_PAD_UART1_TXD__LPSPI2_PCS0                                 =
         0x0184 0x0334 0x0434 0x02 0x02
> +#define MX91_PAD_UART1_TXD__TPM1_CH1                                    =
         0x0184 0x0334 0x0000 0x03 0x00
> +#define MX91_PAD_UART1_TXD__GPIO1_IO5                                   =
         0x0184 0x0334 0x0000 0x05 0x00
> +
> +#define MX91_PAD_UART2_RXD__LPUART2_RX                                  =
         0x0188 0x0338 0x0464 0x00 0x01
> +#define MX91_PAD_UART2_RXD__LPUART1_CTS_B                               =
         0x0188 0x0338 0x0454 0x01 0x01
> +#define MX91_PAD_UART2_RXD__LPSPI2_SOUT                                 =
         0x0188 0x0338 0x0444 0x02 0x02
> +#define MX91_PAD_UART2_RXD__TPM1_CH2                                    =
         0x0188 0x0338 0x0000 0x03 0x00
> +#define MX91_PAD_UART2_RXD__SAI1_MCLK                                   =
         0x0188 0x0338 0x04d4 0x04 0x00
> +#define MX91_PAD_UART2_RXD__GPIO1_IO6                                   =
         0x0188 0x0338 0x0000 0x05 0x00
> +
> +#define MX91_PAD_UART2_TXD__LPUART2_TX                                  =
         0x018c 0x033c 0x0468 0x00 0x01
> +#define MX91_PAD_UART2_TXD__LPUART1_RTS_B                               =
         0x018c 0x033c 0x0000 0x01 0x00
> +#define MX91_PAD_UART2_TXD__LPSPI2_SCK                                  =
         0x018c 0x033c 0x043c 0x02 0x02
> +#define MX91_PAD_UART2_TXD__TPM1_CH3                                    =
         0x018c 0x033c 0x0000 0x03 0x00
> +#define MX91_PAD_UART2_TXD__GPIO1_IO7                                   =
         0x018c 0x033c 0x0000 0x05 0x00
> +#define MX91_PAD_UART2_TXD__SAI3_TX_SYNC                                =
         0x018c 0x033c 0x04e0 0x07 0x02
> +
> +#define MX91_PAD_PDM_CLK__PDM_CLK                                       =
         0x0190 0x0340 0x0000 0x00 0x00
> +#define MX91_PAD_PDM_CLK__MQS1_LEFT                                     =
         0x0190 0x0340 0x0000 0x01 0x00
> +#define MX91_PAD_PDM_CLK__LPTMR1_ALT1                                   =
         0x0190 0x0340 0x0000 0x04 0x00
> +#define MX91_PAD_PDM_CLK__GPIO1_IO8                                     =
         0x0190 0x0340 0x0000 0x05 0x00
> +#define MX91_PAD_PDM_CLK__CAN1_TX                                       =
         0x0190 0x0340 0x0000 0x06 0x00
> +
> +#define MX91_PAD_PDM_BIT_STREAM0__PDM_BIT_STREAM0                       =
         0x0194 0x0344 0x04c4 0x00 0x02
> +#define MX91_PAD_PDM_BIT_STREAM0__MQS1_RIGHT                            =
         0x0194 0x0344 0x0000 0x01 0x00
> +#define MX91_PAD_PDM_BIT_STREAM0__LPSPI1_PCS1                           =
         0x0194 0x0344 0x0424 0x02 0x01
> +#define MX91_PAD_PDM_BIT_STREAM0__TPM1_EXTCLK                           =
         0x0194 0x0344 0x0000 0x03 0x00
> +#define MX91_PAD_PDM_BIT_STREAM0__LPTMR1_ALT2                           =
         0x0194 0x0344 0x0000 0x04 0x00
> +#define MX91_PAD_PDM_BIT_STREAM0__GPIO1_IO9                             =
         0x0194 0x0344 0x0000 0x05 0x00
> +#define MX91_PAD_PDM_BIT_STREAM0__CAN1_RX                               =
         0x0194 0x0344 0x0360 0x06 0x01
> +
> +#define MX91_PAD_PDM_BIT_STREAM1__PDM_BIT_STREAM1                       =
         0x0198 0x0348 0x04c8 0x00 0x02
> +#define MX91_PAD_PDM_BIT_STREAM1__LPSPI2_PCS1                           =
         0x0198 0x0348 0x0438 0x02 0x01
> +#define MX91_PAD_PDM_BIT_STREAM1__TPM2_EXTCLK                           =
         0x0198 0x0348 0x0000 0x03 0x00
> +#define MX91_PAD_PDM_BIT_STREAM1__LPTMR1_ALT3                           =
         0x0198 0x0348 0x0000 0x04 0x00
> +#define MX91_PAD_PDM_BIT_STREAM1__GPIO1_IO10                            =
         0x0198 0x0348 0x0000 0x05 0x00
> +#define MX91_PAD_PDM_BIT_STREAM1__CCMSRCGPCMIX_EXT_CLK1                 =
         0x0198 0x0348 0x0368 0x06 0x01
> +
> +#define MX91_PAD_SAI1_TXFS__SAI1_TX_SYNC                                =
         0x019c 0x034c 0x0000 0x00 0x00
> +#define MX91_PAD_SAI1_TXFS__SAI1_TX_DATA1                               =
         0x019c 0x034c 0x0000 0x01 0x00
> +#define MX91_PAD_SAI1_TXFS__LPSPI1_PCS0                                 =
         0x019c 0x034c 0x0420 0x02 0x01
> +#define MX91_PAD_SAI1_TXFS__LPUART2_DTR_B                               =
         0x019c 0x034c 0x0000 0x03 0x00
> +#define MX91_PAD_SAI1_TXFS__MQS1_LEFT                                   =
         0x019c 0x034c 0x0000 0x04 0x00
> +#define MX91_PAD_SAI1_TXFS__GPIO1_IO11                                  =
         0x019c 0x034c 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SAI1_TXC__SAI1_TX_BCLK                                 =
         0x01a0 0x0350 0x0000 0x00 0x00
> +#define MX91_PAD_SAI1_TXC__LPUART2_CTS_B                                =
         0x01a0 0x0350 0x0460 0x01 0x01
> +#define MX91_PAD_SAI1_TXC__LPSPI1_SIN                                   =
         0x01a0 0x0350 0x042c 0x02 0x01
> +#define MX91_PAD_SAI1_TXC__LPUART1_DSR_B                                =
         0x01a0 0x0350 0x0000 0x03 0x00
> +#define MX91_PAD_SAI1_TXC__CAN1_RX                                      =
         0x01a0 0x0350 0x0360 0x04 0x02
> +#define MX91_PAD_SAI1_TXC__GPIO1_IO12                                   =
         0x01a0 0x0350 0x0000 0x05 0x00
> +
> +#define MX91_PAD_SAI1_TXD0__SAI1_TX_DATA0                               =
         0x01a4 0x0354 0x0000 0x00 0x00
> +#define MX91_PAD_SAI1_TXD0__LPUART2_RTS_B                               =
         0x01a4 0x0354 0x0000 0x01 0x00
> +#define MX91_PAD_SAI1_TXD0__LPSPI1_SCK                                  =
         0x01a4 0x0354 0x0428 0x02 0x01
> +#define MX91_PAD_SAI1_TXD0__LPUART1_DTR_B                               =
         0x01a4 0x0354 0x0000 0x03 0x00
> +#define MX91_PAD_SAI1_TXD0__CAN1_TX                                     =
         0x01a4 0x0354 0x0000 0x04 0x00
> +#define MX91_PAD_SAI1_TXD0__GPIO1_IO13                                  =
         0x01a4 0x0354 0x0000 0x05 0x00
> +#define MX91_PAD_SAI1_TXD0__SAI1_MCLK                                   =
         0x01a4 0x0354 0x04d4 0x06 0x01
> +
> +#define MX91_PAD_SAI1_RXD0__SAI1_RX_DATA0                               =
         0x01a8 0x0358 0x0000 0x00 0x00
> +#define MX91_PAD_SAI1_RXD0__SAI1_MCLK                                   =
         0x01a8 0x0358 0x04d4 0x01 0x02
> +#define MX91_PAD_SAI1_RXD0__LPSPI1_SOUT                                 =
         0x01a8 0x0358 0x0430 0x02 0x01
> +#define MX91_PAD_SAI1_RXD0__LPUART2_DSR_B                               =
         0x01a8 0x0358 0x0000 0x03 0x00
> +#define MX91_PAD_SAI1_RXD0__MQS1_RIGHT                                  =
         0x01a8 0x0358 0x0000 0x04 0x00
> +#define MX91_PAD_SAI1_RXD0__GPIO1_IO14                                  =
         0x01a8 0x0358 0x0000 0x05 0x00
> +
> +#define MX91_PAD_WDOG_ANY__WDOG1_WDOG_ANY                               =
         0x01ac 0x035c 0x0000 0x00 0x00
> +#define MX91_PAD_WDOG_ANY__GPIO1_IO15                                   =
         0x01ac 0x035c 0x0000 0x05 0x00
> +#endif /* __DTS_IMX91_PINFUNC_H */
> diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot/d=
ts/freescale/imx91.dtsi
> new file mode 100644
> index 000000000000..4d8300b2a7bc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include "imx91-pinfunc.h"
> +#include "imx91_93_common.dtsi"
> +
> +&clk {
> +	compatible =3D "fsl,imx91-ccm";
> +};
> +
> +&ddr_pmu {
> +	compatible =3D "fsl,imx91-ddr-pmu", "fsl,imx93-ddr-pmu";
> +};
> +
> +&eqos {
> +	clocks =3D <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> +		 <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> +		 <&clk IMX91_CLK_ENET_TIMER>,
> +		 <&clk IMX91_CLK_ENET1_QOS_TSN>,
> +		 <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> +			  <&clk IMX91_CLK_ENET1_QOS_TSN>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +				 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> +	assigned-clock-rates =3D <100000000>, <250000000>;
> +};
> +
> +&fec {
> +	clocks =3D <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> +		 <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> +		 <&clk IMX91_CLK_ENET_TIMER>,
> +		 <&clk IMX91_CLK_ENET2_REGULAR>,
> +		 <&clk IMX93_CLK_DUMMY>;
> +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> +			  <&clk IMX91_CLK_ENET2_REGULAR>;
> +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> +				 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> +	assigned-clock-rates =3D <100000000>, <250000000>;
> +};
> +
> +&i3c1 {
> +	clocks =3D <&clk IMX93_CLK_BUS_AON>,
> +		 <&clk IMX93_CLK_I3C1_GATE>,
> +		 <&clk IMX93_CLK_DUMMY>;
> +};
> +
> +&i3c2 {
> +	clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> +		 <&clk IMX93_CLK_I3C2_GATE>,
> +		 <&clk IMX93_CLK_DUMMY>;
> +};
> +
> +&iomuxc {
> +	compatible =3D "fsl,imx91-iomuxc";
> +};
> +
> +&media_blk_ctrl {
> +	compatible =3D "fsl,imx91-media-blk-ctrl", "syscon";
> +	clocks =3D <&clk IMX93_CLK_MEDIA_APB>,
> +		 <&clk IMX93_CLK_MEDIA_AXI>,
> +		 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
> +		 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
> +		 <&clk IMX93_CLK_CAM_PIX>,
> +		 <&clk IMX93_CLK_LCDIF_GATE>,
> +		 <&clk IMX93_CLK_ISI_GATE>,
> +		 <&clk IMX93_CLK_MIPI_CSI_GATE>;
> +	clock-names =3D "apb", "axi", "nic", "disp", "cam",
> +		      "lcdif", "isi", "csi";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/ar=
m64/boot/dts/freescale/imx91_93_common.dtsi
> index c48f3ecb91ed..52da571f26c4 100644
> --- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
> @@ -1178,7 +1178,7 @@ memory-controller@4e300000 {
>  			little-endian;
>  		};
> =20
> -		ddr-pmu@4e300dc0 {
> +		ddr_pmu: ddr-pmu@4e300dc0 {
>  			compatible =3D "fsl,imx93-ddr-pmu";
>  			reg =3D <0x4e300dc0 0x200>;
>  			interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



