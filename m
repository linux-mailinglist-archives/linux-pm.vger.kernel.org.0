Return-Path: <linux-pm+bounces-33598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4BB3F2BE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04041A85D0A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 03:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2E2E1F1C;
	Tue,  2 Sep 2025 03:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gdaw68UE"
X-Original-To: linux-pm@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013069.outbound.protection.outlook.com [52.101.83.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6862E1F08;
	Tue,  2 Sep 2025 03:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784020; cv=fail; b=q74DjPsNLulVqiweY3NIs1BDs3QZQnJVvcC4i+URKZ+ng3E0JFnQnYO12Ez2C12J6BP/8eoq++yqCySk0S+bnZxjdHofIIWU0QekWXtbOXUjQO9QSxbi0KnUQZzjs0CtCzazAgYyeGBOCVQj6WSp6nIFhsAUbl6lMkH5PuybAIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784020; c=relaxed/simple;
	bh=pQa9/7vG2Vug4Y/co3bN9usmSFZ+YlUfivhoLtMuP+w=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZE9kuoTBahAIu/B+VWk0q+hrPsir0FLVztAagZJNKfBKhpsCXlFbXAjl4OZdcC1+BcnJqMEp+Sh37xOj1KyNtIgka9XCyo3iwGoo9S9u2Kn8j2elfG3DXHuYbCQJ73XapiEMWV/7VdkHjBqlVWw3fpfNV+o9MmgjlUGKvkHG220=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gdaw68UE; arc=fail smtp.client-ip=52.101.83.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy1fNAuPH3g+nD3xWnjFvVge0sRnGY35AgxCAjybFP1+LDbJPFlHyFh10aUAlxSqVJLcLuLKn8RisftkLFCxgl6LtXomNuZhTBpVrW7ZxfVe1tGEBMAK2SoWsSGFQqEf2ZAmff8L5IgNXLefepngUYU/C4EhBNZP9VBm5roI+IbHbdFZFLsUBMvmH8396A7vdyEHL+FF5HsI/EoHy5YeBZl9NL3hfdMfG0HhSRu/hVTXbbnBBm2gsXDnU+RkZOB0U0gmNw78Yw4r3QCvpAwyGEkEqUPmAaVJd0cAc4OS83D0Qd4MaiHNqQgeElCo0sluNa7XsGu1+Owv2DAWlrQLhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QWCGOfqd2G0/b+Wx4TsAnNRc6mWSA1JKbjpVZCLx+w=;
 b=f+M+CcUWim6xrbEA1z8H66RtO5lRJh490g4eOSwsDyytb4XJMDgUdD2yXBbHcQCs5UhOqfhFUy0zcOjgUyx8lPs6QPgYkwgg6GPtEyrzKfnmz/xhNvrHMXQweZvxRC1LYE5wGuIVE/OBlxPNOxvN9wxEEOCNjUrVNQ8jbkzRkEUXRyGYw7QxUPklQn7zwmbU11dgjU0ZpalaGxu84FTty3BlOF/z0XwIzWiRCU9BmsPmBAxuYFiEyJ7uwi0IzpbrPtpy6Gqeny7nU2LUSWJ/LHh/OiN5Y11+T3Hza2dKR3Xc9PWLH/F/di+S5RzzXgbiVVkDvcpAyWUXPesfBTuglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QWCGOfqd2G0/b+Wx4TsAnNRc6mWSA1JKbjpVZCLx+w=;
 b=Gdaw68UELLEw65bhFzMKLYrj0SLUsB9pgPYq/w1UH5joO7OQ8ky9dTV3HL+gX2wv8Bl/88+wc0C+WCelLIrNnasNkX1jYOAGRHns4kQFB1xk9vhWblPuQSmNSmNoyDz+cTLN5imGzukgJTPvbHhXgkbwWImENrtBF6jMdDGX5hz6aV1fHz8dq8fmchQ2OPi4CpY9q44WRsZuDPkIT+W1PVItSVb000bB8kPnkZtuDvVBVBnhQRofUnUwndleqXlJX5vnU2nCT2VoRxGO3EQ9zDQWTNPisH86xbquWAVfhMxJcPk/modMePbLCeIZmjIUo5pQcZZWaKm1AawcBdRXHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:33:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 03:33:35 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 02 Sep 2025 11:33:02 +0800
Subject: [PATCH v3 3/4] usb: chipidea: ci_hdrc_imx: Set out of band wakeup
 for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pm-v3-3-ffadbb454cdc@nxp.com>
References: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
In-Reply-To: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756783991; l=2458;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=pQa9/7vG2Vug4Y/co3bN9usmSFZ+YlUfivhoLtMuP+w=;
 b=UT4uU21I5R6Qzbhk+d+xJMRV0ZUxZjv37vYw1rnrZi0sY9f8+pZJlA6F2LEv5jUenECNbsT4A
 1Yj86T0kHZNDpK+QfWmUA0qV17fQf690Ptfrr0QBucwC+5VCoGAfWCM
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: d6304544-390d-4ed2-3a1c-08dde9d17fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUoydXEvakt0Ukp1Wm1jZm9KMXJhVXM0eE14bzAybm5oODAvZU80U0RzVEZY?=
 =?utf-8?B?N0NTZzF2ankrS25jTy84bkk4b2lFeERodysyWkZxRE51QmxYamJXR1V3cUFK?=
 =?utf-8?B?cmkzRytuZjh4dXloQWdzcHNGcHhxM2pSdWlZRWxkdmtrbW5TdEVhSWtIZUxn?=
 =?utf-8?B?Y1NmUVlPcGZLSUh4dmppQy9Tc3pYV1JsNjNUTGcyZ1UydTZ2MWw4RndqQVNX?=
 =?utf-8?B?bGVnWXlvb0tOQ205bmJmdWdsblIwVW54TlR0T1FiSFM5Skw1K2tlL1hmdE1s?=
 =?utf-8?B?dXFhRWdNSjJnczNMQlQ4Ymsrb1l1WEZzMEEvNWw2QXdhMFlSNTJFTUcxQTVN?=
 =?utf-8?B?K2dXc0s2Y00zcU9aenhyTTBmc1lPMEliYUZrc3MwdmI5dUxJU1Fsb3hHeHFW?=
 =?utf-8?B?MU1wZS9rd2NzT1ZqcFp0VVBxT0FHazNXQjVSaFBsU1JTRHZpbzZRbXhPK1RL?=
 =?utf-8?B?MTJtRy96cXpVRkVycHBzdk85czFSTFRLclVMejVLcDMwTEsrNHNvZjMxZjRR?=
 =?utf-8?B?R0RWa1V1Y1BMYmRNR3d2WUFmcWlCdzUvRkduckMvRkplbmJXSVpKQ2Jxam53?=
 =?utf-8?B?SUw1Z3NBQlJFR2hvZzl1MXZBVzN3eW5INzlRdFlOZzJzb2QvOEZmdHR5UFVp?=
 =?utf-8?B?THBZM05NeHlSUlNDT0o2Ylh6VVRnZVdwV0ZXai84TTVtb1BvOG94bWhLOENt?=
 =?utf-8?B?RG5PWWp4VmhlbnJQajFnbE14NkJ5V2hHM2EwNkV0Qkh5UUxhVWUxVjRISXh2?=
 =?utf-8?B?cW9nazBtK0habFpFZUV1ZXh0eEVEL0plWFMrUUs0TEpYZkpwcXJWZ1RIUkRI?=
 =?utf-8?B?cHlkMWUwRlZZR2NUSHFaVGhXMmFoaW11ci9FRGE5Qm1mRVhrUWc3b044SDla?=
 =?utf-8?B?Y3hMb01rTElNOWFkdWVYR2JQbnlhSFhNVVJNbzdpNzd5YkttQ09zUUhEMGV4?=
 =?utf-8?B?Uk8zZzJ5WEVYd3hwVXRlcUFuWVRKbk9NaktONmE3MHlsTC9XUmFuVno5emdo?=
 =?utf-8?B?ckM4SnJ3YWtCZm9Ob3NFK25KVFhub0VZV3R5UGZpZnhDUHdXam9RZkMraHoz?=
 =?utf-8?B?WWpqNnVPSjJiYW5QRjRnemtuYWJ5aHJ4MDh3aldlOThxRFVuWjd1N0ZaVi94?=
 =?utf-8?B?UXJOSlJSVGVZK0Z6VEdQV3hwQk9Db2FVL1duQmxYTjMyOEJUNEI4SGhDRXpQ?=
 =?utf-8?B?ZElGOGkxMThnZk03MVJZdVpEUkJNZkVoNUsxY1JHWDNUaWZJZlAzYXYxRzhn?=
 =?utf-8?B?aGNPcTByL1I3SDY4V2tLODk1a08xZ0JxNnZwUVBuWFFncnExMEpQOEtEdzRE?=
 =?utf-8?B?U3VGQ1lyckQ1NVNvQzc1MVFhYmtDVzBQdGgyT0QzcXRjOCs5K1BVTUFSL0N4?=
 =?utf-8?B?eGNDYTk4ZGNEM0diY3l6YWdpbVVHUUFKR0pWRTZiSmRxZWhPcjFGcENHMUVt?=
 =?utf-8?B?eFBJd01QZHowRHdIMVN0UHBjb2djOXBhNk1qZ2ZlWEVYMDZkcUFCUkZSM0NK?=
 =?utf-8?B?Q1B5NUFyOUQ1ODIvU0NSZXlMb2N6TkNYK2RteDhITGVob25PVjRWSmxXUk5a?=
 =?utf-8?B?MXVtQ1dyMDhmTkF6ek9IT1h3dkdNdUJTNjdkOWh4OXpZR1QrVUE3a3A2Tk9v?=
 =?utf-8?B?ZzE2UGNSb2UxT0NkeDZMTXcraDdJTlhqbHlFdDgvUG9QVEtjRm05ak02TlIw?=
 =?utf-8?B?WDRmUnBYV3I3cjRxcFJpY0sySzZGUTg1eFpYM01PclNQTVBSNUdKR1E4bStO?=
 =?utf-8?B?UXZPU1pVQmYzWTExRTlqK1JxMExEK1lqYTJSMnZHUnROdnJXeGtmNFU0Uzkz?=
 =?utf-8?B?SzJnZ045M1UwQXltVkc1Vm5OUEJmZG14K1pHaDZQTmVWQlh5MFhyZDkreUk1?=
 =?utf-8?B?bE5GSUkwQ3RQd2RDS3ZWSnF2aFhuazRUbEgzcGRNa0h3cmdHMEZWemRyVG51?=
 =?utf-8?B?MkJKTFdaMVJJSXZZdTRabTlPcy9IeWJ5YmY0N1lVaTBNYTFpOHN4QXVJaWdR?=
 =?utf-8?Q?D2Kx/C8hG3+lDXrX8Awp+OAfMKH6hg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHZFNWMxenlEZmtSVGI4SUdkVjJ1dldONXZWZG5paTdhMDg1aklJekt1Uk5I?=
 =?utf-8?B?YW54R0Y3UWg5NStmMHF1YkVHQVJNWlIwVHJjZmNHdU5NR0h6RlF4OHRWQmln?=
 =?utf-8?B?YVFRd3JYdUpvdHFnUkFEak9mWnVBSVVlTEc1U29xM2dHMlhqQnNVWGFFcHdF?=
 =?utf-8?B?K1ZnelVMeG55UkloT2t5ZVVDbExiR3dzbk1KbE1WV3ppaTdtKy8zOUpmdkRy?=
 =?utf-8?B?RUxoNDYyMi94a1B2OUNWSTVKTXkzZHdrL1lZYkhSYjhENE0zY0FValdLb01S?=
 =?utf-8?B?MURBZFc2YVBzci8xYUdyRHY3b1lyTm1FTEc0MXQ3WXowbjMxaTM4R1ZxaXZI?=
 =?utf-8?B?cUhsR2k3MTV0ODhXazQ4NFh4cmhaaVd5YTBvTUxHVVgrRUtUNUtSTHpmT3Ft?=
 =?utf-8?B?VURXRmVnb0VJdHE0MkprVU52RmhGWHc3MTQ4RVIwaDZ0L3FPeUpjU29YRHFT?=
 =?utf-8?B?MmQ1SmxyUmRud3EzREl0eDYxdXR4aEFzcE9SRU9TT0ZCWTdOWHVtQytwUjUw?=
 =?utf-8?B?V0EwaXZicXM1ZC9tTWgrQ0xuYmtYMnpSWDJ1REJEdFBvdmlvaXhFNG44SVRq?=
 =?utf-8?B?bE9lUThCaS9SeWo1b2VUOXhzemZTaXBxQWRwMndoV1EzdDNDS2prS1VPSXFw?=
 =?utf-8?B?b2diZ1ZNZU1MYzlJRjB1b1lZRXRlTjlTZWx5N3JzK2hkR1pFSGdibzh0SFJF?=
 =?utf-8?B?VGtpeFBmcmcrcDBmbUpZWkE2dXYwd3U0WlJ3S0g3NzFET2h3UWZhU0tNVVdR?=
 =?utf-8?B?ejd3MGJWWFhGS2w2ay9uMWlYdXdYNzdmNzlSdGdlY2IrYWc3VTRSYkk2dGE5?=
 =?utf-8?B?djI4VjBiRHZMK3FQMllBcks5clp6OGtNdmR3UlFsNC9BK3VPQ0xBUlQ2OTV0?=
 =?utf-8?B?NTFHbTR0M3FHbFFOeVZ1ZGpTUEFEemlhM2cvZzNqa1pnTlg4Vjc4d25DL0ZX?=
 =?utf-8?B?MmUxZVdvSVFNbE1FR2VIUnZmWkdoVU00a0ZGTzdKZ2l5YkdKRXZpK3kzRUtM?=
 =?utf-8?B?QmlPMW5MREE3d0xuaElDNk02VndKZldsd2F2L1grRUJTRHRkUXZsaDV1ZUlx?=
 =?utf-8?B?TENTUEdvL3V3WUk5azlOaU5rMlBtTjVBZTU0QXNxNk0rYWU1dDB2UWNjSkFH?=
 =?utf-8?B?b08yeHlTeTNlWVdURmd4eEhxWld4M09qU3h6MGU2Sk9QelFoaTd4YnZxZnZM?=
 =?utf-8?B?NXlkOGtJbkJsd0pqWUxyK09ZdGJuVEhJeTJZQUhudktxY0toa3Z2MWxrZ1ZT?=
 =?utf-8?B?RzR2aWRTWnI1d1V3djNNK0wvT1pVQUZOTTlIazk1bVhaSWNOWHhtNkhYdFIx?=
 =?utf-8?B?bnZneVpWZm54Y2VLTFVSR0RHMzQxckxjcTI5QkdQTDNBaWdveUQrSXd0Zkc0?=
 =?utf-8?B?UGpzL1hIdzk3OHdhYUZacG1yS1V5eFhpTWxIVXdaOEpsaERIQ2RNUVJyOWxo?=
 =?utf-8?B?VlkxcmNvbFlFcjdveWRwVWUwWEUzNTZ6VFlXMkRoVmJXWHhFc1ZnU25EcTZv?=
 =?utf-8?B?ZzJoUWh1c1VPRXpZQ0tVVnpXbHBua25RdlVSTkxBRXFqQWNvMC9EZE41aVg4?=
 =?utf-8?B?QzkxNFEySmNPOVdjamNzeVRkUjFOUEFncVIvMFpiZTY1ZTFXaGRNVjBNRXJu?=
 =?utf-8?B?Tzhvb0JLd0w3elBkbUlqUklIMnZIeFUxMDVZaUQ3Z0RmbVEzNGc4UWFwdmNv?=
 =?utf-8?B?ZS9uLzBCM1Q4MWZSYnVVOU9ZZjF3WkM4VnZBKzlUci9yL2d4NzFRaUdKdnJi?=
 =?utf-8?B?QnFQa1c5WFpPQnk3T0loT2tvbUJJVzBtVnYyWW90dVVFbFZsVHdTN0FrNEsz?=
 =?utf-8?B?SDlXWnBLcUx2a3BzWFYvRlBNZHB0YmpoOUVIV0lqYWY2UEM1T2s5RTM0RnUw?=
 =?utf-8?B?NjNQajVwUk9DVkFKdXdSWVVGNnNMWWI2bHB6M3ZGZmZEZVhFSjdCaDh0dTFn?=
 =?utf-8?B?RW50VC9FRTRkS1VQOWVvbW0wRForckZkYVFZVXBMVlVtOFZncGZUY3NBUDlK?=
 =?utf-8?B?cEJ1cXk3dm1VWUlOTDhaNXQ5Z3RiK1VoQTQxVXZIZmVwT0QvbWh1Y2ZnQUxv?=
 =?utf-8?B?bG1Ea0dHNjlUWG5HUi90RzBTay9kc29JSXZQaUVFWERXRHA5U2NvbUovMWtD?=
 =?utf-8?Q?4gSZ809+UNKy9RujFE4t1FL7v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6304544-390d-4ed2-3a1c-08dde9d17fa0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:33:35.6669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyB4Q1tl7bp+O7/yH4mRX56QSqOO0fsXDe4lGoteUiDbyREcTHTk50AIpoY0J/yUORyU0RMynmDCqpw6fHiPjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583

i.MX95 USB2 inside HSIOMIX could still wakeup Linux, even if HSIOMIX
power domain(Digital logic) is off. There is still always on logic
have the wakeup capability which is out band wakeup capbility.

So use device_set_out_band_wakeup for i.MX95 to make sure usb2 could
wakeup system even if HSIOMIX power domain is in off state.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 8 ++++++++
 include/linux/usb/chipidea.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d7c2a1a3c2715967203b98c819fa864e06a00a32..a2b3f673dfc1183a02783bf6ef92f8570c6042cf 100644
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
@@ -570,6 +575,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	device_set_wakeup_capable(dev, true);
 
+	if (pdata.flags & CI_HDRC_OUT_BAND_WAKEUP)
+		device_set_out_band_wakeup(dev, true);
+
 	return 0;
 
 disable_device:
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


