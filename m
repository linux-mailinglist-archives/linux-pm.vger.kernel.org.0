Return-Path: <linux-pm+bounces-29309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1057CAE40A9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBD3176FFF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B442246BCF;
	Mon, 23 Jun 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DIybk+2K"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013029.outbound.protection.outlook.com [52.101.127.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E692405E8;
	Mon, 23 Jun 2025 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682257; cv=fail; b=tEFsy6/A4XixDHuaKq/8Py/nmvzSUsgUEYpxsMZoWN1reeHPiw6aqmOCN4h5rMA95ye5JRYd8AmbJSqyz7wazaDTClrFZ3KJu6Ayux6EQ9r5xjHxDgtmzcSpKZUUCWMF6+FAtErdWLRLEpRW3EzkcpgprCJVtR1axeOmWtW0UAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682257; c=relaxed/simple;
	bh=8/889B3wWs4CdbuFn64r/+TA80ytDQFi0SRs20LM7NA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Rbc1VwMXzQR0bCWMXwfyAFeuDo9nlWiBkcf7jOPRY6r1WkfWuiYFyvIYbaYygUBOFFI/p4BdIM74yzCsEYA4zuMG5+DCuZEHvN4wRMiy9Lz2k5muIjwPNZFADLYOhbPNDcKdG0OE9cMkNKtO++4EHWEYmqq9ksQfx92K1ZdMgEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DIybk+2K; arc=fail smtp.client-ip=52.101.127.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hq48OZuqau2KuY5j8j1RNYZ+gVxcC7ulzjZwauj+eLQ+WO0j9HXKcAUgHmvo6wD+uv+1wEvbhVVf50czI8Yp9Kj2qK5UnrcSpXt04/YFyDMUfyVX1ZqxMeRCKnnRZ9Z859J+Xbe4biUdCBQN8q8dPiCBQAgYtYkTPzxymbYT/qLX6LMWkOVb+B0frM1n24+hM6hktsGXml8kEMqYuL1ZfbA4jziB4jSt9ZF2387LTk6iveNfc/42jwnb+fz9pjlG9gUg9Gz9nBXEVaBhLaimghkXKeyVEZpXG6y6akGWMVUgjKmXM01bWK9w2n3jrlpBojq1zco7PBkkNPlQ0mwXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfoKtx3IXsHDmHfIJml8kntbkjCIYh4Z6e6yKhYJxeg=;
 b=cepnWlwrIBR+JUSvixsAXniJWTSqYwlr/8oEDJ6iw6e1c0btz3+OJo9qPE9Fj0VPBSrx2C6wevoj3j04SqykKLp+X6c9INrnw6j59XaUD1fGWfTpHPa06yPm9Cr4bbcEkOkfv8VejWGF5NKMWegla7cIZnEVD49Z/POrt16t9Lr7/atScIgog9IfUCCp45fXWJnjE+iUhs4Z4Dw6ywmTBNHBCCXxx90l/v0Tp7ElObAqGoorAe11Fh/TwTbsK72Mfn1fzZ6gP06VrHfqUUoo9LsYEh0shYG5Hi32D9wGq1YzLU52GmnCVPUeq5QKKCxXPy8yhe2Mh2g1X03WZ12dDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfoKtx3IXsHDmHfIJml8kntbkjCIYh4Z6e6yKhYJxeg=;
 b=DIybk+2K3fyg/tkV7rS/lTmSKGNO+b4iJslC8vwSPc94h4AJ2zWWfIggbkaR2vKoiTRRDVA7tAA7ibhJpliUJY1JHnzLdpRIXHYG4veA/nVO2EeN7oxVLQuVU+74wJbMc2QMFSG+jUrJ1cP9KnQhnm3A+eTM3zpMpa9xSpdut0b7wx9YZ9YQr6osJK8s0914qEXqrOFZExStIxdLpGPjSEt5bOxyxsw2SeHzeY1SriDYUT4tDS406/Y9Z5cE1k7bqDUFSMIdfdDlony+uS51KycP86vcAmFlSyUgRdWt1fQHKDEv/WqxQDjUA9zVoNhjjKD3DBOEJ+AkmqbRG9mHDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:37:31 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:37:31 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 09/24] thermal/drivers/qcom/temp-alarm: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:37:18 +0800
Message-Id: <20250623123718.473645-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: aafe3a87-fc77-489f-15ce-08ddb252b8e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0o2MnlYMktJME5MMk1uQUQreUJiNFdZNUR4d2tDaFcvUGNRRHlJZCtJK0Yw?=
 =?utf-8?B?ZFkxK1dVUnRWR3FKSFA0SDFTS2VUNEZqYnZkT0dvUE1nb3F2c1EwU1dNUXRT?=
 =?utf-8?B?NTVCTCtzK3lRdlRKVlU5ZTRzQjlqOWEzdGdVNXFWQnlmSzZBUFRMUE0rc0gr?=
 =?utf-8?B?dWxYcHNjcTJHZVBUVkc1OC9kWjZKdWE2ZmNTOGg1eWYwcHVjSjhIaCsrSWNS?=
 =?utf-8?B?K244WE5VVEpMSmt5bHV6Wmd4RUJwYnNURFI3eDVYMDdsSDIvSHBqUm9uWDdW?=
 =?utf-8?B?dTArTENMbWFUR0sxcVdWLzl3VzE4Tnc1MlpzOGhVSm50NmhjVkx3N2hSRi81?=
 =?utf-8?B?ejhNM3JPVjl6dk8rQUhoaUxDN3FvWlpYTCtkbGkxZTZ2Q0xhaXhtMGJMMkxj?=
 =?utf-8?B?RjRZY2xSMTExSktrSkEybVUvR1JEbkxTZ1NLdkh6UHZTZmhScHF1SFMzbVRX?=
 =?utf-8?B?UDZFOU1VeWVrV2lqTDRJM1pmNi9lR05XRHFPaVMxNWFiWVFQVmFla09PS1di?=
 =?utf-8?B?dWp4NmpwTXBhcUxPaXRzdnBzbzgrVFBSZXVyR3BodEgrWFdBT3QwQmZJalpV?=
 =?utf-8?B?REpvZWlHRG9MYUVJL1k3R3FhYWdEZnozV2pvR0NnbGZtNlFkaldjcHFobktl?=
 =?utf-8?B?K0RYUnArVjRzMlllM1E3cmFqZG1UMU84Zjh2SkIySVdSYnZMZGg0MUtvUS8w?=
 =?utf-8?B?ZUJkTVk2YmIvOEYyN2dNK3U4MllnREtFN3QvcDEza2U0d3UwTk9MeXJuWU9q?=
 =?utf-8?B?aUk3dVBXaXk3QjFTUURiNkMwcDB2SVhTQm1XQmJjTXRWWkU3ZytRN0xkRkc0?=
 =?utf-8?B?M0lLM3Q4QnVmcnlHcEQwb2xicThZUWZKcHl2dXIxVFJQSzkyZlJ5VjdpWXh0?=
 =?utf-8?B?Unc3eXdlYUVDeG5ia3ZOUUJ1ZTJVeHdRUFpiUGJMdUY0SHJIWVhHZFovZCtE?=
 =?utf-8?B?alc0SVppaTQyQzZEMFV0TWs4eHh1NEZ2RHJaWXRCOGZrek5HUy9IUU5qWGgx?=
 =?utf-8?B?eUU5WUNQRlA4Rkx3TVU2WWRvTzEvaTRTcFZnYTlRdzcramZ3ZW1DbkRCRkZ2?=
 =?utf-8?B?N2hRZGwyaDNZYmcwVlJ1SEhoNWNTald0SFJqVWtWUExKaGxxd2tWVi80SjAr?=
 =?utf-8?B?SGdHNXlGeHBubXBIU1Y3OVVkNGU2YlIwTlIvb1dtUVJKNC9leVkxSSs2NTY2?=
 =?utf-8?B?aFlCL1dDdk5na3dmOWRrTkJ6aVYwN3N3dVR2NUJEUVorRFJEQ2ZabDVRYkJD?=
 =?utf-8?B?OEgyeEpNMGNxSGhFaU1YeWw5dExRVHFKQTRHUHZmQXhtVkV3eStVU1RFb2di?=
 =?utf-8?B?YnQ0elhZZ0pqM0VXdEZlOHZjSHUwTXFSTXpmalkrT0YxM1NEbnVicDVwQnZu?=
 =?utf-8?B?cFVPVStlNHJVa3JpMVF5cWlBYzhxU3lZZGxQVW5UMXhhZG1lb0plQ3FxQmQv?=
 =?utf-8?B?Nm1pQ2VVSDAvTlR1NmgvcUxZQStuZmU2aXBORjJPNm0yczFoMU92VHlMNC9J?=
 =?utf-8?B?M0UyZmRLenZITUR2cnMrMTVJbUVLQTRaWnk5MjNrQ2lTN2twSFErcTBoNFdI?=
 =?utf-8?B?R3Z2ZlpoUnc2Q251bXhtREtRZHBtb2xXN2NURDF3elY5ZmJQNEt6Z29VMkl6?=
 =?utf-8?B?UUlmVEFhZWhyWEFwbmJsd0lGTUZlb0kyZHBTWDJFQ0NqNndqRE1DRkhDRVlV?=
 =?utf-8?B?RmxWQXBIbE1HYkQ2eWtrOVNRTy82cVRlZDVTaUg1TXBtekpDaUJuTVhuU3dJ?=
 =?utf-8?B?aDE2Uk16Yk9LSEVoN0s1Rko5RGFKN0NiaU5uM1JON0ppc05SVy9KNWNuRnhx?=
 =?utf-8?B?ZEVxN2dhc25NT3dMWk9CZGtIZmpHNW51RHhqNUl6N3cvaHhjUlA0UCtnQVFs?=
 =?utf-8?B?SVhtbWF6Ty82MWtUQUpaK1oyUzNCVEc2Zmh4MlplcDFORTAzckQ4WjlSeVl5?=
 =?utf-8?B?SGFYWmNscm9hRGJlN21aaE1ERHRYb24rR1FhMVlORXozODNSVU9Ma25rQTNZ?=
 =?utf-8?B?aDZIR2I5N2d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVhuTXpMRi9mWlpiK1VlUUozMXAvaDNpVkVlQlQxNi9zWXp6MDVIVGhPd0Ja?=
 =?utf-8?B?RmQ4UFAxN2RNZUt3TTU4RmQvYkVTOGk0TnJ3WEZtTmlla0YydkFQVlZvZU5x?=
 =?utf-8?B?eDhFeHdrVGpjQXNrSGxUc0ZIemFJYksvb2VOdlNWMFc5cDI3TDNnWkFWNi8x?=
 =?utf-8?B?VjRwOHlkOTFrUUE1K3piRTUwamtZK041Y3hjQWtlamJBUWk1cjIwazgyVGw1?=
 =?utf-8?B?eWxFNFhFNThrOTE5SVlCTWVSUm1TOEVZekVXSURhR3k5dWl0K1JtdUZxTXU4?=
 =?utf-8?B?NURXMzM5eEVxQSt1YTZ6TTBVLzlab3lpQkNYKzZPd3VKanI1UXBpR2pHZURX?=
 =?utf-8?B?bWl3RUg1NXhqRkVwUFJRQkZsR1VPcEVrS1FVSVBYRkRxbmZqbkV2S29tcXdr?=
 =?utf-8?B?YmpycUhUNHlzb0w3NElyaEY2QUhVWWhtRmZlby93SU43MmdMWHpjbEVjbjBa?=
 =?utf-8?B?WWtHR0U2ajBadG5oQU5DMTJoYy9udWVuSWdEQitXajY1NW9xNi84bG5yRng3?=
 =?utf-8?B?Q0dEbG1pRTRlZjBab1VkOHYxUWNCWXpidERxbEV3SVJEdmRSVTFUYXNGTlJK?=
 =?utf-8?B?VzhtWmFpaTdnMVlrd2dsS0tnL1JSbGs2UEIrampROUhlM2k2MzVOVk9KdDg0?=
 =?utf-8?B?QmFXZ3lSUXJ5Z2hOUXVkYUV0S2swbzdYNWZIb0JjUzJHZkUxZE5wbmRJM1M3?=
 =?utf-8?B?WFE1Y2Z6RGFidWUvK1VQZTRCWGFMUUNHbnVOUlVsdU9lNDdSMTJVMjUxcGtN?=
 =?utf-8?B?NkdOeDBpdlRWa3pGN2toWk55aFYwL0sxUEJHMUtGYVU4SXNVMHFJeWRRS25M?=
 =?utf-8?B?cGptaVd1ODA0NU83a3RJVzZHZDJqb1pQNXJWRTZnbnJTMzVqZitkZ1RjZndN?=
 =?utf-8?B?UUxoSUREZ3JxeTZURFg4K3ZNK2IrWmgwMXhWSE5zUEpjR3pqenJXRVlqQmpI?=
 =?utf-8?B?WXB5YitZZDg3MysvVzVLWC9Ma1hLNWllcmUrQzBPamhaekRodTNEQXh4SEJa?=
 =?utf-8?B?VEhkTUxHbmc3VkRpbUVnaWhiOWVzclhhNzZVSlFwZTJ1Q1N2YkFDd292RElZ?=
 =?utf-8?B?dFpvcGsxVzNQSzhpYzBoS09LV2VVcVNHdHJ0R1pEVFdCT2p3a29UczlyMFpS?=
 =?utf-8?B?L00zN3FKMTZOTjArV0U1VHJYOExrdnBMY3YyYy9EbU94b25VKytTelEwT3I4?=
 =?utf-8?B?L3hWcmVBTlNRK25jbHBPVXBTVExDdUJWS3lVb0hsTEVwMzdRaXVNSGpxU2VN?=
 =?utf-8?B?M0FqUkNadDUvSWpnMTdrb0tZQVVpdEdHRk5tcWdoNFhEZG5nOTJmZGZGZlNl?=
 =?utf-8?B?UTZZcWt2Z0hDQ3R5Ylk3UHNha1hUZzRVUmpwNklWQlpoRHlBUENHQVZlRXhT?=
 =?utf-8?B?L2RSSzMxWVNrT1VrcTg2TFdrdDNzeWxVeFRmUXBlYjA5Y1d1N1RueHRYOTR6?=
 =?utf-8?B?RVRHK3VDbFRWUjJYS0JVZ1JHdjhHaTRGTnhXRitheGlBZGlwcmE0T1ZTejFW?=
 =?utf-8?B?R2xpeTBxMHVhTDkvRm0xaFV0NENRaFlmMngzb01EQ1VjaTZPK1l6ekorYWJD?=
 =?utf-8?B?RWxNM1AwU3FUQm9qR2dFWCt0OXpnc0xuUWpVRTEweEgyak56YlZGdm85Qjc2?=
 =?utf-8?B?bXZGaXh0Wmdoa0RqbHJjbmYydXBjOVhGVTZ1cTRGL003ZmJSWU1hWG53aDFs?=
 =?utf-8?B?YlE2RGxjeStzanNTRmRFMlJya0Rkb3JXL0QxR1d6MS9qNmFtZDZySThuUUdi?=
 =?utf-8?B?SkJ0aGRJc3NaWkJjSkFOMEd4cUZKSGszNVdzdUp2SVpPeXRFenlpZEpraVRl?=
 =?utf-8?B?VXlQWWIyRFI2a0FXcWVFTzlYVURJUDFEZ0h0cjRKZllsYmZjSkVQZkQ2STlk?=
 =?utf-8?B?YmVqdGowSlVwM09tWnhGMHgxK1dQZk1HSll6R3ZWZzBJU2Eya3ZaWWtYOWZ5?=
 =?utf-8?B?dE55bTE3b0FZNXEweTc1LzhtazRyWHFTZll0ejBSdm50QW1FbmlxaTUva3M0?=
 =?utf-8?B?azlLZmgzcGp2bm1TektVRFJPalFIeFc1cVRaYktEdjBLVVRuM0t5QnlGTFB5?=
 =?utf-8?B?V0JYTVZKZ1pZZ0NHMmJMZzRiNldlcUs5azlCeFNVRDN2UVBPemlhMWo3b3Ji?=
 =?utf-8?Q?gHWv/VLfTovpIOGlpuU2U8jfC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafe3a87-fc77-489f-15ce-08ddb252b8e2
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:37:31.7458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22cEk8BaB0xGG5ziDENocfvAHSE3/Wc6+LwuGfzoKpEpA//ciMmLg7u9UX7G1XPsfwta+7NnGboXm9Caj63ubg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6196

From: Yangtao Li <frank.li@vivo.com>

The new devm_request_*irq_probe API prints an error message by default
when the request fails, and consumers can provide custom error messages.

Converting drivers to use this API has the following benefits:

  1.More than 2,000 lines of code can be saved by removing redundant error
  messages in drivers.

  2.Upper-layer functions can directly return error codes without missing
  debugging information.

  3.Having proper and consistent information about why the device cannot
  be used is useful.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: AngeloGioacchino Del Regno  <angelogioacchino.delregno@collabora.com>
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
index a81e7d6e865f..cfa8c2cd9874 100644
--- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
+++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
@@ -432,8 +432,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
 
 	devm_thermal_add_hwmon_sysfs(&pdev->dev, chip->tz_dev);
 
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, qpnp_tm_isr,
-					IRQF_ONESHOT, node->name, chip);
+	ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL, qpnp_tm_isr,
+					      IRQF_ONESHOT, node->name, chip, NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.0


