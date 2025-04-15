Return-Path: <linux-pm+bounces-25417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7CFA89056
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 02:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669111897D71
	for <lists+linux-pm@lfdr.de>; Tue, 15 Apr 2025 00:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DABA4C83;
	Tue, 15 Apr 2025 00:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eOH5FX9P"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306931361;
	Tue, 15 Apr 2025 00:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675898; cv=fail; b=iJQc/KLn6tuzvRQnKUU6r0nsrlXpYrONLU+L2GKfMzGVAK/9xamH6Qpl+fLv+RnbvDd/II7X3nzsdd1waPt/OvIxqwsPGGhXQrPcrDfLRn1OBO6qezMpM+9Q8wmxug0PFX1BRNbWeULPT2J0muVhuBE5ut5ft6Q/BVLSplPWhRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675898; c=relaxed/simple;
	bh=SXOG6Vjx25wFsREDMt46YLHRz+CDLCaqJ7NlBevBAB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNn/bWKrTG4+xQcXNHLluPiXwZiNuH+9Gb5Q84Y5C66KuTCd7muqvdpeBVvwaSs0CCRLyHFLXqJytWHVxma/bFgd484Xf5/LT7l0heaMwJwLvGzk7l4gvjDnjAWCMgMUGG+8++SU7qrEpe6HiY8ZiNfj74+9chbJXs11ekW+3xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eOH5FX9P; arc=fail smtp.client-ip=40.107.105.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuNyVculBS/IPuQ+8soIoZWaK9KNlSW5AxngkWBSn6zDppuAF7j7+hMXt8RYjr5AcNCSRa/+5uEVqh1Wh/zeP3tLTGHZK81Tpt3GPvysGaV0f6b05KO0pSdDfDPu73Rq0fWVr3WowAlNdSMv/wQTS6ecBRBUHipjnw/b2LU0TFsrXRcKjX4vHrP+JGPS93xEu2gXBshz89MkZysIXhgWj1DwPdsak60sI0gYXul8BNC34+a/gRcMRqfAc6wzPE/yHU6+2CBE/0tSQMacaEidtsMdPre/2/DyaZpOXMPbLRNYH3dXUkCOOD0QBSt/N8RApMBXiq6CZZC80cF4Hn82Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXOG6Vjx25wFsREDMt46YLHRz+CDLCaqJ7NlBevBAB8=;
 b=rDjLE1d3HmaYC8tdEaOxx1SL+RRNg33zZLjePrS8i3jbFPZ0QogbmKOOnS4LfQ3MXH3LpAjjF9ZGuatq86Sf5+B4j8RizJrBDKKLl2wVoOtL/OY/IC8ELzJqwRyfHYmo6eWDKboX0IYs4blgzsX2BJ1gDDh5evMuB61HFtTsAZZi2H/hBHVskDHlZ9gDp3cHZT5mCb86lhPfiNIFc6OUUTYAVdn1PaNcGbYcsQgdbp2qFMQE5Y8h38B5y03KktPi4fAqDCk1a8XbQ0ScFRupSnCU6xwKfaTy1PvYn9GOOVweNXOMbJBNVaYyMSzpC1JFYE/iPgdVSYn8uMGnK1o/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXOG6Vjx25wFsREDMt46YLHRz+CDLCaqJ7NlBevBAB8=;
 b=eOH5FX9Pws+1IKfSRt/U0DvJpUzwTXWKhDVFQ9QTSXqGrQdoqKk8M9hG6wWk+gxSz00gduVUxmfB5o49/R4HA3vrXbKVxcDhpXYzDS5emUPtAyIfDWIhEerQlU6/zayAk0UDNW4TeNXfXvqtM/EAe1ydGg2YWJ8cyjNdEJt3yLL3j7EORSMyuzQq01KoIZE3QsMDwUr2IruqphjurMyHbPRi/iX++VUREh6GYlBhwNxHQ7A2aHg1i1qAGXWB2L2Q+aOrAIxvgzjGyR4Ky0xun/F7czFh8T1NL/yaK+v9sdE7XzRuRVYJ4lAIri2Z3UQYoLjYt82Y2OkiF3GUBbMAnw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 00:11:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 00:11:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Hiago De Franco <hiago.franco@toradex.com>
Subject: RE: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when Cortex-M4
 is running and it was started by U-Boot bootaux
Thread-Topic: [REGRESSION] Kernel reboots unexpectdely on i.MX8X when
 Cortex-M4 is running and it was started by U-Boot bootaux
Thread-Index:
 AQHbpWxIyVwHrK1A2UqE7zPASmzQ0LOedbwAgAAHyXCAADO/AIAECmYAgAEXKACAABeSoA==
Date: Tue, 15 Apr 2025 00:11:33 +0000
Message-ID:
 <PAXPR04MB84591C4D560C0D3D64F927FC88B22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250404141713.ac2ntcsjsf7epdfa@hiago-nb>
 <20250411125024.i2pib4hyeq4g6ffw@hiago-nb>
 <PAXPR04MB8459ED6CE869173D4051257088B62@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250411162328.y2kchvdb4v4xi2lj@hiago-nb>
 <PAXPR04MB8459ED33238AA790252E730988B32@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20250414224452.gk4ccniqtumfbjth@hiago-nb>
In-Reply-To: <20250414224452.gk4ccniqtumfbjth@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA4PR04MB7552:EE_
x-ms-office365-filtering-correlation-id: 6207e61c-0f0d-4b5f-fd63-08dd7bb2149d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RBZAEBq9eHTArfhcREG5yaEEvQkH+ZsM8Amz6LM9Yg6WmRw30jhU/isI0yKA?=
 =?us-ascii?Q?+55DvZcsWpt3IZ0WuUqkurTMUJfvZYYpb+/ZRdQWS5tsZDW+LgPP89tbKLYW?=
 =?us-ascii?Q?b6z01g+t7BNag7h50suoV8iUGmM1SaWi0uKCtSE+OqzyFVQ6llqJjSLHwpbR?=
 =?us-ascii?Q?TYeSCrGxMC6hL6fe7ywcsGeiU2x+C4zwQBYc+S37rbfGBQXPxgQ/ZVHtJndc?=
 =?us-ascii?Q?TSVYZEk9GUnfv2ehCeT8gtIuFZKY7YRVifeZCoDeDrUk/ANmz2r87j8LIWIX?=
 =?us-ascii?Q?9JbBLYbaTay9L5hMLc+2wajl8q5wYh+v9EkrSO29BvpzjjLWSRJLT8CyusN+?=
 =?us-ascii?Q?qsRmBQkhEk9PFCKD3p8OwK0Rhimnkxkm/F0i2yeJf4TiAGyf90qPPq+1lGTk?=
 =?us-ascii?Q?b2J6l35ijNUSRqeIxVKO9BQFmFLRHuAIi09Co+58yDnSpE+fX2a3ZrhcxoXB?=
 =?us-ascii?Q?yvTkjWWKUURGwJsaNeD0Aqf4tqYq8WA0SwUbBLlqItJH8AdD0LSiD9D25pjM?=
 =?us-ascii?Q?y/zy7W9dnsX5LfHATc9sNNO2lkNYLtH+FykyA3Ag2GSRtgNZOD3x+nbBTfDF?=
 =?us-ascii?Q?9lelmLo6nVwiZ1LjqvoWIiT9KH5sd9BzUDoUkQ4yI6AJgNtreZKT8EIp4uDl?=
 =?us-ascii?Q?hGdTDhN+VU8BQfqbCGrGG/XMviTeYJ9lVYXt+9YT5bdgC0kd+KZipFU6zYbg?=
 =?us-ascii?Q?KDaZRp4Kcd9Ll28hq60HVAiRMB9KRPQW3EaprIeJZoM+duHBZVn8cyt9QBnr?=
 =?us-ascii?Q?VHxqSuQjBVIDBXYIGt6R5l8NwR7qIuT4uUGYjk9q/vf3diTZ7u+37sdE3KYJ?=
 =?us-ascii?Q?mxf/e76xKPWU3IyJU0T4Xa8D9TsSRMPTLlSwhGzDux3aQzVldBK4RLYStLJD?=
 =?us-ascii?Q?+QsM7eDI2NDwMNXMLBf1zpJcWzbaBZ+IONJt8eK5pl7acZauoAELFqZObXce?=
 =?us-ascii?Q?lkSyUWhxGfOTg89MDrJNrQRtX41Iyp1y0H4Cep6CgvcXRuyJ0/MMUt79tlWt?=
 =?us-ascii?Q?2TsGw8bndoH/Btg8sJA8WJ5IeFrdESadwrsdI4IPC58oa5jGFIjjY3eZ4srX?=
 =?us-ascii?Q?qJOCd8vhyz0Wk7Lama63Fv1NwSUYOuH1SUHqhtGPPyBpZS7LcFgBTEjWXeDa?=
 =?us-ascii?Q?Icn1c0uGjxy/4Fg6Ik9dOiguNzoAUIrOf7zU/MezJrU1hWgxfcPratCh+tbq?=
 =?us-ascii?Q?rWuXnr74JYZ2FAttwle9ZacB5OVLtjzM++3SdP84Yt6xijpu7zvtWmmwoICG?=
 =?us-ascii?Q?Hly4kv4IpCYyJLTu5DsIia7r1X8Si2qRR/LAnej0yZSFan4U8NMLtt+foYTK?=
 =?us-ascii?Q?xLnXqJZjtO79kEjYkI5gO3cPFATESOlOWLcObG8Y5rpwAOV/xAiGukXsZehU?=
 =?us-ascii?Q?WX6hSoxssNApIV2AvQ78OFxba/E0GDRGS0qivz2MhY4oZmzH+IMhntuTdlMe?=
 =?us-ascii?Q?AbxhanPgKpzFb0oxThuZ89bfacN93tes+TSSYjWeV68rQpI1fuoEEhmlDxf8?=
 =?us-ascii?Q?8CtSFFPEymxc/vA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W0tLjoxgArmyScf5CRPvUk1+BLI91XwfX1hW6Hw8C2SIFGbO1jZ3f2bLf2ZG?=
 =?us-ascii?Q?jXITC2JzsbbB5ab10mVP7PEIdcxRcW+9fWM/oLKeQLfmdPK8kTy57MQAnWx8?=
 =?us-ascii?Q?rsfA1roPV6dKE+ljdRl0qFOZCO2AQUs27n6T7RfhYMtLVGbS3Dj/d/KyXpFf?=
 =?us-ascii?Q?LhfwX/vQ1PPEOsgh8POKhS/hDwReugtfKfVZn+Oebf7dNF39pKW2tEikQwq1?=
 =?us-ascii?Q?qSnvFMIlewm/WKcKNotxaxc7Jirs/enYa1SIS70Rsw7aVLEL4GKNav9LON3Y?=
 =?us-ascii?Q?XrWn5Gsn/GOg4IzaQhHhUI/WQOAYHYCNH77KHnXk3RsyrLDGhLdhN01FZQ91?=
 =?us-ascii?Q?OEevuJZoBz8Wf9vlNlkA44MajIQaEnhjqzLHIRa4zv9qVrlOvBKTQcnB9RF5?=
 =?us-ascii?Q?10JzePCenDMNT0nw3VO5/z505xTNJkAkKiiwE45zrW27lF7PawfaprRkrgUR?=
 =?us-ascii?Q?iNSdFGWC8JM5+gkwxgyT/HytBJecTd6g2xhQpBHRNiyqXqQD9BTo/PAltWNI?=
 =?us-ascii?Q?arsQvDYn9n/sRo+FC3txbVMW1wnJvBjXowYa0MYUbSDxXzHaVjgEXUsh37jT?=
 =?us-ascii?Q?IetgWkrZeXwZkoCgvIxuVuzO/9aRmTEFCM0c55g0SAM7snZKG6rCuT2W6yhu?=
 =?us-ascii?Q?0xzrigrDARRSNZIGX3dHU23zxnT/jyEsXS7hNSS2nGbUfdNjPF2SrW6VOErh?=
 =?us-ascii?Q?KhOhuA2B3cBVZDIHrjqZIsidosQ6aZx1VPIELJ/gAcjWarisPFarSoe2xJf9?=
 =?us-ascii?Q?BV1Idcpegzz6hmJZZJov6aGkMdP+Jhv8mZq4xZkfGCmz38JajloTCfWfQnZT?=
 =?us-ascii?Q?/2f5pqBrK7j8Svod71cz58q8NsHkaTlzb2xctoWqbltUIRbKXNpi7CJsQvzV?=
 =?us-ascii?Q?5CdPLJY9i+0Y5ospGNS4PKCrDyx48j4E46leImTIWCDAxkD0KvCuT3jlyHHb?=
 =?us-ascii?Q?h6tfVPtayYWAvpj2i4NHxY+SYdS1aSatP0A1VF2h/HdljLITjN1yKyfnVUc+?=
 =?us-ascii?Q?q2a0NpQ0hMnFtirYxrepQZdCj88gdldfgo5jY/rj1u/NNWIkGVZVMyoq+Zqz?=
 =?us-ascii?Q?jJpaWr+eJyO0IIB36dzGUpPVQB0k0cXzBaHV66wXyAN54URIBC78aka/3Jk0?=
 =?us-ascii?Q?XqqKrmS5BFTq1477lfJumUU3nwB5zWsD807+Qq0SezCt+oP4wAGmPZj16bow?=
 =?us-ascii?Q?ohGUiqYyfyj2jtc9+I4tXeGfLyGphx8lex021Tows8V2UCdKaRHmnX0pzZp3?=
 =?us-ascii?Q?pwLIDwkn9fWiMQ+5318XtGM93blLoEfj4a0khR5Hd1T+X81BD9LziJDqlGfS?=
 =?us-ascii?Q?Fj/8dHdbCQEboJWBDFJhiL/N6cniXsyBgTa+xccgK/yuukTk3cjWI0/nqd0e?=
 =?us-ascii?Q?kQQgTgBlVtog0VSIbtem/TSpCIQyzJ4D3YetDcW6lH19tX3SB8YTQmn0SNw7?=
 =?us-ascii?Q?l69uFzPkq+VTLvvGZzR0jrxY3/GIQ2MaJNRZL81dUm9WUBYjsY1RU4EISDRm?=
 =?us-ascii?Q?cYECjLALlUlidcsOvMabY9lU30ztuu9ada/5rnRSjb8JuNcyI3agZByA0dDV?=
 =?us-ascii?Q?PZQiy7ctcF7CGTyUj58=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6207e61c-0f0d-4b5f-fd63-08dd7bb2149d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 00:11:33.6733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cgBAx1SwMoKTOhLzgkiU5KIiIEzBy8Nri03Xx1LZts9Xjs7rP8Gb0bBI66ggHrYtDjgJ13VzybRki4FzQTvj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552

> Subject: Re: [REGRESSION] Kernel reboots unexpectdely on i.MX8X
> when Cortex-M4 is running and it was started by U-Boot bootaux
>=20
> Hi Peng,
>=20
> On Mon, Apr 14, 2025 at 06:09:49AM +0000, Peng Fan wrote:
> >
> > In your case, m4 is in same scu partition as a53, so m4 power domain
> > is manageable(owned) by Linux.
> >
> > However to m4 earlyboot(kicked by bootloader), if you not wanna
> linux
> > to handle m4, use scu_rm to create a separate partition in u-boot.
> > If you wanna linux to handle m4, but not wanna linux to shutdown
> the
> > pd in kernel boot, imx_rproc.c needs to be built in, and need to add a
> > clock entry or use clock optional api in imx_rproc.c .
> >
> > Current imx_rproc.c needs a clock entry to probe pass.
> >
> > I think in your case, this driver not probe pass, so the
> > M4 pd still get powered off.
>=20
> This was correct, indeed. I was not able to find exactly where the
> cortex-m4 clock is defined, so I added a clk_dummy to the imx8x-cm4
> remoteproc node and now it works, the code continues to run and I
> can control the m4 with Linux. Thanks!
>=20
> One thing that I noticed is I cannot make the RPMsg work with this
> devicetree node, even tought I assigned the correct memory-regions
> (vdev0buffer, vdev0ring0...). Also tested with the rpmsg-lite from the
> linux-imx. Is this supposed to work with RPMsg as well?

To make rpmsg work, you need a m4 demo that could publish
resource table, such as i.MX tty echo or pingpong demo.

There is downstream rpmsg driver under drivers/rpmsg/imx_*.c
that could be used to talk with m4.

helloworld demo does not have any virtio devices, so no rpmsg.

Regards,
Peng.

>=20
> >
> >
> > Regards,
> > Peng.
> >
>=20
> Hiago

