Return-Path: <linux-pm+bounces-32003-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DEB1C541
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7A189AA62
	for <lists+linux-pm@lfdr.de>; Wed,  6 Aug 2025 11:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49D28C021;
	Wed,  6 Aug 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cKxbtalh"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F828BAAB;
	Wed,  6 Aug 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754480623; cv=fail; b=U65t89rbBPFHcWlyVFELH9O7u/ogTuU5NbPvX+yBYmJVQJ/T2PtE+b1cTBTuVcTllwTDoVPQnUt2cALnNX3p0kEg1nyJvCcG3qWN2i0paCHInqoIp4RNopWPvB2qOI9aHJuWS5Uh+L+E2Gj6Cy4QzdaxdYIjHCzBIfszf9CfFI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754480623; c=relaxed/simple;
	bh=6P3wgbeIeXdXYTDyOX9K5DhCQqHGJKpEiGfsLXUAAd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7OJbvoqbZc9bT/SlM0tasS1z2zqxt0aaVY91nPfkWB3mhUeX/EASuTTS9DeqafFG7KpqbtW2Wg3PXGxfFCU4Vbrp+PKsrJ/VxRF3+TShMdytmia5bWxOfZ48e6UFqUiLxokscG60BOOHkLCZlP/0+9H3rPWrXr9sHjHT2narME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cKxbtalh; arc=fail smtp.client-ip=52.101.84.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6vPzj1dtskRZg+EPANNmcsXeau9jegmtra6VLYBxY/jJkLdB3hjh42uOOVnd3h1Du/7n59BkDRQgk51W7f5lR1Ci68XPLOW64MmhpDO4phQfJeVkkKmCr0otzRj7ROCDVcL4/vlhbF+bceho29M0UQVSSiy4FEKf2JQj8cuS6zT/Jo0CtuTwmDjgG7SZAKzGwxPPJlTsY3kP6ZXP41wYjgEyCPZOrF0sPAqpdfMszvn8Gbb5nvwk3SjSkzu+QhdMYftbwK9GDhxCcHQR696Ul9TOWKMix6zNK0HAz4qR10PhBsUiEOFXH2jk/RDn8FoFmjnagL95OQ+RlbGT6bg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyhAoGxj55cbivasTjcwPKxNJpR9jGQ8uiJDe/6cBII=;
 b=vs2as9O//MXOnshl+CrwFhW7+C9ww/5Z9wdOuI7eWlAFQy+SlwLCfBmol0VuXlo4md4T4VHgf+9o0tIogDOe5i+HK6b4YUgASaTdeyu9wW/pNV1RjfHxO6OqGl+uWilZGavrJZVA55c1dNTVhS4IkgwSSRBZHc8mc8fvPC/TlNSZsbzkM6vFfK33YHqLHpBmrVqLJkV5mOTeUokjnm/yM371Af8xtsncEnk9PbLFTT+7o1VNTDSMTVWa0ZtWsjM3SVhebkOZZV9Dq5U+ZwVGAD+x+ECZeCQ34dCcnIBu7I2MxeW7Zp9OVlinBhgc9KL6bneBoQcJz/C4Snarih/pRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyhAoGxj55cbivasTjcwPKxNJpR9jGQ8uiJDe/6cBII=;
 b=cKxbtalhnOozhoDS8sBVS4moc/GCIe27URenwq9suVLmlTGKIohXq/8S9naBEZK0Ie7vNih8Llu6T18oH1j1HV4rSnUNrW/dt/RHKqmgjC4cinm8oAfwJMJU8EfgP5oueH45RYutnOG2yFbSgwx4JNPzsEM7o3wyPjCKDaQHO2Lmb6XzSsL8MJROe54ESa7wO5psqMQR91D65MflTVFgZ8v6wHreCF5eGM/m3QeRBfc7bX1GxjjsV11HEDATLGkY9OLyKKJ5PYjED4rXBGnuPhzsnHJeu1AGgjCaQXDScUKGvPfnmrUfH/9QXCMQhg3GDDZiFZ6pMIqt15o32WSOqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 11:43:38 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 11:43:38 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	peng.fan@nxp.com,
	richardcochran@gmail.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	frieder.schrempf@kontron.de,
	primoz.fiser@norik.com,
	othacehe@gnu.org,
	Markus.Niebel@ew.tq-group.com,
	alexander.stein@ew.tq-group.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	netdev@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Frank.Li@nxp.com
Subject: [PATCH v8 08/11] arm64: defconfig: enable i.MX91 pinctrl
Date: Wed,  6 Aug 2025 19:41:16 +0800
Message-Id: <20250806114119.1948624-9-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250806114119.1948624-1-joy.zou@nxp.com>
References: <20250806114119.1948624-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS8PR04MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: eec748f3-7272-4971-d655-08ddd4de7b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|52116014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/IUa60M8EVydg32C+pjrrw4erhY86zq1UcEqgHpSGhRPOTJEw6ykow4M4UxT?=
 =?us-ascii?Q?W1auw82XFBf+fP7jgYLhXeyxsebIeld81daZyL7P/j0K+Tyu9ZWYRM2XRiA2?=
 =?us-ascii?Q?7kVdEoaRtmCmKP9UiSN++woCxMsT1/ShMoBTmuUcpJdo+4+T02PpMochNHYa?=
 =?us-ascii?Q?SmY3+S0nvU6AEb+i7y9DThuJFUQXFTPr239IZeDgkJ5rFYrlAOaFT+VVrYyu?=
 =?us-ascii?Q?6Bt/zkxdCDKYHzqIJF/Jgo195U8jihIuRYpH74a3kzOpbrksc5erAWyjH19N?=
 =?us-ascii?Q?EcHaIgicYYGlSm/RP99OsNeqf8CpQsle0gEAuJ4JaGyz72Yn4d64mBgf5pjM?=
 =?us-ascii?Q?AC3IWOjasDftnYXUPc9u441k60L6h23DYo3MWYg94/yVU2JR0/hp4hm1hwuc?=
 =?us-ascii?Q?luSV9tSAGw/BaTWIycqBbOU7ibnURfWayE+C1u7mFMkaJZ7oeQGEkiZe3nnj?=
 =?us-ascii?Q?rYfQtSv8Px5BMSBcnLo7vDc+Ai8KRB9G5Oww1wBx3+uANlHMJQMumklh1Rfh?=
 =?us-ascii?Q?in9j8IRhCtOXWKqiHYHYtGz6xq0lHpBQfpQZrjAdlMKw3Sizrs5gH8fZNyvS?=
 =?us-ascii?Q?/XZ72CVYPeKJ6/1moCEcNbj1/4nqpv1ZdcWSChJllvHFOlbHtlpfvQJJ4wcm?=
 =?us-ascii?Q?0C2BTohu7rOeXKG0DQucPDMbuW/rlMIOmUodGcR7TXXaRkjfTV5StrmGfBqK?=
 =?us-ascii?Q?se0Tu9iO0LObDsyVx3W0FoeeCalPRXpZkDyqpX696il7aOjpXxsfASZXlf1k?=
 =?us-ascii?Q?TM/cKSwHs3IOMCMjnkz2rsMiI89LV73Y7YVB3b+Vbg75V5/5/nnVSp7WUZ5O?=
 =?us-ascii?Q?Z2FxCAnxN/T5/CFtc+it/RG+C2pLEY619nyeKiGeaKg/OQSYMETU+5gXjq/S?=
 =?us-ascii?Q?fKpLsMwUtvKYfd1sFRlMVJInAi4wBGVf/YzODaTNo7QHjDIfNZuXUTptlAuu?=
 =?us-ascii?Q?PQReLzg59ICahOjg+447EJOr3mp6uNP4XIL3EAkAez4kInpTUgVptuqHOc9q?=
 =?us-ascii?Q?PH+RcGyRV7xkXXUO6dp5maz9hSdvOzjl/o6muJq5jhfmmWJuVbESV8ncAMxq?=
 =?us-ascii?Q?Nq/z+NLD935Dy3hTMTo/dkytL/dJPhGEXYGg3cy2hc2VqmrM5rKkL8oiwWCr?=
 =?us-ascii?Q?KhyfQcTYN8knWF5/UUklQMQ65dVfB/mjvJSz8ygmhKOn+YFLoZViYwnsmWxT?=
 =?us-ascii?Q?Zh1eNwdw0zG4Nr3ffho98+hZ7MxJ5wBL7IcGgH4ucNikedxuxOzldgO05pU0?=
 =?us-ascii?Q?I+HIaFkyEshLH//hTsg5hfiSV0jq37nSvOBWfO2hWt1vJDN+yDyPCowLQC/I?=
 =?us-ascii?Q?ertzxNSKqQEkWL5Cz9srhy/0wRykHmsncIX1rOKexaOEO/7Opgb6GwFHmKZg?=
 =?us-ascii?Q?f0DDd3NtZ63K59jvZb48rhgwRZ0CnHvHk6rRDK1+oQq9udpmxPxneiMV+8A6?=
 =?us-ascii?Q?c7A3GfPWrxprdkC6qgXyRMFgQD5ue5eH3ibaJ+bNJMDTMTwznkqVYP/6oJJQ?=
 =?us-ascii?Q?+pHhbWlwsM7FeSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(52116014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPnDf2x0BU8p6Jc5M78UPLl1orNu/d3p6RYo5Z53FIs9jk5zMP0T4XO76oW+?=
 =?us-ascii?Q?OTpb/0oFJIKClwFZ+cqhgznz+CWjOtOWzL0/XexERzRoRbBGIqZUFaiiqJzr?=
 =?us-ascii?Q?WnjTd6FXeJOEl2fV6muEO+pmtzDcsm45tksAISsCqaryl//jhjzGCQKdhXz3?=
 =?us-ascii?Q?11vJMCjWGPtWxLmUx/w+GTiG9o6fyOPDlPcjPJoImCJZfgi08+mwpozUOgIB?=
 =?us-ascii?Q?7uJ21DbjUFgONYNQFvAriYLRTmXOLykbrJiv908L3+/g06UxWMk4f0c0H973?=
 =?us-ascii?Q?KmKwFWsj9zI6wh1a+j51JauH9Jyie6/U/9JUSQWxWI7a8ynn39tGqR6I5qeM?=
 =?us-ascii?Q?SJrNOrDPhNfUsB0FvY2uh6U5mNHKVdOceJrJ2bSLJ3UWcDOAYqjXZhXmebLM?=
 =?us-ascii?Q?6sqf0fbkzzDGwNIL+G88fzgz25XAlqlNGYyotuYtLm1IZn2g1muWKDt6OTCG?=
 =?us-ascii?Q?AV6Gg61XH7uedr1UGy96I1h9IzeptSUfXY6pT/+6z5sA8ViWZs576W8ux0gF?=
 =?us-ascii?Q?J09bLe7g4PwbPNzOQJPim3cJycelgLNYRX6tFiaY9fRGy4cuG7Qmp/5+xAsY?=
 =?us-ascii?Q?rWts+9pU1uw5HTYjEhZo0rqbxBR3nSDK1gR5jVvHfvGFW5Xm3zl+bi/MNtfQ?=
 =?us-ascii?Q?5+uqcUkZ3HBE1VvdAvAuQFTonuHmEuFRYhR6jEvMlmTz9CBno7ZRVY2kHU9U?=
 =?us-ascii?Q?+wxXIA0vbfDs1aHAqkbpQsVVHhFGVBjUwMUC5X/Ps0oJ3/lQ/SXZYrS2pSmI?=
 =?us-ascii?Q?Fze5JJea5KhBPei5vuqsZT1go0Ew5YleHxvbYskSvEXnJ6d6O4i1GmoZjGpl?=
 =?us-ascii?Q?A2d3YspuUok6mpyjMo1s4wyHm46bfvz0vMGdOwQE+rqAhBi5PTkdbhn4Y05C?=
 =?us-ascii?Q?54++xXgck0itq6XtQ4fzXnFJVdW7iC4VSNhdX5IwqonY3BUXqBzz/A8tmpyL?=
 =?us-ascii?Q?xB3c7/Up/g03K5Gt+wznAkrjqWIiGPgmDKphq6G2ocZJzMkJjNSwruhRFK1c?=
 =?us-ascii?Q?6kaDG9AZLFce9KJbEMotgQJkztQ4YOdiJE0Uhcm9KpIhGLiUoBdxzaYTZMZi?=
 =?us-ascii?Q?lSHC1lkRkkzR/SM1boJqlZ81vnUZvi/1eYNQ5WNXuPR9URfITgGDuGu4bGPM?=
 =?us-ascii?Q?qBy0o2HKAoiRmPGJ6xCyoWqWzVu/wJpTPAMbDSW0NoWGtb7FyWb3zg3dr074?=
 =?us-ascii?Q?RQLrQMNoJ0WA+cpmSFxv9kWtsP1ef4ugNKwaC/ZdhiXxNcf1Ec/KATQj1dnx?=
 =?us-ascii?Q?Tf1sZLJZSbRfIeGmv/eH98bctCFtIoDaen6N3SspK+fRAxWbEHI6uR24T+5d?=
 =?us-ascii?Q?3gHiAkierYr0IhociqmGTlwN9SV6zIf2CxsWfWWKT+CPvv3YvEHfxsacusN3?=
 =?us-ascii?Q?Z03GRIrcBDOPeuf8iNPN6wv8omURswltFoMxj8MqweZkHZ3NeMTfuQbyvZTJ?=
 =?us-ascii?Q?lMAwXsqffWasyrxmcWE0sJ0FTNYd56qrYp2lLmOpTAVKUbHzOo48JR4WWTRB?=
 =?us-ascii?Q?7XLS5hU+bSE3RjjAk+xkV2nGlFvNqQuAtZ7TXy0/Vm2WBAmOmjGsIybvHxMz?=
 =?us-ascii?Q?WucUy6IqnDd/cXgrVs7Sq/MVQ7SbzT35PehExXGh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec748f3-7272-4971-d655-08ddd4de7b72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 11:43:37.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnN6stjRR4vgWIq9hXHszQwSDYWo6WKp/N1yNqgjrRxmRMjWGOHufBbxG+6gc4Z1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8833

Enable i.MX91 pinctrl driver for booting the system.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1052af7c9860..2ae60f66ceb3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -602,6 +602,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX91=y
 CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ5018=y
-- 
2.37.1


