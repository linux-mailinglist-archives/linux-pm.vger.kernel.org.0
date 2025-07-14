Return-Path: <linux-pm+bounces-30812-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A648B04615
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE32189B040
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28B254873;
	Mon, 14 Jul 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="LjPGHclf"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2050.outbound.protection.outlook.com [40.92.41.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CA2AD20;
	Mon, 14 Jul 2025 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512702; cv=fail; b=KTbfOsmrBSaGh5TCSxRprbIsudW/HxRBrKmNSfb+An+L7Ert9S3zYhNptEkhEkLW5pI27DjIuPTaJaX3lwS6skarpe886i4fng6FmgvRtB3/efs30+BhJ8p3eYSJF7ZJjXVUbxEevAB8v607YbQQzXMpM6yGT9XiypfvZuLswzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512702; c=relaxed/simple;
	bh=B9tssM4KW8e/UzoJgm1oXR4yV51fN5JuZByKyXU4P38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DZQcOI8DruJZ6MkV7wFt3DOBZp5Kz/no0cMIQ5JD9RSXuUj/jvpoGYXZFUz0bg+0WfezMIH/TR0CEJ4ieXMFto7I1CWIEAv3I2elnBBSNsWxBKlvkbx1VkvU2hlixj3FmgqU7aZlu8lPl4Y1Mvn8hbhzDu8JxMO8lvZM90LP0Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=LjPGHclf; arc=fail smtp.client-ip=40.92.41.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnbp49+LZHZfTmY0NadmlpSDceBKqAxb1qysJm+0db4ieaOyCusUchnfDmLaeUrKP76XRFvobL6OOZKTZLfGggx64rqCJKwvViRpFyb3/HWpfBRKl/d2734L9B5r6fePMTVzdgGFBwS7OfSW3xXs3BrJneY2wuqfoASZRblMD0MBhJS4+gZmR+JhubnvnpzDx/+2sWcWHJKmCQlXsphcKsXPu3uHns0aPcTtFqtFeepaA5ZAgnzHIFKPOIiFOfme5zFGlb2HORgTke07WSd+u9O+oKcmc+NDtMAH67kqJtOlPs8oqrleHTPB1g87ZWRCVEhkS4rgz0yqJ3jAnrb9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2LcYHJfC+9Jxv6GNUZTHe1mekS5nreemM8O2I1e5ds=;
 b=AWPjTNFYlYxjnVLZ7TWqRSXSv7aGngDtDAPS5al3/GusxvlEC8c5af68H1doKx5lTARWjQVIkDZUhbR0YTIA6INrwKipOueIAn8a8WdsGGYhatLXCuU70ZJCx+d6NCE+xRnmtiE207finBa2Api4asX+DPLwl4J75U45OgKmDFxB9mwxDBWUcVTx8qEHm9uX5ire8dPWsJqmNGd8jblOdOIcfjEvXRcl/akY7SJNZwvBKQwclyKIot3dNlHKvBArF56tczaZtKT7NyE/QaPxHh3TlfBC9wrnx4642Ky4aX5fMBI0/uKk0EXhKqPWt15Tk9M2bQHwj6IUKsR4cubDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2LcYHJfC+9Jxv6GNUZTHe1mekS5nreemM8O2I1e5ds=;
 b=LjPGHclfIU+h+nxvcT2hqHKR2Bblxsx3dBAcw3WAvt3fAavstjxawUsEXGHjcCJGYEgifEr8oCqUYXf0IjneT5GSqb9Zxf6ju7jIEnrEr/krwUC4sOiaXOY6VIZuO+lmixaKuO3PAFfb3LHsMTRZ8TlpFcoP8I9BGC/agEOQGsIm6VfP/sRZ5JYA4QEdIX+dRZKAgL8m7MsUySj+WsVvJ+oLHsxMqsxtGg0CrsK+O8G2Gck61Q0+dvWmltrUhbiO6k6wJxDOaMhOjVTpuqgG/P05GNDfedIANaJOsJdlUyWHWKEUaUw6Go+PBd4DTym++E/cZzhZWEFt3K9boeg2Og==
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com (2603:10b6:805:b::18)
 by BY3PR19MB5025.namprd19.prod.outlook.com (2603:10b6:a03:36e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 17:04:57 +0000
Received: from SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150]) by SN6PR1901MB4654.namprd19.prod.outlook.com
 ([fe80::7ffe:9f3a:678b:150%5]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 17:04:57 +0000
Date: Mon, 14 Jul 2025 12:04:54 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	broonie@kernel.org, lgirdwood@gmail.com, sre@kernel.org,
	heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH V3 2/5] mfd: bq257xx: Add support for BQ25703A core driver
Message-ID:
 <SN6PR1901MB4654D00CBB0CB0673D51F9BDA554A@SN6PR1901MB4654.namprd19.prod.outlook.com>
References: <20250623162223.184304-1-macroalpha82@gmail.com>
 <20250623162223.184304-3-macroalpha82@gmail.com>
 <20250702150210.GS10134@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702150210.GS10134@google.com>
X-ClientProxiedBy: SA0PR11CA0115.namprd11.prod.outlook.com
 (2603:10b6:806:d1::30) To SN6PR1901MB4654.namprd19.prod.outlook.com
 (2603:10b6:805:b::18)
X-Microsoft-Original-Message-ID: <aHU4tlaQyhCUrXQe@wintermute.localhost.fail>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1901MB4654:EE_|BY3PR19MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: e7433517-50dc-4997-4984-08ddc2f88f20
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|6090799003|41001999006|3412199025|440099028|40105399003|51005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUw5TzQ5cXVQaElXVnhSeXBUQ2tnczlCYjg1bjRiVmwyV1BsTGVrM3g4VE9O?=
 =?utf-8?B?bG04b1MyZWE0M0xCL2VsanpDdUNVUkVhbDBtaWZEVDE4YlZWM1dkaFJVUnM1?=
 =?utf-8?B?MVR3aFhqMkNwbVFkSzc3SWRMSnJCSW1kSXJiYTJSU29tWFYxWXBreU82WW9j?=
 =?utf-8?B?VVlsUDJIWCtLUElISnhvUHc0OTBzVnc4TTY4K1cyMGRjbmIwWm1tWUY1K0NN?=
 =?utf-8?B?eUdhVGcrVVRKakFhQzVFQVNtOWRqazB4K2lEWi9UZElyaytsMDhuL2VsTFUz?=
 =?utf-8?B?T3h4WnZqUlRtazRhSVZTS25qRXVQWUdrc1dKMytoQzM1ajV4YlZseEMzd1dx?=
 =?utf-8?B?RTdkb0pKUnVTUWFGanBISGpSM014alVRN2E2allYVW5JSTZxbXVvcHJJeUpB?=
 =?utf-8?B?MmU3ajdIUExLaHdORGtiR0VhaWswSTR2clVhdERFVllIR2QvNWYyNitOUkJF?=
 =?utf-8?B?eVM2UGJXWkhkakQ5eFo1NzlqeTFtcGNzZzZEelV4c0NFMFc0VW9YRlAyNzhE?=
 =?utf-8?B?dWV5VFlaVTFQZEpUd0F4L3ZRR1dqK1F5NkZLMWEwd29xcDJYMzFHY1hvejlV?=
 =?utf-8?B?Mmt6djBBRzc3eUFjcXMyT3BIWDlQTHc4OG53Z2o2T0RMQlM2S20yRzZYcWtD?=
 =?utf-8?B?RzJGR1lWSHpoV1QyMEVxRklqbVVjcWpXRDd3L0VSNUdxektGdDg4NW14bFdt?=
 =?utf-8?B?TlI0bVdLc0RIa0xVclNzNTgwWDZRYnV4TE4wRUZMQjlKYmZOV29lU0xPZFB6?=
 =?utf-8?B?UFBzUEEzZm4vNmhFV0RjS0w4K29tS2FLbHhuK3RRNjYrdWhCNXozREh4aGcr?=
 =?utf-8?B?ZHZzZnY1OWQzM3JiM3ZmTXF3MW5xT1diTmphNWZZc0Y0RTBsR3c5a0l2UU5z?=
 =?utf-8?B?eS9DT3pRVlJyRExOSzFmUklXWkhEOFZFNnlFRlRRbjF5cE40WnBnZU5zQm00?=
 =?utf-8?B?Ti9xMmsvd3RQcGgzYUdaay9NMGRKU3JNQitMRnUyZ3phVkI0cFN6QTRkMTg3?=
 =?utf-8?B?SmhDejRWdHVIRjVULzR3T3pYZFlaOSt4bTJlOWdoZ01qTUhLZGhDQ2N0bXVl?=
 =?utf-8?B?Z0crQ1lYVHJkcmh1Q0JoSlB3cEtEamJmS2hvMVBiVHFWTnExaG1Od2FCQy9W?=
 =?utf-8?B?MnJWbnpBbXBMV0NTZnMxK3VVVEdtMkhKOEcxR2dXQ3RFdGdrUVdDNDBqQ2s1?=
 =?utf-8?B?Vmx5bXg2NGxHbmVrZ0JTMnp2M25qbE15RzRpQ3VTV0JCMytkTFJ2eHVwczRQ?=
 =?utf-8?B?cEdrem9VREhxaFFqMHBVb285aWJYSVkrSEZPZW1WOEtzVFhLbSt4T3NHZ01K?=
 =?utf-8?B?dEswVHBKcHZ2eWxFTUNKamhMRFdUblYwMlBSczduT2VDd2p2OTFEOGdpK3FV?=
 =?utf-8?B?ZFNzZGRhanQyNjM1OHZJZW9KTkhVeVZsUUhZc1l0dXMzQ2cxMFBOVFBSVWhX?=
 =?utf-8?B?MkhKRmdLZmY2MVA4YXRtZEJ1V00wZzdoT3Y4SmNhVFU4d3E2Q3VwbFMyU0lz?=
 =?utf-8?B?K2pVaXJZQ2lOZXdTTnpGbm44Qm1BZFFwYzNSTjk5Wm9uZk9ZZG0wUEtJQzB0?=
 =?utf-8?Q?7N1x8H2R8cblMTdoehMU1lxA4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXdDRDB3SDdmQkF4djJOQm92UWVzcmxkQ0pZTjBUQk11eEZVNDR2SllMM0Zu?=
 =?utf-8?B?V2NPY2RTNk1Ca1pDTk1HRXdYbXBpZ0MvdXJHSTNyTlB2Q0Z1NThWME83SWFj?=
 =?utf-8?B?MVU1algyaE1uUlhsS05UczZRYkx1ZXNxZGt5Vi83RHJDVkJSVEFSN0RwcnVC?=
 =?utf-8?B?MHcvdTd5enFEaFVtcm1RRmxlWHhXaGljVUxyaVB6VUthVDFkN1ZiQi9ZK3R5?=
 =?utf-8?B?MVBSa0VKZUZ6Wnl5R201WDNtN1ZMYnBKVmFqRjhoYk9zcVRtU1BQMUUxMlZW?=
 =?utf-8?B?YWg4RGwyYkY2eTROY3ZXOXJUQ2JCNnNvNGxuZmZGM211R3NKaWpsR3gzQjE1?=
 =?utf-8?B?ODN5eFZmQWpDN1lsYmhFSmRrb2ZidzIySnh4SFpoQ1ZpUlZhdDNhMklWQ0JP?=
 =?utf-8?B?NW56aFQ2NVA0RzhoUTFucmhhSXFtNDdzekFjcGlDdmc0eFJ6bHV3UXV2M0FE?=
 =?utf-8?B?MGxabUJVZk1YdXB1TWJGMEs2UlZzQW8yUytnZFd2YVhnVGxCSTQrVVlMdFNT?=
 =?utf-8?B?NUcyUkN3dm85Tmt0L0IrdGQ0OWJGNDQyQnQ5NzF4Y01NQ3JtYlZ3WVFNZWJp?=
 =?utf-8?B?c1VvOUNrRlE3SXNGVDJzeGh1RFJVUEtnT0N2Y1NPRkh5VnJIMGVkaHJmUURD?=
 =?utf-8?B?WVBvekxrblgyNFJGZ241Z3BHdE5Ic0RWMk51alpBZVRTTExNSU9RZU1MVjU5?=
 =?utf-8?B?NWx5Q3MrbHlTMzhYcnlZNXVGUFlNSFdBVWdsYXV6Z1MyUTRrSTVIMkxsSXhF?=
 =?utf-8?B?TWVjM25KbENnRFNSbnlCbVRRUTNRK0orM0ZzQlNGSWpqU2locWlUV3Y5ZVFB?=
 =?utf-8?B?M01nNEJIQnQ5MUpuaEJmcjdTTEx2eGIzR1J2cjloTnZxaTh4aVFWSCtlZE9r?=
 =?utf-8?B?dXFsN2RKNWRYWHRnaVZZU3AzNTN3SDRNTWgyR3F2NTArWXJVdEtIUmdGYWNy?=
 =?utf-8?B?Z2RGZVNxUm1NcjRaMEtNcUxpZStCbkJQOTd1emk5dHQyQWt5YTZqdG1OakVy?=
 =?utf-8?B?N2ZyQXdManNCSzVUd0VoaytoTGNvYVlaZ3RRcllUcTkzM3FnZEtveXpIVmRR?=
 =?utf-8?B?UE15eVZ1RER0Qkh0L0pvS2ltQVBSRDk4Z3poZmlQNG9vTW4rN29KM01GWnRW?=
 =?utf-8?B?dEFJWVdzdGVoL2ZSMnJBaXY3dkJ1ZklteW5sNXVHZk9MQXo3MjRrSmY2c3U4?=
 =?utf-8?B?Wld6K1pucG8zMDBkRHNXV0dCZnRPYjBSelhSYmdnMjV5eDNJOWFnQmszTXBO?=
 =?utf-8?B?anJMQ3BtQzNxemNUcjBrQlVVbXRGV21tVFJidFhYc09xSTFOcWI1SjZDdFVH?=
 =?utf-8?B?QzRzWUJmV2VkcHc1UlZ0VDhjVTE2TGRuODdrQTJLNUozcUc4c3dLZG9GMEhP?=
 =?utf-8?B?WGVTK1BIOW5BMVRkRTRYVHJTTHhvRldZNWo4VHFvd01ReHY3SWZJTXlqdTND?=
 =?utf-8?B?bjdaaDBPa2VuZ0lKTklDbVE0TkEyaTEvVk5oSGFjdkFqT3FvaWdmdnFlRjhN?=
 =?utf-8?B?UWx6Vmwvend0SFk4OHNydXBWejZYUG5GcXhtRTJKT3ZOR2NUcG1vT0dVUUpU?=
 =?utf-8?B?ck9IU3FwVTNVcUpYOGlIQklpeTIybUQvZmxTVlVxbE10eEtWVkZjcnZvNEZF?=
 =?utf-8?B?a2FWQ094Qnd1YjEwWkdXb0ZUQzVrZkRjQ0pacFlqeE9WcGs3OFBYLzRmRktn?=
 =?utf-8?B?SlpLdU1JL0YzZEljR1FmZ1ppZkRqMC9JS0hHU3diU2JCR3NweUJkQlNvR1JU?=
 =?utf-8?Q?KmgilpvPc4/umSA/zB39H+IC894wlq7pd0Wvl2T?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2c339.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e7433517-50dc-4997-4984-08ddc2f88f20
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1901MB4654.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:04:57.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB5025

On Wed, Jul 02, 2025 at 04:02:10PM +0100, Lee Jones wrote:
> On Mon, 23 Jun 2025, Chris Morgan wrote:
> 
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > The Texas Instruments BQ25703A is an integrated charger manager and
> > boost converter.
> > 
> > The MFD driver initalizes the device for the regulator driver
> > and power supply driver.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/mfd/Kconfig         |  11 ++++
> >  drivers/mfd/Makefile        |   1 +
> >  drivers/mfd/bq257xx.c       | 104 ++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/bq257xx.h | 108 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 224 insertions(+)
> >  create mode 100644 drivers/mfd/bq257xx.c
> >  create mode 100644 include/linux/mfd/bq257xx.h
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 6fb3768e3d71..d8b39e8a8a17 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1585,6 +1585,17 @@ config MFD_TI_LMU
> >  	  LM36274.  It consists of backlight, LED and regulator driver.
> >  	  It provides consistent device controls for lighting functions.
> >  
> > +config MFD_BQ257XX
> > +	tristate "TI BQ257XX Buck/Boost Charge Controller"
> > +	depends on I2C
> > +	select MFD_CORE
> > +	select REGMAP_I2C
> > +	help
> > +	  Support Texas Instruments BQ25703 Buck/Boost converter with
> > +	  charge controller. It consists of regulators that provide
> > +	  system voltage and OTG voltage, and a charger manager for
> > +	  batteries containing one or more cells.
> > +
> >  config MFD_OMAP_USB_HOST
> >  	bool "TI OMAP USBHS core and TLL driver"
> >  	depends on USB_EHCI_HCD_OMAP || USB_OHCI_HCD_OMAP3
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 79495f9f3457..06da932cce5d 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_MFD_SM501)		+= sm501.o
> >  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> >  obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
> >  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
> > +obj-$(CONFIG_MFD_BQ257XX)	+= bq257xx.o
> >  obj-$(CONFIG_MFD_CGBC)		+= cgbc-core.o
> >  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
> >  obj-$(CONFIG_MFD_CS42L43)	+= cs42l43.o
> > diff --git a/drivers/mfd/bq257xx.c b/drivers/mfd/bq257xx.c
> > new file mode 100644
> > index 000000000000..27fbb64110ed
> > --- /dev/null
> > +++ b/drivers/mfd/bq257xx.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * BQ257XX Core Driver
> > + * Copyright (C) 2024 Chris Morgan <macromorgan@hotmail.com>
> 
> No updates since then?

Yes, there have been, I'll resubmit with updated copyright strings.

> 
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mfd/bq257xx.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/regmap.h>
> > +
> > +static const struct regmap_range bq25703_readonly_reg_ranges[] = {
> > +	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_MANUFACT_DEV_ID),
> > +};
> > +
> > +static const struct regmap_access_table bq25703_writeable_regs = {
> > +	.no_ranges = bq25703_readonly_reg_ranges,
> > +	.n_no_ranges = ARRAY_SIZE(bq25703_readonly_reg_ranges),
> > +};
> > +
> > +static const struct regmap_range bq25703_volatile_reg_ranges[] = {
> > +	regmap_reg_range(BQ25703_CHARGE_OPTION_0, BQ25703_IIN_HOST),
> > +	regmap_reg_range(BQ25703_CHARGER_STATUS, BQ25703_ADC_OPTION),
> > +};
> > +
> > +static const struct regmap_access_table bq25703_volatile_regs = {
> > +	.yes_ranges = bq25703_volatile_reg_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(bq25703_volatile_reg_ranges),
> > +};
> > +
> > +static const struct regmap_config bq25703_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 16,
> > +	.max_register = BQ25703_ADC_OPTION,
> > +	.cache_type = REGCACHE_RBTREE,
> > +	.wr_table = &bq25703_writeable_regs,
> > +	.volatile_table = &bq25703_volatile_regs,
> > +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> > +};
> > +
> > +static const struct mfd_cell bq25703_cells[] = {
> > +	MFD_CELL_NAME("bq257xx-regulator"),
> > +	MFD_CELL_NAME("bq257xx-charger"),
> > +};
> > +
> > +static int bq257xx_probe(struct i2c_client *client)
> > +{
> > +	struct bq257xx_device *ddata;
> > +	const struct mfd_cell *cells;
> > +	int nr_cells;
> > +	int ret;
> > +
> > +	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> > +	if (!ddata)
> > +		return -ENOMEM;
> > +
> > +	ddata->client = client;
> > +
> > +	cells = bq25703_cells;
> > +	nr_cells = ARRAY_SIZE(bq25703_cells);
> 
> What's the justification for using local variables for these?
> 
> Why not use them directly?

I originally wrote this driver to be a bit more "generic" in that for
different hardware revisions a user could just add register
definitions and hardware specific functions and it would be supported.
I did that because very often I find myself having to refactor drivers
when adding a new piece of hardware... I figured I'd just do it from
the start this time, and that's why this is done this way. Since for
now the only piece of hardware I know of is the bq25703a though, I can
skip using local variables if you prefer.

> 
> > +	ddata->regmap = devm_regmap_init_i2c(client, &bq25703_regmap_config);
> > +	if (IS_ERR(ddata->regmap)) {
> > +		dev_err(&client->dev, "Failed to allocate register map\n");
> > +		return PTR_ERR(ddata->regmap);
> 
> dev_err_probe()

Will fix, thank you.

> 
> > +	}
> > +
> > +	i2c_set_clientdata(client, ddata);
> > +
> > +	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> > +				   cells, nr_cells, NULL, 0, NULL);
> > +	if (ret) {
> > +		dev_err(&client->dev, "Failed to register child devices %d\n", ret);
> > +		return ret;
> 
> dev_err_probe()
> 

Will fix, thank you.

> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct i2c_device_id bq257xx_i2c_ids[] = {
> > +	{ "bq25703a" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bq257xx_i2c_ids);
> > +
> > +static const struct of_device_id bq257xx_of_match[] = {
> > +	{ .compatible = "ti,bq25703a" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, bq257xx_of_match);
> > +
> > +static struct i2c_driver bq257xx_driver = {
> > +	.driver = {
> > +		.name = "bq257xx",
> > +		.of_match_table = bq257xx_of_match,
> > +	},
> > +	.probe = bq257xx_probe,
> > +	.id_table = bq257xx_i2c_ids,
> > +};
> > +module_i2c_driver(bq257xx_driver);
> > +
> > +MODULE_DESCRIPTION("bq257xx buck/boost/charger driver");
> > +MODULE_AUTHOR("Chris Morgan <macromorgan@hotmail.com>");
> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/bq257xx.h b/include/linux/mfd/bq257xx.h
> > new file mode 100644
> > index 000000000000..153a96248f32
> > --- /dev/null
> > +++ b/include/linux/mfd/bq257xx.h
> > @@ -0,0 +1,108 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Register definitions for TI BQ257XX
> > + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> 
> No updates since then?
> 

Will fix.

> > + */
> > +
> > +#define BQ25703_CHARGE_OPTION_0			0x00
> > +#define BQ25703_CHARGE_CURRENT			0x02
> > +#define BQ25703_MAX_CHARGE_VOLT			0x04
> > +#define BQ25703_OTG_VOLT			0x06
> > +#define BQ25703_OTG_CURRENT			0x08
> > +#define BQ25703_INPUT_VOLTAGE			0x0a
> > +#define BQ25703_MIN_VSYS			0x0c
> > +#define BQ25703_IIN_HOST			0x0e
> > +#define BQ25703_CHARGER_STATUS			0x20
> > +#define BQ25703_PROCHOT_STATUS			0x22
> > +#define BQ25703_IIN_DPM				0x24
> > +#define BQ25703_ADCIBAT_CHG			0x28
> > +#define BQ25703_ADCIINCMPIN			0x2a
> > +#define BQ25703_ADCVSYSVBAT			0x2c
> > +#define BQ25703_MANUFACT_DEV_ID			0x2e
> > +#define BQ25703_CHARGE_OPTION_1			0x30
> > +#define BQ25703_CHARGE_OPTION_2			0x32
> > +#define BQ25703_CHARGE_OPTION_3			0x34
> > +#define BQ25703_ADC_OPTION			0x3a
> > +
> > +#define BQ25703_EN_LWPWR			BIT(15)
> > +#define BQ25703_WDTMR_ADJ_MASK			GENMASK(14, 13)
> > +#define BQ25703_WDTMR_DISABLE			0
> > +#define BQ25703_WDTMR_5_SEC			1
> > +#define BQ25703_WDTMR_88_SEC			2
> > +#define BQ25703_WDTMR_175_SEC			3
> > +
> > +#define BQ25703_ICHG_MASK			GENMASK(12, 6)
> > +#define BQ25703_ICHG_STEP_UA			64000
> > +#define BQ25703_ICHG_MIN_UA			64000
> > +#define BQ25703_ICHG_MAX_UA			8128000
> > +
> > +#define BQ25703_MAX_CHARGE_VOLT_MASK		GENMASK(15, 4)
> > +#define BQ25703_VBATREG_STEP_UV			16000
> > +#define BQ25703_VBATREG_MIN_UV			1024000
> > +#define BQ25703_VBATREG_MAX_UV			19200000
> > +
> > +#define BQ25703_OTG_VOLT_MASK			GENMASK(13, 6)
> > +#define BQ25703_OTG_VOLT_STEP_UV		64000
> > +#define BQ25703_OTG_VOLT_MIN_UV			4480000
> > +#define BQ25703_OTG_VOLT_MAX_UV			20800000
> > +#define BQ25703_OTG_VOLT_NUM_VOLT		256
> > +
> > +#define BQ25703_OTG_CUR_MASK			GENMASK(14, 8)
> > +#define BQ25703_OTG_CUR_STEP_UA			50000
> > +#define BQ25703_OTG_CUR_MAX_UA			6350000
> > +
> > +#define BQ25703_MINVSYS_MASK			GENMASK(13, 8)
> > +#define BQ25703_MINVSYS_STEP_UV			256000
> > +#define BQ25703_MINVSYS_MIN_UV			1024000
> > +#define BQ25703_MINVSYS_MAX_UV			16128000
> > +
> > +#define BQ25703_STS_AC_STAT			BIT(15)
> > +#define BQ25703_STS_IN_FCHRG			BIT(10)
> > +#define BQ25703_STS_IN_PCHRG			BIT(9)
> > +#define BQ25703_STS_FAULT_ACOV			BIT(7)
> > +#define BQ25703_STS_FAULT_BATOC			BIT(6)
> > +#define BQ25703_STS_FAULT_ACOC			BIT(5)
> > +
> > +#define BQ25703_IINDPM_MASK			GENMASK(14, 8)
> > +#define BQ25703_IINDPM_STEP_UA			50000
> > +#define BQ25703_IINDPM_MIN_UA			50000
> > +#define BQ25703_IINDPM_MAX_UA			6400000
> > +#define BQ25703_IINDPM_DEFAULT_UA		3300000
> > +#define BQ25703_IINDPM_OFFSET_UA		50000
> > +
> > +#define BQ25703_ADCIBAT_DISCHG_MASK		GENMASK(6, 0)
> > +#define BQ25703_ADCIBAT_CHG_MASK		GENMASK(14, 8)
> > +#define BQ25703_ADCIBAT_CHG_STEP_UA		64000
> > +#define BQ25703_ADCIBAT_DIS_STEP_UA		256000
> > +
> > +#define BQ25703_ADCIIN				GENMASK(15, 8)
> > +#define BQ25703_ADCIINCMPIN_STEP		50000
> > +
> > +#define BQ25703_ADCVSYS_MASK			GENMASK(15, 8)
> > +#define BQ25703_ADCVBAT_MASK			GENMASK(7, 0)
> > +#define BQ25703_ADCVSYSVBAT_OFFSET_UV		2880000
> > +#define BQ25703_ADCVSYSVBAT_STEP		64000
> > +
> > +#define BQ25703_ADC_CH_MASK			GENMASK(7, 0)
> > +#define BQ25703_ADC_CONV_EN			BIT(15)
> > +#define BQ25703_ADC_START			BIT(14)
> > +#define BQ25703_ADC_FULL_SCALE			BIT(13)
> > +#define BQ25703_ADC_CMPIN_EN			BIT(7)
> > +#define BQ25703_ADC_VBUS_EN			BIT(6)
> > +#define BQ25703_ADC_PSYS_EN			BIT(5)
> > +#define BQ25703_ADC_IIN_EN			BIT(4)
> > +#define BQ25703_ADC_IDCHG_EN			BIT(3)
> > +#define BQ25703_ADC_ICHG_EN			BIT(2)
> > +#define BQ25703_ADC_VSYS_EN			BIT(1)
> > +#define BQ25703_ADC_VBAT_EN			BIT(0)
> > +
> > +#define BQ25703_EN_OTG_MASK			BIT(12)
> > +
> > +enum bq257xx_id {
> > +	BQ25703A,
> > +};
> > +
> > +struct bq257xx_device {
> > +	struct i2c_client *client;
> > +	struct regmap *regmap;
> > +};
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Lee Jones [李琼斯]

Thank you,
Chris Morgan

