Return-Path: <linux-pm+bounces-36982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D3C152AC
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC175626AF
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4433375D5;
	Tue, 28 Oct 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YtA7hYYr"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7C2EB10;
	Tue, 28 Oct 2025 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661451; cv=fail; b=u7lRrz3H78aUgsSbVVALR737/CJOLUFE3IN/nmEp1fbjInzal2eDCG7hokk+utsUw2SV9nR/fi45dQ81Q5DzWCATXY9Wy5YEHA61OXokk87aqV3LR3besDBNlD15q/O1Vylw1tFfkPg4UJS9AkB6CwOuzwpNs/rOvHSVf02zD9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661451; c=relaxed/simple;
	bh=gbs0rwJAtx5g8s5YzbPE+6YCwhyMqZPsXf0ZWVVwMak=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=kqxMqXFvCbZrghWcWoHOJChrdfSQsp5LmTyQMqwYirAs/MH/uMs+bpclfCfHhXlkceh2P67IqWzPJcVfYQ6qxdrrca80rbMdCNGHzenk3T0+bK1tbzbDvmx47kVNPpWZYCJwqFUwLvO9XDeM46l4AAnfi8/zrGc/hkDAH7qm4cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YtA7hYYr; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGrGphFRVZSJrpepklUVJcqdy/byW/WZM7AS13sogZThkEE4Cr+wsaAo5LSRkKtOY/aq00wRnsRwU9o5ja1js2uoSjHwRIRln+K05qvSUKfmf+BoqnAK9blTSDxo6sobtJR3Y7Q0YdPcc6K+bYK4B530Xf7hEAI3pWkpW3J6DOMbEmg9ObZsaVgf781fJ/KIq4ea4OKQpYXj4UbLTwVwfmDnf6BEsW5ysb1wAmgik7K8DSGm7M8WLOXDUv5nkxcpoDwJmiP3ZrUKnCIH5X9hHohp/qK/0LhRFA+PtnxYuQ6FJtWe4drDlwwqmVH4LCX68tlQLh6QTBtEajhyFkQsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxOgtCuwOPSWyEOJGSV4MUVtKb0V+z13a2uS7vqnB4U=;
 b=h9pDOOJs6bjzHXaS/xzC2Sl+ndSaD5uL1wuCcpiF/ekVhVzYw432SxCnUPveNZW8v77p8Hagt8vfipLmsgHfm/Fda5g6KyDAj/q8Vm+pn+Cz+Ra0Z43YLX0evay5k+VcWiUJZ/NH9vXQ7wcP8BMphB2JtXYYQ7AUFIJSLk7SlDDyWWJrgC4dSG1mBbCOfs3yN1hhzxoXLdFSaTX9rrGuly8KzXWaJ8i8A8MQPdt5+sjbaFjZZ1I7LRb9qwMxFCXc5/7lP7ecd+O16Al0m8jeiosVm9z+XuzWduzKLdK0sjV+cRwHR/84GRBWqcu3FRFj3XSK/Tk1taO4CFKCfpAbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxOgtCuwOPSWyEOJGSV4MUVtKb0V+z13a2uS7vqnB4U=;
 b=YtA7hYYrKhxzPOeXxCLfG0Xo8ppVhg0hI/Wcs5CsodmGc7G096yI/dGiSU2HSD1mnsw+SLSEeJLBEBePJ9oD2RYuYAploCB7+oTcbDLAILqxgDnpJSkUWO3QM2GDkEUGQrkoLj219DlDL/uIu7E+7k9jsnIpGbfXpsP2ah7ryepPPWLObT4jAzKvlrL5i5sqkalWL2eeU+HSEU7HYSvW6dQBFiWrL/D2J99q0tzpW4fQH9NZO+So0dn2onxGqFkbiww+Be/7j13sOqISh8sOqNlDT08gPbUM7W7eocyyR4qQp3XOj2VvljBbsVcUg6/hFyf0IGs+2T+aOkqQ1I8vqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9106.eurprd04.prod.outlook.com (2603:10a6:102:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 14:24:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 14:24:04 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 28 Oct 2025 22:23:32 +0800
Subject: [PATCH RFC] PM: EM: Add to em_pd_list only when no failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-fix-energy-v1-1-ab854fd6a97c@nxp.com>
X-B4-Tracking: v=1; b=H4sIAOPRAGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3bTMCt3UvNSi9EpdsyQz4yRzo8RUy2QzJaCGgqJUoCzYsGilIDd
 npdjaWgBXiQFQYQAAAA==
X-Change-ID: 20251028-fix-energy-6b63b72ae9c6
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Changwoo Min <changwoo@igalia.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761661436; l=2007;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=gbs0rwJAtx5g8s5YzbPE+6YCwhyMqZPsXf0ZWVVwMak=;
 b=0QqPkqLnTvfh080g3e5/gS67LmTI6Esgz1htel2txTN8LDPxMiSuzS9I/dafELnoJnCd54FVT
 L0p5kM82OQMD8zFYbajh8qv8fL1gVRqVS+1phREo0umMM6xK0VXd/PN
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d83c98-3308-491f-b881-08de162da5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGZRSHZuUllLRTYvWU5kM3Nqc0J6Y2VSZlNZSVMrTXV6T3IraU9lL0VFTEt5?=
 =?utf-8?B?emlEZjZ1WTRxQkZrd0FqS0Z5eUZjNTdVUVF4aWZ3a1orbHlJbHBpWGo0K092?=
 =?utf-8?B?enBQOUs4UkdQbnNjMjdvTVJ5STRXbWI0cUpKT21JMHFyMWUrN0Y0ZjFycFAr?=
 =?utf-8?B?WlZVby9WVTNFVGlVajY3VEJBc2ZsSlEwOS9GV2ZwcDVYSmhlWjd1NENNTEVG?=
 =?utf-8?B?dHlkcWhNWHVkdEZFeEhvbjVETGJMSVFISlJOQ3R5MDVwbXUzYi9CWk9EMHFx?=
 =?utf-8?B?N29rcTFXcVN4M3FseUdCcU1Yb1MyYktiLzUxSmF5bXkyNGtnK1dxeHFQTm5m?=
 =?utf-8?B?bjB0d1dQZmw0UTVDTXRhdFZxL2sxUXd4Q05UZ3RoaVNLc0VUdlBHR0tlejU2?=
 =?utf-8?B?S2IxcUNkY0VVWFJncUJVUzNnT3FFUSt1dEU5VFZNOEtiV3JjVklWUXkvMTBN?=
 =?utf-8?B?LzVIOG9PcGNoaExpUWZCYzBKL2M0c0VpVytVU3hQMmxTOWRIUDlWV2FnTnMz?=
 =?utf-8?B?SlVac2RiOGlYSGhVcmZlWEF0RkhLU0c5c3hWUG8wZkdDV1FabENaYUFKa044?=
 =?utf-8?B?M0gyWWc4OTNVa2NlK2VlVGIrSm5NSzZmcFVsSE01MGdZS3hHdWhhRHlmUjBT?=
 =?utf-8?B?TkFRUDNBWTA4b1JaVU1sT3hQWnR4alZLSzBidUxxaSt4dVF5ZFpSNGR6UmRo?=
 =?utf-8?B?SWo3cTltN0R6L2VheGN1RThJK1FpK2owNUtjYlZ2YTkwdHlZQ2MzREpIQlBV?=
 =?utf-8?B?NXpzM3NHaTI1WFFYcFcxajlIMmFGZGlYYnE4SUM5NE5RTmlsZ1E1dTc0aXVL?=
 =?utf-8?B?Q1A2cE5vWlA3cUFhc09jY3c4Y2lhc2hMa0RvZTFwazVxeGNoeWxYZHNpYjgw?=
 =?utf-8?B?TkpPNkc4QkFoVitBQWMzb2thbWRLME5xVitZMzd0M2FXY1JkWENyQ2h1dnFl?=
 =?utf-8?B?Q1pYcDN5aVplZ085aU1uS1pTbmhXOTlyZk43cTB3WDA1dGJDVW5GcElyTlJl?=
 =?utf-8?B?Y09JTS9XbGcrOFNlQ0JSTEJZUWNqdTN0K2ZaNjBoQmQ4ck84YlN6MzRraUI4?=
 =?utf-8?B?dm1Pc2cxanJTVVhOeStnN05sVmU0UTdtdzhneEd1S3lMajhqaUJLcTFNaW52?=
 =?utf-8?B?cHVGM3RSRERqU0YzdUgwUlVjTjEvMHZ3NDVrMlZ3YlJXRWlvOXdLY2crK2RJ?=
 =?utf-8?B?amx2SWt0cGxGUVNRZ3NPa0JsVjV4UHhyTjhYSjNHaGliWUlKRnlGZGRYaWU0?=
 =?utf-8?B?d0l1MXl0anpiMG5BcnpiVzRnTkFoS0l4bEdpbGk5TXRScy9sdVlFTkVPQnF0?=
 =?utf-8?B?TEJLZkkrNmZrM3dTUXpzaHhDdnBVTnJNSUtTR002Q0xhV0VLV0g1ZUtWcGhs?=
 =?utf-8?B?anlIUVpLSXFTdGpvOThKSXpha2I2NTEzeC9SS3RMU3VFY1BTQml5Y2FlYlBP?=
 =?utf-8?B?THRwN1hSRWNmREhiQmhQd2tiNHhSU2pGUmFBblpxNUlHZG1GWVhYL0FSelJP?=
 =?utf-8?B?YlFvamxkS3VkRUJzdmh3bHZmbklrWEVXTGVOMHAvUkRuNnB4UkpPbVdxajNt?=
 =?utf-8?B?SE9sN3JkSFJzMGt6TUJhYmFKeEwrclRFM1VhMGpybHdOZTJLN1p0OFo4alhm?=
 =?utf-8?B?M3NpQVFlT0Vqc21uYTh2elZQdjM1bXJzRHF1Q0ZCUTY0cmhMNC9xRnd5TkdI?=
 =?utf-8?B?RmVqVHFhYUQrQ0E1Tld3eWxqNlNFRFpCRm41S1REZnNpUWRQYnhNN1lOeUdN?=
 =?utf-8?B?QnFyUlVuNHFhMkpNZVBqaGQ4c1FOUlUwTmplOTVMNTRKRmJ3NHVDeDRNT2lz?=
 =?utf-8?B?UFVrSGN1YktiU0lTcVJMZDUwM3VzUUtiTDFWc1VBOTNIbU5LMmxjR29XMmZO?=
 =?utf-8?B?WkkrR0pmaTRrQTNnV3RaRUZ6NW95ZDNVMzd1Q05BQUNPdXU4Q24wdUwySDNS?=
 =?utf-8?B?Z2hQdExIVHMvS0VodURNMmM3SEoyUFA5RWpFMTBUcG5yaWczeXBOUWgyV1RH?=
 =?utf-8?B?alEyWE5kcVdYb2lvQmZBakV1L29HM1drdHFJWGQ1NW53VFBWYjJJK3NQbC9S?=
 =?utf-8?Q?Qk5Aal?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1JzSXQycy9rcG1TTDBObm5qVnhSdk9OOUVJbUpiUnpiU05sQURoMTFWYm9T?=
 =?utf-8?B?MFJTeVRCWTRudFNxdTNzT3BGcE5XM1RnZW5MTFBabHJvWm1WTXVhMjBxQWxO?=
 =?utf-8?B?d2xjVnBReVU0dVlRWHVINWNrNzBKVm9WVE9HQmROZmNQR1lKemFrTUEwVy9E?=
 =?utf-8?B?cHQ0ZkYrUEZOQUhyb3gzU25JZ2JzUHRLQUNjLyt6elo5ZTRQRzExKy9QeGpF?=
 =?utf-8?B?ZGVFSmZ0TTFheWtuaitPSTROMEpyR3hHeFNnVy9UWGZhQitVbEY0aHB2elFC?=
 =?utf-8?B?U2hia3V6NUlReGt4L01jcnNmcHBDZGdncndMTElBNDFzZmhvOU13Z2N2NWV0?=
 =?utf-8?B?QVlMN3ljR2h5NVJHaGoyZFpNdWJtdjhlL1gxZGd0djhHRm5lZkRrYUo4WVNv?=
 =?utf-8?B?anppNUFDV2I1bWR1UTkxZ05KeHVvYnlxYndBMlBlK1gwcnJWeUdIcjIxTWNr?=
 =?utf-8?B?Ylc2ckNQb1BJdXAxemx3NExBVG9uYzZVT3JrNnR5bXFSTXZzSmVhU3luWW5G?=
 =?utf-8?B?Y0xSSHhJclhET1Y5Q2prWVp1M3FKOE9pZGNnSFlhemVoaTRQb1ZWWnBpQ2pH?=
 =?utf-8?B?U1Joc0dlUWRyL01MbVhTd0dsMjl6TzNORE14Y1VzdzRPbWhBeFUzL0t0MG9n?=
 =?utf-8?B?UVNucmNzRDlHbDZRUWJEckpPYmFFSmtkQkhWS084UVJyR1ZVNFlkOFlBdlF1?=
 =?utf-8?B?TFBjcnI1ZjFkNFZwVVNNVzBCN3N0Y2xydFYzV3EwbmVsTHVHcy80ZG5Ddy9W?=
 =?utf-8?B?RE5DMTFWQUJwYURrYWJINURDZ0U0aFBDTlN1OTNYN3BMR29XZDllaHZZcjlj?=
 =?utf-8?B?OFBJUWtzcEpxUFp5bFk1aWUra2JKWTY4RjNqNVU1Z3lrVm94YjcybDFFdk8r?=
 =?utf-8?B?SVpib3lEaUxUdThSMytqbGdFcnZUVjF0Y0E1M2NLZERrVUhSS1VUdnFvdUhS?=
 =?utf-8?B?TFN5em5YdVNLbDhGQTFtMW1OVWNJWS9sVXBiTHUwS21PejA5Tm9MVlNMZ2Jw?=
 =?utf-8?B?R3U5eGFzODIwRHk2clBhSjJMRmY4bmFwZEtsTEVZOG5CZ3kyeEhrSXpWZitF?=
 =?utf-8?B?Z2N4UVh0am5NTVB1RjZnVmJjRnVmaGY1Y1JsaXlMV0ltUUF5MjFRSDg0NEht?=
 =?utf-8?B?K3VKbjVvRGtuS2gxRUhMSmo2bzAzV0s5akk2RFlaWmh2UzZNa3JiRnRnRHZL?=
 =?utf-8?B?eTZucWtJK0lnMU9VdXJJeXNuYkRBN1k0SHV5ZVpURHhzK1NYYm0yVWU0WFdP?=
 =?utf-8?B?Vnc3NlhhN1VCbFVmTWR2eUdEYlp0LytYcXdrL1BNRkFxRVo3SnViYmp2NGZY?=
 =?utf-8?B?QWtMS1hSQ1IxUEp0aVdIM2txN0trK3RqenFXNW5Lb2M0OVdGekRNSnVkYUZJ?=
 =?utf-8?B?UE90SnVKM2sya0t1aVZ5RDFiYkloWnRKV0tRMXhZNTRZWnpqc0lPZGM0bmJW?=
 =?utf-8?B?THNyUlRBbUZEeWNXcHc2a0RwYUlDNXNBWlR3a0tXanFzbE5LdGJYMjU1NXBK?=
 =?utf-8?B?RDVtSkU1L1BLVWlJblExaEwrMTlTTFBMVmJNL3ZDSTFNZVRGemtzYjFocUkv?=
 =?utf-8?B?VFB3SVl3Y1NXVlZQbkh0c3ZCZnVhSUFJSXhQSjdUWFZZTVdXcm0yRkNSb2ZU?=
 =?utf-8?B?Yk9VK2RHWnNaRHduU3grMWNjc0JRaFFWb0E5NFVQdStoY2Rha3dMTE8zNHoz?=
 =?utf-8?B?UHc3LzRrMUdzRUFQY2d2M2FkaXpxQ2kweFdibnhhdzF2ejZuK1NtSEk1bFJS?=
 =?utf-8?B?ZkJ4YXJidG55VmlFaWc3QWxPa3Urcmlhc0VWa2g5a0dCUlRvelVJV1F2eUZF?=
 =?utf-8?B?ZlRvbVNocG4xVVJucVdlOUZWa01KVCtsdGhvVzYwcmlVZU5pL2tockVaa21a?=
 =?utf-8?B?RDRzY2gzS01pelNrVDVvWmNERzVQL1BkcGhoK0Jjb1dRZ1Y2alJ5eDh5cXJL?=
 =?utf-8?B?QmVXUkZFbGUwVkI4WVRuM3dqb2pXNnFya20wVFVmYlNnaFA0RitPQjJvb0FR?=
 =?utf-8?B?YXYyczFJcFF2REFXdVhJV1NmM0dZVlJtaUtDQUkyaGNUcS9KYjRMQXhkbXNG?=
 =?utf-8?B?dEJJL0ZMLzk2MW9NOTBEOGpOTU82NUJzOXArRTFmNkIvVVovb2pKNFpXaUh6?=
 =?utf-8?Q?0m0ClXoynYiJVKbgfMPLfHRzV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d83c98-3308-491f-b881-08de162da5f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:24:04.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eKq1jZRecbLpzbdyrfBhw8O1z7RClK5e8L7MDQlNN6PDiVFwidXqP3CMlasEiAw/UnXMzQYzq8Kf7bB7xeLMpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9106

When em_create_perf_table() returns failure, pd is freed, there dev->em_pd
is not valid. Then accessing dev->em_pd->node will trigger kernel panic
in em_dev_register_pd_no_update(). So return early if 'ret' is non-zero.

Kernel dump:
cpu cpu0: EM: invalid power: 0
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000008
Mem abort info:
pc : em_dev_register_pd_no_update+0xb4/0x79c
lr : em_dev_register_pd_no_update+0x9c/0x79c
Call trace:
 em_dev_register_pd_no_update+0xb4/0x79c (P)
 em_dev_register_perf_domain+0x18/0x58
 scmi_cpufreq_register_em+0x84/0xb8
 cpufreq_online+0x48c/0xb74
 cpufreq_add_dev+0x80/0x98
 subsys_interface_register+0x100/0x11c
 cpufreq_register_driver+0x158/0x278
 scmi_cpufreq_probe+0x1f8/0x2e0
 scmi_dev_probe+0x28/0x3c
 really_probe+0xbc/0x29c
 __driver_probe_device+0x78/0x12c
 driver_probe_device+0x3c/0x15c
 __device_attach_driver+0xb8/0x134
 bus_for_each_drv+0x84/0xe4

Fixes: cbe5aeedecc7 ("PM: EM: Assign a unique ID when creating a performance domain")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 kernel/power/energy_model.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index e669d5057fca6da9612575a1c626474e60e7f7c4..11af9f64aa8276e47e0a5b2d615b227368af5480 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -693,13 +693,16 @@ int em_dev_register_pd_no_update(struct device *dev, unsigned int nr_states,
 
 unlock:
 	mutex_unlock(&em_pd_mutex);
+	if (ret)
+		return ret;
 
 	mutex_lock(&em_pd_list_mutex);
 	list_add_tail(&dev->em_pd->node, &em_pd_list);
 	mutex_unlock(&em_pd_list_mutex);
 
 	em_notify_pd_created(dev->em_pd);
-	return ret;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(em_dev_register_pd_no_update);
 

---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251028-fix-energy-6b63b72ae9c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


