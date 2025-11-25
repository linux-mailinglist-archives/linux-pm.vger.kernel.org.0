Return-Path: <linux-pm+bounces-38517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB600C831F2
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 03:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34543A8BA1
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 02:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDA1D5ACE;
	Tue, 25 Nov 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O7Y6Q6ZT"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011063.outbound.protection.outlook.com [52.101.70.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9E1A00F0;
	Tue, 25 Nov 2025 02:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764038403; cv=fail; b=IjhYeyfmzCeWYpfc1H5ZvzTOik5HNW51v7rKv0HKt8w/r1CzDCeqpzdzFpPolrLVlrzESXQpT+ZtUenaNdJ0Tu+Wr9KL5z8cPKIaIyHSDWM5LOntj4BjM5sC4rSITuDbbU4QPizhGXpzQdcS/RWuy9Ju1nDwWKauttQxd1UONE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764038403; c=relaxed/simple;
	bh=JtQL5B8QKmLr2pQGTJM2hXpXk1xJIQKUMPPJ0csWoM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c/9GqWguWB9WXX2qhWKvDphr0gu5vM7+Q0dTT6aWelaKY2UABzCEirEYF+dxvmADm1enMbjVGRi4B+AuPS4VkH2x3D7GqyVkC/t+bAiClzdRTezrdIJVnN1RFokHPRyTSVxMvqaAl/tIu+YlaMlwQ8Bgj31ktzjad+NY1mx8EwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O7Y6Q6ZT; arc=fail smtp.client-ip=52.101.70.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLD/pGli7Y9BJ7SzJh+VCu0Y+7+F8mC96CprTMy10DQLAPnIgHTxRlrPY2YCnngJLH97I/NDDo+SAaakra+UyPj8rEWrZ6ljpztpQvyybw4jkQXHjzdBOeY5v3t/kjc9Y42/+22y2fg2gbTCbP77eIEmOEmOY25zJwHz+Hnl+LWnDANqRm+ZJKeBQTGw9//EoL1Fl9gz/aOl/pIptqB3GSk6Af2XWhQC7hzpLhHXvc5qRIyy+ozr7t8iKBf2pDbYd1r1V0Dg6eONguT/jy+BDAIgHoBH02WKqtbNbLoRhMHZGuwHUPOkW1LCTfmVyhqzpW45x9yJe9WWNf98m5VJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGR7iRSvfk3qMO7SlipsNFOL5+ltXot+A9qlTVivCaA=;
 b=U33aNk3td6d+fHKPjeJwQX1rwfQSTY+XvyZwSw3oAlh1DzfB0iq8c1Gj6YHkKgn0atXpMOSEkIQiaRDNucEHLEyyekpsbE0GFxDKSKj74bVZVh+mdOfr4pjzAilAyOuIlvPVy86fTf/XamwGzDrUWlhEfLFGqnHea2JvNWzuDnpjqkvgxHVpLhwNrd3Ko22Zi2HQhOOyDNehhwB8gYkCfuUtsoy3+jO50nwPA2zJemYK+fNLKa+B5qxwKeacFNrS9v8TKRF8tBjXNnGw1gJdK1hlT0mBcmHIrg/DCMTigH8lAQ5DkBW6c2YJ2iN7EkBOlVI0LeJreekjAlgH4Q9xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGR7iRSvfk3qMO7SlipsNFOL5+ltXot+A9qlTVivCaA=;
 b=O7Y6Q6ZT9Cm+O9YnPr5OHFjfi1fCdAHNB5FX1VIwWluSW42u9f5lqa+atLCOgzugwQ5EfBr0XAVYXuH1c8m/iLfUXtArTEbJfe9C5YolQwp2oeaubOu/Jk5x2zxaAqZu+TBmMAobkZ8mOIaGfGDBWs0cA1nQ0+DUFofgv4OiG8MaiOHcUr4o9iF6W+6S+yYY9z92GEEezfOBTBLVqUq/eGWTi/S/sD9EA5Ro8E5f6VoTj5aNRN7Vy4ThOWthgniMI92CxeUY4YjL39OnEH946ktZbJscbiQ3rvnarTrm98KVKzClAJpEpQgyHav3b9H6cN33l8fmC9rNTaVxO51HxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by PA4PR04MB7664.eurprd04.prod.outlook.com (2603:10a6:102:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 02:39:53 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:39:51 +0000
Message-ID: <7ceb9424-22d0-467f-b42c-33f0a903f5d9@oss.nxp.com>
Date: Tue, 25 Nov 2025 10:39:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: verisilicon: Avoid G2 bus error while decoding
 H.264 and HEVC
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Frank Li <Frank.li@nxp.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, benjamin.gaignard@collabora.com,
 p.zabel@pengutronix.de, sebastian.fricke@collabora.com, shawnguo@kernel.org,
 ulf.hansson@linaro.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
 peng.fan@nxp.com, eagle.zhou@nxp.com, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <20251121081911.1682-2-ming.qian@oss.nxp.com>
 <aSCOZCJ2rSw7LAvE@lizhi-Precision-Tower-5810>
 <d282811a-866d-4ca8-b9f6-fc1da3a7565e@oss.nxp.com>
 <aSR+eaVxBhnahOl7@lizhi-Precision-Tower-5810>
 <baec095da2b7b84be19b205b18e765f9a2305574.camel@ndufresne.ca>
 <020d1263315b8a5ff3fdfb46d61d0108cdfa5bb3.camel@ndufresne.ca>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <020d1263315b8a5ff3fdfb46d61d0108cdfa5bb3.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|PA4PR04MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: e20b8abb-f97a-49cf-d6c8-08de2bcbe821
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yko5UE43ZGNZczVLdU1NZzJzeEdJUTdDRGJzbHZLTC9KRTFDMVBwZEJTZU94?=
 =?utf-8?B?TmlBV0hlZzN1MUFXc213ZU8reWgzczhVaE0zUlRoNy83WTcwU1NXV0tpUk13?=
 =?utf-8?B?M2g0Z09uL0RMMm55bE1CdHF0OWlpVTczN2pJWTNKUXNiN0hqWE15TDBXdHlj?=
 =?utf-8?B?S2FIZStrTXRZMnBCd0V5Vmw0aHBPR25zaDQwUUY1VmVLbTljNnRLMlBJQ1Vo?=
 =?utf-8?B?OERMNTk1Mk9Uc21qcnhGRWhMRnZBdlpodnZHZldsa3diOGJTOHdIWDFOakVF?=
 =?utf-8?B?NDNlVUREWjdNT3F0YkxRamtZR21PelYzZnBSWlNMVUJaNytNaHZUZnE5V2Ro?=
 =?utf-8?B?UFQvbExvNHI2aS8vYTgyLzlYY1p0blNnSTdpdVBuWWhvS214NXAzbHFWVXF0?=
 =?utf-8?B?S0czYXdNTHFZS2Z1dDdTR01RdFQvdGJvUmlvMXRxK2YrZ3RBdVoyRERkdVc2?=
 =?utf-8?B?QWp2S0pqZFRkcmZvOS91dmE2bHFsSkw3OUJQbEpFWXdMYldHcWhoOUtDYW5v?=
 =?utf-8?B?UDBCV2VoQWFWSGdOcVBXL2RPajJMUzJUZVdFTmpXNGRSN3R1K3hDNGVBelgy?=
 =?utf-8?B?bkdjL001M0FoTVk2b280OXRnY1grZGoxN2lEcUR5dHI0VlZOcEh2amJ5QTRJ?=
 =?utf-8?B?TDhuMUQvd29saHczQjRtOFdiT0hkVkFOb0xRNVBKazJEdlE1RjltVFhyc29j?=
 =?utf-8?B?OWdzUTNFVjZXNjRLL01EWVNiR0JOMGVqVFdGRE5lNGljWUprZjd0M0IvRWg0?=
 =?utf-8?B?VEl1ajIxU3A5ZG5mWU1XRjZHaFNHdUNobUMvNCt0V0hYQUNURmtla25YcFdq?=
 =?utf-8?B?cWJZUlNqRFBGSFJtZ1lsem5lTjVmTkt3YnhrMGdyTCtDaGdtRHVpenN2OUZq?=
 =?utf-8?B?RXYwbnY0dUsvVHZjWmg1VmlVR2NydmRXd3o0Z1ExRVJIWS8wdGttd1FFUHM4?=
 =?utf-8?B?ZzRZd2JpVzNZVTIvSk1NOFFRSTVhb1U0THIwRXhlbDFwajNJU1RMRDgzcmhu?=
 =?utf-8?B?Y2g2UFIrbEE0bjZ0SmZlUlVaeXFnK3htU1pSaHd1cTB6bkJGSWxKL0xCaEtK?=
 =?utf-8?B?c3d6a2dYVFRtdVJJcHR6WlRaalFINXNXZmRvTUR0RU1UZm9zYVhtRWxUOUJN?=
 =?utf-8?B?YzNQUy9qYmJWY3ZJRU8yWndNRm0rc2pBWVpPaVNFUHFIU05VY09UVTRjUkVs?=
 =?utf-8?B?dXpTeU5tWFM3d0R5N0FzWUNIb2Q0WEU5eUM5VWFlVktJd0E1Tm1rcnFXVmtG?=
 =?utf-8?B?Y0llRmNhT09HbWc5R3QzOHdCeVpRcXgyMDhONFV5QzNZcEdsaFJzdjdVb1U4?=
 =?utf-8?B?UnQ5TEZHbTJhSEdldnNlTlFNZVVoYlhnek1LWUJqU0FzUUhOampJTFY2SjJm?=
 =?utf-8?B?L3dyNk9BRXVHWmRpRlRNSkM3dklvZVNmMTBHTWw3ZzNNRGF2ZTM3YnFwT3lw?=
 =?utf-8?B?bE4zS1F1SlRJdHhRTEVmb1BZMllUQmlES3RiT25ETmhMWUhnSGdXd3pFY1c3?=
 =?utf-8?B?YkdWeEFLSmhpdmVaRjJaaWlZL0VjUHp2cXVsUkZKT1NLWlRJSm5YOWMvbk1q?=
 =?utf-8?B?MitKaCs3cC9ock4ydnE1RU43V3dndWw5eS92WERYKzkzVzZxNzY2djJlcU5x?=
 =?utf-8?B?R3A1eWJLRmg4UUpXR1Fxb0tiZDk2Y1pGc3A1QXdZMHRxMVVxS0xKZlVKU3RR?=
 =?utf-8?B?M25qUjhiUURSU0pOZjNCTXptc0hYVXpnQnZ6WW9SQUFoWjFvU0NZcjlZUFhr?=
 =?utf-8?B?QmZlTXUzQnRkZS9mM09qNTRwQWp3bTR1U0dSMlo0VnV5QUFXSXJZN0lFL2Jp?=
 =?utf-8?B?STg5WkVQbGx6eHBFc21ISlpVNEJWME13TzlPQkxpOE5ZVzBEMFE1ekMxN3pI?=
 =?utf-8?B?aW1rL3BlelRLd09OVThQN1ZuQzkzY2EwZytrUlpvOUxRQ3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZvRkprOWdGbjRoYmRTSE9hdCthcVZweHFieC9JeTJvMlgyS1IxV05mMHhk?=
 =?utf-8?B?S0MvbUFuTTJkbmlxbWFRcUowZHB3alo2T0liMjlXbXVxRU5hcjFwb1lBRjk0?=
 =?utf-8?B?bVRRVXBYeDF1UFhpcG9vZmxiUjFib0NlcEluY3lIWHFEY2txd0diWHJJMHpS?=
 =?utf-8?B?V1BjakJUYmNkZG9Edjd2YlI5SUFoczBsUTNDTkoxNC8waWMzb20yVXUvVXFL?=
 =?utf-8?B?YjhpSzlyczdXdlNMdmZFcStXSUwwby82UE9wcEpuN3lJRkNQYWJIRzZYd0Zw?=
 =?utf-8?B?R2xHeFVYR3RtdGZ0My9kYjJUOUcyK1UyUEk3YW1lRXM1eUd1MXdzS1JVdUZq?=
 =?utf-8?B?alJiZC9kZ25iSGIwUllZRnFlSVd5N3Y4bjlTNGZYd2NTdTduZkp0WUVOdGR1?=
 =?utf-8?B?VUVXQml4N2xRS0F1eEhuZEVoSVphTTAyRGFCb2M2dnNzYzFCZEs1T0VyNnlq?=
 =?utf-8?B?MmsxVmsvdWpBYjJrVUhzNk9wS3NNdDdiR3grbThKQmIyaC84VVh6ZW92c2Nv?=
 =?utf-8?B?RmVidlhRZGFDY0k5SjVtK0U5ZUFOM1djT2Q1ZW9ORVYvQm5YTG9RNE9DODRS?=
 =?utf-8?B?TTE2MEI0cFNSRXYwRStjS21BYk1kVVZXcWU4d3lXVjdia2REWG1MdXhHQy93?=
 =?utf-8?B?U3prMDQvQXdKbjBEcFlxZ2gvQjBFekhCM0MwY0hvYnhXVWRZeTlxb0NrRDIz?=
 =?utf-8?B?ampLT3Z2L1YyTjNWUDQ5a08rQk5pZFlVaE0xTHpLMXMzRFFta3ZXSXVQbjRV?=
 =?utf-8?B?Sjg4blBVaVVaU1RoTVFBbG5RN01WWUVKcVM4dGNKUzNnajZPSzVCcGw1MDZq?=
 =?utf-8?B?YlBqRHlHbWw1QWp0M1gvK1B4cWhkMlc2TVVtWGx5MXgxUWlycS8rZnczNE5x?=
 =?utf-8?B?RlFjeUE3c0w5dGt6SUdHaW5XMGVMa1VVZ1NkNTJnYWlFQlpzZ0p3eWFWVGRL?=
 =?utf-8?B?cW1UQVgxNDF1bHMrTHNBWEdwRW1ERFdPM2xWdDlyLzZXUE1uVXhZTVdwMjFi?=
 =?utf-8?B?RDBzd2lxcUgvWDI2YWtWOThKUkN3MHFRdlF1WFB4aVNPMkdXalVkYktKV2Yv?=
 =?utf-8?B?WFY5NXRRc0R0K01HT25CbExmRHM0OFJXTVFjR3ZEWjJ6TUg3WFZQSVA1QXY4?=
 =?utf-8?B?NUFlcFc3Vmh5ak9FMmpNNmlHSlRWVmZBdEppckZMNkRNNkZQKzNGemF4ZGRV?=
 =?utf-8?B?MEhkSG5CN3d3N2VlQXZTU0M2OHQzbjIyTnNJdGRVcmhqN0JFd1g5YkEzS0hs?=
 =?utf-8?B?cjFwaXFBNmxqSzI5VWJ5bXBHS2hsdXREWHpKQk93UDAvc0QycFFLNko3OEU2?=
 =?utf-8?B?VUZQYWNCQWk1V0RsM3BySDVudDhjaGFhNzI3UW5rb0YxZnVxN3QycUNtZ1hI?=
 =?utf-8?B?Ymh2NHRycUpSbXlkM1NTTGE1M3dQMC95NWQvRlIxZzZiNGRFMzRmcWZDT1cw?=
 =?utf-8?B?Y1hvVTcxbG9kTTk1K0grQ0tRbDZ1OXZEekd0V3JsZytwQmxOZFpUbURTcEx5?=
 =?utf-8?B?d1p1ditpd0hSc0Vya1BlYnZUMjJLYTkrb0ZURUp0ZE1US1NVKzlOZXo5bXZC?=
 =?utf-8?B?NlBKUzFBT1NsYjBYd1ZUR3A4WXJuQnVLZjMwbE1rN3JRdkxTTVEvaVJJcldC?=
 =?utf-8?B?MlZZZWFBZWt6MTdma3AwbGZwb20rWG1DNGFLTGZoUDNMRnNicU5ORjRjTnF5?=
 =?utf-8?B?YisrelhvZlNCdWVzWC91cHBRK0ZjVDdMdURVYU0reWd5WlhGRkFraHdvZ3ZD?=
 =?utf-8?B?QmlhcXpQKzZtTXduVlNXdTB5cDI0dUExUU84ZC9sSFdTUmJDNWR5WmJHR2ov?=
 =?utf-8?B?WlR1VUNmbEtmcW1WTUYybWhuNHNSMVpKQVR0L0s5S29WTzJvaUY5dWdNTDNm?=
 =?utf-8?B?NUhScVYxS25scUxkbUNiUTlYUVNvZzh3bkhqOE9hU2crS2swNUh6ZkxjOGhH?=
 =?utf-8?B?N3lXUC9ZOHNaVHFPVTg3RnByVmp2RlN1aWJtWDlmbXA4U0dRdWsySFY1L292?=
 =?utf-8?B?T3RUSlo3S0JxcFVYc09ucHpXOWk1YVQ3ZDRYSVZJV096UkJKRnN1Rmg1SDVD?=
 =?utf-8?B?NU9xZ2FuRU56dGlUV0RFSXArbzZCcnhvSmdRWnVBRVhZSFl0ME9VYWhlaXpv?=
 =?utf-8?Q?9P1ZZML+HJIF/vwDAkCsSre7A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20b8abb-f97a-49cf-d6c8-08de2bcbe821
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 02:39:51.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRulYb/YCcWn6zjOUFsWo3C8UiU5WXtVlrEU9PpkjdhrS299XBYW9nIShkhkCgGQWQd3lsMKIat9TaAKDQRojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7664

Hi Nicolas and Frank,

On 11/25/2025 12:55 AM, Nicolas Dufresne wrote:
> Le lundi 24 novembre 2025 à 11:39 -0500, Nicolas Dufresne a écrit :
>> Hi,
>>
>> Le lundi 24 novembre 2025 à 10:49 -0500, Frank Li a écrit :
>>> On Mon, Nov 24, 2025 at 09:38:15AM +0800, Ming Qian(OSS) wrote:
>>>> Hi Frank,
>>>>
>>>> On 11/22/2025 12:08 AM, Frank Li wrote:
>>>>> On Fri, Nov 21, 2025 at 04:19:09PM +0800, ming.qian@oss.nxp.com wrote:
>>>>>> From: Ming Qian <ming.qian@oss.nxp.com>
>>>>>>
>>>>>> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
>>>>>> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
>>>>>> error and produce corrupted pictures, even led to system hang.
>>>>>>
>>>>>> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
>>>>>> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>>>>>>
>>>>>> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
>>>>>> Then this allows for successful multi-instance decoding of H.264 and
>>>>>> HEVC.
>>>>>>
>>>>>> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
>>>>>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>>>>>> ---
>>>>>>    drivers/media/platform/verisilicon/hantro.h   |  1 +
>>>>>>    .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
>>>>>>    .../media/platform/verisilicon/imx8m_vpu_hw.c |  4 +++
>>>>>>    3 files changed, 31 insertions(+)
>>>>>>
>>>>> ...
>>>>>>    #include <linux/workqueue.h>
>>>>>> +#include <linux/iopoll.h>
>>>>>>    #include <media/v4l2-event.h>
>>>>>>    #include <media/v4l2-mem2mem.h>
>>>>>>    #include <media/videobuf2-core.h>
>>>>>> @@ -93,6 +94,9 @@ static void hantro_job_finish(struct hantro_dev *vpu,
>>>>>>
>>>>>>    	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
>>>>>>
>>>>>> +	if (vpu->variant->shared_resource)
>>>>>> +		atomic_cmpxchg(vpu->variant->shared_resource, 0, 1);
>>>>>> +
>>>>>>    	hantro_job_finish_no_pm(vpu, ctx, result);
>>>>>>    }
>>>>>>
>>>>>> @@ -166,12 +170,34 @@ void hantro_end_prepare_run(struct hantro_ctx
>>>>>> *ctx)
>>>>>>    			      msecs_to_jiffies(2000));
>>>>>>    }
>>>>>>
>>>>>> +static int hantro_wait_shared_resource(struct hantro_dev *vpu)
>>>>>> +{
>>>>>> +	u32 data;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (!vpu->variant->shared_resource)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	ret = read_poll_timeout(atomic_cmpxchg, data, data, 10, 300 *
>>>>>> NSEC_PER_MSEC, false,
>>>>>> +				vpu->variant->shared_resource, 1, 0);
>>>>>> +	if (ret) {
>>>>>> +		dev_err(vpu->dev, "Failed to wait shared resource\n");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>
>>>>> why not use a mutex?
>>>>>
>>>>> mutex() lock here, unlock at hantro_job_finish(), if second instance
>>>>> run to here, mutex() will block thread, until previous hantro_job_finish()
>>>>> finish.
>>>>>
>>>>> Frank
>>>>
>>>> G1 and G2 are two different devices. If I were to use a mutex, I would
>>>> need to define a global mutex. Therefore, to avoid using a global mutex,
>>>> I only define a static atomic variable.
>>>
>>> static atomic varible also is global.  Global mutex is allowed if it is
>>> really needed.
>>>
>>>>
>>>> If a static mutex is acceptable, I think I can change it to a mutex.
>>>
>>> ref to
>>> https://elixir.bootlin.com/linux/v6.18-rc6/source/drivers/base/core.c#L43
>>
>> My main concern with either of these approaches is that it kills the ability to
>> rmmod the driver forever. The only working approach would be that both drivers
>> depends on a third driver that provide the synchronization services.
> 
> I do realize after the fact that my answer is a little off considering its a
> drivers against itself (not cross-driver, that would be a huge pain if it was
> the case).
> 
> Checking further, the ref to the counter (or mutex) should cleanly be gone by
> the time the driver is removed, so perhaps its fine, though best to test it.
> Though, in both cases, I'm not happy to see code that will wait for multiple
> milliseconds on either home made mutex or a real mutex. Adding another arbitrary
> timeout is also not very nice either. The current software watchdog already get
> in the way when testing simulated IP.
> 
> I know its work, but what about a recounted singleton, with a notifier so we can
> schedule work when the resource is free ?
> 
> Nicolas
> 

Thank you for your comments. I will consider a better solution.

Regards,
Ming

>>
>> Nicolas
>>
>>>
>>> Frank
>>>>
>>>> Regards,
>>>> Ming
>>>>
>>>>>> +
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>>    static void device_run(void *priv)
>>>>>>    {
>>>>>>    	struct hantro_ctx *ctx = priv;
>>>>>>    	struct vb2_v4l2_buffer *src, *dst;
>>>>>>    	int ret;
>>>>>>
>>>>>> +	ret = hantro_wait_shared_resource(ctx->dev);
>>>>>> +	if (ret < 0)
>>>>>> +		goto err_cancel_job;
>>>>>> +
>>>>>>    	src = hantro_get_src_buf(ctx);
>>>>>>    	dst = hantro_get_dst_buf(ctx);
>>>>> ...
>>>>>
>>>>>>
>>>>>> --
>>>>>> 2.34.1
>>>>>>

