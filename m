Return-Path: <linux-pm+bounces-19798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C259FD8BC
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 02:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9AA416639C
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2024 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A16E154C08;
	Sat, 28 Dec 2024 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KqEwJo7Y"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FD153814;
	Sat, 28 Dec 2024 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735348584; cv=fail; b=lxn1yQwRrv+9m1e53b+/pBZOll2eOh1vnxCkg/PZyZyuuQPTPZKF1HSOxpSghvr3/+74iL/2Cc7HSn1oYCW7KIusvjbs9G4tJo8BlaRNnLM5EI4HV33DIuDlPItH5Gg1a4GCMgn4oU3RbhZtUqG74bLqDYVFDuBEe3/X3VWZMZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735348584; c=relaxed/simple;
	bh=SnFy90xLWjBgBtav8pLuycb02r6OH0zBP7HYMzw30Fw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gbOwJtRK8NIRl4O+FtneKTeN+4T1HFJKdov8yEfSYOa4SrHeXQ3VkpPBNVsNa5NnlvOZEqS/p3yVLYq0WDtHNK2IjE5qQBrM7hhBxXwU9wS9oTsN1ggYzMoLjSWFbnkvv+16a5LuGymA/sJUChrDYJezgssaetgXNc+0UH8Pq/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KqEwJo7Y; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icYCs2ZqekGd+37C3M70wSGEHi/HMxj7N47k06vMhgqNf3RLegI28GAMzILY36lrkRwRwHGOVm1xYxRMWhfi1RK7sOrE7auzvXlviX08nkVSiSJGzW6Epc3Qi8hQAJZ9Ww+l9jyg3t6fgxh3yesIl/f5l/PvT9LJ+H/ramAsd2PFqZzNFYNWMvYvY/7EwlvNPNjqAgr5sJTLNTLwGZ7y2jPITWGV7olA+RWg94m42NUxfpw3jED6+Y7PI814YBt+tujJKWs0dIzvXyjZQpInzbOmBoQZR4fWIhcM3i8pJ4TD3rc4u58SADmRVezauXlDzNPSp+c8OE1oTzefoMgrIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SwP/Z30a82zAkoSfiP4uYDFRLsAZY6IC2N1v3ZTRi6g=;
 b=stm+2Gd5h+s0NxVf6Bc4aYom35PzbsbFxb9TBJT68vkguGCNVjpus5+XpcW4XaPfN5e8lLCupYocEaJvGAX0NklDzEfDiCQZNP+36nu1eoK6qvLjDJyzovcEmO37kkI04kpLhVDgKtKd9ylq8Ax6A+xn7a8OkdrywB/cxpUCuEb8zrl35Qx9lkqlbPW7rPHFx1toFCQjuYhPyNwM/zfqXkepZ/driT17ssDEFuigPsjZ78V9U4S9FZYEg8M7oy4tpoKbgEyT0Gc6hjDQHLwANiDKNQaeaAaZYnaCMzWN/7quyvIZybN1JDj2ppJ/Qyz0HgP3dssRiqnlHxwUmJHEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwP/Z30a82zAkoSfiP4uYDFRLsAZY6IC2N1v3ZTRi6g=;
 b=KqEwJo7Yq93VGM33epmbmAouJdXGLda3Q6Sdt0z+hOHEeDX+ctzRAmeVQpWaHQH47WW+mCBLXpEfEZz6uroSsY6C50yRHReawvsjUyZcoxgS8+Gy0MtA2OE7ae9AQ4xjD6cTbntH/DbnsSHHhOxOHFqkzbr7lx/xNWoFNxjmMa8DQ68FjlneXWBefp9I+DaynJqlHiInE/Jq9YcWjmgVOtqFO79vJMbe7Y5r2isr5DLLd4Xse3q0UcxxaMPTRTIuofwp0mDHyF6jlq+E1HQA4ZirwNKcjj9dy/1mdDKnmdYN/gXx8pug2qDPOMmJhmWVvb0zcRgYEmoBHigKzjDTCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:16:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:16:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 28 Dec 2024 09:14:48 +0800
Subject: [PATCH 12/12] rtc: pl031: Use resource managed API to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241228-wake_irq-v1-12-09cfca77cd47@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735348488; l=1402;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=4BMfK6zSQF5qiBDmk7U70xZY4AnsGczgpoZ/YOkhF9U=;
 b=pUt4U8/DoSsmmA+YwURboasmkRyxZrbgsS72GSgchx8AvlavLmQcbowWHUf60rQ6f87O4Xu1H
 zZb3y56hfH4CqUdatq1mfS0i5ZTetyxBOQORYjJzuxq6HS9oK+jnXae
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
X-MS-Office365-Filtering-Correlation-Id: 6455ec2c-8348-423e-b75b-08dd26dd39d5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkxpaElxRlo5dk1sdW9nUHd5YWczclN2TitMcUMxVjBFNzFnNXN4SldicDUw?=
 =?utf-8?B?b0Fyek05TkhEbHRHeXpBenJybFRNd3g4d1ZCMlBqT3k2YmVZempubEpFVDg5?=
 =?utf-8?B?dHZjMHVGN01OVDRoQnJORlZHTTRGZEZhdjBhWlI4aVJqTm13NEh1SVlTRTV4?=
 =?utf-8?B?c0Y2RDZlOXU2NnM5aHg3TEhQSlJGVGhSWWFXdmo3SDJaQXRnVTU1RVhOcXg2?=
 =?utf-8?B?LzVXRlhHWk13ZDRpektydUJreG1TMzY1QjkvdUFpWEVBVlVSNHNobTRFeHA5?=
 =?utf-8?B?dDhuSTE2SS8zUWs1L0JHdnFSLzlMK3FkY1BvVHhWT3BQWEh6L3BRSnBFOU13?=
 =?utf-8?B?Zm96KzFiYlRER3NQNm1LaVhVT1g4aGhYTnhSREpYMHpJcVp5b2d6YWZoL0tq?=
 =?utf-8?B?TWZ6NzVVRWN0bFRiZ3ppT2FKNTRwZUN3L2hiL1NNM2pDMUpST2MvTWQvR3E1?=
 =?utf-8?B?QWVhelRTYUR6cE8xRmd2YUh1Ty9UNFZCQVVBN3psSTJRZ3E2YUlFSjZibkJ2?=
 =?utf-8?B?UzdteWk5TmFoUi9Qd3pRVnBWQ1R2aFliZTFRK3BCOTR6OC83ZEtOa0xLYlI1?=
 =?utf-8?B?YVFDNG4rUUpheWZxZjlEUjIzbW1JTXhiQ2UraFdjWGRTellid3d1Wm05VWpQ?=
 =?utf-8?B?Q1N0ZlJFSERkUDl1RHBiamU1aEJEMFNLYW5TUG5aT3cyU0VVaHV0VFpvOTRY?=
 =?utf-8?B?TnBsZW9ZT0pHZmFhc3YwaUc5R08yMHJqb1d2b25HZjRKR251VDVocGNjNW1a?=
 =?utf-8?B?TmxoOC9SUXdscklsbXRDMFplQlRmWUcxWDVuaEE0TWlFdDdvN0FLdHZhekty?=
 =?utf-8?B?S2dzTE5pR1lJQjZaUUZYekxFUzhzblNNWGY2ZTYzNS9PNXpjNWxScnlkajl3?=
 =?utf-8?B?UGY4WVQxNk5ldWJMMi9PZEhWSktDcUgrRC9OWWM4SklOS25LazF2ZXBFU0Zq?=
 =?utf-8?B?VC92bzMwSmpUMk9EWTN3SE1TS1U4U1hoSGFqck53YWFDeGV3dGt0aDJJb01Y?=
 =?utf-8?B?VnJlWXJ5bHQxRGl1Z0w0Nzc2UVo3ODc3YnA5RVFPdURqeXJDRzJNWmpqQ21a?=
 =?utf-8?B?Y1JaRUtnTHFyWmRtZTFPUy9aQkNkdGJJRy8vL3FVM1JnYW52RTBzS2Z6aWVn?=
 =?utf-8?B?T3Z3N0RRNVRCNXNGT3ZmWkFGUEx2ekFwNW5KdDdnVTg0L1lOV0ZGcVo5dWdG?=
 =?utf-8?B?M2F4UE50VXNERGlsQ3VwNThWSVdtZDdlMUZ2ejBubFJlWnZRQ0g0amVxMnBk?=
 =?utf-8?B?amFweTVvRGMvN3VaYW1tRkJ5b0d3NE5zZkc4enpxQUtBWTEvaG16SWVPMmtR?=
 =?utf-8?B?OStXY3BVdExKdll2azY3UUpIVHhFaTJaNnBmVm1hamUyNVlJakdxTkFtdmll?=
 =?utf-8?B?V2dWRFZ5ZGJ5TGU5b1o4TkV6SjVDYkl2ZWxhcVlzdjZ0eExOTVRUVmNkWE5C?=
 =?utf-8?B?WHpST1ZMUDQ4a04zSE5ORGYxNU41T2VCOUdDejBVZjlCbndyUjlXb2NXemVw?=
 =?utf-8?B?YVJ3Y0ZxNVF5VDJxQ0dFQjhDUzNtRnhMMGJTaHJraHlqLzFpUi8yZy9FUW15?=
 =?utf-8?B?cmkrWEZvdFkrKy9ZdWRrN1V4Y3hGaHkxN05DZ21wamk2ME85cEQ1eEp5ZFpm?=
 =?utf-8?B?VTROMG9kT0FpV3NHNnV6REtabDlzbUJrQWVMbHA0RURKd3hvME44L1FVWUZP?=
 =?utf-8?B?aVF2Mm9EeWtPR1BIZkFORTJnNU5xcHlzUTJFUUk3R0dhSWptOERSaitNZDBI?=
 =?utf-8?B?eGdHZnh1emI5ekNxdVZzL2pnMWd5dGpuVEREd2Fnck9XeHRNOC9XOGVaamlT?=
 =?utf-8?B?RUp6eXV3NnhNT0xBMU5yREFNMkhNZlRGdXFIWHMvMkxzVHRGbHkwQm5hUWdM?=
 =?utf-8?B?VlRXNUx3eTVhNFl2TUhVNmo1aUx0MXVGTWpMSDB6aGxpczFpcC9LVm9iTkk4?=
 =?utf-8?B?ZnRRakxPd0pQdGJxMkRubUZ5V29hQTlXeVVHMGw2NnNXZ2tIZkN4cXoxV2Nv?=
 =?utf-8?B?NFBqT201ZXFRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkM2b1J0WktLQXJiM09ydjJkS1RiZEd4bGh5TWtCTGVFU3lzV2dldmRIN2NG?=
 =?utf-8?B?NE5zbTNXMFFVdVR0aWFyZlQ0WmlWWUpoUnNIVkc0K1g5ak41YXU2S1IyZVFm?=
 =?utf-8?B?UldrR3VMUmY2Tjd3cEJLZFFyWGVtcjlPOVR2ckU4dzNtNGtvQlA4Mk9hQUtN?=
 =?utf-8?B?SFdOa3VTV3Rsdlk5MEZKR2xPQ04rdzhrL2RqKzJWcStxWWZFc01lSFF1K25n?=
 =?utf-8?B?c3JzcUFLWVcxUCs4RkFQM2dia3d5bHZjSncraEtlci9McFpQeElBdC9zVlht?=
 =?utf-8?B?MVU0VkNibzAxb2pNcGhnbmlNaUdkYm56UHJIcHV0M2ppamhJS3MySWFoT1Ft?=
 =?utf-8?B?R3MvQVUwcGNQYkhhTXZZN250SWNMT0x2a1ZZTWVDTUxoeUpiTWtwbXZ5Ykd2?=
 =?utf-8?B?VmhJbnM1UnNRaXlIbnc5TWYxcnVKbVYzQU1vcnkrWURtVUZxM0REcTh4dVpJ?=
 =?utf-8?B?aE43NEhaM0tubmk1dTducm1TNUduOVYvWGlYbGF6OUFCWFQrdGFxVmlJV1R5?=
 =?utf-8?B?REFBQS9lM0lkalU3WnB0SlhoVG1NZXFhUklYVm1HZUJ6eW1zaWoyd21RN1Uz?=
 =?utf-8?B?Y2wxUEFXMWJJNEwxNkpJUWpiTEwzeGtGd3JJU00yK1RMUzJmRlkwOEJqUS9M?=
 =?utf-8?B?Tk9NN1FlaklIMnJYVHJIL3A1dDBOSm9hWXhRajRBSjJTV3AzTko1MCt6STNJ?=
 =?utf-8?B?N0xlWE5RNmE0OENjOG1xeUljSGxSakQvSkFTZ1YzVUtnWHhFR0kwYjFQU1lz?=
 =?utf-8?B?cWx3SWRhOHowd0gvVjA1bCtFK1llajhyRjI5QWpORGVpbmJMN3Z1K0Exdm9a?=
 =?utf-8?B?d3IvUDBkak00bkUvRHRZc3BaYk1YMThLOEFSWUp3K1hUbnVoVmVBUmJPSW8y?=
 =?utf-8?B?NlFKQzdkb3dsVk9vTHc4NW1qTHp5c29ic2crQzRvT3U5Vm9OWTJsaUl6bmhq?=
 =?utf-8?B?QTlSUnVjK1ZuYWpyMzFpeUhKRzVXY0p4NVV1YlR0KzVFWnRuQnpBekpGS2RF?=
 =?utf-8?B?R01zQUpkUEg0R3ZRV3RXdU00UmIyNHI2M1dJMUMrTU1DUDdNRGZhV1RaWW1S?=
 =?utf-8?B?WkttV3BOcFprKzlsNGdZRVhNNTE2M01TM3pSOFAyUVlXTDNxS3orMGluZnZp?=
 =?utf-8?B?RE5qOEd0bjFoSzlJSk1QampwMjE1a1dnbllES1RJYkwvZlJJRG1SNXFsVjRr?=
 =?utf-8?B?eTVUMmpWUWdjbzQ0K1Focm85aTU0M3hUeXU0RzR2aEN5ZDk3S0Z2QkZ6TjIy?=
 =?utf-8?B?Q1dYbVZENVQxeEdLb3hMRGNERTYwWmhxUFErbG9ScGtMeElmUkluZTkveGtr?=
 =?utf-8?B?RVlkQkxDZE1VaHYzdkZKUGNLYkE4TklWM0NXTmw3dXNOMlZhUmFyU0tFM1Vz?=
 =?utf-8?B?N3djaEd2WmV4QVZLRDBaRHVVOFJGQUVTTDBkV0JUK1N6WVJPa0s5QjZTQ0pS?=
 =?utf-8?B?WHdvMUZPSWRtWXMrT3VQNTVpUWxBOXphSHRVYUpQQW1BbGd3c1pjaVZzYmYz?=
 =?utf-8?B?c2FOMTdHSlhWTHFVaDFCcnU0d0FnamREc2dWdytvMGd4TGN5SURXdGFyOVFu?=
 =?utf-8?B?Y1BHdS95eHZFSFVJR3pEcGREc0pkSUdkaHJwOVJTNnBRRndqT293M2s4Qll4?=
 =?utf-8?B?NFRrdlkySUpEQiszVDRWK0lLNEx3UjAwS0xvVTc1QmoxWTlWQWlSeXB0MU9y?=
 =?utf-8?B?a0FyaDlqQzBkeEVYNkh5bFg2MUhoNiszMGxvV04vbHhBSU84MW54L1ZkOUhB?=
 =?utf-8?B?Z0RJYjZZMlpGemhsdityWE9LNSt1OFdmRS9WTDdYNklzZlVQTlN2ek8zYVFI?=
 =?utf-8?B?aEdGeWdTb3lpY1c2clV0QmN5OER0ckpkai9ETVp4bWIvNU5tUFpBcWZzZlZO?=
 =?utf-8?B?VjFrTGh6dVg3WFJNWmYrUVdhSGd0MU8xOHo2RVIrdTFkLzE5NmZaTlB6V0Nk?=
 =?utf-8?B?Z3ZTVzdFcitFQTZCVC9EWTZRcXZIU1JjSVFMNmJVenhsclhNRVBubWQ0M2ds?=
 =?utf-8?B?RUNEU1AraFF4M2k5bUc5b05zSmhDd1pLbzg2cEtzUTZGaVBpZzRSSEpqZjVC?=
 =?utf-8?B?QXk5V2ZrQlQ0SVUrMk8yd0lCUXkwREUzemc0c2kwK3ZFV1BJZXhTaTRVSk95?=
 =?utf-8?Q?TN56MI5yW3r/hryfPcA1lHOQq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6455ec2c-8348-423e-b75b-08dd26dd39d5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:16:15.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFUTPpyMWHKSNY6jE6x5gXIMv7hUjizTHKJjCWoGhzxl+RBGvoDIzRWrkNYCt++ZS1gV4fMvqstQmEUt+7Zb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140

From: Peng Fan <peng.fan@nxp.com>

Use devm_pm_set_wake_irq and devm_device_init_wakeup to cleanup the
error handling code and 'driver.remove()' hook.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/rtc/rtc-pl031.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index bad6a5d9c6839ca70905e3d46286b9729c1fd435..47bfc5395e5908b7722b98276399120f1ba65af0 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -284,8 +284,6 @@ static void pl031_remove(struct amba_device *adev)
 {
 	struct pl031_local *ldata = dev_get_drvdata(&adev->dev);
 
-	dev_pm_clear_wake_irq(&adev->dev);
-	device_init_wakeup(&adev->dev, false);
 	if (adev->irq[0])
 		free_irq(adev->irq[0], ldata);
 	amba_release_regions(adev);
@@ -350,7 +348,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 		}
 	}
 
-	device_init_wakeup(&adev->dev, true);
+	devm_device_init_wakeup(&adev->dev);
 	ldata->rtc = devm_rtc_allocate_device(&adev->dev);
 	if (IS_ERR(ldata->rtc)) {
 		ret = PTR_ERR(ldata->rtc);
@@ -373,7 +371,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 				  vendor->irqflags, "rtc-pl031", ldata);
 		if (ret)
 			goto out;
-		dev_pm_set_wake_irq(&adev->dev, adev->irq[0]);
+		devm_pm_set_wake_irq(&adev->dev, adev->irq[0]);
 	}
 	return 0;
 

-- 
2.37.1


