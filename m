Return-Path: <linux-pm+bounces-19793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F09FD8A6
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4F43A35A0
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27BC8633C;
	Sat, 28 Dec 2024 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JboT+Epw"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2059.outbound.protection.outlook.com [40.107.241.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDD8633B;
	Sat, 28 Dec 2024 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348558; cv=fail; b=oOE5m78b3/2V0q5lN5Mw7hIjkE7STps3/LgoLzyozl1lAm6vv2TtMHvw0fAIEWHmUjS8ij18ddWivfNyekVoGvvj94nUiZ6iw85GBB8B5Zq3TosgrpoNZ0LHPAq/X0B2wj+M8xpt8LowQ4L6SUNWJ7rtG0QBaIRg6yvSVf+YYUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348558; c=relaxed/simple;
	bh=bGv4dF3gwaQ8/rybE3qOHzdzrW8kBSYtqBarBhutlJE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FnUjL9sGj92Tvcg0IDWDB+VX16vFTur91yDBxPR8pqwUQvEUIjIbrUdTuxVzKjWToea/SQjxod+218C5pMikMUW0ia1DtE+qWUd7O50G6yF6CcZOszq9AJGLF5Luq1K03aJ9Xqje73S97LpCE+vqo5PNQsjymOqZM2VYohX3oTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JboT+Epw; arc=fail smtp.client-ip=40.107.241.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf/lEd8zbFuK3ibEDx9jGqHKWkgJpK6DF/FCgfeqrd7sG7zUmyFwL3fc6gnpkDM21YlngW8JWnpOvB7zJIlW/HcZBzWRDWjrro7Z6fCyUBbhB4pTS+9JlLPVVhQD5qeHaAv2zDN4lWzPXWino2KN7Gae1X0TOmkk+julNpYBRxYPyy07QljT+n4dKNqEbMAlleGve6i+jjAtIA4mKsQZW+OeQWqw+zw7HdKF2uwiN3NBukOd1VSm+9hGWkrBogitdExYj9ninwBPggHAAzEs/fFH1ACpiozxzaAaKYdjTsWj8GeS4AEuMVKd2nVd8/rlaWXkAuJ9h53jSS8GMERk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFg5y3TrIOn9VH/jNSFVTNtUnnNsK5iZCxLymVMVirI=;
 b=xeuBrPTlkMx+d+wO/drwBoY5rrdQS42JRT8bU6e4tmfMA/zfsYoX26wys/YQDOW/QMSIItfWaEi+otBczYTvp20XDe7A9Ax2hSdZNx53OShl408PgeZcbraw8IrReWVrA2Dtb8N+ZNpiYoaMiJCHltGMdUB0oA3PM3ipae/lttvgLOKlOUYOY8FezrfcxI4QDsISqyNa6X1Ce8bkwc0njeV+irhG3/sBHN8IxlswWxtxBafG0ed4F8PumFW0f9McwiKTWuib7HoSb8uDXWd19C6qzE+KCKRpyzlRRunWkt+qZH5H58OhQ3jQAhx0T+sd3CoQJDiRTSINal0Q4+tt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFg5y3TrIOn9VH/jNSFVTNtUnnNsK5iZCxLymVMVirI=;
 b=JboT+Epwb3x2Arjezq5MdwcMSqep2L0tWB1HYJy46fthtfvPQj16Pb31L6cNT4gmoJcp00zTTytgYNpf8UID/tnEBymbNtULU0A480vijRl3LWQbxl2LMkSHrIXCjOwz49gjKaLUsKo3SMPEqhxxbtZoQpCQy86w2qdmABnPaZsuSwCTsqv/2tf76WKQ5JfRZI7vBNomdr7wBLKpo8SkmqTe+chkGXGCXM4ep6Bqg7MgoeY2gZ5oWKrMRGHsxuhivncBxt7W0lMVR6t5KztVEDpXWfjUFKYA3+x9dYPKEDDgvPVagdsroJeCeYJDgP7HDyL4N30GaDsBOvCbUpQ6rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:15:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:15:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:43 +0800
Subject: [PATCH 07/12] rtc: nxp-bbnsm: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-7-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=2071;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=VAulaoWVPhHtzgpO1nG1u9VR+bogAGzfLBxhdt2/l0I=;
 b=/Y2rJW+uvGVymldGjTdqHDl+b4ky/5JEFPBIiquUwbEeAm86Ox9gFX8XXPk1WjXf7BQX3ZFl7
 EVH+AXBrsT4CjLNe6ykOi1b3V/H+/sq6s7NoLo4euO+l/d0xsKfEZBx
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
X-MS-Office365-Filtering-Correlation-Id: 1a057b42-4d3e-46e2-a3e1-08dd26dd2a36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGtMTDVQUFhUNGRmRmthNTR1ZWJnV0ZuSVpTS3lXalA0K0JSNFpyaUxybnpu?=
 =?utf-8?B?VGFwcHFjd1pSdmZaYjIzYURuTW9MK1NCOXJNMlBJRUdDVGU5N0NTU0VYR2kz?=
 =?utf-8?B?bzgwYUZyTlN0TS9ESDBxNUE1bFloQXNPWWpFYU52eEhxWkhLL0lIOHBFeFpr?=
 =?utf-8?B?cmhoN2RMQXZWVW5SYWJwK1ZzM2tjZFg3K2RoVjhsQngyeTFpWk5TdVRnbEVs?=
 =?utf-8?B?TUlRNnk4QlU1ZmdTRDk1bTFlMlNvV042SkFrWkZpUkpsUEpIaFptdjlIdWVI?=
 =?utf-8?B?UDEvakthTyt1WmxtNFNSV3pSQVJxQThaNUN5Y0EyTHR6VjdianQ2WERld2xF?=
 =?utf-8?B?eXpmYTQ2THBLNHBtaFN2eGlsSGhvbUhDNUNwanRTWVVpanBJL0M1aHAzRTRp?=
 =?utf-8?B?dHVFQTRhOGhSaE1GcnoxRWxiMm5tSE9CNytNcmNwUDJhb2o1aVoxVjFma0dY?=
 =?utf-8?B?QjlHaHZLYmJmeFFjTzVnU29OUzJLeFQvODRXdE1McXRZaDl2YUp6UC9ULzFt?=
 =?utf-8?B?TThMcWI3c3haMEVKVGpFUlFEcWM0elVNWVFldmZ6Y0V5OTlnOWxaYmhVWXcx?=
 =?utf-8?B?dWY1WFZHZDVwRkowejhqWjQ2M0FGZU1paXVnZHZaSmpGTy81bmg5cHE2cytW?=
 =?utf-8?B?MFhVZHlKV2cwVWw5WnVycUtRUXBjTVpoMTZjcFVtS0czM1NtejhwMjRER0tG?=
 =?utf-8?B?ZElVVk51RGp6aWdCY2ZMSSt0RkRyZklEZ3BJMENLQ2VwSVZlSDNoS2NzUWtQ?=
 =?utf-8?B?R3VjSmk1cU55T3IycFEzME05SE5aWEpiQTAzYnZOUlpWL0JlbklOYUFtR2M2?=
 =?utf-8?B?M1BQQTVYemY3SW1pd3gwT2ljd1ROL1pic1FpVlh3WTRXVXdzYW94aW9naUhu?=
 =?utf-8?B?TEpKUlRHNnE1eTFKUUlmNHZSKzVQNjlwVDBxMzVNcmZmWXQ1eU5vbW9Xa2U2?=
 =?utf-8?B?Qkx4VDdGNG04Z0JFNjB6azRkemF5UGJqOVQ3bVpPYkRDdktzb2tjYnpZY2xY?=
 =?utf-8?B?ZUJPalBiZzVTUmpHYlE0TGZQSVJXTFlCMzZlUEg5MEhxbmhIRHVxb3FYVXpo?=
 =?utf-8?B?TVppSWJQZi9wOXZPbUlZTDUyamZwN3FoWWJyUzlCRjJMNUJpZ0tWWitMVXZ0?=
 =?utf-8?B?eG9kbTFqM3NtZ0ZSaWJkcmtjZWhpcVVzb0hPOU0zVG9OYXo0eWNqV2NJL2dD?=
 =?utf-8?B?MmRva01TbDI0YVhHR1d1em1DWGc0SjFrNHliOEdZNEFvekJ1VG92aHZTR3kw?=
 =?utf-8?B?YTk0NUZ2RjFRNXQ1WlgxbHZjWWdqVzNuRkR2VzJ0OXRrb0JXdzRLMzZaeEph?=
 =?utf-8?B?WVo2RHhYUEJsbFcxdTFveHBUekNLTFBWZlAyTUZCYTFRVE9NUWVTQVBOVWVW?=
 =?utf-8?B?b2QwdVhIcGNyNUdIdHdqSlJmRzdKR3dpRENUT21mZlpURXcxeXVqckFtOHVl?=
 =?utf-8?B?VmwrcFlCVzVFMUhZbkI4WWpiNnI1a3pxQWNmVW5wOExJNXM0ZkR3YmUyeDFZ?=
 =?utf-8?B?UTEzQ1UvSFhFSlFmdzkwVElVRmFrSlVMQ3dPTHRHS3pCM2V5TDFpZW1NTUl4?=
 =?utf-8?B?L00rZ3lkbjg4SVdXUEswR3NLUlFlZnNPbXgrQ0N2a2pWQVI2dzFnWllrdUZQ?=
 =?utf-8?B?REZrTWRENVVac01VZmZMeTZNV0xXZTZPRUVTbmw2NUlMQWZQT21qUWU5WTZt?=
 =?utf-8?B?dXp1MURjd0dMY0VIeVV2Q25yTDd0QnJYb3M1STRrYnJUTTh2RWNZaTBGaXVm?=
 =?utf-8?B?djNvTmsvNDErRlJPSXFZTVRjNUlMZVBXYzVXWS9IbDJZZUUxSzZEakJmc1lO?=
 =?utf-8?B?eFpWQ0FrU25Qb2MvZEEzWE1RNUd0Q3l6SWVUQ1lBbXV3UTd3VjVHL25pUkl2?=
 =?utf-8?B?Y0pNbGN4QUhneGNVaExYNDFDbXZ6c3Vsd0JLVkgwMEI4dnNSai9sZ1I0NG00?=
 =?utf-8?Q?PjkIBcIv0bjmqy7cQ5IkMIMdfnrQi6f0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXAzTjBUSlRUcHY3QkZySXZ3T0YrUEhNTEV4MzRUUkRxTUlnRnNRSDdtckxw?=
 =?utf-8?B?RUNsUTB6TlF0SDlDTmpxTkY5M0JVTXREYVZoQ2pNQVFjMnJvbDlNamhMMDBD?=
 =?utf-8?B?ZGdXeXhJeUdwSDdTMjM5YWJYSW8yUDdYOHVzbmhTSkFHOHlXVnpyclpCWmhm?=
 =?utf-8?B?WlRPVWdqaTVkMWkyakRvVEdJeXVqMHc1bXZTaXVoUTZ1WC9UQjNTajlYZmV3?=
 =?utf-8?B?Qk9Xb2w2OEFwVzBQOHd4WjNtSGhxSnc1NDdVOWp6bkk3UmkyWnFibG9zZTB6?=
 =?utf-8?B?ZElCNG5lTzNWTWhkR0VHVGpMcUFpQlQ5SlBIazc3NVovRHBKQWdLTkUzWElw?=
 =?utf-8?B?VUdaa2VwbFJmOFVVQzkzeFY4UVljRnh3NG9OblpmNG9rblRrZTZPOG5lUXk4?=
 =?utf-8?B?dWZMeFNPYWdxaHk0QTdqMmdQL3NraXRyNnI3Z0NhdHE0Qm51SmFlc0ZJWGZL?=
 =?utf-8?B?b1JKVVpQQkRTR1BJazR3TCtyL0gxQUpmVWZnNVRrckFRQkZXQmd0ekxhK2cy?=
 =?utf-8?B?SmdoeTRJYVNHVFd1c1FtRGhtZ0ZHckk1SVhoc3IrdEZrcEh1MmJLM1lJUVo5?=
 =?utf-8?B?Q1BBWWxDUDN0aThESktCSU4rUktpaEdSaEhFZ2huS1dJaU92MTFlbEVnTFAv?=
 =?utf-8?B?VHoyMG5DbGVFOGRnZzdGa3RzaVQyU09RVk8wd2VWanNOb29NYk51MHlpMlpx?=
 =?utf-8?B?TWs2M2tDUitMZ251NzZheEpwblkxVFlKOGswbm5RRXdmbW1QWE12Yit6bWE1?=
 =?utf-8?B?TnFmcTROdVV3eXM3cWltanlCQ1o4cG1mNnVKbjFHZHFjOVBxVWlyUTdKVGZO?=
 =?utf-8?B?cVRWakVtcnkvWGFtYWNRUFlLQ3lvOW1kUDZ5dTNRZDNpaDJMOGlxZ3ZyY2Zr?=
 =?utf-8?B?S3FldGRybUo3VXpPZm5XZ0RmODNNTnFNeWpCUkNzNjcycW0rYVl5V0lSMUlr?=
 =?utf-8?B?YmZEV0dFdGJKYXFwTVVnNk1LYWo0RGd2MHB6NGhLUDRlY3FJdTJFUmtDcWRY?=
 =?utf-8?B?OW9pdS9TaDhTSjhuSytmdkQrMjR6UEdCUlgyZjRpUG9BSGI2SVlleXVnM1h4?=
 =?utf-8?B?TkpyZEd2b1JoSUl5M0pxamxqdTlaWDJGY3FZYlQ2QXBjSGdDVjR3dmYzU1Rj?=
 =?utf-8?B?dC9FWVJ3aFQwdndIYnZ1Y3Nrek1xQm1mZFg5c2RYaWwyVG13S0hiQ2xLMHgw?=
 =?utf-8?B?QU96OXlUV1piTTZISi9UVG80TVJyYytBKzlBSS9nRXRXamMrcTNrWkoxQVV2?=
 =?utf-8?B?aC9ub21mODRIb0FOMnRjK2s1ZVRNc0UvRUlQWmFiMFVpTHdRMG8yWE1panRC?=
 =?utf-8?B?VDRqcUtFYWFnNnZsUy9VaWxFYy9IQ3UrNUdoeE9hUW1OQUZkcnlvMlFyVTUz?=
 =?utf-8?B?L1VJTzBLb3RleTZncTFDUXE2OG5vMXl3dzRHa2VYUzRsaUJubzYrWjJKTWNp?=
 =?utf-8?B?WmdnaUJhOC96dm5VcEtyTHFDRE1LS3kwV1VyaGJEM0ZYeFZTUFJyMmUrdlds?=
 =?utf-8?B?dmdtWm1HMDliaHpvZElSejJqTmNvWEZnUTRNejRaOElxOWFZMlhQR3pMYkRo?=
 =?utf-8?B?TytGQWpkTk9sYThpOTZ5aXRjSUY3T0Z2UTBMb0lBVHllL0dlWlFzbHo0VlJT?=
 =?utf-8?B?a3NlS3BkOFU0U1YwdTNhc1N1Z0k0OUQ5UTVQbzBvTldmQUJkOEJvSmJpT0NH?=
 =?utf-8?B?dXB5aGtFVENYZEJBajRXM09SeHFMRmxqZytXTkpnMUJaMUdKNCtjc1Z3d2Rz?=
 =?utf-8?B?NGRoc2hPbjZXSXo3Qk54YzZOSjhPR3IzbktQU0pjQi9lRmlxWDZaQy84SU84?=
 =?utf-8?B?QWdzZzh3dEhpQ0Z3L3RBV1hiWGR2VWd6eDJLTzRjTndxbThNMTlLT3BPdTJw?=
 =?utf-8?B?OHcvNUNCMkt5eUtmT1NRelRQNHdXcEUzcU5EVkExTlBHUk5QZ0VXeFJxZ2R6?=
 =?utf-8?B?UzIwZ0ZaUU1TbS81anVWVk5KOXB1MkFMUVhqbzZBZ01vWjhScXRoNlEvM0l5?=
 =?utf-8?B?YUcrSHJUdXFIL1ZqTmJSNTNtaEplcGF2Z0RHTHl5WnlQcmtwcXI2aWdZTzFZ?=
 =?utf-8?B?R0ZUcVFNTDNobGdEU1lTbThkUitobVV6blk1WXp0bitQSzd1YjFFeE44WG1Z?=
 =?utf-8?Q?qcy6UrOLmwIdRZQPdwUPiAF9M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a057b42-4d3e-46e2-a3e1-08dd26dd2a36
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:15:49.5526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 037cqaYX6lrRruUNEz7qXHqPSkrDbyK6Dt0fVNXUp1BYwzW6EiUo/aSAYpeURU39MuecTrPOjL+EXWPjkqZtVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-nxp-bbnsm.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/rtc/rtc-nxp-bbnsm.c b/drivers/rtc/rtc-nxp-bbnsm.c
index fa3b0328c7a255ff8a902a58d61a4b0e59eac493..d4fc9dc583d317d4852b7d897a6c45cfff6961a2 100644
--- a/drivers/rtc/rtc-nxp-bbnsm.c
+++ b/drivers/rtc/rtc-nxp-bbnsm.c
@@ -189,36 +189,26 @@ static int bbnsm_rtc_probe(struct platform_device *pdev)
 	/* clear all the pending events */
 	regmap_write(bbnsm->regmap, BBNSM_EVENTS, 0x7A);
 
-	device_init_wakeup(&pdev->dev, true);
-	dev_pm_set_wake_irq(&pdev->dev, bbnsm->irq);
+	ret = devm_device_init_wakeup(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to init wakeup, %d\n", ret);
+
+	ret = devm_pm_set_wake_irq(&pdev->dev, bbnsm->irq);
+	if (ret)
+		dev_err(&pdev->dev, "failed to set wake irq, %d\n", ret);
 
 	ret = devm_request_irq(&pdev->dev, bbnsm->irq, bbnsm_rtc_irq_handler,
 			       IRQF_SHARED, "rtc alarm", &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request irq %d: %d\n",
 			bbnsm->irq, ret);
-		goto err;
+		return ret;
 	}
 
 	bbnsm->rtc->ops = &bbnsm_rtc_ops;
 	bbnsm->rtc->range_max = U32_MAX;
 
-	ret = devm_rtc_register_device(bbnsm->rtc);
-	if (ret)
-		goto err;
-
-	return 0;
-
-err:
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
-	return ret;
-}
-
-static void bbnsm_rtc_remove(struct platform_device *pdev)
-{
-	dev_pm_clear_wake_irq(&pdev->dev);
-	device_init_wakeup(&pdev->dev, false);
+	return devm_rtc_register_device(bbnsm->rtc);
 }
 
 static const struct of_device_id bbnsm_dt_ids[] = {
@@ -233,7 +223,6 @@ static struct platform_driver bbnsm_rtc_driver = {
 		.of_match_table = bbnsm_dt_ids,
 	},
 	.probe = bbnsm_rtc_probe,
-	.remove = bbnsm_rtc_remove,
 };
 module_platform_driver(bbnsm_rtc_driver);
 

-- 
2.37.1


