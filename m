Return-Path: <linux-pm+bounces-35133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A56AB8EBFA
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C0A7ADE61
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777EA2F0C76;
	Mon, 22 Sep 2025 02:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fdZ/quo0"
X-Original-To: linux-pm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CDE2F0C5F;
	Mon, 22 Sep 2025 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507289; cv=fail; b=k3ZhUe/BjjViVMHKTtryBVrWzcJleUbBmnytuL+9a/JLUjZYHQRHrG4+UezQqZlmtuRSSU9wYXz7gPtDKiR9pHcDnFw9VgwhcB0xpj5qcYw2uQEEeU3QgBx7RfT0v/cBvCPgLusyR90LtJBeyKekB3CfMLZZ+j2MAeqWh0EEpCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507289; c=relaxed/simple;
	bh=gSgvNMd42cS1yyxNbbqlbnsgCXM/K7jY4R8qzJ0uIMk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RWJQDyebOKHgjZ2B/NC4G41aYtlxSTf5YIwFW7yy5e+JjrTsTt3tUQL2TmjDF/qZmxgej0/KBtD7EfSZ9ZGIgmPZrFILbGeIIpVHqQAVsBaHACADblu3uw+/Ry0fGOabj+ukC8oZFIeIDN8waIpCtXQcBtKzWd9X8N6a3mH0tnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fdZ/quo0; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jb+h2+1r6NK8IRIVzqKvHfejh4oI8uYKgqfT1rRCMzs3GWAtIkOkHm/39YeGS7ZGNWlFVM9SVpIxL1ahsRAgg4dQ0lEusJyekXb1Pd9Vv9F9y+iUclxEEf1GUqlHJDpqzfK+T2teua/sewzIvRei0fSQVTuvLI0JqIobWVkscht/dTw4nc+0J0sCmnQO2G0KlTc1n4VLNd/LXSn1+Nt4axIpICeex1uW5eYNJNh9uemM5gSVlG5BT6EYNu0PjEsWZz75IKz4EUV8I80b/MrCtFxxYSLbiIGmYbENHdlbqthFTq0ABJnduBWwdnPdivdk23fVVJxSlQOQfq82ghHrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1o5eAQMrSMjvz/rfMDAfptXhUch6sz+PiGm3mZGh1bw=;
 b=E7vpV3mNp5ITj2p8O0oSl8kMdRmacPJrp1euLVYmKDzKaLAPefWcK14kRsaKaYmBiQqYxTduyXVGOI6qodceLowdPYM4vMRqCoVZzt2OjgG/ZjIgta/xacyLmtXrm5+vmZr10JnzeXpeA0BSKxuRqsd4n9rr9yUKg/MaNpMFeOQAMIR88/JnXmSteVls1DzFpXstO7Uy+T+oenS0+SRBQ218PJbtkRg/sSa92/JfDo8woF2Q/Fggsi6iNC1zF0YDxigB9Ja7dGijWhcvfyuChWSYtRbeT4fVF9q+mXusTA+q/u9QKcSgPCiIJx4sCAWVzVBGP0V2ymaH93bvhUDDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1o5eAQMrSMjvz/rfMDAfptXhUch6sz+PiGm3mZGh1bw=;
 b=fdZ/quo00ic1kwKDF9G2cYBFxpDbymxj0jWItaBuyby6YHSyggkI2qShpFJcORstzqP1UJs2lyf9rl51R7XSxwXivhGNGUJ79zIbHgLdz89k9HSEhdaht+U3FesX1I1fs8PDu502n4PkOZ0Slc6DXIpxF8ipjDGVg3v6fy0NMPbHbhY8jaEbPE+CiUuHwdBVpUiVvONa+C4eNVMXj1Fr3h1RmcdCqNVmdZXTx7i7Fsj/1sBRPltVIzs/m1VsMVyNpnf7ZJ97KKXQqiJtS98yeXx+Z80tKXXIiccGvYeuezJaJKY1bOlVLyYuim7hkUXwiv9NmZNurK6qqLlUsB5fgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:14:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:14:44 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:14:11 +0800
Subject: [PATCH 3/5] usb: chipidea: core: detach power domain for ci_hdrc
 platform device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v1-3-7ed2e98065ad@nxp.com>
References: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
In-Reply-To: <20250922-pm-v4-v1-0-7ed2e98065ad@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507262; l=1737;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=7SABP9R2PQ+RRgGfQ+qgV83O1Sg3zJkr+c7aWvNEdE4=;
 b=GVYKwz3hB7ZLV15C5d6/ZtIXwlaZIZaHeUzHk2v6fLJZ+PVfA/I5XNx0tTwWsRrp2B6KVcURk
 LKjjDgc0sZ1Act5V2FD1PUUifdiVqfvRF5TNeKNItiUsGfrz+1MfNl7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 6192c96f-11b7-498e-6aa8-08ddf97dcc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE9aUytObzNQTDg1TGtnY3FkYnJ6a3JOalMyR0Q4ZHJzd3JRVFoyUXUySVhB?=
 =?utf-8?B?WE9KZkhRV29oSXg3SHRnNEpCeTBJaGZNYkxWMHI0bUhwMmR6NkRLekZSYWE4?=
 =?utf-8?B?aXByZXg2dHRUM3Z1aVY1N3pDVHk1eGo0YzR6bytDeUNNQW5TVWlDcDNubURU?=
 =?utf-8?B?a3lnL1plVzNEbkU1bDc2SW4rWkc0ekg0S3FUMm9DQk01bkZZbWVjOFVFRFUr?=
 =?utf-8?B?L3orR1dPZEpScmttazJVUnlrNFY3djc0aTdOZFg1ZEdORFdMbTR1Q0VaR0Rt?=
 =?utf-8?B?dEpUTzR6bmJvL1ZucXdKVk1wOEZONVN6MU1EaWhyQXNNanNnNm00cXEvTWE1?=
 =?utf-8?B?NnNSNDU0N2FGUGk3VmRxWTgvdjFuOXQ4TnM0QkZTNFhYRTAvUjYwcUtEYWpx?=
 =?utf-8?B?NkZPSnpUY2UzNHhuZ3JFaEdHUm0vMThTY0JPMHc0NG9ST3dZS3cvWXZmVyts?=
 =?utf-8?B?YnArcnptR0FtN1I3aHNaUlhKbkhaN09DL2dBTWlJVDYvWjBDa2prNjFaQVU1?=
 =?utf-8?B?dFFlallDYStZSmdPV1ZyaUpJSUhqZ0hScE9nU01FTDc2dU92K1dxOUJtRHZP?=
 =?utf-8?B?dnJKMVpROEpOdEhwL3I5eDFENGxVU3lxZDRVWVU2Z3JaTGh2eDd3eC80REg4?=
 =?utf-8?B?RGoyRXJNN0NLdmphYU5PVWVmbG5adWt0anpBQlJ1ajV0N0VBS1l5eUdDQ3lo?=
 =?utf-8?B?a3NjSDFPSXQwNlVRcGwxY2hTVHlDS1FzVm5XcjR5WERrYVhYN2x5dFV2a3dY?=
 =?utf-8?B?MFhhcjdSbGgwRGsxbGhhMnY5cndFN2pGTGlwbWR1RzZFM1ZsZG5YZGJRUDAv?=
 =?utf-8?B?dTNSY1E0VVhIQlQxVFNjTW5rOG13MzM0UlN6NklEU2RReGcwRkR4bWR2TWdU?=
 =?utf-8?B?TTZPZTU2WDlsRHUzcksyVTlHMmZuYTIwdm80Qkc2QWJQTDNyZGdBZ2JxbjVC?=
 =?utf-8?B?bi90Z0gwd0dhZGZtOERzK1NtbFhPdG45c1NKZXV3VWxqMHBVK2Z5aEd5dFNz?=
 =?utf-8?B?SDdRUi85dWFKRkhybmlzbDhndmdIRGhrQzd1N3h1dVZTVjdUWXBxSmd0Mm9L?=
 =?utf-8?B?aWdBU1NOQXNmNnZBeTk3dnNDVjVzUG1XanJrQzJxekxoNGxRelQ3S2tNanor?=
 =?utf-8?B?Nkl2VC91eVVJOFB5Z1YvNk9DYU51ZVJHeUc5eDNoZWZFaTBya05URlZXajRo?=
 =?utf-8?B?RkNOODVxTXB4S0NxZG9PelJ4VWZMY1Z5Y2VSb25zOHJYYnFtcFFoOXdQT3lh?=
 =?utf-8?B?ZHowS1laQk9GMlM1Ylp5Y3RZT3RvczEzTm0vQlRLeXJscXhCSEdoREplaTly?=
 =?utf-8?B?MVZkUU5zamZlNWxod1V4aEN3dUVhaXFtWTlYMS9Oc1BzaHJwZVMrWU1sdU9V?=
 =?utf-8?B?bi9qU1ZYdWFuN0dTcUkyQzhucStLajdNaitMSUhkN01GdzlvZVJlclhmakRt?=
 =?utf-8?B?YlMzV1Y2YVVleitNUDBUSFYvTmVWK09zYW5QeEFzMmNzYitBZURVTXl4aE1Z?=
 =?utf-8?B?a1hQTmhCU3R4YVI0QUpGckw2TXVSZk1JVGF0eWphRFFNWHl4UDA4eDRIQitW?=
 =?utf-8?B?Vk9Ta3FTRTdKa2d0Vm02S244ZUc1Nkw1N1RzVmxuQVpYUjBjZHVYNUtEU1Iv?=
 =?utf-8?B?aGt6RkdkU29xSVgwbmFQOW5WOHUvNkZDTnFydTlzWGVrcytmLzcydHNhcStl?=
 =?utf-8?B?cDl6WHdxeFZaM2JuUDFleFVoRy9FaUtFS0l1OWVJOVV0N1kxWGZTWWkvY1Jy?=
 =?utf-8?B?QnJkV1NBQm5IbHlwL1lwZXJsUTlNRVg2UHN0SnFTNEs4ZEwvNzBCVTFBMng5?=
 =?utf-8?B?QUR5MHg2M0FxRm1WTExMY0g5NThOSm5EcThRVXZlRnp0elVNa2xWaVc2Q3Vw?=
 =?utf-8?B?UktxL3gzRVUwZDh2dTl6cWFYenhQeTdOem9iNnpPdlVnRGUrVC9zM2hia2Qv?=
 =?utf-8?B?RGp0RjU5UlFCTzZuUldiR3JwWXhNUnhpanRnbXZqa2dreE9LbFZhNlNyMEpD?=
 =?utf-8?Q?US+bPy7V7N2SL/EZjdr+h/facaJUe8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU9sUldsakVnNGRJcUF0Ny8yWitHSmZqaFdxWnp0MmIvbzU4OUZmWnRlSVI3?=
 =?utf-8?B?NldtbU5UNkx6eXpmNzBiSjcrYmk4NzNhRmQ3MVQ4djFacWtzcEFGSzdwSHZw?=
 =?utf-8?B?ei92dHltVnM3eHZlaGZvbTkrTWE4MDh1R0dwUWQ2RW1TMStSak9rZEE3ZkNO?=
 =?utf-8?B?bkYxSEl0TVpLQ1NES01mcnhIc1N5K01aSzRIYzg4dGVzamlXMExrYmJTZVUr?=
 =?utf-8?B?VHVGellPSG1JbFhuZm50V243cDZsaURwOGNETXBTdU8rcHFOS01ubW5JbmlK?=
 =?utf-8?B?d21WSmg3WmlRb3BtUlJxMU1wWDJwVXozd01YbzBQdlBDZEp0ODEwT0RvWldU?=
 =?utf-8?B?NzJVM21DSVNWR0JWRWhNck9kWEtaYk5nYkg1Z2lFUXlCZ2c5TERhN0c2WHBy?=
 =?utf-8?B?LzJkaE9tcVdwTitVbXFOK1dxWnNoNDdMb2VLRHVjZWJlazNzUUJGNDVEQ3hP?=
 =?utf-8?B?ZjBNekVabXcweitmK1ZwRCtGSFJqN3haWHgrMkhlSGNJNHpqbjRKYk9jblVn?=
 =?utf-8?B?b2FaczlDclNpb1NYSk9sZlNSSlZIM0hIVTNRZm1vMUYrUHoxTFpDbFNzN0dZ?=
 =?utf-8?B?dDhYM2kzZEZKU1NlMEs2Ylhua0VSK1JqVlhBL01WY2VxSmZzcUozVG5IUDNY?=
 =?utf-8?B?MU1TMXM2OUJ4OEYxMXFXbmw4aDN2Znh2dldDb2FDSGlkMVpQLzNQRzBNTFVO?=
 =?utf-8?B?Q3hRallsa2x2YlcxNmhZMzhXcktBOHJrMkhYSmNTNG5vVlZMTC9oZksxZ0JL?=
 =?utf-8?B?eHRjbTlkMnU1RW9nT1NtekVCaHZzOUpsTE9CWFB3WGRTV2NsZGRPUGt1Y3Bk?=
 =?utf-8?B?YUdaVGphVWZnY3VFK1FJZlZ3UUJaZnNxTUsweTlDL3AwWlBZd1UxYW9YbVJM?=
 =?utf-8?B?VUdLY3hESitiUEpWdzRBQklvYW1zVXhmb0EvYlp3Q09wYWF4b2lBR3B4MXg4?=
 =?utf-8?B?ZlRSL05GYnMzQlZjL1F0WDVtTWhPVUZYdURJZXkrY1grdDJRMzNqaCttMHpF?=
 =?utf-8?B?RzJDdzlOWGhza1BoWmFPSjhxQVdIeDFlUmwyUDdsK2plSTVEMHRsVVkzc3Nu?=
 =?utf-8?B?NjNxR0t4Snk5dUVwVTRZWkJibkYvVlJRRlBJZGRhQWoxKzRjdmltUjdmYmFx?=
 =?utf-8?B?dGFkWUdKZmVPYVlhQ3Q2Y2NEYlVBcjIvK21tdk1YcEgxdi9nS3VUNy83UkdC?=
 =?utf-8?B?SzFWcVFGeitYZFNHZ1R0WWQwZ21GWUtsTzI3WU1YWDlZc3NMS2ZrdHBubGth?=
 =?utf-8?B?akxIem8wMm5xTUVBTjVVVnNiVy83MWhidStzZUtIa1JqMjg2MnFJeHh1dERS?=
 =?utf-8?B?OG11Zk03Y2N3TkUrclh6R0lROHpKdjh1dXJ1VnVhT25XR2xyWW4zUzdlTndK?=
 =?utf-8?B?dFhkbGhMRWRhZS91UXhNall4ZGExanpMdDRhK3N6a1ROdWpXS0V3dk9TVDZ6?=
 =?utf-8?B?TVVqZVJJbnoxNHBSK01jUFZuUkFZTGJZRDhzVWdGWnFrdFV6MWJEMWFGZWZL?=
 =?utf-8?B?RDFYNFo5K25lQnIrbzhHNXFxcWlBZlVVQ1ZSNjQ1VnNvQnhZS1l3U3NYNHpQ?=
 =?utf-8?B?M2RXOVEzWXh2SlJMOHd6WmNDdXlROUhQRVNmRUdkdjZLY2VQTUtZQUFiZEVM?=
 =?utf-8?B?ZFpkb3B4TzJ1Qm1LdThCQ3hyNjM0eTJBMXZaN1Qxd1Nsc2FEaVhpa3ozaTZh?=
 =?utf-8?B?b0ZiMzUxOW52d3VnUGIrbCttaHp3c1VINDNXZUZpQXFjSDVXRUpzZVF6NEFq?=
 =?utf-8?B?ejZ0alJRQ3FiaEFhY2lzeTVFUS9USlJLTHE4UTdkYlpVdGQ4ZmdNQmw0ZjlU?=
 =?utf-8?B?ZHRqMWpWWFVxZENOZjFCK0c3Z2JpZ0FxUVR5am1EREduS2xiVnlUZUl3SEln?=
 =?utf-8?B?ei9ITkxOM1gvM1pzS3N6Y3ZCa1h6cWhwbXJ0NXJrR2grV0JZMVd2ck9yckhC?=
 =?utf-8?B?OHV4blpJdWtFazBaS1FqSGFvd0xia1hlb2pjaTJwQU0rQVJIS3FjZVdnMjRP?=
 =?utf-8?B?bzJBK0QvRXgyZWNwd3ZhME8rWURiRkMrR1gyMmp4SXZnRnZpN040SDMrUjNt?=
 =?utf-8?B?Y3JiUi9XVDJCTm1FS3VIa2lYU2YxS2YrbUNzWHd1YXpZZkVXRmM5ZWtIM2dw?=
 =?utf-8?Q?aXFB9VqZavUPDJuFiUCfoFQYQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6192c96f-11b7-498e-6aa8-08ddf97dcc1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:14:44.8695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8vOAnA2LeMKxCNywU7QKcbD53MMMiBGXjRMVPtJL8L2wr6q0+ey7rltv9vAig/n7SK4Ox2Q0ppCuNtdNVGQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

From: Xu Yang <xu.yang_2@nxp.com>

When add a platform device by calling ci_hdrc_add_device(), this device
will reuse OF node of its parent device. If power-domains property is
provided in the OF node, both two platform devices will be attached to
the same power domain. This should be unnecessary and may bring other
inconsistent behavior. For example, to support wakeup capability, these
two platform device need different power domain state. The parent device
need NOT power domain on for out-band interrupt, but the ci_hdrc device
need power domain on for in-band interrupt. The i.MX95 Soc support
out-band wakeup interrupt, the user need to enable wakeup for the parent
device, but if the user also enable wakeup for ci_hdrc device, the power
domain will keep at on state finally. To exclude such inconsistent
behavior and simplify the power management, detach power domain for ci_hdrc
platform device.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/usb/chipidea/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 694b4a8e4e1d8583dcbf4a42f8c2dfd785d5745c..70597f40b9997a9766934c67bbbed38e96c210f8 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -27,6 +27,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_domain.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
@@ -915,6 +916,8 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
 	if (ret)
 		goto err;
 
+	dev_pm_domain_detach(&pdev->dev, false);
+
 	return pdev;
 
 err:

-- 
2.37.1


