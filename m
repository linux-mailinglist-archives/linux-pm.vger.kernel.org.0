Return-Path: <linux-pm+bounces-29320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3FAE40DF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133F918860C3
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878C246BAF;
	Mon, 23 Jun 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="N8XikW6o"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013005.outbound.protection.outlook.com [52.101.127.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5C2417D1;
	Mon, 23 Jun 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682554; cv=fail; b=uLg6m0UBiAbnguIrq3Dbk4y7CV2T1JzdSvSXRGg97GB6tEnmcpU7LchrXFnFZ7HGKqYKJFZ56I0SHssg8on+r1VFwx8JzmEEhzV3FwN6yr4uxeto9f7JjPjJt+LP/1Xvu5yZX/K3ywIuIr02ENhaGoZnxH1sObSE/aFxdplw+xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682554; c=relaxed/simple;
	bh=8HSxXfItqCRjBiCW1mgwBE0gx6czQ9/W4EvXBl3OOxI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RGkP1XLuoaEcfaWYOel79+4u730XTEjJpoxc2/0iIiL9mbEz3hLvRtsXC0CNVL6g0PxqEJj/iRdF8B9hU5OnW6CaLLGKtVN4UNmDUG/pW7ti8/yozDsqqqHz6D3/1najdF2NnyvIYAVqlkZfEFlZSYxr+LzXCsdMrBjfHQ/XWsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=N8XikW6o; arc=fail smtp.client-ip=52.101.127.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvDBxbkUipDP8jUooMun6GYIEQFJEDDMc5szRHGlb82IU0eIbJzujCrFoQYUS1uc4DHQfmeGTeFieo1x3Lffp3HxJ8oumkGvrobAsjpKLWPpbTZviw/a3wZt+cdWhlwmfTmvJWEvS3ai2rjiF27c9RdY76FFYrTMzZM1SFNF5YrQpsAlxSQJFqOa1s7p2hGCmnNEJsd28fZoEy6HwMQIwhg7p5TfmcvJTJOFzYQwqlMwzxqqb32GlY4PfzkoBupWTOwkbaA3QC9/rsbom6JJL5tUzuFpA2H6ne7rZGlMWekXhP4hX2eLESm0Y56cIGBdlzwv0Tj3aOTZyGMSMTmqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abc3Cii16sOfg5vsiw6Uys17OgCCdI5cJP599frfTr4=;
 b=qJ2gtPWu2VjX7RTVMUV7kGkc/a91jIDWfUG0EOkDFGc2WPCyYLYjjbv11Vlc01vvSpGc9SCkg8DuDnUHrEmWI30LT5YO2XqFnAXMWbVI4AX9qJBmDRB2Flw2R7ah5K5Wm8nCLzALOL8y7ZoChjhRDakzLN0RpzZSaw9Y362H5NJtgK75pRLx/O/Clbp8BLcbjoClql4azbEMMov51R+cAvaYx48l3qGPxFJa5m8TCikTJJNPfPPdUYlhyho5OrwV1iT/DytQONBdfYDFrXCbSgMAX0fTexjGpOi6gisK3Ilu5KgfSmDvEB6TDpEvUw11lgxMSIcM1lhZ+D2CZc5QFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abc3Cii16sOfg5vsiw6Uys17OgCCdI5cJP599frfTr4=;
 b=N8XikW6oxZ0wnbvGVC1DHTMXpcSZpplkylrTLHwIic0PeX2KbGDQjq327wZofIdI0MCSQVTylFzIT3Y2ttgtIDOcGAAg7MHfiURXNAOAvxbg35aCccB/6lQ2PsL6U3DpR8axntsAZ2ogzOKQiR7iVGjTADDmOXsFBev0w6NBJI38DNReUn0SkcUQP5yfUA15dH7ScaGi+x61ysjqwhO/Teuk+So6RMJwpQG/gl0GS9y2Zb8qEf0BSFD+GTQvlCrSjvnIAthZW8D4cDOdqLnD26tGicpXMKqYaLwszFMkECifGVIJpWeYkMQoUd1v+vbulQjPoINF9Ps+WJQF2d52cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:42:30 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:42:29 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pan Chuang <panchuang@vivo.com>
Subject: [PATCH v6 20/24] thermal/drivers/qcom/spmi-adc-tm5: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:42:16 +0800
Message-Id: <20250623124216.474893-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SE3PR06MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b84030b-3f27-48ce-ea73-08ddb2536a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXJBV1FNM1ArcEJERlh5SXhYZ1RnTDJRQkxySnlEVDJNTlhWVVlORXU0emZt?=
 =?utf-8?B?cDlxL3huS2NPbVhWakZYb04xOVJmbDRnald0WkNmaWRjVXJrb2NQL09jQk9a?=
 =?utf-8?B?TnpHT1A4SHBkY3BiSHdMZG4ycllDdG8vUTlVdFhuVHg2TFh2TzJmSHlPRDBG?=
 =?utf-8?B?VnpwRHZLQUk2SUV5TVp3eW5kWTNTYWFtaFI2ZDVJTmthb1JHR3U5U0lKb3By?=
 =?utf-8?B?c3AwZzhDdDdaM2lGN2REbG5vZzdyaUpIRkIycnpSZVFMaWZraGlwbkNKUWdB?=
 =?utf-8?B?M09HbXZoRTI0MEtQREUvT0dpQkhFdGQ1K3piM2JCaHB2YzJHRVpGc2E2OEEy?=
 =?utf-8?B?cjBsRTRqU0hxUDQ0SnY1T0pocm9FYUpyMUt4cFNJanlzWmlabXNpcXdBYXhQ?=
 =?utf-8?B?NXhwWmJzL0hlUlV3WmtEaUZpYlJWWE51QlRvdDB2TGgxeCs3VWhFMDVNTFdO?=
 =?utf-8?B?a2krMXdGZjdPeHlVQUhkdWVnSjVJUENFTFhJOUxxNmx6NFZ2eVZYa3JQdExv?=
 =?utf-8?B?NnF0M3EydHpIeWIwVU4zUzJjTEl5NHlma1ZFZ1pWNnp2WlN0MlNOSTlKQS9a?=
 =?utf-8?B?NXZidkd4cVA2dlNpRWFjaGVrNElpaEdYVVZGNWhHS3hOeit0QzQ5azhTVGFQ?=
 =?utf-8?B?ZHlFN3BzUVR0SGhSM2VVUk5XWGFRNWFPQkVRSWYvcFJtVHJzaDVHRm1LcGhL?=
 =?utf-8?B?R2kyVWpxWHQweDkxNUJnemUvcUZLcnR0M2RCU0VRTzcvSWxEWGRUR2VBTE5t?=
 =?utf-8?B?RGNnUmpkeGFUNlV3QjRhaWRIN1d2TG1YZ2ZJcnI4UUdnQXp5REtIc3RvTHZv?=
 =?utf-8?B?K09qZ1gzMDNHZktMcXE0TitXOXJnV0hCRmJNY2JUd09RVHI2d1Arc01LMXdk?=
 =?utf-8?B?RzJVU1c1a1dTQy96SnE3S3NaLzB3V2R2YmNTT2RYNThoZlR0QStxWHMyTkxj?=
 =?utf-8?B?dElTeFlHeVhrejc2MXErSDZacjNKRGgvV2NGSE9QZjBoVTN4TVEwK1B6SFRr?=
 =?utf-8?B?QmJwenVJSjhSSGk5akNKbVRScWIzZVg2VnJZYWV1ZmtDQ3VRZVJ0OW4rMXZa?=
 =?utf-8?B?SjV0YTBGY1ZTaDFoMXJ2TlpqRDFqUU9oeWlSdk9ZU2JoNHkrRG5LN3MwTk1K?=
 =?utf-8?B?ZGhDNXJqU0VWTDlYbWlHNW41SStVdUJhZGg1MHYyRStHWnFWeVpmRTBOYm84?=
 =?utf-8?B?U21TRWFNbTNOUTVXdk9MVmtYdTlwN0c5dlp4aEM5cFBMSUoxbTJmT1JOaVR3?=
 =?utf-8?B?K2JRUFBhck9SY0lGYjZCMXVPNERCUHcyeVgwb1dra1hGR1pOV0thYlB0dkkz?=
 =?utf-8?B?bWs0RkJvblA3cDdTcXh3S0JCY28wZXNhcFRFWkZKUUJDQjdBTGI3S1AzNTZI?=
 =?utf-8?B?ZGVJT2c1RmRyZ0dqdExGbDlEK1UyMGRWQkNFRFRlWDJKZFJiSXRWeXRTTCtL?=
 =?utf-8?B?TGlUUStWUE9UWk5NTFNXTlpWK1A0eFkxYmpXRzdsRHFubmNycVhlWEoySUdv?=
 =?utf-8?B?Wm01TWp3cmx2R0ZLMHkzZkJ4YVVCWmtTNHBxVVhYQmoxaG5sRHlMSzlacHdP?=
 =?utf-8?B?SkRZRFB6aUdYUUFieE5QV0lxUmI3a1pPVTJyZEROUHZEbFlaekRGazluM1k2?=
 =?utf-8?B?dVFTMzVuWGl5cW02MFRlazhhRlhPYytPVTVpU3U4NnBnL1BBUmtzSkN6U1ZY?=
 =?utf-8?B?Y2FXdUlTamxpOTY5TzhqdGZSdEFPZ2xSTEV1MzlyaVlJLy9BdWNvVmwrVzIw?=
 =?utf-8?B?cnpIOGdFVk41L25VUmlwVDUvVG5ZZTAxb3c5U0QwaWFHbTBwcGpLT0hzSWpu?=
 =?utf-8?B?d200TDBhamVyQXB5U0ZoYWdPNG51MlEvb3pZL0ZmWUJFdFNhakgyMzZ2NzEz?=
 =?utf-8?B?UlpsbXg4MGtCdXNzMThveUc0aVluZ3hjVHAvQmc1U3kxdENmMTNzWEpzcXZ5?=
 =?utf-8?B?SFY4R0VoVnlPTmJhR1lPaUpsTFoxL2w1QW5GQ3dEbmtGUVZ2WUtwWEFjcTJI?=
 =?utf-8?B?em9IcXhYSSt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2hzbzZXVXRiNHMvc1p0K0x0SVdlSUJ5L3h0Sy9CbjViOGpRdUVQNXk4Q2w2?=
 =?utf-8?B?NnBYSHp4N0haZEhiYkR6S2NpS0EwMzllN0xqbDVkYTU5ODdyWUJFTjU5VkdP?=
 =?utf-8?B?MS9WRWJSSDRIR3NsbUdXRUh5aFR0V0lDdFlnWnB5WUdlSzRoY054OXdOYkNh?=
 =?utf-8?B?RG5QYkFYZm9iRzBqZEV5U21yN2g2TmFzckhrZnRVb0wzK3BvZW5LNmwvUlRC?=
 =?utf-8?B?a2RkRlptYkFMbVlXdGpXSGxJYys5dkNCVGlNMGtRZ2haSkgreVFXZ2l2Uy9O?=
 =?utf-8?B?RmQ5V3VRQm11S3FjUTJZQ3JON2NUMWMraGNnOU42cEpaN1ArTEtCNlNMejNO?=
 =?utf-8?B?Zk8wL2FqVm1ZaHpudXhKMmlBenJ4VkoyUjJKbC95S3Bjenk2WVNGQlhpVWph?=
 =?utf-8?B?ZGh1M21IejYyT1psYkkxVzB4cGcxSlRlV055YStxVkxLemJpNE1rQXdvQW1G?=
 =?utf-8?B?ZE94dkRRSXVOUmVRS3lJVThKQ3hSMzVCY3d4a1dpQURZQzNsVkdETGN1RDRN?=
 =?utf-8?B?UlFsRzN6TGZiTTQyZUVXdDdZWHVtUzZUUFdhSEROQ3NjWk5iWlNVSkt1WjhH?=
 =?utf-8?B?RTh5bS9Qd1RTQ0tOM09rUXB0aTRPNHZOQ3ZBZ3NGSm1mMmVvNE1BZkF2d1lG?=
 =?utf-8?B?bnhCR25kR3RWNE9GRDlpaEpkVEdaNlpCN0dWQmdZdnF2ZUlmVGthRTh0Mmky?=
 =?utf-8?B?YmhlZkFGUEMwc0Nyb05IMnNYdWZ0REZlOXd6K3NkaEUrdDRVZmkxR2NsT3hX?=
 =?utf-8?B?TExiL1FzQXk4MSt4WEs3bS9HaUZldXNwVWJlQlo3Uk9CcU56Tm9JTVRzRUxB?=
 =?utf-8?B?ZzVlQzE0YXVqc25sVFYzeHZKQ2JDd2xoYW5xZXpvUUJza0lzanRYVWYwT2J3?=
 =?utf-8?B?b3Z3dTJuQTNCVUE5andlaFJVeWFCMnR6ZGxZL1RQZGhMQmNYYTVZelFlRjhu?=
 =?utf-8?B?a1ZrYVphdEpNbEM5UXdRNnZuQktLRGtZNVNFa0xWdVh6YTFYaWYzdU1JSWhN?=
 =?utf-8?B?bmZGNGRtUkZFTnYzT3dacjFaR3BGRjYyeEJyM0FsSUFBLzgySDMwZmdac3Ra?=
 =?utf-8?B?S3ljZ2Vxem1yQklsYUJyTzIza3RseGZMaDJITFhyV0MwVmJNNWw5cUxDdVVv?=
 =?utf-8?B?V09sRUpuai91MFJybFhzNkk3cjVNSFNQdU01NS9JaStmQnFkdUxlN2YyeURB?=
 =?utf-8?B?eVdQZTZIbnVTSWE1UG5FN1ovYzUzbmtNSzZjYU1OWlJ2TVRDV3Y5NWRHcTJt?=
 =?utf-8?B?VElmdlJhbmVXMDJHR0FhQkY4VVV2V1dMWHVjUWdDb0JsYVFhUndJVUd0emxT?=
 =?utf-8?B?TWxBNVluNVpUa1p4S3JvTndzb2RkUitpUkc0Mjg4ZnRXdmhNVzNHaGFuV2NI?=
 =?utf-8?B?dWdkcjVJZFRIL2JBa21jVzIwTThOSGY0MERMM3E3aHF0VThIdG96TEV3Uk5h?=
 =?utf-8?B?WXJzaTA3Z3dOZUc2STdxTysrWjVvSlR5cWVGWjBRZCtOTEJ2ZXZybGl2aDlC?=
 =?utf-8?B?MTBJdmxBZ3BxdlZKTWtOUFJYVWtGUzc1VnhLbThzekVMdDJPKzluaFE5VDc2?=
 =?utf-8?B?M1N2TUNlUTJyUzJidWlBRlF0ZWl5WDNDT3ZxZmI3U1hoNVdDSXBUQnV0c29K?=
 =?utf-8?B?MTdRU3NkMFFZemtTcFVFdTVNTml5UGVnUWFpdWl0YWN3OVhyZVpTUFNwWlNU?=
 =?utf-8?B?amtuRU41V2dqQm9NeDl5WmpiNUxudjM5eWVsL0NVWmd1M2QxWlNtVlFpTU9l?=
 =?utf-8?B?L0ErS2ZRTm00OHdYaU5ld2ZmQUNFdWhlaklmQzBacUpNa2I2NDhMVloxa3hi?=
 =?utf-8?B?eXNSUFB2MVRSNG5KamZqYUZERlRMaUlxMHVZaEFoVDMxR0lpRllWeGhOVlV5?=
 =?utf-8?B?bDRWQ3FuTmRJYTdwNTdCZFJ2VlBIeFVxSXlvMzkwb3BtbUx5d3grNmhqMlBP?=
 =?utf-8?B?dEl3clkrOWRwcmFiQUhNL3l1bUR5NURvRFJ2UFRvOHlLTUxHRGFybXJrRmVB?=
 =?utf-8?B?Ujgwb1E1NjcwRmI5ZkZPc1lVME5oV2doYVZhUXpaR2xHS2VycDd5Z3FOdnNB?=
 =?utf-8?B?NUQ2SjQwbEdxT0lzcVFuMHZrUVlvYUM0Zk1iUGZyWWZZbEg2ZWxjaDZDdjhP?=
 =?utf-8?Q?egFPaukvfNbwdg2+K8+yWlrH7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b84030b-3f27-48ce-ea73-08ddb2536a97
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:42:29.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7koDVMFnnYx5dRSUxoGeJi0qgxLt3MU/54whcn1HEzE6Jku5sgyzndWto3Dn1aIdnnBwDad3XBbjsFkj+TzPA==
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
index d7f2e6ca92c2..18c0ace7e5ed 100644
--- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
@@ -1037,8 +1037,9 @@ static int adc_tm5_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	return devm_request_threaded_irq(dev, irq, NULL, adc_tm->data->isr,
-			IRQF_ONESHOT, adc_tm->data->irq_name, adc_tm);
+	return devm_request_threaded_irq_probe(dev, irq, NULL, adc_tm->data->isr,
+					       IRQF_ONESHOT, adc_tm->data->irq_name,
+					       adc_tm, NULL);
 }
 
 static const struct of_device_id adc_tm5_match_table[] = {
-- 
2.39.0


