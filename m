Return-Path: <linux-pm+bounces-22515-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63497A3CCCD
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 23:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D453C3B9810
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 22:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DD325C704;
	Wed, 19 Feb 2025 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2NRwfdc"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013007.outbound.protection.outlook.com [52.101.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63B25B698;
	Wed, 19 Feb 2025 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005781; cv=fail; b=AMHA11NkIZgC39GSNTqB0hMpRjCXI6G3cf2KXkQJA3vAl+fCbDMeMJytwYX3Q3lx4Jpq4+F+OHjqlutIzLUGXyahzpu9D7rld/Q8De0VCy8v9UgTAoGHvyPCXqUQbhKU1nyW8YiwWEX0y+fkWnki7QBpJRqSZNknHT5Re2sZv84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005781; c=relaxed/simple;
	bh=gOJZ6nMR2grQccbgh3YWWN+DbJpXHKnHHavlTk0Ib54=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Lj+3S+04fBVUA9ZjPcr0DRGZbPrHJZ0DoSg2MAYMgL0KVpbnVhLoE3AGNiTAPGsFIwXati5+ZkfEJXyNS0B9bbKzb/TPVw5j5yVSWvBGlrBeCc2J7rnNPKCiW6hLEaNz3K8qph0rFwlGroU+STErlInkDxMisUbV30qdWPZ7Vhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2NRwfdc; arc=fail smtp.client-ip=52.101.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+cVFiPwoWliqJzUG9Vyx3CAgboK2PBVM54U0nnHXnKRtnCixhNl+EZaar4RRjnoMmvAZgQ10mdBLCFqJPQJTgz9CJdCYzeTJLXyZMDPqQM7nmdh3VNC4bkDhu1gSgUEaOL2xzwHpwbSe5Ans6MTP1nNYq5omxgLeZhjg3mXpMyEUimcrX4hS41wcK8m3opgnd3mBkc0NSaPjvUENbzHe8QmX+NkB8RC5jhnAbgNnzXLW5LM6C+8w0DZNKdCkNLJ39eP6Ic48KclmdJNrM0m8GCBuRqygqO4MSC+IWwA3+d3e1v7rq0Qt9X4ADoVRUqueXF3TQdPTBCCga3ovs9LaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6b3LFmQ3syHYiRHTSE/J2r+YNNfC6Rd/3bTuxzgj6c=;
 b=UySwTesnRu+7f9593K6bDmaA5yPPb/SXYzwEIcMsgk3P/1Y/YltuCsivLb3jNv2Jm0ykZXOs01f0+F46x0STz7mckKVuAhnokHp/VOOlsAki+7oVJYFswv+3HwCBKUc4pUr25jfrY/e6WL/4Ui/bRmIiFIdu0nCHz/cBoSsNNRsRywkQvz8sOndmAURdDvfJpRJGINblNqIZz+joCKDX6vobPF1e2WkRXbJjly89JQcZSfn+3hiY8KY0P2xqaBH+OmzqmuhjkDiewmpZqT5/zZbu0xHPqeBosB9+Hnj2lLcEN4EYvRggTCQvkkiUNMx0CGg/UWG6wwpwt49goRjvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6b3LFmQ3syHYiRHTSE/J2r+YNNfC6Rd/3bTuxzgj6c=;
 b=G2NRwfdch+aknN1UakaD10LeIJNR7m98YKKh5aKEXwTg+2nVHI0fdxm3c7HeZglZzIvYKpG4zWKODK/GnAJ2bGsbvkJaldy8HSTYJG7KKerBnFyYtw3u6gBh7kVEe1JS74nlWJOxHjHlG0dKYH8l9Q9/RRfVwZkiolzDA+BFNhwAV5SBCC6OuzjxPurjyqV8mR1TRNmLVBu4Q9OY+8gTtKMfIi+685uSvO9XMT+cp/tIdAiyYxiSTDKhQIdSQPeOk3LVPU20YohozpkeuRq24bDwUvNZCwH2nSOiszgwoGa9zG6XGFNP9Ep4qcA+ILzD1cbtD9biaj+I7EFFDYTpPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 22:56:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 22:56:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 19 Feb 2025 17:55:52 -0500
Subject: [PATCH v6 1/2] dt-bindings: thermal: fsl,imx91-tmu: add bindings
 for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-imx91tmu-v6-1-7af2281bcada@nxp.com>
References: <20250219-imx91tmu-v6-0-7af2281bcada@nxp.com>
In-Reply-To: <20250219-imx91tmu-v6-0-7af2281bcada@nxp.com>
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
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740005766; l=3278;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+L1Qe/+JHtQDcDM0baaIZLwnjtk1VSJMnHn2mFaYfHY=;
 b=8XmphZdp/0tfMXdzWVl/Ftwium/Ip5ZFNu5sZz+4isNvs1Nub4tiNGNfyKZpduyxv1avwRXhE
 eYxf7Yg0fUWA6btoaGiEws1IMmJ7fsGtM6nQT+A10FG9dnXmuAT+nDP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 6991063e-b25b-4780-2736-08dd51389e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVoxRmY3d01hR2tyWGdtV1Z4QUcyaWFxalowNTdnT3NrN2RzZGdQMmc0Szd0?=
 =?utf-8?B?cnB4TzR0aE9ma1ZEb0FZMmZhZEIxVjlsZzRuTG5iNitYQlNaZUt5VjlFaTRj?=
 =?utf-8?B?ZnppSGtqWGZ1WjRNQ3MwSTV3TXllV1RvaXhjcU5iOURXbWZRNVdYWUdRaURL?=
 =?utf-8?B?Y0RIbXM0K3J1ZTlVOTJxN2R5L3JnOThYODhzV2ZCaTYwRHR6RnB1ZURCd0Nv?=
 =?utf-8?B?d3d2ZXV6eWNaNmpaOUxzc0ZoUkk0REZ6emloOUtwVWt0SytIOE53V05JUGp1?=
 =?utf-8?B?TnNtYU4wZlZhQ3A5R0JDK1FXdElJZEoxZmxXdFJqZkl5VW40RzhwekN3OW9B?=
 =?utf-8?B?NDF2cXdzalAwN0dtT0FXOFBLRjFla3ZwUEUrN3AxNGVqMDJmRlR6eGFsSE9l?=
 =?utf-8?B?eEpETndUWkhjODFBWlE0T1Y0WlNGRk0vaEo5TWU1UXhFQy8vY0M3Rit3TGN0?=
 =?utf-8?B?ZFJhNTBITklzUFdLNTRoM1o3Z0NKNmJDYkR0RzdKR3lLMFJreENuM3hDb2Ez?=
 =?utf-8?B?bExVWnFGL3FNUTBEdXRlakxPbDBrUmhqK3NqRkU3WjVYRFZmZ1pkdHloZVJw?=
 =?utf-8?B?TStZTVhpZittUGprZjFsV2FuZlVrc0ZrYW1oQ0ZBcGYwamZZOERvV2xsWm02?=
 =?utf-8?B?VmFjV1pkN2grKzRPcUNTSkdkV3h5Mm1obUpUaFpFNjhnSWFpbW9vUy9DVlBC?=
 =?utf-8?B?VTI1L3JpbHhoVjVjRldjYlhDb29IcTN4TEVuamJRVG9HV1hGTXkxUHMrb29a?=
 =?utf-8?B?Zjl0dEp6VisyQmMzZGlEeVU2akdSRjk0MzJ0eWx5R20yRDhMZ0ZjZE83UUMr?=
 =?utf-8?B?cE5BQ0t6K0lPbmp0RnRPcnBrQUZabWY2bWF0ZWJBWWpRaFZJNzJxVURWMC9w?=
 =?utf-8?B?MjZXS05jeTF6VEhieTJoVkNtRU1UdW9XWE9tR2pKUFh0Rm1janEzTVZDOC9P?=
 =?utf-8?B?M0p4cHNrSi9wKzZtTFErSGJldVJ3VE4xTnQ0YmRwSXFHczFxVzZIUHpMYnhF?=
 =?utf-8?B?cVhnakFNTTNzdW84Q21udUVZbUI3THFxYkRUTmEzSVR4N0NZdU1yenJzMHNl?=
 =?utf-8?B?cGNta2w1b2pvbjAwdTh1YU0vQSs1ZFNRUTAvZlIwVDB2b1pDaHJIN01iaFp5?=
 =?utf-8?B?NVhlelJOczZnblZBNXBZUkk5S2IwRTJEelloa0RlZTZlb2crZm11NVlkdDln?=
 =?utf-8?B?dEh3YVFRZ0F5cG5qU1daamg5YnZ6c2hHMkNqN0hNWmxtbHRRek1vNmNRZEtZ?=
 =?utf-8?B?RWF1N1IxdzgvbUh5Zk1iNGRSWC9jdExpMUV0aU44Ui85aVBmUldkS1lVZVZU?=
 =?utf-8?B?cjZEV0NidTJoWDdJaDJITkpuNTlHTTJmOHdVVE4rZmpSR0JtMDltL2poM2JN?=
 =?utf-8?B?Mzk3NG9MdGMydzFEYWVpR2QxbTZHN1c4VHovNlBqZk1VYUEySk84WDJPMXZw?=
 =?utf-8?B?UDByYndsOFRZeUkyZlNxZUVrT2xwbmwzZjFjYXhCdzFsTVZTeEZmZDhSTmQv?=
 =?utf-8?B?Rm96eFV2SjBvZnBwRWkrMkptWkxQNlJzYjhaWVM2Z0hKSlNTd3NuRTZTNm81?=
 =?utf-8?B?TXZuZDJHR3RPUjRMR2h5RkxUZExnK1lrdHdROUZFYmFuc0lRamFXTDB1L3Mv?=
 =?utf-8?B?dHZDTlVMTnBWYVB3d1diR25jTVV6S0hOREQzb2xEOEdTTmFYNVNXQkd2aXg4?=
 =?utf-8?B?REpkKzM4YmlDR05RaUcwc2xoTGdrSTZKRHB1RmJmYUljajhlSFdFa25EdUEv?=
 =?utf-8?B?dXA3amR5aUw0MFJBbyt2OUhxTzY1R3VQZHJwZzl1Si9nOEwvdHZGMmpVN1hu?=
 =?utf-8?B?T0hPczc1QURyYUJJVllBa290a20xd05ieFMxQlpLK1hIK2pGdzlwYk9VdUQx?=
 =?utf-8?B?SUw3U3B2ODlYWFpaaTh3S09ESGd0c2Z2bGNTaEE0K1I5WEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bExsS0dIOE51VnBOc1A0NkgyYnc3VE1LTUtnTy9XUkdnSG9iNTJKd21PaXI2?=
 =?utf-8?B?VlFBWnZuQlNPODk5dDhRU0lhcm01RnM3QllOdmlTdEMzVUJXWmx0RUtHb2xi?=
 =?utf-8?B?TVJScGRqQThtaWtNODJpN09kL1VlSy9vcFNUMCs3d3hNdjVaTkRwdHk0UWsy?=
 =?utf-8?B?OUlubVhxaHJKZ0V3M2lNUjJjaGZieU5zdlVvOUM3emZ1bEhjRno2RHVnc0Rz?=
 =?utf-8?B?V0hlNnJQODhOclZvalBEMFJWSGQ3TGRxOFAxTWZVVElTMnd2MjVMeERkM3V2?=
 =?utf-8?B?TEtpWTVmWStJeTMwNWI0clZtUlN1eFo0R1hLbHA3WnJlTGgzMzhMR05FdVpQ?=
 =?utf-8?B?UTk1Ym1TbEE2WXF6SmRWbExybXF5bzNnUGF0WXg4amJHQ0ZpR21DdkJ4bEx3?=
 =?utf-8?B?ckl5VHNnYmd5WFh4RkdyM3VKQzJtWml1SXZiMkd5RjZQNThtTjJ2NndHOE9U?=
 =?utf-8?B?T0g2c2kwTzhBVUc0bWxmMmJtdUlKaWtSYXRPd2U0SzNJSDMvNEpXc0dMSTA5?=
 =?utf-8?B?aVQxY2RkNDE0aE1lQVFxamJoWDNVbUFZSnE0eGcwVHArQXA4eUovZDdJQ0tx?=
 =?utf-8?B?b1o5c09kZXpFdVBibkFyVXdkclk2MDFOMHFURE1TRWpSOWZSM3JlaVBPS242?=
 =?utf-8?B?RGVybjIwQW40TFdtZDlUd1NaNDZ0VTJOUUZRU3grR1JVMllsbk9YaFNtajNM?=
 =?utf-8?B?ek5TRXdTdi9VTEhYRTRrYXJFZDErU3dJTFdtRHBqbU5Da09ESzNiQUovRGI5?=
 =?utf-8?B?emZSUGMyVWI2VGJHRWpTSGwwelRvWERIVlFkSllOSThzSXRqbFdRSVk5L205?=
 =?utf-8?B?SjgrZ0VPVGxFSzJEUlVNM0ZpNlY2b0VlY3daWWxPbk5rTWI4T0pPaXMyM25R?=
 =?utf-8?B?Yk5Sb2wwWDlTNGFVV3Z1Tkpuck1xMEIybWpMdHZOT1dseVNNRHRVaXNhQ2VQ?=
 =?utf-8?B?UU95bVhZQmI3VlZGb1lwd3h0c2R2NEFPMUx4S1gvYlAycDZ5OWJxeFJ4bjY2?=
 =?utf-8?B?emZrdTVWREZsTzI2Vnc2MW1PMVFINEtnRCtZWEtYTnFXL0dQTkNLems2OWtL?=
 =?utf-8?B?MklMU3RJem82QXM5UWFDZDBDSXlYMFNXa0RSZGc5a0V0MGZtT2x2bVVjcjhL?=
 =?utf-8?B?S1l5ZjBVaEcwdWZENmJSZTRrKzl6NGQ2RFVGMTZaeXV3YTJ2YlRxK01aN1pk?=
 =?utf-8?B?UEJsWXByNFVVRVc4NHFiMjVNeFRmUGhiR2F5MmcvUkc0dFQ0eVBtNlBpV05G?=
 =?utf-8?B?b0g4QS9WOXBIb0gyNFA1ZFptUFlaL3EveGpzcUsxdU1RdXZob1BlKzAybDVC?=
 =?utf-8?B?SFRwYkJucWp6WWNHYkdpQXhhMFBXN3ZhaE9qNVRaT3l6aEdPYkg1UG15N0NS?=
 =?utf-8?B?emtUTXp1NWxRVXFGM1orMDNIOEE2N0s5VXBzbkdpdWRuVFhXdXpON2ZzRkhB?=
 =?utf-8?B?R0phUGdaMjZ6bk5NdWJzQlBOWnl4M2ROb1NqN3B6SmpwRGlQL3cyR0pxSnpY?=
 =?utf-8?B?NDhDQm5zREQwWExaZ1Y0M3RlRXI4ZFh2bElJS0xKMllPdnBCbXVIOE5CV05P?=
 =?utf-8?B?cFZqNnEyK1BwME9RR1VkOTNpZnJaS3drdUcwS3dBdSt4Y0wvUTBvVExYUkI1?=
 =?utf-8?B?dkZpdFIzcjA0bG9YQXp5VThsajNGTXYvY3RobDlIT1U3L29TWjZlbU9pMEN5?=
 =?utf-8?B?ZEF1a2s1d0dNbkViNThDaXpWcC96YUxCbDRyNmlOeG1SYmVPL2I2OENYMVox?=
 =?utf-8?B?VmhYWEFYNEFwYm1NTlpiOEoyV1VpT2VXOWQ5dUJ1a004MGdySDU1Yk9hc1k4?=
 =?utf-8?B?ZTVIN2RjTk8yLzhsMi94SnFPNUNocHRJT3VyQjBpZkxrb0taNzdLaVNacEpR?=
 =?utf-8?B?YW9KbzJ0VzAxcVhrdzFGMDdaUHZIOTJjZWo1Y1JoeUtNdkpTb3hTY2Vvd0pa?=
 =?utf-8?B?bER0S3JQdjBXWXJOS0prWk1rRzNLNE9xbVRwU0RCN2ZqRGd1M0ZtWlR2Z2g3?=
 =?utf-8?B?MkljcHNDNi9VMHgyTFgvSGRkUkFBYmY0M1JXMGp3Ymg5NncwQW1qNHFJeWtn?=
 =?utf-8?B?czh6UTY0dUtiMUhtNWhYaG11cGx2dENNN1lvUWVnYTlSS2YwYWVEOU8wUVZR?=
 =?utf-8?Q?U1tKnVw7AfVzyHAzHvDdmnMJ/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6991063e-b25b-4780-2736-08dd51389e33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:56:17.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUxVGK1ExHZGXbDIg3QlXE7CExIc0WOERk2JyAGCrV5VAamYOV5o0QYNrDV/GQaGeyUTuB5ydIAXqqqxTtZ+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9251

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- add interrupt-names

Krzysztof Kozlowski: Compared with acked version, add interrupts and
interrupt-names property. If need drop review tag, let me know.

change from v3 to v4
- add interrupts propperty

Change from v2 to v3
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..7fd1a86d72870
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,87 @@
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
+  interrupts:
+    items:
+      - description: Comparator 1 irq
+      - description: Comparator 2 irq
+      - description: Data ready irq
+
+  interrupt-names:
+    items:
+      - const: thr1
+      - const: thr2
+      - const: ready
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
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "thr1", "thr2", "ready";
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


