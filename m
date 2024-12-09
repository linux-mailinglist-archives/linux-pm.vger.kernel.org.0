Return-Path: <linux-pm+bounces-18868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD80E9EA16F
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 22:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B42C18830BB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE56119D09C;
	Mon,  9 Dec 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDlMyROx"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1EB19D098;
	Mon,  9 Dec 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733781210; cv=fail; b=Y87RHteAzFpZseFVokQAoiNjIczF76zEj0dPj6SNrEKZDZ+4PfzVrlNduWzd2Wcp/GTVwW7QPVQvg17hd6tnozgz/XdbftL2UJb2S0n2DjqHSCtr+kNVLby917akAcKk728PiTY2zeysjXgsD7R6ytL+aSDSQN1EojBL46XEweE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733781210; c=relaxed/simple;
	bh=TdqUFbPdGqQO/wjuy8cz2dm2iKACbtfRr/DuDvgfBik=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Y6gtWKF5fA6WKGJJTfPjgM3ovND9MY88VjIgQCuwJK7M9YC1FeAhEzPmOqJ09pLOKgIs/I5ilBrl4JEDGp6AHOa8VfDgvYPCsZtPnqbWiWhxe+DHPF2T9PviJfDL/0yjR5dYKsVASOh5Lc2Y00VYjDt4v5AEM9dCZs/p9EqoCRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LDlMyROx; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7uT8A0JQH0TS+WbRsfyeBfuc0ISmrX86SeuujlZG8CuhMNh3ZcGavDbpbYEhvnHVH5bWCBr7hYTG43DIIgVt66PNJikhlNhE9webC2lzfaY2APGlqWYvFfA0hePBKQgMK2reqrUF3swqasGsYyyWwkwY9ZIipdpPhrD4InAxhPgxo7EZsoT+YhMJW11g+2UFRxukSeZ6te3hCtMlrTq7pwejryh+Fh2BfGqh8mypA0WulFE9fy9swLOZBZZhUipo2dTfWxSxxGwxUiins/6r/m9FO2IAIotXhTvfviiz/Ld4yJ4MMf8RvoPlONDxdnw7j7JJOShPJirAfEcPpy5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvvsKY/t4LGj2egUuUmWTO+u/aIzVt65d5BlsPZLxJI=;
 b=ufDKQukWJfz8zn8/1SqnSe94d/WSLGNsOkdf9hgq07FltzKPK1AGAzG/1TdMLKvJBduLcF+SOo88KKQv1sf3nio2REFNKsoXZHzt+Q4FYSqy0FYCF8QE4X2Ci+dXkgnkx/8Zq8HCDKkgcPlvsJFZFCnG/lDxE1rVmrAeMF9R1LffoNsC1MS+9JzX8KsWFqu1JaaE07+qH+/xsV/f3Y9TZP+M2EOSnhfeFm1miINYPCrc1kR3NBUXr7cMMisRrcENjL5LVc4yEA9CvA+edYTpQQEMNLZx1y/oz52KDnkpaWSB2SHEyUH0LGYWY58hcumAM0CQlqrpxKban6brkBvA0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvvsKY/t4LGj2egUuUmWTO+u/aIzVt65d5BlsPZLxJI=;
 b=LDlMyROxk3pCvhbqduT6T9DYTfq+RsjpvNT3gNBcHmOSowO+YfWaGlV98GdkrO0pSpbdX2wenlrrBHW8776Fiez16tvY1dU/ueDKOppcDdsxFvaV68ZYkS+E3w8Zr0SdbOBriZjKv5eXC7N6bxlSgL71CLeoICdGm6gnLysqOGVr0qMvgUD8imxH/5AktNWm4juAAMX5x8jnnTIF5wy0kgoKWop99rJ+yzsh+hUhltrRI1AWB6gLxvW4VOFemdxlx30gk2PqAb0iOYwiaUqYGnUcPkRiFCEAL4DBIoCmQdVSYoLnqBk/Fk+ea7tP8jsj9P4NjPNVfrTIa87FZz2wvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:53:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 21:53:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
Date: Mon, 09 Dec 2024 16:53:03 -0500
Message-Id: <20241209-imx91tmu-v1-0-7859c5387f31@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9mV2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNL3czcCkvDktxS3cQ0o0TzZAMToxSLFCWg8oKi1LTMCrBR0bG1tQB
 /dppuWgAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733781197; l=859;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=TdqUFbPdGqQO/wjuy8cz2dm2iKACbtfRr/DuDvgfBik=;
 b=9YNO8kwAoXO0emMso069aUpO3rHy6m+GT5AV9DfvBVX2x31saUbxCDHhVbb8+q83Dkqj6payX
 78pLNLiQ9j7Cpuj747vJQ8cXE66nk5rrIiXZmFcA9n0JtEKLON1e9Zu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0158.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be3f9d3-9717-441b-e097-08dd189be68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmRST3dXMmJQOGl0UTRvVUdjVSswNlhnWUo1ME1pUGUvOEdsZkVuSzI2R1NZ?=
 =?utf-8?B?Y0hhRUhQcWU0ZEZOek9ZRUU1d0lLVE1VN2FZbDFHOXlsWjVzS2ErSndBK3Y4?=
 =?utf-8?B?MEpVZy9aaE5hL3JwZmluUzZ5cyt6R3Rtblg3ZCtwbUVKYkJyMjJRWnFMbVdz?=
 =?utf-8?B?T1RVN3poak1VV01aaGpqRmpvd0FjZm9QeUIrbzdsYjZSekdXUXp2cFBrSkhk?=
 =?utf-8?B?bk1pRWU5cXVreTExem9EQXBrbWR2WXRZTjFUazVOcCszWVVnWTZ1TmJ5aytO?=
 =?utf-8?B?Y0lGU1VQR3dpNk9haG5odVZ3UlRPYjQ1bGpMWXhRQ3lIQ25KTm54YzExczVH?=
 =?utf-8?B?VXJtbGIvWG1ubTJCUUh1MVZsVmExM0hIdXN5cFZUM0Era1VtRC80YiszSjJR?=
 =?utf-8?B?eFc4clJhZmh4QUxxaFJpbmI4dnNFQ1JYb2RvTHR4d0NLNWk0WFFuenJXbFJM?=
 =?utf-8?B?eUpsY2RKZUpuVGRILzZJNytCUkhOTHVFYkhUS2JneUkzSDlmb2dxME92d2U5?=
 =?utf-8?B?bS9kcUtWVi9FUnBhcjV6VzB1Q0c2cmEvd3p2MEhkZGtnVWNmR0FENGViMTVi?=
 =?utf-8?B?UUlVa3dtY2p4RmVXY2JHL3hvcGdHMlRWME9lWHMrd0lSTlFhNGc4MU9hejA2?=
 =?utf-8?B?d2ZBaGRnUWk2QnRYNDdLMm5ERjBDSFpBVHVsQ28zV0FuQ0JscDNpMGFDZnlr?=
 =?utf-8?B?N0hQN2kyWDdqMTN1UjgzcGdJeWQwTCtrVEp5MGl3MlBDYU9RcytZT3d1T3B5?=
 =?utf-8?B?d3c4cWlBNi9nb0ZzUDNTaGxhSDlad01DR1RwUlZCbG44VldTdnlwY04rRklI?=
 =?utf-8?B?bVpONXk4WW82bVF1UFo2VnBBRGVnMlFZcnVwNjRYYTFEVlRZVTV1V3RrYmRY?=
 =?utf-8?B?WG9IU0JlOThORC85aEF1b2IvYkEzWUFJM3ZkZFlZRGtDRkxGZkppVitkQnkx?=
 =?utf-8?B?WERuV2xoL3hsNy92cUNLVzAveWovWnNzNVFrUUpQU1Rrc1VLdXM5aTV1Uzho?=
 =?utf-8?B?OGtlWFZRZVNWUDBtLzI4WEhqVnR3L0pHamNOcDRXQTV1Vi9oaU91ZVdHdmV2?=
 =?utf-8?B?TVBScUtWVDVoZmN6UFlBekhqOG5TRVp0Ui9QejhDazJEb0ZyTlU2TjNPRXhE?=
 =?utf-8?B?WkJGaWxOQXBzcGdKaXFnMmExKzYvY29YM3p4Y0RlazJaUzNtR0kyNUp6OGdN?=
 =?utf-8?B?Z0ZVSktLR3hpMkM1UXNYQ0wybjNUczdCKzlKbWJMenpjeEcwYVJROUF6UXQ3?=
 =?utf-8?B?czRiSEpDTU5KTFZ6N09KcmZYZ2RBRzhKNWNrOG4xcXN2RmtCYytMOFFNQzVa?=
 =?utf-8?B?SU5nQ0FaOG1oSVNOLzcyQ0NEU2NMWHlYYVRmNDVjL3A2dXJmQkpFeGYzQW8z?=
 =?utf-8?B?WUp0Mkp4QngwZmZBT0ZOZ2hTSkZxZDFDT3FacXJKL29FK3Y4UFA5YlNoOW5J?=
 =?utf-8?B?d0g4UzBiQ3MrcDh4cEJpSGZZeWxVZ0NlcERLN0hwcVJJRkw2QWswdlA5enV6?=
 =?utf-8?B?YTdVY2grRzM0aS9EeTJvamh3MjRtU1ByUGdKN1h2Q2RwZDBBYlZDWkl3WUhn?=
 =?utf-8?B?bVRwNGNOTUx5dm1vL3FZUlhBeTluYy9pVG5LTHhxN0FoUVgrSmJPdURjSDFM?=
 =?utf-8?B?WG5qVmxpaTVoUFVXdW9nRmNvUld3N05jKzNGYTJVbDZiR255Z2Fiand6cmdt?=
 =?utf-8?B?ZXN2UnRPWlU2Qm1uVzliVmNjYm50aUt0UlhqMnVqYWhjRnI0TUkwMHBoeHlI?=
 =?utf-8?B?aXBGVmN5TVMzWUxzN05CWEhNSUdUU2RuWlEvdGNRbmVmSlVjNmt6R0xmQnh0?=
 =?utf-8?B?a2pDVFhPSHN6UktLT0pkZHpQcGxIM2ZLaXNKOHhhaHJlN25ySENDd0JRYkR2?=
 =?utf-8?B?T2NWVElTZngwUGdMVkkrb0pVS09sZ3oxclZwaHBzUkdGeCtEdU5xU1AyWTNQ?=
 =?utf-8?Q?LViTTXua8bo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFWWUF6WG9TK1Z2QTZBUTduRGhvZXJ3NDdiajlXTURITHNLUjFwSHYvclZ6?=
 =?utf-8?B?RHZwT0dnS1E4c3lWM1BaaHI0cVRUckJLQmhoK3BuYXA2U2ZrdVJFWEpDQ0Z3?=
 =?utf-8?B?VndIcGdtSjBwdkJuUEtZaitvbHdlM2IzMnFweWIyUEZHTDJXdUYvdUNiWGVz?=
 =?utf-8?B?SzdYK3U2ZnRtWGhCV3BHNkJVZVMwVDc4Yi9mZ0ZuOEVTbEZjSHJCOTh6bGpm?=
 =?utf-8?B?a2x3d0VCaDlTd3ZsY3dNMlc4VFk5ajdOMTZydlFtdXlVWmV5SmxCMXo2SXBN?=
 =?utf-8?B?amMxNUVzbFI3UW9QUXRTUmVuZWlZeG5vNmhWc3dDVjhZNXIxQjR2ZlRYY1Rz?=
 =?utf-8?B?Rjl1TitKdm9oUURWWVk1b0NoeU1NNmFLbjZPdE9kS2tOa1VUNUFjUjBjY3Vx?=
 =?utf-8?B?OWx4anNmMzh3MWV5Z1ZXcWpSaXNTNkpzOVFldnhPbnVRU1EzL0xMODRGMHVh?=
 =?utf-8?B?T3FzNFJrWG1GcHBUT3dJdFVlWGRVZ1JUd0Q0cWVBZHdnbVJXSVhFRnRBNXdn?=
 =?utf-8?B?Rld1UEFJQU84Snp0ZVZyZ2JmRXBlRUR1MTdXS0t2NVJqWWt4VUhTMDhKZmIy?=
 =?utf-8?B?bG9ZUnhBMHZIMWo2RWdqL0pSajB5bUNsUWYvamltRkZUcVBxSUlCQWdaRk1Q?=
 =?utf-8?B?M3UzWk5uV2xxS0dZMzJ2bmswVlByWVRHQ0NOZkNHV2o3cFVFR1VBZDBJTytT?=
 =?utf-8?B?bExwdDRsaDJhdHZvNGtkUG5YTG02YVRhLzJaeWszTTRKbC9EbW5iVERxY2tq?=
 =?utf-8?B?TWY5NU9tdWI0bEsyQnVXbTVPc0NySk5ETXlINEpRT1I4MHpTNzA2R1FDRURP?=
 =?utf-8?B?a2pMS2tScXFiK1FJZVQxNFdhU0p2b1pnUjluTTU2anpDK25ydC9wRFRhak9o?=
 =?utf-8?B?cGl0b0ROek5jZzcxd0hESWEwbjdlek9MWmJVb3ViQTI5dHU2SHFBZ3pMQUtY?=
 =?utf-8?B?M3pGbVlialdTVko2blg3WksrNGdXNElTb2VNZGJEOGI0RjVZWmxqWFg3MHdp?=
 =?utf-8?B?QmtKc2JkbkxVRVpNbm01YVgzdGZ2dGtya1drRVFXTWRpRXdBVVdoTHVCY3lH?=
 =?utf-8?B?NG14cSs2NFErVTdyRW5DYnhaSFFMK1ZCdThSendSZ1Zua3MweWt0RDBoQUR6?=
 =?utf-8?B?SW5OeEMyVTlnZW1zRjVxdEVDNE1vUnlXcDdoOEx0MXJIWGZOU0NaeVZBZnlM?=
 =?utf-8?B?aG5ESE1wVmFiS01ZSnZ2bHFOS1E2WWhIYUc4WWN3RkFpU3VZNkVFNVdKWlNq?=
 =?utf-8?B?TndKTTR0d3BxVlFreUtPKzJxV2tJNUgvTlBwbktlLzJ3M3ExYTBwZ3k0ZGdn?=
 =?utf-8?B?V0tnT2wrNUI2YUFib2NVeXlLSEhydFNvYk0xU09JNFlQdjdTUW9hd3lXc1Jr?=
 =?utf-8?B?NEV3bjkvMkNFdkVJbURNUXd6Nkl3VFcwamlWNGYxRDdyeEl1emxlWjZqSDlU?=
 =?utf-8?B?VnRYSUZzZkpRREpUSTN5NFNvTFptTlN3b2ptV0ZYU09HY0ZpYWp0aU1oMU1O?=
 =?utf-8?B?SnRVWWdjUGdrSG5Sc1U2NmxQZ1BxOE5USlZBL1hGOTFGWnFqa1V5eGw1UGh6?=
 =?utf-8?B?Sm02WEtwRS9VRytGaGNkcEs1djlYQW1UcU5Nb2tBajNNUjF5UXUvTHYvK0w0?=
 =?utf-8?B?aGUzcEI4cndaU0dWL2haNXFPa2ZaeGs0SmZjNUZIUG5GNnBFRG1EWEJHKzVZ?=
 =?utf-8?B?ZjJybVVhMHNKSnNQZVltMTBaZmEvbzdsRzg4NVBOd2hvdm9QRzFxWWVCbHVC?=
 =?utf-8?B?SG5La2ptSmpGRHkwUnUwanBEVUVJcFYveTE3enpmMGwrVi9mOXRjdE1wMi9T?=
 =?utf-8?B?NkhnQjJ3OW5oUzdTcDZwb1ZmYVFpNVZPSDBsSHVDa2pML0RKWlg0QmVBbElU?=
 =?utf-8?B?bTRGN1pJOUlHZ2NNNUNkaXNLZjdVbXB5a3QvZ3htTEpuVGlNNHQ3RkhVNG5R?=
 =?utf-8?B?S0JuT2tUeGI2dW11L0dMVnNpeStScU9KczhrRVA4SE9KSGlLam1BZWZ1NmZt?=
 =?utf-8?B?c3B6bnNvWFc4VEc4THo1WU5hZ2pkZnI0Mkp1bk1VMXNOQmhzNW1hQXRJZE1n?=
 =?utf-8?B?ZFJpdUJUaWRySmFDU0VPTVA5dEdDaTNsTi8vaTUvaEJGaklHRFpQVGNXZW1l?=
 =?utf-8?Q?06Tg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be3f9d3-9717-441b-e097-08dd189be68e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:53:22.4626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjx9mKhr+7+O8vlLYG+nNAZhVoLn4Csa4g4QfcZVPOfYB9kYqHD8jyj8CY4nNVkpR97MIkmynblMYq4fwOlpHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

- Add binding doc
- Add imx91 thermal driver
- dts part wait for https://lore.kernel.org/imx/Z04W5chGq5TitB9f@lizhi-Precision-Tower-5810/
merged, so not in this serial.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Pengfei Li (2):
      dt-bindings: thermal: fsl,imx91-tmu: add bindings for NXP i.MX91 thermal module
      thermal: imx91: Add support for i.MX91 thermal monitoring unit

 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml |  65 +++++
 drivers/thermal/Kconfig                            |  10 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx91_thermal.c                    | 281 +++++++++++++++++++++
 4 files changed, 357 insertions(+)
---
base-commit: d07c576946b2bc440d6d2073998023e8a0bd7568
change-id: 20241209-imx91tmu-af2a7c042d8d

Best regards,
---
Frank Li <Frank.Li@nxp.com>


