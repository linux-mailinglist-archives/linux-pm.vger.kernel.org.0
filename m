Return-Path: <linux-pm+bounces-35134-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10EB8EBFD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B265189246B
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437772F28F9;
	Mon, 22 Sep 2025 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YRhHZvHM"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269442EE263;
	Mon, 22 Sep 2025 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507294; cv=fail; b=irLpvG8+PvVZ7MaPibpj6ARSD8Eu7skOLzYczoAgK8EDyNf7i/uMtpIlpyXpE4pxNec0Pizz6Ae3cv8ZOHdF3JhMq66+raNLx8NqIri+ozOch7OpdwH1rJYVq8BGcnC8Snx+4sBn3UfnMoHY0QLStBT0hqGWZbB+xCEe8gpTCtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507294; c=relaxed/simple;
	bh=tFenkh2DWRPRFh+U8llYlxsWJbKVaGoikrze3QAq7uI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BSoh4/AXVuCRx/VNzBh2ab5uTdQsy9FTWJbG1VlDlFgs41a33Xfb8Ete0CZxl7zF6x9H8dVlm99Ck7AQ+KHpWP3xV0uYn2mdCZOL+xCB4MfX7lalxr9alwrmTRgGYvC006CUbJZIAiKAhod0vGo05Ngs2pcgLKfUm9W10hbsJKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YRhHZvHM; arc=fail smtp.client-ip=52.101.65.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzHD1CRmXUINLnlXvMqtOSmk4M5hBBUinlmX7AzTNJUhvZ8SAfRMogFUMFHaGAKTM/eIbI9MwfJ+sibpy6PjMf7STDIX5GzUESdA/jrhEvbdbgj3t40FufMTbpVZaDvSmeym+2ZV1o3Xn5ctCLOwD/1sHLWA8e7U8B/w6l3c31nQj7X46NQcZesCAxmu5yUhzCbgL9/R2uZhdGubxEw7tTb9fpYRJGgzTegNZVXrxw3XnCBHjeTirjj3y2da4mjjp7nD/Xkj/BMMY0VhLtZLJFMws3f3rhYjc1MGrNCl+7/KyxBeWA5V6ElR1hu/kv4/dMUVq7zDvnuOvVoxtWsHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=budbbIk+wOY4LKgHwBzvWz/sXgCDytqnME2SSU/foFM=;
 b=gLZMYCboPy8KBSexXeBsz3O4GBHKll0KzHqHDoMphEjhfyvxI5Cjk0DhNUP+6q64shkGzeVq4QPzZtz+hLinjoep4TrdHRm22Acp96k6AY/TACJGZR6IazuEjy509djZCaQhFXsZ7Ty6kJv+6EhQVWUNe+IAdRxpDMnUItYdq+ejE2g7LC46Cm+BAXVZBSCG6rkQ2V4WoExU0yTpEkoGNW2ThK8oNX2MB2rb1mKKmAwroRTPyHyrvcSvEZJxZaU0dRQwS/VXeb8ZvfgI24eNwpoA1epkYawq20B8/nOsuS6LSlK67oNH2rJ2yaMu4feTsZEOEMJiXq58dHr4WIKecA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=budbbIk+wOY4LKgHwBzvWz/sXgCDytqnME2SSU/foFM=;
 b=YRhHZvHMNPzYAdTGyLL1aXNsMWQ/myfTHnh36lwkQOaP14lsB5REcHI1lhSWeLlKJxkmWsN042qfBLx/XgJs5NkKefJsv163uQWFaQyyyog4WQDq8cwluw9QxzolIcFrVSOH6NsiaQMHXnh9//zm0SgvXijiH8pJak+X846SJaRG2JXgBIfMd9D68X9Oz9lWPAuoGvmQ7PHk1uPsA/NYCBGLydWEOHzGZfHOtlL61KVKjRmgUiEymJsonAq5yoNFXUbCehCa8dO+Q+PvtJpcWH678VyW8LRLb4BDngsB8A7Q4ASFl9fk0J3Iwzq8oIUTJvDwrZWnAcwVkV36wrmhyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:14:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:14:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:14:12 +0800
Subject: [PATCH 4/5] usb: chipidea: ci_hdrc_imx: Set out of band wakeup for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v1-4-7ed2e98065ad@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507262; l=2706;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tFenkh2DWRPRFh+U8llYlxsWJbKVaGoikrze3QAq7uI=;
 b=AhyW+NEpdCOUym/0uh9n0eRCZiZsoc27gBcqVUevgF0XOxjFLz+j/IsANH99j4OdqgS8I3LZg
 PIbTewPxtuVAtRCAV0qhtOSlSDn9VBeX97+NAc2KWUrOdeose1KjuCJ
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
X-MS-Office365-Filtering-Correlation-Id: 220bece9-200a-444f-091c-08ddf97dcf2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDVLUXQ5ak5kV2dMZUpGSmh5SVB1dUt0bFQ2QjM3TGtrWFhRMXpmYlRwamh1?=
 =?utf-8?B?bWtmUm1LcDNGL0NjZFNqNkcwVnlPTnQ2T0tnb3JBbjF5UTgvQmNIMnZqREdI?=
 =?utf-8?B?TEFBNE9qVGZYQlNjekJDWXpydXM3NU1GWVBydmFaam85UHZtU24zeW5nS09s?=
 =?utf-8?B?YmlXcnY0azFBRmRVV0w1VmluZWVhY2Y2SVlPRWVRLytQZUhvRGZEdnh1S3Jy?=
 =?utf-8?B?SmthWmg0YU50YjNMckFHSUp0VTROOE9QNlhHTysvR3VZZjB6ZlNadktCV1gr?=
 =?utf-8?B?eGllUWw5UUdkOFlzNFNQTTV6eFVqRk9Hdms5REZnRWNhemZYcVcrUGxoR0Uv?=
 =?utf-8?B?ZUNLM01HVVlJZlRIYlpDRFNIL2FGYk5qc3Y4U2JLeHQxNDVtK3JQV3JJMnhx?=
 =?utf-8?B?VTdzT2dsVXpUQVlqa0ZWSUtMcVBhdFp1d1MybU5FYmRDUnhweFdPaVplYjVa?=
 =?utf-8?B?Wno3L0M5Y24rZWhnUW5zNm0zcDV5QTFEZVNpYW9jMlVEa2Z2bVljeWdWTUtF?=
 =?utf-8?B?aUluekpJRmFEb0Nyc2h3TzdpTisrY2Fsc3ZtYW8wT2hvSkNoRTh4NEFiOEw0?=
 =?utf-8?B?Smgzai9hL1RodWZnTWMzWXdkSFlMaFk2QURPcHBqOU9iZTc1ai9hbnJxbE9i?=
 =?utf-8?B?L0VRUTRwSDJicW9HTkVZNi80T2c0VFN1ampUcXpuM1lvditkVEh5L2wvK01V?=
 =?utf-8?B?RDNoM3V3QmkyOGF0ekplTmFSZ2VYbDNNWURVSDVEU2xlcGRkd2RySlVwL3JQ?=
 =?utf-8?B?YVFGaTY1TVd2dHc3OGxPTUFoZHk4WDFNTElIRGlwTXhUUlNuTG9HdjBJNGlG?=
 =?utf-8?B?a3RCbUtCN0lSUi8xdHIrSnI5cWoraFNzK0t1dkZhbkw3TXZ0NUNjRGpiRUUw?=
 =?utf-8?B?ZEwzUXA5cG1RL3RPUXZoT0gwVldQVUZaVEJFZkEzTlFDcWw0N1REMVl1M08z?=
 =?utf-8?B?RzVGdWlPK3JhVEdmeTdvNmtrb083WFFiQjNMZXphNVFRREY2TDFlVnY4b2dv?=
 =?utf-8?B?YjJJR3hEcEVwVi9OdEIrZG03V3hMc0dBbFVYUlZadzY3L2pocVpicGZCbFk2?=
 =?utf-8?B?YTdUUzM1WjdENkZsQ1dYbDJOdnpqZ0dvWXk0N09WK2s4Q2J5d3dBNllFelRv?=
 =?utf-8?B?NlNZUXQybVNDa2JTYnduQUNUeXJBRldOZmNEbFlxU2dtL0MyU0ZmTXJuMkl3?=
 =?utf-8?B?Y0FkQ3diSGdHbnI1MithYzB4S3hJZFlaNjdzNkNqQ2JJeHdPQU9aYkcyd3dJ?=
 =?utf-8?B?OVdHNjB4K1VZSGlEOXBYeitEV011eStNYm1SUzZmc01FcWdJRWZta2Y3SnA1?=
 =?utf-8?B?U1B1T2NsZjAyamFvRW1BcXlwNlIzUVJZK3E3QlBXOWt2U1dMbTlQaXFlUEJ3?=
 =?utf-8?B?dDh1bUVsQlZ1NEl0NFVyM0hsaDJhYnJOU2hSdEl5d3JIc04vN1o5N0dCOExu?=
 =?utf-8?B?QzdjUUJuTjNRS0xhMm1hM1dGRC9TZnVqdWZMOXMvVW5jWHQ4emNOcjh4cUZy?=
 =?utf-8?B?SndvQW51UzNxK2hQUFFLVVpIdXRrbTNIQ004WG9qN21kM0ZtVE9nNUQ5WlJC?=
 =?utf-8?B?ZVFJbnBQSEEvbElweVBUclAwcmlEMDg5eU9oQS9SUUV1Rm5VRzJuVlEvb3dP?=
 =?utf-8?B?RS9RSmNUcEJLVEc0Y3RvU0dudUhQK2g5cEtEUUVsbnJUczFtYWgrdk5Wa1Yx?=
 =?utf-8?B?NTV3SHAxOFdiaHQxZ0tGWTFSbUdTc1hVQ1JGSVc3eTVBN2ZaR1A1V2ZjUFlM?=
 =?utf-8?B?cUdtSEMrR0dNNzdFSU9oRUU1ZVBaMDY3VXdLRWJOMlltSU5JYzBKc1JGZTRS?=
 =?utf-8?B?Tmd1djVzb1VvSXFkZDNLOEFFeEVJNFcxV1k4N1o1NlpLSUNBdUlsYzFBZlg3?=
 =?utf-8?B?UGtPaVhmZXQxcUtCalhHM3g5U2E4RHI3VjYrWnJZK3FLMWpZVDdSaUlYK0FI?=
 =?utf-8?B?R0FKeEo4ZW54ZFpjWm5IUWpETCt3SWdVYVVTSkxIMkx1VnJYS2pUbWN1M0hx?=
 =?utf-8?Q?OL1O2Tz1EtEC6+m2qtiPucLHMXhpfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZ2MDlMNkszNTNhMER3Sk1tOUJELzFYeUowVmF6eUI4WUhQYldxK3lZUVBE?=
 =?utf-8?B?aDVmY0NtOXJWSWJKb2dmMFhRYTZJSUdZMFg2bXQ0Q09wYU9KUUg4ZkZqZHZh?=
 =?utf-8?B?YTQxQWJmb3JRT0NvVzRqNDZzelVCeHh6TUxKaUMzT0hIWW0rVFg2NnE2WDZh?=
 =?utf-8?B?bXdxUVdQMm5UcW1oemtMaHR1NHFpUFVwQklJdHovR0YvSjZ5RTdKbFI5UXZH?=
 =?utf-8?B?bWpiREhzMEZzY0dmcEJkVVNmU3NXekJKakFhUWNkakRUS1c2c1ZBOC9XcWRp?=
 =?utf-8?B?am1kZnAvRHFuUC9FTGJnOXFKZE1lV2E1OURQN2dyb2l3WFhqWEtXU1BtYlRn?=
 =?utf-8?B?czc2OUlxOVhLYmFtdGtEcnR5ZUVzUjVVS1RlQTU1My84ZFRZNTBkV25oTm1X?=
 =?utf-8?B?UUV0OXlwUHIxSXVrb0ZJYlBZSnQyTENsU1ZscnB5UWdXTzlxWUIxc2M2dHZv?=
 =?utf-8?B?cUpsclU4b1pIVGc2YlNDNFdSUHBSVzJZSC9SWmtjNnRxQnErdncvbEQxNTM0?=
 =?utf-8?B?bFp4b2I3eStrUWNnS25IYS9xeGgyZXlIMUJISWlTeUdzbDQwOUFUVlBWRmdZ?=
 =?utf-8?B?b3JXZUtlL2h2Um9RVkNNNWVnYWkvY0NCakQvblAySWRlWUtjR2hmMkVZSFZH?=
 =?utf-8?B?S1RZa2k4WXNXZHVHYU03T3ZMeGdRbkd0Z05ET21XWnViZmozclk5K0VmN1ZG?=
 =?utf-8?B?WlZXMG9VZkVQRGxQY3ZweVdqdjIya25CWEpKOEVMWmo3eHI3YWoyMHNCVHFr?=
 =?utf-8?B?RzAvNHdIZURsZjlKYjdtWmxXTDRKWkdYWUtWWHJlOURINitRV1VBVjZZU1JT?=
 =?utf-8?B?cXJpa0pQNlRJVHp5NEJYRmFJV0MybUMwY2t0MUNCUk5jSEdFejE2RDhnOEhV?=
 =?utf-8?B?YVEzZEJnWER3WnlkRWZ3TFZ1aUxaS2Q5cGxEbEI4L2hnTEJwbWJDTzgvczdm?=
 =?utf-8?B?UE9CSEF1SHRrRkkwTWZzWUFBNXo0MW4xamlPNy9tYzVmWng2RndIQmdHNkk1?=
 =?utf-8?B?ZG8yNGpBUlRhQzNkLzdrTmRBVDl5SzhXa0FQNDREREFsRi84bnNITUxzekhJ?=
 =?utf-8?B?RkNBajJzOXM0ZUNpbkIzM2hxYUhxam9YcXM2cnVPMENUd1ZPa0hTVEZtS2lq?=
 =?utf-8?B?RDFGNWMzaDlKQmFaSDdIeExqTVAyUjRVeUwxTUtabzFTMXV2QVdhYlVBUXRJ?=
 =?utf-8?B?RkxxZE1XMno0azZRWWY4YW1xZ3JiY2hrb1EyU2lFMjZ2WjFyNkNKQnJjUmNG?=
 =?utf-8?B?VnRJZWtUaFJIazFQQTlzSHl2blpNdzM3SU83M2YzU1lLNWJPU2lkVDltNWM3?=
 =?utf-8?B?aDVISHFNQkNaOFY5WVBFUGIvMjc3a0dzWUMwcFF4c3dNNzZtK1V4K080Z0tZ?=
 =?utf-8?B?N245bnB3YWVUM0UrV3p3S0tJS2RpMXhaK0JLK2pNQWdSYVpQZnlndVRybWp2?=
 =?utf-8?B?T1pGcUUrOStKWGpxa1k1Kzg1Z0RhNi92bm5kUXphcjNrTjJRNVJadEk5YzFo?=
 =?utf-8?B?bzIzVjI5ZThaeGYvTVRCYXJnWGRyT1AxVFI5QUpDSXVMMEZjSk9rT0p6a0xv?=
 =?utf-8?B?U0MzeXNDV1pnZjEyUHhWNHdnTzJPeU5jTkNXdytnamREdDJKejl3YmU0eFEy?=
 =?utf-8?B?SGFyeUhkaUFxUHpFK3BiZG8ySGd4TmZ0TlRtTEYvUDQzdlY0b1d2d05kRnNJ?=
 =?utf-8?B?dE5rT2VKZmRTQ0NGZUJQc1UxRytzWVJhQzBkVW1ycWVsN3I0bTFCZVFGSGVE?=
 =?utf-8?B?OWt1L1pvdURWZkdwRENlbTRrLzA1cnZadXdLeVQ2OW9zSVhxUm5zQ2Z3aWFw?=
 =?utf-8?B?Z1hWRGZaVllHTitvczZkN1poaDlDUnFRcnRIN0oyOThWVktpVTlpZzVCTnlj?=
 =?utf-8?B?dGRCQndPSmhQYUF4cVFxRk1UTWYxMk1vSGdpekpaSXQ1U2V1RVprZ2d5L2o0?=
 =?utf-8?B?VGVPNlBpSUc2VVh3Y1FzZUxZNDROWDJBeEEyOUJWL0liMEJuN2FhNkxNaFdo?=
 =?utf-8?B?U0tSeEVwMC9aUFZPeHErRzZZUTM0ZWhaelFNcUE1U0lOLyt4cFgyN0hHQ3Zk?=
 =?utf-8?B?dDA4amZZL3RKeWo2TzFhd3h1aTlCYUdneVBjR0gwOTVpcXdtZjJZY1lZT2sx?=
 =?utf-8?Q?gU5OYp6LNxEVrKmOQo4TkFg0L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220bece9-200a-444f-091c-08ddf97dcf2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:14:49.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ti3b0KPR6kXgEUF1KkNsQ6jXLENZC892wLLe3uv9PN8e0+kKtyG+pRpo7fkmxz+DJ37Gp8uFKCkCCbEAAFZhYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
wakeup system even if HSIOMIX power domain is in off state.

Tested-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Xu Yang <xu.yang_2@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 11 ++++++++++-
 include/linux/usb/chipidea.h       |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d7c2a1a3c2715967203b98c819fa864e06a00a32..d4ee9e16332fe8b506711e4739c9008f73a377bf 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -79,6 +79,10 @@ static const struct ci_hdrc_imx_platform_flag imx8ulp_usb_data = {
 		CI_HDRC_HAS_PORTSC_PEC_MISSED,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx95_usb_data = {
+	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM | CI_HDRC_OUT_BAND_WAKEUP,
+};
+
 static const struct ci_hdrc_imx_platform_flag s32g_usb_data = {
 	.flags = CI_HDRC_DISABLE_HOST_STREAMING,
 };
@@ -94,6 +98,7 @@ static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-usb", .data = &imx7d_usb_data},
 	{ .compatible = "fsl,imx7ulp-usb", .data = &imx7ulp_usb_data},
 	{ .compatible = "fsl,imx8ulp-usb", .data = &imx8ulp_usb_data},
+	{ .compatible = "fsl,imx95-usb", .data = &imx95_usb_data},
 	{ .compatible = "nxp,s32g2-usb", .data = &s32g_usb_data},
 	{ /* sentinel */ }
 };
@@ -704,9 +709,13 @@ static int ci_hdrc_imx_suspend(struct device *dev)
 
 	pinctrl_pm_select_sleep_state(dev);
 
-	if (data->wakeup_irq > 0 && device_may_wakeup(dev))
+	if (data->wakeup_irq > 0 && device_may_wakeup(dev)) {
 		enable_irq_wake(data->wakeup_irq);
 
+		if (data->plat_data->flags & CI_HDRC_OUT_BAND_WAKEUP)
+			device_set_out_band_wakeup(dev);
+	}
+
 	return ret;
 }
 
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index e17ebeee24e3ecc4b1c2d153d9ea9b656b5a3d35..c6451191d2de68607a9380482701d11f949d0ff7 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -66,6 +66,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
 #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
 #define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
+#define	CI_HDRC_OUT_BAND_WAKEUP		BIT(20)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1

-- 
2.37.1


