Return-Path: <linux-pm+bounces-40701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2EED16F1C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 08:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A8CE3033985
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 07:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9882F29B77E;
	Tue, 13 Jan 2026 07:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJankv7Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hSVQxmrA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E7270EC1;
	Tue, 13 Jan 2026 07:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287998; cv=fail; b=h5axzmJRR/rUyXv0zLTjdzhDPAz4KKxayParqxj6MuD4VqIgaglZv/6jqEQqvoLSHpn70hMsE/iAVDwD3B63ysEXG2db4/a/PpWLLTMVYoL7EP6v+zNsxbENrRTHGnerhV8i3The+89WzFcSHHL10H96h8zk1oDeee7OisIUWck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287998; c=relaxed/simple;
	bh=LLh/qexroSDWYdtCkgGDYc6ErOmRAWaG06DB3oTsPnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X/Vr5Aw/bJ2/cYlX+NSRACFWxTAgq411WaHYNJKgC8CmJz0AHLqW0ymViATvU41GZRhc3HRJ+546OTi0X7JAiogz6NdQnqUHV+ml0gRSdQAlLZRIR8BEt0ZVO8l+449L4xrtLbcc+/8R+RXWMj2aU/KmHrUffiP7flULVtjpECc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJankv7Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hSVQxmrA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1hTgV2755030;
	Tue, 13 Jan 2026 07:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UdFwYQwmsLYMME3B7LBViOLCW/697XhQD9cOTkaHmW0=; b=
	EJankv7YT3oQMNkZfPBx7nlSXPFmwX5VrDrOC467XEv15UawGWMvTAS9c2OXthte
	QesCmybP28m7OuUwZTK8jS717zR8Vl/KcTKYwv8KVAtD0TZk7KwQnGeOLuDH8ofr
	3xQtdcmpmmR57jlAKk70Z5GUaH8d6RRaZQv4+WMkxSSLoLdAttQDo8DvNsxizcQm
	8vReAAYj/vfOxFYOgl+D5ar/6yRd0EkoyaXk17Onx2pGQB/QJvdE6+J8LDf6fXzt
	E6WKMyqwsvPyqWJxwr/mlQybfdrv1GRQtJx4WrIrgeEIQ3dDM5hafqAlXdGXSad6
	DuYp9BfUfFVG5bFB2D6GMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgjy5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 07:06:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60D6uIns004234;
	Tue, 13 Jan 2026 07:06:27 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7j5txt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 07:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQXEORc5ngIvSxrVMbq9yxQCDe8wzcxZn8oDt5SSeRkvRBcU1qVBU+UGJorZFsdYz31Lt3xBCFzQxiZfq6A6KBxf3Wy7xGmOQykx6k/BcpNwkvH/DGJSqW52bTySIews2ZXrd3asAgq6UUEiW32lS89nPDXvTw1zaS310BcJEXiV7/QeQsVVIGzsfmY34PLMyTdBExcxnhslB4X48gE7NwuR0XBCYshexi27l2cAR+IyppD6av2XNno3R1qUMEJGRQUlig6HAqT5Z21hiUr6qK/fnlx1A/hPDTUGVvIkBKEIUSK0RBQZlZyEsMNuTYobEufNKqalXu+qiqaLoE74RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdFwYQwmsLYMME3B7LBViOLCW/697XhQD9cOTkaHmW0=;
 b=Cg4KpkicfwrlgmGsz57TP4StucTsLyrteKwjbXvPO4if+L5/JBnqWSpRq3dRl92bsC5/DT4USXBq0Jx1tYwJL71wHEVZ5K9fknojYSzDrHm2lg4yOAW6ZDDNYL7qEjR9f6GceLfAO6beGH/0t0kWzz/YpQlBtl/1BWZkF7qrsKByi/y+3dZVMMu6mUJo2Gt28cZXsEHY1UtVw+WiKZ3XhpldFmRhwpcTlevzlTCRNcWI3GYERxYcVX4e3b8AmH8UUGtfs7RjF46YPXI41xYiZ/n2c8OrsHARwUWTvO6RGZDKjf6/FZ7jMtfz1kO6k2QXe4DO6/fHS7Kzey86LLccVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdFwYQwmsLYMME3B7LBViOLCW/697XhQD9cOTkaHmW0=;
 b=hSVQxmrA+28bUp5R9jNTISVxv6paLs1+BiKP4PLJ+zIa9zMGK+s4/qi4BERSjFqEzsOT67dzHxFtIbXFV1knnuJ484nr/V0Q/aFWxPAwWTeZaiWyCFOK2d4xf4iP8DvWV44dkNIx3Cz2GpivTFRuLLUzAGnMGGo31/ywJRGMdNg=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SA2PR10MB4651.namprd10.prod.outlook.com (2603:10b6:806:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 07:06:24 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 07:06:24 +0000
Message-ID: <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com>
Date: Tue, 13 Jan 2026 12:36:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Christian Loehle <christian.loehle@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Cc: 'Sasha Levin' <sashal@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        "'Rafael J. Wysocki'" <rafael@kernel.org>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::8) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SA2PR10MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b14c9c7-27a4-4866-7208-08de52724310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEtna2k1dUhsdjlBWE92NzB4c3pkY1VxVmFzVlV6QVNOMUV6TStSVnYxUzZs?=
 =?utf-8?B?VnhzNzVPZzFGT3d3MDdQYVJwS2tPTVBZVVJUVktkL0NheXRraGlQeXNyRkUr?=
 =?utf-8?B?UTFhcThIWHJqM3Z1Z0dueDNuaGV1RXEyZjErdkwyRGhLVTIxdWF3TFM3RlJv?=
 =?utf-8?B?aU81bmpHQXducDREcEZLYUJ4UVFMcWhncFJuaFVPRkc4N0ZERWI2VXprSlpP?=
 =?utf-8?B?eEVEM0tyaHVYNjA2UHFnNG1IYU9PWEtkKzZrVjZMVGpzek1jYVMrUlY2ZjJZ?=
 =?utf-8?B?ZmJYYUs3cmFrQnpmaEFoZWZsdUViZUxOSzEyL3JlU1Z5bkxSbHV3MklESDNk?=
 =?utf-8?B?MjYxUVRvamZTaGVCU2RzNnpZUDdEY3FJUjhydEREaHE2SU9lb1JiTXUrZjVQ?=
 =?utf-8?B?TkpZTG1jR090RkJxRFFiUGU2UVYzWkxtRzZKcG9EcnBneXNvNGJoUjAzbjFj?=
 =?utf-8?B?ZGFhVisrbGNrYXBOT0s4YTA3UEdLRGFxNE5UR1JET2Q1WnVwMFRaYmg2T1Z2?=
 =?utf-8?B?aTh5QTlqRTNid0JlbGFWaTFEVDduRlRIMkgwb2E4UTdabDZqYnVFRDhTdTdD?=
 =?utf-8?B?WEE3U0h2NVczNk8zc0NXQ09WZmhKWFBoRk9OL1Z3RFdJMzRBQm9lS0xib2Vw?=
 =?utf-8?B?TVU4WHFWMG1mNThyWTZIRXNBcWdXWlJwZTBIeWVOUlVTS3BTelpiWEpvZ2NB?=
 =?utf-8?B?QlFGd3BTM3lqMVNXVm1CRmJSQzljaGN1QmJwNlVCdWZka2MxWjlVMW9MNnM1?=
 =?utf-8?B?MkxLc29GQ2w4Y3I0SjI0bHByWitaZVpNY0Q2NFBaa29hdlUvbDltNDBvdjlw?=
 =?utf-8?B?Nk0yREVPWk9jcllOdXdnbHhhanJYbkd1blhnUzRjUmZUalY4MEtnZG1XTG9O?=
 =?utf-8?B?c1JyQTBNczNxOS9yOFkxRVhwdDNzcFpSd1ZKcmUvZ0FURTV2ajRmcU5zTnBM?=
 =?utf-8?B?ZVJWRk1kS2xtN2xCVlJQenIzWFFwT3lOWWdzWjRVdHFOVzY0UEVpZ29CRGxP?=
 =?utf-8?B?bWlqWnB1QlhkVjl2cjJGbVZrWUVrbStWdVNDeUMrUERXOEFXWmYvZVBsUGsv?=
 =?utf-8?B?RlNCVUpjMTZxcG52d2h0bm9KWWJKVGxYQkg0R1ZWd2RFdnlIZHcyREIwdUN1?=
 =?utf-8?B?ZjNyN3J3VUkvRlROL0RUK1hFb1loVi8wSzVZTm83U0dEaGNMK3MvbG00bmt0?=
 =?utf-8?B?SE1kcDh1VGtLRWlFSWtuUThtOUxOenUzUTBQeUJ1Wk84T3E3LzhkTkZpVUsz?=
 =?utf-8?B?ZlkzMkdJdm83SXVBM2FZbEtFcGl3RHZCRFdveUhmTkp4RW1VRElpRjJoamM3?=
 =?utf-8?B?bS8zWVNlSG1GeEZOcmZZNU5NbkVyeXhkb3FSbHE3VEE2SU9DbERMQWFJNzhO?=
 =?utf-8?B?WDRxNDZHRTVIQjFRQ0xNSGRQYUdsbVBFbnFHeGg1SVlkUkNUT3JRL09Od0xj?=
 =?utf-8?B?c01IWnNFZnU0by9rL3NUNUQrZ2RjSk5DRVR4TTRqOW1wTkd4TWwzKzhHZUZF?=
 =?utf-8?B?VDBNbnVaRHFYWDhZN3NFZGI4RU9vMWRPNnBiaVdZMEJLMTd3TE9nbklMQWdx?=
 =?utf-8?B?U1lHK0lwcytFaWJoaXV2dHVoTWEreGdIMVMyd1NSUmg2RkxHYjJxVjRuaFpP?=
 =?utf-8?B?UGp2TitVK0o5U3NSNkNnSlpkVDFtNld5Y1JwQlRZekpoc2JUOVd6dThSaXZk?=
 =?utf-8?B?TDRVc1FtaUdXTWpWcmZBamRnSTdHK1ZibEFIZXlJTnQ1VkU0LzJEMjMzYlNi?=
 =?utf-8?B?RG9vRCt3WE1jRkYxRXUyOC9CbktCbGJOUVV2UWdES1M0Rk5lanRUSG5zUG4v?=
 =?utf-8?B?S2dFS3dCZGkxdWpuS1lXaXJzNFBCeHVZdVBLdzNJaWRFcUdsbHFXSVlRNWxH?=
 =?utf-8?B?eWhTanNWdXJnaHc4aVhvQ3FDL3praWtpZGVSa1d0SzFicWVza0hBa1RTSExi?=
 =?utf-8?B?TEtEdUJrczNKMkkxRVRCOUNzSWt1VzlHR29ML1RFVzgxQUJrZjkwZFVxbERp?=
 =?utf-8?B?T3ZhUkRrUHZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnhOc20rbWZhSDNCWllkVWhSOFVoQzhXVS9mY2RqUlpPNW45UzFaaHdsZTlp?=
 =?utf-8?B?ZmhqaDB1QUl5R2cxd3paV1JuRTRzdnVpck1ZeGdFRTM0Yk0rS3ljUEhDUm94?=
 =?utf-8?B?bjZiMkg4eDh3cGFEM0N2QW9BcHFkMmVZUG9PdjFpNzMyY2dtSHUvRUNnTksw?=
 =?utf-8?B?SDk4aFJ6cVR1bHhtaVg1M2diZVlrWFoyeithODlNMGNmR29odFMzYVhES1NT?=
 =?utf-8?B?TlhTby9aNEp4V09RYzMzTVNlVUJRWFhOV1dBWGQ0cU5RMDhicVFVQnU4Sjli?=
 =?utf-8?B?cmZZY0RlODN1ZjkrS1pLVUZLaEw5ZytHTERGZ2FnK25XS2RqZXZoZkZWem5N?=
 =?utf-8?B?bDZJTjFCaERtOHg4LzRIQ0RjeVQ4ZnYzSXE3ZTFZMHhvc3pVaEdRcWIxYitR?=
 =?utf-8?B?NEhWQjlNZEdPK2dlQy9XK2haTzFJaVJJbzRjTkp2RlpVUlV5a1VxZGZjMVJx?=
 =?utf-8?B?amU3REliYm1uemNlZVVuY0tWSnlHMVpWNlBIQVdHdG5NUDcyR0tXaDYrOUdW?=
 =?utf-8?B?enFpNjhheXNPNm4vK0VCcDVpUDBTY09HWVR2bmwwVTBqTE51VGMvOElwN2Zr?=
 =?utf-8?B?ZVJ0TVlCeWwyUURFeXlEWWRKOC9BZGlscXdDa3hGbXQyZEx5a0kzdnNJMjJ1?=
 =?utf-8?B?WCsxK2xnVjgwNUdONkRCekRNWG8yNU1rWnpzT29BdnpIUy92S1ZrK1Baa2d5?=
 =?utf-8?B?cUVwTnZKeWlTQVdwVThVbnJzL1REYjZoN25Yc3B3dUd2c0NyeFUrQ293ejV2?=
 =?utf-8?B?R3ZxMkFTS1FtRzNYLytUZUxZNk50R3pNbGt2UWx3a1V4Z0dKL1FMSEJwcFhU?=
 =?utf-8?B?VG1uNVU4MEwyeEFlZzV0Y1R2bHZSaXlTMEUvaWRqWUFWUXIwSjJQaWZINEwx?=
 =?utf-8?B?bGwydS8zdGJ1TVVtSGxEVGZLMW4rcGY5c3FCc2YrN3VXWGRuUE5QWGVpdXRa?=
 =?utf-8?B?SVR3Wm4xN0lIa24vSkFxQVc3M2V2SzZmSnAzMzY2UytReGdIN2ZzL2hiUmNm?=
 =?utf-8?B?bHlDWHUxWHd3UFlpSFJmZi9OK29KQkRjeTYycmFFTjQ0MWxBQ3JVY0dOWnda?=
 =?utf-8?B?L213eEVlaFh6eHpUMXBrOXhLQWxkZ1VJVzMxalF4bEZwZ3YvSXlqZGxLSFYw?=
 =?utf-8?B?YXBJUFQvQStjNXVBSmdqWUE3WG1HZjZLaTQrTzY2KzFtNFcrMnBPVzluZUxw?=
 =?utf-8?B?U21rbmN2Z2M5Y0JiVXNIaGpIMmJtYmwvN3RDc3YxWWcyOUFLOU1xYVYza3F5?=
 =?utf-8?B?OTMvVHRGcm9heFlJVi9xc0JrZGlpc0FLa3lxM2oxSzVKMnpGcjRvWDJvbUox?=
 =?utf-8?B?MUw3aXJhVnNQeFIrcENyZVVicDloYnVqWFR0YVkycHpTN09aamJneWQwdmJa?=
 =?utf-8?B?YkFPVFliUXlHVEtpUWE4Z2hzVHBYN0Vlc0J2eU02ejdFNGxvSnZoL2lzY3NV?=
 =?utf-8?B?WnpSZXp2Y2ZnM3d3MkFoU2Y5MWNMajRzZVhJYnVOWGNid05NREhOOG5vY3pE?=
 =?utf-8?B?VEpmOXVrTXowWmhQQVIrOEp4TmpaTGFOOW9QMjVyTFVoMitvY2thR00xdVQv?=
 =?utf-8?B?VklzSEhKLy9aVjY0SmgvNzZrMWE3TmdDRW14RGxVZ1F0K0hVa2dqaVR4V1pl?=
 =?utf-8?B?RVpWUnU0dk1oRUhHU2E4Z09yQUZDK3BkM2VRN1J1MHNYKzNUV3Iwb0tvdjJl?=
 =?utf-8?B?OUVnOHlEWFBFczN3VWpOWnk0c21OOGJvaXIvM1JnN2Nva2Nvemg2eERWVFRk?=
 =?utf-8?B?d3JtdktkVnRWZG0xM3pyU1lKSjUwc051MHdlNjlNUTU3WEkzQkNjc2dOUU9i?=
 =?utf-8?B?UnBuMTZhNTVieW82RHVwaGw1YlpjdEwycU1DYkdob0NXelgveWdsalk3TUlB?=
 =?utf-8?B?R2tXTll1R21hUUsvMmI5UDJyVU1CSjVBZVJUMVBxLzJBaXNueC80TnlDU2RR?=
 =?utf-8?B?M2UrUG8vM3pJSUZtMzJ4czlTUk0wcDJJVm5NUFJKellqa3FrR2E3K2U2VGs5?=
 =?utf-8?B?bS9GZExIWkY1OFVaSHBHVC9ucHdsMVluOTIrY1MxeHZJR2N6elp4VkJyUkNr?=
 =?utf-8?B?L1JHMklRU0N2OEEyUDNLMEk0c2VqcXBVTDUrd1NyUDdIWjFpOFJhcllERFlG?=
 =?utf-8?B?WTZhR1pnK2xaV2taS2RLaWZNWGRhL09aZ1lyeDQ2aldHdlVsK056aGgzQU5U?=
 =?utf-8?B?SEVwWktieUZwbkJ6QldyM1EvTDF0WEljZTdWbE1xZUpLdStoK25GajVqUi9Q?=
 =?utf-8?B?M2NCNXZnNHNqYzFtYk1wK1pjU0tRNUI5QjI3NkVjbTVaV2NiUkZMTnd6amww?=
 =?utf-8?B?c0F5ejZaL1lJLzRDL2RZWW4xRDQ1ZG1DZGxzczFBWCtNOXN4RXU3cGd0QnNx?=
 =?utf-8?Q?lOn8p76ozi7mInjE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RHACOtOj6n12SJw5FSr8htd59NEqKDMpZ0YOvS0TiBguY4xg2nJwwC92ICwXqqSUBCjSxZ2UXItJwxLC+AKxj+RG3zr/a1/oBoWHcjlJikdNhk2zpU8zhsWE9ZCZCakLLbqa9QVJ7FhwHtcZgMn1ANu2oPjLOs73t4ydBYqwGAaL14u/oRKfPPGp7thXsRJO1FAzSccshET40jvJ/3J8O+Bl7MkDIkrO7OvqdVOlc4qzhreseTf/GF4UAECbDT2yQOEQm6n8LR+dyf7/t7dZg6MM3ttfS/+bFvzIVfc2eiCYiAtRitv5c3M9YOsq7eX5hqX64ECrQzQPLvLNMYyBV9FnWZhIksnApyGe17T/Vm2O/4LbAdVtRuMS4Yf5k0luK67UkjLMGR7bFFTZ5FiFCCLcOf2AmBD4yKg+h+CZV8PeireFX5ZUgeDtsmcHUZ/sbIDzsG0/Y6HP+9M0wjdFqbGHLc/e8hgBrAjswyKDuXwmz7PC0QthVuV6bsv3cAwL11l5FGwu+BN6LqbG2Qc5a73A2aPWlIkDxBpjJAYoHGfs194BLh8Qccav77TL6GCtclDZcOAOqliy1FKnOQir4Tx6y9hstV4xaH8Q4/UiNzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b14c9c7-27a4-4866-7208-08de52724310
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:06:24.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnDUsj0YSBY3v6ulffk5fbldb3zbTnoIvjNlM5U4soSMCzNoughMokjnRzlL3Lr0JY9hrkBWt/gv5pCGKbm6i7b5l4/yKxjHYHn5IE9HQds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130057
X-Proofpoint-GUID: zgWkNsxTdTi-qtfrDYjLCHhRINcawELa
X-Proofpoint-ORIG-GUID: zgWkNsxTdTi-qtfrDYjLCHhRINcawELa
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6965eef4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=dHxpzvolIU7PBfdXntwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1NyBTYWx0ZWRfXz7yqLuWUTWev
 HI373icFCTTykiN+jJPP9Ryu8Pb0qsgQRrx5wnNvvmN0mETL1v5EARn5PnsE97L8vxQCW6IeYyX
 QSDN8V/7W52qRTLkavg/S/5tqxLIwRlWolL/ZJysAbskUqiIj7byVCzIBLdC9JkIhCDmKnWsxJZ
 9691BfjFPjR8sN83zbe1hCCV0rE473PMEM1rcdUoxcHjEDFdogOSJm0r0fNqGnXmMnhplQOWe8t
 dqkJKuG0uXm9owNysnN6M7zKTjy54ZpFTP1H7l89rr+HsbLcAI4Y1e41gJ2ANT8Fg/K8UAMLo5e
 zAsoudnWPdDnT1ttFhPyI0cynw6lP3A1axM1p9xc0xOtAaNKChrlI9Akv1f1WZYhwzFsPtBaZJs
 Ue/xNdZ1ptl7FVbuRTXeMVihJZTQVJ/zNJsXTIy5D261myBdPZyzAlt1/idsGDZ/QjcgVVcUfTx
 EFHoS/NHe/RHzLTVbmlLE+/fjH648Xky8Ynb/mVg=

Hi Crhistian,

On 08/12/25 6:17 PM, Christian Loehle wrote:
> On 12/8/25 11:33, Harshvardhan Jha wrote:
>> Hi Doug,
>>
>> On 04/12/25 4:00 AM, Doug Smythies wrote:
>>> On 2025.12.03 08:45 Christian Loehle wrote:
>>>> On 12/3/25 16:18, Harshvardhan Jha wrote:
>>>>> Hi there,
>>>>>
>>>>> While running performance benchmarks for the 5.15.196 LTS tags , it was
>>>>> observed that several regressions across different benchmarks is being
>>>>> introduced when compared to the previous 5.15.193 kernel tag. Running an
>>>>> automated bisect on both of them narrowed down the culprit commit to:
>>>>> - 5666bcc3c00f7 Revert "cpuidle: menu: Avoid discarding useful
>>>>> information" for 5.15
>>>>>
>>>>> Regressions on 5.15.196 include:
>>>>> -9.3% : Phoronix pts/sqlite using 2 processes on OnPrem X6-2
>>>>> -6.3% : Phoronix system/sqlite on OnPrem X6-2
>>>>> -18%  : rds-stress -M 1 (readonly rdma-mode) metrics with 1 depth & 1
>>>>> thread & 1M buffer size on OnPrem X6-2
>>>>> -4 -> -8% : rds-stress -M 2 (writeonly rdma-mode) metrics with 1 depth &
>>>>> 1 thread & 1M buffer size on OnPrem X6-2
>>>>> Up to -30% : Some Netpipe metrics on OnPrem X5-2
>>>>>
>>>>> The culprit commits' messages mention that these reverts were done due
>>>>> to performance regressions introduced in Intel Jasper Lake systems but
>>>>> this revert is causing issues in other systems unfortunately. I wanted
>>>>> to know the maintainers' opinion on how we should proceed in order to
>>>>> fix this. If we reapply it'll bring back the previous regressions on
>>>>> Jasper Lake systems and if we don't revert it then it's stuck with
>>>>> current regressions. If this problem has been reported before and a fix
>>>>> is in the works then please let me know I shall follow developments to
>>>>> that mail thread.
>>>> The discussion regarding this can be found here:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA-b9PW7hw$ 
>>>> we explored an alternative to the full revert here:
>>>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/4687373.LvFx2qVVIh@rafael.j.wysocki/__;!!ACWV5N9M2RV99hQ!MWXEz_wRbaLyJxDign2EXci2qNzAPpCyhi8qIORMdReh0g_yIVIt-Oqov23KT23A_rGBRRxJ4bHb_e6UQA9PSf_uMQ$ 
>>>> unfortunately that didn't lead anywhere useful, so Rafael went with the
>>>> full revert you're seeing now.
>>>>
>>>> Ultimately it seems to me that this "aggressiveness" on deep idle tradeoffs
>>>> will highly depend on your platform, but also your workload, Jasper Lake
>>>> in particular seems to favor deep idle states even when they don't seem
>>>> to be a 'good' choice from a purely cpuidle (governor) perspective, so
>>>> we're kind of stuck with that.
>>>>
>>>> For teo we've discussed a tunable knob in the past, which comes naturally with
>>>> the logic, for menu there's nothing obvious that would be comparable.
>>>> But for teo such a knob didn't generate any further interest (so far).
>>>>
>>>> That's the status, unless I missed anything?
>>> By reading everything in the links Chrsitian provided, you can see
>>> that we had difficulties repeating test results on other platforms.
>>>
>>> Of the tests listed herein, the only one that was easy to repeat on my
>>> test server, was the " Phoronix pts/sqlite" one. I got (summary: no difference):
>>>
>>> Kernel 6.18									Reverted			
>>> pts/sqlite-2.3.0			menu rc4		menu rc1		menu rc1		menu rc3	
>>> 				performance		performance		performance		performance	
>>> test	what			ave			ave			ave			ave	
>>> 1	T/C 1			2.147	-0.2%		2.143	0.0%		2.16	-0.8%		2.156	-0.6%
>>> 2	T/C 2			3.468	0.1%		3.473	0.0%		3.486	-0.4%		3.478	-0.1%
>>> 3	T/C 4			4.336	0.3%		4.35	0.0%		4.355	-0.1%		4.354	-0.1%
>>> 4	T/C 8			5.438	-0.1%		5.434	0.0%		5.456	-0.4%		5.45	-0.3%
>>> 5	T/C 12			6.314	-0.2%		6.299	0.0%		6.307	-0.1%		6.29	0.1%
>>>
>>> Where:
>>> T/C means: Threads / Copies
>>> performance means: intel_pstate CPU frequency scaling driver and the performance CPU frequencay scaling governor.
>>> Data points are in Seconds.
>>> Ave means the average test result. The number of runs per test was increased from the default of 3 to 10.
>>> The reversion was manually applied to kernel 6.18-rc1 for that test.
>>> The reversion was included in kernel 6.18-rc3.
>>> Kernel 6.18-rc4 had another code change to menu.c
>>>
>>> In case the formatting gets messed up, the table is also attached.
>>>
>>> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz, 6 cores 12 CPUs.
>>> HWP: Enabled.
>> I was able to recover performance on 5.15 and 5.4 LTS based kernels
>> after reapplying the revert on X6-2 systems.
>>
>> Architecture:                x86_64
>>   CPU op-mode(s):            32-bit, 64-bit
>>   Address sizes:             46 bits physical, 48 bits virtual
>>   Byte Order:                Little Endian
>> CPU(s):                      56
>>   On-line CPU(s) list:       0-55
>> Vendor ID:                   GenuineIntel
>>   Model name:                Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHz
>>     CPU family:              6
>>     Model:                   79
>>     Thread(s) per core:      2
>>     Core(s) per socket:      14
>>     Socket(s):               2
>>     Stepping:                1
>>     CPU(s) scaling MHz:      98%
>>     CPU max MHz:             2600.0000
>>     CPU min MHz:             1200.0000
>>     BogoMIPS:                5188.26
>>     Flags:                   fpu vme de pse tsc msr pae mce cx8 apic sep
>> mtrr pg
>>                              e mca cmov pat pse36 clflush dts acpi mmx
>> fxsr sse 
>>                              sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp
>> lm cons
>>                              tant_tsc arch_perfmon pebs bts rep_good
>> nopl xtopol
>>                              ogy nonstop_tsc cpuid aperfmperf pni
>> pclmulqdq dtes
>>                              64 monitor ds_cpl vmx smx est tm2 ssse3
>> sdbg fma cx
>>                              16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic
>> movbe po
>>                              pcnt tsc_deadline_timer aes xsave avx f16c
>> rdrand l
>>                              ahf_lm abm 3dnowprefetch cpuid_fault epb
>> cat_l3 cdp
>>                              _l3 pti intel_ppin ssbd ibrs ibpb stibp
>> tpr_shadow 
>>                              flexpriority ept vpid ept_ad fsgsbase
>> tsc_adjust bm
>>                              i1 hle avx2 smep bmi2 erms invpcid rtm cqm
>> rdt_a rd
>>                              seed adx smap intel_pt xsaveopt cqm_llc
>> cqm_occup_l
>>                              lc cqm_mbm_total cqm_mbm_local dtherm arat
>> pln pts 
>>                              vnmi md_clear flush_l1d
>> Virtualization features:     
>>   Virtualization:            VT-x
>> Caches (sum of all):         
>>   L1d:                       896 KiB (28 instances)
>>   L1i:                       896 KiB (28 instances)
>>   L2:                        7 MiB (28 instances)
>>   L3:                        70 MiB (2 instances)
>> NUMA:                        
>>   NUMA node(s):              2
>>   NUMA node0 CPU(s):         0-13,28-41
>>   NUMA node1 CPU(s):         14-27,42-55
>> Vulnerabilities:             
>>   Gather data sampling:      Not affected
>>   Indirect target selection: Not affected
>>   Itlb multihit:             KVM: Mitigation: Split huge pages
>>   L1tf:                      Mitigation; PTE Inversion; VMX conditional
>> cache fl
>>                              ushes, SMT vulnerable
>>   Mds:                       Mitigation; Clear CPU buffers; SMT vulnerable
>>   Meltdown:                  Mitigation; PTI
>>   Mmio stale data:           Mitigation; Clear CPU buffers; SMT vulnerable
>>   Reg file data sampling:    Not affected
>>   Retbleed:                  Not affected
>>   Spec rstack overflow:      Not affected
>>   Spec store bypass:         Mitigation; Speculative Store Bypass
>> disabled via p
>>                              rctl
>>   Spectre v1:                Mitigation; usercopy/swapgs barriers and
>> __user poi
>>                              nter sanitization
>>   Spectre v2:                Mitigation; Retpolines; IBPB conditional;
>> IBRS_FW; 
>>                              STIBP conditional; RSB filling; PBRSB-eIBRS
>> Not aff
>>                              ected; BHI Not affected
>>   Srbds:                     Not affected
>>   Tsa:                       Not affected
>>   Tsx async abort:           Mitigation; Clear CPU buffers; SMT vulnerable
>>   Vmscape:                   Mitigation; IBPB before exit to userspace
>>
> It would be nice to get the idle states here, ideally how the states' usage changed
> from base to revert.
> The mentioned thread did this and should show how it can be done, but a dump of
> cat /sys/devices/system/cpu/cpu*/cpuidle/state*/*
> before and after the workload is usually fine to work with:
> https://urldefense.com/v3/__https://lore.kernel.org/linux-pm/8da42386-282e-4f97-af93-4715ae206361@arm.com/__;!!ACWV5N9M2RV99hQ!PEhkFcO7emFLMaNxWEoE2Gtnw3zSkpghP17iuEvZM3W6KUpmkbgKw_tr91FwGfpzm4oA5f7c5sz8PkYvKiEVwI_iLIPpMt53$ 

Bumping this as I discovered this issue on 6.12 stable branch also. The
reapplication seems inevitable. I shall get back to you with these
details also.

Thanks & Regards,
Harshvardhan


