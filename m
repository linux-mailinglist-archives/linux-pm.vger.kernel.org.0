Return-Path: <linux-pm+bounces-29314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CCAE40A7
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C41E87A9D4B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558D242D6F;
	Mon, 23 Jun 2025 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="MGnZNUea"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013039.outbound.protection.outlook.com [52.101.127.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450B239E84;
	Mon, 23 Jun 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682374; cv=fail; b=c717K9CR9JJdr+OO+bycQXnxogBeXS58DZX2Q76O7siRo3rMI2lNPNr8VywCBVt9zUDE6xijvzD1tHCHF0qZ+YB3pLwbn08DAj9klbWSX7S9NO7TzVViRhK1l30AKRvFht/G6dgyK4lwJ443IX4kthpbMY79XGX0gLEBYGIbUKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682374; c=relaxed/simple;
	bh=6FkJk9jQ67iK68a2CSIV+I58zHMBBFV/IO5kNjiqWO0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IPvRrFBqZ8kS8gYcC3ZTxn0wS8UoB8SmzBZM4AOtWXEVr5qN290w5c7sx5ZphVSb2r2/u030gJhjrhNqQoLak9eagvjJyaozPTOdYmjdqGjooJ+xq5i1rcMdbf30G76yKKkQEmZSyZL1oVelNa48r/wglHm8P3nn6+oAqPTBhx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=MGnZNUea; arc=fail smtp.client-ip=52.101.127.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfDhTOfJMRuQJ9sbZDX1kUIasy/ODSEJ0a41zx5dNuiOyQ1eWS29yzmgnMt7hD2lNkqS1fNMyOsEgXhjZ4fa1UT8huxedrZfmp7CK4kxhFQ+1XsKbtAGRme9E+oL0/RcFgleHli8hKJUmx1hxZSGFCc5Zy99LKDuyug6Jt+5vyxKPrIhw5zYu/z9aihkoThuSkAyIPMw27GmLOpcy0yIai7ztjUEO2dw768z8RJciusZMw8a1wmfT+EuyCZWBPVAt13jSpw50exdhPq9yTsVFc8ldcCd3EJwW+9ekPkh4uw8eZ/agr6LOvKqV03sgnAmbttrYG04Ae1lTy3mZR27Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN07oeb20Ry0roUHWfBUvPJITjHi9aJrh12ugIVNthg=;
 b=i99w471DALnO4xyFTpy5yX5HSda1nakcpXnqe0EZK7XfQg0FKPuDep9kHSYOK+twoXzcK0ck917ZnarRRSPZbXbkHJ0njFP8FcoMsKCmJyWF87oMrfuharDW3tXUUOCGePWE7w9pbGoBeOGwI5L9jFNyssl9mmBk3U2PbEvuLBYeuSyMLeHoJ0VbbtuIbQeriYOU4+NhVPxRiZvQqkSFd6Gp9oPMfcVCYAhWMvP+Q9s1JoIKd52YFXWq8raEOIh4FWFLPrDZBM1aK+UTsJ1uM+VsJRNEUy+iX+yQGa08rDxkvZhtmcURsSCO9TbBXv8EJonCkW+uMLcUke4Vb5leSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN07oeb20Ry0roUHWfBUvPJITjHi9aJrh12ugIVNthg=;
 b=MGnZNUeap9XaDzg3k2mX02xC5LwYc5tazVV0Al37oGsIrbrKTYK33sk7pTUy6akh2uexqX40Tq+z/8kdo9O4J0Cry2E4/piHMpH5Fh+sQdZ/y9XTzHr8P1gXMm2N+3yc7ad7MsFbn0idbEqAVezi2Hm9A3Dn8poQjEYzu55/0Ir34T+oqy5L/f9B6pe9N9zqixE91gN32tXGQB5P8WAP9SChuPaMCBrSrfMvQ6Fz1lqlf9BIUGhDJgLFZGM6GAo2psYlkqiJ85CLCmYAeHke/sJ8lH5Zo5apOVVmGg0/DtmDvxlB+m9UuwbaGtWNuBKe+saLA71fpSQFf/N0m8g/Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by TYUPR06MB6196.apcprd06.prod.outlook.com (2603:1096:400:35c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 12:39:30 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:39:30 +0000
From: Pan Chuang <panchuang@vivo.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 14/24] thermal/drivers/renesas/rcar_gen3: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:39:19 +0800
Message-Id: <20250623123919.474049-1-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|TYUPR06MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: e063562c-de46-4c98-6bca-08ddb252ff66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmp3bElUZ01XbzdqN3RHanFSZTBRSU1LQXNKMFVWRE1OYzEzVnc3SWZmZHZQ?=
 =?utf-8?B?dFNweVBxeXF6ZDRpdXA1ZFBsTklLWmRla1FaV3prcjgxc1N1dHBFZm1uRmhw?=
 =?utf-8?B?alRQbFpPZS82VWdVTnFIdzVQaFNBS3kvOUVBZ1hza1RmQ21WNnFKeFJmVkk1?=
 =?utf-8?B?ajBrUmJnaEFGV096NlhnTzFxSUNQQVFSRXBDaUJnZ2g1K0hZTlRVbXl5WWdB?=
 =?utf-8?B?VS9FMTgzbFNwNG1KVE56b1NDYUpOZDZ6a3FzWHBLbnV1cWNhemlJRHYrUHZv?=
 =?utf-8?B?R1BQNzRDeURsSUVuQzBNOUlMMWNqZThycFhYYTBkZ0dTcGRKUkp6cU54Y01W?=
 =?utf-8?B?L0Q2RUlpcDN5eS9GL1k1dksrWlhJTThyZjBSL2J4ZnhQN2dETHIydjBLdDg4?=
 =?utf-8?B?U1RUbTl5MTlPSWNVOE8wSmpVdENRYVpsbldMZkVoTGl2eFM5bUNrU0pnZkR0?=
 =?utf-8?B?K3UxdDI4UG1xWmNvUHFYRzc0cXRKQXlYSHhjMnpxOXVKSVpQdWRRb1FZNDR1?=
 =?utf-8?B?L0Y2a1NTSlZXa041R1lQd3ZYbDJCZXp5emN0UVBBRVZjWnJOMlRxcGNKWFBS?=
 =?utf-8?B?MStIOTkvalVCZzhBZEIra0hyMmhOUCtwMG5WRHNKdER2ZWtGcXhDZ3BRRTll?=
 =?utf-8?B?a2JOWGFyOHFUM2RhZXprT0p2dWJhVkRJcmxWUU81dlNZWTFRQnVFVCsvNklI?=
 =?utf-8?B?cEZZZDdUYmlrelNWZ3llUzdtK0c3T0xYUXMxOWw0WGZGMlBjZXM0MWZ0TG9U?=
 =?utf-8?B?RUZGMFJvbkpibWJ4a04yNVM3OG5xNVN4dGFkaHhucEo5Z0s3SXl0dWdsaUlB?=
 =?utf-8?B?bVdSQ2QveTJMalNYek1GaHFaQ2VvUHRkODlUUU9HcUZFb0paWEF0QkJqN0ZS?=
 =?utf-8?B?SXJDRnhUSDR0SG9SdityRjVCU2xWaExEUE03TjNPcGVReGJOV2VGTVZlSHNt?=
 =?utf-8?B?NkZQRzZjanc5dWNUQXQ5WFRvY0M5cGdEMkJYSVZhem1Ma2pBSUF1ajEvaVZn?=
 =?utf-8?B?QnJKZDhsRzQrNHgyQmYrZ0pEU2d1V1lCR040RDFoajdqd0I0OFJlOTNLSlVU?=
 =?utf-8?B?T2phdGpnMkkwSUNwdmNrdXNQRVMwSE1qVWZkcVY1R3FGWmQ4WGI0M1I4VG5x?=
 =?utf-8?B?ajgrS0pKcEU5UlFFQ0d2Q3hudEx2VGtuM3VmdzRsM055aisxZVFFMXFmUFhY?=
 =?utf-8?B?djhLUU1ORGQ0bSs1a3dBZmxLdTBoL1ZIeGppMmNhN0hpeFAvVDlMVkZCczNs?=
 =?utf-8?B?dXdRUkYwcStZOHB6VmRzZGlBYVE5MG1nUm5GT1FlUDgydUhvWng1NDhiUW1I?=
 =?utf-8?B?L3NXZ1pJMktTMDljWVN4ckJabHk2aURwZWFHWjM3QjhpMisxRWNIKzB1L2Q0?=
 =?utf-8?B?NGVlSllkUUNscitCZ2VCanZqZGYrOUlHMklINjIwbWpVaHhTMGFJblNwVlhS?=
 =?utf-8?B?c1Y1bWZxeTVQYVJFY3I1QVNhWHYxYStvSEtKRmRDeGQvUjUzMytGeWpRYmpl?=
 =?utf-8?B?TXREQ1dQUGloYitNWjQ4MWk2YVpsZ1dIaGJiVHUyRkdGUGpYQml6UUpsTE80?=
 =?utf-8?B?UXZMSyttNHhkL05KYTNrdUJSeWlIRUtEUnVrNWZyUHplSWViNTFQZm9BRWZz?=
 =?utf-8?B?SjhvNWJNTjB5aytXNTFxb0Y3cUF2eWpwamRLZjRPSGx4MGtJNGd5UVUxWGZn?=
 =?utf-8?B?SmxUZXVwK0NEUUFoT21JNmtmSjVucmpIV3lxR0pka1NFUjdlbC92VGYyOWFU?=
 =?utf-8?B?THIxRnRDb2VGaTJreTRVNHhma0YrZXBvY2Q0NkVHMTNYU0VsbEd1bVJIeWty?=
 =?utf-8?B?TDlpZURqODYvMHJZYzBrVFNFQnc4VVNRVXVWMDZsTFV3WnZwa1oxaFczVFNh?=
 =?utf-8?B?R1F2LzJkVkRROHRXSUpDUUM3OFVTSFBPcldmZVVhZlJLUVhHcFB2a1RsWEw3?=
 =?utf-8?B?WFdzT1NaaGFpUU5hbGorTDZhakgxeGR6L1pLVUMxbVlIMlhWNDVkWkhNbk1L?=
 =?utf-8?Q?2+adiCJeAP5ejtOvXM2cnADQ4NmSAE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUgyb01BeVdZaUIwakxIK2Y2QkpER0pIY0tWdDY0U0pzcG5vaURwTTBzSGZ1?=
 =?utf-8?B?MDhzSHlsemhTUUNrNHc2OS82SnNySHI4aFFxd2hoK3FGTThmUWx5QTdJbWpJ?=
 =?utf-8?B?QXRqWjVpeUJJYmp1eVd4Tzh6ZUlra0V0b2p3UGhFYkYxbmZleTZqUTJvL2Rs?=
 =?utf-8?B?UlF5MGhMelBBa0ZRVStSSU5BZDdqQWF2anh4VU13aklqZ1M4b1JnUnJEd0FJ?=
 =?utf-8?B?d1cxeXMxNmZVSlluTjJaZ1BJWGhBeUhHeFFjcThnelRiMGZkQkNRbzhzNjB6?=
 =?utf-8?B?TUhNTUpVVVNBRDRSaVJjZEZ3TVJ4OTdtTkVVa2QwYjMxZlFtMUdxamxodGFa?=
 =?utf-8?B?Um5lTEVIeUVzZWtIZFZaN1AwSjZBV2NQVDRDNWF2Y2RkTERLZ3l1VDFHMCsv?=
 =?utf-8?B?eUU2NmZhVGo4aFUvWGgrTGJ4V0lIMGdyMzMrMXRNQjNpdkVoZzhRRlp1UFFa?=
 =?utf-8?B?Nk12RjJjMWdnVmc5L2xDaktYa3J4TitrWk5TK2NjUGFMQldXVFpWY3lnOG93?=
 =?utf-8?B?SVdyb25naHVDVFU0cVlQekx3YXNXRWJxMThLMW1NdXRVd1U0d212RFlIRFVq?=
 =?utf-8?B?Q0d0a0V1czVCQ0lOdVdXTldCd0ErVVZoK1NVUDk1ZFBOSE90ZDJxZGkwMDAx?=
 =?utf-8?B?a29aWGFuUFhsZHhKS09iVktKdWFFclFWM3JPbDRLaVQva2Z1dElJZEZFS0ll?=
 =?utf-8?B?Sm5EYkxRNjZ1Q0ROUTlGNHJyUHpXSTFidWg0TXYyMXBNZmhnSk9UaXl6cDZR?=
 =?utf-8?B?TUNOUjRaRW9tTDZ3Q1ZzVDhMMkxVYjlqQyswdjNaalJVT3p5TG9qZVhuekEw?=
 =?utf-8?B?QmQ5NFk3bzduV2ZpeUhvV25XOTJFWERmdHhneENlblAxZmFKaVB2RTViZFJD?=
 =?utf-8?B?cEtHcFh5eTI5NjMvd2ZIb29qODl3UDl1Y0pEWE9SOXBmcVBWa244RkRwb1FF?=
 =?utf-8?B?Q2Q0REI5K2hURTFGYkswNHgvK0g5ek1jWnYwVU9UQzdJTVZvRXNONndyaFNo?=
 =?utf-8?B?Q0xaVGxRTUpVL25HN0k4SC9SUzlJQ1VaMWI2LytIYi95T1ZhVkpUNkhJK0c5?=
 =?utf-8?B?QzBBLzBDaEdUM3BvSlRZZGUxRWVVaEVsWjhUQ0M2L091aGpVK3RzeVRvdGhW?=
 =?utf-8?B?d1dRRXpNd3BhN0o2em1ZL1plUXo0dEIvSTU1SFMrNEd3VnZyVlkrVFJtQ1BZ?=
 =?utf-8?B?Y0M3a2lKelVkUlIzaCsvc1NJZWdqbzh3RFdPSzc2SkxLRUYxb0RlOVJCbU1v?=
 =?utf-8?B?MG56QTd1aWIxU0hCTkxjdG11RTFWOEFodTRROTY0Vis2OFhud0UvcXdyaDc5?=
 =?utf-8?B?VUtWekxicDluRkRNWnhWalQ1SFhGQ3gxU090ZWJIYlcvck0zOE1CNlA5SXZP?=
 =?utf-8?B?NjVRNGMvRUREdGlCY2RYN2Q1bWY0a2Vtdk1taWdudnZZQXVPWnVuRmdBYllQ?=
 =?utf-8?B?QTJYM3AyQS9XRUVVanBnbFdzUlVsN3BORU1wQ2pPQ3lpMDNST2tKRjBaS1da?=
 =?utf-8?B?QnV3QTdUaWU5SWpDb09xT0NHVzcralNrT05GS2x4N2FzNVBGb2lzKytyeFpM?=
 =?utf-8?B?U0IwK2ZCdEwxc1lzUlVCSFgzK0MvODYybjFxbFY2ZkJPOTBnbWU0VXJIY2Qr?=
 =?utf-8?B?Y0QrTjg5WTQ0K0VaVFV4Tzk0V0lXWktWZDlSNGUrNDh0T3ZHRE5aL1Zvamxk?=
 =?utf-8?B?bDgwYmZ5SXJqUUdLd3NtZHZGTXlGdGk4dXY1UnZWZ25ESVhYaFdvRjRyZ1dC?=
 =?utf-8?B?K0tLVFA2b2ZKRUxpTDVkNGRoL0wxOHA3aVVuQ2RJemFXWmlBVmFGOXdSUzlx?=
 =?utf-8?B?Mk1pWVRTcStjT2Zud0krUHZkSWgvak1PWGdQK2tYSUNCWlF3OUQvTCtCYm10?=
 =?utf-8?B?cVdTWHBqKzVkTU1EbUF5dHNqZWpIeXFNL0RuRGtJbWJtUmFNTER2cStGd0hH?=
 =?utf-8?B?enhnZTFmZGpOSUU4aHBqcU1kVjNsRG9KM081a3pENVh2NkF2VlVnODNML2JJ?=
 =?utf-8?B?c2ZCL0ZLeUNXdFd0K1J0c3o0QUxmY004VmN3WnQ0azNBTmJydVZDMXgrTkdl?=
 =?utf-8?B?R1NvaElDSHllblRPOXp4MkFVS1luQXZWK3gxSzBaOXAzK0JiWmUwZ2MrYmJP?=
 =?utf-8?Q?blLWznUlCCqwaLt2rRQw64TfF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e063562c-de46-4c98-6bca-08ddb252ff66
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:39:30.0594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIuVKJKm2CqebjiWo0JyAG19ha5RNFK5CFJ4SPGhgy+W7+YrVgiT0HgSxs2XE31ngzfqYdVaW+MB4SHUEaZWwQ==
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/renesas/rcar_gen3_thermal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_gen3_thermal.c b/drivers/thermal/renesas/rcar_gen3_thermal.c
index 24a702ee4c1f..e7ba1aced606 100644
--- a/drivers/thermal/renesas/rcar_gen3_thermal.c
+++ b/drivers/thermal/renesas/rcar_gen3_thermal.c
@@ -468,9 +468,10 @@ static int rcar_gen3_thermal_request_irqs(struct rcar_gen3_thermal_priv *priv,
 		if (!irqname)
 			return -ENOMEM;
 
-		ret = devm_request_threaded_irq(dev, irq, NULL,
-						rcar_gen3_thermal_irq,
-						IRQF_ONESHOT, irqname, priv);
+		ret = devm_request_threaded_irq_probe(dev, irq, NULL,
+						      rcar_gen3_thermal_irq,
+						      IRQF_ONESHOT, irqname,
+						      priv, NULL);
 		if (ret)
 			return ret;
 	}
-- 
2.39.0


