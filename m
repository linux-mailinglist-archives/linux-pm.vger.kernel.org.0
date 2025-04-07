Return-Path: <linux-pm+bounces-24899-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A8A7EE87
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 22:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93CA18896A9
	for <lists+linux-pm@lfdr.de>; Mon,  7 Apr 2025 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498E2222D1;
	Mon,  7 Apr 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V85b67zz"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013047.outbound.protection.outlook.com [52.101.67.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65181221F0A;
	Mon,  7 Apr 2025 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056362; cv=fail; b=I/jZkbMRlgfpy0gOgivvaYvEXw9aIM6ovNPskayb2ESlNz1OFKJUZ8JYlPoK4/G91pck1P6ZNpXaKotbafln+zP91OdcF9X0xEQ8zt+hynYH6LVrNWXIdPUDPxkDBj5H1MPqG+w8YMqwynJ1LaZXtxwRBJP0xtaYikJB7FH4S+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056362; c=relaxed/simple;
	bh=gOJZ6nMR2grQccbgh3YWWN+DbJpXHKnHHavlTk0Ib54=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YqCKAQFRewO/ENdPYDuT/Bl61vakTS4iOSr23Z2Wn8gnQG+0K4S2Ug/2bpav0YDHArM7ecjtnu7JAbMz3qO2WhN8IT9f7ExA0wjTqVZpFLpv54cTibTp2AHQ8n2u1bIdjQ9Sdw+PyXATgw6qOkTAxNivRThzlex3PHayd4kJ1Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V85b67zz; arc=fail smtp.client-ip=52.101.67.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OidROpvuk0qKH9vdRCJYDkzqkRFXS8spJJOW0S7edWyMRE0ZRknQufsjGjGMEbvR1GgTUN9LElgqzQ01XmAldLdQ0LY1UkS9m1P+IR+Rey3qT7FyL++spTGUToGir7ZFakWbT5EvMrFBX0bMMpNHrGt41dK46bFO7gnIas3wNrQqIKG84pQAgTvLcX1I96Fqr+pT8ZoMBhP6sJTuCUx2PsrNRcCLKizBWl6HTv4ayEfxfwWPVSaXSgaM5IbB11x/o1UeUdkaH/mHZYAV6oxueI8+veGK3WHG+/aw7o8xwhK3OZek3zfRbL+91vxIvnopMiZ+8g6x8uWSNewRv/OkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6b3LFmQ3syHYiRHTSE/J2r+YNNfC6Rd/3bTuxzgj6c=;
 b=ydpkty1TkUNpPj65msyhrvJOo6t78/dE4nkRRSwjphHD6ck+GQ6S5GmUexomFUuCcRInF/8hmM77kWQDXsvSEJIUSfvqjieQKwFnyeaHyneEN03LCrWIj9KTLCgX8LYfnWtSauwEQbsBvtLIuMdPyA3FwuXM0u2REii61MxobmBW1IzqFULmS5+smBYy9FTnEoJhxJL2cR9vlqm76UeGscXmpzXyRdDW10apNMwyGOqCh4+offYjkA8eFaf5Cs+zYvhCy+1NLZse7N2d0B30Z5zA9/19YofvbOpCszeYT2BGeizgVwbmu4HXPU9wuE5sAd8MijMdPWnLSKz9ud1grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6b3LFmQ3syHYiRHTSE/J2r+YNNfC6Rd/3bTuxzgj6c=;
 b=V85b67zzsy/8xbpQuxoeLHZCrzwdCZPZOBRIFBSrRrez2hw0hcnANQzT9xQeRom2+AeYi4whLl12Nur3NIxs6ou39mHgbkmfCpNJSDcYxEdicQ29KW/cFeNUna+OWbuKqhun8HwofY1sS6n7e39M0tOoR7IgbVyrXTCAQ1L/XQzAafgGnV0Brpi0nGgW/7tGe33yZrcew5godqzE8XuuXVu1BgIBdlW9G4yUEDXorcABQi9lh7NOnst1/XLCs0pn+aYFL8ogSj0YZYhXoRj8SZkSeqXgfkkb0F/Tn9NiN27oLvsrubQum7Q9vnkKtqk4m897R3KW4jgqRpITjunfKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 20:05:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 20:05:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 16:05:39 -0400
Subject: [PATCH RESEND v6 1/2] dt-bindings: thermal: fsl,imx91-tmu: add
 bindings for NXP i.MX91 thermal module
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-imx91tmu-v6-1-e48c2aa3ae44@nxp.com>
References: <20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com>
In-Reply-To: <20250407-imx91tmu-v6-0-e48c2aa3ae44@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pengfei Li <pengfei.li_1@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, ye.li@nxp.com, joy.zou@nxp.com, 
 Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744056350; l=3278;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+L1Qe/+JHtQDcDM0baaIZLwnjtk1VSJMnHn2mFaYfHY=;
 b=+w/makJ7Sg24LYQsstNirZuDyuogkNSTnRtMUXopTwnlxDUPVRWbfm+HZEXiTmUlARRETBV1o
 Ym+ShT3R4SdCuLzGoirtHNA76F3aiV6zNSOIXY1QzKYSMeMj+G0scjv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: d60f147b-511b-4861-31e0-08dd760f9d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alVEWERqczVBckY0U0ltNzNiS0M4dGFKbWJrZFkxbG5BczFHeWUwTCsxSFhm?=
 =?utf-8?B?ZUFIMTk5cmsybHphKzVGSjNoUHZ1UFdkaXUzbVdWRlFtS0l0WkcvUlRmMjBz?=
 =?utf-8?B?d2F1M2hnQUx4dHBEUklCWWhzM3RiVkNHOUExVi9uZWFnajM3S0xNWEF1Q2ox?=
 =?utf-8?B?UUZ4SEx6d3FMdEdSK25jQ0ZiNkdEams2bVI5MEFmTnlqMktBR2F3a212amdV?=
 =?utf-8?B?SXBJWkxjZDhoeHdwNjNvR2NRUnFrOWhWYVcza0lsTGxqeDRQQ3hzK0Q0QzVV?=
 =?utf-8?B?N1NJQnRiQXVVNFF0UkxTMVBPdEo2TkJ3eTh0cWY2dXVlM2RHSEZOTDdpNWJ6?=
 =?utf-8?B?cDA2bFNKR3M4NnVWTU5GdTdGQzNpOTk2Y0dxQkVIMnNPUjNLTUhJMHBoaDdk?=
 =?utf-8?B?UlFVNWxaZDlJdXVEV0ZZM0dNblZ2VDd1NWNveStyTzRSUGN6MTNtQ0ZXcUEy?=
 =?utf-8?B?R25nak5lOTJBYVJGZVRlTnZwVzd6T05xckl1YytmYXlCS3YyZ2c4QTkvYk9X?=
 =?utf-8?B?a0ZLWHArSk9EQ1pTbDRaYld3RkNHR2hNdTJGM2JGWDBjMUw3TjN2aGtacVJB?=
 =?utf-8?B?T3ZqLzBWZWNDOTRkSDVOci9BTFc2Y2RBb2twYWVzWW5EZVZ0SzFqSEw5OWg2?=
 =?utf-8?B?YVZmVm5YNmg4SElBamJTcDJ5TTBOM1UrNVUzSnVGWHBZbU54c1JMdWVtVVFD?=
 =?utf-8?B?RFNITjdQTXk0VzdvNVRWRjcvcHlmWnIwOUZkdVNYVHgrSjJ5OHdEMXJRTXlk?=
 =?utf-8?B?TjdKU3g1dC83RGhMcmtKaDFXSlR0UXZMeVU3L2N6Z3JsR0dJWi9qQkZEYTQ3?=
 =?utf-8?B?aC9kb0MwcXkwZUVNcUZ4TjcxL285VzQwYzcyRlV2M25VSGF2c1QvQUhqbVZ3?=
 =?utf-8?B?eDFNa1RDNUVSWXlpUFh6WXBGWkNUaEdlclZ0Y0k0VUJBSjh5K25SdS9Hb2Ex?=
 =?utf-8?B?MjVEUUwrSnJ6cmhLSEF1K3U5ZlJ2RGJ6dXRUMXVhTHpYZ3VGdmlveTYzanJV?=
 =?utf-8?B?cHRobmxXeHB3R2RQcHpUcGZ1aEFqZm1QVnVGZXVyRTF0SkIraStUZ2psTnNk?=
 =?utf-8?B?OFBtaUpaVzBFclNuc2NGWm8zTnk3U0xScWdQRHRlL1RlK1pVVHFpdms3YW5j?=
 =?utf-8?B?Tk9YSWZydUVUdWtpYyszZGYrTUtjekJySTdHaFRnaUFtbmZMRTVnd1lYWkNr?=
 =?utf-8?B?RG1iazJaN01NM3VRQ1dEYWhuUWVPZDF4OEZhUGlsZzdTVmh3bHhJL1FxK29k?=
 =?utf-8?B?SEVDODA3OHh5RXUyWC96NC9sKzBacnlPNjRiUzE0OFhVdW5FbEgvUThqMDB1?=
 =?utf-8?B?QTlCL25od2o3c3JXNW1xWk5yVXp1bUZwS0RuYTd1ZE9zanFvOUt5ZG52bFdU?=
 =?utf-8?B?cnB6N2Jzb1JHSVhnK3ZRSnpaaW1pOE9jWUFHclFBZG9OQTg0UjBEWkNNNUk0?=
 =?utf-8?B?clNMOVRmZTl1ZGNkT1Y2OHNGWHRmMFpON3A2TGFqeXF5NUlOZkd2Vm9NT1Ns?=
 =?utf-8?B?N1l5cnd5S0NoUGZja1d1VklLYnNjQmd5d2haMVpXcW5zRVgwQ0k4QkEzQ0Ir?=
 =?utf-8?B?ejN4dHVraVcrYmV4SUNpTjk1cVBCZksxTHdCM3NXcnplK3BwTmpOSXJSQTlS?=
 =?utf-8?B?d0ZlcElrWk02bXg0S1I1d0pVZnNZazhiOHNVOHdTQlNuKzU1MGVsR2VtN25Y?=
 =?utf-8?B?MU13eEthb1JOTlVKYVRudUlzVC95OXMrRVlETDZIYkZ3bE05VFBBZUowMk9V?=
 =?utf-8?B?OGpZYmRxT3VYTnV3TGN1V2J6TG92cXcwMERGMDlNM0lIRmlzRXdTSmgybGJa?=
 =?utf-8?B?cVdJdFYwTHVBMjlMYUdTRzZLYk52VENqTndEalFHd2ZSRmhRcXZ4N21iKzl2?=
 =?utf-8?B?RFpMY0xnQjBxUVBmMHl5d2lkWlJvRXBTU3dWQUhtak4vYUJiS1VscTRQSTA3?=
 =?utf-8?Q?6avrTU51ktJ1sRkcWRWBHEVHJ1xv+lYh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STI1clhEL1dTTWR2eEwrS0Y2WXNMZlFMNnA0a2hZWldHTGJKeWM0WGxHYzlx?=
 =?utf-8?B?dVl5a3hVcWQrZmh2ckl4KytUUDdsUGM5Si83YWVRWS9lZTREcER5L0U2RHNP?=
 =?utf-8?B?M0dKNmNSY2w1bEErMTlFRHorOFdnL1JmMFlnUmVNMHp1Q1ovbHVNQ0FRREtF?=
 =?utf-8?B?V2xHSTRKaXNNUVdBdWpMTFlvYjlWUTJ5eGx0bkZoMVVUeVYrSW5XcDVHTnlo?=
 =?utf-8?B?Ri9NN1laLzJuTnQ2OXRyUlVhRTNZY3VCRVJJYmJUcEZxUXBjMVkyZUZmeVgv?=
 =?utf-8?B?N04vUFJjUW4zUGRaSTlTM3FCY3lrTTg0ZzVGQ2toZUp1dko5WkxFVlhFNGJS?=
 =?utf-8?B?YVkwMTl3UDdXZnErVGFkbDNJd0Q1UEIxWENrQmI0Q09jTFdub1pBcDZKQVg2?=
 =?utf-8?B?Q3pzcjEzM0xGQVI0M1JKMmtiY051N0s0dTZUbjlEU1pRRXhzOVdnOVRPbUlQ?=
 =?utf-8?B?a0JCYmI5QVFyVlg5OTBuN1diOFZiczVoajRuWVNsQkV2NUg2QVBOUFpJcHRs?=
 =?utf-8?B?WDk4UnlCZlZtbUdnL1hyVUZIK0JrSUtOZk1zYm5ZOU1BRjB1Y1E4WnVCVkRU?=
 =?utf-8?B?Y2VTUlpOVmU0UGJxQUFhNDZUZWVjSjZyTzdLU0VZTnJTa3lDUytuVnF5aXZr?=
 =?utf-8?B?dTVlTVdLek9EN0tEVk1rb2dUV3FCWmV1NFcvcWxWYlI0eFJNNjJ1S0hYellQ?=
 =?utf-8?B?eUp6UkJPMGhSd3dyT1gwL3BnNUQ3dmpLdFc4MnY3SEo2R2dScnZtWGJvMjVh?=
 =?utf-8?B?NUhKOC9MY0Z1am91Nkh6NUhBMWVVV0lOSVc5SUdwT2dONllCRVQrVjVuWjNS?=
 =?utf-8?B?S2RBNmdmSWF2cjlhVlNxUXI3WHMxQVFtR0QyRlJpWG5BamhZVVFWOFNUS01l?=
 =?utf-8?B?ZEM2RVJFZ29WYi96N3JKWUc4bW95YWcvVzZ2SlpVa2c5bTd5bEh5Q1hNSW9y?=
 =?utf-8?B?WGcrd1QwWTNXU1k2TEpIM2pRMFQ5dElST29iK0IraFAweERMdWFSNmR6N1l5?=
 =?utf-8?B?eUxDZ0l3eFhwZ081ZVpsQXNRZE1YbE04WGp6QWxXUVJiNE9WNjQ5YlVxSHQx?=
 =?utf-8?B?dTVhSkVXMGJNL2gzS29xVnB6MG42eUlTU2R0U2lyM25XY3VXUkdsN2dYdktp?=
 =?utf-8?B?a1NmaXZTZnNxQTVQQ0s0SHNUd1dNdnBNejEyN1k5WDFSN3NPT1BVWUtEeCs5?=
 =?utf-8?B?UHJVZFJoWElVdUZ2UElvWDh4T096Ynh5K3RPM0JzTytBSzJQa3hhL1U4NEZp?=
 =?utf-8?B?UkVyYndqWnVuU1czdVYrV3oxbXB2dUt0K1I3U09XWng3ZmEvcVFIUFZPUXo4?=
 =?utf-8?B?eXZEc2xEdmhzaTFVczFVS0hCWU1TRmpnUkZ0RmwrSFM3dVpZeG5Od3NmRktQ?=
 =?utf-8?B?MG8ybVdJTENlanBiaWY1NGJFZ0h2TDNiTmgwbnRSV1RlZkN4blhaTU5UcHhm?=
 =?utf-8?B?T05ZeFFkQm54N1ZYUUJHejJCajdFT2YxVFI5YlBCeHlsamJuTzZFS05LeGlZ?=
 =?utf-8?B?K3RKS3Rwa3VraGw2K3A0aGlKek1XUTFNa3ZBTnlnV0MwQ0I2WWVMaXNPRVQy?=
 =?utf-8?B?VnF3d2RRcFNaTkduSWc0M2I0NFF4YmZ5RWx1SHdBMm5Ld3dLY2pieFhaampo?=
 =?utf-8?B?NnpxTDAxUmIwMTNsbnpwTlRHR091ZEdoOWZEYjRWQmlhNnRCQktweFpZdUlJ?=
 =?utf-8?B?SkovWGpXcGxVbHJRRGlwMzA1Y3FoRWVPQWJaQ1NKYlZPY0lKSTExckcwalNW?=
 =?utf-8?B?OGtRQURSL2ppa1Z5dHZjRC9rWFZVWHR3eGlUd3h6MzN3Um9HaEQ5bDlqNnlO?=
 =?utf-8?B?alZCRWJzSGU1MUVYT1BtSWVnSy9udUh4d05xSk5QUDlyblZGR2xSVlJUMHJi?=
 =?utf-8?B?YXE4VHUwblQwZmN3eGFZdEpYYnhlRlV6elhhUTNLbklWanFodTFNUmdJQWxp?=
 =?utf-8?B?S1FNRjJQTytwZlMwekVCb2xBWjd5MmUxUnBFOGJ0OGIyd3kvZ0NNR292d3p6?=
 =?utf-8?B?blM2RzVRVVBOZ0tBVDlWZzdzelZCcHNNU2NobytKK2xwT3BwOVpWL2NabjdP?=
 =?utf-8?B?VE12SC9sVnR2cUE2UEw5MDJaZDBMWWlTcjRjOWFiaUE0MXpucTZnT09aTWVK?=
 =?utf-8?Q?Q1wM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60f147b-511b-4861-31e0-08dd760f9d4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 20:05:59.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/k5hr1OHgIyFJ2ASRz921PkKr/Y0gqk89tIR7ySo862m5AdPiTcYYhL2kiWS5r0eS0+/+wgjstRdjwL3xHLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

From: Pengfei Li <pengfei.li_1@nxp.com>

Add bindings documentation for i.MX91 thermal modules.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v5 to v6
- add interrupt-names

Krzysztof Kozlowski: Compared with acked version, add interrupts and
interrupt-names property. If need drop review tag, let me know.

change from v3 to v4
- add interrupts propperty

Change from v2 to v3
- add ref thermal-sensor
- restrict #thermal-sensor-cells to 0 only
- Change to unevaluatedProperties
---
 .../devicetree/bindings/thermal/fsl,imx91-tmu.yaml | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
new file mode 100644
index 0000000000000..7fd1a86d72870
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,imx91-tmu.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,imx91-tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX91 Thermal
+
+maintainers:
+  - Pengfei Li <pengfei.li_1@nxp.com>
+
+description:
+  i.MX91 features a new temperature sensor. It includes programmable
+  temperature threshold comparators for both normal and privileged
+  accesses and allows a programmable measurement frequency for the
+  Periodic One-Shot Measurement mode. Additionally, it provides
+  status registers for indicating the end of measurement and threshold
+  violation events.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx91-tmu
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: Comparator 1 irq
+      - description: Comparator 2 irq
+      - description: Data ready irq
+
+  interrupt-names:
+    items:
+      - const: thr1
+      - const: thr2
+      - const: ready
+
+  nvmem-cells:
+    items:
+      - description: Phandle to the trim control 1 provided by ocotp
+      - description: Phandle to the trim control 2 provided by ocotp
+
+  nvmem-cell-names:
+    items:
+      - const: trim1
+      - const: trim2
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: thermal-sensor.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/imx93-clock.h>
+
+    thermal-sensor@44482000 {
+        compatible = "fsl,imx91-tmu";
+        reg = <0x44482000 0x1000>;
+        #thermal-sensor-cells = <0>;
+        clocks = <&clk IMX93_CLK_TMC_GATE>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "thr1", "thr2", "ready";
+        nvmem-cells = <&tmu_trim1>, <&tmu_trim2>;
+        nvmem-cell-names = "trim1", "trim2";
+    };
+
+...

-- 
2.34.1


