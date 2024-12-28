Return-Path: <linux-pm+bounces-19790-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB279FD894
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCEA163DB8
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6ED74BED;
	Sat, 28 Dec 2024 01:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bdVTbLzx"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F27082D;
	Sat, 28 Dec 2024 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348542; cv=fail; b=qPv9bYtx14q9G0t3PsCmegW5I3kqmaQVR37hvLoeQqgKLX7Lfbe5hU3b9PZjdWYS4DMLM12ui2UXljiE3we6JjrqUyfAirS5G2rlVYwALQPVD4a9Q+zLA5oAeHzAkSSOcm2dUPk7DQABSxbgJu+kZShMVwotAAFI7aouwXmer+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348542; c=relaxed/simple;
	bh=zQeVfeCxLWPp1ta82McHGDfqjkgW42mBMCjsal6VJxQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WxofqxsYZgof3EFCj4UJVGHy+mSRhgPyQDcBLPNql0jESCe4Fc9Uhu4A3YyQUuQhcWo1mOaui92n7mgezFgkDXLJMmoZA5XlSeLAuhi0rklpzvoSNQ4PjUBwrMFjTFoeGZJtmxcYVypmHMkDtz3tLeKbXZVoLyfmY0wgETjkjVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bdVTbLzx; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De03qc/7+W09q88nvZWjpdJ+r44syFhmY0TGXrDE9q8cLOOQ+MC2FTi/26TBOTg1z71q/Njjd2+YilGj2hVqA2yBruyaElB3FzznpfGnaJFCyehc9x0U5kkafytI4nMKaOdBBe3iuf2o0DBS0O0e3DDuSIKrL6PC1POWXdwPlz8yvMOasg1ES5hAuxZY1ER4iKQAzwGhflNJnP3qo7ZlZhxJAqBfT69E8uDmBUQ7OkMCx5BA9Z6i+akGtRpBr+BEb75qnSg967vVYBGvDiak7OnV4huxskJ12YkZCfTiAsLDTFP/cQ+mOU/JxPEn7N1laO3U59HZAE3rCv1cMPKHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLJ6/6T287sMFeFzpA8pzl4U0kUK+AHmoE0BEwYo/f4=;
 b=FW5NwhB6l0ulZlgR8HG4Y0y6fxynFZ5VS3ZIxGwpH74L90gXYmN/Z0R9zJjABrQOvPeDSCsaFgG1jgM0xzSySFtFHhYpyWlbjktQtwERCr/aEMcWiWoau2YF7puLTfamwHlk8K6PQBxTy1bwYfJFbAlw6Si1pKdPNhoBnkPk7LGmEADNJj//fMsMdrJEw8PdAje9VqE/UsM4UDVDtunaYEHfrXyo3Y0DDRLfrMiUVHosTRWTJerLjfkfF5BX8nxpJZVbI5jC49AJdAYwtLRoEpFiFhtC5OneUhmhHyZG6/K2IZ8q9pjZ/hgpdcZarohsaWgvza8fS5IvFEvBrPtcoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLJ6/6T287sMFeFzpA8pzl4U0kUK+AHmoE0BEwYo/f4=;
 b=bdVTbLzxiZp2lRvyYH6Bc24luyGUH+RGc4fBdXYmTBIVFgOTXEViTJ4s/2MYXyVZF9izqgQge22bRocgyzocpeFBKin+IBVVMZ8zsQMn9CwojzYW8I5ieqpNQfHmOhcVeZnglGDVVllkty5SzZK23UEsnCZO0Ck0TX5BkNowSsfyT71QeIeZsVALm3I3fkUT2GEQOfb4dVCtObhysKjGVxBY+xu9NnrgHTyo+CczxQRzDddYsePxupFSjSK9gvqzEVngWyndAeDV7L1nk8wtoEpQnSEX3YtJJjXv4viJbdwfupfOJMULC6mPH45PnVWPKFCFkJwrj3sli68tjXp8fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:33 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:40 +0800
Subject: [PATCH 04/12] input: misc: nxp-bbnsm-pwrkey: Use resource managed
 API to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-4-09cfca77cd47@nxp.com>
References: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
In-Reply-To: <20241228-wake_irq-v1-0-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1523;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=g2vZhAdAlG59tJHA7zmPtBw4oLxwHW1tSbJmlo9rLyg=;
 b=n1Rdvh+byloMgU9fVOo/u/dO2fgSbylAiFhuEeGCWpv+c5cbO6HQBC8GN4OZ2AYv6PpvAFCpi
 5ptQtE7Ox15CwPoCaVywbzaXII03UcP1k2p2mA5iZLfYxQWU34rIpK0
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7140:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ff64c7-de9a-4bfb-c06e-08dd26dd20e6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUFLZ09Uc285ZlhQZXp0UkN5TVAvQWFnUTUyQS92aVhZakhoOU1RL1BJVFdw?=
 =?utf-8?B?Um1sRW03ZHQwN2pLVmVEVm9jQUtRQ1ZwQUU0amxJTWlQaXJjM2MwbTJnNHQ4?=
 =?utf-8?B?bzBsOWlRTTVLTlhUWkxiSFo3WUlMZyt5c0hobW9OQ3lHTTNaNVVTT0ZpUzAy?=
 =?utf-8?B?cHdGQUhZSGptbGl1akJPT0JrTTZReDZveXFNM0VhbWFKK2xuWSt1bmdXNDI5?=
 =?utf-8?B?SnFvemxCMGtuOC82dlRwMXZ4eCtpZEgrRlZHYk9VK3lYcEJObC9iWjcwRnZk?=
 =?utf-8?B?aE5MOGlCd01oMTVza3VWOXVSeUZYTStZUkpSY0VXYi93czF4Z01xQWMzRXlL?=
 =?utf-8?B?Q1BjcmdvalowRVcvUWZ6ZWovdC81R1k0N3ZDbnh2MzR3K21lMXQ0Tk9tUGI4?=
 =?utf-8?B?aVMwMGlGT2l6bFpQNmYxdFd2TmJUb285UnlWTGhWN3ZlcjlUQ3daRlZaWXM4?=
 =?utf-8?B?TkhoWE54aDN6akc3Ky9TSU56YUhXbms2WHdHSkR1NW9hRXZlMFh3YU56emF2?=
 =?utf-8?B?cEdRMjNvaWNtY1hYWEVhejN3STFFemtVVVNtVnEwSzRsdWxydnZJMVBENm9x?=
 =?utf-8?B?NTVLZGxrZDhEMFpjT1BSQm5sSkhQaTNadXptY2Vpb0J3THkrb3RKWVJ4S1hu?=
 =?utf-8?B?N1hjVlMxbmZmbVBvN0RaRUFmNGJKR1FndkNLeGsxNXV3NEMxdXRmU2xaemVL?=
 =?utf-8?B?Z0RCL3Q4dzdNajduMytLMDF5cm1VRFVRcXpXeGhwYjIrcENDNm9rVUgrZEdm?=
 =?utf-8?B?V3J4bm9OdlozN0JLK0d0cXlUMnJLSmFocCs0T2JnSml3SlBmbk03MXowelNa?=
 =?utf-8?B?MHBJUTF3bkNyeW9aL25RMkpUczVONVdGNUcyMXN3NmFsUUNBVGFhNnozWUpm?=
 =?utf-8?B?QVdhOTREK3hNbWx2YVc1bVQvS21iMkJWYzE3WjVTUTNnbFZGZTAyd1hiczVx?=
 =?utf-8?B?bzNTSGlIcXdTemN2bDJRNitNeHpEK0dWVVVNOWltWjBCNjBTaTJEYklvdWdj?=
 =?utf-8?B?bVBIYldUS0JES0tKcWtPL1U0MlFRelhLZ0RXWXloNFkxbDFiRXRQUExLeUNl?=
 =?utf-8?B?RmpLa0ROYnlFUFJ5cjE2N3dTNDFKOUJGckRXVnp2RDVQaEZZVmtIUHZ0M1lM?=
 =?utf-8?B?WmpWQ01NWFZtK2pqUE9YUnNZa2JVczQvL0NPMzg3R1ZOVjl5TzRNbE9jYWtO?=
 =?utf-8?B?NW1kMTNUVythYi9PUitxUXVBRTF3Q2Jyd0trUHhLWlJUdkJIS0tsR2ptUWlo?=
 =?utf-8?B?ejdjNTNPL1E2R0RMbGF4SEF0VHBUVFpWZEExcHluYkhEdDN4TE1PT1JvcXFD?=
 =?utf-8?B?a0JmN2RUZytlSHBsZ3BUMVI5QTEvZ0lqTEo0RHViZkp4SCtRS2lXenNQemdm?=
 =?utf-8?B?Sk1hZUoxZjZndFNsOUd6eUJxb3k3NzhQTFFUdkpVYndNU2xMTEMxd2dIYkxk?=
 =?utf-8?B?S2pReTZFQmZ3cEdGVjg0cVN3R0pwME9WUnNwZmg4V2xLYzBaeVl0V3VWOEhw?=
 =?utf-8?B?eG9XSVZxYnljY3c3N1ZGRzlqd1ljM2M4aUgyMTZzL2ZueHYzZlNYYmtVbnc4?=
 =?utf-8?B?Z0M5N294V1VVbU45MzhnUDNXbU1mb2pNcU8zWjJHcEhCLzNHNkFDL2gwRytZ?=
 =?utf-8?B?TUhqcjFBN1orMlc3aVpMOE91dStnWE1kbUlrVU5MdEwwQmpVNmZqbU56UkRP?=
 =?utf-8?B?KzU0S2lRTnNaaWxwakxJNDd2c3VubnliY2JqTWdzZjJkWnJXS0NFQ3VrUkt2?=
 =?utf-8?B?ZHNZN1owNVhiRzJBMGFSMWU2MzZvRXArRUV2RURiSW0wNEZ2MEhob3NVS2tH?=
 =?utf-8?B?TVNqWDRESEM4eDB0djVnR0dGOHIzM3h1T1ExUzZyYXlDMmEvaXd2cmNWTTBy?=
 =?utf-8?B?L0dRRlN0UWl1eURUZGlsZXJhZ2xWZmJMVnBCM3l6YjZmOVdHVUhDSFRNWVRB?=
 =?utf-8?Q?Qov3paE4C0lgy6xTFvfFARIg/e8Ng5Vf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUJid2k3bmlzQ25mTmdIWEFid1hmck84ZlhEOUVLb0FETVZWZVJmOW02VEpG?=
 =?utf-8?B?cU1mQnlRSTJQM2tBV2EybTdEd2J2eHZ5NTJOL05Xd29NNEJpMFVTamI3WGZP?=
 =?utf-8?B?NDRIZ3lRd1Z5Y0ptQlJIUlZZaU9PencvU3RraG91ektvREp3ZEVHVHB3NHdS?=
 =?utf-8?B?UklMT3o2QW5INjVuL2FnWHRjZTVFZWhqNU5qSW03MVg1RDUxNHdqenAvVW5v?=
 =?utf-8?B?Vy9aeGc3Mk5hMmJiMFhweVNYTzcvUHpxMHVSSjNaUzBZQlJqazhYdFMycEJZ?=
 =?utf-8?B?VlhyZ2M5OHdTa05FYjlJVjJJMTQrdVJNOHFVTEJPNFUvekl0dlN3dXV3ZUI2?=
 =?utf-8?B?bXgvNzMwSTZTTGFJcEpkUmV3ZW52UDlFSE9YcW9lNUc4eEFvcDVCa25WS1BF?=
 =?utf-8?B?V29BU0YvbFF6SE1GRWxNcTJvTE1tR0UxZjFGOHl1RTNCMXVkdlRSZy9mYmpu?=
 =?utf-8?B?azdvNTBTeE9uQktMVmxiZVVFcHFJOFFOUkwwN0kyRVVzQkh1b3JrTE9rYVFL?=
 =?utf-8?B?K2tlYTduVkh6WFdNTGpQelM1TGFZa2ZVR1RXNXZlY2k1dDBWQWlkVEIzYW90?=
 =?utf-8?B?ZEFTajRyd2JacXprUVNYaWdWa0lNUjZUb0NSMHN5ZEo1UWh1YVA3N3M0eXN3?=
 =?utf-8?B?NWsyODV6eHBRWUJRWUdZQVcwRC8xaTNWMmtGaEhXRjlNSlNsenVEZXVMNGpM?=
 =?utf-8?B?Z21xMWM1cUxHL01RRHlGRndaL1hLc0hzWHozc1R6bHM1R0FIeUJybzZaUGhh?=
 =?utf-8?B?MUlsanZzZ053Zy9wdnlvYUJBcFhyb1J1Y2t5MkxFb3hSZ3l3V3ozeEh1V2ZQ?=
 =?utf-8?B?VHo0eFdBb3pCQ1h2RFJvL1dKVWV6eFhDb0E2MWNxT3BQMTFNUzVoUmRRM21p?=
 =?utf-8?B?S3FETHlVR01TZHBsZlR0cnl4T1RxYjl6UXE0SUxxRXc0dFF0ZnpJT2swUXJw?=
 =?utf-8?B?aVowNUc0ZTNLOGFaUE1PM0VNTlZXWTZReXpybnVxaGlmYXVQMURGSkdnb0Vp?=
 =?utf-8?B?Y2pGOWx6cE1yZ0kvMTRLM2xJeE1JcXZrMklaWjI4NDlYZitrTnpmbWZaTGVn?=
 =?utf-8?B?OVNlV1gzM0p2OHd6cWIzOU0xblpnVnE3Z1dlNzRzUlQrb1FYM0U3aUxjaUJs?=
 =?utf-8?B?cGQvWGZlNlYrY1ptSmErRVNPbEI2QUJmMUxvVVFpK3NxLzdXSG1YeEpURjRO?=
 =?utf-8?B?WVJITFBtclJPelNWUXFTbGxJczFtYThWS1JNNG1qYzFPRTVJbUZNMnVSVHdj?=
 =?utf-8?B?dWUwSE5ReVRlNHIzbUs0ZS9ISzFhNWJ1NGM4OHlxSUZoMGxQQjY4VzJ2Sk45?=
 =?utf-8?B?OEZMbWFydGRNalZudWtITmlFb1c2c3kyTHZGczdCenhOSWlGZDRwODgwck00?=
 =?utf-8?B?YVo1dHN6VW5kN3ZONzByQ2F5MytSV1lYYVFXb051R2FBcVlncS9ZUU9EZXVY?=
 =?utf-8?B?K2J2RWM4WkZwZWUrWUQ4VWdxSnRrWWJCMml0eWVueWd0aXAvVDhydzVPeUZi?=
 =?utf-8?B?Z1ZjZzFKVGRHZHRNc1BlVTRWYXFDekVmWDhEQzkxTCt2VHBVYWtXOGVRRmh6?=
 =?utf-8?B?UW54VHZXZkxXQ2F6TXNsZmhvNHRPTU1iVXJaY2ZETXhiNGY0VmlncDhnMm4y?=
 =?utf-8?B?T3FWMThwS01CU3RIN3J1YkU4KzUydHcwbkpBYzZwU1RTejZRbk5NWG5hQ284?=
 =?utf-8?B?YmRtemgyUDhpVFJJcnlQcmhaQU5za2wzbnJsRWRIblQ0NUJoUnlqQ0tJQ2x2?=
 =?utf-8?B?eEtsUDgrdEVnZnF1a0tqYjVUclFYZzFLN1Zndy9ieFpqb2Fla3k5dG9wUTJh?=
 =?utf-8?B?dC9QWHU2aHFhK1JpVGo4eSt0WVAvSmVoQmdTbUtZdzlpVmJ3WkNybzd2bVZJ?=
 =?utf-8?B?UlpVdXM1bSs4Z01oMjZxNDg2Vm9HcysvQXFOK0VqVGpKVTk0bGlKL0VZZWhy?=
 =?utf-8?B?ZndrNFFCSHQyUWRWVnJ6cmtCTlY2RC94aVNjVERwYWk3VXRseWVLdVBaSUpC?=
 =?utf-8?B?N1FyYVBUWjY4Nm05UlVXNk9zcDRPVTJKZGEwdm5nV1dNajlHSkxMMVZNVUdK?=
 =?utf-8?B?TkJ4OVhIeXR4aXdacmVlTS9teG90WDhZWmp2TlRFWUxKYkhBNmpkczJuYW96?=
 =?utf-8?Q?j5m0zUdQ93hsTeq1NLF9BgLhT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ff64c7-de9a-4bfb-c06e-08dd26dd20e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:33.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD2oFTTUJKXRjZyLT2oh+iao0KNwr0nZ8a2u/HrrvcMaWm+QIY09MWs2jLoUPjFMjxc6FzhvpT3XbtSHfrakHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/input/misc/nxp-bbnsm-pwrkey.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/nxp-bbnsm-pwrkey.c b/drivers/input/misc/nxp-bbnsm-pwrkey.c
index 7ba8d166d68c18b396e616f6f9074ae98c4629b7..5faad2c98af35c52dcacbf25728dbaf2cbb3c625 100644
--- a/drivers/input/misc/nxp-bbnsm-pwrkey.c
+++ b/drivers/input/misc/nxp-bbnsm-pwrkey.c
@@ -179,20 +179,17 @@ static int bbnsm_pwrkey_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
-	error = dev_pm_set_wake_irq(&pdev->dev, bbnsm->irq);
+	error = devm_device_init_wakeup(&pdev->dev);
+	if (error)
+		return error;
+
+	error = devm_pm_set_wake_irq(&pdev->dev, bbnsm->irq);
 	if (error)
 		dev_warn(&pdev->dev, "irq wake enable failed.\n");
 
 	return 0;
 }
 
-static void bbnsm_pwrkey_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-}
-
 static int __maybe_unused bbnsm_pwrkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -229,8 +226,6 @@ static struct platform_driver bbnsm_pwrkey_driver = {
 		.of_match_table = bbnsm_pwrkey_ids,
 	},
 	.probe = bbnsm_pwrkey_probe,
-	.remove = bbnsm_pwrkey_remove,
-
 };
 module_platform_driver(bbnsm_pwrkey_driver);
 

-- 
2.37.1


