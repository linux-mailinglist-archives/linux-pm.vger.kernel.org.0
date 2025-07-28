Return-Path: <linux-pm+bounces-31456-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362BB13572
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 09:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB937A9B5A
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jul 2025 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350DF225A32;
	Mon, 28 Jul 2025 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GJdKqlKM"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013030.outbound.protection.outlook.com [40.107.162.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD192253BA;
	Mon, 28 Jul 2025 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753686982; cv=fail; b=dWdFsgnLSXuqL+n2KQfLdMCmeQnzkXye1Phq9+rBuRn/Z3heUyIhsIOZ6CwWdSvgCmNsqVU2PWDgJ0nVByUpx3fgiWJ26rvPRI5dBrkzKCKuHP5Ae3xxN1gQ2DUxLnOF6G67mBxEJDailzxF4kQCuYzVAy93a2gsyV2mhZsCOY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753686982; c=relaxed/simple;
	bh=04CMGwsdhRX0JOzepyR46qX6f1P+QQuZNMHy/kWHF+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=coG3WkgtxOvQS5HCdyim+hXiVyjBjuwsTzTMsLikd+97QCVR3aaf9v/YHfngfK9/U0KrjdbQA2QJAoBR0hCgUbmY75t0q/OlTJUlw9yjASKrk9BDuYSr3V3xS8BJ4RTcdpLIaATW7vs6VeTJQCKnALrdQGpuRSFUuoCcD3txdS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GJdKqlKM; arc=fail smtp.client-ip=40.107.162.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aayTcnxQNx+bBIjfkTilOGdlhAMKjoavhAjhRK9BTHDORjCC36FFAkw6BN8rKNseM+tXaGO+yErr/1bc0QYtXKUlabL2371Mro2vuboeafid4484aiVRcoTmfhsCJhnAn1fCyBoB7KNWfDRXgRomCGd1LDx8NnMw/biUcaF1CZrLMIIQP/4oBChSqLpWBm4J1QVMzAI9S9ljUkkoREDIXOlgg16DcKxfFZ2JrkIg0wywMh6qVnhB8QY/EPqV+oiC9KH+TL71LfJNp9X8mSjobY56TJ1Hvok1VDBYlQCNXfBvT+Uxn5q1T0VAXMymNZfJf8OIhqB3zgqec+uI5ZN8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq0LpmdJUTVQr5/x9Qb2OaHCvN+D0jaJwbU5hrpZv7M=;
 b=HCS14Yodwno1i+ZyHS9nzKzHF6P6sipC9ywcQxH6Hv17Ubo9mxNlt/6dxtsI3t/oZt5o+dItKbJFlc1OQEYfY0P4SP2aoDs1wxiZ21G0bshEL75SLQMDATwc1b1KOq6A6fhGGM09bwxr9BnsUrc4y6sc+EYWKKYaE4esws6Zbhj/JtUh6nW0nrEh3/mxH9BSaOtwkIYE3VScCujv3GEw7sUwFb31iErxAhZl6hIohumbLHlq0OV9DW3FnXKmAYSMBRuSMEf7NtMTiJMED4DoqxR9ZJ0EB30LDc5++akWzixNpSEQThAtq+IBh+hddr9EwH10hUm5hGWJaE0s5N+GWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq0LpmdJUTVQr5/x9Qb2OaHCvN+D0jaJwbU5hrpZv7M=;
 b=GJdKqlKM6SBsocwPEzDQW8VHjfpUzT/hwMOtx0tLrsmYS0Jvyn4h28rfR6j3CKQkEakh3ynUQL46861EVnAqU3AzVUfq1bhR65ErpD+AP1noDW73R3qBYcxygbWMTNPMByv3y117R5uKoixUSAGb3enBBiHY3z+M2xgGBsqPm6c7bucVVaWp4OPCyTcXJGAnnc9UPJz7tRkwqHXArOUUjibO/U9DdedezZGJEo4c6Fm/5fFxJLoxeW+Fx4NgMArRqHzN+g8mt5riOfEqcKewQB+4thCykz+rN4Gyi6C+5gBUhXABDh8n7N/CldIuZvbguSG0x8yHOd9kwzPHC5egcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by MRWPR04MB11489.eurprd04.prod.outlook.com (2603:10a6:501:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 07:16:15 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 07:16:15 +0000
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
Subject: [PATCH v7 02/11] dt-bindings: soc: imx-blk-ctrl: add i.MX91 blk-ctrl compatible
Date: Mon, 28 Jul 2025 15:14:29 +0800
Message-Id: <20250728071438.2332382-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250728071438.2332382-1-joy.zou@nxp.com>
References: <20250728071438.2332382-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|MRWPR04MB11489:EE_
X-MS-Office365-Filtering-Correlation-Id: 286bcb07-3eaf-4a03-130e-08ddcda6a353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cjqO9J+UuHtyrS7nIIdzNIKzRz1nureLTyqzFNfdD2N2EM3IJjp1BWqwU1BM?=
 =?us-ascii?Q?HpShQwpvGLqphJQ5OzAJRc0zAw0rjj5FN+K5zFUNWOa8ApYUT+geCuui8fub?=
 =?us-ascii?Q?cLsxFlRhqtTBocQ/I5SWP6um07RxI3GLEOVCKyK82zPtsaMJ8UTHJcBMWhF2?=
 =?us-ascii?Q?dD5tPHDo6SpwJpOP6JxDiKCkJ8IhBcKjawd3iG+F6xOUx078NCA82vdCPUFY?=
 =?us-ascii?Q?2yqehDTYrgsSAlaVdLSBOg7T8+fx4aBqGyp6hI4yPVT5e4nW/GjXLvYgKzt/?=
 =?us-ascii?Q?rJ54bkIU1+567gdspiw8rqT3Ioq2UVNyqPPsENLO/i+Li0j8dwczmB+El/6I?=
 =?us-ascii?Q?Ly+Whez0GrkCvFniqOr5LSPLakZBqA0BW2aE4EwW4mv4x+OiQ86LMF+NR9lH?=
 =?us-ascii?Q?GBdFFRVF8PDRoFa5b2Aj++J+F/b5rGrep0KmCT2jUTNiUAkBpsnjmR0psnZi?=
 =?us-ascii?Q?DhmY4LaclYz6AAl3YvuQ2cYByAQacfbcsujy4UBijZyUp2ZjyNlJ/jhcZUci?=
 =?us-ascii?Q?Xrn1fNyDPwEfalGWFTeSGsbKQuA7aUuxSXqE2OGEMhZz0/YSFizxD2iwh1r7?=
 =?us-ascii?Q?78djt2oyYgXiAvimeEuesHMVSpouamWK9ItEaVtq/uS9+SBCSfDv1/R+KCPb?=
 =?us-ascii?Q?uTM2GPvsYgR6MAw8PZ8rUVURvkI4a5OLR6YXVIUK03mQdX0kew2Oi6gf+TEk?=
 =?us-ascii?Q?iH3kqi7QsFFfSBFblg5jmeGYFkc8IXS64fbY3+mhQrKdA8M0lJL1RxYp/es9?=
 =?us-ascii?Q?0vC8Su/s3ZVeYZ+WGX9vwLf33oXqqx7M+H/AION2lyQHzTzvCQclE1gXyNpn?=
 =?us-ascii?Q?LAcnMmndZUZFS36IK6F4h+Pp3REG8WV1nNAun01HlXTFQ+KCX4E9TshzDfwB?=
 =?us-ascii?Q?8jkWW2GYFk2yyg6JhIhfBqyyjyQSKE8CJ4fgtlD+TQNdSFO4AMA8khSLun2l?=
 =?us-ascii?Q?HSy3d47SgM3uBPxTLzHRrtQwTPPMwuaSI6Rjb9ScODp5m9XpViNiISn5Ky0P?=
 =?us-ascii?Q?Q5GmC5sNgLJLPY6Yo8iKvVJzWscrFqJIQNLQvP6ONwMPzGvBf59HfoXou3WR?=
 =?us-ascii?Q?ciftti7DFNF5K2ZIhqn/2fzIgsyZhywWGCIP8mCTpjGkzjj/4EEC+Ym2R9EK?=
 =?us-ascii?Q?2duVTqAuUvQRV+QWnXVbHggRwTdXgmA6/6lGR7ICQtgGolreVIa01eolOOat?=
 =?us-ascii?Q?4KJBYNrlq2O7as5cxeSFWFlZ5cg45xRnTEeSxqkuq1P5IY5TaAjzc42rum2e?=
 =?us-ascii?Q?4l0tCz0jgHHquZbggLzBKOKekxikMcmmZPXPxB7+K1E1MuZSulgzWMmZYPBi?=
 =?us-ascii?Q?eYRcLO1zY9OV39WSKLgagGom5MaOYKuXlC5+hWuPVjSRgaTR12d9naKV5CpX?=
 =?us-ascii?Q?uSMikVWZgm2MICrLhQamYl9WgnfdWuF7LoCW/y3L4q92hsgD9noolZSUkq6/?=
 =?us-ascii?Q?LcJlJbiUw6oHE+/2qPPnMH1SD2r8RFRc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BAwRbPmtoY/oI2KjytzhSz35/eWuWZPr7TO0jC6Oer9UJF6ylT2s07iVnyYL?=
 =?us-ascii?Q?wp+xoTAc/Nc2Y8/njLx+PE+lfnkDLmLbSrIn20g1u93E7hzS13M1zmV9LfL/?=
 =?us-ascii?Q?IeKZGNSqb1wYYjtAw6U0UvSf3gTGpjliVkhL70KbwyDOzMPQbKAJ/ce3Pf6i?=
 =?us-ascii?Q?Jv3oyW1fuMG2RgvE427VQ2ei6RcW0nHs4nlCtCANEfpUQTHDpy9B78GmHiyX?=
 =?us-ascii?Q?Q6r0PHCraetzuz26SIPiPuDFE06Qcivzn5xjazpzyw1Cy4+ALHQFjCD/6aRL?=
 =?us-ascii?Q?6MO9+c6+SrmXKxM3ars3OvGHH8ug7J94G5fth22zzuMRwe6M9vOLUc94MvYG?=
 =?us-ascii?Q?wicYvuiwy8J2MOSzENhZaKOSPLc4XVCs/aTwJLn2hSUkXvaPOzEZNP8JEm6g?=
 =?us-ascii?Q?+qwcl635By2uVzYD9Mj0ZXbmhpNl/8o/Dxt5SBUcrb1o1iIylgk/DSxtau9z?=
 =?us-ascii?Q?amEKzl+tZFnuYrBdG7BiRVKtDlh8nnhlpLnQh0Wwf18R36f1h4iqNxPMjaU9?=
 =?us-ascii?Q?0ysAtKQfgm7hhiM6gSWv5WM4oNPXOkSgfPYbDXxlzK1lk4b/NI3zo8n1vvpj?=
 =?us-ascii?Q?R8oafEyyCNQHlY6NOqQelk9TKssX6YQLh+asaTKkmGDP14n8ayr5NIppzQk6?=
 =?us-ascii?Q?Nj9q02teSNXx6yLabvm4uFOe22h+jbeDSZJEPaMMouLrp8QP9EoVjGmaxK6J?=
 =?us-ascii?Q?vuhmzU6ippa6Tstd3eWUZ1j7W/6XT5WS67yWpE7jJZl3wCz0TvO/2OmIkll4?=
 =?us-ascii?Q?TRJqFlovSlN84OhJAEsN7ao/87gXumqFRDv9bS8oqi0KhO6okXWsEr3n8mG6?=
 =?us-ascii?Q?DEcMbasWkJB1lf7/2it70//J3Uw7vjYIqpLd2rZKDVOnUKQQ3EGigZuqJsuj?=
 =?us-ascii?Q?7dyjOotvlGxQSCGk6MxZJtpaCY8mu6QDxXKjRw8AlHrIRSyKnhOg5+JNq7Zd?=
 =?us-ascii?Q?/2I8g6oqrY7tuqm/abm6Qb00GZaH5nxJ+yN1ffGyuFI/Bb/KyhAe/lr/aOGt?=
 =?us-ascii?Q?euSgdgo6BLrw1axlooiQz9/nR8vKf/nOtegYB/Oic2J/gIEPS6HesGdk1FSC?=
 =?us-ascii?Q?9lOl+FkONiDorEoVdfhfKXruY1QmCD/QPLouy2MhjF+P+8hARcnKy/5YL/b8?=
 =?us-ascii?Q?W5rHW4mNL6Eb2Lxk05x0Pft1Sb9Ec/c7bRLLwiHz0XYbd8eE/vc1yF9aNLRe?=
 =?us-ascii?Q?mp4KrOGpjxbEO7bdp7W1ObRlVSGKSlKxQywsdbeJP2n7lKp1/sURz737EmfB?=
 =?us-ascii?Q?obYZr0LPL2O4tfu2VaX+cZ5FqgnF77RtCpmKIqpp6x+DBJOKVKBovHj26gKb?=
 =?us-ascii?Q?ChkeWcXAfgMhoX+9qyRsv3SCu9QGqvDc42/LzL7gqoWA+h3M7RDyTz1GJPwr?=
 =?us-ascii?Q?9TaStgtJBIuj+IQ+2NBQgfVSbTsznQ/pUG3bcOBWJvBKH0n+LMfOwAfPeCnv?=
 =?us-ascii?Q?XxMt+08kqmAL6qsj8LOObXgXpHQ3xxMBhziYbecp6cUcTBLID4SKkzP3Jp8D?=
 =?us-ascii?Q?3m62JPqxwZ7QUnjmZRo+WuSPawutqgt7Smu+PkCfe64oeAPNgZtI0USCIVm6?=
 =?us-ascii?Q?Nb+/4kE5pZ0yqRZSHtZQpIRrnxGkFgegrL9u0laq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 286bcb07-3eaf-4a03-130e-08ddcda6a353
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:16:14.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UgsOCKsyJi6sv2y8eCnCV9cKCeIycvBvdAb5hRgmp+ueApWPcj3CVAtwe1380vE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11489

Add new compatible string "fsl,imx91-media-blk-ctrl" for i.MX91,
which has different input clocks compared to i.MX93. Update the
clock-names list and handle it in the if-else branch accordingly.

Keep the same restriction for the existed compatible strings.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes for v7:
1. add clocks constraints in the if-else branch.
2. reorder the imx93 and imx91 if-else branch.
   These changes come from review comments:
   https://lore.kernel.org/imx/urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26/
4. add Reviewed-by tag.

Changes for v5:
1. The i.MX91 has different input clocks compared to i.MX93,
   so add new compatible string for i.MX91.
2. update clock-names list and handle it in the if-else branch.
---
 .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 59 +++++++++++++++----
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
index b3554e7f9e76..15e6f390b53b 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.yaml
@@ -18,7 +18,9 @@ description:
 properties:
   compatible:
     items:
-      - const: fsl,imx93-media-blk-ctrl
+      - enum:
+          - fsl,imx91-media-blk-ctrl
+          - fsl,imx93-media-blk-ctrl
       - const: syscon
 
   reg:
@@ -31,21 +33,54 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 8
     maxItems: 10
 
   clock-names:
-    items:
-      - const: apb
-      - const: axi
-      - const: nic
-      - const: disp
-      - const: cam
-      - const: pxp
-      - const: lcdif
-      - const: isi
-      - const: csi
-      - const: dsi
+    minItems: 8
+    maxItems: 10
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx91-media-blk-ctrl
+    then:
+      properties:
+        clocks:
+          maxItems: 8
+        clock-names:
+          items:
+            - const: apb
+            - const: axi
+            - const: nic
+            - const: disp
+            - const: cam
+            - const: lcdif
+            - const: isi
+            - const: csi
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx93-media-blk-ctrl
+    then:
+      properties:
+        clocks:
+          minItems: 10
+        clock-names:
+          items:
+            - const: apb
+            - const: axi
+            - const: nic
+            - const: disp
+            - const: cam
+            - const: pxp
+            - const: lcdif
+            - const: isi
+            - const: csi
+            - const: dsi
 required:
   - compatible
   - reg
-- 
2.37.1


