Return-Path: <linux-pm+bounces-29323-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB817AE40E9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191B31887B99
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC59724678E;
	Mon, 23 Jun 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="AhomUoQ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013040.outbound.protection.outlook.com [52.101.127.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A503246BCF;
	Mon, 23 Jun 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682607; cv=fail; b=Sr1PCj5mNd93NLOIQA5t2JsnyJbMI6N78lwgHfQY1GGG5rXeB+3Q49Ltb08jQT4m72l7QbsME6+Zb7L2qhTXbkpbo8yRSlIGJ66eqEnLoFHi+cBn5yihUUXK2Sr3CWZ+loZ0BKtvuhtYe6Itd18zRrOIVZhNUW+NJxfh0FRkMiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682607; c=relaxed/simple;
	bh=sCBceEJnuPY4E0xjSKUrV4O7efFM4u7RwrkXSQgfAr0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XFIbTpRp/+UeNErgrdmmCuB13quI4ckYD3LLIporIwD0nkYUqgHS/ZAVchoO0hR6whlT2RjVz9Qw3QdUzuS3EdWTGS89wHePS7+Xb6emVohT5sHKy5YpeTBKVwYDAtwY1koijqgbFnx08O7Qp5e2dpRPxka3yzcenIJDQKFVz8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=AhomUoQ5; arc=fail smtp.client-ip=52.101.127.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVOt8k32Zvk7K9TW0w5uHMLNKyEjpLarobKYkF+v2HOSTUfy+oOKG7eg9s4kozSEc5wmgJ2GWSgcO6UGUCVgPk2kf20C5TjRjc8aI12cGM7YYK8ps/QRNC1NR/BWDGdh/CYOQYxdRnvqsOU8zSGHVGOc62hrH3hKaph0b/cR/kl2k0SPzYGIJL0xeC30d0VrlSbquNMj3Vfton+UxNw/RvMWwpFVCIMIST8GY8+HkvnYC+T7SkHclVC3zs93JCukPkymgINJ4W+0EZF3kvautFX5+Wa6i8Sfs7iwwoxJ0lbVN1aC2akdCw89kJHe7c32eHGZNbkdADgo98nxktooig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3n5MJwIa1UlX8Fmkeid5dUR+LgURceicz6Mja5Q9wI=;
 b=rZfdFiryHvob46k3V6uYoOwN8MmtxyEhvmiLzkqZbdAFJpfYvpF5nK2PV31XDrdwxXB8WzEBl9nN8wzb6reHiVa48LKrl6ipH9ryNOifAe9Y6L8G7krQTAxjWzKQegFrKZMDGAN830W6mTaGaZANmPFEy3qpEvJMwSepHm+aUv7iznHyV5xjoQSBkNBzw4tEbG/Jf8eg6/g47eWMew9bU6PPTL0yHvlNrmopBcKKDvG0vn4n+q8Jc0Bdwaq/E96i/5yz7IUepwOMYmrngGT4hAvHk+8xkQwPK7GBUqUDIUt0jP6/uFTZicuTRngJRRjX6z+9uM41hajEIGGPR669GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3n5MJwIa1UlX8Fmkeid5dUR+LgURceicz6Mja5Q9wI=;
 b=AhomUoQ5J5eEs6xveHwqiI2nq2jQysvHtZ19WPWHuSz7ROvPPzKpdCVk6/hnOkRoFHjIwjFflnjFTBADdtfmzqBHCMqIDX/LDBvpx13ezbQj/QCWvGzt7m6SfM/6+ZBqilysuRBJ93fFurHY19lBSBmAL8QuL2nZBo5Ow31eemG4zqOnzBHT8iaVKVkMAajzFVZJycJa2oPY/P83wb1uxfHcalQUumm8B7/2g8e6oBrj9f/UBPTaTkJK5ARpwfjtC3mE8Y7SOjvMnz3BoQxp2IrP2RY3wiMbtn9Fhq6tRPVOt60yYcohmY44eKVHa/Tu00xX3D0uvq6I9VoYgDeU+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SEZPR06MB6611.apcprd06.prod.outlook.com (2603:1096:101:18a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:43:23 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:43:23 +0000
From: Pan Chuang <panchuang@vivo.com>
To: zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: frank.li@vivo.com,
	Pan Chuang <panchuang@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 23/24] thermal/drivers/loongson2: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:43:10 +0800
Message-Id: <20250623124311.475115-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SEZPR06MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e3da14-cc9b-40b0-3e55-08ddb2538aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXpCL2VEcCtWY0RFd3h2N1puUkJYYk55WEVFSVVpejZIRGVBQURMM2ZkQXZo?=
 =?utf-8?B?MitGUEExTVp6Q2xSMGlHQmEvWHRjalhVRExFZlJzNThVM0xVRWVQVTMrZzRN?=
 =?utf-8?B?Vkd5RWhJTWR6YWwwMkdWNkNESlN3dGJYelJxY0o0aXRsY3VRajlzVVRuUzly?=
 =?utf-8?B?SUx4MVp6ZHlBRXEwSlhPNis0ODM3am5YajN2bm9CRVVBRWs2RmlvRHZMbDli?=
 =?utf-8?B?SUhqQzI3RHNCNk1jT3NSUStoUzNNYWQrMjhPMkY2QzlqMVoyM2Vza0xBK21t?=
 =?utf-8?B?V3dwSURqRVEzcHBoVFkzclc0eHlnQnhPWlF2cWlPRzl1bzlkb29xQjZFMzJC?=
 =?utf-8?B?dkNhTnVWdmNjRlp4dlNVVFc0WmRaNWE1R2lKZ2dGbk5EN0IzTUJRQUdnVUJw?=
 =?utf-8?B?cEhsOHVBS3BIV1EzNUFpL2N2VWUyZ2F0MTdxaGVPVE5BZnpWVW1rbm9URXNK?=
 =?utf-8?B?c2kzUXQycWNHQnBFUEVZVE9tb3FHQXJYM29PZXFGemEvK3hkQ1l0UEdrRWs3?=
 =?utf-8?B?MkV0T0hwS0cwcmxNLzFsV3BhcVNPb0Uya0pHRWh1d1pjZVE4akJsZDREVksy?=
 =?utf-8?B?cmNRRGl1US9PaXY2bnpyaWU1UHRSSDd2a1N2QWFEbWxPYTFEdDh0N2ZiU0Vu?=
 =?utf-8?B?ZWJFVjNXR25adEdoaWxrTGtxc3lna0h5VHdmUXhuZ0thM25xYnZTN3lDNzhR?=
 =?utf-8?B?OFJyRU50N1FMVU5HQ3FVUVZLSzRNajFsUjA5cTIrcUN5L2hramtMNHQ0SVFq?=
 =?utf-8?B?VjE4RnpKMzZPdVNXNlQxcm1uYTF5KzBoWGkzZFMwS1pGTDhqcTVBYUgwSzkz?=
 =?utf-8?B?cFJJbk5vWVltZ3lvNS9keGhyNE1URkF5Mng1WHZiekFRbGNvaUZ3M0lVOVdz?=
 =?utf-8?B?Y2QzWXRqME44cXBUMVNBaGpkdXVwWllBd25HcjZ5RkxjVjlIdWF0ODJRbDRJ?=
 =?utf-8?B?UDB5VnNRb1VqSnVFMmRQRFpWNEdLNnlweFVGeFlMSVErS3orSDdVaDlFc3Z4?=
 =?utf-8?B?NmV0QXM0WWNMbWYzZExRS0txQVdNYjNWcXdNbzZkVElJOFBTV0pIT1hmRGly?=
 =?utf-8?B?amdXa1VuOWZPOGQrY0R1QncranlSUFljd21VNDZHTEpxRjBUZVZBdnFNaTM5?=
 =?utf-8?B?Tk51TUtmWmM2U0hsN3kyTHZsTzBEemxMQXRScGFocFpVSnd4c21YWnp6dzd1?=
 =?utf-8?B?eksxdDFHcWw5YUJVaWp5MkFZR0I2ZVRCdnZmck1haXkvOHRXcnFLbXNRaXNh?=
 =?utf-8?B?bE5BTUhhRWUzYkhyN2paN0ZZK3pURTk3MWw2NWk4ajAwTHlaYUlrbGhlVFAw?=
 =?utf-8?B?WVlkc3R5UHpveGdRRzlGcWhHbVFDUlNVNFBVdlI5ZlRTbXk0eU1haHIvWEVx?=
 =?utf-8?B?Vzk5Qk85NW5mMXBPQzNYaS9tQjA3TDBMeTdOdGxKWHB3UkRubGFiYWRwbWt3?=
 =?utf-8?B?OS9UN0RFdWNueXBsbEZvTVhhMTk5MmkrQTE2ckpzeTliZTVENitiQVB2bk5C?=
 =?utf-8?B?dVE2RlJvblZ4TmZEamJWSFlHYktCd2E3WE1wbWFGZmtFTWtwSVBJTko0SlNP?=
 =?utf-8?B?MjNDeFdXQ3I2MzNJajhnYlFkdzQ5bEVaQVJtY2R4Rm9zYWVxTzR3STJUeUtp?=
 =?utf-8?B?TjN2YzVVelhuUGpkcDBSVXFtcC9uc3NUOXNsem9iZjhwSFczbmEwMERPdWw2?=
 =?utf-8?B?S1B4d3Y3ekdqWWRSQVAyTUwwdXBBeElKRmtIQnV2aWJKZ2dqYW16RUVucENp?=
 =?utf-8?B?bVBEV0FhbDQrbmx4VkxhOUc3czltbFRieUkxWHVDTDdIK2F0VHdaUVNpanIv?=
 =?utf-8?B?VjV5MzM5dnRmTXdYUWdmVTJJaG1JT25NclU4T2ZvbVdLN0lrc1owRXRGWHlR?=
 =?utf-8?B?U3BobzhGdEphRmN4MERnZkRBOHV5N2FMcmlUcU4wZFE3RjdEWFBPTTNWbmlU?=
 =?utf-8?B?ditiYUZRV1JEMmZCTktpTzlQL0Z4MHlEZUFpaURQb0dJOWg4eThHSVF3ZGJ6?=
 =?utf-8?B?T2ZpVlY2VXZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFcxRCtjM1V3TlNIRUptdk9CaUJYVDZBZlEyRkp3K3FEcHVMWTdQUkh3Vnlw?=
 =?utf-8?B?ei9OQUMvTHlCckZKd20yNFBWZHRZS0tnZzRoOVVkUkZrOUtsVzNtWm4rbjZo?=
 =?utf-8?B?dnZtWXAyRFIyMUJteHAxQjJLb3RDOHZ2b29VTWVjSmI2NGtWS2RYYzJFSHlH?=
 =?utf-8?B?Zk8vU0xibzg4blJDSXZmREx0QzR6ZWw0aktzQjUzbDd2dnJVWFExNXdWdk50?=
 =?utf-8?B?Vlh4WFErVC9KSVY3UHQ3QlJvM1ZqR2lkQU50MFhaWVJrWk1aVFF2eEEzeUFW?=
 =?utf-8?B?S3RaZEcwMk0xcWtBem1QY0lQdlV3VjRsdElaemFvUFRONWxTa1p0aWhEblhR?=
 =?utf-8?B?WVNHZ0ZmeXNFcldhZHRxUXlnWnBaYmlDbFRGUWpMN2RkRVpIcnFLc0tmaThW?=
 =?utf-8?B?ZUxMTER1dlIrZjVTZU93N2J6RDY0d3AyY0wwajdFREZzSVhFNzFmV0hDSGNK?=
 =?utf-8?B?MGIyMFJkc0J3ckEvNmZiNytBOFNnTjkxZTBwTWw1RHZtMElJWWNmNmZCQW5K?=
 =?utf-8?B?WVNNQXN3UThGeTdEdnJxRWE0dEkyMnR2a1FCa3FnWWRjdmVlcUk4eDMxdG1x?=
 =?utf-8?B?VGF3UzRFV2w4aDNNbk8xOXNuWENCT0tzMC85cmtuOWx0WU1ucWFmTmpwbjV6?=
 =?utf-8?B?MXZDZXlQS0U5UzFUajJxcDlwMkJ5ZU9EZmVMVmpjWG4wKzlFeUk3RXNwdFBm?=
 =?utf-8?B?S013UzI0Uzg2a1o5enExMFgwQVRwZCtTS3dVRnRwSnBpb0VOQjlRMjVIOFVP?=
 =?utf-8?B?Q1h4c3FqbGlMaldlMzJCOGJaUGliL01DMGhlZDFnTkd5QnFEQTVlbzcyMVNH?=
 =?utf-8?B?NUM0dm5ERkRBZTdtV2NqeXlORGRSSzk5MUhveVl4Q1g3cHRNQTBaT2JIYnNV?=
 =?utf-8?B?YXdKSEtROWUzaG55VFRPWmZZQjFtL29LQUFSSHdmV0szQi9MamdHUVpuM2xp?=
 =?utf-8?B?YjJjWlRXQU90Yk05cmxVSlN4dWEyNEVNVXhxODNZVDZpV1k5eVd3ZUtudGFT?=
 =?utf-8?B?MkxGQzRSald6OWFwb3ZMVEE3U3hZUmlsUTA3Z01zSjd6dWpoM2xkSU82QlZR?=
 =?utf-8?B?VEl2em1zSkdkckgxWGpOeXNodkdsOWFFMk5nUzNHd2VHWllTcnpUdU9RVm9H?=
 =?utf-8?B?czlwZEU3STBnckJOTmxkeU14RVhhbS95Tm5ycGRrVXdDZE9UaGxMV2NlWXFW?=
 =?utf-8?B?Y29DdWM1Z3p6eER5TFJFRFBSZXpBR0dYVjFXUTB2T055YlR6dU1adzRPSXdt?=
 =?utf-8?B?bUpSc1NLeWR2elVubTR5Nmk5eVJSMHp2U2EzUXJ0MWJySXA2a1lwcU9uS2Yy?=
 =?utf-8?B?TVlWNVFlM2lRVFJaRWFJRm1nL2N6OFlNTElpYmZxT2dQQi82Y1lrS0xGeS9V?=
 =?utf-8?B?WGMwNmlEa2VmWFU1UHJLL09mNVJSbFV5TGxGYkVUcHZ4dVBTYjloTktjczhK?=
 =?utf-8?B?ejVoK3ZydnhibUdiU3hqOXBicDJ0REJIMmNScGZ5QlFpSzVIZ0RHWkhGMFVF?=
 =?utf-8?B?V1FMYmVmNHVvSW1QeVdRc2poZ1VZcFhhQWlydjJ5YXh5QVBJS1IzdmNNMUVi?=
 =?utf-8?B?dmZYSHlodndBeHplaDRra1hGNDk2RVZJL1V4UytGVEpkdTJaN2dHLzh4VkJ1?=
 =?utf-8?B?RmRsMVd4bnRsT2IvKzJBclFZRjhQU3NxY3NaRU5xeG40Z0l4ZVpEcWZ3eG41?=
 =?utf-8?B?a052bzRFVVNsZ21SemZXdG9kVW9nclZUNTVXWUEzVm43Y3FIRXNMM2hDUDVt?=
 =?utf-8?B?RkxOM29PZnIzMFRyQmlqR0JiOFVnVGhVa0d5YzJrQzIrRU1wUXBNTFJVSXoz?=
 =?utf-8?B?UnZUdWZkMmVxak1YUWwrL21wQVBLVUlwZWdXenp0ZlpjYW04OUpsWm5wbjh0?=
 =?utf-8?B?YUs1U2tYeC8vbFRmU0NYdmZmTXQ1T3RQeUdVQlVwc0I1dnF3cXUxaGhHRU1a?=
 =?utf-8?B?M21vbm1ERVdSOE0vWVBzL2xNZGh3cWpUaCtPVjNibk9TR0t6UjZBMThXN1RF?=
 =?utf-8?B?YzlTeXFGTnBQdWgxS0RsVjR2V2FYUmhBUUh6V3h2LzNrS1JCS0pXRnhyR3I3?=
 =?utf-8?B?OER0SXhkalQ2K2c1VlRoWGFlQVJBUXRRMk5kcVJqTWNxMERjaGVVMmVLMHEv?=
 =?utf-8?Q?rUfkmDtkX9D3Bi8sivIwW4X1T?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e3da14-cc9b-40b0-3e55-08ddb2538aa6
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:43:23.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPv96XwvwsS4DASip21rDesM+cEVODE1+tiolXMfCeNBvxdyeUu9B+VbfIdUtW9uN3pbfPeoSD6LdgNJ5a5y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6611

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
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/loongson2_thermal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 2d6b75b0539f..28178d327723 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -164,10 +164,12 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
 	}
 
-	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
-					IRQF_ONESHOT, "loongson2_thermal", tzd);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+					      loongson2_thermal_irq_thread,
+					      IRQF_ONESHOT, "loongson2_thermal",
+					      tzd,  "alarm");
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "failed to request alarm irq\n");
+		return ret;
 
 	devm_thermal_add_hwmon_sysfs(dev, tzd);
 
-- 
2.39.0


