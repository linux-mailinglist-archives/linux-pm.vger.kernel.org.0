Return-Path: <linux-pm+bounces-30002-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033FAF674F
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 03:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B23816C78C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jul 2025 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B0715746F;
	Thu,  3 Jul 2025 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="So9ZvhL2"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010058.outbound.protection.outlook.com [52.101.228.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782383FE7;
	Thu,  3 Jul 2025 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507333; cv=fail; b=UozZtCGn6mVys4i704Kv9h1iUvS+FobdEH6KZN1TQdNcfnT1VdzllebUGCi+T5zuREDfbdtc054Oad0x/+vOCwgf0ic0xUInfEhW0CjvxKFTJIJXKsN+VTBXnzwV78uGjlspNM23e4BFAzKFxpWBWwf7pQ3thDhyTFio9y3KSQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507333; c=relaxed/simple;
	bh=6/CwxlQylZa7AMoCFg3Xcx+mq6weg041uIOulS/tpxU=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=aw3juNpQVhye+ZUh5yQhzR5Xulcp76XyuGYXECFlwqllKVkneMaRq6iCcxtKI9EdfkGpYil3s2x8rng6LeOZDcyYCvbL/oVAEYgURpUgDkwnp3WSuhCVYVeEEI0cECDDiE9YMD2HiUky5NRdLbK2HBYSAtMLeu3AhBr6Qvvm2Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=So9ZvhL2; arc=fail smtp.client-ip=52.101.228.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYequ2s0ILkJjxxKruuNWLtsv8ZUBroB4/uzCokvvmSXq0yaBEFg0IJV7CUS10PhAGuhdGDnms0p2jqqj6rJr1SV1Hhl8e8yJtPwBq/hdWTgNl68Gwmd5Se3YKV/kloKZpBSO2dBDMpdM881owqmjZP/MeOiwYlMX3uZnW8olFp0TUzRG4TF5ljq/5lPNS0zH+v7y69oTlmFEpkd6GVPYpmXc2jXkBYXPZuWTa92NKihMVMpVrw/aMahzsbFnFBm+hTESJwNe2qjVQ9sqraNYOBTah51EY3uKW4zZYb741ECGNf7T4K4dpesfrEsxZW6QURnLvz7DhdW4rvF/lTbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETSF/onwBIvryFD/t6C6hfl4wNNULeeGaw/9K54BRPk=;
 b=S/DbZ+4kHePuIr6nkZRiQMmiJ3jlIQK/RoawsUkVoqzs9bdNKFB6g5gPhOKpR7JjDZEvx0cqPdr4bJMHWzp024b5PrlErD93V6M80dHaWyrceKN20Wa/kyb1auJh0ulIUTCUh4fldgmrW5hKP54a4NYMPsaUyxhvd58LUQnzjfpGDVSQD6zMpSnBr37NwM4YUvSV4TlKk2Ko+4FnrkZDWQEyflf7DiqhlWmy4WNb1UBRZ1fjZClNuBDqQkIdKpH9ol1TpYnXNaZjCHd4mGmSBiFcaoPDm0Xp0y6EM0dOr5W6MW/rT5a+n7XA1yvjKqfmuiepSoAQlnWs4v+WFdPmZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETSF/onwBIvryFD/t6C6hfl4wNNULeeGaw/9K54BRPk=;
 b=So9ZvhL25l81JGA4Zm/eOAei81SpB+joXqovzgA1HCTl6TYBzA49Y1R2ZPUANgEtakzaXbS9FnNtOVAPU/Yb9CKfSYc8XXeSMHgLNJarMx1LRRj8Y8QcCki+tNmLM4MTQHGv+4vR1+1klmwaXulAjlwzJM/UOE8mic+AQFO6JhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OSOPR01MB12299.jpnprd01.prod.outlook.com
 (2603:1096:604:2d9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 01:48:43 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%4]) with mapi id 15.20.8880.021; Thu, 3 Jul 2025
 01:48:43 +0000
Message-ID: <87ldp6cadg.wl-kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 0/3] pmdomain: renesas: sort Kconfig again
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 3 Jul 2025 01:48:43 +0000
X-ClientProxiedBy: TYWPR01CA0010.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OSOPR01MB12299:EE_
X-MS-Office365-Filtering-Correlation-Id: c32a9f58-2020-42cb-888e-08ddb9d3be0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UeCGnVP1j02f/u2nurQ0ye01Z4d7HquAcviq9aeksN86xFI9RBt5ItTl+hSq?=
 =?us-ascii?Q?NicEJ1gsyGMdZ3uMoQLlpg6A0lTTuRWRJETryGalyxjq0OkgVmVerSB2kE1V?=
 =?us-ascii?Q?tlNHYYmoNcsXbVYTKZAaku795LX9Ycy+hdK+fHWK5ZvMvpH5x2T8HOnxhyod?=
 =?us-ascii?Q?ezO7J59d7WDuB8aehLtr0+CeH7hMAA+5YNj+fRYI2+9fLnNi1sQIOAd6OaF+?=
 =?us-ascii?Q?1DGNbLzCjJz7KqtZ65gNwempnMm/BcarnW/wq5oYRaY0W3POC1M7+T0NOCNZ?=
 =?us-ascii?Q?bCRfmWRJXhpc1IrYM2U3uZA2pNJm2vT3/UDgqGFQCtyzuBd68IA3UAoF9n6V?=
 =?us-ascii?Q?ChfRIDuXTPJcixgkr+qotbFtOQfgkgIhgWrLbnnV4iFMV8PXDYHHZCWCvHRz?=
 =?us-ascii?Q?D4WUXQbRK4/ZNApZKrbtZqCCVfWJuyCGJ7wVO/IOSqcGcmAx41A1ePOTADgW?=
 =?us-ascii?Q?qk8e+bUpiaXCJVYT09dU8l9CbxBB6QOxsvtO0nGUSEfISnZlRpgaFD9ZvJlO?=
 =?us-ascii?Q?lcFNH6WiueOBSG6h90E9/iddDNnadO5SwKZS5VwIcjXwIgXGurqe/guuKUmz?=
 =?us-ascii?Q?9kUzZyp/qmm9jptWzfP7T19VPu3QyGxa2BSUxkcm5hezzdZz2oT0NI3YVLhg?=
 =?us-ascii?Q?vtTSTJrSrjWQiiGE1wgWaXmoIr88nwlxjnixohPYYwVUhc6D/xh0GTkpzFT7?=
 =?us-ascii?Q?zy6F8B8ZCdRhsTQPKSlW/SK9lFjEOOffCgYdM9ci22oYr9LiE8nwhTaYLj5O?=
 =?us-ascii?Q?7Vb9O8hWRp56i6LPJSQYdwvtZacjE3YEjhgLlG5zTB+H94UUFwaEsAs29AUt?=
 =?us-ascii?Q?l9WqktqjDLg3RldLLd+FxJc207qcoh/zJliEl9DBLRxGGXMawA7Hhb8O44L6?=
 =?us-ascii?Q?GIoZPjL9gF87Vt9e6wr0rnxO02xYOpeTbkN+821I1mQnGk7E9T8OSR2tXVNl?=
 =?us-ascii?Q?4PGsNswEmQUh/uizzFAmlghXF8RAHAwjDhxFwL/cT5UZLCKDvVOAi1rXTOyX?=
 =?us-ascii?Q?ZNFpsN/D+9FbqNBvhPnW/ghA0LjULmt43V9YzuU9XJaGaRyBH/qgCMoF8sr9?=
 =?us-ascii?Q?NX6hdCDFXjHtE64HnQsFW0c2/gqUg+f/i9LlccIfqYq2Nu4kDu0SOSrOQY85?=
 =?us-ascii?Q?QS/ZR0Nd5J+aEM+WFu92QNMdUwM9iNyEQ0LNyd92K+WNat2hXWjpGf6eZzce?=
 =?us-ascii?Q?aX4MQFK5nMUjvt0hR91Lw6gavLRPem6jRA5n1s5qUtBxsQC2mKn6Av55p5Hn?=
 =?us-ascii?Q?sHJifncl5ZfDvCuFwEk5zToQxAOsm0S0U0uX4Zd1NwsdquCWEfksOGrc16Jn?=
 =?us-ascii?Q?IkFZBmJj+NTmPxDj0AZ6Euut1Y4zXtCGowuYQhxlAUWKf5OKkZJLyIM1Q9YQ?=
 =?us-ascii?Q?RtDiIVG94J37L1KcLy60pHRxw3JjycNN99clVQr7xCiXHdoXl1XfTGO6mlvz?=
 =?us-ascii?Q?tmzDzOwmGsGoTY2Uq/4X5SVbMc4zB8rtlno26DIKDe6/pyKPYjedVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzlRcKsm7MVfsZkNIIWVtXQQ+D3r9y/UamU3DvT1F0u7f8pCHpArbVn9JQZk?=
 =?us-ascii?Q?cr/XI0sE3T1STASxqDEOdrYmVhsjkcID5W7sBcf0F0Z128/4LOCgLg5JiTnf?=
 =?us-ascii?Q?Os0fV0j/5zWCctn1/pyJsDAFGhrbaXeBQMi9CgFAqfIb7+GwtP4fKteMSXrn?=
 =?us-ascii?Q?qgKY4sApscggVUmTmA3WwhtGJAG/km5057i0UnCltjUwH0+bTjCP48vXGWmd?=
 =?us-ascii?Q?FqWsrnJC8ZCQETE5rS9XoQ3qkxjRHqAZB/RTs8XVCuCmqcc0+XEatkT3nzB0?=
 =?us-ascii?Q?JTKYWNZdTW5a/UPdH2hZvvWPZg0iXqeE8QkiP1h8PWIF3PlH7soAr1F72OoK?=
 =?us-ascii?Q?FM63TfNTDvChbhNK22J6L7b0MgxaCIK/63HhSspcHkgnBCGnB+THbObE4DN3?=
 =?us-ascii?Q?ePRBPwm29LH8cihvzgXfdaKxrtWb+jeM4zxXDqlBzXJvjodopxV/nocj3CHH?=
 =?us-ascii?Q?0joVMkJIFVFc8tSLvvEtfibt6mtKw+TDvVbc0chfru8+EBycn+1P28RKDf3b?=
 =?us-ascii?Q?aXtWN2+LjWHvowclDCQsuigA96hBXAHg5R0rN6hzdUHfVYFSGgEq0T83wkkV?=
 =?us-ascii?Q?3DNkj3BAyFGupZekKv1BSlZBq4LgdgXUZPWs1Xwlcaq6a/QRrENrZ2exZDvW?=
 =?us-ascii?Q?LBuk8LkkLFQGxFDhNNvv4OjRqrhHrTrSIdR07l+YVFmc3lYl1oZw7UdLsVg6?=
 =?us-ascii?Q?ifJspSGVHggIoXY12S3dEDVb7CDTmnG53s7pC91fa1VvLYgLV+uU5/zkWf+b?=
 =?us-ascii?Q?DvcSlraJqeYufH0YZk8FDzzhf/hM/DLDlKWzmMQ63hEHiRRSvOHycZQP8xxR?=
 =?us-ascii?Q?mXOyITFwHXQFEyxhQMQVufQQ7kh4EREtl6oXbXaPaGBZne+oFh4nm8oJN3IX?=
 =?us-ascii?Q?DvE0SQX+jPvmWsIEzD/HjUqBWNSCGBkk6smrwVuKqeZ647qVSrN7w95PSlmC?=
 =?us-ascii?Q?dvob7LtIFWEokfPLSeJPJweMTjlJJ5DX1uvJ/RRilOhXrS8ZTEQstwhY6J1Q?=
 =?us-ascii?Q?HBbfxXOhPkNOW+uXHguuERl0wPFEzJDNrfN20eZHAY8gQSUcH6Dmjz5QGL/T?=
 =?us-ascii?Q?htxrF5V+vaubm9A1+Nh2okFINCi+Zv6Uq4M4GVAfZYWmwMYClDj9DbalAh0b?=
 =?us-ascii?Q?ptkBoxHMdUtWfGgB98vk87K8J71dC82lgRXez7EKg2TzHWvVkuTqLe13kxoU?=
 =?us-ascii?Q?YXt45Cul3i0svQpw7A4epG8ZEeP6wk6cQHkFdFZXUyWR/znZky/ubD5f+Vyv?=
 =?us-ascii?Q?dR/rctQ0v5OUTFTNGBI7RDsjkBdVE6nT+61OSSrW8O6PnR2ZsCpHDFJ9kTLM?=
 =?us-ascii?Q?rGmvZLKEArK7NKmh1PcAl1OTgnrwrOLvcrFiaHfy/ChqbOzm/OFqnGrNMdgX?=
 =?us-ascii?Q?/AsvzjiSTeaIZZtvXw3G/O61qy77IhMoAkNLs6ngCbtQ1vaS5GcH97EFhMSl?=
 =?us-ascii?Q?CQDjq1vQNJMOu6N/hbxAaJK+RWzeD3dKLT+3LbzZaaojWiqotbPJNMUIKIO5?=
 =?us-ascii?Q?+kX1tWWwULksLdryxnzYFYtKQNqZfrW0ZIKJwkc/MPxd7U44AAMw8qfdsToL?=
 =?us-ascii?Q?jGKLwNdJ+mjqJLD4+2XHoAZMp9PDjJ/NgRM1UfY6WNPSx8EfyD4UAouSXKdF?=
 =?us-ascii?Q?YkiidloayB/LHJ6v9V/kdDA=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32a9f58-2020-42cb-888e-08ddb9d3be0f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 01:48:43.5963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vn6D/PpXUOfL8TPnAt56gwyVWx1/6LKnaO2FijryUbVqaNvdrinbavK6hF8dMCOH0iXTw32jQi0ykGupybccvH4l71sJSJ4okb60CoHB51t28ZZFhHMmxYm2uOne22Hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12299


Hi Ulf, Geert

Renesas Kconfig is using "SoC chip number" for CONFIG symbol, but is
using "SoC chip name" for menu description. Because of it, it looks
random order when we run "make menuconfig".
    
We have sorted it by "menu description title order" (= SoC chip name),
but it makes confuse, because developer usually checks CONFIG symbols
(= SoC chip number).
    
Let's indicate both "SoC chip number" and "SoC chip name" in description
and sort it again.

v1 -> v2
	- tidyup git-log [2/3]
	- tidyup comment [2/3]
	- separate R8A7791 and R8A7793 [3/3]

Kuninori Morimoto (3):
  pmdomain: renesas: use menu for Renesas
  pmdomain: renesas: sort Renesas Kconfig configs
  pmdomain: renesas: separate R8A7791/R8A7793

 drivers/pmdomain/renesas/Kconfig     | 126 ++++++++++++++-------------
 drivers/pmdomain/renesas/Makefile    |   1 +
 drivers/pmdomain/renesas/rcar-sysc.c |   5 +-
 drivers/soc/renesas/Kconfig          |   2 +-
 4 files changed, 72 insertions(+), 62 deletions(-)

-- 
2.43.0


