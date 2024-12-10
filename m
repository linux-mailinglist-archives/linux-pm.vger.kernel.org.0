Return-Path: <linux-pm+bounces-18952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA799EBBD0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 22:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A0D284FE6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68C23237E;
	Tue, 10 Dec 2024 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JJc+OSj/"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FCB232368;
	Tue, 10 Dec 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866050; cv=fail; b=W+ZhSwpPgiyZ8h+URjg/KLKSH3PvzamctTrpGDbL5GzAE5MgaoNshT8cQV3HVxAzBrpPYsH63p+M1XynqZ1rAeDIFnYMTzcL/hcDMf+u+Yqp8jH4VDIpZaZWKRXlKQ2mjBoetNYv24tAhBIgFhUGaA2TqKd6bwQXPJSauSfqZyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866050; c=relaxed/simple;
	bh=r1D6YleI4pfbRMudJcC/mpaiq45dCNo3RsDTZ3TyLf8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jJWZa7HpO2F+VSsY8t7b+jkN+qA8v2FemxfhHV3AsF4K1iKNZi7u68CwcYFimlY56E5w0TOB+mu07Yeum97e3Z3pLW6Uvlxq38hF5vuC2V3epILyGFiIahnyVhSQG/CtR2ZO2k9e8tAonAPWRRd25oQ4PWzaP+xwKvTvKCsU604=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JJc+OSj/; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbjlfOCYQTPmFKL1Pv3M/6PW45AFeLgQxS6x6qe5EkY0YpKPBuuZPiDtjR6xPljzAZw18U+wqqNRHDaDXkPLvK3K+tRk15RXLWabYHP7tiTdda+AIQRKKZGN6rAPilNCvdnwX3AeEKg22Pe2/XkfTD2ZpULMgd7v5BrskVsCMx5eh1YLPNuATfohJgCdaZ/zrpN7CLz7zNzOfcPFKgwGEbKheCWVH+YNGhVAlSE3yoI/D4mScf0s1uozdJYTF39VP958pclrOEEabKU3CyT5leMaRMW9Si2JQUUnpmS4RxSbaLdxIe1Yq7hF3I6zgj/hvJazCpZya3DG3N8+aXXDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UwDRaceH7GvnQ/QxRniWA3dsOW7A2WQ6w6+nm1UCs4=;
 b=ko5p34okMZNFNCxUikhWNkddrDKcJKN1R4lAJEUTXfsjfBb3Huko6FZ/FUKkGJOwwc4C1bSfS2828KLG6JXbRwR3cgYzm015NaZplXF8Mc22mZcjQZ5QnsfQZQo6A2ppmcys61hsJeiFA0U/J0+vrmsmoGeMXq4sX9OSx4wWMse23etjd+J8h467migRbJKNwQWfTp8xY8GLeNj9TiyU3GLjao+lizw9kGKyWcpSySwfdchIRbw8b2+2lrg4cVv4G1DRTr+hQ6KPuUtk4BFySlkgDLhrBoLzzqZeL7pe9pHu3lTXJGiXKa31wVgvFka9ojEuzSs4Jo/A7l+AC43sTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UwDRaceH7GvnQ/QxRniWA3dsOW7A2WQ6w6+nm1UCs4=;
 b=JJc+OSj/2mdPknoMpbETsXuCl33bI+ML4sxO6GwunJABOqhPDUbjeRy8lPcjpiHAy/udXhOD/sYNYyKv1tA7HuUH+BIlyk5YvqOE1+g9Rl9Ra9fSmwnEjvLhCWwpovo6nTULCwr7uNDaCZdJ1hFPaxCgnbZbhxqgZQbxupx1axGz4a2NA3XQSdaRdwVQplG/igZUprAp3K+fgw73AzY42Gg1EOZhP7WV0Z3ACB/BT8zHuCWyCOCKOkTvPCbEtvMxtkZMIkEsYMm+VAqK8DzA1d5jpK7nbCYZY/QkDtfSEyfHNg5p4Yk5PMMvT7AY2H23gRUDgvw6h5z7eljQ61Ky/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7550.eurprd04.prod.outlook.com (2603:10a6:102:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 21:27:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 21:27:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 10 Dec 2024 16:27:02 -0500
Subject: [PATCH v2 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-imx91tmu-v2-1-5032aad4d88e@nxp.com>
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
In-Reply-To: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733866037; l=2218;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iVQTtCNDQDMEk1P8NXmCJ6s4gReJ2DPWuwpLblkVduE=;
 b=rNb9Ka3yqYp3yTiT2byc7uTGso57JLa+SycObjqKs378GeRKCu77j8YJwHGP7cJtYPN4fQ/i+
 CYnpF2lm90UAmTVE9rmtPFRU0db67qHDdPD20iBtJ4v5FMSMtuKTiNM
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fe0484-095d-4415-bfc0-08dd1961715d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UDlzNGVTU3dKYnQzaS90MHZXK0czVXhaYTJrQXhWWHlWb2xRa0RubFNmeldq?=
 =?utf-8?B?d0duNEVScmN4ZFNWenlEM09FWUhUWGV6ZlhYOWRlOUxpTCtkNGFHcFhYSUx0?=
 =?utf-8?B?QmhaY1FkdiszS21NdWJqdUFPaHNueGZubUtCdjNaWlJLOUdCOEZLTXUyT3NP?=
 =?utf-8?B?YkdVcFljSit2QzRkL0doQkRvME1DYmdxbUNoZkE2RkVvK252YWdJNmlhOGRm?=
 =?utf-8?B?TnEzcXM2MGVZQ1kxcWIvb2Q1eDZZS0sxWEhyMHF0Y2ZacytVcFhnQkRtbXNs?=
 =?utf-8?B?emhMT01lQUJIOGtYaFpaVWJPRHZtc3RWNDVoVnJESjNxMjhwa1dQQk40OTNQ?=
 =?utf-8?B?dFVjMFhqMzRicTk2Tk5LbTF0RW1ERzFacnloaHNmd3ZhWTRJNkJESTZ0ejhW?=
 =?utf-8?B?aVdZYW1zU2NpMFd4SS9FOFlzSFdFbVM3MXl4OU9McFFOVW9SNmxyVFh0M054?=
 =?utf-8?B?cWxHTkgxSVBtRXBxR3JISWM4czJsTldUakVkVEtaRmpIREhkZHMzQ2ptY0xn?=
 =?utf-8?B?bW5HcUhObCtLbW8xOGU0NTFoZG5jN2puZVBqZmVJVjJzYTZnUEhzRVM5YmU5?=
 =?utf-8?B?SXU0bjNjVUw5RGcyZTRiM1dlRThrWUp1OFdGbE84ZE5ha1pseVBmYWZZNzZn?=
 =?utf-8?B?MW1DSmZGUzhWNDhFZXlIbU5vY2Z3UmpWTUQrS3EvRlJpTTlUMnorTzloeTIr?=
 =?utf-8?B?OWp1dTh2RTJBQy9yMzBrYjdiSGF0eG1Cd2NvMDkvL3Rqb0V0bXFYaWY4Ym1Z?=
 =?utf-8?B?ZnZ6a1l6VlJhVDZKQW42eXFKN0gybmIxbEdLcEhZSXpGeGwxdmhlMjVzaE9w?=
 =?utf-8?B?WjlFZWxOeE5IdHY3UlhRbVRCakJXUjlHaWNXUVhiMVM1THcreG41OEs1WmdH?=
 =?utf-8?B?RGpTbHdsZ1ZVT05lKyt3cDRXb3BBbTRISDBIdUR3NGJQc1Zmd0gvUkZlR3NY?=
 =?utf-8?B?d2V4eHVYMVRoVmI3TEozNllORTFxUmlqS2FtcTh1Q1JCeUVWeTAzWmFJZFpy?=
 =?utf-8?B?MjhiWXZ6SXlFcVNXOFpGeWpKVjZ0UDNFYXhZcndmS0ZoaWowQjlSdTVYcTVo?=
 =?utf-8?B?Y0lMUXFudlJQL1VkbVp0dlFUdThzQjFPNnArQ2R6Mi8rZWVYTUt0NkZtUEs2?=
 =?utf-8?B?SDZ4d0U0dmlwa3dMdnRqVDJqYmpVR2RxZHR2U3ZSUWY5bVEyS0pHdk51OStM?=
 =?utf-8?B?dnN5eUl5Z2dmWVRCS2tUcDVDQW5iMmp0ZWZGU1kweEhMWDh3azZ6cVRJY3lG?=
 =?utf-8?B?VnQwcG5UZFNEZ2V2Rjc5QkUzczFPc0hKNWhOKzIwb2tSOVVZRFRPQk1QcWIr?=
 =?utf-8?B?aVRnT0I4NVVOempMMUN1OWFLZzl0bmZReklSc2Q2UFZQS2s3K0kxR0hpaHFo?=
 =?utf-8?B?bGJzQUJaT2FwUVIvcmltRjArZjFyRnQvcHQwdU5xczZqWWtSaVJZZ09JZnJa?=
 =?utf-8?B?UGh6di9oODlIZ1JvTC81Z1NjVmFzamJGREp5ZDRYQng3TFpRbythN2NteTNS?=
 =?utf-8?B?UjFNQWRBd0dpUmZRNWxNSFVvNUhkUXRkOTRWZ0t5amdSYWx6cTMxR1dzekl3?=
 =?utf-8?B?M0I2Y1BOS0VyY2xtcTFzQWNSd1RUaGtyOVI4SW1UVTU2T1o5NU9uU1UxM21C?=
 =?utf-8?B?T2lyV0FITGQrUGMzNU8yc1F1NW9pMFRHQWE4SXBLa1NHbTduTWdLSG1Welg0?=
 =?utf-8?B?a3puZndZdXUyeGIzL3pPTGt3R0xMdThWNjdUTXhjdWpEVXdURTFETEU2M1ov?=
 =?utf-8?B?eEozaThOaDZVM3V3MEpERzJ6eVMyMDA3ZXc5OWhPdEpzUThtY0I4VVVwdjBu?=
 =?utf-8?B?SXdJTVl3OGIzbENjbVVvRjJQeGVLR09odEZzdmRqUXNhS1Q5NUpwUjlQN09S?=
 =?utf-8?Q?kmKQMEJdI5iP/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGV0dk5McW5hcit1SDNZcDlXVWVxL2kxSEtFK29aNGtFNnFRTjJ6S0pPektE?=
 =?utf-8?B?bFhkWlJ4aFhBbWpDcG1oZkdLMFZWK0dTYjJBdWZrOFZLYytXbnVNMVBzaFZE?=
 =?utf-8?B?VjRLMGFQSFlRT0tlajZqR1E1RVRIQU1JWFBkaTBKc21mSG5tN1pyT0pnR3ZK?=
 =?utf-8?B?WklBaEx2dHlMcjZBeUVLT256TmpIT1FJajArZkVCaUFqdGlFQ2R0ZU41UHVH?=
 =?utf-8?B?MGpGaFh0NXZuS09ZeHVWdG5veWlkVzJ2R1Y5dTFUNmdEUWkwblJFYlh1a0Vp?=
 =?utf-8?B?MFJvR0NCK0tKMGUxR2NoNVpRTnM3aEhEQmlLRkd6UmRlZVg0cXVNdlpPZEJw?=
 =?utf-8?B?dG5peGZGU2NDbUNlZk1tTEhxQ0t2QlRQYjFaMm5Qb3Rxd1pSbTBIWW5oclk5?=
 =?utf-8?B?eTVMNmdRcGdxL3FYdmRKazJFYnRsaTRuZkFXbHczNW9Nakp1T3UvQmpDVkxB?=
 =?utf-8?B?c1NCVFZWT3VXVVNPYlZ4Sy9kZGZhaXMvTmRsNGRRTUZDRVpwUkhSWXRKNkZK?=
 =?utf-8?B?NGZIMzFhWmpwb2dBTWNtaUQ0MEhJc0lIVHdqckVBZWRkTE1Xb3B1WU1pWUlL?=
 =?utf-8?B?a0JDMm9XelBvYkZjWHU2RmFnOW5jUUp6VTNzcHFwWmN4cEg1M3dxanIrL01M?=
 =?utf-8?B?U2NJOCtJSVcwd3oxbm9BcStPL21MMTFGbG5kVWdPWitMZ3FURFhEdkZlalg0?=
 =?utf-8?B?blhQTVJDTXVSbktpbExJeFo3K0tRNlNodDNYdWpwUy9rQ3EzL2JKejRBdHJv?=
 =?utf-8?B?Zk5BbTVmNklFK01GT2FwM3EraXJOWkZFTDhVVk80QmRnc3djVVlrbmJTcEFj?=
 =?utf-8?B?OU52UHBTaGpvSWhGOUNMTlZYbFFoR3ZJdGsweVQwY2F6Wm5td0ZmVUlJVXRS?=
 =?utf-8?B?UlhoSUE4cnU5T0ZYUGRjbFNjTjlOVkRzOWZ5RG1yenRCdUtITVdyTml0Qjls?=
 =?utf-8?B?QkdBU201di82YlRkWEdISFI2enFsR2pyY0hyb2RGVzlMTzg0RUZFRFJtaER1?=
 =?utf-8?B?am83bWpWcGx3RDNSbHJ3TjVGeHNacDFGWW9XbFMzMlBCTmVDY1VLTkxkSlVQ?=
 =?utf-8?B?MCtSYWZrUHA5MWQ5UXdvR0dRNTFBNUs0aDM3aGZuclNJNmlyNFdlN2gyNXY4?=
 =?utf-8?B?eXorQ2NrNC9BUmFqTHprWEtDZ1dVNGtXejMwdU1WZEFxVG1yWTd1TkpCOEJJ?=
 =?utf-8?B?aGh3NVFLRHBXb0RNbnBreDdmOXcrSS9sb3lVc1dLdXI4bHFHV1grLzUxeDA0?=
 =?utf-8?B?SThGZlU5Mi9oK2toV3pqUkRwaVViVUtCeXVuSytXa3I5Zng4TGZ0cXpMSFZ4?=
 =?utf-8?B?V2IxRUwzWjlwRktSYncyN0kwKzRlMkdqc2hNb3ZlcXNxQ1Fqak9WcjlYalJx?=
 =?utf-8?B?R1JWRmoxYm55VkE4dGFrdzZpYzM4anlYN1RmR2srYXlYZWtNOGhaSzYzQWdE?=
 =?utf-8?B?a0prOW8rUjRwaUdrLzBNaHdsNlJEd005SERXSmR4U1J6WUMva0E1WXlNMC8x?=
 =?utf-8?B?eHE1L3J6cWE0QnlZUVIxanpsVWZWaGRlNjBFRWFxMEswbzVIT2dSdVpBbzlG?=
 =?utf-8?B?VWk1N1ZCZXJ0azh1bjdWR1NUb2dSazMrcm9KbWV1eldrNkhxS2xyOXFhMXRT?=
 =?utf-8?B?RnRzWEx5OTJKNHdpSlRpdHQvWG9UbEpZWExmZHhMM1F1QjJ2ekFpSnRMZUZG?=
 =?utf-8?B?RG9pRVBmUkd6dVo2LzFFTTRoRVVSTE5TamJicDFmTm8vYW5kODczMEROTEZj?=
 =?utf-8?B?Y0FoTTd6LzVmVVhnVnhUU0pldHJKdm90NWs2N2s0NTBQSHJxcWNpOVR0NHBM?=
 =?utf-8?B?L2lSTDg2T01IWVhORUVBNlliMm1mS1QrZUVwc09DNHF3L1lFMGZqOXpOQS9u?=
 =?utf-8?B?UVVSR3FCL1VjNkJPY0tmd2dvZUpFZWVqWjROcGFzd1pDMzhUSVNCUVEyRllk?=
 =?utf-8?B?ZG1qUnI0VVB3L2hQQjA0Z2VtUGxWSy9Hbk5VSzdmVWFXTVdiWlJWVjlReUpt?=
 =?utf-8?B?c3lkV1FPckxFci9NTjVjSEdZQ3pNZ0RtVUwxdXkwSkVQUmsyU3RHSEdqWmRH?=
 =?utf-8?B?dUw1SG1XWWkxUUZGOWs5NVlMa3Q0enB3L3QxRTdGOUIvMlY5OEs3dG9rOFNM?=
 =?utf-8?Q?gJ25B6gNtDYPBXY3RdiMJpetd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fe0484-095d-4415-bfc0-08dd1961715d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 21:27:26.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ftYrw2OXEbMpfkDajQxnQcc0G+OwUfKeL/QWbE3bjbJXatq9DAjj0IT4h+d59hZoIMOuK1UBuEo6Cyq5cehsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7550

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..f5898db1006c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


