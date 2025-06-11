Return-Path: <linux-pm+bounces-28450-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF0AD4D84
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D74189F88F
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86845237A3B;
	Wed, 11 Jun 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kN7pDTxz"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012058.outbound.protection.outlook.com [52.101.71.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D72235BEE;
	Wed, 11 Jun 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628476; cv=fail; b=hrozT7v8fuabamjDHMpu5RBZlLrfKpM1TMuM3VV6A4dnJR9iUrZP60P5Sbvr02RqrOQGPfYV/irpvpUinn/9C6vQ9zqTMXH+1Rl/WBkZh7YWRIIXVR+gJdL+let20B6Y5TuAFxH3SfnbWdS4RrLvWYe4qYWtLTRiW3ORBV0QzOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628476; c=relaxed/simple;
	bh=vG04jTI43UVWSiJpi3b5RIq1axLG45es7V1ZzJlf6i4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BUW+xxtJ75pLqEk/EI03mFmO5Ox/zpm+BsXFnVS/1q44Ak83x52s3mKehXgtJK8XXZOhZgSwdWSPEuVynOybcapjn8rWQP9Vw3mXNTfqp7vFCALR/GiavUYJCEys1qNA32FRZ0eKFMyqFt3JH70wws74/ddcg1v7ZM8SjTMVVyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kN7pDTxz; arc=fail smtp.client-ip=52.101.71.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cn0huNzGdGUyS4x9qNe/5OFcsAkGLRW2XATo93wAjsWTsCsOkZFrkuDGuUTFnMnKfUQZpWjf2Up1p9BrKuUoMQOemXskiiXgbAVy+S1A1kA2/1k2BZ9Es0brGDAh5+Xbc0tugq2k3iANsFTJayLFVHsKFoS7EVsmUKU3Nc5FPC8PJPEQcC8C5bfzqBvYCsozvSEuJFQScxJ9GSJ+PvhLOguBAsVhaskLZiGBCI81Y3ciyyxXhNeTonF7Pr82UR6fIsJV5fUQpPO0Wf+ruAJR2Dq0n4RNHf2d5rAD4Hyo7tvIRggultGngQ6XjYnhW/KJwrDVTiJEncdjrrfmoaDXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j1qM1mQZpmOuwDBV6Uw53mME0d5wdy/8UqbSSPrf2Lc=;
 b=C7dO25OWSJIFRn9ddycwQtHb42nIwn5NBjjWNGfpxkGtUtoj2VhuIy/iDOJv6oKDmqAhUwk3G7YnkjHrAniPFwc5KkoAGpc9tuZdlHO3mk4K6s6BDmHwOTsPk5bgjZNo2bgzIdlk8QrnKu4jbfNBnDIE6IrAe1QcCIQyfdbjXwIPgWz3N7n8m5rGeyFwOd8lgEizvfcNoLRKRSWuZOpOO2Ji7NuCaOZ4UlXH4oQU5fsAWhFmu4rBoQi722mu3nd6z48y8X2/JxMh61WZt6d8MnPQcfBTDmWpk7mGarcIQFR+eQil7Rtxpk1XU5VAvU77yzl1FWFbrP20bXU2zvbpQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1qM1mQZpmOuwDBV6Uw53mME0d5wdy/8UqbSSPrf2Lc=;
 b=kN7pDTxzKSjcmLZL0hhZCk2L80Rz163anRVWQJwum7kJ6JKV1nznQ552z/kj7t7Pca/CdkrQdqPSOuors/lVpo3zywqH+MUyJfX6C6HXGQzbHj88TIKsBcDdDrsQdvuDJZ/92zKV+85R028763XbVu+enBSCfNgRwtVjuYegoBn7yEBZw+R9jO2MbditCfDziU+RPSJeJiIZowR6so2MS0ChOf0QKuj/zz9sLC2N9ik0sQCu9WVBXTZK63EFbP+Y/M6N9zZqdYTbFIPXGN4x1UcmU1+IL5Rq0l9Ash+OY8jTfJvblSolDKo9mqPbA+lkrueAr+ONxBPZQdJcXuDeiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 07:54:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 07:54:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Jun 2025 15:52:44 +0800
Subject: [PATCH 2/3] firmware: arm_scmi: perf: Add notify_supported for
 scmi_perf_proto_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-scmi-perf-v1-2-df2b548ba77c@nxp.com>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
In-Reply-To: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749628374; l=3875;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=PH1c6PwicRSoyygQYAlLYy5cXM62q10Qj6z9/KR4a+o=;
 b=3GL7fg7OZ2Owvi2y/AjM/5O/EGfQ37j/3sKlvzpzB6qLM7sQ4S/riTupAZ/OrbW+p7zRnME9V
 S0WLaXYMvNvBBQbp8W0+aQyK9TIh+LMXIGGV25m4jEKVRA50ip5GkQn
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb1941b-59cb-4d82-1bf2-08dda8bd32c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnNrSmhvV3djU1FzckQrVjRZWjk5dzdZY1hNL0Z4OGhPaUsyNkF5U1ZVdi9N?=
 =?utf-8?B?TEIrK1g4c09PQzFxWnZpcjVIZklyVHdzUldEMTd3NzM1emZqcU9Eclp0eW1W?=
 =?utf-8?B?ZHYwSzBuSDY3VEcrc1NNQzYwOTlpRWpHYy9MS1VVbUdDLzlCNC82RnNrSkov?=
 =?utf-8?B?cFc1L1Zzd3B2cWcrai9lenlRY09GSjlienpVQUxPV3Q4cEM0aSt6bzRJei9s?=
 =?utf-8?B?YkxuRHIzNU5yK2pSMGlQMGx3RVo2OVQzZm1OKzh2Y3Awdm9hTkVDdnI2d0pq?=
 =?utf-8?B?amNucUFjSFRYZUJSZFhhc2Rnci9MSm44bG54aEVXN05nTmRsN0ZnUXpITTJn?=
 =?utf-8?B?cTczd2trMENzY0VmeWVHMjlZbzlzYTBLNVhNZ1p1MWRWY0RzNWVnemtnTE53?=
 =?utf-8?B?U3RzaFVzSDBreGRDTkJiNDNRajlYS0h4d25BdkFjU1J2U1NhTUhnK1dzYWpP?=
 =?utf-8?B?K3NRNkk5QjBwRHIxOWg5KzJXK2lkL1RWb1k5M0RRaU9wUFl5Qi9xMHZzQmJo?=
 =?utf-8?B?bS9NR1FFc1EzRW1mckUycitra243S21YdDhOR2VuQnAvN2JMN1FoSnVWT0c2?=
 =?utf-8?B?WDlOeFZXTSsyd0tDajhIeUJQajNKUCtzaDlWZjZIODJRaWhKeDBhRnl4OCta?=
 =?utf-8?B?VnJUcjMrbGhSUnMzTnNvM0dibURnZWFjdkNXOGxYVk84NzlnYWFXdUdsYnZx?=
 =?utf-8?B?WDVTOHZtd2F5V0FLMkNOYmlMVXhSeWdJVlFsb0tEYjFtRlZZK3JwbWdldjhR?=
 =?utf-8?B?NUViaC9KV1ZMQnVPTE9qblFDYk9xUHZDdVlaanJZaFlhcTBFbzU4Q0hjSDZR?=
 =?utf-8?B?NnM2MUxrSWNLbzhObEhjY1ljOWQybFJTb0pKYU5nazBHeC8vZHFUUTB0cXk1?=
 =?utf-8?B?cytMdFR2cEVyWHBMUUJDRmtJb0d2L1FHSXROYVlwVDFvNWlvTUNTS2o4THNB?=
 =?utf-8?B?M21WM1M1QXg2a293b2x2aGMxWUJkYmZ1cW50YnNQZXV5VkpVV3FWSlVZVjJR?=
 =?utf-8?B?TGNLZW81dG9yZFZNaC9qWVNJeVpIbUk0ZFdIelBXUXlpT2dNaWlPeXoyZmUv?=
 =?utf-8?B?MVUrY2hUMldoNDY0ZFVRMCs5RWNlbW1pVlNya3FLK3NpRi91TzQzOWthUk9B?=
 =?utf-8?B?bUdzbnIrL3pUb2x3WEFOcEc2QlVkZER2cDBRQXZKQk4zZGdVeWM4NDlIMlow?=
 =?utf-8?B?UU5yT2p3T2RqKzdsQWlNeHFZemtTTWtMaDE4c3REdEcwU0NNY2grMGdxaHBE?=
 =?utf-8?B?elI5TFQ0UkhzVTNvRGtZQXh6VWd2dkJ6cTlpZjh1cVZ1bTh5WHdKT3RKMzNw?=
 =?utf-8?B?NXB5RlR1VE1YMlZOYTd1eUUwN1RUZ00zREhaZUh0Y21ld0VGdVVlam80M2gr?=
 =?utf-8?B?TXNxVlVMUUhsTmd5VkxBaXYweXdDYXltUWo1Zy9PTDNaTUpJb05UQUtURnhX?=
 =?utf-8?B?aWVwU3pJMnNQSEQwaXg3OWVVQmxQSi8vOXpwQmFtQldDRXdWL2hHSzgvd2Fa?=
 =?utf-8?B?WFVGcUpYQmJUUzJUOEh3MkRjTEV1Ylg4a1VaT0tYMy9tNjkzd2U0ckpNWDRl?=
 =?utf-8?B?TjRCUGFjaU1DM1g3aWdhM0YyUWRsUkFsTXVYMmtkV2N0ZW82eURxUXA4TmJR?=
 =?utf-8?B?L1pZZkZlUUNRdFo4bmoxcXNOb2IwMjEvQWVOcVhFck1xcXM5QTlSOCtoSXJC?=
 =?utf-8?B?WkZIc0JObUZieGdKSUNWYnBOaTFuOGJYNHByTVpLaHJtc3l5MmloZ2lRTVZu?=
 =?utf-8?B?R1Arc2RnVU5WYmVFK0tCNitubmNVZTlQVGx5RXVzWXN5c2w0UzF4dHU5MG4w?=
 =?utf-8?B?bjh5S1pLaVhXaGVwL25QVjZ1MTUzVEZ1Nk1GbFhSR3BCeVFMMVhPaWxSSTRF?=
 =?utf-8?B?Z3JxeDV1elV2L1VaWXp5Mm11Rlg0Q08rSm1CMzFxU3JpajhpSlB5eWIxSVA0?=
 =?utf-8?B?eTloZnhXbGY4OVFONzFKUUFLa1o1QVN5UVdrT2ZxUVFFdzM1aGxEclRuQ3V0?=
 =?utf-8?B?TmtqK2tGZDF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Lzh0TXlvcDdUcWZyc0dsUTBhSlphdEZXd05NcHM5T0dydWZ0eHBNSTFaM0hH?=
 =?utf-8?B?dVI3ZmEyei9zUXZPb2NkSWl0VlUyZXdrNTBkQmJJbEF4OXBUYTNpd1dIUHJ6?=
 =?utf-8?B?WjhsdFMyTFpxNTc5dmJPSmU4ZDMxZGJMcVhoRlJGSysvcXhvbEhhbFZVZkpY?=
 =?utf-8?B?Nk5VN1ZBOGwxYmMwSnFTU1ZHUzJFeWEzUGg1Z1JaVXM2Si9lY3pUd0ZlRm1B?=
 =?utf-8?B?eGhhZ2dEU0MxQ2syYUlxUjZwcVF3UHFTdGtlMjFNMnh3a2ErcWEzNUIxSzNB?=
 =?utf-8?B?VTRBVVpGbzBXMTFSZ01ZVFNMRzg5aVRCQk01TzhHbWZCeFk5T0MxTVZ2T09k?=
 =?utf-8?B?TUtMbWppZXM0RVhzRi9pRmIrRlJLT0d1b3c0cnZlVk5iN2dDN3FKNEIwQzU5?=
 =?utf-8?B?OHNrVUl3ZzFVeTVKUjY3M3c4SVJuYVFPK1RxMHhVUHFBYmlRNUhXcGVWRDl4?=
 =?utf-8?B?R2xIeWx6SG9PME9nV2xwYm9BYTcrK1plY2lkeEthRDZWUlZ5TU1VZTAvUXFN?=
 =?utf-8?B?dUthcElnclNLMHBycEcrQlcySkpoRndONU4zL0xXcTAzZkRndU1aTXpMcnVw?=
 =?utf-8?B?ekJuVUd4QlRJc1VaWWowallmVkk2WFM3OFAxMnZZZmptd1pqczNaNlBldExI?=
 =?utf-8?B?UTFJZXZmTm9IWjZGR1NDTHg1SVpzektsMy9rSWw1V285M0FjQzlwTGZkaVN3?=
 =?utf-8?B?TVpncjJhV1BBM2xyZGIreEpIVkJLYmxhenN1cnZDeW5vdnFPQUdjeXVvcFpq?=
 =?utf-8?B?SkFrYTIxSG5qV2hZQ0t0TDIybnNYVVFLWS82UHJxNXdCQ3FwQjBrQ2VQSE04?=
 =?utf-8?B?Q3BQelMvOXR6NnRVM3VGSjJUOXRXWnBkdlc5ZTBWYTdFNXM1eXdHamtXSFRl?=
 =?utf-8?B?VGtyT0FHbjhpOUpMQ0NFTmorQjVkd0NsZERpKzZ5elFXbGtJK2E1a3FiTHg2?=
 =?utf-8?B?YWN6c3hYckRDOU1oZldienJqSUYwT1dFZkN4UDVaUEM0Ynh1L0diQ2RhL0Ft?=
 =?utf-8?B?bnp2MlJhVXMyamlnTXdWdlc4RVZzZ1htelVsekh0dTN1bDBrWnJhRnlNMzZs?=
 =?utf-8?B?T3kxWEs0NkNJd1NDMllkN1dRekhaRTlDczFKZklKeVVDekJ1eERYdzVpMGNF?=
 =?utf-8?B?N3BWSENhZzF5aUJSTnhuREd6aDlQOVlRdWpMTGxVTnVDeHowY29VeFB1RXRR?=
 =?utf-8?B?WTVKbG8rNXBNbnVZcmppLy9VN0k2eldmNVRMTHVXTGVnMm8yZ2lSTXJYZ3pv?=
 =?utf-8?B?bWFMZXo0clprL1pzOEQrVGhzcGwrUUh6ODFnOVQ1OGNVVDczRG05QTdobldp?=
 =?utf-8?B?a2twNGtLRUM2cUpmNmxxWG44RUxZcHV6anZPTC96UmFpTjVDYXZYaGMxR2Zp?=
 =?utf-8?B?cTBXNlRwbzQrcVJRUlg0dkVhVWRtM3dPVnFSUkRlSUdSa3FLQkZJaUdocTVw?=
 =?utf-8?B?eVpUWXEwSHdXOVZkYWxGbE1zSmVwVk5XUFNMMnNkMytSdmxaSStueDNsdjdt?=
 =?utf-8?B?cUhhVFFJOWZyc0NDOHFnUUNYaE1BaE1wemlpYkNDTlBraU16Z0hRelVKZnJz?=
 =?utf-8?B?M3p0b0JHZWw4ZEowbWo2WDNKZk5ZN0Y5cHVhUEZ0MzVYTXVuMGY0K0NKVUxN?=
 =?utf-8?B?azdldmFzU2RFbTN5RzJ5bEJWbnZyanh2K2dwVTd2UUx1TE5Pb0dUYTJwdUlv?=
 =?utf-8?B?a1g2bG9EcHRFOFVGZExKckw1Rk5wZXBjdW1VU1FmRDdXTXBFbEVpN0grUWVl?=
 =?utf-8?B?Mm1uYlRJeEY4QzFxSTNHRHU3NGU5dzNMakVCUDVvY09BYWdHdVF5OWpMTTBL?=
 =?utf-8?B?aVJKTFpzREFneS9jczFlajQyYWVsRHQwL0h5b1NnUFVlaytULy9yTXZVSlg4?=
 =?utf-8?B?eGQza2xjTC8zRlRlOTEvL2ZPM0xOTDE2K25rVDVibmx2a2d3V0dpdEU5VHpO?=
 =?utf-8?B?VTlRZGtOUkJjYklaUFd1a3BFNldNdmZWWmc3aWNjUmFJNTV3UFA5ZVdpRnBP?=
 =?utf-8?B?YWZVWlFDc1NscTlsNFJuMWVxb0ZkbkxIMXlaZ3dDTVJ6N1kra2VnaHpDazBw?=
 =?utf-8?B?QlVxSy9MWGl3QjZVMnhicno4V0IrNURjZnE3aEZFcUZFNmlwWklSUWtITDgy?=
 =?utf-8?Q?BaJaf2taiw57HQ5tK/z36HmWM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb1941b-59cb-4d82-1bf2-08dda8bd32c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:54:31.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q71m9M5RTkijiKC3Auh1THxEWaYh9QBGeMYiuro+XvxDYbz6UA+tnN3nAfC0H8G/pBZaswiswBys9iYoy3WGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

From: Peng Fan <peng.fan@nxp.com>

PERFORMANCE_NOTIFY_LIMITS and PERFORMANCE_NOTIFY_LEVEL are optional
commands which are not implemented in i.MX95 SCMI firmware. Provide
a hook to query whether they are supported, before invoke
event_notifier_register.

scmi_perf_notify_supported could be directly used here, so just
move scmi_perf_notify_supported above perf_proto_ops and use it
in perf_proto_ops.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/perf.c | 37 +++++++++++++++++++------------------
 include/linux/scmi_protocol.h    |  3 +++
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index c7e5a34b254bf4e9c51c7be56803b6d851f0e1d6..ba990643edf0bcb5fc25253b4f52a5dc93b62a77 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -1068,24 +1068,6 @@ scmi_power_scale_get(const struct scmi_protocol_handle *ph)
 	return pi->power_scale;
 }
 
-static const struct scmi_perf_proto_ops perf_proto_ops = {
-	.num_domains_get = scmi_perf_num_domains_get,
-	.info_get = scmi_perf_info_get,
-	.limits_set = scmi_perf_limits_set,
-	.limits_get = scmi_perf_limits_get,
-	.level_set = scmi_perf_level_set,
-	.level_get = scmi_perf_level_get,
-	.transition_latency_get = scmi_dvfs_transition_latency_get,
-	.rate_limit_get = scmi_dvfs_rate_limit_get,
-	.device_opps_add = scmi_dvfs_device_opps_add,
-	.freq_set = scmi_dvfs_freq_set,
-	.freq_get = scmi_dvfs_freq_get,
-	.est_power_get = scmi_dvfs_est_power_get,
-	.fast_switch_possible = scmi_fast_switch_possible,
-	.fast_switch_rate_limit = scmi_fast_switch_rate_limit,
-	.power_scale_get = scmi_power_scale_get,
-};
-
 static bool scmi_perf_notify_supported(const struct scmi_protocol_handle *ph,
 				       u8 evt_id, u32 src_id)
 {
@@ -1107,6 +1089,25 @@ static bool scmi_perf_notify_supported(const struct scmi_protocol_handle *ph,
 	return supported;
 }
 
+static const struct scmi_perf_proto_ops perf_proto_ops = {
+	.num_domains_get = scmi_perf_num_domains_get,
+	.info_get = scmi_perf_info_get,
+	.limits_set = scmi_perf_limits_set,
+	.limits_get = scmi_perf_limits_get,
+	.level_set = scmi_perf_level_set,
+	.level_get = scmi_perf_level_get,
+	.transition_latency_get = scmi_dvfs_transition_latency_get,
+	.rate_limit_get = scmi_dvfs_rate_limit_get,
+	.device_opps_add = scmi_dvfs_device_opps_add,
+	.freq_set = scmi_dvfs_freq_set,
+	.freq_get = scmi_dvfs_freq_get,
+	.est_power_get = scmi_dvfs_est_power_get,
+	.fast_switch_possible = scmi_fast_switch_possible,
+	.fast_switch_rate_limit = scmi_fast_switch_rate_limit,
+	.power_scale_get = scmi_power_scale_get,
+	.notify_supported = scmi_perf_notify_supported,
+};
+
 static int scmi_perf_set_notify_enabled(const struct scmi_protocol_handle *ph,
 					u8 evt_id, u32 src_id, bool enable)
 {
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index aafaac1496b06a6e4f0ca32eee58a9edf7d4a70f..91865f0ebcbd4b15b55afd8c1a0d0614d6985daf 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -155,6 +155,7 @@ struct scmi_perf_domain_info {
  *	successive fast_switching requests
  * @power_scale_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
+ * @notify_supported: indicates if the event is supported
  */
 struct scmi_perf_proto_ops {
 	int (*num_domains_get)(const struct scmi_protocol_handle *ph);
@@ -185,6 +186,8 @@ struct scmi_perf_proto_ops {
 	int (*fast_switch_rate_limit)(const struct scmi_protocol_handle *ph,
 				      u32 domain, u32 *rate_limit);
 	enum scmi_power_scale (*power_scale_get)(const struct scmi_protocol_handle *ph);
+	bool (*notify_supported)(const struct scmi_protocol_handle *ph, u8 evt_id,
+				 u32 src_id);
 };
 
 /**

-- 
2.37.1


