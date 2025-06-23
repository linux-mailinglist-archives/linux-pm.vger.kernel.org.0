Return-Path: <linux-pm+bounces-29321-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44968AE40D9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A16E162C9E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FDD2475E3;
	Mon, 23 Jun 2025 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dQpjxFhN"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012052.outbound.protection.outlook.com [40.107.75.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB08244698;
	Mon, 23 Jun 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682576; cv=fail; b=LjzSLCqlWPLYCgSF4TzJ//neVojL4dzN2NDssHd7Cibs15pbD24+7V2C0yip7tq3Dbjh3MA5EUTctgTiPNUcSc63VFQFu+FeR/xa13lin2UgvCR0Dh5vNOuNid0t3spKDO2g9NfpzyS+8thxt2Uj40ywE1Q0WUzVhOlsINHfSK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682576; c=relaxed/simple;
	bh=T4rqxyx92kJm3oT1QC/l5ZmN0WiFE/A3hOPdqomjbq4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dUzFdZL1SfS9tblq5ApV9YCSXOnASIZCVtrZkSiYViw9Zo9UPaCwq70hB4imsO9v+suMs3KYBwfq9auyRBkzmSpuGN77lK0EGMMc6hu3I40qkI49Buypjg1a4AeN+vt2fEeqGtJCKUxqRZlvnlgYSvZWngNt6WgMFEq5hjEukAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dQpjxFhN; arc=fail smtp.client-ip=40.107.75.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nixKCJFjh5ppDI4GsnpYxzmruEk1qJYDzSgb3Nxs/lsAcjRjHgcDSD6sDwkBT2r6LncfWWBAkRbfUBHs21HiRdWGKTTuPncUW8C/CW/an5x26q0i+3k//eVhY1ZZUseBklz9PhpZjGe8a6Nb0oONnTokGUf2/DP6BzWFYIfScVndMBdlcYHb+LgSuajxLcDILuDU3X8pNT0qAQnNg2vO61pwrxHF0ZGIwQlse6ud9oBqNYRYneJXFBXkB3kLvIOE+I9BDetUIqbAnSLmdlti0Odog+wz76ZhWWsHTo2FwMzFHLziDtk4w9uJKe1TKcpC/yepqXekZLOSNXKpRFFieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqhSkztcBfZf7Ou773XEVRlGrXMGGnc1yBjon0KN4sA=;
 b=ilrq9wfXSV3qbS8aJRt1akHqR7h1qjbmepLGnqBxUqignVqnzSxPUZiYCCeWUijZZoyPivTLpuXWbWEdFwQppSVpl2lFBPKFZUGDZpoOyRrHdWKw/PGSZanPjr9KVWPLLFbNQda34QuUQvmYrgEM8NTyPFN2h0MY2jAiCv7NsNZQKRvSOffA26gpaBMFtM0B6VTcW1jej2NCfIKxI2V/S3SGk/uefj0ZOfPsk2RAKmJcxoj//xpio62gL+mmewKHdsbeFKN3/bd3NNi29pU0FWIBYxCI84v1MlmKtQRP7G4NDtfney/DCw+c+zg58ONUesGxsQD5Op6RG4ymDSEyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqhSkztcBfZf7Ou773XEVRlGrXMGGnc1yBjon0KN4sA=;
 b=dQpjxFhNLSI/ZSvgRgiAtVwr5MeVsTH93Ah7vn0fbK1cxIs5tqRc4QmBQSV/Kgb9vaI6XDQTtYtjV50j5XFRJXWJO0k4ZoqELd7MZ7BAXOk6NxhFenKHnuWEx+l8lSDuz9e2XKz0ohibDKyT/w4zkKVy8aB0cC9B3jIjo9KFmHhgeQFWidQVkdjED9Fx1dsV2ZxMzoSZ5VR4dbE49mZzVF4f59pbRW6S7aPjsT4Jww/KVdP7dsJ3RNxBBhs2tpyhdFJTMadoJOvsbnjWpibccXhhGFnuXQPTsrrdb2KIL0yzrApoBj8r1xK/82DuprjBv3AOliy3CB4jJcc+sJo/OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SEZPR06MB6611.apcprd06.prod.outlook.com (2603:1096:101:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:42:47 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:42:47 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
Subject: [PATCH v6 21/24] thermal/drivers/uniphier: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:42:34 +0800
Message-Id: <20250623124235.474960-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SEZPR06MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd86270-cc7e-48da-093e-08ddb25374db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WS94QWZQZ21rSC9KblZJUzJ3YkNYc01BbGFsK1lUc01XTTJwTnBVTVQ0WFpI?=
 =?utf-8?B?WHdaaHM0alNJZGF3Mi9YaHNLWDlXaXg5UjlGSkRkUWllck94L0hMa1hhTm1N?=
 =?utf-8?B?Qy9pTGIrVUxOaFkrdHRma0ZBQ29IUVJzeEFxTHZVek85UEVZTGZweElrb2xa?=
 =?utf-8?B?bDZIaVpnR241STRDYzczR081N0UvREIvUUY1bkdzVmprelZhZ3FneXNvTTJj?=
 =?utf-8?B?VEFyNnRuaEh0dVFwRGUzaGsyRGc2QWVrbXowd041V0RHVmI3V0NMd05zU2lL?=
 =?utf-8?B?aHh6TFBVUTQ3cEQ2ZmZEVnM3TXIvYmtSSjZSNVp1aTFvMUdCR1lTOWFob2V6?=
 =?utf-8?B?ZzQxcHlGeEpFUmFxTDNRdVZEWkFpRFFzbnNydTlaYVYyK2lVUGhlM0RNZ0Rv?=
 =?utf-8?B?WWpKeTV2VkU3Mzc3K1ViQ2taUXBHY0plVzF5QVg1dExudjZ3NTZpVUZCVi9w?=
 =?utf-8?B?UHVEcGU1Z2FUQTdLc2V6ZnNJQlRuZU5aZ1kwNnprMWE0aThPbTkveDhhc0Zz?=
 =?utf-8?B?elJMbzZzS1JRVy9TOUZCVmxWVnB5bm5rM1Z4dVZyOWtDTzRNcDg2Z2xSUnNZ?=
 =?utf-8?B?ZW5nem1aZWJGSG82TnNQeUFRM0NZZkxHK1VVTmN3MHJwQ2NwOTh5a2h0YWFP?=
 =?utf-8?B?eDY2NmRGclJSSTZxc0k0QjVOT2xtQmZIN2VQR3RaZ1NiREpWYlgyTHJqeUJE?=
 =?utf-8?B?NkRjRElLM0tnVnVFSFJhaUpCeHQ5RXQ3WDJSMXZkV3M2Z0JPMW1Eb0NGdHlI?=
 =?utf-8?B?di9pUmM2Mkh6QVJjb2lldVpla0NWRTdqemtwaXRVQlV1YWtvcndZRXpVZGRj?=
 =?utf-8?B?V3FNcng3bGErUFBVRW02L1NXUUdlY0xpeEI2azFUODZ3OExzT2M5a3FiRDAy?=
 =?utf-8?B?amRCNkhNaFJ0WkNmSW13WGs1NFR0b0pwdGdsZGRLM0ZqUzBnK010YnB4Nlc5?=
 =?utf-8?B?WWVHbzVxcG1aM1h2cFZBcEZmYk15K0J2bnM3Y2VEK0hwZDJGNzhQdHM5OWNz?=
 =?utf-8?B?b0tGSTA3YlhmUnZiK04xOFNWeFMzUFZZVEFwYlEyMDdSdFVIYkxnOVVYZ2M2?=
 =?utf-8?B?UThDamhoQ0MxMHNMN1FmUDlQYUYrOVRFTjRXQUNNSUJRN3lXMnErZ2Ezc0Yr?=
 =?utf-8?B?NUhRSktEcGpmT1d2SExmUWpHemEyKzAwV2VjZWxZeFQ0RTA3MFNKa21jV3ZR?=
 =?utf-8?B?aTNGK3h1amZ3NlJvLzF1UmFhSGVoSWkwZEZNV2VCQzF2QkszRDA1cU9LcVdH?=
 =?utf-8?B?MU84eS8vdkRBdlRvakZIYzhpNXZqUmZnZzdQeTJzdjcyREZFT1lCWjE2ZHNH?=
 =?utf-8?B?bzBmekxUK2plTExRb3hMaHZwU3RPLy80aDcxV2ZmUzVRdElZWmRkRUxtN0Iy?=
 =?utf-8?B?QU5idWdvZ0JWNFZJS2NTRmNOVUZwVnhlVGMzQkNOWSthRkxVcTVraU41Z0V6?=
 =?utf-8?B?R3Y3NjhaZ0FYcURhdjhBbFZBRlg0M1hSSXpkSTVSMjFFQkRnUi93Y0VkQ2hD?=
 =?utf-8?B?VzgzaXNaSUsza09qRWo1ZjFrVWRLZ1dmcWlNR3ZEajVtS3loQ2lsTk5MMGQy?=
 =?utf-8?B?R3BtMWFDMGcxd3RPdFp2M0VCRmNZR1ZnMUtXSGsxWllzd3pzZFFsZS9adnlo?=
 =?utf-8?B?NDlrdG1kRmRmcm0xSTllUjlhMHZTc2IrS3ZTbnBHY2tHQVFDVzBSMDJIdndn?=
 =?utf-8?B?OEFZNWM3YjRPOXhROG0vT1NzaWpCT2YyWDRSOVJiZ1dORDY3RGw0V0tNVWZI?=
 =?utf-8?B?Wmp5UmJCTFhHZDYxZnpMaVBKRWVPWXIrMzI4R1hwemNqcUcxSWRFNStISTBS?=
 =?utf-8?B?WWxaYnpHaS8yVnNFVjlQR3lYbVhFaUNzbEdHMUx0VzlIb2Y1Y1JwMGs3bnVk?=
 =?utf-8?B?S05kcUQ3N1dnNkZFK0NyTUM3b0ZSamRRVUxpaDE3Z2tHWEU5SXpsLzRidzJP?=
 =?utf-8?B?Y2htY3NESERPRVFreTVwUEI4WUxsdm5sZGNwTWVzZjBBbGlZb25wNWJUTzJp?=
 =?utf-8?B?OXo5dEt6SVN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDJsMFZ2NjJ0TjFVc3pMS01RNHVrY2Q5YkM5S2hLNlFtSFRURnpjQUI4VUlw?=
 =?utf-8?B?emxzQjhrc3AwRWxCNTl5RWM0dk4zNjB3VjdSdEFuZmlaeWJuYk00ZnZqSjk0?=
 =?utf-8?B?VXpxMkVWY2xBUnVkQ0tDTG15eVMzNitIT2JvNUhrd3Rla3dEMVZZUzZ1QmhL?=
 =?utf-8?B?NTNBV0dTbGdtNjk0SUU2OXZ1cmRkUjl3TlBscGpDeUZLc3VkRUh3ZldXK1NH?=
 =?utf-8?B?bXBKM3dxcU52NEZ4WXBUMGswTnJWczdUcjQ0WDFNaEtNeSthNlhwTUZxMmxt?=
 =?utf-8?B?a1UvYmJua0trNDZMbVlFUVcxSFZtZUp6OGFlYk84eVN2Qk5Rb2hONnZuaTdt?=
 =?utf-8?B?bFBEb0twSnppL01zVE9LTmphanhIRmoweDgxcUl5MWFQRTRTS2xvYXZ4cGFE?=
 =?utf-8?B?MFVwS3BKeDJGWGpSbGpBdTZkKzRzcG9CWXp5NVZGaCs2bkU0cUd4aWlmOE5D?=
 =?utf-8?B?M3RzUDB2OUZKTGxWWHdReXZvaUpyMGJxaGFSMEpnYnltU3g2cmVJaForZmtV?=
 =?utf-8?B?ajFhd05QS2dubmU2ZDNNeThkWG0yeWxuYXQvaEZUQTdneFlpMlVpcTM3TnVE?=
 =?utf-8?B?VXQwUkkzOEl0T242TUJQNmlya1E0cUhpWEhTMEFFdTRFZUQ3SkI5WFladklQ?=
 =?utf-8?B?STRsWGc0ZzBtTmZUdHFtMDVWOEZCVXJKcU53YzNiWDBUODYxQTJHdzBPd1pl?=
 =?utf-8?B?Y1NEZU5MTnRlN21qL1dhUE1sYkxJNklpaTZrQ2E4R3c5WWgwWjFiaGFBVWtJ?=
 =?utf-8?B?VXRaWHUvL3lPa2IyOWJRLzFsUzU0M2V4NFFkbk8yR1gyeXh6N2pvSFQ1bEVW?=
 =?utf-8?B?QUhJRkdXWjg0K0wwYjc4ZGlFRkJFaUhMcVNHRkQzRVBjRjRCTDlIejd6d1lF?=
 =?utf-8?B?LzZ5SXlMZWVaeEtacEVxaEJWT3lhd1BzdmFaeVZOT3RqbEFuK1V0WjFkRkFm?=
 =?utf-8?B?WGZ4QVY2QUErU2FEKzVjdmZVZktLRDBJTW9oSmpldWVKVndOcGJlcnJYYXRH?=
 =?utf-8?B?N1V0cXR3cGx4K2w4Ty9jS3BXQ0NmOU9TaU5NS0tUbHZXNHNRZ1JpeWJ5KzBG?=
 =?utf-8?B?VjZXcDk5ZUUrK1A5WnF2Q0ZYSm5yemM5UzZRckFHQVZ3Z1RNNmJQN3FJZ09n?=
 =?utf-8?B?TGVOb0JKQTZMYU84VHdhOGduZkh5Q2dWcU10VEZESndPRDBDNk1sVmluZDg1?=
 =?utf-8?B?UDBETnVSNlVnZE42eUdYaG05S1Vwd09MMmxuSkJYZ3FBdDY3SkxLQWx0WEtn?=
 =?utf-8?B?L09xdEtCcVd6MXRsaEFhM1lyUEgwUEdpOThSbnBLTk0reTl2WnVEUjYzOFR6?=
 =?utf-8?B?Q2piaDR4QU5lTDhSd3ZKMGRBeWtzRmhCNXVROHZKOVdnWEJyc1ExRjVLbGls?=
 =?utf-8?B?OXdIQUxOdFUzUTlJK3pidStyV20rWkxLYlYzcUZmRjhqTzRJRXgvYVdQdW9N?=
 =?utf-8?B?UElrZDBFR29yS1F1Y09CNDJ3WjgxNnh4aTBiQzBSVnJsOExtaG1SWExQaHoy?=
 =?utf-8?B?Qk5SQ1ovVS9RY0c2NzNYeVpyaXJaV3hNWDc1TnArNGZUeHpSZDZlRkVCd2Vx?=
 =?utf-8?B?ZlIvRktqczIxUVVtWGFTSzJSRm1VVFMxWndrNDNkbmZNSmJ3RmthaE51NFI5?=
 =?utf-8?B?TGg5YzZ2bGRzZ3NIcUV3MzJiQ0xpU2hweWY4cEpNV0RBbUJiSFRIM1VzVTJr?=
 =?utf-8?B?dlVqUnhQd2hERnJ0blY5M2dEbWxtWCt2NVJ3UTBOa3lOai9DNjk4Y1RPRWZF?=
 =?utf-8?B?akVXalAxQ1U3S0wxV2o4cENrU2hrdnVVRHFoMkxjem1xVmVrRURLaWRJaGlq?=
 =?utf-8?B?UU95UXVOU0J5Vlp0bjEzaGR0UEc4TVQvQU9RS2s3b0pmancycU1McU4rUi8z?=
 =?utf-8?B?b1R4eG9ZQUNtamR4Y3pDeXRWcHBmdGo5a0dzT2ZhN2RZbklCZE94SHFVaWY4?=
 =?utf-8?B?MFBOajQrdGVSMjZNWk5FTk0yQlViaU5BU1pwa2kwOEoxaFRJNDVxY0Njdk9k?=
 =?utf-8?B?R3RtNjV5Q1Z4ei9qSjROVFVLb2RtZUVXTDdhRkNQMkdyTjdwRlM1NEdpQkkv?=
 =?utf-8?B?aU1MTVpjcHpZdGZsa21QTmxRaEZnVy9iRWdJa2Y2TkRDN2tHdEQ2SnBMYkll?=
 =?utf-8?Q?r6o4ed7SMewcZAS+uqM8g4l1u?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd86270-cc7e-48da-093e-08ddb25374db
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:42:47.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X6p6LncwqNfqoLvU0i1kkNS9aYTg6cIBtI7kG+X51eHz2aydSA8up2FI1k1Ic31b7ZfQQ/uuA0OykTOGEc7wAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6611

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
 drivers/thermal/uniphier_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 1a04294effea..af2c84fbb2a5 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -298,9 +298,9 @@ static int uniphier_tm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(dev, irq, uniphier_tm_alarm_irq,
-					uniphier_tm_alarm_irq_thread,
-					0, "thermal", tdev);
+	ret = devm_request_threaded_irq_probe(dev, irq, uniphier_tm_alarm_irq,
+					      uniphier_tm_alarm_irq_thread,
+					      0, "thermal", tdev, NULL);
 	if (ret)
 		return ret;
 
-- 
2.39.0


