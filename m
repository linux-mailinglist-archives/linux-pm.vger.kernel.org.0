Return-Path: <linux-pm+bounces-28560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940B4AD7785
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 18:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA69170E21
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 16:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01089299931;
	Thu, 12 Jun 2025 16:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTHA8NTp"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92AA55;
	Thu, 12 Jun 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749744203; cv=fail; b=RbmTmoi8+TH2ghx2C0Jb9ORri/0TiFV5cA8bHkA9Vi1nt3LwDxMbw3ADDzLXQ0VxzdwYiE5dsLZttTiSuRQjoKVHzkeffhvb7++jzq2Ni3e7W0qEcHQE3GMBH9RuGBXeC1BNmlui2jbJT4OmTO/OOVtHQ2pcCCmH6QI6jCNqOEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749744203; c=relaxed/simple;
	bh=Kn7L+fiY/X171XHjbF2kMEOq/dMu/VoyCUK2LN9Sn9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t+fR+6OaWgaPGgpxgpxFT81n8z5zMLf2EkdNXo9sQHm3oCLVRoD2yIdpqTcJe1WXIrZMAifB3pRG2im07rM28LbUchIUOZz8N7o38M1TO5sTyruOOhqd0DA/Qq8ukWadcimN9mTFzFiHeYXRkL6Wt2viHATojcqjSABHQZ0Lw5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTHA8NTp; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0na2guu+Wk8WIc0T95IIFRXcIohGF6M61OZK+ZCZ/L9pFHZ9PeXGTxFtZVQL7FRy8dyl1CujsUxmt6a21GsJrpntmatzn/crYH0zqDwfhmohJnIv0RVodIezcsFYYKFEijOxD20okc1N0IOblJpwq1cU2odX21yMLyJNY4sYtWJNK8UzzCWbXxjwNRBJsr0QDM47hMWrU/BZq8VAG2fNuuPMEMJb/W2NLBL0dBHc50CQHTmAcnotZVlvJFw0H2W/ex2t9UM9gIhXJ8ZmGWQIcvUfgygSKRh1+3Z5AB1O5UUBs9jFzukHIJcEdYxDbGisdHqhBjL7vDkD633Y6k3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGk/riKjEZ4e8PuPy3S2DeQ6Jp1lAKkl1KdE8Ngtxkg=;
 b=xslxiJmic6PumuoNzPFsfvIyso4msJ6HXFBCSnngn0QfedjcwYVRZYq+HcPujruyzrglx4+3dnHYu1LMW3VAn9mAVv/A9icH01gU+BXcLKnWyI34b8dR8uYNAflL9jz+0pWmODWFQIVJdyAY2lN2ytKdQyJ+R1Q3mTUAgkfjbT1U4s94HdZtJQvX5wtPghiVtqA9JRDJvCMULRvfu+e2s6CJfdqHyI/p6+P9IIU8cdRhuXVe5NfVAidBhnq6/cRFatifCfIcNpEbxnt8GcsHqPASVgEa+jP4Al8q70IHkd5cLh7X2q5jEI3Fmn1pT4eOXu65UMDOf1Goh5xVDU66kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGk/riKjEZ4e8PuPy3S2DeQ6Jp1lAKkl1KdE8Ngtxkg=;
 b=mTHA8NTpDi8QLpA/iTVJj6933l1tT3K++LO0GczxAnZp0i6eR9FA59lH9Ad9qw37BDMVdt2XUtv64fKhH/ak+fO/qjx7m0dDh7o+F7/TRlyST31UnH8icxWuvqli+JTIe1eniK/gSxbXetUUu6igqQNMh3ibWckxMYU2jigOowTcK8Ek5F9nnY3Wqpnvz2eLIqDC/Mzp7nbrxE8K/+611qEWwz+pI5wndpHmTkF5nya4q8/8+4maWDC24cv5K9BAROsFaCLSC5Zrn4nViAFbWw25LDiATBqA4Q2tQ0UqwkfzUDvH2D8dRDfspjIS8oNj9jzEluQaho2T0XIqfnBdXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9347.eurprd04.prod.outlook.com (2603:10a6:10:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Thu, 12 Jun
 2025 16:03:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 16:03:15 +0000
Date: Thu, 12 Jun 2025 12:03:07 -0400
From: Frank Li <Frank.li@nxp.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sebastian Reichel <sre@kernel.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>,
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>,
	Enric Balletbo i Serra <eballetbo@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Message-ID: <aEr6OyUokESLlrCs@lizhi-Precision-Tower-5810>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
 <20250612-pf1550-v7-6-0e393b0f45d7@savoirfairelinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-pf1550-v7-6-0e393b0f45d7@savoirfairelinux.com>
X-ClientProxiedBy: PH5P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:34b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9347:EE_
X-MS-Office365-Filtering-Correlation-Id: cd44cf38-f0ca-4b65-461e-08dda9caa3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XnJZHRGVel1puzM8SXQSjT90ql/q00My1xMvBOWqHafrDTU1PrdIiQKH01aq?=
 =?us-ascii?Q?8Ae0z9HTiQ0w7O+z9ZAbAntmVbdvF74qj11r1jE4cDk+Uv/pQoMlHZelqTrJ?=
 =?us-ascii?Q?bq/PdWem2OsZ6X9rlIVf01z3gtkLfOrauyckQCPGky6oH+Z5/s4mY5dEYFFJ?=
 =?us-ascii?Q?jZ9zrdW9+9s0BGX+PNept9H1Yzf12S0VA2sR3meVHF4NT+pkaFC4lx5+lgkj?=
 =?us-ascii?Q?GDtAyt3pFKj2PqMUMYGiztSRViI9B92UWSALouN1tT+IqSkdjTe2jCHnu4bA?=
 =?us-ascii?Q?KrDXiH3x9ctXMqyW+19mXhMmW2UT5DV2WvC3YGBdE1mng3fYPle96pFCrLSS?=
 =?us-ascii?Q?yG/3qBU8F4PQz6l/csAVwJUSc1drmOO19Zj4MWQyh41LNVKqeRAVSTn+ZOZU?=
 =?us-ascii?Q?8AkVsSSmQbx+5LZ97JVfxU0AG7INhEJRwOcJIK3bH6m96q4OcrFA/xtcpc+9?=
 =?us-ascii?Q?qFI+ZpBVdVj92Ai2qmVVrQfrQKjV1aclo/6SIeWUgz1LPWqpkyxHtNMhPlcw?=
 =?us-ascii?Q?E2mp0I5rQ5Urf68iE5vZAUuTvlQl3g41H2+XL+y+1nqaeAO2UZWV+UtqDhfy?=
 =?us-ascii?Q?Lh+vq7Xz0hccQsFYqONKFc+H9LX0y9V4C2W936la3RN5rGBcMBAQAsd9WjEX?=
 =?us-ascii?Q?G2i02PEqoYfaSSUXsQAUXif8jjtInW6vi8FtXmSAYQ8PAXSWJoh1Bx0JmiR5?=
 =?us-ascii?Q?s8hhAEdaH2hLtipmsICBBC1CHn77Pjh00jcj+LmzVBrb9/9tz8bDojc1BEdW?=
 =?us-ascii?Q?AtwWZbTKWaJXR6mbSvH4nL1s+E960Hl+dw53wO/fUTLebNEAYgBPA8SBHi1b?=
 =?us-ascii?Q?mXdXXw8QQem1SVG+UFVmlnFzpvO7NjR7sT63GWZgAmmkmghRB1OuabEHIuwL?=
 =?us-ascii?Q?tzerf22ZnFL+mQZU9AgiLCDpa3a87CnapgRoMLqsVISjMImpCSOGL5/ZIhNH?=
 =?us-ascii?Q?HPVo36nt0CUWmuEJ1EpNmCNiQaasxaJZP+cFOsrvvwdMAZI9FvEYH9wZww/G?=
 =?us-ascii?Q?mO2ADrbbJCxQecjyrkIgfkgOfatQq0lo30RfplvWjSfsKfT5a6Mcezh4OgO+?=
 =?us-ascii?Q?XoDyJg4ndLahVE83LTEiH6EInD5Xw/qzzcU4SFRd2Tf1dM1cGQAN8E3un3Ie?=
 =?us-ascii?Q?A2KpIzJErWa/nRZcoRELqv4NcNf7rCgjKI4qVplH9x4aIKKyIGmC2Dzl1Uh/?=
 =?us-ascii?Q?6aMe9YmxFo+kOprWcGRIHvwpkEEOyHgKKb1GL+0/ZaTzmwrBw7YJ5w+Q1Ah/?=
 =?us-ascii?Q?ETzT+Cp1mPJFlT0EaKuGEzecR4YlXE2n/nmV07o4jSPnS6mR3NkiEGgdMEOG?=
 =?us-ascii?Q?gEnKqma96VV/QE6hWGblYk1E6i7wqiBihbGOVL3NFWugRT6YNFDTapH61pi6?=
 =?us-ascii?Q?/WYRLh2o9QjCaTTYfHq9OYBb1E+jDjEp2QIBd9qfE8d86xm90BzwP75W1cCp?=
 =?us-ascii?Q?245LQNh9GHnzjGUyBKLLkp13392jpwAyqGjYsM2mU6exPsb3c3HpIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M7rhADnV1VmZyeRoXaEwKRucWJyan6KJVChVJOMSvsgUnu0saEWFZ7Ea3iQ4?=
 =?us-ascii?Q?v+pzcq/I8ACKDQpUARXtJjkoddWgF98olamBLcBHo/0hOqn58yTblyRFLx1o?=
 =?us-ascii?Q?epCQ/6xxTdSZ0uNe1df7AJpEL6In4EiGu06UvDgI35Yy7hNuMwpt1QpJ8M3i?=
 =?us-ascii?Q?4UDyPdwnoSA+MlGo1FtZtbnVoQk3cu/DywRMHAPsDxRz4j/PFNnYlBiph9p7?=
 =?us-ascii?Q?rgEGuafn0MfFAVWsozcdBip4glWVGMVU8TDSo4O3KKaHrAZFQwyqLjuKpIsQ?=
 =?us-ascii?Q?Yr0CyFV+WGwJuD7a2wCkTbrLTHDf9ouqblN+E0msENr31h6KwSlBAH6lpPL9?=
 =?us-ascii?Q?aQN/ymtn9BOw+kO7JJXt825Q1Fi9rZA3k/xVZ3+U94yQ0VyFa3j3amPTQyN5?=
 =?us-ascii?Q?3a5onI0wny/TkkUyh1dbBzMt81pZXmjB89UA+tUxIW0TgrYN4d9pQjJdgl/4?=
 =?us-ascii?Q?Rq3x3PTlcFTRaL95Phzn7XQ+lkM4EFCYVM22lPq94nv7DMdEWpi5HcX5/l8C?=
 =?us-ascii?Q?m6eZww6xTit9J/FiUUyy9A8854M6qELS3LqL6+duTk/fSdVadFVHu/KsTXWg?=
 =?us-ascii?Q?5O/jkxO7FwpKpQ3aO5CIbCxJn/9QmcE1BPSIhj0zhAz5Bbj71wjciFwp1++p?=
 =?us-ascii?Q?wfQzWkT7vHFTUe31ugJfeyXagZ+ZE9j8kcucAew22hvj/cHZJojR1K3pCZFI?=
 =?us-ascii?Q?+ZNq7gHvx5zktc0TATX5rm91FINoChD0Zm47igabdsdvxoRN4WRiWOaaVcuz?=
 =?us-ascii?Q?79bfa8EHRYS80+nb9KoH4yIyUH7Ms3hJmkrP3/1JjOSFnQUJxPIQC1Jyx8gF?=
 =?us-ascii?Q?w5a3vL7FaGGwQwmxTO0g+FHLW+t0SFoGp7nBxMZt4qKJMPHSTQU/gOMD8eRN?=
 =?us-ascii?Q?I5z5YzRzat7jaxSptigqpwFnwhJum/SZol2uuY3xYzP/W4bh1e+iojwaELrz?=
 =?us-ascii?Q?r6YIiCITZDhkdzxtcuyLnHyQvnV3zGkgi5PCAFtgNgCPTSmwc3jLh0C5wj29?=
 =?us-ascii?Q?LV0hhnasdRckcsXlHolsaQf8qe+JnTb/sKyAlky2s5rfQHzlcSxZMDA3it8r?=
 =?us-ascii?Q?CEvX07kgmf6eKS8OFZ10E2XSQHJN4IKsynxenRWb80PT3wAbLK7IHLQ1uNlD?=
 =?us-ascii?Q?34U4l/UJs95OzTRdyZLSD+ByF48gIFWT4mtjoz3NLZppi0c9y8GvNk+dVSzu?=
 =?us-ascii?Q?hqVPwFrwaCKpughLht0IqqFyoN9ABYvuATv+WtqEPd6WrFUwIy84Nvcu2xCF?=
 =?us-ascii?Q?ORHkiMWA/xAWywBsHtvZlQjLXORhjB5NEBSoiJsklhMYXPU3YKzbhsZ/jTkg?=
 =?us-ascii?Q?CIKBuZoiubGL3cH1ztEVRsUpWjpODno6BsvKOXxdCXiikEONYnF6ebXL7xTu?=
 =?us-ascii?Q?JrK2SLuDN9lAoFVp2YlvyJXykuA59Ma5QebK480PDlfN5GQ2Nq/yblahlT2d?=
 =?us-ascii?Q?uU/l57CJp6s53FlKZ46v58Px5vmDrCaMU1KqlypUMVOlW06T5osdWw1wlrfS?=
 =?us-ascii?Q?GwbVHUlQ/1Rbp8KgCcCums3pe0svw7prbNModLfv+OLFskSWm9kNMU5j9IuT?=
 =?us-ascii?Q?EtzSKJhNdpgCp0QXKR0k9v+LFSh46Y8fsmckbORG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd44cf38-f0ca-4b65-461e-08dda9caa3fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 16:03:15.7661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rANvMHrTOW1u59XwiLAHgRPQjJ7fzSL7iG/imVXZJMGo6sXKTw4wQtR+Ka1p7YgKbk08xGRlLmoF3rua5mbd7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9347

On Thu, Jun 12, 2025 at 10:55:48AM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>
> Add MAINTAINERS entry for pf1550 PMIC.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v6:
>  - Add imx mailing list
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 98201e1f4ab5908ff49d32d19275e123cedb4b66..5547fdafa7e1bb11903d5d5bef246c2e1a20fbca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17853,6 +17853,17 @@ F:	Documentation/devicetree/bindings/clock/imx*
>  F:	drivers/clk/imx/
>  F:	include/dt-bindings/clock/imx*
>
> +NXP PF1550 PMIC MFD DRIVER
> +M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
> +F:	drivers/input/misc/pf1550-onkey.c
> +F:	drivers/mfd/pf1550.c
> +F:	drivers/power/supply/pf1550-charger.c
> +F:	drivers/regulator/pf1550-regulator.c
> +F:	include/linux/mfd/pfd1550.h
> +
>  NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
>  M:	Jagan Teki <jagan@amarulasolutions.com>
>  S:	Maintained
>
> --
> 2.49.0
>
>

