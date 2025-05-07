Return-Path: <linux-pm+bounces-26773-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D95AAD5F8
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 08:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3B917E40B
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3590C20E033;
	Wed,  7 May 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nbyipach"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858C2063D2;
	Wed,  7 May 2025 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599063; cv=fail; b=ejRRUO26NiXF1RtJINDNv5aCyIy0XFZH2sYAHiRAyvn+lu/H8Z296Z7zAT2+uNgZdJd1kjOqzK5D/vhymtIBUON6l8yWTmgRNxVtno+ZRB91vUrJyVLis/XKikeVQn1ry+sg1n/Bt4i/wXUHGIdxR0/wsZi4ekzWPcp7hkrZPHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599063; c=relaxed/simple;
	bh=WgvLl1PHbJ8CP9di9Xn+SG23lPSE4Lgcy2TuLblI4zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YpVkKTZeGeSh3DYDMyO8UP4wNlhiYyIp71s1WO+dWqGLrtID1OV1JlU1S4UX+P96y/swXQe/b10IGPkWyWTi7YGnToRqj4kvOpx883by62EHAjmhc1BMYY3i6siH0lm+oc5GGsgZTmJToXLnqN9OZvt8E9u3lraWvGIzHGwaHDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Nbyipach; arc=fail smtp.client-ip=40.107.105.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTyUkVlck1dKipkfL1GdkqpvLzZPLaM0Y07uL4bq0z/uyFfOXa5ERvwARcObO9S2N326USubOO+IWI5W90RZ/JZoxQpfPwme5tF09KS23bs3ZZVfrZtSUF19fjN+chafO2CVJTgfT3wEERNA1LLtb1HgRJBXzFvXotY3x/bF1KMmBYdZZev6r9rxeBYxoHUBEe+1a4k2dQeXFvEiWX7cpnrS71n2RdvVCTStaJkLV48dfzUqcx6i/hnEDI9uLsx8tfTq3pa8G1nFTLbZbXpDx1l/s+FP0jeir7Jf33WOjPTi9r0TbblW1u+A2NO7aY5a59Ka1SdwaYdR4wBbyC6YGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRLbbYJNcVxKMK0B5a74lNlv4utyF8rrAcS58HaupmQ=;
 b=meeHZknOuCIsMz8d6658aeq/9TBw5TsbkU3TLbTpSgfOdFJGdLUkTewfsiGY41YzSDS3vNy8uAY2bghZK1FxH2Lq9i2MJBnvB8NhMYIF0zc31Vs1oOH9KPT9ywCJeSa0eE59Dt2UMS9xUdV3Q/9CCIZVPLPcOADFZlSnGu1knTKeYRutX0mWAY9JhktQTYuhFT0nGK0hMebXCU+L20pO9Y+Zklf78LVoPsg/kpnOuQk0x97wo28cI0sSLUZzAjfdPur7ZsIH7FThrmw5f8s4ipLTrfWnaC4VewiTWr2BK+KsmKzq8ea+evwXdYrdI5JfYK8ZP4bpLVpBlwBnViSiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRLbbYJNcVxKMK0B5a74lNlv4utyF8rrAcS58HaupmQ=;
 b=NbyipachHI7ocD3PwXqLb0piFsvc9BMq4eKaLSQRewkvk3xdQP0OoVfngnuiWq27pBme1Vo46yzZ9QxbgM1Q4TaDcIVpgnRHM+6cWiKxaKOC+hwVtb24uJLIClnA42gXTfMJGZcLwfvKTeuXen5/UU/LUOX8UaqHCyDdRJ2oRDwOjFQtblbxGDepRr1aaObLgo//yxAICRYYkVN4FcE+gZ42oPMYJCcrMH/1vJvAsd6EEVo7M4IFe9FPqv0ciQuOnzgFriItePU8G2UbxfK9ShL6W/O7lQ+FMZe48EDN9yRJ/czTCAXAA3Cb9B3mUFnq6WY4cfJmKsUnpvQYzrzKwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9654.eurprd04.prod.outlook.com (2603:10a6:20b:476::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 06:24:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 06:24:12 +0000
Date: Wed, 7 May 2025 15:33:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>, zhouyanjie@wanyeetech.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 08/17] arm/arm64: dts: imx: Drop redundant CPU
 "clock-latency"
Message-ID: <20250507073318.GB2351@nxa18884-linux>
References: <20250410-dt-cpu-schema-v2-0-63d7dc9ddd0a@kernel.org>
 <20250410-dt-cpu-schema-v2-8-63d7dc9ddd0a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-dt-cpu-schema-v2-8-63d7dc9ddd0a@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0194.apcprd06.prod.outlook.com (2603:1096:4:1::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: c229a58c-a5f5-47de-e6e0-08dd8d2fc87f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jEJfFSG3rSvecB9w1JJJimYVk/RffpSRq3LpKUbtLYXqdQR5qqDFEz3fmL2b?=
 =?us-ascii?Q?B8/ig8h2dA/90RGHWLsXUAUTl9yImgFVQ4AZ+ZGw4GMqcuM+RUpvxnzzbqAN?=
 =?us-ascii?Q?5aVGlXAGMe08xPQ2afeB2S1+yL4uOuFISx3XJOq3cMJOdJeXU2uQ2xJAo0ev?=
 =?us-ascii?Q?mNjDSqTS3rqj492lHA04Vh3It5tMws8xcjfctZ5SZZX0FImL6mR7qDk8MKoc?=
 =?us-ascii?Q?dvPi4Swzwxgpb+WP4nLexReNjD4gIz9c9ZO1oOy0/1iPg4SFwLFjJueZuwUd?=
 =?us-ascii?Q?OgEeXK9vBEPNwae9srstAu8HDHXZENC8PCo8JOFSDwhufFHjf77bnFbhVVar?=
 =?us-ascii?Q?Gep+wpud8p3ztRPVJizcrbw6AvUavIfTZET/kbcwtAabGB/NTqclL2BNTAc8?=
 =?us-ascii?Q?p9lZCDTAU5LfB39y51pAzNZMfJ3nPxUuSfpeIzCtI+oX/5fRJku9GwbyYnC4?=
 =?us-ascii?Q?YS+qgVPs0FEJGDMbacGJCmvi1PzVA2x/Qrg3Mg9Uqv/5wy99fTDMk4FrhbB6?=
 =?us-ascii?Q?D+wSHDuFaRYvlkKKbIO7SVKwHIyY0Eg+RGuSYkKW6P0HRGyp78yolknl3C/g?=
 =?us-ascii?Q?1guhS+CYDZzfPaXHVwK+IyarBnZKA5TKwjDXIcSQebMnUpU6GJSXNaAaxVyz?=
 =?us-ascii?Q?ubKprF222Tit5/3Jvo71O6KJt4Y2PJiN4344mCnrcYekL1KY795M6TSIJsZu?=
 =?us-ascii?Q?+LfzDrr1O23WTbHk0MgmxN71coStJmRwhn/0GPfC6zMSqCSpN8xda+jovpBM?=
 =?us-ascii?Q?cJucJUHRjpTuYEn9grGlipdwuw5h4xvDa5N35/v6+tibj3JV7dDVwPpo4KtR?=
 =?us-ascii?Q?FMaVsKaRKbl43UKNpgN+TN4KoFTau4nIKDAu+dn6T/FafxAXe484ndj1w4pl?=
 =?us-ascii?Q?jSOJTUKbpksvsV2iZvtxxG0YEk+3Hcx/n1vtG9pt5iwRBr0W0UN1f8/OPpx5?=
 =?us-ascii?Q?w9qB2Gcq8mGXLY6w7M2uKQbc7vr9kLIdNvrOifyRqZw+U20Rwv0x8ATG8lFc?=
 =?us-ascii?Q?0Bhu8Ij1lpS/hNxxjAdkbS5uTJubk01hh24U5GkQrydEQoALudZdJkbL4Wzj?=
 =?us-ascii?Q?4mwbJiU1sxoR72t5GxesQD1BXPZlizJO7qh64GgKdherbNRb56TEUegB9Pmm?=
 =?us-ascii?Q?+VMoEuu18xIuUG6utAbb/1WStzGUVsj9yZmb+I5Re2B3XyJYd+zD1xtkJ7DU?=
 =?us-ascii?Q?1nO6nyLFFmnE/t9qCTimMUwOkkiPHB513cllcr+pyN37UoT39/vojHgcLzBz?=
 =?us-ascii?Q?LazTSRPdtX6LjfzyKHwU0pnAO6O/ljILzvFlonWjUAfjUapqbgR5YqyV9kve?=
 =?us-ascii?Q?wjYHmwfxx6fQKqSRkWcEFV1olgwNv4aX1vm5/LcnyDQcXjp3t648xZyEpo0G?=
 =?us-ascii?Q?ZjohJj0v6eqF/GeaPbCrx0j5NGr2cSObrZytxI0qtWeTTWqITyO9QKkcwjw+?=
 =?us-ascii?Q?wB2AmUOhlz17cdWmV3Yd5gGOzPRqKdst2uAPSfVCdsHfxUguoRb1JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1dJEpdfTYdS4UuORXJAdPvQLh6kKLCjfmdLizhsPeJSeBqkCJfSdMJTW/Sl/?=
 =?us-ascii?Q?A2UYHqgvuWq79E6EHl8UirMFsfz71IlRYJKPqWwIRmqbto32AVV4DVojv2fb?=
 =?us-ascii?Q?ilBJQS4xPhwM+6fA7GeeEVYWpuRJ6idEolEVvEDJqgQAeUWQM1KdGlR/CXv3?=
 =?us-ascii?Q?pdPNTngxRDY2zho0yl4K3bXtM2eb0oWIJBjgl8JrdQZq1g6X4HF+WNqb2Khb?=
 =?us-ascii?Q?7CXc8iUMXhat+lXJci1Yfziz23Kb9dmCYl0zp1KStXT/SQYLlRygL0ZdAY6g?=
 =?us-ascii?Q?VFdbLHpxfDldc9xbW3FQS6hayIOSBqSSbSQsI0sbNOo6C/8eJPNy1PkhSDvr?=
 =?us-ascii?Q?8Zw+vPEa2hkHYCjT4KLK37hoDx4W0LtjJBrtATnvK1KfEsIppogZvFpIhp7n?=
 =?us-ascii?Q?LP02o0So0RGkFPpBwnj7nci96bbg8xSFTOR2tXBxrcf8zwWocKhpuatfJtkl?=
 =?us-ascii?Q?hW7E2ycWu3F/iKASBJ5pW9v4Y+qPigGN6agb5g3UvlzHnQXK6eQTJ/31vBBw?=
 =?us-ascii?Q?Rnzb6fLa/9Pre05fFHEpGhKURtZp5TByL3byNAMzaeYdHDqSpsUKW83z6SA/?=
 =?us-ascii?Q?ZJHJUfFTyvfbYGVugLefTAE8CaF3w4xbulwBJe/IP9I49z75qxxfR1FRxJ8R?=
 =?us-ascii?Q?8x4T2ip1aPU2AJ4MmrVtsGhnFx5sfK2iIacbgFiljrjwhdBnYEdpCK7IFBEa?=
 =?us-ascii?Q?150TZu7Bc3fgAYj3vZbLlusVO0LUZcY9Cq9ZFaCSseDb+2M6m4XSh8mgj8DC?=
 =?us-ascii?Q?Fv3SaEnc1z1Q3hZCZ/agbYnyBazf/X5rqL6P7/n03XNvDSVbDbfd68PWGO10?=
 =?us-ascii?Q?VNk/QzUN1Ji8CEBkMVQcT4dUJKb9PX3BTbYI+m05S4MT+TSzYc7HBggcdjoe?=
 =?us-ascii?Q?JQeuIktctXIWRs2EVcb9I37VEm0HuQAKLKXilMzA5JqQ6Yw1g8aNFzyjyN+w?=
 =?us-ascii?Q?uoGlOw4qUvQfABPnZcSobKMyhocesfJpkKLKB74kNcbnx1J1AuKrt86R2/7Y?=
 =?us-ascii?Q?EWRaooK6L5/f5hNxrszgAxwWF9RBnDgSTlXrHpGNbvuvz2JMo1HMKwTxKuUi?=
 =?us-ascii?Q?cmh07fECTx/2phJ9ZMRbgk/SYcRimRc4hFEMOs5wB67+HCoxCa1qcCQlU+N0?=
 =?us-ascii?Q?kob59n8OwFzbpJudmVxz85c76D2Fm2AodjeYeRQuepDpIXsdgLGKVv1GuBhT?=
 =?us-ascii?Q?iPH0TKDQ+o1qWw17uEfz1658Tmp21GIWcAsiiXbhUA8nvbAaeeeOyEdx2dc6?=
 =?us-ascii?Q?0+rxp6shg71l9oMSahY25mRQisPEqpWFvp+v7Za2OyZnxKV99Dk+PzZKYMux?=
 =?us-ascii?Q?BmVl1QUQCSKjiM9TkHIwVJNVrUL0C680+3XbZqx9XhOU1hzIsHB31Ghk+OjZ?=
 =?us-ascii?Q?qxxHaA/nPYIoXAMmKKRy6SmfjSTJuEJ24Y5TmUU0FREiG76lC4um7uk+j+1Z?=
 =?us-ascii?Q?j6Yy+oVMIMvPBquC7iyJLtP0Axaa9E+wMYL8nX+ZLhrRCW6Zm7y0KJwYvnT9?=
 =?us-ascii?Q?NAxcmrlm9RBe1DLqGm1pnCt0Nqpb9Q+SaUFkEExsHq4FCQgE7F13VQhls7hI?=
 =?us-ascii?Q?/0fFvCMN4mPDOLkZr0OJ1SzzmwnMh+Ygyx+CwvqQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c229a58c-a5f5-47de-e6e0-08dd8d2fc87f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 06:24:12.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZ7HKbzJabh4szsQOV4fA7UpZZHOZLebsI5kLMmEMv2tXKSXx1uxiNLBxR+WMq/BM4cLP/gnIMEPAU4S5Nh3zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9654

On Thu, Apr 10, 2025 at 10:47:29AM -0500, Rob Herring (Arm) wrote:
>The "clock-latency" property is part of the deprecated opp-v1 binding
>and is redundant if the opp-v2 table has equal or larger values in any
>"clock-latency-ns". The OPP tables have values of 150000, so it can be
>removed.
>
>Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>---
> arch/arm/boot/dts/nxp/imx/imx7s.dtsi      | 1 -
> arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ----
> arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ----
> arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ----
> arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ----
> 5 files changed, 17 deletions(-)
>

Acked-by: Peng Fan <peng.fan@nxp.com>

