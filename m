Return-Path: <linux-pm+bounces-29307-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC983AE40A6
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B381887107
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12C235041;
	Mon, 23 Jun 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QjPG81v3"
X-Original-To: linux-pm@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013064.outbound.protection.outlook.com [40.107.44.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE323774;
	Mon, 23 Jun 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682176; cv=fail; b=PGFdaVL4Y0ZAlE+8LTK9TJ2Pyu7rSdB0u2S7rTJPBSnRU5jlB4ahP0Uw8M7/A0u0H2USzl8d4NFTWQFQaNf+AhkBCnPoH8Xj0Smd8p3yZQ1ZkEMIXI62G1aHg2XIXNLK3KVyT+JJm5Llmke+xDea4W2nfGqslrFBHQcYblEr/Ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682176; c=relaxed/simple;
	bh=Z6mISyWjjCQRqjbTBR+x1+45gCEDP8q/2ga7mnrW4AA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JP3114rLE+/gEplwoO4mE9ZXFJwYA4fa2NZd9gZFwZn5ZXz9A5Q3veaqdgNuobGICNjOqIH+s/GR8P95f+hpNUrBlO3oL7RVkY4GSv4zUm7W0qCJJJGyRP7jBAupdNu8jPXE0agEtNPO3lSr4ED33l672Rt6sGKwBRferBFrx6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QjPG81v3; arc=fail smtp.client-ip=40.107.44.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQVTaf+yjqPvSdhVQgjaA9TYq4X+If2ucoAGc0xqEX7ZQwhQjGmM3+FbFjrV4qGjkW3/rviC6JtMgTWIAqA3GnYU05NZcQVYk6BgUXXs38F8u96ayc4fjtFnDjFBhFLOZ3GRUKDuO9nD8aGEJo5kAJUM7vrqldRaV8yXv1T45d9zgFUSOVlYGc0zVf8PEClJ2XpP06yREHmTaxTIA6LoTKZcVGTCTYMUo9kKZoho4pjcgURo+gSeH3NPh7xQpRieXo8d72ZktPmYpM7YUb4e90DpWiJTdwYW58sgI6U2XMgBA+LDKiKOA8ytyHUolQ/95ham8azsyXyb/jxEn5y8pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPlN8MdBJcqrXEKurLyx3nOR6zybLMA/GkAZYGQrPtk=;
 b=L1hkUFH0JewsyJfvuZGx4mJoGMhwd6iSd6I09XJFxb2QAjnsy7w6TvH+UpFLBY+DAOc/7Hc5Q1tEm97kVogaZ0w6PTsz49fM6X2YFWXcqHCnb4P0LVR9Q6F0tw2Y5p4mwTRbaY0y8zayuJp3KV/f7VymFEyuvkjrb0UTgW4ATrQ5wuXx/Is1c3N6GaYPcgV33tEC1oGr1E5MFWzjQS/VdO6j4rmUbdzGAWnNDExHljvWrHkL1khgLAni8PkiUSTaL3TPeqy2xbxms2hukcZn2u8eZmo95Kc1xx5ixYEm8kzteJVrERzDnG/GyYO6wJxN5lXMDSz0dMX2LFZZqrkDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPlN8MdBJcqrXEKurLyx3nOR6zybLMA/GkAZYGQrPtk=;
 b=QjPG81v3M7JzJOhC6nN5PyHYrV/cpdU0h67eyOZ3DvYTT27oltYu1NCZU+9y9XzRQdD5sStLrVTEK9NC7MQWnp4dS2bi9YWrqAgdhdNjGx5c3K4hoQs1IpCiHwz45NEoGmVFKnkBOAOR7CJ+lk4ts4wK10x3Hhrz4ls2fHakTaDV8i+hoJgXJ6cXERPoAAAeHaDYL+gubYX5v08tSKMXZaByuVYd4fmAuqL8/1FNfmrSy3K0MNZSRI5r4CdZhM0+wq3Kqi7G8qFG46ec40PPFj617xXwYrp6gCWkbKzkOFA98kIUkYiaNpI5icTEiAaAyOraA3UEKd/bkjkUypUc3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:36:12 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:36:12 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 07/24] thermal/drivers/db8500: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:35:59 +0800
Message-Id: <20250623123600.473428-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: a350c82d-e63a-4e13-e113-08ddb2528973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3JiM0JvTHQwL3YxY05XdkVKb1lrNUNEaE50OGRnZU9OTXlLVEJscE9VUWUy?=
 =?utf-8?B?Y0ptQTNvR2xqUzdCNUtuZ2c5eStwY0FqeWNibEdwUTJOM1ZuSG5QRWZBWmQv?=
 =?utf-8?B?L1RDZVpiVmtHTndGMVdzN1FxVWlOMDB3YlMzZDBKVHpRNmlPZEU3VlZYYTZP?=
 =?utf-8?B?N1NiK2o0ZE5NT2FxU3h6enYrRkp4U3RqSHJGNndmYnZNQ3JUYzV0YzBIRG5D?=
 =?utf-8?B?Wk5ZWVNBTEd0M0RiVjVUYmNDQmpoUzdwQU80YzZUWnI3UlZ1U1ZvT2crMXRa?=
 =?utf-8?B?cVhzRlpTMzdadHJhdlhOdDB1WUtpQThlT0piMHQremRMQldpb2twNEcvbktX?=
 =?utf-8?B?am9WY3VtVmNjRUFQMXdCYit5ZXhhRXdkMkh5NWNiRER3anZjbW85dFhRUFQ5?=
 =?utf-8?B?dkRyKzZ4cXpUc1hrU3VDcXpnQmtOTGY4TGFqZ2tGa2x1WmRNVE9nV1BPR3cx?=
 =?utf-8?B?ZEsvN0xlMktqTDJ2bTQxd3A1SGlPMk9DRkJpMTRLSkN5VWc0NFBWa1lFOHV1?=
 =?utf-8?B?am41dlg3OXR4WDNBMGY5bndrQkpIenh1VERTaTVTdzdMcFdGQTQzS0NYNmIw?=
 =?utf-8?B?amozczBoQXYwMzh1UnFGb0VLYk00V04vUXNxWFJacXlaL3FEM3lFQjcyOU9O?=
 =?utf-8?B?b2ppaDZBV2lKRkZZMjhSVmdET1p1dTcwb1d2dVJ5M3lZUFRWbW5RZFM0MjFM?=
 =?utf-8?B?K2VCNmhYY0RQMXYrUzhMNWxDaHNaUWJ1akozZ090Y2N0NGxreW5UMENDUzlC?=
 =?utf-8?B?YTFYUklQeUxFeHYyakJLbkVLZjJGd2xIdlNmYUxVUmliT2NIQ1NiNVQyS24z?=
 =?utf-8?B?bFVYLzk1cW5IQ0ExUmgxbEF1NFVFZDJNc3QxeUl0Z3VGZkF4TUhqb2RManZB?=
 =?utf-8?B?UU1WSGM1eDd6aS9MZ2pZNWRFekpLRHY1M2crdzhWU3NFWHppOTAvcTQzRG5w?=
 =?utf-8?B?a3RlVExYbnExRFdOcXJZZVd1QnNvbWNuMEdJZ3NIaWZQZ05QOHlqZk1ySkky?=
 =?utf-8?B?enhWMzROenZoWWQyYTRGQ2pBaU93MUJWTVlPUSsrSUFBcnZYdms3N0FzcWtU?=
 =?utf-8?B?ZkV0TDdsejErbCtjNW50RkNnMC8rNDRlWEtLUWVkcWY0MU9GaWhNN3J1aGw4?=
 =?utf-8?B?eEFiWXFmUWFXMG9xUm5BbzRKTHU5dUFYcEJ3aWlSZWRhemFQOGYvcnZWb3ZV?=
 =?utf-8?B?NXgyU1hXTUdhYUVQMTBha3UzcFI0aUgzNWh4RW1lblRrOCtHNHJ6M2poeWQ2?=
 =?utf-8?B?NWNVRzhMM283cVhDZzlQTjJOdXNUSmlJdEVuYmREd2R5TWEyMHJlNXBJaDRD?=
 =?utf-8?B?WnJXd01TcmlzL1N3b2NnMHhvdFpwV09SRjA0T1pDVThETWlCZkt2cTZHSUp3?=
 =?utf-8?B?bDdIMUdldW1Fa3dIL1Y3ZVEzYVNlbmRRRm9tRG8vQkw0eWxSUXZUNGF4cnRt?=
 =?utf-8?B?VUxxOWZBcWVqeGFoUiswQSs0M1lhWmFUZjlxbHYxVTF0ZThrLzhOdkkxcmJm?=
 =?utf-8?B?QWRkVmROa09BZS9sNzltVVhRY3RMSjFwYjUzV3J0QnRONHZ1VDV1SkhsaEht?=
 =?utf-8?B?dDVQRHdXeG5ZMlFwRVkwTlFJU1AzM0tPYnVrSDZRczBlYmdROHhIVFdhTDBv?=
 =?utf-8?B?b1hLb3NvTXpiTVk4SUFxVnFCMTByOVpWYmRIMWpmV0FuMVlrNTJZWmlrNHha?=
 =?utf-8?B?U1VFNVNLVWxiYXUyOFZmVGVkcVFJenR5U2hUT0VteVNyZ3NzSG10Tk44dkpD?=
 =?utf-8?B?c2V6eDB2NGhGYzRSM1hnMXhZY3o0d3RQSTJIWFpsVENlOWd2K3BOOElLOGdv?=
 =?utf-8?B?NHZiSHZmUUxnV2s2OWh0UnlCbU5tMEtNZ21XRURKOEVaMlhyWlF1aXNDbWVQ?=
 =?utf-8?B?bWxmUk83VmgxQ2Q1Si9ZaUF6cDRrc3RqY1k3aEVJWGErbi9WblFQb20wb3lP?=
 =?utf-8?B?a3FSTDAvcktYcFhOdlF3UGx5b2lnQXIyWG9uYW80QUhsM09sYytIMnQxTklS?=
 =?utf-8?B?MXU3Si9EVTlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDVPUnU1d1hNTURVck1rOVMvKzZuWTRCSUVWQzRlWjJSL3V0N0VYdDNCalh2?=
 =?utf-8?B?NFNLU1VhemZVTUtxT01RWWRDNHRScytsejVIYkxhOVg0WXNZeFAyS0JJMUlq?=
 =?utf-8?B?R1FxWER0T253cGp4bktYVUlhZC9aR3FYVHhNbWRSWkxyR2lTeXF2MWgyenNi?=
 =?utf-8?B?R0p0UmxMSWJIUFJZbHdtcVdWY29UQ3owZk90NnkwcWdmVDVCVlFmeTE1YkR2?=
 =?utf-8?B?QXVzVnc4eWN6eHA1MlVDRWxhUEN1dW9xZVh6akR2TU53aVlHOGZyWXhxVDJh?=
 =?utf-8?B?VmVFeTdPK25oSFZOUVduRlRrcnRnN2ZpR1ArOEl1b0JzSjFtUnVIVS82d2o1?=
 =?utf-8?B?bU1wVFJaNnFwdHQxTGNSaXRRR3BldWtIOE1JU0daN3VaNmV6eXFLcGQweGJ1?=
 =?utf-8?B?ZUErd283czhLT2N4amRZemdneStMbHdqWEJuUW5aY3VxbkdreHdzTzQ1WS8r?=
 =?utf-8?B?blhCNGZId3hSWnFZUWRKODZNbXk1WEgxOE82WGh5Z0tCZTlWaW1GS0taM3Iy?=
 =?utf-8?B?ZXNEeFdSTGVRRFQ0dGwwS0lRNEJQQ2cxNFRaVlpkUFJRQkRwUTZHSCtiN3pK?=
 =?utf-8?B?NmlTbzVjdTBIMlJJR1UxMUsvdzJWZFNCci9uREdqWk45WWlxcC9kelV5aFJE?=
 =?utf-8?B?c085RnJ1bmI2YVFMeFkrMFplT1E3SDBOWGZCcDRBUDhtdkpVUHhQa2ptZGlv?=
 =?utf-8?B?ZmViN2hxc2drcDVNSEN1WHFSVXA2eE9rTFNTRFBPSjhpUlRYRm5ueG1ld2RG?=
 =?utf-8?B?V0xaV0FLdVluYTEyaFFybS9yN0h1M1BRN2JNYzA2eUhlMUFYcXJjTjJCU0sx?=
 =?utf-8?B?WVh0VU4zNlR0M3NqSE01SFZXQVVNYjRlL0FsMUVlMFlJL2lUQ20rb3ZBOW43?=
 =?utf-8?B?WFd5amNtczlJejMrNDl2bS8vRVRMTnMyZHJPdEtDQy91NlNUNzhselBqVHRC?=
 =?utf-8?B?M0hDN0JHSmt6WnhvQnd2UndzOHAxeE1PUXdzQ3NySlpMZEIwc01TdGs5ZnA2?=
 =?utf-8?B?eWdXL3A5TFBSaFp2dGpUZnZlNmExUnJIRXRpcXJaQisyWWVpMEFJQUhyY3Z2?=
 =?utf-8?B?YnluMGhNRk43bG5pS25XdXFCQ1MvdVVhUFZLR0cyOFp4cXUxUE5iQ202b1Zq?=
 =?utf-8?B?SFlJVnVlSitVV1N2d0Zic2phUERzcTdKN2NIelpWdkV0b2VrY0NTWmg5bVZ6?=
 =?utf-8?B?MHhXSHZwS0l5dmYxL3RRVVR2QWNZcXJMVzBrY1lZRjQ5SktoamEvbG9odHZz?=
 =?utf-8?B?WWk4RkNqSE11RzRJcTl1Vno2Vm5QVWRiK3NoR3RwUzRpNXUrZFBiV1NsNXha?=
 =?utf-8?B?cUNIbTBGS1A1L3gzeUNuK0tFbDRqWnZSTXpQOEx3eDcxcitMMGJCUG5VWmRB?=
 =?utf-8?B?R3N1TWROczFnd0s1QkVidHY1eWt3ck9pcEVGU2JhbVNaMjZTalUzUjM5cy85?=
 =?utf-8?B?NUkyeUtnd2ZzZmVuU3ROdHBzdkJFVXhPQVJ1L29CcTJhRk1STG9VbEprL083?=
 =?utf-8?B?eVZQci9HdTNjWldzK1NUcnNIcGhIRE1nVlFFQ3J0aUdiTjU1a0FNZHJjNGdp?=
 =?utf-8?B?S0hqZittdzdJTFBESDQxTTlJZXNuWG9lUDErbkQ4bWVjZy9wUHI1OHNjK1Vz?=
 =?utf-8?B?S21ZYVE4ZHQ5NEFheVNBbmNETkdzMmM4dUI5Z3hjd3hzVk5JRU1OUGdmdWlk?=
 =?utf-8?B?NTBCOUZiVkJtekh4R3YvajZZY1QwNEJ1VDZUdEJ0OG40VzBzemprYS9SaVFh?=
 =?utf-8?B?NjNBYXBuT1pScEJSTlVQWnRHaXBtVjNnWDR3REdaM3pqWWRCUktiNVI0UU8z?=
 =?utf-8?B?SVBZcjcxd2llRFVaMzR5REQxM2FnZ2hWcFFkMFhRR1Z4Z0ExY01Jd3BObTl3?=
 =?utf-8?B?NEdFNEdnd2ZCRm5uSFl4cG11czdEWEJwcXliU2ZYMDhmNE9uUjN1Vnh2Vldo?=
 =?utf-8?B?cDZxVVZUMFRvbXVSakZYaTNsNytMR2hXU2tlZTQ3eC9Tc1Fpay9VdTNRdXV3?=
 =?utf-8?B?ZFk1b3JsY3hRa3NBZUpEV1dvNmpxNllVeUlkWW9XbUxEWVpzejlsUUV3NW5C?=
 =?utf-8?B?MndQbzM5bHRlMGhSOXY3WC9ramc1ZThjRGwwbHJzbHptdWRtTTRWTHBmYnkx?=
 =?utf-8?Q?S3PCkVln4RGjTI7PVuigXZ18h?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a350c82d-e63a-4e13-e113-08ddb2528973
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:36:12.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkuJX3rgTqKrQaIB/u0u7kAcNMoPBC1HL82efbVleMggj9vmopGaFNZGJdbJRlAl72LV4r1iKiBp0kXa6dW+dg==
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
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/db8500_thermal.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index 576f88b6a1b3..2d8be827b17a 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -164,25 +164,21 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 	if (low_irq < 0)
 		return low_irq;
 
-	ret = devm_request_threaded_irq(dev, low_irq, NULL,
+	ret = devm_request_threaded_irq_probe(dev, low_irq, NULL,
 		prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_low", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp low irq\n");
+		"dbx500_temp_low", th, "temp low");
+	if (ret < 0)
 		return ret;
-	}
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0)
 		return high_irq;
 
-	ret = devm_request_threaded_irq(dev, high_irq, NULL,
+	ret = devm_request_threaded_irq_probe(dev, high_irq, NULL,
 		prcmu_high_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
-		"dbx500_temp_high", th);
-	if (ret < 0) {
-		dev_err(dev, "failed to allocate temp high irq\n");
+		"dbx500_temp_high", th, "temp high");
+	if (ret < 0)
 		return ret;
-	}
 
 	/* register of thermal sensor and get info from DT */
 	th->tz = devm_thermal_of_zone_register(dev, 0, th, &thdev_ops);
-- 
2.39.0


