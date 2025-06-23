Return-Path: <linux-pm+bounces-29304-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10490AE408F
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE84188C95E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E423BF9B;
	Mon, 23 Jun 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ENWM7dDu"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E71239E84;
	Mon, 23 Jun 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682047; cv=fail; b=BelWhBy7YYJcJbp1dAXyEeyMu0z9yHrnkKrrKnun32cAxa+/bOUZascRfEWR2X9yuPJVkQuIKsTwiGK7J4fOyjq2McDGVa0JkINv6njMukXfvFhopsXIdFpmJ0o8aXr8E7evstmn7r1AB558O/29rCIbO6JErBY0RndsufOQWdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682047; c=relaxed/simple;
	bh=VKwNORudEizAqHSxQCbO+KDnH3oGJ03C6ZoJlXBMlUI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qhyhesqgPAwSBkjVA57VBifo3ws1C7DLKgiu9JyL0SgM8mOKIRLiNmXGE4GXq6OCmqQY2X2+YMae6m4mHtpqNyjxkR5jU8pC/ZmtDi5eoKMMF7Fi96986RiISqFK883NcZekKCm/kwQTvC9vYBOWXp0Pl7U5aWOiVTxD4k2fmGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ENWM7dDu; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpYFMLBQ8op7sJ/OC2AUEFpyl4lhQYnAkc+tTNjtUvZlciYuuhBxigMRmgLjNFWeRLzL2T2aSK/tdbu0oK2y0G9VHBsI2ESwpR2zgdR/qLoWHaHlxIqqwtpnP5cW+4vLTVGIlslzke7pgrICNUvTlqMVT6PdXurvUovPwivGLDw62VPMiaSFReR4wU9kdNLB/Q2VbIW7vi1wBPgpo7aPHqcC7gZ1vaHauvLPYvdiuEtRlNXjdl7VYptugdmmZ4ygfOtc3gcEVfwW29wcDCa7yS0O4sTCPiT14edikyyEu3t5rnvCy37oC2SENkUwgpt5+E3WmA3177qsO4Kjwj2Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSAS+UdF/2Ab3HHQ9yBDm26rWQXm+1hirRlkWJ11GXM=;
 b=Wqo2XHcbQk+VF+CXzOvFUHASwzEi0TQGHdYoByG3+R0MrZOpOxmz7xWFE825ZGJy/YZtD9e+gltJiz89BHB3Jf5dwwxTFpu0h0DqKxOthEViAhf9W6z0SURwq2T4IABZcsVnNGCfWCTsrIXa89mpFkkWE+osxvCZ65+rX7WcEYbFcKmi0rUXsVNFVS73iW+3r2ns463RTYy0urlHk8gfEtGnNGGVAAFAQyR/aVyAth50he1wZJSIxcn3VzFL3UN+Rs5hUn4TA3dry7+QI3K6eZlK4pG8EVgcbQo6/H2lfyJMIIXhfou9ooKc3EsWI7L0J9WQn/n0bAGy2zUuuSeVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSAS+UdF/2Ab3HHQ9yBDm26rWQXm+1hirRlkWJ11GXM=;
 b=ENWM7dDuC1rpgYd2GRi0VjfCGFuA2jYKAK98/a8nG0XP+SivpSo2IoOqG1Ba2v+CdTAMsE7KGsO/pQS2kmRoED9TK8Q88A/9g61Zxvk80jNapndAZaNrer8tlToxfNg7f5OpOWjsBIXAcVcPKusnhZa5S6cTg7tiYa13RRbzAeZ6SZPeFfl8PmLz5aa4atXtIhGDlqy//3k6I83GTEHP27lPrWey10QJXkKdNTXkV3QpJfHQ1ylwDpdr6A1Z7goxJGOuf9tMOlqPATGF5BJEZK8CTfM9e9pwuhPa1ekFNipDnCV40L1ZaMYUjxlCKFTnAaqYQujCgCzXJZhS2iTaEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TY0PR06MB5185.apcprd06.prod.outlook.com (2603:1096:400:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 12:34:02 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:34:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Markus Mayer <mmayer@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 04/24] thermal/drivers/broadcom: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:33:52 +0800
Message-Id: <20250623123353.472668-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::15) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TY0PR06MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e80cb9c-b862-4b0c-64cc-08ddb2523c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHhvbFBBSG1pM3FLMlFRYUFFd1grK25NUXdJSEZJdHF4SzRzUjcwMUNvdHZ2?=
 =?utf-8?B?K3lmU29Ga210RzM3Um1WR0VkM3d4RHBMRG0ydEdaWjVaOHZKblZzaStUTm1T?=
 =?utf-8?B?YkdpSllCWHNlWDVZcFV3d0pzZ3RBNlU4QnoxWTgvdDlVMlV3V293ZWRXQXJ3?=
 =?utf-8?B?VkVaaEdGUkk3SlM1VUZySlRCU0JHU3IwZHA2dml2UkNuL0U1S3B1SXhKZkhI?=
 =?utf-8?B?c1RZSzFjd21JUThhemFVM2pnZHhMZFY4Y3F3K1AzS1hITlhENzRtZy9KU0pL?=
 =?utf-8?B?YXpmN2xNb3VEdVlRVmlaZ0RJRWRUa0xtWXpCSVRISXBLQ0FwdmxleHMvTldG?=
 =?utf-8?B?TE45bWlCR1lyblA3UVI3SXJwbEY4aXV0RzYzejhzSkZQUnlWeUVHYmFnRy9q?=
 =?utf-8?B?RkVBS25zRS9pQThlTHVjWCtMRzl0RVhjVXczWVJOOHd4b2xzTmphTDBLNnND?=
 =?utf-8?B?ZFpSaUllUno1Q3dZa01oUkJ1eFJNYWpEQkw2UGJYNjlmNE9mYkdsOTZQUzh3?=
 =?utf-8?B?U0dBRWZabXRWbVBpM0h6eDhCaE9tQnFFM2ZRcFFIYkNoM09rNzREVWdTZnRs?=
 =?utf-8?B?R2ZWbHZna2VPLzZPUG5IeGpLT3crNm81cXN2Wi9aZlRvVjN2d051Wnl4NUdn?=
 =?utf-8?B?UkpkUDl0T2hzbnVuTTNOWUU2ZHBqbDU4SjVyUkgvaDN0aE82OHd6azM2MTlD?=
 =?utf-8?B?b3JrbEVja2I1ZGtvK3NRbkx2VHk3N29iaVZwTGhtWWRqNmpqY051dERnUkRy?=
 =?utf-8?B?YXpHRCtSaEs1WE9TR1pwbGp1b253MU8xRE0vVGRXeE1FTTF0REwrZDdoek1o?=
 =?utf-8?B?eFArYUhDa0tMSGNSeFROT1BTUzN6ZDlqenVLS28wS1hYNlpuckIreDNzVDJD?=
 =?utf-8?B?MnpLeDBlUVVaZkRrL01JTzRVV0xiYTlQRGhLQUQ1Tno0eHdQc2VRS2dOU1gz?=
 =?utf-8?B?ekdwSEVJSytSSm9SeFlVNGw0QW5uK1hYUXAyTk91WlFIQ1p1d2t6cGp3N1pw?=
 =?utf-8?B?dnZiaHVUTHVLMGt0Y2g2OFhpemhpQUk2amVtRnhkM3c1VG1kR2ZGUVdIZk16?=
 =?utf-8?B?K1RvK2R2V21lbmZzTE1YZnhlTmZXeEp5STFSdU1UOWVkRXd1WlhKdVdVQjNP?=
 =?utf-8?B?UzVEZHVoL0ZPbGpQQjB1cEVVbmlvV2t5Z3ZINFluYjJjTkZQams4Tmtlcmsz?=
 =?utf-8?B?dDBRbWFaVTVFU1hzN1V3d2ljRS96K2xkeDhWSEp6YzJoOW1TK3RISWQvdU9i?=
 =?utf-8?B?b1B0K01YK0pYMHZPT0lLcDRzTGtmc1JMZG9QMk5VNUx6MTNuQ1d2U1U3cS9y?=
 =?utf-8?B?ZFFTdEtIM3JxOWZyaEplT21BZ0E2SWVpaFM2eEtWQmN4MW5Cb0ZNeXFsQ1RR?=
 =?utf-8?B?eDA1eGJPbVpBd0k0aFlGa0xNN3psTG4wQWlxOTZaUTFPUnExR1djQVNmbE52?=
 =?utf-8?B?cUhwL0h3ZEVNdGJSOEtIby9sRVg0TDRHcStvb05odGRxcGRGU2N6aS94SmtM?=
 =?utf-8?B?MEIwMmVNZVJoSEYvTDF6ZDRDNjhGYzY2eUczUkVzenErUWE2TVVXVDBMa2s0?=
 =?utf-8?B?WnUzN1AyTHZvNXd0ZGhOZkFrN2tRWEliclZ6c3BpdjhZT2E1SGxuRkRjTlhl?=
 =?utf-8?B?dEgxeEtTVElyeDhDKzFIQWVkMFp5U2tEVGNXdlkzbHVWdFphNjFIZnlYMWk4?=
 =?utf-8?B?SFVwT3B2bG1QR2kyNDI5bTZMaUUwcklsUkJUMW9mbXdoNUtldHp4U0x0Znpo?=
 =?utf-8?B?T2RmeUczcll0alV6ZlBLQ1lXWU1WaVlzZ2ZNV3ZxNDF4QVlCV080SHBrU3Jq?=
 =?utf-8?B?NjZyNVJoRktnTjI0UlBWYlc0a3VrSlNTWldxcGF5NTZLemd6V28xNGtCcHdm?=
 =?utf-8?B?MHpFcVJoOTBuMVUwVHZrYkZnMW5uZjNFbW9qVkhPOThjeDRZVkIwUWsxczV6?=
 =?utf-8?B?OXM5a1FVa0RFM3JTaXlVZWxsZytvVkpxSm1XY1lraThtUUxaVk5HVFNYY1dW?=
 =?utf-8?Q?QxHbG0VnFWEvIjpAZQYSJdmJtziapI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emZJMVU4RkZqTCtwTjV1Z0F4V0lvdC9oSjVQMlJOUTF2YXJ4QzFtdTdqS053?=
 =?utf-8?B?Q2p5dEcyZmJLMDlYanF6UkJ1Tlg0TVlCdW9WVUNnMmtzZzJDYXB1aG93TDAw?=
 =?utf-8?B?YmFRSndJSzdWeUxGc09ndkNzYjlhamhoNUlpZnJwQ0t6SDd2N2l2UEhScHh0?=
 =?utf-8?B?WDhMTnBhU085NHJHdVQ3Q3hDK0lYQlRWam0vRjhUVWk1OEhCaW5BelZ6allN?=
 =?utf-8?B?a2E5d09Xa0xCOHBVOTMwQU5pK1BVSnZxSzhxSk50Z214eWhOUWtOVDdiNldN?=
 =?utf-8?B?Z3lwaUNoZG5ibzBjczZHME9JYk41OEcrTGlwYkd0THNUb2FUMG9aQ01ITnZW?=
 =?utf-8?B?NkRsN05JRlBURjl3ekJUY0cwNHQ1a00wYVIvd3R6Y3YxL1FuTHFkWFBkRVhr?=
 =?utf-8?B?MGxpYmhPT2dicHYyek1id0Z0L2tScUJvNGpETldZdkcvZkVsMjJ3T2QrUWF2?=
 =?utf-8?B?UHo4cFJOVWRDamI1MUJaeWVFd1IvQnpjNUJiSE8zSHZKS3hoZmYwTVV0S1JZ?=
 =?utf-8?B?QVErSHZhUFM3cU15RjE3MGpxTWQ3cWw1ZThnakJjMTg1bjhNUEdYM0ZjVHJm?=
 =?utf-8?B?SU9TMzYrcFRXN2QweDlHdHdiazdtRHRCc3dGeFlQRzBmM2NwN0ZxZ2JrMUxX?=
 =?utf-8?B?aEZLMWhlWEVBbDVjSzZmdUM5U2RjdWFRVmUydXBqYVZWbVFvMHQ3T0NBeUp3?=
 =?utf-8?B?VWw5ckY2aHZNblpYTXlTazZkQUpBOUpFL0xDMUR2RzV2dHpFSXh6NGtGNU9q?=
 =?utf-8?B?R3lleURSdm5NOURpQ3lHVmpLYkhvQUo0eWhlZ1djNWhBc3BuNHRCTzdSODc0?=
 =?utf-8?B?R0I4MTRIaEExdDlzUmd6RVdGL2kvdGNocERUbmRRbEZudEhGdWVyQ1N1LzEw?=
 =?utf-8?B?alNhRllydi9aclVMdmI0cUR4VU8wRGpUcEFFTXNjZVJYS0s1amVpV2JTWjZD?=
 =?utf-8?B?dGduYjl3NFppN1F3RUtNcThaUTQrc0ExWHNNUFFLcUNHZzY3eWFES0xSVnA0?=
 =?utf-8?B?Y3Fsemt6M1BUK0FCODRicTI5L2VTOHhWSi9QVExhT3MyVTRQMXZMVGtjZ2hj?=
 =?utf-8?B?WmRYWHFKMHlvd3YydHYvWm1QSlc0NCtQNTdNbGRMNWF6WWF2T0d0NEJLOW5S?=
 =?utf-8?B?SjZuTWIvaWZVVmpJa1Rsckw2M3VtVDhmUUtIUFdGWDg5akRiWlFzd0xKS1Zy?=
 =?utf-8?B?MWF6VlpLUTVJaUZ6UmoxK2ova0ROWk1QMnJVSTRJbmhtSDdkaG9SZzFZdG5X?=
 =?utf-8?B?OTVnOFQ2VDAxc0VyMlpNWTBRcjZtVHpWYzMrTE9YOTJrdmtkdEF3YVZVOWlu?=
 =?utf-8?B?M2NDUWdPdWVlYnBIb3BNSm9lU0dTMjJhTHhMcUtENXpXQ3pVeUpLMEtpMndQ?=
 =?utf-8?B?UzBiaVVNQjRsbU53OUZ6b3lTNVF6K0IrN2cxV0dhNGN3aTdTVGJaSnI2NUtG?=
 =?utf-8?B?V0k5Z0xlRTdaSlpIa3hsSkMrUU53TzErK3pXSFhuRWpPUjRYbHA1enpJb3BG?=
 =?utf-8?B?OG5INjJBUk54RFBhdzVnaDAxVHF4cnZTaENmVGpMeVhlSFZFaW5RNGxMYWkr?=
 =?utf-8?B?RXkwM1YzdmcwTmlIc2lWNWRtVm1tdHIvQ0JKZUlBZFY3bCtISkg2TVQyTnZq?=
 =?utf-8?B?RTU3dVRnZUNFUXpnY2lQSTVORDFJWUZjN0RkZENqTXIvZWRxWFpsR2Q3Sk5B?=
 =?utf-8?B?Ym5ZTVg2QU5oT2hXQ2taRHlCK2d2V2E4UnJPWStNbEpxb2hGaFBsSnQvMGVy?=
 =?utf-8?B?aVJMbEFBZnBpck9Rb2VhY0ppdjROUmlaTGtsMUF0S2Vzek9jdEdFZXNVV2Ji?=
 =?utf-8?B?YTRzY1lmeXdyc0xKeDQ3TTQ3OG1kYzVkMWwweTZZcmU1aVBJOGsrUVlDUU9S?=
 =?utf-8?B?SFY1NVRnL0FjWTljQ2VSY0Z5T29KVUdON1lqYlFscERwUFhSK1g0WmZWcVlE?=
 =?utf-8?B?OHpmVWRmbDZEbHJ4dnJQRHAxMlZlTXNjbSt0d2RQYllUbnBYcURsNWRjL204?=
 =?utf-8?B?biswUi94SlFxdXFSTi82bnR1L1N0VXVGR2d5VHg1WHVnYkFMbE1WQXNyRDd4?=
 =?utf-8?B?ak5kYUtUQkVGa3grVE9HWTZHNEd5T2MwRXBabk1zb0pRVVAxM2ptTDgrV1ls?=
 =?utf-8?Q?d2n+bGlHyfCXvoNw4KlQoM0QP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e80cb9c-b862-4b0c-64cc-08ddb2523c3f
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:34:02.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbzsrKOLQ8uuq6ZRIHANd1RjTAyOROAF7yjf70geoDSsMk5wOjKysFwM/WSV+rlNud4bbdzIEVZL6aruC1fetQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5185

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
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index f46f2ddc174e..c2648fd14267 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -353,13 +353,12 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						brcmstb_tmon_irq_thread,
-						IRQF_ONESHOT,
-						DRV_NAME, priv);
+		ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+						      brcmstb_tmon_irq_thread,
+						      IRQF_ONESHOT,
+						      DRV_NAME, priv, NULL);
 		if (ret < 0)
-			return dev_err_probe(&pdev->dev, ret,
-						"could not request IRQ\n");
+			return ret;
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.39.0


