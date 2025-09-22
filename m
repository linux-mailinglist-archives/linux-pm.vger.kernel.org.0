Return-Path: <linux-pm+bounces-35142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8CB8EC78
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7744F3B4019
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DDB2F49F2;
	Mon, 22 Sep 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OQeoh2/v"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05D82EFDBE;
	Mon, 22 Sep 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507714; cv=fail; b=ECWA9tHJI5gb62R5bPgGqrbge3dztVtRPhvGjQPLqt2HGYvtr+q5s1hZSdd+C7u19IV2Zth1a5STcI71Gn5vhfPn3T+aJMzbZAzJW2OVdncC8KR49aabNAYu8/Mo4mG55vncH8iBLnem73A60oeWYeyFnHa0AK92t9xapCRSKOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507714; c=relaxed/simple;
	bh=W8vS5ztSi/wBpkyb7zcOiyH/FeijQe8uyYrrzpMzHHo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qrCtgPHuJlM0OSSHKHPknFsaYImbNC/Vcq+Gwe4AOK5IqONl2sZ7rGOJskP2fXKynvpunXt7TjS4LvRcrIw8XX6YT3NUgLO6p4op467OCIjoNc+EspIRlIH4eKaDrLl+XlvuloK5/GXV0Zv6LpsBKDfcgy4MQJ1/a5V8tT1Rhl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OQeoh2/v; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvDJt7hyvJCtDofoiBlXdQtlDxvskfCF+XeroyTvwCvt5Cr5OwpyDiuj4gtYpCji9Ebf1wWhVN0b7knH+7UB1NUDBTI/YMLDl04LdnnQxdm0m/y/1KIaTWdJUKXg3mBnEhFNVOhFplMKotODPTF0FJ8cCMupzVw78kd0Txabg6HoR3m4Sl3sQjkiy7XAcGrA5sO9vJcb9bXMc3QkBe3GWS1CD5EL5wfyP3plFCoCkpt8JFKZsE+X5PxS1IvU1N/5qCxElAhPEuuqMo6Q3BgkE3/3xFPDjNqYvrM5VDwOGzdY057C9B+Bcfrq6Bca30M+aBlOxXVe9dmVH8VBGch2Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSV3r8U6YyZFM08LSXwgY6kuTfLIWft7C0+iawqKPvg=;
 b=j//mNzPC7AZ+1IOzxxTvmWfcwqFw53ZVBCeuQBgJBJeWdKMVqE+oP76YliLLGoMTODYvrdugp14XWqujQKjTzHeAskU32Xb7VZ2TcYTPdLaKCac1gq45AkfIt/RHRgDDKD8BBZw9DZSCEP+pUvma8P+IgaIjFqKYuDOT3By0Lh1FFwJ9kw5DapXesIbUkgbUxUWo9Re9B6NSZQ82loNP/wfHcuwNtr9NNL3zrasjzJeRRYlUEVag25AesGQFVPIvVPIEyn8oJhHixmqiybteGlXJF29B+DsilkTZM4I+f1IUhchcjy7bRoC7UDRqD2BgpSADujNFj8YpC/0vXsTqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSV3r8U6YyZFM08LSXwgY6kuTfLIWft7C0+iawqKPvg=;
 b=OQeoh2/vliKePNdzWmY27U+d4LuTkBeueBYKjROeQ8lKx/ZVcZpf8F0iyMXv572tkHjB98ikS0QfdvdeL+HeYuQGIAXXMKZ88KPbXUSuouZylNU4k7OqRwx3LfnB5ovx8qex0l1h3oN7yUvMiL8k5VJsY3oL7BK/7hmNfBYcSLDelPpc4O1arMFYHze+4sZ03fd1zGaOj3eC+qm/nW6NXKbWsx60iMM9l4qwOIKixhGLSoOyN5bE/2D76bxEDp1t5A78flU1WHolb8qiz93FoTwSjnbOvUc0WsSGds5KxIzBC54cn95uBB1AVgTvxY/NHlksZmUIpfZA3lq5No9rcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:21:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:21:49 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:21:10 +0800
Subject: [PATCH v4 5/5] usb: dwc3: imx8mp: Set out of band wakeup for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v4-5-ef48428e8fe0@nxp.com>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
In-Reply-To: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507676; l=1409;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=W8vS5ztSi/wBpkyb7zcOiyH/FeijQe8uyYrrzpMzHHo=;
 b=uz9QEdC46ENBqNomOKVluNHKtUe1FTLOj8sXL754TS1XNiUANQ7I0V3UlqAwJMRqZsX4pFKxr
 Jyd7cGlk0MBDcss/7qZhIwopMFfsg6qLPaMAhBXN/ZY/NOMIt5MCf+5
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 23125244-7f4f-4f64-cba0-08ddf97ec95f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJQSGRXK3A1MG1mSmw0OUdWeXlSNUpLcXRXYzQ3ekRuZjA0c0dzZEttMGtF?=
 =?utf-8?B?OWF3UDl2ZHh6ZlU1UEJ1OGxYUHNnUkVlMnQ5UEd2K0M2cUN5VzROM1lXeXZH?=
 =?utf-8?B?YjFLQU01YkpmWTRXQU9LQ0hoQWtRK0VyRFMvRUJWMjJyZ2N6dDY3emJXY3Yz?=
 =?utf-8?B?QUtCbWsrQ0ZucDhIVnpZWmt3M3ZybzVvakxKekpqamdPdWZTNHVLQzN5Z2Ja?=
 =?utf-8?B?Y2tuUi91WC9BNzZKejE1Vk5FdjB2TG9WbUpJTFB4YTVRWnE4c1FWUXBtU1Rs?=
 =?utf-8?B?RTl3Y2xqc01icmNnWlZzVWNZN1g2MVRGV0t3ME5WYk1ONjJ0WUJwNEw5VDds?=
 =?utf-8?B?Snpid2ZJNjUyY1J4ZU04YTU3UUsycUxPL2FtQk9jZzJQNXhXdHNuUTRvbmRZ?=
 =?utf-8?B?amkrS1NBbWRHYyt1TGxvMkpGcys0TzdqQWFkYTl1YU1JYXdFM1FaWC95MEh0?=
 =?utf-8?B?ZGt5NTI0OXpVV09wM0o0cC9ibVMwa080b2JXTUZsT0NCdUhER1JVUm96Vm9v?=
 =?utf-8?B?eG5Xb1ROOGVEVFZaN0EvSitVZWEySjdnYW1KeW4vYjJmaWxiZkpVam1oNVY3?=
 =?utf-8?B?Q0luRGZ6MnIzZnlZRGRDUHNXSjVFYVZxZjkybkJQKy9tYURYczNMNUFQWThW?=
 =?utf-8?B?cUNtbWdubnZIMWprb21nMUlCYmtBNlkxOEdsTWx2bm1pVit6eGx0bXI0MWlE?=
 =?utf-8?B?NjVCeEIxVFBKdW9XRUdoM0hObmJMWVFmTnczcVc5UjdKV3JPUFEzN2J5SFFk?=
 =?utf-8?B?NXZUQ2VwcUpBZG1sUmhXNE5MbTI2MmNFejFwMTFsUXJOVk13OWFobnJRSWVk?=
 =?utf-8?B?bjl3K01TbFdBV3FCQUU3WUJiV29TaXladkIxQUZZNHBCU2FLSWcyT2V1My9F?=
 =?utf-8?B?YlZFUWM1Ui9NSlpacEZnaVYzNHBnRTRIeUE1ano0czhJTVJ0QWdqdUZZVDNE?=
 =?utf-8?B?cnY5SG1kM2ZRLzlabTdsRzduK3hBNDNxbmkzeGFnUm83SnpzeUg4VGN2TndN?=
 =?utf-8?B?YWpMNDc3T1lybDg1YytMVHJ2V09OWUR6cThMdDBzWkJxKzh0VDVSeWhIQTlW?=
 =?utf-8?B?bjZ6NERDMW1Dc3lGUVYyS0tycjh3YXNBdkp2MlZET1UrZmh3eUU4N1gzMzVv?=
 =?utf-8?B?dzE5WUh1RzBqNER1bU9VWFJQTks2SVNyYjl1a1NhaHcvM1RiMUxQQVdwTHpY?=
 =?utf-8?B?RDFiZG5PWm5CZ3dEMG5pTkgwaU9kQ1EwUUVmQWJwMjNEc1psb09lUFJPUUg5?=
 =?utf-8?B?MUV4ZWxIUVNtbVRydmxsL2RESnNhc0FSNm80ZWNtdm4wU2dhTmg1cTJHV0U1?=
 =?utf-8?B?amE1T3hjR09PRjA5QXl0UW1XS0FiZ0NBOTVxQytGVzhpWWZsYnRjUUJ0NFJG?=
 =?utf-8?B?V2NkSUxmQWZnNDJ0VzJkdVZoN2lJMzcva2drRUdNTzRlRnZWOWNqMFpqN1U5?=
 =?utf-8?B?SXpZRmFPS01sczBwOVltTzdiZ1Z3YVN3MTcvWDlQQkkzZG50TzFjZkZoN0g1?=
 =?utf-8?B?bDd5MlhEODRDWkZGZitLRzNzM1d6cGNrZDVEMTFkVnFOZ0hyKytWU1RvL3pK?=
 =?utf-8?B?V3VoYTF2eENPMGE2b0xka3NBU1lxNEk5dmlOaS9FT1hoN25kQ2RyMW5ta3VO?=
 =?utf-8?B?L1F2VjFjNTFLMSthMjhCY1ByMVRleG9udXZZdFRPNnpGZURiVHJ6MXRHVDhk?=
 =?utf-8?B?aGZ4MkZ0SisrZEZoNHNoMHNXWjZ0MFlsTVJaSXVzbndybVFCQzJzRnhRQ2pY?=
 =?utf-8?B?NDY1NWNLQ0FabFlSVUpjcjRSUmZuOWRDOGlrVHJkRXExdVphVUo3YytQNUhI?=
 =?utf-8?B?a21UZWlFU1BuNGh0aFd6NWg1eGJ0WXJ4cTdHbDZOZlFJZm8rTWhiSlRubXMx?=
 =?utf-8?B?ZEJySHlDSEhPaVM2dE1uNjhON0RXTExOaVFzTjBZMFU5UllPa29RbzdHN3BU?=
 =?utf-8?B?TXNaVWttcjd2ZnBXZFpGYUZkSkhYWFVDQnhnZGJaV29zeFNBMWovSXk5V2xs?=
 =?utf-8?Q?YGw1zvluZgGxkQsxaihHSNLmDa3/z8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEJ3dVZEam1NeFlqblVqcG9YR0JCTWpoQ1NFZS9oM1kwMlloT1pFZzdSN2hV?=
 =?utf-8?B?OWI2Z2hiWXNIZnU3cVZydmZlbks5czhCK3NFaWhUb2pKZHVMR0FrMFRmZ2py?=
 =?utf-8?B?Tk1Hbnh1bC9POWZENzljY3R0WDVGWTVxVVhPQXVtMkhjODBwZjZ2dHRSMHMx?=
 =?utf-8?B?RG9ZcEdhUFJpSHBXZ0tYQUNVWW9PU3BLa3Z4M0t6Zll1ODdtQTdwYUxSTW5W?=
 =?utf-8?B?YURNNkN6TW93WjhZbVhUZTFETld5TzM3eDFjYjlMeWN0VjV3ZDI4R3R5RU81?=
 =?utf-8?B?OUZaZjdMeVdiT0t4NzdKdkNpOU45ZGpIR1NUd1llSUlyaTZscFBKNDBjLzlM?=
 =?utf-8?B?RytjWWdmNFdJS2UrOHFtbnpMa2ZkQTR6dmIyY1U2dzJGaGV0YUVKMitmbnds?=
 =?utf-8?B?blA5QUYxUGZDcHNWMTRLWkd2ZVpaR1RlS2pzNDB3Q25kcXJhR1lZMkk2c2w2?=
 =?utf-8?B?dUVsZUUvbkpZVEZ3dXJDc2RQUjhEdWlWb0RLTUQveTZTMW5zNEwzNEtSR01J?=
 =?utf-8?B?aFRYV2lISzFIbWFjbnFpd2hEMlJ4eUFSQkYvR2VvOU5zUHVuck5XUHVlUStw?=
 =?utf-8?B?ZnhzMFNDRno0OXlGRlpqV2IzSWVWWVd2WkEvU1FEYUJFc2RiUkdSNjBReUJ5?=
 =?utf-8?B?Mm9POHJFcTk1bjh5WDMyVDFBdXM1aGRPcnFHbjg0cHBYTnVGdUtRQ3dleGhF?=
 =?utf-8?B?L2FDZkN4clUrRmduQmhVTlVyY0NNK20vUDZVb1E1Vm04VDQ4ekE0dXBaVjFn?=
 =?utf-8?B?d29ncTRreEcrUFI2b05NMWlFWWt2bFNXVjgwNXhydUJSb0ZzckpEejBwTTRr?=
 =?utf-8?B?ZGxud2tnWWxZMm1YaGM2c0k0YnBTN1RjZlpIY09HRitHaThBNkNobnlzSEhP?=
 =?utf-8?B?aUM3SmpIclBoa3Q2bGxFV0p3S1BTdXVNYlZFNG1xM1p1bE9rcWdWbTlXUWpU?=
 =?utf-8?B?UHR2QnFmN3Y4R2tIaC9iYWFzOW5GSGJ2NzlZNSt5VXhscVJYdW9URjhTZi9F?=
 =?utf-8?B?Uno5QkdvbjhSVEpoZ3FFWXB0d0VhWWZ5UmJSWlZGbXU2ajBnb1B3TlZBQkdr?=
 =?utf-8?B?VWdUbXpBVUhZTkR0OGpOWjBIMEw2SXd3VG82WS9jM2NkU0RnMlhZTk1MWTEy?=
 =?utf-8?B?cWpaUjZzOHIzWk50N2RpbUF0NVZXOU95QzdQKzIzYktvOXhxQ0czVERINWha?=
 =?utf-8?B?TWNzZTA0enJjNmZhTEl3QkgxNzhPLzkzWitmYXBTcGJLWlZhUldBdzhTbWJt?=
 =?utf-8?B?T3owcE9Oc2ljUmZGVkJnYlBPR2ErZVdjWVNjbU9JQitYY250c0tFcTVIaExv?=
 =?utf-8?B?T0dKZ0VBZ2hnSlI1ZDg2TWVXSGRhcHF2Tks5cHNQVEpCMjh4cURUNFpzTXRp?=
 =?utf-8?B?cjU3Y3lwbG8zaWNHd2E3cEtEb0dBY25IOElZQ08zckRwRWR4RkswczNOdVd2?=
 =?utf-8?B?WXkyNUFHeDU3U2pxb2pkc1VYbDRYc3dRUmppeGJFc3R3Rk1YMWxtVjdtcmxy?=
 =?utf-8?B?ZGIzU3BuNHFycWN2YWVYSisxUkNuLzZ6TWRMODlUT2pBbUlaL09pRkxYdnNn?=
 =?utf-8?B?UkMrVHRmUndGcVdGU2Q1YmF5eS9ENUJMWFZ2OWkyeVAxWlduSFBBekZTWElr?=
 =?utf-8?B?QmhpMnlrMHlTa1B6UnhGSzJyS3MvT0JVVHY1U1ZkM2JFOGgvdEt2ditWVTJt?=
 =?utf-8?B?cnN2U0wydWlYUkVsdDY1dUZndHRtbU8zc0I1WEZnamFyQWdHMzBaeXpObkkz?=
 =?utf-8?B?blBMN0E5a0ZGTjJBU093M1ZHdDNxZ3k3ZUZlNTZZRG5ZYVJQQTR6bWszR1Fm?=
 =?utf-8?B?cGl3UExZRk5GSW1MSC9PZlRGc05ESlZid1BmbGF6Y24zdERmV2NZM1hmVzl4?=
 =?utf-8?B?YXB3NjBHVlFRS2FIWllHYU50U2NqcHpqY2t1cnkvWUk1SlFweVE1M2thR0JK?=
 =?utf-8?B?ZHBvMjJsOFUxbzRiQnZPcFcrTVFKZGhTalJsN2hKYnRRWkZVR3NSalY0WnFl?=
 =?utf-8?B?TmNXcE9nQVhoVjV3RlczODVTeVAwY0ZVVU0rWm5Yby9lZVJzdkt6a1ZYVHla?=
 =?utf-8?B?bEVQVWZjWWNSb1huWjBBUUU5SlNSSUFjbHJISHBtQ2ViMFF5ZmJGRytFanQ2?=
 =?utf-8?Q?rFVTMglcdfLj6WENH4nfV2Aql?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23125244-7f4f-4f64-cba0-08ddf97ec95f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:21:49.7422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaXtS37WNr8rFXUO/n5fnOM/O66pVERkgdKKfeU9aniBQV722kC+BScffrklSkY5ud49TfZpGfQ3Kg/Tc+pm1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

i.MX95 DWC3 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure DWC3 could
wakeup system even if HSIOMIX power domain is in off state.

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Tested-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index bce6af82f54c24423c1e1fcc46913c8456b6f035..225d59e9c1901c36be1fc18311dace6cdd45de75 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -334,10 +334,15 @@ static int dwc3_imx8mp_pm_suspend(struct device *dev)
 
 	ret = dwc3_imx8mp_suspend(dwc3_imx, PMSG_SUSPEND);
 
-	if (device_may_wakeup(dwc3_imx->dev))
+	if (device_may_wakeup(dwc3_imx->dev)) {
 		enable_irq_wake(dwc3_imx->irq);
-	else
+
+		if (device_is_compatible(dev, "fsl,imx95-dwc3"))
+			device_set_out_band_wakeup(dev);
+
+	} else {
 		clk_disable_unprepare(dwc3_imx->suspend_clk);
+	}
 
 	clk_disable_unprepare(dwc3_imx->hsio_clk);
 	dev_dbg(dev, "dwc3 imx8mp pm suspend.\n");

-- 
2.37.1


