Return-Path: <linux-pm+bounces-29315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A6AE40C9
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF17188E4C7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE664248195;
	Mon, 23 Jun 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XWIDW0/W"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013020.outbound.protection.outlook.com [52.101.127.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4B24502E;
	Mon, 23 Jun 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682407; cv=fail; b=tym0CirVJtxj17C+fILoXHAXZgu1e/3NujsDZQkbkN1W1b7qpiDDiDesdCxRithv/FR4FNIH0ahp7h39Hphpwe11gQsDTqQmayjwZPIT2TbPPOzJWnC/jM3lMN/nP5ylrMiHfTTVNC5O5+Uw5EBuo4K205d7tF62WC37Pgc1I/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682407; c=relaxed/simple;
	bh=UMw1/yYmiTHGBIhL6SUnBNRCuyW5uYyInUsydHh+544=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VIWMaIPEPuMtFS3bePYSp/abZ00lo7tSLQdX/7Yn3gR3MsOq4s2jHBtFSSY70DdlzY+BzsekJoWQ0b7xBDSln2P8CMLgz8vSo/oEFFdcqPHrUV/7IgtXx+T7Vna59zGhVrxThd5Pand0+I4j2G885nlLe/Wy4XZmRW01R0uufVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XWIDW0/W; arc=fail smtp.client-ip=52.101.127.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Muki1GNT0gRtSRX5oLhYfcCDxp9pQh92lbI42tVOQ4J8vQaZgCKiTRl66EnLXps1qirj1SxXpoxH8KYUhb2utqmZFRfZXDb2HaNvMi3SvTXwlHImIT/bNsfgZmWGFjPcLfQoBjUp3rqYq4FyPAD81Aov8dV63zFTKHfFMhFdpQNWgBDTdPHtzIuph3BZ5xvyuhYdq8qwzKgbWHb1hcLtklRjmUZwvhIy/ycOLRwFx6lIstEMKLcAaDn6iGz6Rr7PJIUAdW268mIoorjoUDLOQ1sM7aBkY3J+Vq75dwN0TtaAJ4v7+pSfm7w2AGkOLiZqmoJo+/irisxt3hbHljVRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O7/+7Ai9m0OqsHin5+SL6BcHhcdoVf98qN7WrR5QYc=;
 b=VtEKOsONaR/u4rWwlNNZg0Jh4RbmU23WJsw6P89CNkmLFRX6POjuzjKJwRpRWrywqJoWzZ27irzy7fI2cJKdGyq2eAYM0c2302mt1gOnqLDBmTmOuliAoXnM0EHnJ1IbbM7P8k8rxyIkp8lL//UgucbCQumMDneva0iNwhOzLvpbRaN8slbKS6cKZfsH98uiQk6Fii/Fk6D5wPDJA8RUDUUrk6sd3i0e4z2WYaxZlPMXAZtvfeyqbwOTvvmf91Lj/IRE9lRW5uqj7jjHraGmI8/dB880NArwnhrqenIvX8DjXRj0PMu1Bs2I4dZX45r50PBxsI59Zus2PhhNwpWo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O7/+7Ai9m0OqsHin5+SL6BcHhcdoVf98qN7WrR5QYc=;
 b=XWIDW0/W7lYb3cTk/W7UEldMCY58dRlVkQG/RItDeyeTJD7eyQokuVBsI5ymX6JyZD8Uq+gcmEYb2eYmVuxI9YNBmUTEuv7RdpQX43t4vivpb+f0FiXgyjLwI/qxhddJIn0czPI60YkUXLfZmnshcJ1RkfHZf+ppGezPiL83ZGo5fjv8nM1eionRLb2BZ/BHXiCB3LYkWnTlIpbAmxZ3E5EChRDrv+ANA9CAE3qED8l1VHDQlwSFEUsZW7qyd/SNZi2inEkfcw+mGeWHdHPSnM24ZA7xgWqy/dnrGeuUbDmtEqYqfVdgnAVHwYKpRLzVkWaan7edFmK5a5yN424nxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:40:02 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:40:02 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Julien Panis <jpanis@baylibre.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 15/24] thermal/drivers/mediatek/lvts_thermal: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:39:37 +0800
Message-Id: <20250623123940.474310-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::6) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SE3PR06MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3d9859-341e-4d70-8e5c-08ddb25312d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDBCN2lRVnpXYjBIajJPWUNnYUJWbW1hMHpmTWhHZFE5UnRBNTdRUzNYQUZY?=
 =?utf-8?B?WDBJbUJuRDhQR0JkYW5NMzZDdGdITkEyNDR0bFgwT29HdGdPMjdiK2o5YWs3?=
 =?utf-8?B?VGMyaXFqZ1h0WW44WTNORnl6SGExYjVJdVk0bnBBVmhYWVN1S3RRMVdmSFRr?=
 =?utf-8?B?TlMrK1diejFIcjFVdXdXTHRhYkwzbUhEaGNBVzRjMEtBbkd5cFdRblZhdDEz?=
 =?utf-8?B?UU1YZmdidlAxU2orMG4wSXp3cmhYb0QwL3pvK0NEajA1MkxyQTVEeGo1SXZN?=
 =?utf-8?B?TVk4Um81alJEejFSNDFNelpaUjVHTkxIRDgrbXU1L1NoOGRHT24wWjN0UFRs?=
 =?utf-8?B?RXVyZmFpRTloZ25NNWZ0L1BhYWxiMDJpS09IWUxESmRJU3A3RnFFd2tHR2U3?=
 =?utf-8?B?YVB5bElhdXhMdUZyRHQzM0s0Vk5xTGFraW03blljZE9PSENHTUdEZjQ0ZlF4?=
 =?utf-8?B?MDBQbHFzQk91VXoxR0Y5dUd3eUdGNzBSQjdIOXpoVzRzdmlweTV6WnNuQzMv?=
 =?utf-8?B?cWxTbm5sLzM1c2pGQzJWSU1yUzQrV3N0SWlFQUREOHExRWhhclNLNEZZUGtR?=
 =?utf-8?B?MVduQUdNRUY2NTNtMHNTVEh2TWMxY3lSTVVYT2F0aWFtZU5mNzdrQ1JENnNh?=
 =?utf-8?B?Mnp1d2dLMDF5YnZkbU9naXQxL2ZXcGxFOWswRk1tTnZsaE9LL1Z1Zm01eUIw?=
 =?utf-8?B?QUZSSHcwQStFYTBHdFhTU0JhaE84WHFRWmRVMjl0VUplZEhTeE5xczh3QURn?=
 =?utf-8?B?djMwQ1h1WnJmNjFDZFlOZTBnUEwzYW8rdmZZOW55ZWpOTFRDSWJoUHJuTzlZ?=
 =?utf-8?B?QUZLdmNMNzlqT0F4bzJ4YUlvUXpLQ05pRlc1WDNkakZnK1o4bVZXa3FBQWJV?=
 =?utf-8?B?aFZ5Z3k3UkNJVFRRQ0JDbHRwYlEwRWJwelh0UHowclFtUHVGTmVmSW5oL1NQ?=
 =?utf-8?B?SkJ3Z3gvaFhDTzN5cXJuUklzd1pIZTBlTE9RSFllT2NrV0JRczc0eVZ0c21D?=
 =?utf-8?B?NzRKTUoxRkZuNmpwYWNIMm9mWFVOc0hxeG1LdWIrUjlwQ3VLZkxRZzNRQkl4?=
 =?utf-8?B?amdKdFl1dlo2QlVrQVFJdjhOWEthT1VDclkvNDRQWHpUbjFhUlM0NEorWTll?=
 =?utf-8?B?UjZ2STNvQTJ1aFV4bWZhd2FUWkl0YlVRNXh6QWVhb2ZvdEJ2aUhEQkpKRTNi?=
 =?utf-8?B?YXRha0piQytmUmZFK09uSEJ6Qzc4eGFDU1creXNCZ3h6ajRGOGxaWGNuUXRK?=
 =?utf-8?B?Tkx2UnpQWFNpQTgxc0hxUUdtWHEyTmN2aVYxOTJhdVYxSjZhOGR0Q3ZwRThr?=
 =?utf-8?B?WDFkUnFIR2NmbWdXV3U4MlFRWDc4YURLTFA0TkNoZW5rQWxPbklOL2gvS0dP?=
 =?utf-8?B?SUdjZkVpS0pkV05RWmJLeExnOGplS3p1TDA0RkxFS05ZZ3lLWVlNVStqcmMx?=
 =?utf-8?B?TjR3UlV2NHF3Y1pQdzdldFA4QU5nNVBaNGNWckZpdGJoa0Q4VEJnMXo0NHMx?=
 =?utf-8?B?Wko4VjRlb3BFRTJsZ0Z1eTBpV20xSFJtSXFLb0FoRGdnczdIcHhtRDcrUENM?=
 =?utf-8?B?YXpCSGRmMFl5SDlBQ1E1RUVJdTBjQ1FsZDc1dSt5aENMdFNINFV2eUJFSDRo?=
 =?utf-8?B?dHVWRWFDZzkwcTZ0OXFycWxOZ3lHQ0pNK1hwWVovRTdRNzA5TXVyeDFjQzA1?=
 =?utf-8?B?Nk9aekhLQytsWmhkckNBYnZsY2NpV3hpd2pFRVpLNFV3RC9sdUpaVVhzMzVP?=
 =?utf-8?B?bUZUOG5iMzdGRENGUWVlNyszS2pZd2dVOWM5LytOVERhcVptcWFTdmhidVZ2?=
 =?utf-8?B?S3JjSDhPTkRVWUZqWitTRXdZOFI4UE9qQXNneVZVV3VJclcxa2lvRXJrWnRv?=
 =?utf-8?B?RFNaUS9mYjJEcW9MRkpmK05hekkzYjZhVUgwNzZJYk83QnBoWkJYbHJ6U1Zl?=
 =?utf-8?B?eVc5Tk5TcEpsRUlhUUtXTzlJKzJvdUF5NTAwc09vTVBFV3VvekdVYUk3L0t6?=
 =?utf-8?Q?H1tyTz4hdtBEjF7yqxZyZTH3SRSKg0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2xuOTUwWkJVUnJqR0JMekxqUVBsRjBkM2g5ZzNuVUhwYWZORmZSTUxEQ3Ay?=
 =?utf-8?B?NnNsVDZNNVljUXhTTkpzWDBoV093bGVDNitpZUgwaGtXaHlPbHFOU0xjQUwv?=
 =?utf-8?B?WWFFT1dlU3VldTNlVUNFaHRNTExkNTlHR3ZGMElaRGNWQS8zdUJZRFB6QUZE?=
 =?utf-8?B?WUtNVWJvbkl6OE9nSzB0MHM1STY2SzdKUi9udWNUNlFZcVNqZlRZcVhHbkZH?=
 =?utf-8?B?SGpHSGFLclM2ZDM0SndJY2tpTTEyRUtISXBiZ2JJaEVaODdyV253Y1RkVkR6?=
 =?utf-8?B?eGFSMURQUXAvNUdSbkxtcllUV1BvcnQwOE1XajBQVXIyenU0S21jbG1DNmo0?=
 =?utf-8?B?OHJKL1VUNjdOZGNnZjREWGVOK3E0b1RTTnZsc1k1M29EaW44UHBITUtZaGIr?=
 =?utf-8?B?cU5iMUxXSDNvZjVZcm5xTXNlL1VWYktPUzY1dUpnL2dGWWloNjcrcDhSOFJF?=
 =?utf-8?B?bER4Yks1U3NYeFdCRENUMnRIMFhmVHA1WjJSL2s4Vm40OHBGUUNiUkg1bnZR?=
 =?utf-8?B?QS9rdnRLM0Q0ZVVCbzkzK3dGNXBaNjdOZHhHMzIzc1Q0WGpnRXVUM3ZoTytQ?=
 =?utf-8?B?VytKZW16cXNST0VUZmJQOTYyU1dOeFJhQm5NaFBOVWszWFlNWkxvYTlmT2FL?=
 =?utf-8?B?N3d1UDRmQVNGR2tKRXc3ZlFGVXZEL21FbXJ0U2ZyM0IzZTRONHFvSGFmU002?=
 =?utf-8?B?WFFVUkptQXduNHp0VGlVdTFCekZDY2NCd256eWZlaC9iVWRqeU9tYWtxYU5Y?=
 =?utf-8?B?SWs5RVlSWlBJMmpDWFEyNGZ1WUU5MHhQRHNLU0hEaTc4TTRzYVdWNlF1b20r?=
 =?utf-8?B?TWswWmhrT2hIM1o2NmVmMDBIN2M4S2VkR2xnd0pQTDFOczlIcXNLREtBN21m?=
 =?utf-8?B?RXhyb1htVm05ejhDdHZvajhzdjhXY0hmdVlkb2VXd0xuUHRXQmhMY1JScFYw?=
 =?utf-8?B?RFNrN2FjSkxSTWFiTHJacHNGQUloWDNwMkhuYldnVXZtRnNaV2E1b2M5TEpv?=
 =?utf-8?B?SGtWN2k4Vm5WTm5LckxTVmZFQk9hL0J6cXhURVFzZzllWDY1Um9QZXNRaXY3?=
 =?utf-8?B?NVZHNHF0b3VreEM4KzNjN0c4S0xCeStFcVdWbVhJTlJScmlzZFQwaXdTcWxE?=
 =?utf-8?B?NzE0Y1drcU5HSlFQcUxReXA5UDZZa2JBY0ZLZ1QvUURIZ1BEb3NxSnE4OUxo?=
 =?utf-8?B?ZG9HUjNjY0UwMXZ4RUN3amhDQWlKWVdxSnpBS2hFckwrYWJMYkZwQVFjQVBB?=
 =?utf-8?B?VGhQSmZSMTBFeU5HSHBFRWEvOFp3SS9NMGlaRnpXWERUWXVCdnM3SDBndXZv?=
 =?utf-8?B?bzJnSzVZWm5pYTBnVmNla0RCUmFtU0JmQVQwaGJIOTZyZ2dydEoyK0hOUWZ2?=
 =?utf-8?B?THhVKy9BQ1NkZG9VbXV5TlVyaVp2MWVNNnJsRUJKWnhLdDlRb0pZMk0yWnZF?=
 =?utf-8?B?am5UdlduZmNHckhwMVI0dGo3SEQ5T1dkLzdBT2NvSDJsSWk4V1h1VUZ6K2Q5?=
 =?utf-8?B?M0VpMVA4dUp4UE15YWl0WHgrdnpTcG1od0V2Q1hIWmRTTWdNUFNRRlhLWmRX?=
 =?utf-8?B?SjNiRnp3d0YxaTZEOHBWeG1PYWhYREJ0c0ZGQmdWR2lzb1pMZEpqamhvSjhV?=
 =?utf-8?B?dVNzMW9Kd043Rk9PY1c1V0FoOWFmaERiRlpHb09mY3RtSFpwQ3ZES1VZT2RG?=
 =?utf-8?B?SjJBNmdhYzkxaFpyWDJ4MjBhL0RPcloxVWVCQWRZemhqMEpzWkNJd29tT1hj?=
 =?utf-8?B?N1plNGFBQlROMVBPQ2NUQWpUdkdqVVY1Y0h6UzhVY2tndTFUd0ZFRURocHdx?=
 =?utf-8?B?SmNUUEdsQWxzalBZdWNEcVFzTjJEYVVSck5WcTBpU2xmbDRIajVORXNFNngz?=
 =?utf-8?B?Wk1qUlNTam5JU2gyYzhhS3FyM0djR2x1aVlRZjJrWVZHWllHa1VMRlNDMENM?=
 =?utf-8?B?bGVvRnVHSUxyUU5ZY0VoWXhEaVVZNTRwWUNra0h4QW5yai84TTZhOXFoMVVS?=
 =?utf-8?B?UWszYUUwTFpxcXlpNnhlRFV3TDUzdEVvVkg5c3BFaHlTWDV2WE93NkJzTlE5?=
 =?utf-8?B?aWU5b042QW8xcFRjNWRZd3pSQ2ZQdDNQZnpxODh2VUpHTnptVUpRWEYrMWdh?=
 =?utf-8?Q?oH8d9MtqnIrM82NRO8ZWYZpIo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3d9859-341e-4d70-8e5c-08ddb25312d1
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:40:02.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf3PR5JLSougv548Xft8ZTASGjk5kWjgQUduVVaWbqKIkbygiiXaM5McPgMREaFKc61xxcttJful2nnqOcfilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB8096

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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 985925147ac0..459bbead3095 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1355,10 +1355,10 @@ static int lvts_probe(struct platform_device *pdev)
 	 * At this point the LVTS is initialized and enabled. We can
 	 * safely enable the interrupt.
 	 */
-	ret = devm_request_threaded_irq(dev, irq, NULL, lvts_irq_handler,
-					IRQF_ONESHOT, dev_name(dev), lvts_td);
+	ret = devm_request_threaded_irq_probe(dev, irq, NULL, lvts_irq_handler,
+					      IRQF_ONESHOT, dev_name(dev), lvts_td, NULL);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request interrupt\n");
+		return ret;
 
 	platform_set_drvdata(pdev, lvts_td);
 
-- 
2.39.0


