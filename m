Return-Path: <linux-pm+bounces-19936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55273A00625
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336C53A5326
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812E21D6DAA;
	Fri,  3 Jan 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fdyth0dH"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CE11CEAC6;
	Fri,  3 Jan 2025 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735893786; cv=fail; b=Tmz/QGpv+q+fJASSnhNqb2UcP3nnCCaranZtyDxQeiZ7Zr3205cFrOumUpLG1Lgmx2YwmrurEEDw2nL3FiaXUppNUXAJJ2VsOadp9RHGDQgO5zXwrdBIb1njZ9hlpCtKAx0svk8ALKCir5SyfvAxOPtWDyYBuzy2+i+PvF58gx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735893786; c=relaxed/simple;
	bh=/EC8zCoNiyDgYUl3GWxR1c0E1R02p9BWvo/Wx1hJgus=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jJpYjHWtxzIzbKs80usLAC4llMmXJS5OgVtRWAjkj31AwHlrcpxFeWyIgyIOOwde18wyTK6J2Yq4ZWouyTa3HSDls6vbl86DHoArtJXLVOeHlw3ucC30tIPXfCCDQDG054aMOjVwVQSMPjEcfTfRlY+9P/F86pyakJk5zDaO+fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fdyth0dH; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agKHHPyfrGCfx1/RmupgmGQhMk0tyWaM3hP+kHcOKnIvGBYN7pFNiq+1Dnll3ulGM7oH35XMgZQ+JpkCxcIS+bDxUMx5pZTDMl8rAwIIfrOPO8fHFyDdp2jys6TR/nlW943GEGzS2tC7q3bfeoEOhKwkz8KS5bucUQly9JjNttzb+HFIz/emWfl1OYabuafAr55aDwyUfsGzrXqB0yAV2620xj/cRLAfoeOHlb/vWvAQl7tE9js9DxlROY3sYs8aCSCvPuQ080pMR7dUxbtlg+iGMP25teToCT9rSU/eBw2OuoungZKYxx02CjmgFatIDiT8EcdelIesFZMdm7UAVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsAJU3FUgsUM88m4mSGw1WR2K15UVHFt8h4YUCR7Im8=;
 b=KFWpXpecfbdDklWKQJShAadsHNCAfzS9k0xlz2emBIuTFumYWd6TriMe2U69HspmGoyreD5bxVZeq4BwoaKD9yQukeFDqOtYIWp7sMCyBvjJs9KUmXHKs1z9+ULYt3Fuv1F53USMx/jxdqCxLdy7NbgGqTeEM6787vqP8D4NSQgy7qQS5jB3gKi1AT2yEKsDEEzPy2JoicGcD67eihqYB+MV1DwTgawRb4LtLM8+A/oX2ejzI1fBhFi9OxNyrKkj0GM3gefxWeLULh4Mky3jBMWsHaOjt1yVFv9KiIKWXe74vUa6b7iLnYC+CrAPx7vXxAUFKlAgIFj3MpTzjno6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsAJU3FUgsUM88m4mSGw1WR2K15UVHFt8h4YUCR7Im8=;
 b=fdyth0dHKKfYgg5y0izdeQ9GTx/ypIiXzeY+cFZrLQMyvN2DqlvMKanwSi/AY5eM8h+P1pxMVrPeo1LoQiIdGzYUdBmP2801/p0o3cSX30JqGzNu87oE7gwYo4HCQAn4Ooh1T/uN8Epb39nrRoNSLXxqiLF1NZf8oA8YDWAZeIRuTeJEkvOKmYifR3zyLwjsujqW73ZBw6fRFcEo6T5BDZWU8DZvhnGEPM94RE+fHgBwuz09+u+3VZ9MCTTp4smx8QoSQYAnTaxkwlTHj9spuE28Eb3Ot4fG1wdN7YpWmAQER75UcUa7ZVAZ0KjH5bZaueS9U/1Q6gdgB/4r2Kw3BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7599.eurprd04.prod.outlook.com (2603:10a6:102:ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 08:42:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 08:42:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jan 2025 16:41:23 +0800
Subject: [PATCH v2 11/12] rtc: mpfs: Use devm_pm_set_wake_irq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-wake_irq-v2-11-e3aeff5e9966@nxp.com>
References: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
In-Reply-To: <20250103-wake_irq-v2-0-e3aeff5e9966@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735893689; l=1347;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7sZhYfT/a75JkuPsULgAYPAtV5pnc5lWQRqy0mNIenc=;
 b=pqdku+mazAjUpAScAyFxwTXob9j8RqYQyx11Y5TT6Khed5JfepTp0XYtWnVT8pAuswCVWDRMT
 m0ycP6frFQfBnZK6G/n8bGNw81H3gFP7Ep6EZzK7MuASSSJ+fCzeR3+
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6d6526-2acb-423c-4460-08dd2bd29f2e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFhNUE9sZ3NWek4rcDZGSW9qdEdVcEFQUTNXMzAyWDFYVzZtSEhBbi83dUlP?=
 =?utf-8?B?eUUxZGloSG80Y0hnQWY4YldrS1RBeDc5UHVQaVhFMFBSQ0h6V05mK0EvdXV4?=
 =?utf-8?B?OU5LQTRMbWFTOGRjV0dFQnZTNmg1Q05zREJkNzRkaWloSStVeFgxQmdtR1BN?=
 =?utf-8?B?cXQ5eXptMFFkWkhtZWN3cUQzc3dKeVVML0FWRTMxNlptVTdRNDYvYm01LzBo?=
 =?utf-8?B?TU5oeU5TMFEwVGVlaDVUTXBwekpUdTFWeFNua2YwTnpYaDhtS3BaenBPczhv?=
 =?utf-8?B?VFVUS0lQSVIxQXRITzJMOXNYOTlGSUM2aEVDcldacHFSZThiZ3F0R29MZTk5?=
 =?utf-8?B?SDhJNWw4YXk3c0xKclhMQ3lhRXJ3aGZ1UXVNZWE1ZGhQOEU2Q1UvQmE1R04r?=
 =?utf-8?B?d0gvR2xkb21sV1Z1YWREZHMrVDdGWUFQSUVrd3hONmRpV0MvN3o3aFc0ZTlN?=
 =?utf-8?B?cHhrQU1aM25IWTFEdlNoc2tDTGhMZXZ1dThYdWlFcXFKdW82Wkl6TFQwVGk3?=
 =?utf-8?B?ZzJ6QWdrME5zRmhtOGI5M3ZYcDAwOEg0RjAxY3dBNU5uRy9tZlFmanUrdVVi?=
 =?utf-8?B?WHFjeW80YlZWS2c2Zlh5cUNtL0FJd2YyUWkrRFE4WUJ0QWlGOXpDWTBXL0Z1?=
 =?utf-8?B?a2xMLy9mQThaQVJ4Y1pnTFJhTmhvU0h1SDN2MVI4bis2emgrZFRuTUgwaThz?=
 =?utf-8?B?RzBnVlRFZFRjQlJ4S2krc2wxV0dJY1lMUmMyVlFQeXVqR3FYR3BlWTM0amo3?=
 =?utf-8?B?N1lielBVMmJYb2tnbjVmb2RmcEpTOTBZdHhYaE83WUYzdytib01DeE56cTA0?=
 =?utf-8?B?Q21DMEV0MVl3R3RlZEtON2oxTkZhQlZoQXVWTEp3bko4OS9Ia3JKRzl4MU1J?=
 =?utf-8?B?ektuWThlWlhyTVh2Y20zblZDdFBxc0ZtczJoeDU3NG92U1FDWmwwOW5MVk83?=
 =?utf-8?B?WHcvam42Mkl0dVJpRlRtVFBOYTUxdlRReGV2a3R2TUVCNzNVZ1dWRjEzZzln?=
 =?utf-8?B?bGF3aURYRnpMeDZuMzJOaGx5Tjhlb1YranYva0srK2dFNU5UOEdVWDlFVlhQ?=
 =?utf-8?B?VzBWNlIxK2lCSE8wY0xwWWhsUVYzeGx6RzlWdDZmaVFVM2l2VEt4VEdxTndu?=
 =?utf-8?B?SGdlYk1ocUtTOVZaeWJneHZyeUN4bU5UbEVaV3YwSy9Uc0Z5ZEtJUi9iWlQ4?=
 =?utf-8?B?NXZ3Q1F5Y0NhT3IwTitmVU8yZHpGOEtCbHlvWG9yc3poUDMyeFRNYnY2U0Mr?=
 =?utf-8?B?M1laVTRFSVlOSHZxTUpacXk1V2VpbEoxN2lBRCtEMWE0eG11WktDOElrL01Z?=
 =?utf-8?B?WHZFSmFTUlZyVis1OC9jZFE1STRkM2xtWkhJTFdjMmJ6U3l2Mm9DZkdIcDBy?=
 =?utf-8?B?U1BFSjVOdVpqeTJHOENuTDUrMkxZQWxOT3UvTVBaRVZCRlZNWHNpRS9iYjdO?=
 =?utf-8?B?WGhUSGExb2lNMXNiWmxubnU2WVZCc2NHUStnRVI0Q01mdE54Q2I5RUVlZWcr?=
 =?utf-8?B?UGVxN1RQU1hwY3pWNTBEd0VZbGk2VC9JSnoxcDZoVUZWVkUvZHVoVXB2akJK?=
 =?utf-8?B?ZXRQZi9lRTBqNjBXK1NNUFo5TmhIdVZsajRqMVNVNFVMNHphaitLdWtRNzFs?=
 =?utf-8?B?R25KVXh3eDMvejlmdHlLSXdaelpPa2lrcFRqenNyUExUdFV5S1RwUGlUVHFI?=
 =?utf-8?B?SHR0cFRvL2ZZYWlUenMxNEVhV05xQXczQU5tUElYRW5HQVRQYVE0MkxTWElu?=
 =?utf-8?B?VDZvZXFkOFBrc3MvNzViOGN1TmNibXZjaEErMTVFbjNIUmphcXc1Y3daWlNl?=
 =?utf-8?B?M29CdjRzRFdPRjZPbjFGMXl2UW01TUtFWW96VTAxOUFmc0VBVUFVVFVKMWlR?=
 =?utf-8?B?SFFUTmgyRHRFdU00bi9QaXdiRTBETldFbG9qcW9lRE8rTzRPK0ExYk5KSnJE?=
 =?utf-8?B?NENZMEIzb2hTeXlMVE92VG52YXpmUnpUNzMwa09wQWh3R0ZOSEhwbVlmTmdx?=
 =?utf-8?B?bmJuaEprYi93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmN5dFViMTZrRVd1WEhpanJtdWtkZ1dYTjM3MFRINHBKRG1QZ0RGQlRjQ1ls?=
 =?utf-8?B?RzhPSlBtdUxMZFdiS3pvbFRNZG83cy9jNzZFMHNleXBSWnRzdzhRSEFOaDc0?=
 =?utf-8?B?bW1yZXJraG1PR05KaXFha3EyTTUwQk1TN3RteldFMWI3M0o5L1h2Tmt0WGt1?=
 =?utf-8?B?Z08wMVlQZDdBTzJ1d1B3UENzMW4rcDZ5QzJ1WW12QnA2aVZ1Qmo0SExlc1d2?=
 =?utf-8?B?VUpDYisyWi9kUmU4bUdvOGZWTWdLMlNNMWdoYWQ1K2NuSXQ2Z3FENi9HSll6?=
 =?utf-8?B?aFdCbW1Zbk92MnIzZ3p4OHo0MWRBb2JodmhLcTRHTG94azNaOVBtVHR2bFFF?=
 =?utf-8?B?QnZhcUR2SEw0Vy8vNWpYeHhpYzJTekNTa0N3a05qWkRvQUpLUExQUzFWU2x3?=
 =?utf-8?B?emtXbmtlQWZ0WDlPdTZGMGxKd2QyWDd5TStUZzJtc05aelZ3ekYxVWc2Nzky?=
 =?utf-8?B?SXpFZUV6NndHSFJQZ0lRZGNacjBKUndaRWo5am9XYjJTTmsraGtRSzJzVlJz?=
 =?utf-8?B?aVVPd3lsTzNuQ1JQdTVQbXdkWEU2b2lxWVlqZC85YnhJWHQ0bCtkeHZrSlQ5?=
 =?utf-8?B?ZXRaTEx4TG5uSjhmOXBqSUYrQitaTjd3NE1NUUtwWTdtNnZKUzZRSWRVd2Yr?=
 =?utf-8?B?amdTNERlYjJyRlFFWHR0Y0F4d1BNZDd3Wldmcnp3bzVmeVZDd2t6eXJxblJh?=
 =?utf-8?B?N0N6UFJwVlJhdk8zWFU2eHNxZ3VEdEFGWVNHV3JOVnRMSXNwVFVzd0w2T0c3?=
 =?utf-8?B?WnRsd05VbVFJMWpVMjV4NkJYc0VZRXl2TkV0cHlRZXEvY1UvRDlEb0tFQ1NT?=
 =?utf-8?B?QlFHcVp3MloyVzhvT3ljeFNiNkR3YlhVNlJYaE03UzQrSEJHZmdHSngzVWxI?=
 =?utf-8?B?RFBEZWovenJVZHlheWt0Q3V3bHpsUHdWZVA1Q3dLamFPZERwUXVFNGtDOHE4?=
 =?utf-8?B?a204aXpIN0liOTZQNVhaUEp2VEUvV3BZOXROalVRSUxoVnpSR2Uvdk5sR1ht?=
 =?utf-8?B?RWc2UnkrRDZ5VlRxM1lZa0pTRmcvNTFnY014TEZBNzVUUzFDN0hrKy8yZjQz?=
 =?utf-8?B?L0dCNm5HcHBJNWtBRWU5ejNUNzYvaFhHYThubXI3ZXhmN282NzVJdjZVMUhu?=
 =?utf-8?B?c1VpVnk5T0diK0JpZ2R5OGFrSjNRQWJWUjJyRmRsR3lJc2xEa1RESG8ydlg4?=
 =?utf-8?B?M1V0WkVZSnpOcmhvQnVsUFF0eUFZdWt1QWFPU0tnaW4rQ0xVc3pSbUl4SEM3?=
 =?utf-8?B?a0IyTU5OSzVuYmxaVVRuem9SQ3U1aXgrU21NczBYVmZoM3dpNHFlVngvUTRs?=
 =?utf-8?B?N1FmM0xWQ2dSSk8xZjRJN2tCdXUvQXZPa3kyNVBLZ2Exdkc0cTdHZ2lLeUdJ?=
 =?utf-8?B?bmRGSEI4S0EyWU1vVmJvVlMvaENsL01ubXpkMFh3VnJlWjhMa0JBT2pUVDlX?=
 =?utf-8?B?QXk0RUpKZitMSHp5Tk14TFpYSFJoaXlrVE8zbXgwaHhvRkV5ZkJtSzZhSm54?=
 =?utf-8?B?VTJCa2o0cnRvVkJPMVlGT3N1bkVzNWRhVU9VRU1jYkFkK3ErMmY0UGdlUjZx?=
 =?utf-8?B?WkovWUJmcmZacjB0eEpxdG1UOGJRMjdHdUF0WWhiQkZrMDNQZUwwSEFWS3RD?=
 =?utf-8?B?YnFhM0NLVlZrNXVnbjFwenYyMkZ4cnJUY0xtbDNnOTBmUVZQRzZPSjhsL3NR?=
 =?utf-8?B?dXFFMVhJdDlHV0Y5RVJBS1k5SUVjZ1NtM3JDaWdxVURXckZZNmI3ejJ5V3V5?=
 =?utf-8?B?SWVDb2o5UnljNUpxN3UybXJybVREd2pvMkFmYXFuc0dEZmNYS2tRZzRVaXdm?=
 =?utf-8?B?di8xQksrS0ZHWTRvbWRnQkkxUHRPYW1iSDdVb0VBQ2UrY2FxeHRMaG9MZ29M?=
 =?utf-8?B?VXNWQlJpdTJkYm1yUUlRUHFCaGFxZmgvUHEwRHJVeGM1bnQrMzIrRDlKd2ds?=
 =?utf-8?B?T0FjM2tUaVArY3NTWWVGMDBaNkVXVzlsblFHc0RuZGNGSEdMcXplK2F0Z0pD?=
 =?utf-8?B?R2pxQnZGVmUvUGZxVHJpN3FJbDM0UGViWHdnT2VwTzdoRGFaU2pIMkV4TExY?=
 =?utf-8?B?ZTlwdTFUZFVVVU5TMzlnTUJCdC9kUmg2QUNrNjlKZTdWOS9ZZm1GVGRONjEz?=
 =?utf-8?Q?k5ZtZ35/zwxY8fL2CpdWxawcy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6d6526-2acb-423c-4460-08dd2bd29f2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 08:42:57.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcKLnmumH38JFy6B8vQngVlbJeSSXnBV/m/ezhoyeuG+wTQhYa9/o71OXmuHdzKAKu3z/v7ZoBqFSAZUJjf9WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7599

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq, then the 'driver.remove()' could be cleaned up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-mpfs.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-mpfs.c b/drivers/rtc/rtc-mpfs.c
index 3892b0f9917fa7bc4f732cfe2c2b2f548ba7429f..5a38649cbd43b3c6f2fec5db95c4f0013deb2a08 100644
--- a/drivers/rtc/rtc-mpfs.c
+++ b/drivers/rtc/rtc-mpfs.c
@@ -267,18 +267,13 @@ static int mpfs_rtc_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "prescaler set to: %lu\n", prescaler);
 
 	device_init_wakeup(&pdev->dev, true);
-	ret = dev_pm_set_wake_irq(&pdev->dev, wakeup_irq);
+	ret = devm_pm_set_wake_irq(&pdev->dev, wakeup_irq);
 	if (ret)
 		dev_err(&pdev->dev, "failed to enable irq wake\n");
 
 	return devm_rtc_register_device(rtcdev->rtc);
 }
 
-static void mpfs_rtc_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-}
-
 static const struct of_device_id mpfs_rtc_of_match[] = {
 	{ .compatible = "microchip,mpfs-rtc" },
 	{ }
@@ -288,7 +283,6 @@ MODULE_DEVICE_TABLE(of, mpfs_rtc_of_match);
 
 static struct platform_driver mpfs_rtc_driver = {
 	.probe = mpfs_rtc_probe,
-	.remove = mpfs_rtc_remove,
 	.driver	= {
 		.name = "mpfs_rtc",
 		.of_match_table = mpfs_rtc_of_match,

-- 
2.37.1


