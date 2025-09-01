Return-Path: <linux-pm+bounces-33547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B184B3E048
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005CD189F080
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 10:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A9030F926;
	Mon,  1 Sep 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RoCFRRqx"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E530DD0D;
	Mon,  1 Sep 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723051; cv=fail; b=spR0jU1kZ/kWeahiOp2KZpqRL1c1wmkjHiTlUL9Jt4e0j97rIw4nMqUumWqvZLReBuvnrScFlovCUgGGB43PZ0abmLDU8Kh9rMf4rbhpYRI2xH8NyDEMZjVGTfEHou5BWnExl0DzFvgy34qNIoiPfcQo4onMRTQL0iIouu7te18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723051; c=relaxed/simple;
	bh=gBfWd4q1/5T7UhQOhT1DZEPen35d6xX221mPxA783p4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tL7UC4aXtEAsIBP98Tl6jyAkfOX8N6za5UQAKsR0uOtiDyXW+0t97s1I6D5Xi2OKbZkX9+glUp7gy+GiySuXqGIKM/hSGGa4Fyr2Gt0a1MBmGi03BYbaVmgboqy75og9dNbjDzVpYSJU8XHTYopPkM4o7mEvfIIae6DOpvi8FBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RoCFRRqx; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb7yOVEEj6TrpWS9YtQp12eaZzYUles6KDnRK8HUFHnR8Eu1e4ly8tr0hegfHPnYs6kVnUbZ7yuZzHItqVRCOHMLqES0pCPcmkICeAjeQdu/AfSqvMQysk3mclA3eBr23zny2y534kXpKwBbraO1nov2St+iOMJAQGMQxFgQidvOowC94p8r0pr4YFkm2njRgebUqv0+CB6YelmoEl2hl1P+MmMeLURuvrPNi778ffk81M8HaRropl6zXL+mbxxa9BebxUmn+WJQpCdm+51d0NbPM3m1aNYTTCcDumi+L/vWekB62wIiH6kCPWDQ+X+3kQPbsHazbEGoDzVD5OL0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VperyxVAjlwlbJCJkMjCmXrIBGNM7jAh5WR9v8W14M=;
 b=hAczhlcMYFVj5kSZAubWSR3WF5LzkJ44JyVESt/vR3fPWVbCGQPEfBhe4YffF2D5X/z1faM3iYjjyr9PzH8rAKikj8sKqoY0V6EkDqltFBYK+AUG+OZJSH4/+1wkFSP3rrgRMDDK7ONHmyM9quGyc88i9fsS6FGFzKmZYI5jhrNlD2PYXRk/fLfCQKTnlCVhNeC3Ae2X5EAm0Bfi7KWIls2/N7IrNWpBViWu4ltNnRnWdNf4W1PFfBGpO8TW4A5K1UVf8A5Qasw/IC1jsCcK3QEl8C6rYJzSj5dr2N9vvqn4tR/lye3cfxQ9ehmhxxXnHWpiU4JuBWXvGb9IJSvDjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VperyxVAjlwlbJCJkMjCmXrIBGNM7jAh5WR9v8W14M=;
 b=RoCFRRqx2Ia/OOfrnWm/PPTJD1VwPZEHWHLXXdChFTgZOoiKocVvaX7yIXnpu0bOYDZeLwk91DqUOjiBh5+P+4x3c99upLTj0lwJfqPpQrc5pLzirgFEitUreasZw+pmpXO8SRLWYy3bnACK0I4tgzLHwd6p381YVhjB2Xwz5K9kvVNPaxGzisp5cJinVirg0zOGohR2+JMXPEYm2t/PO/6h38VzexdjdKYmIcp8dRgx+92EIWuaLe9aixp9znAfA12aBWV0jqTruqRCJTp0Q00aVXafzIY034swBRF78vXCbxeBehhbLnK5+PrKGEI3DUs/EGg0ZroHQllKa7p52Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by GV2PR04MB11304.eurprd04.prod.outlook.com (2603:10a6:150:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.13; Mon, 1 Sep
 2025 10:37:25 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9094.011; Mon, 1 Sep 2025
 10:37:25 +0000
From: Joy Zou <joy.zou@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	richardcochran@gmail.com,
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
Subject: [PATCH v10 0/6] Add i.MX91 platform support
Date: Mon,  1 Sep 2025 18:36:26 +0800
Message-Id: <20250901103632.3409896-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|GV2PR04MB11304:EE_
X-MS-Office365-Filtering-Correlation-Id: 625b64e4-5c7e-4ead-0b7d-08dde9438a44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2FFu8OwIvNeeKR0f1XnC036v0YMntfbaYaB+eKKvxQt5whXLMLLqW/GXExYU?=
 =?us-ascii?Q?IlJs6K9buW5exX4ldstkqbeYPM7kAfAl+12x2ALfjmedRzBnongexrFCE+bh?=
 =?us-ascii?Q?zeyw8/AjOp5NtNx7lL1U8rM1pnYZiB96R3iU7K+8kc2ABJkj+VRaI8QyQhih?=
 =?us-ascii?Q?3tIPxRXnx57ZDByjQG6/YDS/SsEXIaCgBemsa8zVJlroPBECYFKhPyXyXfMZ?=
 =?us-ascii?Q?DolMThgLGOskKl7/0eKJFia4nd+skO/3pRscH2y0ZGgdeZByJbQug2XhxHpw?=
 =?us-ascii?Q?lEh1FXNTJpSa0w8+I8W8gTmAeKQl9JJiY0KwbrdIp5o02sHP6pe8bCItL9vp?=
 =?us-ascii?Q?LAU+om0DYWHM2PwXVNjYbVLNWWeaav8hKrReJ8cJtr/OTx4EM1CB/XltL9JP?=
 =?us-ascii?Q?V53Cbiws2GcFcVIPjT5Eqvf9WAoYMF/pbEQUQT/asIdWXudMAC6sJmUBCXu0?=
 =?us-ascii?Q?ffSFLmVPtt1z0WfjrjR7Ux7y5NGCbPIGRVfQ4Aad8HcZ1uLX5TUvVRNYqqhX?=
 =?us-ascii?Q?u8IQEw9oPtrZqQludYAW/4/p4eVt3Fz/wvFdkqDAZ9p5HeCG6UmQPpcSk2FU?=
 =?us-ascii?Q?cSFIu8O58jwExwGhUlQbf8XRtHwGtCn4hV5I0BH4DSutgnDcj52V1OWaPYrn?=
 =?us-ascii?Q?0uqP3XJJUrTwEIraVJfjyedjsgypBnAV/HLGcmjowGnIgKKsH/XJUF5LpKVA?=
 =?us-ascii?Q?mBoiBkjoSGLm+sEYmwjjCOI/tIT76bhN/e9vPdB03ucdf5GcgSjQMeeQLBTX?=
 =?us-ascii?Q?P9VDTBgA5mj0cVlSi2lufWWIefou7ElyMsq736fUGV2ZZ/1z2wmFNvaa4/Nj?=
 =?us-ascii?Q?EWK7G34qP8S21s/fuRw/at1QhdnYymXGZfdllOJ5ibANG8/+g5zK25umcehh?=
 =?us-ascii?Q?wGgv2/iH/h2vSZarkKQwucQ20srmv3K7lpMPc+yeFS42bFkpJMTkG9+x/o0k?=
 =?us-ascii?Q?dQbjJbrAwBcxJr2w6Mz6tCBMFDoAPPUiS5ts4BFga0S7fUCAgpnwXn64as06?=
 =?us-ascii?Q?f6lZ1n1bw/PRNHndY+gUowMqoz1PqCBtJeGXisR2TMFmrwLaFxFiTJHqJi66?=
 =?us-ascii?Q?f6jMHBqd+gr7NdDYmuXyLpr4kMeJ85xDRyzGokjPasQ8aHdxLlqPGS+OZxqf?=
 =?us-ascii?Q?v+xOpLJaCVJ2QRAc29elQJDkWIiqr4oj37ln2DwitBgVg+/mnMzeG+oq2ezw?=
 =?us-ascii?Q?ofRj7hc8nMJDvfL6RABZcA4+HjGwfLX3mFcl98WpF3dr2gLFub3QeJO2nzV/?=
 =?us-ascii?Q?B/vgQCqZyPAEJDEwrSQFEEY77QGoEzQm7QYE/qsCXmjD8Zd6R1LNa2SH2s1t?=
 =?us-ascii?Q?OKiZp6VJAU+/qA2VCkKnxjNhq2+PL5SE3j2RvPjk6b5UQMwg8UHfQtUGswJy?=
 =?us-ascii?Q?Q6YXpv90KCzoXd5UJ0u/EHbTFspGPueLe+G/NqxGZuneppPC+G5EEjkb/kvH?=
 =?us-ascii?Q?I2jO+iJb/eq1o1UlA5KCWsfQyiwD6e8Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iZlyCBtuOY9yJTOAs1OFL0uAbex+NMRARc8WZPsyyBaI54HXT1IBUJZWiyuz?=
 =?us-ascii?Q?dg1d7lbiCDj6rjqGRufH9tlI8cntqfzVTOWNVc7aVrI9JYYT91MbLYhaPdeN?=
 =?us-ascii?Q?pXAlyGeHSeT83WrUjxdZq0RLHzX6krHzXLwxbvH8LVS5q3MCPx/wSLCEyqEt?=
 =?us-ascii?Q?9bW+QQp9Plqv0Y/VpbfxSdDDws2Ky5+bAlLLplGO2Bxv+f7DQN8tOkfGgMCY?=
 =?us-ascii?Q?a9xxwjEjAxbkk4YGnQgSrjCx5TLtTiXcpGo4Rj2XQBHJb9tG7XmdB7aqfVwY?=
 =?us-ascii?Q?LmRTeMYBoy8F/Pv/uPnvIZbM0XmfCnwkX4ucmcVCAaq4zdiLVvKWfI895X32?=
 =?us-ascii?Q?wemgooODpOoTvXXpog5mraQbMecTY87bfyEgRLufi5OeiZUIY+qFD0cinpJs?=
 =?us-ascii?Q?+qa45COHk4hM37Eg0VW7QrGbyqT4G/mM6Ygd7LfcSFWKZBiEuP3o8FGp5UVk?=
 =?us-ascii?Q?hAs2ityLTv9XJCFmiweJdZF+1nz7O8g9PzCNpKDp8Lzk+5BwvCtuWveQPkPs?=
 =?us-ascii?Q?nrXDjoMHuGykR2dM0HZqCKNEaaVn2ykuQ4YBySJ1lpODSzzGXrZPJtddMDSA?=
 =?us-ascii?Q?lI+c3+bRVnjRzEpL4BiMI9QjL91Ay2WtaqwqnQzseG4dkueXC02VhkWd8Ro1?=
 =?us-ascii?Q?eMrqqowG9XLCd+1dMEKtfQkkXY2ry5Pf6j2uQrtk+xG0vZgqgdQdD8MLm6IO?=
 =?us-ascii?Q?oT4G37dpzG5HsaI/VdMVisZpsEO77dAaeuvwzWnG7zABwxmHoL6GkidWTinR?=
 =?us-ascii?Q?ZdSCCslNZjmhPIpJLJBn03TSrwm1Vl1R43+cOm2eBrrNlLqu4oJG08HtuIw0?=
 =?us-ascii?Q?txtfmlRQ8xK9+iIR6nq2ZtkxxiVzXeptu5zmzD52YuGzDcYP6pI0f6seXcKa?=
 =?us-ascii?Q?ydWlknbwkTves7ooJzFIpOZ0U873nxPBMPNXcJuGudeUJEPDGnTXNB32ghVW?=
 =?us-ascii?Q?qcfwi6dIyGcyaC1RRQOjmlIzB1ZOkdUuxy9jOzdWPThPAikPKxpBfeGtEzSc?=
 =?us-ascii?Q?9xOyfh0F3cCNTfWt/q5KilwHjGVIMw1eb80Gn7w9hhbeDBEiDFs7jThVo8vd?=
 =?us-ascii?Q?IccXqkzGKEChPE4K79bT1JZlJw8WMYh+PI1yw5++TeKDOkmoVgcevvFXmixx?=
 =?us-ascii?Q?5u0B4LxwTt4pnDnRKQnvIOQ3OAI1VeTsggJTllKY+YC9UoonKJJr6Bey6a1a?=
 =?us-ascii?Q?ZhOZYLXFz+XyxIsgrvL64DkxF2R/4EOfh3K4r13svFgN074LEjRFEK/RvPvV?=
 =?us-ascii?Q?vg8gyuMTrsTWpXtWO6v7+wUClkoSPQ2yW0lZmPP16ejhNv+WpdxX5QqEQVbd?=
 =?us-ascii?Q?QtSS2lTW/DdCUfUTb+rv4+GBkzwVeb3XVFwyczLwDTFwJf/h2Gd3K5xGrqrc?=
 =?us-ascii?Q?rLCxTXWP3EmycpmnQQZIqwNKebWO6dfF+gSneF23Nx3DMO1Yt745DN2RI0OM?=
 =?us-ascii?Q?1B9HMbtLg1CtciYld5egwzAKbEDQ/Bfv9QKn/9YnsFNn74XKZLSoIRt//fx9?=
 =?us-ascii?Q?N6VUj8gVvTECYo+Ta/U6993I19hEdAjJD5LBFwtMbFrS8n1pUqWpbszZczE7?=
 =?us-ascii?Q?hQFPTns4FRr33T6SKJrSR1DNUUGhzdC1zpRMLETy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b64e4-5c7e-4ead-0b7d-08dde9438a44
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 10:37:25.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZAvSV1byZ4iN41aKtcrFNZRgfEhJwauRKhtwKVnLAvinlSpxTLx0iNE6UlDPgI6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11304

The design of i.MX91 platform is very similar to i.MX93.
Extracts the common parts in order to reuse code.

The mainly difference between i.MX91 and i.MX93 is as follows:
- i.MX91 removed some clocks and modified the names of some clocks.
- i.MX91 only has one A core.
- i.MX91 has different pinmux.

---
Changes for v10:
- add Reviewed-by tag for patch #6, 1.
- add Tested-by tag for patch #3.
- modify code comment indicating that imx91 is a required property
  for patch #6.
- Link to v9: https://lore.kernel.org/imx/20250825091223.1378137-1-joy.zou@nxp.com/

Changes for v9:
- rebased onto commit 0f4c93f7eb86 ("Add linux-next specific files for 20250822")
  to align with latest changes.
- there is no functional changes for these patches.
- Link to v8: https://lore.kernel.org/imx/20250806114119.1948624-1-joy.zou@nxp.com/

Changes for v8:
- add Reviewed-by tag for patch #2/3/4/5/6/7/8/9/11.
- modify commit message for patch #10.
- move imx91 before imx93 in Makefile for patch #6.
- modify the commit message to keep wrap at 75 chars for patch #5.
- Link to v7: https://lore.kernel.org/imx/20250728071438.2332382-1-joy.zou@nxp.com/

Changes for v7:
- Optimize i.MX91 num_clks hardcode with ARRAY_SIZE()for patch #10.
- Add new patch in order to optimize i.MX93 num_clks hardcode
  with ARRAY_SIZE() for patch #9.
- remove this unused comments for patch #6.
- align all pinctrl value to the same column for patch #6.
- add aliases because remove aliases from common dtsi for patch #6.
- remove fec property eee-broken-1000t from imx91 and imx93 board dts
  for patch #6 and #7.
- The aliases are removed from common.dtsi because the imx93.dtsi
  aliases are removed for patch #4.
- Add new patch that move aliases from imx93.dtsi to board dts for
  patch #3.
- These aliases aren't common, so need to drop in imx93.dtsi for patch #3.
- Only add aliases using to imx93 board dts for patch #3.
- patch #3 changes come from review comments:
  https://lore.kernel.org/imx/4e8f2426-92a1-4c7e-b860-0e10e8dd886c@kernel.org/
- add clocks constraints in the if-else branch for patch #2.
- reorder the imx93 and imx91 if-else branch for patch #2.
- patch #2 changes come from review comments:
  https://lore.kernel.org/imx/urgfsmkl25woqy5emucfkqs52qu624po6rd532hpusg3fdnyg3@s5iwmhnfsi26/
- add Reviewed-by tag for patch #2.
- Link to v6: https://lore.kernel.org/imx/20250623095732.2139853-1-joy.zou@nxp.com/

Changes for v6:
- add changelog in per patch.
- correct commit message spell for patch #1.
- merge rename imx93.dtsi to imx91_93_common.dtsi and move i.MX93
  specific part from imx91_93_common.dtsi to imx93.dtsi for patch #3.
- modify the commit message for patch #3.
- restore copyright time and add modification time for common dtsi for
  patch #3.
- remove unused map0 label in imx91_93_common.dtsi for patch #3.
- remove tmu related node for patch #4.
- remove unused regulators and pinctrl settings for patch #5.
- add new modification for aliases change patch #6.
- Link to v5: https://lore.kernel.org/imx/20250613100255.2131800-1-joy.zou@nxp.com/

Changes for v5:
- rename imx93.dtsi to imx91_93_common.dtsi.
- move imx93 specific part from imx91_93_common.dtsi to imx93.dtsi.
- modify the imx91.dtsi to use imx91_93_common.dtsi.
- add new the imx93-blk-ctrl binding and driver patch for imx91 support.
- add new net patch for imx91 support.
- change node name codec and lsm6dsm into common name audio-codec and
  inertial-meter, and add BT compatible string for imx91 board dts.
- Link to v4: https://lore.kernel.org/imx/20250121074017.2819285-1-joy.zou@nxp.com/

Changes for v4:
- Add one imx93 patch that add labels in imx93.dtsi
- modify the references in imx91.dtsi
- modify the code alignment
- remove unused newline
- delete the status property
- align pad hex values
- Link to v3: https://lore.kernel.org/imx/20241120094945.3032663-1-pengfei.li_1@nxp.com/

Changes for v3:
- Add Conor's ack on patch #1
- format imx91-11x11-evk.dts with the dt-format tool
- add lpi2c1 node
- Link to v2: https://lore.kernel.org/imx/20241118051541.2621360-1-pengfei.li_1@nxp.com/

Changes for v2:
- change ddr node pmu compatible
- remove mu1 and mu2
- change iomux node compatible and enable 91 pinctrl
- refine commit message for patch #2
- change hex to lowercase in pinfunc.h
- ordering nodes with the dt-format tool
- Link to v1: https://lore.kernel.org/imx/20241108022703.1877171-1-pengfei.li_1@nxp.com/

Joy Zou (6):
  arm64: dts: freescale: move aliases from imx93.dtsi to board dts
  arm64: dts: freescale: rename imx93.dtsi to imx91_93_common.dtsi and
    modify them
  arm64: dts: imx91: add i.MX91 dtsi support
  arm64: dts: freescale: add i.MX91 11x11 EVK basic support
  arm64: dts: imx93-11x11-evk: remove fec property eee-broken-1000t
  net: stmmac: imx: add i.MX91 support

 arch/arm64/boot/dts/freescale/Makefile        |    1 +
 .../boot/dts/freescale/imx91-11x11-evk.dts    |  674 ++++++++
 arch/arm64/boot/dts/freescale/imx91-pinfunc.h |  770 +++++++++
 arch/arm64/boot/dts/freescale/imx91.dtsi      |   71 +
 .../{imx93.dtsi => imx91_93_common.dtsi}      |  176 +-
 .../boot/dts/freescale/imx93-11x11-evk.dts    |   20 +-
 .../boot/dts/freescale/imx93-14x14-evk.dts    |   15 +
 .../boot/dts/freescale/imx93-9x9-qsb.dts      |   18 +
 .../dts/freescale/imx93-kontron-bl-osm-s.dts  |   21 +
 .../dts/freescale/imx93-phyboard-nash.dts     |   21 +
 .../dts/freescale/imx93-phyboard-segin.dts    |    9 +
 .../freescale/imx93-tqma9352-mba91xxca.dts    |   11 +
 .../freescale/imx93-tqma9352-mba93xxca.dts    |   25 +
 .../freescale/imx93-tqma9352-mba93xxla.dts    |   25 +
 .../dts/freescale/imx93-var-som-symphony.dts  |   17 +
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 1518 ++---------------
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   |    4 +-
 17 files changed, 1864 insertions(+), 1532 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-11x11-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
 copy arch/arm64/boot/dts/freescale/{imx93.dtsi => imx91_93_common.dtsi} (90%)
 rewrite arch/arm64/boot/dts/freescale/imx93.dtsi (97%)

-- 
2.37.1


