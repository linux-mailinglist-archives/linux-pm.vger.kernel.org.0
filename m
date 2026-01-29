Return-Path: <linux-pm+bounces-41675-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG4bNDc1e2mGCQIAu9opvQ
	(envelope-from <linux-pm+bounces-41675-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:23:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F406DAE96D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 747FE3004CAE
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067953002DF;
	Thu, 29 Jan 2026 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Uu5JJh+9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qndKDNwa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B633D6C9;
	Thu, 29 Jan 2026 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682226; cv=fail; b=XJY3BrFT4/FYjJqB1O+4IhZxLEP5V+5/VffBjCRKPoxTI1/ITpvpJbGqUOAI9t9Jc9ey/0UsOjn1LpCOablkOrvLDXTWOmpYa4W0BuRcZ+ZykEyd0SxSBqFuR9STxpo2wTqQGExfjmdu9GnBcs+kPeYSmbxBYjqwYClEahCaydQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682226; c=relaxed/simple;
	bh=i6K92ZqFgxYNkrALjD0GrdHQEGzHOBg6LkxPjJHWiKM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncwcywj+jVsRVtp19CmNWX8qBVspDIXHkETDmt4RMAxk32H8x2iCMX/86oaRv4tp/wxuN8CcrzrclHL9du9fEnI3N6ptHS1kHU7LRGKJp+YiKKIpnqHdoG2htVNVjRtqqlFN01W2B7njPKMcTzSJDe3OgDgjf/CdmQAWZTr4Jzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Uu5JJh+9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qndKDNwa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T6p3Nh1231016;
	Thu, 29 Jan 2026 10:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i6K92ZqFgxYNkrALjD0GrdHQEGzHOBg6LkxPjJHWiKM=; b=
	Uu5JJh+9QZphXthQF1xHvjm6ERY4Fjnei8K4MEABhnJATqwZcQ25HctJxPRGw3I/
	Zhvh3h0NxZ/CDK1y931gCuSFgRdd+4bQBFA2eZIN5fCuxgRN2nmFfOh8OXH47rXU
	Ja7C7r8W8KEfBpjNcqXdbxjH2g4CEc7iUplWghaN45nQfR35yrGHPc5vr+DWJbzs
	OHwDcC0xYz9HpssfEBILCDyKU0wx1TOzdD7TkEBmSMyjbr7e0ViMgka2q0YaaRw0
	vyeV+GtpvmUFcIzlyCzPOkx2nLpMEYbwlYDFQ1rvBCGMAxRw9nlZLxKvFGblDLqt
	wgR4Ih5Zs/47bD+jyueEOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t6an5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 10:23:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60T90mPN036091;
	Thu, 29 Jan 2026 10:23:34 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhredu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Jan 2026 10:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPJvR+cZEB095QHyokeMtth6VKFhVE3Ke19FHKNyODctHKGg4GUMqTKZV5bSMIXbDj3YoVGrY2Oc3Lwvp7ldK4XQsReRqACbo1fs6QKN2/hgUxj3yIByvpEC2+GvAfdPCXw989aZMamEHbj4II/rx56nkjGQ4wWV1E2ElBAzKV7qgJr8VRgfkGFfKYMjDqvmSHVoothrK8jZhznFefubGoXZYIHdLZXFl6jZN2Ix2FJ7IMxkts5C6q6v/V0C8zyUWv7RSkpzhHREq0oa0lRR9CLMO05Q+BnF15ntKVdqrVFyj1UU9oqbDMP06GmT3cVD7fqUHqkNsM0QeJNTFCfX1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6K92ZqFgxYNkrALjD0GrdHQEGzHOBg6LkxPjJHWiKM=;
 b=VVaDUqMqistbGGfh7fyHCIXXdYSNcBrI2k2eAClAXyj42/NKoGQDrBWfgSSx6shbWg/E/P+IvSDDJ0DwpAJGa8kkkiuggni/JiHC3g73qJ1ITmbahu/C9qFvEeMMLyvjfko6vkGtT2ZAI/KTi8yNuSO8FZ5vUWIt3jK7Rzgb1Nr8Ey+dGbY1ddc4exSNj/Cr6VT+8LlsipuMpR4W9LrB4Sjd43+uWpTZ110xBKItnedVKQP+Knkk5qh5TGS7kBR04OipYBQ1Haw811V+8KIksNx7+fmiQic4oSf6HRlCloH8fmOd5QlU3R+r6QRYGYPFFhDTrNh4UmijAnMmTgruWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6K92ZqFgxYNkrALjD0GrdHQEGzHOBg6LkxPjJHWiKM=;
 b=qndKDNwaqQC2eWCTmrctTYUbWVYnM3lB1yziwxq477Yym48+Sin46DdxYqpk7d8XSFM3W2ges1dUTlSmLFOqAZmh6tYphApE1YTrHBonh/njMnUunLjPQT+1pQUrFAfknYssWYWAiXujOdiw4xHHVaHUOZSrYNf75QI26VL2keY=
Received: from CY5PR10MB6165.namprd10.prod.outlook.com (2603:10b6:930:33::15)
 by SA1PR10MB6296.namprd10.prod.outlook.com (2603:10b6:806:253::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Thu, 29 Jan
 2026 10:23:17 +0000
Received: from CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc]) by CY5PR10MB6165.namprd10.prod.outlook.com
 ([fe80::93e8:4473:e7c3:62bc%4]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 10:23:17 +0000
Message-ID: <b2797511-c395-4986-8925-edf5f827505b@oracle.com>
Date: Thu, 29 Jan 2026 15:53:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: "Rafael J. Wysocki" <rafael@kernel.org>, Tomasz Figa <tfiga@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Doug Smythies <dsmythies@telus.net>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com>
 <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com>
 <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com>
 <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
 <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac>
 <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
 <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
 <CAJZ5v0h2CmeRGs-4viKrVu9OOFtepiDqXTAoY2bAia4JMRFcqQ@mail.gmail.com>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <CAJZ5v0h2CmeRGs-4viKrVu9OOFtepiDqXTAoY2bAia4JMRFcqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::8) To CY5PR10MB6165.namprd10.prod.outlook.com
 (2603:10b6:930:33::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6165:EE_|SA1PR10MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: c2cc0520-879c-470b-3657-08de5f206ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1VvTTI0MDZrdXBiUnRPNFFua21LU3N4VE04VkNQMkZTM1VOaldzVEdIZm9q?=
 =?utf-8?B?aWFva1o4NlpScHZDbEtBSkszSWdwaVpRcXlrSmxCYlhjby9VUTdXVUNMd3dn?=
 =?utf-8?B?dXhqdmdVNFRCaEV4VjhzT3U3Rnk0aXdpK2REbjlNZCtwdlYwQ0lwRGpsSjJV?=
 =?utf-8?B?ZThSTWdaTDZuOXV4dEpkNDlreVZleTVFNStEeXpCclB4N0xraEdVUjBkS3ZZ?=
 =?utf-8?B?YUNIYUFpU2FaMExxd2hBQUxSKzJ1L2QyeDZTSnk1S0dkZHZ0MjRXUkl5YWpN?=
 =?utf-8?B?QUlOYjhtbTc3N1luaFBRU3FUTnl3VDNFRDAzaXkwV3ZBT2pEN0x2ZVN4QUJ1?=
 =?utf-8?B?YTBMcDBtbFJhQ3puSlpnQ1NSU2pYZHlUb0pNalA3QkY0dy9kak5yaWJSTHBZ?=
 =?utf-8?B?U1RKbkpoQmJGdGViNGtGclpTWmFhSlN4d3NnVVh6QndIRXdYbm16TUFwOGFa?=
 =?utf-8?B?c25uRUpjRzF4QjAwcVR2em5RZEdlTUJRdDd3NGptVnF5Y0VObGUyeGNJZEQ0?=
 =?utf-8?B?eC81SEYxbEVwdTJuempKMU81VmxPdG81Y29hdmJyTnRSeFNINTFkMDFMcVVV?=
 =?utf-8?B?bWNJcVQ1eWFVY1VvdXlHeHFaT0k0TG5ORFBTbmovOHBNMGNmM2cwZ2VsNFg0?=
 =?utf-8?B?TzJad3JWZ1hoUTRQUzZwcWJDRHBtQTBOcTFiZUNiZVZTM3RUZXNsclA1QUZ2?=
 =?utf-8?B?UHNQdTR3di8reEp2bFE3RlRrQUUyMnZUaUlHNUNhdi9pc3ZzRnRWRG9pcmJN?=
 =?utf-8?B?T0lrYittWWxMZ3ZpRzY1TTlaOXhJRGU1UjlQQmVQTTVRVlpaUmV4ZUhNeENz?=
 =?utf-8?B?OXpmVCt5c1BlczVlSVB1TUVTa1JDSjRPU0pXb1ZSL29lbVd5MU9OaDROVldm?=
 =?utf-8?B?UzQ1eHlFU1p1c2V2YU1wT3AwK2UrdDZKMktYWHBpOGhVbjZhb0hHbUdjT3gz?=
 =?utf-8?B?SUMxaURLRmUrRXZzbVhOY21jcDFTZ09teHFvSEhMTTZQZlp3SkdhVHpCbnd5?=
 =?utf-8?B?ZjhWdUd5YXJtWnZybEs1Q1FDYzVRcVhSdG5NZ3pLcnpwVldFbFZUV1U1YlN5?=
 =?utf-8?B?OFB5ZVByNlhLZkd4QmkyUTlDM1o0SWZoK0pET28zK0cvNWdhZ0xXaEJnYWRP?=
 =?utf-8?B?U21Gd0x2Ry9jYVp0S3ZzRWhMVWFJNDAvNkRmclZvZFdqa3QxdlhHY25OQmFI?=
 =?utf-8?B?M05OWHZZaTBidGZvQTkwVm0xMWxHU0J1bDFQNFozL2NvYUxRd3RuaFFBQVF1?=
 =?utf-8?B?QnpLZEhuRmlNdkswTVlraWRDTmpzSkpYWFJGL0VUVFQvMWFvdVlMMlU2ZkQx?=
 =?utf-8?B?bGdHR0NqbWlFazBtNVdremc3UnM3dWM5MmlGUXA0Q3JRTGZUZEpmVzdOcHhh?=
 =?utf-8?B?RHFMZWRTazV1bTBmUGZqQ3NxNEVWcHk5dmV5c2N6akdMV3JvUXNIS2QwWXdG?=
 =?utf-8?B?RWJEakMvZUhPYS9Cd0ZnSjdaRTNscEtLcnlhRE5XZ05iK3Z5MjAzR2dZK2M0?=
 =?utf-8?B?NGFQVWhjV3pDVFdIT1UwcExFRnJaZ0Zmb2RaTFV0OXZBZzhrQUR6SHFzNE9K?=
 =?utf-8?B?VkR1dXVRcUJnL05oZWgzVjY4SGpLdW1zTENNNUpmaWNKTkRmdE40eVg2R0Ns?=
 =?utf-8?B?Y0RQaVVMdEdWUjFHclJsM2hTeVAvbHZjVTZyLzhFQytvTVo5RHBUMEUyL0Y0?=
 =?utf-8?B?R0hHV0JJOS9TSE44T04xbjdPbU9vd29Bb3doby9qTm5TQVRIUG0zN3lOeTNp?=
 =?utf-8?B?bUtZQkoxZjFaTythQVJuRUJxamZQVjdJUkt1Y3NxL1NvSEhvclRBd3Jsckxn?=
 =?utf-8?B?VXJObVJ3K09HUTJMQ0dMd2NUck95ZjZuZFlpQ1YzVCtMWHlpSEdQVE51WnJH?=
 =?utf-8?B?Z1REc2R4WWRIZXVzemZkQWI3WDZkY2FpWGFGTk0rcDE4eCtXSHhra0xSVUJO?=
 =?utf-8?B?TTVZdTZhSHJpVThUbXR5eVIzWW5mNEZ5cnNEdlJIakJ4VE1ZRkw4aHlUNHdH?=
 =?utf-8?B?SzZzdndPVWJXSjdqOCszb1BMU2xlSXB6elRiLzRHYUdHcEpFVGt3TzBEWFQ3?=
 =?utf-8?B?TW5hOXUvSmlhNzBlUkRUZzJRRmQwQXllYnROaWxVbUZSWmYvZGVCd1ROSDNn?=
 =?utf-8?Q?WQcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6165.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmxiN1YwK08wQkUvdk15THFjV3g3alpsbWF6Z09qeVZNZld6ZmNwcjZMbGp5?=
 =?utf-8?B?TGtjVTJYR1NSb1R3NENUMXFqTFNJRkU0KzVPVWtmdnNsWEhkN1lGR01FS2hK?=
 =?utf-8?B?eGN6SUpEMXlESC9GMU1BV2g5TWVvMHA1Nkk4eGNIM2wwRDVESXcrUFo5d3ZQ?=
 =?utf-8?B?bnFkR0hXYk9ET1lLdFlmS2lGNDdXSXJqSFNGT0FUb2owbnU2VVlTVGp3QVZU?=
 =?utf-8?B?R2Y1eVA5Z29TTStxRGNjcWVQRHhNZHF4SkY2S25BZ1U2WnpJNGpwZURNeGww?=
 =?utf-8?B?NWZoUUIyOG0xbDZNUXJScVlZN1ZFVHVIT05vbDdlRS9TMmVMdVoraVJraEp4?=
 =?utf-8?B?SWxrMmZ0ZmNuU3VuejlpWDZBV3N6VEVJbTVYa05BUElSNUowN0RCS0ZJK2I4?=
 =?utf-8?B?bEVYL2VOTEIrNFNpcHVxOG5FcW83UjBsVGVZaVlVbnQwUmt4U29RNkxrOUFo?=
 =?utf-8?B?Tk40Y1J2QUVDNnYrcDRsOVZJU0pyRXllM1VTdlFxZWc1UnAzU0IzODNkaW4z?=
 =?utf-8?B?SGovemRaMUMvTm1iU1g4K3AyZnRRdGlNRlFHUmErVEFGZTQyd0FoVXF5clBB?=
 =?utf-8?B?a2MxUTJ4YTJmK2xGdnU0RGtwdEZ1a0FTZSs1SXRRWnFMOGZDRTV2TUVadHc1?=
 =?utf-8?B?OHdPOTRCRWIrNFRmbEVKbThxNEk1UTIrOGZDZWhWY2xTMUFhWjR1QzZTWFdQ?=
 =?utf-8?B?TlBaa1YwcUVHU0ZCd05FV00yaFBySER4eXdTbkh3Y0NKaU96REdXN3hZeENP?=
 =?utf-8?B?LzJOTHFUUmlqWW9lUytKMXRoWVhrZ2JWNHdnMG5tL090aFBScndxSjVWOUxU?=
 =?utf-8?B?MU91Y250QXloTnlXWit2aUFPalJZYVNudnpCSEw0bFhlSzhBanRrWVVhdlBC?=
 =?utf-8?B?WTJmZ2w4RUY5TFMyR3d2L1dZNWJ6MVZpSG9xNmJUN1c0NEtnOW9pTUc0dzFt?=
 =?utf-8?B?eWUwVWV2ZS9JYnlZejhIbTNYWjJ6TUZ5aGtyV1NDT1BpQ2xxN0hyRTBIQTBi?=
 =?utf-8?B?V3A5dlhwdkFjQmlXbGtIL0Y1REZnUWJ3eTFESXZTRWY1Q2Vad1JEdzBUbHIv?=
 =?utf-8?B?Zkw0ZWYxMXRDZnA3ZnV6NGdSWnNueDNndWhZMExKV3diYlNWQmNNWnkweTAz?=
 =?utf-8?B?QUR4dmlLazBWZUZCOFYzR1RidDZWSlZucFdhQzhDZEwxQ05vWk5MbTdMeDFK?=
 =?utf-8?B?cEhncncycWppUGZRN2dleVllS1lGS3M4dXgvR2tKR2JnZGU4OVdSYVdjMUo3?=
 =?utf-8?B?Mnl0eFNjR0dtKzJUVHlaL214bnJ2ZFgwZnlRblY1VUs2OVRDQ01oR0tLV0xo?=
 =?utf-8?B?SDV6Y0ZBeUNyTUlHSUt2VUFEbmpFQTlJb1YyUldIK2gzQWg5bXp6aXQ3MXAx?=
 =?utf-8?B?UDJuUEt5R0JGU0ZvdnpRWTJlRGRJMFQyUHV4TkQ3N3J6c09OYXJRYUFxTXNP?=
 =?utf-8?B?SHVOS1FkUElidS9OTUtJRjJOMThJQzFDbllkM3ZETXdubjRSZzJHTlF4ckk5?=
 =?utf-8?B?NW9uMld3ZVUzblllYXVUajNrV0RlaTlFSFV6U09IY2xCWWl4Tm1sRWVMVjNl?=
 =?utf-8?B?dWhrTTlERXhVaU93RkFPaDJUNXQwM21odFNjRUlRMXRYcDBYV00rUC91cEk4?=
 =?utf-8?B?SmMweFMyNlpEak0zd2g0bGRJUHB2dlFhSWZTa0RSZVVLOEdnY0VGQ3NTZFVS?=
 =?utf-8?B?TjArTm5tQldwMllPSEdyTHhEOGxQZ0VtMjV6UWdobFpaTWxJSVA2SnlwVXNi?=
 =?utf-8?B?WVBCOStERGVJVDhCTjFSVkRmTEViTk9HR2lKSVVzMnMwL0loNy9TM3ZEYnBa?=
 =?utf-8?B?NDZxb1NjK3R5TC84MVB4d2FST2JyTjR1SEhSQ3J5bWRZWkoyUERWN1JyMDg0?=
 =?utf-8?B?QWZkeW5iM2xVbU1SaWVEMUFweUhVQUpLdTJKMzhKcG40QVo2eGJTUmtRcVJX?=
 =?utf-8?B?KzdUOGduSXBDdlVobGJQQkxCOUJUVHVXdEU1aHArNkEzbWdOeTE5REZuY0JF?=
 =?utf-8?B?UDBsbFhEYW5rNEp6ZG9MVGprQVoyODhWQnZkL1U0SkFvN2tFditJanE1NjUy?=
 =?utf-8?B?Y0x2VkIxUlBYbHFJSFUvVzljalFXT2lwMXVZa3I5WUVnL3pSZzJkUTlndXFa?=
 =?utf-8?B?bXVyMGFKV2ljUndBNmRhZWtleDVnRWJMa3JQVHpNeXQ4T3VieGVsU3d6SjNt?=
 =?utf-8?B?Snk1L1BQVjFYU0M5RjFrVDlEWGZtWHVJTnFhQWVBMjEzaEVua21idE1tS2l1?=
 =?utf-8?B?emhJNXhVU0Z5cDd5N29ZMjc5OHFDbmhRY2tmZW5NUXdaM3N3aTZPM2FBR2hZ?=
 =?utf-8?B?QXBYWTJpYk1nQWxVY1lrWW5nYUFqTU84bHJuUEpKb0VQdU5SYXNiRWE1WGYy?=
 =?utf-8?Q?xDZi6z4F1WgzHKiwRY2MqzkNBBjh1ybkz/HfmhBfxDevO?=
X-MS-Exchange-AntiSpam-MessageData-1: tNuvVoxnsjdYLUN3I6xGbR6uGsj9Wvt87l0=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pXRd3L9cz0o3cIuFm9q8CKtKKJPbuIw5lBfv+ANhG6OiLwsDpv1QCPV+D+aLHvirzeanymkeVOeY42qlqKsr8KVtURUAyF/LKLiLzaq8d6JZEtFJXNF7UsKmQgL9IXGN1fVrylqjkqrElrY1m9f1FF8JHcpDI4imAJAi95VuJjsOeW7JQNMCMTweUcXiwFvqmgHBSD3GgKZVwTnwYoVy+Rbj/1/+o7RiYWf5cBX9D0UsJkao+t7sepbcY7nuN3mv2xKenNEyPefqXu6gDIUAF+ncUOyzC1GfUX8BJ3YR231m6SUtBrWDpFCuWZUnvAJtSMWFaiCx6pWtH105mtPcCVwWQEHMjEjon886Ry5yPc6gBw1kJ0rXV1eot8oGtS+zJocCRyGB/u+qg3fA3O8z809qirzRBVfPBKWoDXjN3M+9O8K2wxiYg5PHjzQPulnzfL+sGsHPcFyK0BMD+6dQAfAkRpmhRWJH6iqimgIouepx+1PTeDTz+xDWCcsVdMCFtCiMwGazU/6leyjmlXqj11CTEFpe8qMZ1XJ9r1k5/W6F8o5c9JaLxqQ9UCoao+0XTyD4r+Pw+GclOjzXz3lKoboPlkMou0TWr3AnuQ1TmDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cc0520-879c-470b-3657-08de5f206ae3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6165.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:23:17.6737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk2dqz4Zc3n3xmng426w+hrjU7vbobMSS0s5qJY9EHqq2jGkGL+i/eLVRzqVuJjFMGEU59jEU5jjcbs+ZF1gFau4TIzzqt7WSQrKkI99oqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6296
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=971 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601290068
X-Proofpoint-ORIG-GUID: hwCYFPsFtieDEKarDAVztshgnU8ROawS
X-Proofpoint-GUID: hwCYFPsFtieDEKarDAVztshgnU8ROawS
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=697b3528 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=cm27Pg_UAAAA:8 a=bOoKwz0E8_KdavgGivMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA2OCBTYWx0ZWRfXyMeiI7Esy8qy
 DBY7S6mtC3wmQtvTAZ6QpJrEBJ1Q2CPC0VBgQOG+SNcZZIAKbkgD5UR08d3wCOyZabNzKa3Oa62
 UYNncvSzj2ZvYXcFqm2iDd3yLDDkR+1PvGG5CUoyt4Fd9+AabW9bl90/6Vc7u0Nm4S7tvuIRwLM
 n9SBE4CiNvDb//zCOI8xrXdL9igdO5cUOHSh8kN13GburA7ixVz1UG2OcYyl2qNvCD+YFcZo4V6
 BjRMRZXp1d1DyBAtd5oWjsPZFpywhNM3Ezp8ThLEfJOh/xA3V73Km9Qs0rxPaM13uai4s5Cl2SB
 D4oxPMSuan6jqCAgj6RH9bD4WovpVWwzrUY4A0sS9W5ws3kE4v1RSnmELyxjmGMte0Ld5Ync/b6
 RRgizGFEZL75KTrnfZXDY1ANcMPXZViUIObdZXH53imfHgAy0/VYjQWfMnIvOqlGzLxeCcMuvra
 7B2ihP2q0D2oBAhDJAzUN1hHdpRMGC7E3MYD1YmE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-41675-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,chromium.org:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshvardhan.j.jha@oracle.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F406DAE96D
X-Rspamd-Action: no action

Hi Rafael,

On 15/01/26 1:37 AM, Rafael J. Wysocki wrote:
> On Wed, Jan 14, 2026 at 6:16 AM Tomasz Figa <tfiga@chromium.org> wrote:
>> Hi all,
>>
>> On Wed, Jan 14, 2026 at 1:49 PM Sergey Senozhatsky
>> <senozhatsky@chromium.org> wrote:
>>> Cc-ing Tomasz
>>>
>>> On (26/01/14 13:28), Sergey Senozhatsky wrote:
>>>> Hi,
>>>>
>>>> On (26/01/13 15:18), Rafael J. Wysocki wrote:
>>>> [..]
>>>>>>> Bumping this as I discovered this issue on 6.12 stable branch also. The
>>>>>>> reapplication seems inevitable. I shall get back to you with these
>>>>>>> details also.
>>>>>> Yes, please, because I have another reason to restore the reverted commit.
>> Is the performance difference the reporter observed an actual
>> regression, or is it just a return to the level before the
>> optimization was merged into stable branches?
> Good question.
>
> Harshvardhan, which one is the case?

The commit first introduced a performance improvement and then with the
revert it returned back to the baseline.

Harshvardhan

>
>> If the latter, shouldn't avoiding regressions be a priority over further optimizing for other
>> users?
>>
>> If there is a really strong desire to reland this optimization, could
>> it at least be applied selectively to the CPUs that it's known to
>> help, or alternatively, made configurable?
> That wouldn't be easy in practice, but I think that it may be
> compensated by reducing the target residency values of the deepest
> idle states on those systems.

