Return-Path: <linux-pm+bounces-35132-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C69AB8EBEB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70BC8176705
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A12F0687;
	Mon, 22 Sep 2025 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jgd0jWEe"
X-Original-To: linux-pm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A792F0665;
	Mon, 22 Sep 2025 02:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507284; cv=fail; b=oX37jYvleJBPdQe7j8rKawZ8RD1OGzAz4gU5XD169l6ool1/ixhVbjTKwstN3GmgVl3nC7BqMrX4VOdd9vaRQLyKii1WO+oP9GMuHQinZEYXVpVIGf1KEP7WP4cVdjWJCVXcIl6+dFBaRk0Yt6QBH5Hgw5es4LifzkLw6/KRZFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507284; c=relaxed/simple;
	bh=oT9Gp2ORJVRd6IFtnNDXwCgxzgI+pxdl81Trau+N2sM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NdH34/NgqS3jtwAy40qM8JIdtY3DXl6kY2KivCuSI/C0QSyZa6ogQTge+PHJPlPEypGNltheSJYvh6hJhoyEVTzV/LHiF4YFn3XckKfoB+TazbwOPORvr80Dw57/97ArrwVWBe37WdDqWuDidyDzFkV1sgPW2wSJTs7/XHxYpWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jgd0jWEe; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeYK6/lDLxSU1zlhLt9RNzwp5wwnknbMG8d2nOycyp9Y9EV6smi7QFUB04f7mMDWAxlQDKoCDmcJkXrd5wgW5KR7ogz5sRZvMNglHQDBNgGuB/JiJA1s55gIsNb7d/yLQ5WgTxwLURrEyDePx9LfVxBJ58kSGn+1cjrpZByZPQ++ziaw51k0GhhwB6pTun56qFtf2UHCje5N7DS7t30sr9XwKeG6EuUIkmI8CDYyd+Ag36sDTQSBvcleuAGvPCB5JgAbau+syAgKcIDTyTV2ZJFshTz+SeiMuA9cwUcnBm4N1lFO7/i8cG/Vbl9N/fa2YlCaCTQbUNypVv7HFSSYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPz1ZBbyXHtcXfw5XSMg63R/KGLZDFT3o47tjZSJ3/I=;
 b=YZZpfJaszstP9aT2G679il4tltyr3FJ0hZJaryrYMAfHnaC7b9P4iGPrLE0Z69gjEHCzneRPoVKFWcXaEsBvl87pG9a8N6NvpQTAqC4Nv73oMkmcPFAAsmxp7RScJjX3Z8Lq5vw0UxPFSHdECau6by5OhsZbBtVt1p1rlCHgdXn0BbWNb5OXoHy0z1qQoxCGbXFJfO3itusOWsMrQPnYKa1QoGsfG8jcWZQBYeTDy5OuToNfxwCwiYE8myDDFyqoFTTp50c53UoupvmOY47XNarD3p+lFvJTro9uyr7xw+Lv8VZ4Xrqkq4c92vWz/Rb4O4K1jAXyJ1a3JTOz+sCIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPz1ZBbyXHtcXfw5XSMg63R/KGLZDFT3o47tjZSJ3/I=;
 b=Jgd0jWEehm10oFMtYka0nTtrfYOJxb12+/QY77/e7k3rmqYVzMQEYjUlh79uNpnoZflmfvGqvb3knDB/wzyKHwsPj3Ui5Kg7ciPDVZqdkgKUJtC6xR/hosiBr6PObptN434ayIeWCtQDwnvk5dZjpoJjx9QN8B/e8RG9R4yys6z+S8/cKP1cirP25S+4gYTHe7Vj33RyibaY5Z2ILI6vrQ/9jtSr85l8+8PAvy7IERx5xj1GiKfPnJ9dN76C3hBIRQ7ttxGEckP2nYgq10XbsGTPVW4cMptHNrC9JFomKo4/Y82GWdAnPlBa/xLWLHE4QeQgmcnAK7Y86vXHdyleJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:14:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:14:39 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:14:10 +0800
Subject: [PATCH 2/5] PM: domains: Allow power-off for out-of-band
 wakeup-capable devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v1-2-7ed2e98065ad@nxp.com>
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
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507262; l=1751;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=oT9Gp2ORJVRd6IFtnNDXwCgxzgI+pxdl81Trau+N2sM=;
 b=diUoLlA6JfyPx8DvVjbPhR89u2CAxUDCjJDEATjXi19zneMw8F+a5K667a1JlKSVKPPUXooBf
 2FvkY8+OEpvA1y1BqGvLKWJk7fRc9LY2EndFIfAFusTP2gcGVALoM87
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
X-MS-Office365-Filtering-Correlation-Id: 66fcfea4-5039-4bbc-3576-08ddf97dc913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmptMGg2a2h1YVBsNSt0N2wzMml6OW8zaCt4ZHpMTVovUEFmY1VzV1lsVzc5?=
 =?utf-8?B?WEpyS01ONUkrVi9nSUpUTEkxZUppYjdTditlS0lML1hTNGF1RG1BMm1LMCs3?=
 =?utf-8?B?UFRYR2VzKy8rUVdsc3ZSUVVVcmFIWmFhSmhIRmdxVWVycjdHTWpMaThZQWdh?=
 =?utf-8?B?eURFZVE3eGRQNmdiZFQ2Y3BRajdBSUd5a3hQam5OY1JOSUR2UXovQlV1WXYx?=
 =?utf-8?B?MTAvbm5DbXRZYjZTOGNzR1NpUGJjQk5iN25RUFYzaW9Xcm8yRGpGTjV4ZTJk?=
 =?utf-8?B?Vi9CVS9GZmxqenUyTndvd21SMS9DWkRuejRhUytUeXNjUmZoeXBjektFelo1?=
 =?utf-8?B?SWVkM01uQk4yWjBDc2c4SERZVFF6SFFhMWVtN09SN0s2cEx1R1puOU41Mk0r?=
 =?utf-8?B?WTB0TFptM0lrODM3eXlPajVySVVjTFNHVHJzZHloL2R6K1VtN3FoTEJ5TE5F?=
 =?utf-8?B?RXVTWkkrKzJzZ1ZRejB3ZUpQQzBORWRTNnUxUU54S3YxR1A4aHVSWUpFbGdO?=
 =?utf-8?B?M0V4dkNUSmtyZmpZSjdwbEx5YXZmcUJRNmI3R2ZVL0hJT0IvSU9ZSXlaNUdW?=
 =?utf-8?B?VnFaKzJZd2MralFrK1JTNm5JZzBrbGRRYXR2THhSYnVEUFB3cUZ6MEhOYm01?=
 =?utf-8?B?dENXM2lwNHowQ3I2Yi81cjlLNTFWOG1MeXg4M0l5d2Y5Z2tFb0tsNXBPYXZr?=
 =?utf-8?B?Slh0ZTNrcGQ3ems3NDVsUkpaUnJuQVpTZnd3bDEwSUZmeEMxZlJmSEcrSUFB?=
 =?utf-8?B?eWpPMlEzdDBadEpFdmovQ0ZWU2c4R3RlVEg5Ny9yMmpQd1NlS2JMK3BtZ29w?=
 =?utf-8?B?cFNqRDZCYWFWYnlsZEc3aVBrT3R1VGJQTHJRU2xYY1dQUWMrUWkvMnh1OXNP?=
 =?utf-8?B?KzRXOWRBTTh0MzFzVnlBNG5wTjQzMGVQV3ZEdmFGbG5mNWZoVkE5eStwUy9W?=
 =?utf-8?B?eURaWis2YjhJbDB4aDArMFF2N2M1RDUxQ01YMWpYNXY5Snl6YXVpcE9zb1Uz?=
 =?utf-8?B?Z21VcTBaSjd3VVZON2tWTG41aGJuRlIvWEc4cHI3VGIzbHcyemhSRk9UbkZN?=
 =?utf-8?B?ZEZEMHYzWXAxZjFrWXlHNU92Y0xaa09wVjVpZXhQYmdOckt6dWFESGp3YmFR?=
 =?utf-8?B?VEpHYWNlVy9xTURXdEg0eFBhdnlxT2VTb0lkWm1yTW1jSzJISVJvL1dLaUNY?=
 =?utf-8?B?enZ0ZXdlMEJBQ0tjblY4WG5mVUp5VDNncTFLRmsxWWs3Y2lsMWxqYjJGOUp2?=
 =?utf-8?B?RlBxSTV3VW9UbjdYRzFiUTdaK0JEV1JxY3pDZFJKWFg0Q0J0bzNrVEdnYmc3?=
 =?utf-8?B?VXRXWUl2RlJlTlJEY1FSUVR6djQ5WDNnUjlCaTZvNmxqQnJVNS96b0NkTlZm?=
 =?utf-8?B?T041Ull5aklnRCtVRC9FbFRLWHEyUWhLU0VNb3V2cnNCeE1zODRHUHk0YWRK?=
 =?utf-8?B?N25MRHRWcjI3SzlENGZ1Y2xQK3lNOGR2NlZRUzlzVEtaVkRxUHlDZVpXTjRp?=
 =?utf-8?B?WWgxNytteTRNT1p0eDFZTlNXVnRtM3ZIMzNkOWlHZGxnUFczQVZpem5nNXFn?=
 =?utf-8?B?cldGMGM4Q01nUm1yMzlTd0FiQmlYTFdtV1IwcUE1TFBIVEVqc3FOd3djVHpq?=
 =?utf-8?B?N01GamFHRUNKaXh3Y1pXR1lzbTlwSDZvejlCNHIwMnMxMHRNYytvTFgvaTRm?=
 =?utf-8?B?YXRndFVnajlXWlNlQ2tUVDhoOVRRUW5JQmRYUi93cjBwYXRvSG8rVjltZXdU?=
 =?utf-8?B?cExNczhjekN0NmdUUFVRWjI4NjhRT09sNjVCWmFCNVY3TDd0QUdsV1BpSUhY?=
 =?utf-8?B?MGIwMGh3UmFDQ1htRkRyczI0eDFvNHFQV0dibjRQM3pwVXBidmxNcXhuWWt1?=
 =?utf-8?B?d3BJUVg0NVpaQWd5MTA3RTU0MHNLY2ZBa2pNdFZrbER1NGJWOU5INnYySWdU?=
 =?utf-8?B?SUZpUWZqWUJyaUx5MG54MVNOZGRvUy9mY0RjNFM0bnlYOWkyY3JDVW5KUzBv?=
 =?utf-8?Q?Cd9Ep4CSX712qPFg3lfPuL9nD9nTWQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTB3WWpuTERXQTBFZ3h0cTJ0NS9JTEgxN2lWeG0wM3BNRmZRaVRicXBmRldp?=
 =?utf-8?B?dElTZ1RKVXJQOVNVbW5oZFNOUDYwOStxbmFCNjRqTUVCVFg5OVBYT1ZTeGpk?=
 =?utf-8?B?TGY5T2RoL2Mydit4QlBvTFFwOWtZb3BQM2xsMmZ5VGFaRDNEdFUyUDJqUGM3?=
 =?utf-8?B?MVBPcHMxV2JJZkdnT0xVVHg1czN4bTFJblhUTE5RZ3QwZmRNb1lOaGhuSTFH?=
 =?utf-8?B?VkJMZkt5UjlWYlM5WUs3TmhxZEMrUno3UUZ4cnhFaDM5ZHpJM0FoV2NFQ1k1?=
 =?utf-8?B?ZC9wbFRoOEpHN3Z5ZG1PVmt5cmIyRzRVVjJ2WUJCTFZRa0VvNnRyR2lEVUlx?=
 =?utf-8?B?ZFVsUGJjbnJxZStoaWY3NVN5RU10Vm5CcUIwM2liTzN3czlmamhZMTJFZ09r?=
 =?utf-8?B?aVlnYlhQems2dFpKZmRGVUpKZjlzNHdZUjI0d2t1YzBPSllYeWxWeUdSSTg3?=
 =?utf-8?B?OXgxZ3k3dy9JWHNZdm5RdzlvblhDU3dLcVdQcTZnVjVkNUFqd3pKS1BhNzhR?=
 =?utf-8?B?MGJaT0ZJaU8yMlFpTmRRc3R0b2JraUUwVEFUK2RaaTU2Z01oVFBGNU5jTWlm?=
 =?utf-8?B?ZnErVVloamRxRWhBeEF6UjM4cEFZdkQzZ1B4dXhISExKQU1TL1V3NGttL1RJ?=
 =?utf-8?B?cGNtSUJ5Sk5meHk1T3l1WVV4aGNMMnRRT0krSUVDQnZQUmNLZDhVbk5WVEtl?=
 =?utf-8?B?RW9UdTJQbzdCMjJGY2ZQMG5xWUlvVXJ2Ni9jUitwMmkzYUc2ZFB2cFJxRFpW?=
 =?utf-8?B?YXV3ZWtyN3l2dTZpd0dwM2w4Z2d6elR3U0FwdG92QmQvSlMvQWtmQ1VDQSsr?=
 =?utf-8?B?OEpjbHdhMkN0S3lqMmh1QUNNOU1Zdzl0eFF0N1F3QU52bmdHc2E5ZkUwOU84?=
 =?utf-8?B?djUwemQ3WGp4S0FZSmZyR2djYkFnbnJjWDhQS1QzZ2dOT2NUMVA1VVNHeGlz?=
 =?utf-8?B?WS9lUFpnemRHc3k5VFozS1l6eHBwVnZLREZkZ3VlazE1TUtwRzhTWW9lcW5O?=
 =?utf-8?B?bU1LaTFrL1EyTi9BYXR3aW53OFMrR2tLckZmR1ZJSmJ6N1FDc29NQi9TUlNw?=
 =?utf-8?B?YndxRG1zaCsySUJ5OVlML29nNW1KWTJTcjlUakxpb2lNdStUdXlkamR1R0lC?=
 =?utf-8?B?amY4d0ZLZW9HVDVEaXg5NFovM2xCd2xEQ21qS2E1eThFUlpJZ3NkYzdIVWpL?=
 =?utf-8?B?Wkh0M2h5dTFsN1d0Zk9peXBRYVdodVNNYzR2RWp2bEF6SjRVTUx1ZnRtbHlT?=
 =?utf-8?B?UURwaHZOL2hjTXY0RmYvSytGOFNYMnhQWmZJdEJ4bGVpdjROMDJITkU4Nk9w?=
 =?utf-8?B?N3p2MUpuSG1aNDlnQng2dnlVdSsxOGQwL3h0aG9DbFQ1Z1ZGRmhkd3Y4SzR6?=
 =?utf-8?B?WTQvWVZqNFFEUHJIc2tUNDBOeWdZK0lpc1FoaktGRlM0c0Rhb3hRd3Exb0JM?=
 =?utf-8?B?M1dsUmlqMG0rdDd4eElNOWxuODVOdFo2TmRiLzJOTmF6aHJPL1Fvc1VEbjRx?=
 =?utf-8?B?M1UveHA0ZFp6eWkzTnQzanZvbFZKQWI4YUVybExlSGszeHZaRDFXT21MUUJF?=
 =?utf-8?B?M2lNbVB1OTc3ekNDVkVFbWNPeVpzYktEdEFxNjJoOFI5N1NsK1kwcE9MMnds?=
 =?utf-8?B?NHR0MG9KNUZsbTkwQzhONkUzNWIxRGFZaTdUb1Z0YWZNY1BYbU9ieEg5WlQz?=
 =?utf-8?B?cVpwYitrUmVQQmpOYlA4ZmdrVFdoZllVdzVad1JqckJNcXRlOW5wOThpMFoz?=
 =?utf-8?B?YVhTYklkbnJidWJESVZ3QXg3OThCSmtCZkI4SHZsOUlEVjJQWlhlNm5zaElF?=
 =?utf-8?B?M1pzSlF3QW9NQnc3NU9rWE5iNXdzdmR0MTBvT29FdlBxMGpsd2NFZm96R1lN?=
 =?utf-8?B?eVduOWc4WXN4Vkl4clBtR2VXYVVDUGZqaFNORjJ4dkJ0U1hid1JDUTUweW1I?=
 =?utf-8?B?R1lEN2h3UXpMODJZVnRRMDZZZmovTXVsWVkyVk1rV1FhbDZaL2lsWWZqTWlu?=
 =?utf-8?B?RE9XUWRlUFpWbldXM09RUWd0NC9ldExiNWJUR3gva0pxZHF5MTRGeC9KL0k0?=
 =?utf-8?B?RWRzUlRoNjJLSEFHSXlkMlJ3dkIzdVZVRkdoZFhlbmZGUHh5K1IxWTNQbFhj?=
 =?utf-8?Q?WdHUvB32t0kpVuzGs3bwc9MRk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fcfea4-5039-4bbc-3576-08ddf97dc913
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:14:39.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/+TsbsfXJ3E5Az3hudIJ5dZLipBvYr4bgG3306TVf7Xz2JdbqxB856Ra8w8xh2fjLyuMxKAqv+gKeizxmE1DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

Currently, if a device is configured as a system wakeup source, the PM
domain core avoids powering off its power domain during system-wide
suspend. However, this can lead to unnecessary power consumption,
especially for devices whose wakeup logic resides in an always-on domain,
i.e., devices with out-of-band wakeup capability.

To address this, add a check for device_out_band_wakeup() in
genpd_finish_suspend(). If the device supports out-of-band wakeup, its
power domain can be safely powered off, just like regular devices without
wakeup enabled. And same check in genpd_finish_resume().

This change improves power efficiency without compromising wakeup
functionality.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce39fcd2f7e77df549626e49a4d5310..4925bc1c441078a8d38600192ee696bf550e80f0 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1545,7 +1545,8 @@ static int genpd_finish_suspend(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_out_band_wakeup(dev))
 		return 0;
 
 	if (genpd->dev_ops.stop && genpd->dev_ops.start &&
@@ -1600,7 +1601,8 @@ static int genpd_finish_resume(struct device *dev,
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd))
+	if (device_awake_path(dev) && genpd_is_active_wakeup(genpd) &&
+	    !device_out_band_wakeup(dev))
 		return resume_noirq(dev);
 
 	genpd_lock(genpd);

-- 
2.37.1


