Return-Path: <linux-pm+bounces-3672-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A3A84EE23
	for <lists+linux-pm@lfdr.de>; Fri,  9 Feb 2024 00:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799CE285287
	for <lists+linux-pm@lfdr.de>; Thu,  8 Feb 2024 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDDE50A70;
	Thu,  8 Feb 2024 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="ZK6nDRjT"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2059.outbound.protection.outlook.com [40.107.113.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AEB4F5EC;
	Thu,  8 Feb 2024 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436720; cv=fail; b=nInejUjntgQHnbGsrwLu/9pMlIlt22Q9AXzShkCQXbTUrXYxMIacWiLfGzhLGoCUu9Vha0XggW74QlElflowGgjnoN8nAubPR2y97t6ryElZPP5k8vO9E2eXUTpqP8O0saV7VUgGUO0ivMEyUnpnyM4w/bcywIDoW61CPvYjQJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436720; c=relaxed/simple;
	bh=lAhWbLd3qyJw/gts2nXnKOe1HE7F8MzGM40QPpcId1E=;
	h=Message-ID:From:To:Subject:Content-Type:Date:MIME-Version; b=oBXoMjdoci+73kaCvzmv/2VQS5EMOprZclXlP7wuBAhl3q/ChobKwdTi2WYiwcgadeMD5dhQRTGUBWG0gDcHWgHMS2b11y+QAPtpQ5NMjPrMOTzTJqdMttp3amkkSlYGbmmc8wfRRxnm/Mtyu32aUGfhbHgh/Kt2PClqrk4p/xM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=ZK6nDRjT; arc=fail smtp.client-ip=40.107.113.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPyeMDALG0cuMWpcq9pziyo4DI9ABrmHX1gkC5idlGzLX1zOMIqYfoC1JPM2HOGJniF7/0PdiEOCXKJIfLL3BnnQmyn6ArTUynCIzy3lSCEWrxBBc7pFkZnFHd8oT5Zf0nDyjEhZXL8S46mOlXhZAjueW1qEJSYu9n+OEyo6/ov9QOg5iD/rT3OZ0oFCFFDtcb6R7pvPyt4DLuEkdA8vAv6heFZgSq3CWsUDH8EWVMsziw4rnSrqW6liFMg+125hX9mSBNoYlBrLuWcQEK3JQnjPvaKaPK8V33f8lfP8ZyZOF0p+fidisrm/PNLfPff+MIlo0XnjinN2ZdXWvFuYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb7k5piDjM3BJzfmx4vTI2Ypa5gsVKoWRLLmqO3n/wA=;
 b=Y85ngY6C3pGoyB+ZHdcL7zAEJiDLwPJjyF7NOz/WQlbLQJwjqfA23xvLhLAK4dUF6NwIi9WKbRce5Cls6BxLziotSm8mj7EV+7wg8CeSr1PrIcV4n2QhJzmK921obGEBV70p9Jj5++C3Fzsu9R8uhE4yChDSFO2r00pVLNpN5Dzfc5+eQ8ManmlZx2RekMOn3MnuPsUCNqC9tUGUSl7GzU1ljbmH2XbR1z/CtMIIEj65SiDUpUT1BX013NmkT12NSMDyj6b1cTFr9wCfdOVNWWPAqeeLksw3El8LYIhhj5NR2IuXTxErKSIjndCDaV64zmaHgaCLU8JT6cGT8Jny6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb7k5piDjM3BJzfmx4vTI2Ypa5gsVKoWRLLmqO3n/wA=;
 b=ZK6nDRjTJD/ov70lWR6SphSZ2x9rw3XYrfpBPiPVJM5rxgr/phhzRIIdz8sToLqanPcZeWUE2zZvoxIbYyf6Vv87/iXT1BnmFlg0elo/c9wHg9QtgFqnuzXEhR0F+z9WyIRjWxm7xlUcUUIMmGAm2L+lpPNR1CIpDGVSACIpZIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB6048.jpnprd01.prod.outlook.com
 (2603:1096:400:61::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26; Thu, 8 Feb
 2024 23:55:08 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::4d0b:6738:dc2b:51c8%6]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 23:55:08 +0000
Message-ID: <87ttmia4v8.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/1] pmdomain: renesas: Adjust the waiting time to cover the worst case
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 8 Feb 2024 23:55:07 +0000
X-ClientProxiedBy: TY2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:404:a6::26) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: a17c0ec7-f93b-4a81-7b6c-08dc29016109
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iZOy9Mexp7lduhu8XFYs8kct3IMCjtF0C6Pxe/5Fmx8NHoR+bbZVVAuQFI2WGw77KL/JDTZ0EA2uhARrhHfGkNCsrY4/7xQfcYpMK03KZg09C1GAm3OUjIZs50EJFt2EVZcdVOoZ6O4e5UQGt1glRXctR426s7CwGCBHhlnHy4PIy3JBXtUabB5eWGWHRPIaq+RkktIuWujy/kw1h6DWdjUeTROQfss/j/zO8MBAOXXCM5ZRA+SVcSdepxEvJbUO/k0yEB7sjvU2+SHDen9SxM+GgbWKetPdYhgAo8gxwdPhydcHOdqjtthhD2vqnKLF5tWjXQ26tneD3tvgzcasGeNFFy9YRRJSvPO39m0767NF3Pgx3fEWMM6DxJRvmTzOwEHV1CCeR+TSbsnOGZ1KMkkEpWqP3LKMomk9q9Rh+Pv6EAb9JFUm5iWr2Qt+8SnVMK2AZKFj2WrnrGklWuV9CHALhxPmsJ/FOV0Zv6rwnUyn7lHmjArhf0kzwDWB07x7tjLAVs4OcsSzLCx8APbekW0L7dy5Rn6TzitUZzcBZuBk4nX6fQRRCGAAUlksQPDNw0n/nLwIUg9W+Yt1/3xk6ooPamuGO+bBaQmQFf/3hUbYTBW24uLZ+pqgn1Bu6iZI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(230922051799003)(1800799012)(451199024)(186009)(5660300002)(66946007)(66476007)(8936002)(8676002)(66556008)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(38350700005)(110136005)(2616005)(508600001)(6512007)(6506007)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?va6B5Sim70ztXzLINIfobEiGzWfXABnVXHLgFBENH+fHqmOVT1KxpA2JilJE?=
 =?us-ascii?Q?BOh2hEt99QRh79OVVwOQLo6Y+HNPPEa147646pJMeDSs8UaDGRocmEasge0+?=
 =?us-ascii?Q?0JBeCj+/2MmO1BQBzmFDnDAx+AdGJnXKNVgSf3z5meiC1R4n8GEiUFx3G947?=
 =?us-ascii?Q?D4H4baO0qBDFWzkoGpnA3Cm53ADecaczS571E+DQlU/GBYUuqFtJrkiWt0kC?=
 =?us-ascii?Q?zLAhVzoRTEQEKG4/5e2pBYRKo577rwkxFAxOmm30B1w+LNb3fleqgaN0y+Qr?=
 =?us-ascii?Q?+4yKJpLguo1Uy3zRNhy59dqx1UVy3sI+AcbVQ6ZpVFIVKrcpILWmy57v6COi?=
 =?us-ascii?Q?qwQ3hUosZn4Q/KjxLJtPIkVloSZBfkUvwnVQLzKFQqI/PUwtSJABBHqlytu5?=
 =?us-ascii?Q?Jo8SwOMtGclpGjVRUdH+UUrArNUl6xkEXbQz6f9Wjwpt2NwiS2Ism6kNQe0S?=
 =?us-ascii?Q?4PWwQ0INQGc1G2NiwkA/cPGV28JloAKAqq9kvZwwV1rH/dJE1L5a65igUVpl?=
 =?us-ascii?Q?wez+IXsqqfSmwzILtOdwpNq4gDm9/Ceza8a5aY5ossjzEPUON9k6mzMSR6KD?=
 =?us-ascii?Q?cIJVnQ/1zzWP7QPlYoicsMlmiHuZu9az26eCFJ+56LaXDES6ymxWUf0uRkI+?=
 =?us-ascii?Q?beNRSVrdcyFdIF39z7QAcMAB5ODR6qTvcWP1/hb2YuTxc4dNBDj7lSrt/osz?=
 =?us-ascii?Q?6TWWufbPp2obzkUUMUYgFF4m1T9hbUnJujQusHePEz3E7zlJKTlNZml4DUB9?=
 =?us-ascii?Q?gVOrH+n1mmYpPdEaZEKI3sa4F/e61YB/UOsJ8jFVVDH5TSF8sA25IVgAWFtK?=
 =?us-ascii?Q?ewO9u2EBRXj/IITdSEXY8QSHfj2RMIICIEOP0CbfMwSY33imO4oviLOZOLsv?=
 =?us-ascii?Q?ekP4Azr3Mwq4jCD1HllDxsDNQ2cFnpQ47fKrYs0/TIEnV85OQ15EDCbCork+?=
 =?us-ascii?Q?Xd3AJQkrajbCnyZ79BYbxfLE9qDl66a7I0dwD1Ddu6T18J2BUzQ1r2iRosQ+?=
 =?us-ascii?Q?PYHVh3O+UFPh8qH9kGATIyDEvcHCwm6Oxql74J7+Fvgp/UNVD3wVDWl4Myx9?=
 =?us-ascii?Q?iSwwOKrXmQcPdP0x7uAWve4bUl7VhQsaWPBAIz+OyQdFl90Pmm5Hj29/ZXzT?=
 =?us-ascii?Q?kiPHbt++Z1Ytt41/18GeogOkGN2prHGgwwXUHHZ2gsTPJaZqU//EmhipnYP3?=
 =?us-ascii?Q?fatofFTa8bsmx4ud+SqARRNBVALj5KlUINezYySJaqS2g5bsbFax9S9oy4e8?=
 =?us-ascii?Q?tn9mFBKQDKhOwpmUz501rjSPDhWk+tMY3wTM7bcJ5MCOrmlGvUmhyivIVNmD?=
 =?us-ascii?Q?pvvN0sH/a0+d/kVtATR+VYj85gYBtH0ckRndhWXbLMeFq5IXPT01dJtLqpEn?=
 =?us-ascii?Q?WTqs2go3EWjuDHxTW/vMtHzdqKjL6rh7REYLBKNc4TB5Oqh30uDo5/0TuxA2?=
 =?us-ascii?Q?ANmRCI1qB1o/yQVV21aXF7U49xxYuuURVv05H8e+QVPfIwiKKvyjy6UiEm/K?=
 =?us-ascii?Q?368w0iho0cmUG4mYviSXiiltlbRE7P86cU4zL2YqHNFrEBBbmyxkpsmfuEpS?=
 =?us-ascii?Q?HnVKF/S2RbmWqLz/gGyaagdlec/d4qH9FdLSg2PUj87OGjaXeTGELpKPibvJ?=
 =?us-ascii?Q?33NUaNBCvSacOkgDIstcz50=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17c0ec7-f93b-4a81-7b6c-08dc29016109
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 23:55:08.0750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsHLjYa6eaJhXNXFlDlOq47u1WySDZtBBHfrN0+naWPicNDJcTkgi0bdwONM8uoCmI8Za7zM50bUHPOz/eHz++hn5mVnlMnv3VNJrpS2OYXHrLKY52zp0FUgn+TbyiS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6048


Hi

Sorry to bother you, but it seems original author mail address
was updated. I will post v2 patch.

> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> 
> Description in HWM rev0.51E, 9.4 Usage notes, page 455 tells
> 
> 	"It takes several hundreds of microseconds to shutting off and
> 	 resuming power domain. Because actual time required for
> 	 shutting off and resuming depends on the status of on-board
> 	 power line, shutoff/resume time is not guaranteed by
> 	 electrical specification"
> 
> Let's assume the safe value of waiting is about 1000us.
> 
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Tho Vu <tho.vu.wh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/pmdomain/renesas/rcar-sysc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/renesas/rcar-sysc.c
> index eed47696e825..35d9aa0dfab8 100644
> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -45,10 +45,10 @@
>  #define PWRER_OFFS		0x14	/* Power Shutoff/Resume Error */
>  
>  
> -#define SYSCSR_TIMEOUT		100
> +#define SYSCSR_TIMEOUT		1000
>  #define SYSCSR_DELAY_US		1
>  
> -#define PWRER_RETRIES		100
> +#define PWRER_RETRIES		1000
>  #define PWRER_DELAY_US		1
>  
>  #define SYSCISR_TIMEOUT		1000
> -- 
> 2.25.1
> 

