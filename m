Return-Path: <linux-pm+bounces-29319-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AF0AE40BB
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F4627A7304
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946FD2417F2;
	Mon, 23 Jun 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="F+VdcBFS"
X-Original-To: linux-pm@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012023.outbound.protection.outlook.com [52.101.126.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19242417D1;
	Mon, 23 Jun 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682531; cv=fail; b=uwUjnzKU1pVnW6OIxO84ztiG3hSy5MYiF3S2wp1gH6NysZaExfPtgWLIL9cj5kBWCBASZr0nNUGvpSIc8nd/G3IyAxiJscopAJxRqwE1cnvc5aOUYbL181PbZCyJ7qQ8GiaF6t0mo71IAQfw3hCirDij1FF/gdc2E/aLjTR/JUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682531; c=relaxed/simple;
	bh=f+rRQMKEHXJcOtTqJX2hnSVCWTj8DAORFCa54KZkNOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hLmG+xgqKCXgticnAqQPMsnjbWcBTdyXuYMaGGt5Rzrzq+Bg58u1tAvbSS01+35YKnGnEOOfoPp7g5yd4zp0oZFL2xvKeruetdTz8ZROFG/nqXE/XGnN+wuOHctaYSWrkRP004vHgXJKGgFVQnaWzXntl1uyrcSbLZkhmcBYD9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=F+VdcBFS; arc=fail smtp.client-ip=52.101.126.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxRcyt+jkoLQLIOYJdV7KBsa9HnbJqqqfbicvPVwQFDf5xAaARkKc82CllKOg3mWxRa8G2UYqsPGG5jDsgFq8UQmCVjvueedAoYTIxN47nIdLkkLhOUxJp1ZbCstq0qdDD+EkQVfz1NfE7k/rvIK/kfHrWupAqb1+yiaj4fIvhlS0rbT+4K1mov8hbiIIr/6mabnXgNned2RHzO3ckGhWwbv8Z/8xHlPvxb4y6t/sFU/eXnYpdn86ZkKbUDXi55GBxxQnzBJ/9BTsJZ5weO6B5ePxqeCnUTSGU5XVCM8dNHUnHXALe0F9/sojlIa7dWakV68SvcQjagjSC1yT3Xryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFajVArnnwFNgvO8tjtPGtQCpamtLyBdfijzIF8SK00=;
 b=g1YYI3rG9gLjOcv+bl6cX212GMXK3+HR2XBpYccJm45E9XvMHDY5aFCzaaj8/gA0NxC8z19hNgSQhTXzVUHvZ1eG5estQgc/JaYYFaTNwzmhNtVF3Mhp5EqLTQNO/XYGUBkn3uf0jRIAkf2S77WZGuuWTgHIRn8MpwpJTY4k8/RkveT6LOBAu5RcvB3czw3Fq1JGmYAIVwb8hK8cjQYbdH//TbM/JO/D91HBM6lXVkcny+6+gTczZoz4BrpotDcZy5vL8b8h9BGFUja3DB1hOmSoEtKtuvb8eb83H4fQvxKGLo3c65VMTIcHB2Jse+qA+qkd6+KdZhyA9xdIFaX6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFajVArnnwFNgvO8tjtPGtQCpamtLyBdfijzIF8SK00=;
 b=F+VdcBFSBGu+Vxy1W2tdktYRn3qCe3pLP+RpNkk0n6Yqe3XKX9TDjZyVAoerocZKXAYmYjEc1JSrmqby0yt+24O5hcu8+ynL9/XesON5qmwNDWZZP28rwS4KRtC3aAD2HWJSiDKuZ/rikpln7TghpoXOdrd23Btim4mztePyIh46Tlkrc08Is5cGE53dhkYeh986DDe9x/LQhEj8X8/CaR0MlZNg02IsEwzGddqVtEjFquq4Q0xkcGFRBA48DKB3z+TE68NE6rVLmygTN97ZttLa+zTAC5Ygw71sC6oUgd3tE2AuZdR5q6nLHnc1f0EfdHrKrVdw2UQf0/PxN4hhxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com (2603:1096:604:2ac::8)
 by SE3PR06MB8096.apcprd06.prod.outlook.com (2603:1096:101:2e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 12:42:07 +0000
Received: from OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49]) by OS8PR06MB7663.apcprd06.prod.outlook.com
 ([fe80::46a5:9b06:416e:1e49%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 12:42:07 +0000
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
Subject: [PATCH v6 19/24] thermal/drivers/qcom/tsens-v0_1: convert to use devm_request*_irq_probe()
Date: Mon, 23 Jun 2025 20:41:51 +0800
Message-Id: <20250623124152.474707-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To OS8PR06MB7663.apcprd06.prod.outlook.com
 (2603:1096:604:2ac::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS8PR06MB7663:EE_|SE3PR06MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a21391-6ef8-48f5-e3f7-08ddb2535d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmU5aVR1L1ZqTEhiQzlnWXR6R2ZyMnJrOWNoZjlYU0swTmFwbDVnN093MjBR?=
 =?utf-8?B?N3hwNWswQ3IzaEE2UWptQ2ovVGg0QldmeEZIWEVFNHRERTVUSnpmVDFJVlMx?=
 =?utf-8?B?Wk1GZ3ZJSk8vL0ZGbUNVMjZPNmZ0eGVMZXFLdW10cW9kMHBKK3FIWEo3cFkz?=
 =?utf-8?B?aHhaMUM1WWdmUHFjSFZQOWlpWGdJaVc1a1pwakRxTW5yNjRjbzlwd09SWnlR?=
 =?utf-8?B?V21kZ2E3SVlaYUZuYXc4ZnVNbGhrUVRJMUNvY2IxcGgxOWtNa2hXSlFnaUs5?=
 =?utf-8?B?cEV1dEliVTg1eDhzcGVUNFhmWUJ2QWJoWm5UZnRYb1c5cVlNRnlHbVA3cUt0?=
 =?utf-8?B?M0dJd3JMNkxaR1FibTBFb25EdWswWnBqZGtHbXZBc2xSUng1RWdaVytNRTFJ?=
 =?utf-8?B?clFsRy9ya2pJcU5jU3U4azQvQ2RxTElNUDB5YXJEUEZQWWYwYmdWbFp6c2dk?=
 =?utf-8?B?eXl5MWVFU0k0MytLYkhQYUxycVFUU0JvdFRSNklOWnBneGRuOUlaaU1KUjdp?=
 =?utf-8?B?N1B5S0tiaVZoSUdibTBDa0tHNkRZRWk1Q1V3UVAzRzlTNHErOVFsSjNubUUw?=
 =?utf-8?B?ZU1SWmNFSlpxaUJnWlNNaE5zS29NbmxQbmp3VnV4aFVYT0w4c2ptVHdhRk9Q?=
 =?utf-8?B?YnBMZWs2SzJyRmQyc1NmbUJvTTdHNDQwaXNvOS8wNVB5UDBNVkJSUnNTd0FD?=
 =?utf-8?B?b0REbnBOWnpSUWMxOFJPbjcxZzNVV2JpU0Ztb2xYRGx4d2ZPZ0VONFRCTW9u?=
 =?utf-8?B?bzNzM2xzUWFwYVAxQlpvWUkyY2Rmb3E4R2pxc3E0NFIwN3oxWFN0dWFJSUZW?=
 =?utf-8?B?a3VaN3pxQ0NTUGliZUhINS9HWktYY1d3YklPQ2xhdC9HMU44aXkyeXhqZmFa?=
 =?utf-8?B?TUZkTitIeG44SXdENmlxRmdKY0xnRmpEUXRUWUFVRFlWVWJNaXdWOWsweHN6?=
 =?utf-8?B?djdOVjk2aVRFRWhFYS94aTB4bkNvaTdYOCtRd3llK29oNGRIMTY5emc2SWNJ?=
 =?utf-8?B?bHZYb0xrL2NEdi96MFhLdDRiUC90akhiMlJFN0JQUGVyMGt6aFcxVlcvcG1w?=
 =?utf-8?B?dkZvb0Q4MDJBSmx4QjRMTjVybm9WRTFTNGxONUVESVh1ci9jc0lLWG5meTVj?=
 =?utf-8?B?MldkcGtnVERVUEFGTVl3azJyeDBCcEVQMUtucXo3dkdzalBYZG50aHZkcGVY?=
 =?utf-8?B?amZEWWNMamF0SU5vZk1rVmRSdSthNVZtWHVQTE8vUlF6KzcxME4rcVd5SDc0?=
 =?utf-8?B?aDg5cW5GYXdITzlvSVhpNVdGNkl2RzFBMUk0dDM2QzV4d09sK0V1R2g2MjV4?=
 =?utf-8?B?V1pmQUo4M3FCdndzaEJzdGhYREYzSXE3TklXbTRSNlRuR1NJYkJ3NnlPVlpn?=
 =?utf-8?B?N3VwajgyTzByWDAwaExqNDlPZW5RT3J2aWJkTDdVeUVnVm1ENjZqZ0huMFdT?=
 =?utf-8?B?Q0NoMWhpOWtSSTZXRkVyMEg2a0RuTzRCNTk2TUYvbGRwcS9JZ2xYb0FpdUtY?=
 =?utf-8?B?VXRsOGpHYTlYdmtJSWR4eE1yMCt4MUFiakxYcGE2d3BPQmh1c2IrTTRnY1Vr?=
 =?utf-8?B?RUlXQ1Y0bkR2WDdqeiszc2JZV3ZKU09xMUZOWE9DZUlFckVwV2RyaVFHclZE?=
 =?utf-8?B?a2FlY0ZDYXhTa0xwOURvSXFSOHVPK0l0R3g0TFBDSXlJTUFqbnFsU21BdWg0?=
 =?utf-8?B?dE90OStXL1dMaWI1d2V2S0Nkc2JORzgyYUN5aU9FdGJYeHkrOW1ESTM2QVRP?=
 =?utf-8?B?WjFPazhnZ054ZXZjWUZsOGl1TzBXSUZrUnkzamticTBIZXkzb1NYK2VOYk11?=
 =?utf-8?B?ek5DOUkzS3pDRkRUQUxicW94cXkrNnEwdllzQVFOZkFFcVM5dzloT29GTWI0?=
 =?utf-8?B?VzhrMWZiN2JCWHpKYzV5eGgzWVFTL25pL1NhSW1OMkl4OU1TZ3ViVVVIbi9J?=
 =?utf-8?B?b2l1alhGWTR5dVllZzF1Tlhhbjd2MVhvbWdxem8rUUYrUFA1QSs2MUhFYVdP?=
 =?utf-8?B?MnNkOERGbjVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7663.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm5oSEN4cWpuRnc5TzVyQ1hqSHA3eXMxZE04aHFnVDZzTExTWENrRSs1ajRU?=
 =?utf-8?B?b3ZqdW1SdXo5VzNFRlBER3lZZGVWVlBOREZ4blhxVEtObTZrb1BsLzZlRjNC?=
 =?utf-8?B?MW0rek10NmdzSXVvaFlNRlN1Um1KbjdDa3NkS3RYV29Xa0xtMkUzZDZYS3Z6?=
 =?utf-8?B?bVdieWFLWk8xazBscnp2K3BEbkVGMXZEZUZsS3hFUlp3eVdIK01WQVJiV3Zq?=
 =?utf-8?B?d2xyYVFsbnZub1A0VzYyN0lnUHRUU2J4L2wyVkN6RkZrZjYwOU50d1V6RE1I?=
 =?utf-8?B?YkJhemlrRk85eGlnUHJnMHZFZlZVRkJudlVock5TYS84WlluYUJYTlhjeDlT?=
 =?utf-8?B?YndYeExmWDg3RW9yUVg0c0JjaEpCcjE5MmtFVzBBaEN4WnNabldWcEZKcWpI?=
 =?utf-8?B?NzNxRlcvSHBtVGZ0am9LekxNeVplUEVkMEJoQzJnOEd6RjZsdFpOeUFHWTlN?=
 =?utf-8?B?Mzh6RGtSWjVzclpES0dYbTVUTFVETVJDYTVVWEtFcDhUd1JHREF4SkFUZzI5?=
 =?utf-8?B?NURlMHpiT2tobGR1WmhveUp1dTF4SHRad1d5QmdoK0Z2SDc3TkVPMHBtMUQ2?=
 =?utf-8?B?RUc0Z0o0cWV2VDd1cEVkZEx1M2swQS9yNXl4c3k4Y1BhNXJDVGdkQ2Jsci95?=
 =?utf-8?B?N2kyZjhQZHZwVTB2M2ZIS3o3cGxzc3JZcy9KTE1iLzFtSFRpYlRnSTdnYnVB?=
 =?utf-8?B?djhkREZ5VXFoVEU1WlBnb2hla28yWDAydnB4MG1FMldiQ0tXZndlRmNISEdn?=
 =?utf-8?B?OGZibHpnVSt0dW1zem9OVkNGSm9qd2xUWitaQ25BOEZnVjZQYWYyc3hrVnNV?=
 =?utf-8?B?eHA5SVFnSXBTek43RlRseWt3UlFXSy95cE9kNDEwMTRKWkw5aVBvQmUySkdE?=
 =?utf-8?B?UVphR3RzTE10NDRxNVJ4UXBpczhIY0RSMkpoU3d3R3UzeDFybkdvRE9BaU5W?=
 =?utf-8?B?MzdpNVBWZkdWS055KzkvRmdhUGJpM0NFTVV3Y0dOWUEva2ZPeHdLSnhZeXBm?=
 =?utf-8?B?UDRPL0p1QWt5MCs3eGI4K252QnhJQUZ2RCsvQURiU0VEbzlOWXlWcnhTeTF0?=
 =?utf-8?B?Y05sd1F6YTI5eGNBQkZEaURpOHk2Sk5sMnVxT0dINS9FaVEzTHQvNFAyV1ZP?=
 =?utf-8?B?VjlyR1h6M1J1ZTdTL0dGZEFockh4SDNZei90eWpiK1Fvbjk1dW8yZy9pa29a?=
 =?utf-8?B?V2RoQlEzWE5keVA2bGN4SDhTMytad0FwT3pra21HOC9wUkw5MEEwWTFLd1pO?=
 =?utf-8?B?RVBpWVEwRmt3NEJ3SVVXVVI3bVBCcW1xaGlqQWk5aUhyZUN2NFViQlJWa0FL?=
 =?utf-8?B?ZHdEM0w0MWV6eTB5Ujg0Q0dHbi9KbEZUQ3FaaUc0NHJzMnlnV0U0QmR4VHlm?=
 =?utf-8?B?Z0YrQ3ZsZjFmQTFvYUVTL0VPdS9RQy9kUHlyOXI2Vzk4RFdya09wb2NZayt5?=
 =?utf-8?B?Q3QwUEwxNTB6U05NSUlUeEFITXFDdk5kYzRtbkpWeUxwNVFTa1V0SlFqSndY?=
 =?utf-8?B?eEY5anZWaGpGQW1rejVlaUpnMm9LSzhSVzM3cGJqUFZtOG40cHUyOHFzUWVz?=
 =?utf-8?B?ZzZLd3ozZVdia2ZtcWpQbXZGUlMydW9pcXhiZVdxbTVYT2JWcE4xeGFYcTVV?=
 =?utf-8?B?STBYSUE5QWJtMFRSZnBNZjVsN1FtSCs5UjJsT0pEQ2gxVkVrdzAvRUhrbVg1?=
 =?utf-8?B?VzdwU3ZEc1dGbFZ6TlBKWllLOUNtN2QxTXV1T3pieS9FNC9uUTBXSm1KZWdu?=
 =?utf-8?B?T2RHcHNPQzVTVzNmVkx6QzkvSlZvYjJ0UGFSYkZlNGU3YzRLTjhMdTd4b3k0?=
 =?utf-8?B?RnNhN3ptdE95QXA2Wm5FVGFQVDF1VmloZ29pZEk2eFdBdURld3FuV2MzdS8v?=
 =?utf-8?B?bjlmSHlsbUdBUkZITUNZaVpQaXdQU2diVHorQjhDSWppTE01dXNRdC9ndXhj?=
 =?utf-8?B?RHl4Vm1HZ3NGa1RHQWtuWU44NEhiTDFpNU5vVkZqZmlDbWNlTkg2VE8vNFUr?=
 =?utf-8?B?eGN4ZGNpcitXLy9XVHY5aTBCYUhlcFFQZk1uc2Q4WEVUenR2bThic2poMWcr?=
 =?utf-8?B?SHQwN3FEMGh2THFmeWFzVFA2dXBscUk4TlpRRVJLR0VLQlJVcUVDSXRoeW93?=
 =?utf-8?Q?n3VLiaKdlu543yK9GamuY+M3E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a21391-6ef8-48f5-e3f7-08ddb2535d10
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7663.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 12:42:07.2037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snV9YDyCpF3E6p0jNhXcoJO4GyLR3UVFBkQFKOTzz8fv9hUQrlhUIdxV/booe5Ubt4pjV19XIeOinR7UFajC7g==
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
 drivers/thermal/qcom/tsens.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..b7ed37f0ea0f 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1190,21 +1190,18 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
 	} else {
 		/* VER_0 interrupt is TRIGGER_RISING, VER_0_1 and up is ONESHOT */
 		if (tsens_version(priv) == VER_0)
-			ret = devm_request_threaded_irq(&pdev->dev, irq,
-							thread_fn, NULL,
-							IRQF_TRIGGER_RISING,
-							dev_name(&pdev->dev),
-							priv);
+			ret = devm_request_threaded_irq_probe(&pdev->dev, irq,
+							      thread_fn, NULL,
+							      IRQF_TRIGGER_RISING,
+							      dev_name(&pdev->dev),
+							      priv, NULL);
 		else
-			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-							thread_fn, IRQF_ONESHOT,
-							dev_name(&pdev->dev),
-							priv);
+			ret = devm_request_threaded_irq_probe(&pdev->dev, irq, NULL,
+							      thread_fn, IRQF_ONESHOT,
+							      dev_name(&pdev->dev),
+							      priv, NULL);
 
-		if (ret)
-			dev_err(&pdev->dev, "%s: failed to get irq\n",
-				__func__);
-		else
+		if (!ret)
 			enable_irq_wake(irq);
 	}
 
-- 
2.39.0


