Return-Path: <linux-pm+bounces-35140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADED3B8EC66
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14013B7EF0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF672F28F9;
	Mon, 22 Sep 2025 02:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mro3vh6b"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE172EDD7D;
	Mon, 22 Sep 2025 02:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507704; cv=fail; b=CAiS51CV5o8oYWIsV8wtmXxlI0OcnBtq4Uh/AeO/PPjURl2eUzqr0l2veN1fKLRA2gUyfkSb12dhZ0EydKP23gwY7GN9N62Zo/SNgQpw7NY+6f1RdbTm3eZft1J4O6dAjai3dMi1vhU3iHkhy/K+SWeE+9BqaEKfGjtnk5M2N28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507704; c=relaxed/simple;
	bh=gSgvNMd42cS1yyxNbbqlbnsgCXM/K7jY4R8qzJ0uIMk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h+L2I+YbiKQTjSaDkI2pyL/d24yfgVWRozZkRUNYmAKzgfE6JFO6NA/NTNHvR5hPV7KVUR9xczs+zgqmTYhwIFiyeImW0TmhiExJJV1FEaoWA5UJawzGkTRsdjz3WpzQfqGo7jwx4m44umlN6KPsgW0/V5e1RCQ3qHLAEOab46o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mro3vh6b; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jd2D7EQ59m3KmS/9boZ3+6oLw2x9vb63BT22wgJEpTiJFsGNRMLmEGGJoKMWNh+ccecmW34p9KZE2r+xlvhWOp4oYxOAJjrPzkLTJ4DbeHrwXGyC/gHA0T0I7fM6AZ7yti0Xw57ibgf0387Tw/2CzTbn4nqg83tl6UnX/tyQglpcS/JOLaJhauqx8tIdjr9GA0kvTa8hxIPRTNsVqwrwGjmRAnc4P+SgeXjTYfZJ7JKyGDxv5/tzUsXwPWMVmcCnnCoWB2KZfoQL7RkMvBZo/T33ey/mjP7CJUtFP5ie8g4N6/tKYa9dv/NYLpLRRblO3rlS3wPWFWKQ6Xv/nf/0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o5eAQMrSMjvz/rfMDAfptXhUch6sz+PiGm3mZGh1bw=;
 b=AI4gyL826m2R4wPowIiPSEo/o8XCf3tTSNQa5+XXAS6qSXI787rj43rXHhCrcQfdkSj8f3NtCrafR2ZX0D3BO2IZir0nR8yLtDVzwU68/VXNG/oGmZnYNXClffPucznJSxO+xfcQ359C1MhW1OI0cUaUj9h9C/AoGpjitL//HlVdW0NvQpiA7rXzlHXFHZDPRhXdHlHENaKOfWzI1eUn0mM2hV7RjAvgYlGnStUGPZ7Yb4Qvk76E/NXRTT0WXSTBqtNnhyNk1vPAzA/1kmdXhwYA1uWz8ilBCT9xeKNL6+6lYqUn3lEXb69Ng2ysVrN1/hUR2H/WtFGYwoIKMdBOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o5eAQMrSMjvz/rfMDAfptXhUch6sz+PiGm3mZGh1bw=;
 b=Mro3vh6bjTk+HLV4HeNK1QDRgV7l9M6XTM+3WdRIX3UjF6GJkpTQQS0tBpGyBuQO4kIX9guE/PlDsBIVBaZ6UVwVN95QA1KcrS+2cOrFNaTYVxEn/2HdnM6ryIP+Xg3ZPFvfs2Ue4h1VOUTKOgL1XY/EY86deYfkCl+x0uQ1LX4mk59Rb6cAKrIUNoRhCurX50CmkvTV6s9dgnID6WUn1Y4MwgEXlurdOY5hY6eENuea0bYyVhLJVDPSB4sxGYgeTaL/jLddphfdACplYCKSyxZTvri28pIueGiBRbG+ceQWQpYgl/ZIOUTMDHF9Lspm3hlcbed6+SA4feVLaLxbRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:21:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:21:39 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:21:08 +0800
Subject: [PATCH v4 3/5] usb: chipidea: core: detach power domain for
 ci_hdrc platform device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v4-3-ef48428e8fe0@nxp.com>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
In-Reply-To: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507676; l=1737;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7SABP9R2PQ+RRgGfQ+qgV83O1Sg3zJkr+c7aWvNEdE4=;
 b=zJcRVhtrqEqBN0qBcJ4qDuSO6Ah+h00uzvT8FGScFLh0TZao85AR+F7gJc3ghV/jl7cxXyv/f
 tiwDqryzBUlAdQUNaseku0O6FuuJENDUSeWc9GC3v2Ap7PuMV3M3Ux1
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 8385c7e2-e795-4cc4-3908-08ddf97ec30a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm1neUhsZ2Z5TGlsOGZJdGN2dHdjbUF0YStiUjZ1cXNWbGFoMExkRkMyUXBi?=
 =?utf-8?B?RWFVQXg1VzBPdVU0a1plVmsxdWhLY3NhajFPRkppQU9uTE55ek9UKy9iV2Vi?=
 =?utf-8?B?RUREYXhaREFQTlVCcVMrOVNNb3ZXaTluL1h3VzNQeDEwQXpBNzZmdW9WQS9y?=
 =?utf-8?B?SDduTXZ3dDhwY05RVUlKeC9zUk1ZcktHVWZuYnlndTBxcmJQMTVqVFgwb29x?=
 =?utf-8?B?bzRSMXFPSFhGbm1JeFYxQjJWNWtDc0xpTmttS2NGZk5sVnlaeDZWcFRjUy9X?=
 =?utf-8?B?VEROclpoQUFpci9qU25SaFFmTENPb0c4a2JFck5FbzJIZGNZWkhmSXc3aXl0?=
 =?utf-8?B?OTNicld5d3lXTWFqMXhvVmRWNVU4MllpNUMyVkVRUHNiSXNBK0VsbVFlUWEr?=
 =?utf-8?B?NHJhbXY3OGpIZDVJbExCWFdzazZOQkRWenhtSGlMSURydXJCalBDbDlvcGJt?=
 =?utf-8?B?SXdVN1plellJVmxaeHRBcDNCeXdFcFNTb2s4b1llRUsrVzhYc1hTemdsZjNX?=
 =?utf-8?B?ck9QZHZNQVhpSkFDUmNKaGNOak96QVg3eHJmb0ZubW1xeFI4VmJtdG11NU5o?=
 =?utf-8?B?OHFvSTFCTXpSR2NtM2oxQXVoREg1cFY4c3ZQU3dTU1kzd3F6alhrVXlvRmpM?=
 =?utf-8?B?TGVVRjVlVWx3UkpRem0yL3Vwb2RWbklBM3cxV2tuUUpLbENjeXJ6dE1LbkVS?=
 =?utf-8?B?ZGhEclk1ZkpBVUJEbDIvVGdoRWhibUNQSDhPUTdXRDRXSlZTeHU0Y0FJZ3RD?=
 =?utf-8?B?NjhId0ZFV3EzQVhENVQ0UTZ6SXloK29nSmNFNnQ0Z0hYVHRVeUVad1d3TC9t?=
 =?utf-8?B?eDFtSld0alRsbHNDRzBSbndIa1NUMmR2emFFMUNiTHVtZnFyNVR4MGJSSVVm?=
 =?utf-8?B?Qm5YamlFQlB0c0NzeGhyZkg4UzNISkt3SGZxR1pZa0ZCOGVtT292SjYxdWV2?=
 =?utf-8?B?bjcyQk1FOGplTFJ4MUsvdmVPRDBDdVhXWmpYTmNLOUJqdzdzcWMzd2JVWlZz?=
 =?utf-8?B?a2FiSi9IeTZRa01mbGJyMzhCWGpTbTZjZlBUT0kxQ0ZvQk5uczFiaW1OK2xu?=
 =?utf-8?B?OXdSdWI3WUVPVkRvZ01GNWpDM3g4OFB5S2MzMExjWFVCazRwM3NlUVNLbnk2?=
 =?utf-8?B?NGp3WE9ocDRkdVFvWlZiNGVVSWN1UTZlcEh4eWp3TmJ4MjZFY1RFaENVU1dS?=
 =?utf-8?B?VDVWNW91SEV0VWFFemlzcUFaRkIwelRlNUhhMDBxOGxEOUpBQUg5Y0thTFNP?=
 =?utf-8?B?VTFzMyt1dnRJQTZURFR5MnozME9kUVhuMzAwdGNmcm9GNTdWdWJFcTJLR1Qv?=
 =?utf-8?B?bkFVQnlPcisrZUlNYmJXS3hFWTl6UE9lNzVZWVpnaE9CRERHaUpTdVJrcTJh?=
 =?utf-8?B?QWZtczdzdDJhdU9PWGt2Unk4aEUxSXpoQXhaUW1SNEZwRDl1dmV0Tk0vWGRI?=
 =?utf-8?B?bUxhald0ODBIVTBUVXkzTXVTdjVGTnl0bWVmcXozNU5sV2l5NDhlQ2dtV3ZR?=
 =?utf-8?B?NWUxQjVSa01OYjBmbm9hOUJsQk13R2VJanhtaU9naGFuaTNtYlp3WFUrYm1M?=
 =?utf-8?B?WDRSSVJtNm8rWUFmQjRYTytDVmNJV3BINjdvbWx0QmlkdzVHQTF3NG54K3I0?=
 =?utf-8?B?SmpNQk85ejhqQVpDdW8xc1p0c3dEQStSYTIyb1FIYnRGZmRpS2JlR2kwT2Rt?=
 =?utf-8?B?bGlheWNKTWFGb1Z6ZkxuL0xxVkZuWXNBQXNpNk1RZW9iVnI2Zk1XUkNYVXcr?=
 =?utf-8?B?TjZzei9wMTZ0dzkvaCt0YzJTa3FKZ0lBR1FZOHBsS040WUM5NTJnZnhsVUZh?=
 =?utf-8?B?SG1aZ25pSEJMbVBMZDRCWjlzWE4wWjROOWh6U2U0VXo2bGU0bjhBQm1PeFRQ?=
 =?utf-8?B?d3J4ZldIRGRCUlM2R3FuUE9jRFh0SFAzb25vV1B2YWJQeVA3YWU4K0kzRkVQ?=
 =?utf-8?B?c2hxMEE1d2Y1UU0rcTJzcUJqdnUrTWNuRENYNWNUNkJocEoxK2dvay93WlM2?=
 =?utf-8?Q?VBAUQjgWO5Ry9M5FwMwRox7EBEckiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG5SZ1ZPVjNtV2thRUxsSThETTFXOTd0M251dmt6Sy9EYjhnUmg2YUM5NWxE?=
 =?utf-8?B?bjVscm42M01yb2RMaUFsNnhQM043cDl6NktzTkJTWFFDbTJIQlNVUDZCbVdt?=
 =?utf-8?B?ajFqblVJWW5JRmNYa2puQ25ZV3owVmxtSk5hbHVEV28wcU5TODA3NEJsa0ph?=
 =?utf-8?B?L1lrQmtCNklOZis2SE1GWGRub1ZmYy94QnNYU0g3S0NqYnRMRkNDU21UNWdG?=
 =?utf-8?B?RjlEQTFBVEhoN052L2tzYjFrZUVqMlNwRlBmb1JlVFpFVmlvWGloMlExeGxG?=
 =?utf-8?B?TkdBY3FJQnJxSFRUZjd1dzd3NkxobUFpSkk4TU13ZURnc0laaTVJc1gvbkFN?=
 =?utf-8?B?WWFYQUc5RWhJQk03QzNqUWJEMFFKd28rdjN1MVdyN1Q3b3RCcXRnR1puZG9Z?=
 =?utf-8?B?OWxYT0JXQ3dreGhhYVgvdXFkcFVWQVVoM0tUMkVrbkhFTlpwWkJBbUZXOEg0?=
 =?utf-8?B?MmFLRjVpQVFMR2Zla2QxU3JhWnE2RmVTcFpRbkF1cEtzRlEwalVKdG5oblhn?=
 =?utf-8?B?TUxrOVQ3THBHenJCZVdpanVoRmI3Vmo2SDZsV0xlTjNpYU1ZdjV0aGFSalY3?=
 =?utf-8?B?dTJnaEhPem5aUGdzY0F5WHMyZUxNUlBieUphbGRVL0dadEpRQlBNSG0wN2p4?=
 =?utf-8?B?Tk5PV3BuaEQxRVJ6dGplQVBjbDYrVDNwaHF2NnpqMnNkMXlvcE5TMU5lZ1Zy?=
 =?utf-8?B?QmNvS1pJR3dDcVUvUnJzRm5GQ0RrcVQxNEpTUVJsNGc3b0ZHQmpSK201S3J1?=
 =?utf-8?B?ckU5L3VMRkNPcjdLWU00UW5ZMzZlZVJ1eUVwNEF1Z3pObUpXNmNXSjJ2OFRr?=
 =?utf-8?B?UURvQzVySmpBaXV4WFNHMU5QZjcvZUJtQzBhaG92RjJJcGVPQ2tZUWp1eXpY?=
 =?utf-8?B?Q0JZazhJYjV2OVU5OVVyNVNHdHhlaGVCWVZHOGxIOGV6R21rbjFlcGZQZ1Fo?=
 =?utf-8?B?V1pPYmNMcm9lSTZWQlo3N2NYdjdIbC9CSXhSQnVsdFU2a2U2cHM1aFNFZEhH?=
 =?utf-8?B?dWJOMGN1VGxuWGRlQTR3blJUZ01VV1J6WmV6a29LeGJndnRlT0VjUEU1T3Np?=
 =?utf-8?B?VThpeEJSYkZ0ZzNEQ0R5bVhiRGg4ZnhZRFV6VWJtcEpSZEFuVEJSeDluUW9q?=
 =?utf-8?B?dTV2d3pHRlhFa0VxVGxBbkhnRk9iSzd6bU1HRStQVk5HZUxIWEJKcEdxV1Ro?=
 =?utf-8?B?OUtnZ0JJQ1pMR2hZaURwNi9UcnFHeXdhaXQ3YXRPaDk3VWdzTWoveDFOTm9B?=
 =?utf-8?B?dkNtSUtuT01BVzZtcmZDbDVUelNHSG5SaGVhaEtYVnhJUWhpS1lrOW9LR2JI?=
 =?utf-8?B?T0hkeFppR2lQYzBVTVQyNFJXVWJBb2RpT1I3TTlBQlE1WG1JT3VpbkkrSzRE?=
 =?utf-8?B?LzhaU011Ym4xK01kUXBodUtqVlFhVWVKMEgvMVoxaE9SSHlHVlZPVFJQS2FE?=
 =?utf-8?B?a3JNWlBUY1F4VzZ2ZnNVNWh0THJTcUEvTk5zMFVDakt6ZHlWK3RGT0VwaTlB?=
 =?utf-8?B?cmhuR0d0cUF0RXhwbGtwbWJYTUlQQjdnelZEYjJ5Vm44Y3NCS2dmdWgzeE1I?=
 =?utf-8?B?SHJpZm1pKzFTekQrdnRvSTdoSjZWUUxTVmFQNXJQK01HMGs5SGsrK0FnRlVX?=
 =?utf-8?B?MHJHYSs2UHVJTWJ1R0ZvU2JJV1UxcDlDZGxpVFVRS0RPdzVTbGFhbjNsdTZT?=
 =?utf-8?B?cDByd1ZqcC9kZ1pXRFQ4TGlPNnRQaytOcGxTTTJNMGdMUGhqaTltTUwwbWQ5?=
 =?utf-8?B?ZDRqb0ZCRktseHYra0dyNEFjbmJuNTAwTWsyL0pmcnV3VEc0L1E2ekEwZUdp?=
 =?utf-8?B?UVZjcjdwekpzTFhJdWtLTXNaSkJFWnE5M29SY0lEM3B2VUtJU1ZuYmVFOEpl?=
 =?utf-8?B?T25meFVISSsxUmk2UmdEY3dtb2lyUVZlVHVzOTJIdjBjM3hKVlVtUElCeFhQ?=
 =?utf-8?B?VFFmTFBxekI1K1FkbFhUUnJ1dEdTd3hscVJpYXRtTTE5b2pYQ0V1UGlNcWZl?=
 =?utf-8?B?d29rWHpMaG9xcEdsTVM4N2dIUGlacDVWbGtxQnlWZ3Q5K3ZteU5jRkYvcFR5?=
 =?utf-8?B?dnZXQ29xY3RieFdJV0JoS1FUN1dWNFlyVGpXMGZvYjBqL2VlT1RVUkJxcTdt?=
 =?utf-8?Q?vwhI79Mu1o+gCyng1jRJZKn6j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8385c7e2-e795-4cc4-3908-08ddf97ec30a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:21:39.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTIoHVsiCMeX0NIMXCNkJHp75AzAnwIKJyb04w6UpyrZEtQpw5wwNtqMyjBKeWxHG7/9DimjnYhU2UuHhFYfTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

From: Xu Yang <xu.yang_2@nxp.com>

When add a platform device by calling ci_hdrc_add_device(), this device
will reuse OF node of its parent device. If power-domains property is
provided in the OF node, both two platform devices will be attached to
the same power domain. This should be unnecessary and may bring other
inconsistent behavior. For example, to support wakeup capability, these
two platform device need different power domain state. The parent device
need NOT power domain on for out-band interrupt, but the ci_hdrc device
need power domain on for in-band interrupt. The i.MX95 Soc support
out-band wakeup interrupt, the user need to enable wakeup for the parent
device, but if the user also enable wakeup for ci_hdrc device, the power
domain will keep at on state finally. To exclude such inconsistent
behavior and simplify the power management, detach power domain for ci_hdrc
platform device.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/chipidea/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 694b4a8e4e1d8583dcbf4a42f8c2dfd785d5745c..70597f40b9997a9766934c67bbbed38e96c210f8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -915,6 +916,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	if (ret)
 		goto err;
 
+	dev_pm_domain_detach(&pdev->dev, false);
+
 	return pdev;
 
 err:

-- 
2.37.1


