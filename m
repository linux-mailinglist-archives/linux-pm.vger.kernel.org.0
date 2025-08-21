Return-Path: <linux-pm+bounces-32769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8949B2EE29
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 08:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844555C7BB9
	for <lists+linux-pm@lfdr.de>; Thu, 21 Aug 2025 06:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D31276038;
	Thu, 21 Aug 2025 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sf8f0ISX"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2577126F2AD;
	Thu, 21 Aug 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755757464; cv=fail; b=HImENzODWIPxTOHSwFT+3XJWZZc8VpKrB9V+uxWvtxqRezK+nfE4+5EPK7q9EgvgXlugY50CUJh8e9RP8XP+kpGH1WDBfw1rkiTBmuSZPotJxYsckm8f5bpxO78zh+etC2q91uTpUTNXWd2dph+B3ZOcHNXbqfStdZM2gUI6AG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755757464; c=relaxed/simple;
	bh=zoqZLnbkHMMCeP9ZZjohYTEtYTlzlee1zr1i2g1k/RU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bGQ+tL1DE00AgeHlxzh1CA411KT2nZmMg+K2qk+U5Mshvj+EhtPo4Dr5EGeUh7Q7XfJjybLT//jzijn7yxOcXsGSr0PowuuCzLV8afB+lFjQDuPVX76I/SSZY4jAw4n/JD5QE1M2HKu7yo+D9psBv5vt9IUYL5eeJJyQPrHdmJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sf8f0ISX; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djcE+XEayT0gg5VyBTBl9LqzbCmAkxmAdyWoYs54rPUT2d/hN72hoDW3NLGKO0gP3gkMNuMXyqXP7SlirW4G/YMJXGk6QbLSRTewd9HUadTUF1WMBqAAWOypNqKy96wS/G8X8Q3+2uyF5HVdWBxISKEeIZuUQUJNVoBkXi5avSxbk+NebVegfG1uF+lRg6qp4PXO92xDBncN7TORkHjaj0g27u4hCV3HVFVEpf99hoaKKtTmmRjJMJWSRDM2mu+kE2cFqzDFmzJyKBemgT6qbQ7Y4CI5kgJSHAXAN2iD+jpgzVCaODJm99HVwJ58OPYS45EkVBpL5/GtQl+kILlTAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga4StdweIGHerV7dFGJxl+AOdt5qAIGjt/GzcrMpZiY=;
 b=i7swIAhzNWt/qiR2o5sqEA7GtZEZYfz+UOpQ5EkAxEJ5ugN9hNguLv3omzrhlI44tPHcCUPJ/TitC9BHbZoKsBeeqSgwMJ/A7ZZh+VbzUX0Wt5p3OX5faZX1+Dtn+QsK9lRziY5BFs/FwnnToU7bPJ8xhuszqxCUTiBP2A46up2p66BeSR6aeNiDd1Bp49MZKarMz4I+0kPVdw56y5vHOpqgxtMBRTX1aAlFlSHbIt/9ucuSbOrvO4m44YwOrihdc8YAlTK9+7hTdL332Uzfu2ddPQJBVT6SMo1RxHdJLNU7rZB6TcaEcTq2ZeDcVIT93KyG6RfhWh/sVuhRwrmiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga4StdweIGHerV7dFGJxl+AOdt5qAIGjt/GzcrMpZiY=;
 b=Sf8f0ISXbLL9i83ZmJ+qe0FwqBXvW+HoV4tUeW/pwx9/jngF4r87OtbtYBoga7Y2Nchn5pi2RuZWXeZLidixdn8flJsz71fs9t+dm9NcH8jFxAZU2u8GOIY9CW80QAHk0MNL5mjJuRlO/Bxs0W6y1m9MONX3NkTLYwlyY1AuIymGBMdn5Rp6lF37aWrTJPuxFs1yQ9s2CsnrB14APTEmh6FUIRqZT4/VSmJFLNcNovffMJRCA994GiN2kgcOsCHHNGl9gW65XpvS6p10tb6o98weWMI9Wz+rsvj9KXr4lpClYKF8jSkkCaKRZjAUmIVE8ohXoNy8wS9OuqqA9joHOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by AS4PR04MB9364.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:24:19 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:24:19 +0000
From: Jacky Bai <ping.bai@nxp.com>
Date: Thu, 21 Aug 2025 14:23:51 +0800
Subject: [PATCH v4 3/4] thermal: qoriq: workaround unexpected temperature
 readings from tmu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-imx93_tmu-v4-3-6cf5688bf016@nxp.com>
References: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
In-Reply-To: <20250821-imx93_tmu-v4-0-6cf5688bf016@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755757438; l=5060;
 i=ping.bai@nxp.com; s=20250804; h=from:subject:message-id;
 bh=zoqZLnbkHMMCeP9ZZjohYTEtYTlzlee1zr1i2g1k/RU=;
 b=iJgKGYbA2CNIJ5TiH9FzTJoFZLeJN8XX47I+6Sdrm+TSyeucF1P1yidwJzcYo3MdNzf18/1Vt
 YTvGAtxfkw6DXuCp9MqNuMPNVTVEyD2p5vDXkVsWS6rXjcE2HEFcJ++
X-Developer-Key: i=ping.bai@nxp.com; a=ed25519;
 pk=ckFjCfRynXBjQGmSmzOVI5hggMD9XnnNlwj/jcO/j1U=
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|AS4PR04MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f090426-6722-4156-66bd-08dde07b5c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkN5bjRzSHcrVURkZy9HUXQrSFl1bk1FVjZjc21wRUQ1WmRoSFcvZXdxSEd0?=
 =?utf-8?B?dkxYcmcvYVVQM2hjR1FKNUx1TnFJSmRyZmE2Z05HSzlWajJhK1Zub0dubmhH?=
 =?utf-8?B?aDdvamdOa0kwWEpXOGkwS01SbUliNE5VY01tU3czN1NuaTV1WjA4VGtjNTNu?=
 =?utf-8?B?ZmhVVUtwa2tRMEQ0elRiQ2NYZzJJSTJ4aXNtYnhkZWszNlZvelU0QldvQ2ph?=
 =?utf-8?B?NUY0NGZyenl5K1dWS2czYVBJS1crQ0FLckF2UFF2ZVFTTGZCbGJjRmptY2JK?=
 =?utf-8?B?eDJJZm9WcGhrVGR1WnhpTVJBWmtNaFowZjVqSHNWZDFHR3ROZkZwWjB4a2lS?=
 =?utf-8?B?Zzl6dEoxT1JrSkNzSklvRlVhRFUzVGdQRnh5OC9nL2NkQnRxbU5mYzJYOGJH?=
 =?utf-8?B?K05EcDN3cjBXSHRibzhOc1JvdHIydEw3Y2xkMkhJRVJJemc4MklPeE5ZV0dP?=
 =?utf-8?B?ZTRmSU1XTS9NNGJrSXlWVmJIVFgzWU1tdEdxVHdWSlR3WnVYNEl1ZWJ2cTZa?=
 =?utf-8?B?dmZqZThpSnMyNFUzV0tTcXZSNDVQUThnVS9KcFFtVWFlcm9yTm9mTFFHNGgv?=
 =?utf-8?B?TXY0NGh6RDIvSFNvbGJOL3dZNHRMYlN0WmtMUDA1dDlkb01RcmVVQWFuTlZJ?=
 =?utf-8?B?N0orVVVEbEp0VHgyazYyeHBHL292SjJHVEl0QjhEQzhROExYeWw5dGMxcm16?=
 =?utf-8?B?TXFtVnRYTWdlTndlYmRtRlBOY1VycEpzVW5PYk9pTmtaNnZCc0NpSUU1c05x?=
 =?utf-8?B?THgyL2hOOUN5Y1ExL1I0c2FpajB0VkZUMGVGcjYrZTJJOGRoQjZSQkZCN283?=
 =?utf-8?B?YmN3QlYvMFRDeW1KRFRXaWx0VENMclIwU2ZJS0VLdDFLK3JiWktmUEwyVGln?=
 =?utf-8?B?WWxOaGgzcFlDaEM4RGRuWS9tdXUyUTYxWnplODRNa3UyZlVQMmVkb0xtek1K?=
 =?utf-8?B?TUNnNndRNmtZZTRINXVvWWluVUFKQ2FjS1ZLemJvZ29UQlNwcHZzRGlsUGZM?=
 =?utf-8?B?ZWR0NUdDbEpweUMrNkgvUjVFeWZWangrNjRjN2wzOWwycXRDUEZVbnVReHly?=
 =?utf-8?B?dm1GeGRxMStEZjVWM2xENXRiN20zNENtVkQ3MlV6UUVxelgrRUhDY2RKbmMx?=
 =?utf-8?B?N1l6Y3Babko5dk0xdXRkbSs4bEZHQkowZjQzOEpqQzdiL1U3UVFVWWd1SHEy?=
 =?utf-8?B?em5sVGVSMzlXaHBCTm1vZHZVRUwybUhwSExUaUhxYVNTQlVoaFh3SEE3OTRS?=
 =?utf-8?B?VDdBdmUzYkJqblI4RG1DQWRiR0VqQUltSzdEZXlVT2g4cFlHSEYyOGJaaTZ2?=
 =?utf-8?B?cGp5QWl0OVdqYkF2SlBRdmRHcWM5MzAvODU5cTZ5d2RDOEdmb00rS283Ty9r?=
 =?utf-8?B?SU5EV1BsMzMvSWJZK0pvYjJNRk4wUURNcnJTbGU5aHg4ZVM1eVMwcVIrY0Yv?=
 =?utf-8?B?TmZiZllIL045bk1lb3pyN3Y5cnRNaTZMVWdkTUh0SjQ0ZXc5THFTL0kvY2sv?=
 =?utf-8?B?NSsxc1JXYVdPZ2hVUGZveEwySGY0d0NRYlVEdS9hQmV3ajRKUVNvZ09TNWc2?=
 =?utf-8?B?VzFkbVUyb1FvRXZ1MU5jMU1BWi9abzVnUVp6d3hJbWd2b1lOek53UE1qY2Uz?=
 =?utf-8?B?Y1ZaZm43Wlg4Y1EwK1FXVFVxK01QZHRZNWU0MWo2STFrV01SZURFbjVHaU1K?=
 =?utf-8?B?dVY4RkhZS0ozZ1RHdVlLeDBuOHNYbkRNbHpTZmJYaVE4L1ptWTN5YlRVd3pi?=
 =?utf-8?B?ZzdTclBRWU5ieE1TU0xQM0xVSkx1MHFGVjN2RlU0QmpZSG1lb0l1VHRlSm5J?=
 =?utf-8?B?dlF6UlRCSm02ek15YXQza1YxeC9EK3JMb054SnMydWpvaDlxcGkrcm5QQ29y?=
 =?utf-8?B?ell0ZFJ4d2lZY1B1R2NCZDB2cnQ0Y2w4S3BLaGtmcnFUYkNiQ1hMWno1aFkr?=
 =?utf-8?B?anlMZHFwMjJ5dXVBRmpGTTRJcVZWTGlhbXE4alFuRWpWMTJ4RFRCTzRiMnNW?=
 =?utf-8?B?SExPdnZWemNmcE1IeGViaG1qWnVZQWRHYVJJM21Nd0xFUDBCVmkvMUdycjNT?=
 =?utf-8?Q?4R0w90?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzJSNFN6T0JHU1JRVzQrVFhsT1JLZlBsVS90OVh3NDRCcGY2Sno0QTRtVzZ3?=
 =?utf-8?B?NkVNcmEzSllNdWpNN3BXSEZhNzdBRkJOaTFMN3phTlVFczJUc29CR2xBY014?=
 =?utf-8?B?cGVlZ3Mvd1Rmc004QnNKaHNCL1cxbXhQWVdxT3NrTW5CTnNRM0lOeFhRZUk1?=
 =?utf-8?B?dllueFE1ZmxHT0JPSVVTb0xiVlBwRFhHMEVHNFJXbHRoT1h6Nm02UEZaMFZO?=
 =?utf-8?B?WnNWUWtwWnU3VSt4cGt0bUdEZjYzTXZnUmVyQnJmUmxmenAvaFNFR2VUSVhD?=
 =?utf-8?B?UXk1MFY0SUNKNnVJT1dicDc1VGdaUkFnT21Ed21tVDl0SW5LVnhaSU5aVm8r?=
 =?utf-8?B?VDlYeWg0OGdOUE1mMmNuUWRwcU45YzY3TDZhbWQ2bHpnNXhqMWNvZ2E3bThX?=
 =?utf-8?B?NG56RlFuR1BUeUdza05UdWoxeW5INXNjUmZOSll3NGhNbTV3ZCtlOEd0a2Jm?=
 =?utf-8?B?TkxidmJlUWllTE5NbTJrejE3VVBzWmNUaE9Nc0RiMUdmVmh1ZzB1ZEpXOHV6?=
 =?utf-8?B?K0ptMXlHbnN1RjZwNUZ2SStxdEcySzlpcEsrcTNCV0s0a0RPYXZidDRNd1ZU?=
 =?utf-8?B?WGMzUEFnMS9uSVVyUlVwY3NCVE9VWXRKYjlvOGJrUHFiOVpMSUpTWjdaNTVS?=
 =?utf-8?B?blBVYk4zcHVVekg5UVk5MHZzd2xDSUlPZjROTnUrN2MwQnRtZEFHbm8xMWdF?=
 =?utf-8?B?VWlSYVEyQWZEZ1hVN2JLenRoQjdQZkZGRFZ3RHVSNWxJVVg5Nm5wMngxR0pm?=
 =?utf-8?B?RDhCK0x1MXdDN1JGSDBkUjQ5WVllSjNDTjNlNXlLc2hIcVNoeWNid1R5UTJp?=
 =?utf-8?B?QTluMkFSVmFsbHlneEdRcFlsTGpkOUlnQWpHTFNsTTRMa2pDL0p6dUJ0WCtq?=
 =?utf-8?B?YkVFNHVXaWE5YjVQT1lEbnhBSnVWRFhPeE12cWZKUGExSnBhSUZOSHowT2FE?=
 =?utf-8?B?OGhycFViaGlYMWJZMFhxVXdZZzBvalVTN0RkVFVDb1ZTQTZxNTJTSzdKS2RU?=
 =?utf-8?B?aXVGaVVyakpjczNUT0tpWkxlOEZHQVdQY0pxRFZ4ZmxtQkY4SnhxN0hzL1BO?=
 =?utf-8?B?bnVoRy9zVU1sbXFKY0lsOUVvcSswVCtsU2JvNFlUK041OXFHU3V5Vk1VRXB0?=
 =?utf-8?B?bjVBajNGZ2dzditiNG10VmZqMldUMno4alZRUnJNcmNWazdYVTliKzVmQWhL?=
 =?utf-8?B?dkJDSGhVQTFLbWRkUnUvNmpzY0xIZWl2THlGTzNHaXY0QWdDcDdKcHVUUEFD?=
 =?utf-8?B?S25SMzlSWE5OV1pRbFBrNzFWVUpXZHQ1WmxISTBqcXB5MlFxL05WbkNPVWdE?=
 =?utf-8?B?ZmV5dzY0VnlhU2RpY3BxWjcraDVLMVlYcHp1MVdVZE1pWHpNNktRSkhra2VV?=
 =?utf-8?B?SjZTaFl5WVB3QVBFZGJMQXpEUDJXMXNVblAwSURnc0lkVlQ4aWJKSG5UOE1y?=
 =?utf-8?B?SEo0aUJHVXVlRkNWaDNRRzNVSEhHeTVUSVVBczRwUTB2WXYrdVpZTTNHbkR1?=
 =?utf-8?B?QloyNTVuUXViMEhJK0pDRjBWQld6OVRQaUVXNFU4U2VwMDV3eURWQ0FDbE83?=
 =?utf-8?B?Y3FYRU5POHJKT2ZnOUxKeVg2enk3TDNwTEpUWmxRYUQxYVZ1TFBlK1oyRWI2?=
 =?utf-8?B?VHE5N29MWkxPRy9zODZaL3dLV2JSRENDaENaaU9YeHdrM2JMS2RmVDEzY1Fq?=
 =?utf-8?B?aDI5enJYKzVCSkl1S0lBNjlleTBBZHlzakJHSXdnUExZY0dXSDdpUEZBWnVX?=
 =?utf-8?B?K2lnS1AxL2NZZDErWUJqNzJ1QVdIV2ZRSGplZk9Va1hLN2tQc0ZjSWxFU2xi?=
 =?utf-8?B?ZmNCMzZNSWY0bmNRNEdBejdHaUNrUHgyczg0dmhhVE4zT002VFJqczB1VXNU?=
 =?utf-8?B?bE4veHlXTW1HNzlHdUJwenRaOVAzYW1QM1RxZHpWaEpPeUdLVTJRakRHbTlz?=
 =?utf-8?B?cEp6ajlEc2hlUStKekJkVDBCZ1c3NjZXMGkzQjR0MnBYV1R2WUJoOVU1Wmhn?=
 =?utf-8?B?VjljNTJnSUc3MzJTcTRGYzRYVzJBU3pldk52NzBGYjVXRFd0K2ZIUVVZb1dJ?=
 =?utf-8?B?bGtoL3hlR0ZEc01HVExZaXl4MDJydnFVYXhvdUJuTkdKSmFpOFZwNDEvL0dQ?=
 =?utf-8?Q?wirqaj3+VmiPnQXxp6JzQRotw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f090426-6722-4156-66bd-08dde07b5c39
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:24:19.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox4H4dkwpDrt7UZXwQiQ5CYrA0uOiIc2SvBK6dV0xfOKAg8k/b5spxv630edy306H8Ha28+BMw+T0qdotQvNNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9364

Invalid temperature measurements may be observed across the temperature
range specified in the device data sheet. The invalid temperature can be
read from any remote site and from any capture or report registers. The
invalid change in temperature can be positive or negative and the resulting
temperature can be outside the calibrated range, in which case the TSR[ORL]
or TSR[ORH] bit will be set.

Workaround:
Use the raising/falling edge threshold to filter out the invalid temp.
Check the TIDR register to make sure no jump happens When reading the temp.

i.MX93 ERR052243:
(https://www.nxp.com/webapp/Download?colCode=IMX93_2P87F&appType=license)

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v4 changes:
  - include bitfield.h to fix compilation errors for RISC-V
  - use macro define for temp rate related setting

 - v3 changes:
  - refine the code with FIELD_PREP macro
  - add errata doc url link and refine the commit log

 - v2 changes:
  - no
---
 drivers/thermal/qoriq_thermal.c | 44 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index b2e634547271dcf512c714907baa162921d2d527..0a505e9e66a839155675a3d78a67de95a670602a 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -3,6 +3,7 @@
 // Copyright 2016 Freescale Semiconductor, Inc.
 // Copyright 2025 NXP
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -30,6 +31,9 @@
 #define TMU_VER1		0x1
 #define TMU_VER2		0x2
 
+/* errata ID info define */
+#define TMU_ERR052243	BIT(0)
+
 #define REGS_TMR	0x000	/* Mode Register */
 #define TMR_DISABLE	0x0
 #define TMR_ME		0x80000000
@@ -45,6 +49,15 @@
 #define REGS_TIER	0x020	/* Interrupt Enable Register */
 #define TIER_DISABLE	0x0
 
+#define REGS_TIDR	0x24
+#define TEMP_RATE_IRQ_MASK	GENMASK(25, 24)
+#define TMRTRCTR	0x70
+#define TMRTRCTR_EN	BIT(31)
+#define TMRTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TMFTRCTR	0x74
+#define TMFTRCTR_EN	BIT(31)
+#define TMFTRCTR_TEMP_MASK	GENMASK(7, 0)
+#define TEMP_RATE_THR_LVL	0x7
 
 #define REGS_TTCFGR	0x080	/* Temperature Configuration Register */
 #define REGS_TSCFGR	0x084	/* Sensor Configuration Register */
@@ -69,6 +82,7 @@
 #define REGS_V2_TEUMR(n)	(0xf00 + 4 * (n))
 
 #define GET_TEUMR0(drvdata)	(drvdata && drvdata->teumr0 ? drvdata->teumr0 : TEUMR0_V2)
+#define CHECK_ERRATA_FLAG(drvdata, flag) (drvdata ? drvdata->tmu_errata & (flag) : 0)
 
 /*
  * Thermal zone data
@@ -79,6 +93,7 @@ struct qoriq_sensor {
 
 struct tmu_drvdata {
 	u32 teumr0;
+	u32 tmu_errata;
 };
 
 struct qoriq_tmu_data {
@@ -99,7 +114,7 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
 	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
-	u32 val;
+	u32 val, tidr;
 	/*
 	 * REGS_TRITSR(id) has the following layout:
 	 *
@@ -124,6 +139,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 	if (!(val & TMR_ME))
 		return -EAGAIN;
 
+	/* ERR052243: If a raising or falling edge happens, try later */
+	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & TEMP_RATE_IRQ_MASK) {
+			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
+			return -EAGAIN;
+		}
+	}
+
 	if (regmap_read_poll_timeout(qdata->regmap,
 				     REGS_TRITSR(qsensor->id),
 				     val,
@@ -132,6 +156,15 @@ static int tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 				     10 * USEC_PER_MSEC))
 		return -ENODATA;
 
+	/*ERR052243: If a raising or falling edge happens, try later */
+	if (CHECK_ERRATA_FLAG(qdata->drvdata, TMU_ERR052243)) {
+		regmap_read(qdata->regmap, REGS_TIDR, &tidr);
+		if (tidr & TEMP_RATE_IRQ_MASK) {
+			regmap_write(qdata->regmap, REGS_TIDR, TEMP_RATE_IRQ_MASK);
+			return -EAGAIN;
+		}
+	}
+
 	if (qdata->ver == TMU_VER1) {
 		*temp = (val & GENMASK(7, 0)) * MILLIDEGREE_PER_DEGREE;
 	} else {
@@ -246,6 +279,14 @@ static void qoriq_tmu_init_device(struct qoriq_tmu_data *data)
 		regmap_write(data->regmap, REGS_V2_TEUMR(0), GET_TEUMR0(data->drvdata));
 	}
 
+	/* ERR052243: Set the raising & falling edge monitor */
+	if (CHECK_ERRATA_FLAG(data->drvdata, TMU_ERR052243)) {
+		regmap_write(data->regmap, TMRTRCTR, TMRTRCTR_EN |
+			     FIELD_PREP(TMRTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
+		regmap_write(data->regmap, TMFTRCTR, TMFTRCTR_EN |
+			     FIELD_PREP(TMFTRCTR_TEMP_MASK, TEMP_RATE_THR_LVL));
+
+	}
 	/* Disable monitoring */
 	regmap_write(data->regmap, REGS_TMR, TMR_DISABLE);
 }
@@ -389,6 +430,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(qoriq_tmu_pm_ops,
 
 static const struct tmu_drvdata imx93_data = {
 	.teumr0 = TEUMR0_V21,
+	.tmu_errata = TMU_ERR052243,
 };
 
 static const struct of_device_id qoriq_tmu_match[] = {

-- 
2.34.1


