Return-Path: <linux-pm+bounces-29610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312F2AEA55B
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 20:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894391C432B9
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3E2EBDC8;
	Thu, 26 Jun 2025 18:26:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04533339A8
	for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2025 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962388; cv=fail; b=YxvMEe+7qpuMQKULjOk9r1idtWvCLdncXJZq8mVWprUpqKIX4ute0NRxDsFZOOpAZM3Qh5ElqSuPntLwZ+pSsZCxkF2Jj4Cx19fHHZGVkDKuQ0qUMpuj/6jJM4bYcbXdDU+N8X7kb0a5m31GwKgfV3wCoLv2X6DWl1mrHckFqSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962388; c=relaxed/simple;
	bh=q3istWlnqnX7w8Q2buUM11jgVOiOPHbhVUk6XIJ/0dI=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=JdAtAKIfcTFqr4rhYqNnPzRkP1SfrlUu1GmW2il0neuunyhIU/SIQe5HbMJX2DyMZ/23apfLs7Vgoo4wj9FjcaPuRKtPKpM44h7us3DxxfBXtIoGLOrdJjz6wD5t3d6LUUU0P9jrmHLo+v3WMz0pl+1q3rw85WZN8jrCbJ/wM8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q5BAoP011527;
	Thu, 26 Jun 2025 11:26:10 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47dv8mnn37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 11:26:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR1JTGiOYt661NggF07apN/aJwlm+8mSdK3MddrQrfdnRZ3EsVEIFd/XcyTps8sTbOl/QZ/kyc8hxueBroEkGBayQzpnaNFAqz6FNuCxHehHk9rcpdXW7eYOWPq0Xasbp0vMRQI1gEBeKmny9hSRhQyuk0afK6DuVGHSHJk5sdckA6iTLhBLl5T0T9Gf46SvcNkSEXvUxcllHpZGFJzMyw07+HbTPwso0BCMXPG5N+iyznHIwKbw4yZeL9VDDFSmV3JdyTb41PDOHRl7G61tq4csj0GVyfE636EN409xIGpc5H5zF+e+hg4G5Xkzm7dxM2b+Pvc1ONYMqKshARn4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE0q3Z//gWrCrE7Rc/PNjrCjLrmRcWdsITAohCKHX6M=;
 b=u8loHxIT6MCkHNu1ymxRk7yHE9Gz1WpB20j6SR2o1H0g2jo+9eJKUg+Ty4GTQR3Le+ceReOrKbYh02j1/Y5Qd4WPglNDUfJE1CvP4hdaOVyHKg1kSe4tbncbqiBqmhceyCS7edtrJG5uqKqOro5noMKfh3f7uvnHFTh8uF8Yx8iZdCPrRIMZh1Jxn63GQR5bFACo5VbP1wgrXTs7wUFx0mkwAOM9GaCYGEpi3kfNRdLZkHoIXgyG5daeelzfnW6LYWFz4mNNPspjsdCh5cukFs4uE5/cnjd6Y3C9PQp70Ph0VSqMiRE0JGyXSakJatyUUXXhbVeBSOSuRfNrdpKhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB8806.namprd11.prod.outlook.com (2603:10b6:8:253::19)
 by IA4PR11MB9345.namprd11.prod.outlook.com (2603:10b6:208:56c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 26 Jun
 2025 18:26:07 +0000
Received: from DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8]) by DS7PR11MB8806.namprd11.prod.outlook.com
 ([fe80::fd19:2442:ba3c:50c8%5]) with mapi id 15.20.8880.021; Thu, 26 Jun 2025
 18:26:07 +0000
Message-ID: <0dd1f3be-3bdf-44c9-a6d5-623077714149@windriver.com>
Date: Thu, 26 Jun 2025 12:26:02 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: daniel.lezcano@linaro.org, kgene@kernel.org,
        krzysztof.kozlowski@linaro.org, linux-pm@vger.kernel.org
From: Chris Friesen <chris.friesen@windriver.com>
Subject: question about behaviour of cpuidle on 6.6...seeing *many* missed
 estimates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:208:234::34) To DS7PR11MB8806.namprd11.prod.outlook.com
 (2603:10b6:8:253::19)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB8806:EE_|IA4PR11MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f99fc6-cdfa-4f8e-8d4c-08ddb4deea98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlYzbGdMQXZHdjBvWTFocFo1a3hpYlZJRzZlV0hIQUVNYndjMHd6TlpOc0Qy?=
 =?utf-8?B?bEFaTnljT3FoVnpuYnpYQzIydHhJUU1EbnBlK2xFUHdwTEpGWjhWaXM1eE5O?=
 =?utf-8?B?VnhYdFJ5WnM3TjNJdk9EQzZXeTl4ZTVNcnB0Ym5rMDRPNVhjWHRSQndYLzBh?=
 =?utf-8?B?SEEvbFhBUVh2K2NUR1luaUJLYmw3eEFjZWFTWHl5T05OWjRuc0JpUTN3ZGho?=
 =?utf-8?B?emdPUnVxdnEycXIzZzNldWRTbTNHVVFqYmZiQ2tBYVkxR0g2cTJYUzdKV0s0?=
 =?utf-8?B?Tkw3WDFXdkgwT1QvbU1SSUQwY0NLVEEwcmZJNmRXM2g0cWFPMXJxMWExM1dz?=
 =?utf-8?B?M1Rkc2UvdUxTMkxEZTN2RXFwZDZXclFnK0Q4WnZYanhITnVpWW5rbFVVbzZp?=
 =?utf-8?B?dDkvTVBGNG4vdmEyNGF2QnlJZ3VGUGFwM2VUeHIzYm11UElZY3VmeThLQW1H?=
 =?utf-8?B?SVVqQWxNejlwNmwrYlhCQm5RdGRvUGpRcjNqU0Z3T2wrRmYzak1iZkRlbTEz?=
 =?utf-8?B?U1gxRktWeUFpS25JRnhEUkdkM1NwSGw5OEJkUU16MHJUL05zNFoyV3FITWhF?=
 =?utf-8?B?MUFqWWhQdFd0clI2OXdxTXQ3bDRLMS9WWGt3Tjc5MmJaazlIWVlMYXFmcUR1?=
 =?utf-8?B?ZW9HKzVDTjhLZ2poNmkwQlhMTmpFRldadFBueFdXUUhYMWZaYU1hQTJhVDNh?=
 =?utf-8?B?N1MwYkNaVnhMNUpGeWo5czc4RW1ZV1NKa3ptclYvSWxHb25uZTEwVHFiQ25z?=
 =?utf-8?B?R2JCcGtTbzNFNUhzUm5tNzlINmZZSUtwV0U1RGpZRUhRTkhkS01kOVV5YjJv?=
 =?utf-8?B?ZFZJMm5Tais4Y3V0VEp4Ym5jM3hTc3Y1NXVKR2VCYTVicWJJaUxvYk4vZkJG?=
 =?utf-8?B?RVpJOU01S29jTHhLYUNtVzJ1QUN4bzU4cVFUbS80ZVpCd29QNjUwdEw2K1E3?=
 =?utf-8?B?YXJxR1dPU2Z6dTk3VWRPVXNKdGZXQW90azFtY284bzdGVktyMWRoUWZ1LzdZ?=
 =?utf-8?B?SGk2a0pBYmZGYmhCUVJ4UmFZQU03Q0pkT281ekxBdW96NEV1TTV2QnA4K3JL?=
 =?utf-8?B?VytZREsyVzJWRTU1YWp2S3F1dFduZzhIekRHRnJLL0VkUzBlb2V1ckYyWXNQ?=
 =?utf-8?B?eDA3ME5zREFkVEtFckdzTjNZSWNtRWthV01XQm94ZHhGL0RMdTZIMnl0aUF3?=
 =?utf-8?B?SUV4VThuQUhDbTRjOFFyQmJsS3p4SkozeW54eXZjbk9BWE83cWxaYjgvNHV3?=
 =?utf-8?B?MFQ0Z0JNbTRyN1VwQVZGaWlRK05tdE5RSFJBTk4zVEMrK2k1ZkFJVlYzVG5r?=
 =?utf-8?B?VEFpUFR3YktJcWRUYXp1SkcyQ1pCR0pLdThkWm92QitxT2l4NFRZVWlrRms3?=
 =?utf-8?B?WUEzT0xPeUxvNTk0akx0b013a05QcVV0dTFKNUU5a3N1c1lHSUc2dytjZGNQ?=
 =?utf-8?B?eGl5M0I5bzNLb1d6Zjh0OHo4VmIvdTFVRnZlaUJiNW5lRE55YlZtMG5GRFl6?=
 =?utf-8?B?SHZoUzQrNzQxeERGZEVqd256TUtZSXQ4QXd0ZmxGa0RjQ1dURUlKQjdJejJl?=
 =?utf-8?B?ck1wNGVmMUpLdHR6K0VONGs0NURFTnhzY3kvQndGb1B0TmFhR0FLd0w0YlZk?=
 =?utf-8?B?blRzcW1DNGVzL2czdW9kS01UeFYzUk1XczBkcVlOYzVsZ2FqTVkwemJ6aDh2?=
 =?utf-8?B?VzFud3lCUXdDeEVuYkxjM1IyUklEU0NRUXE3TGdQUXpWM3YxUmFRUkc3N2hN?=
 =?utf-8?B?eVlhdUJZUUE2TXJIMjRKbUJMK2VqcjNsWVZ4TkhwandwbzZEYy9peEhzdmd5?=
 =?utf-8?B?MzVVZUYzeDBjQVR2VkZZZ1FFRHM2V0k1OFh1SjkwMVQ1THFWMk9jcnlrZnNi?=
 =?utf-8?B?ajZ4Vyt2VlpkU3hOdmVpUkhoWERhV0RSRXkrUDc5K3BrVUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB8806.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkV2Rm1iNXNuQUNhSjhvWlp3SENKY1gvNHBFdWpURmJGaUR6VGEyMUhqTU92?=
 =?utf-8?B?KzhOZTNic3loS0kvVzQyYU12KzA4bkVkMytKVkNTUmtFUDQwWVNrZVN0U0dn?=
 =?utf-8?B?THNSUjM0eHluRUpvaDBHdGl3R3daZlBROTl3VDlNcm80NFRWSkF3VmdnV05r?=
 =?utf-8?B?a1o2STNMUm0xRlFVT0x1blVQVGw4QzRtYTZrM1N6WTNzYzBWL2xJZ0k4cFhi?=
 =?utf-8?B?UXp6WVpCdGI4cnVudWUxdXpZVW9xMnR1ZEhtVDg3aWFpbVpxS0s0VnBDUXZL?=
 =?utf-8?B?U0xCM2tBSkV3Z1lxN1lFZEZlb21ycGY0MVpTb0ZIU29LZ3BvTlFjemtkeHJh?=
 =?utf-8?B?cFNqcDBpcWJjYnB0T2JQY0xkR3puemo1QXNNVVd6UE90MWlEQWErcHQ1ZEJD?=
 =?utf-8?B?UTJGT1hTaUN0LzJId1kzdE9LQUZzdWFGMHVPdCtOYUNtQjJCSnZ3QzBscDI3?=
 =?utf-8?B?b2ozNU5ndHl6R1gvd09zTDBudnRFV1hCV0VoNGd1NWZxT1dTVjRadzNGZFFU?=
 =?utf-8?B?UWlUVDI0N1lHVzVUZXN4dXFTd3RieWZXZHg3WTVXVVM2UXJGeHRZYjBmY1ZR?=
 =?utf-8?B?OElkYlFWYjJUY2xjTWxkVDQwQldtL3dCTk1FbnhEK0Q1ckhUQXZNelNURmJQ?=
 =?utf-8?B?Nm1kdkdFMWNkMGdHWE1jUjVKdTdJMWpNRFVHeVpORnQrL3IyT1hGM2ppNnBM?=
 =?utf-8?B?MmhqUm5BTVlyR3VtQ3ZWanlxejY0UG1ibHVLMTBvYjZkSGxoZGNqWmpWbEdK?=
 =?utf-8?B?OFhUVVVqL29hQjRwT3ZJT1ZYMG9kWkxYVnRwd2N1K1FrZklwMjRnQkFVdVZ4?=
 =?utf-8?B?RGVCZlpXbjdEbFYwa3FwVkhUUDFvWnVVbzBSelZvKzFWMTN2OHVyUGdEZWNB?=
 =?utf-8?B?SkJBNjNOR0d6OW15UUZxUTRxSm5WQkk0WVhLc2xTcTdRTkZJenBLRUZmR2tt?=
 =?utf-8?B?UlhuL3NUaCt5djc3eWs4cmJhRXFBRnNwYzhaUWZGVjIxWi9jZ2prY2kvNS9o?=
 =?utf-8?B?dElYTnNDYjR4WjJ3a1YwNVJwMHdoR3llSHZjM2toK09tYkpSMHZ0aERINkcx?=
 =?utf-8?B?UzA0NHp6M05zQ1JEK2lsZ2F4b1VQaUFScUFVcmU3QkFSRk56c1RRUjk0VzJy?=
 =?utf-8?B?OGxuNUp4SjAwRm5INzZ1TXIwSUFHbzBKRjRNck1ULzFIK3diTDJmUUY4bmtF?=
 =?utf-8?B?cGwwTVpJYXZNUVdKNXB1bHdpa1J4cWhsM3Nmc29zSHhOQk1qcGIza0xma29E?=
 =?utf-8?B?ZUQ2RmNxVjJiWkl2MllSZGJTdTZoK0hTZ0Q4bWltVjhySk4yTHZsUzJHK0Ry?=
 =?utf-8?B?STJLeW1OTEoybWVPMi9pVnZEbFZBek9vdHR5Y1phNW9kMEtIR2NmcjNCekQw?=
 =?utf-8?B?elpsTnA2OWcreFZDN0xyYVl2cUVWeEViQ3ZpVjRMR00ydXZrYXR0cWdqN1lm?=
 =?utf-8?B?WW5kNldaWUYwVEtuckJoVWNhVlJEYmZhK21ac3BrOXoxWlY4VUh2aVNHUFA2?=
 =?utf-8?B?cHdNS1V0Wi8wRCszN3dwWTAzb01UbThDWndJWXZqaHV4MExKNXcvb3RpV2o0?=
 =?utf-8?B?c3M4V1kybGRlanluektmWWZUY0swTEd2TVhTWThiLzBlelRxclR1ZG1CMlFX?=
 =?utf-8?B?K2U2T1EydzZNRXF1Q0RNUnU5MnQveWpiMU80RnUzSm9NM2hpeGVMNVV0a2ZD?=
 =?utf-8?B?YVlRcDlZK3lIK05NaGJpUWRvUmhzMmJFWWhLYVBqeTQvMVpHckFyUnRkQnpm?=
 =?utf-8?B?Qnp1N0NhWHRrVHZaMldvSUk5YjZvNUh6Sll6QWNDYVc2NytMN2pSV0FyNUtS?=
 =?utf-8?B?UThkNjcvUFVTN1dxR051VFViNkNnQ0ZPeTZjODlPeXdqM1dtdU9ka1kzQVE3?=
 =?utf-8?B?SC8vL3JtWVVVbnlUeVp4OHBuUzF5RmNZTjNNQU1ucUFLTzZnSlMvZzl3eTg1?=
 =?utf-8?B?SmZGcTVoSGpCOGtvbENncExNZFplK1BzV1dmcTJFVWVxcnlKV1VCOHZQY2JM?=
 =?utf-8?B?WFd2cUIvcVkyUkVsNTRNdENWckFPWmlMQVNpUVpPMWZMMVdyc1BLakxyWWlF?=
 =?utf-8?B?VVg0QlZzbE54b1lidWF5MzM1SGJvbDRiYysxNlh6TndxUnVKL2VqZXRaTVdG?=
 =?utf-8?B?ZXYzS0Ywd1ExWWlWdTVYS0J0aDJuZE5DbFBOdlAvbnV6eDdZb2JwaStHTnRp?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f99fc6-cdfa-4f8e-8d4c-08ddb4deea98
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB8806.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 18:26:07.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhVbnt71n3Ozmbc3KRoA/F9Mm6saAPo3LADi2rPP1nbHs3pr+D8iGf3F6/JOACzsz1M5Wn1QQH8IvqcoaKwmfhVYBLd8eKkHbKGfmn8RTpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9345
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE1NyBTYWx0ZWRfXx5mu6u7i6jhT 3FjKHLL+uF50D8ebHGg6GJOzoRkNqj+aOp+Mw3uhMJn6sn8S0sNUcK/BMd/JW0clNXx4MUySID8 hsbErUiQyjumTY5PQd4V3AcU8YjSf6CcR+D8kg8WiEyZmSqRKjseycUjyRHkaMBnP4C3JGigM9m
 WjiPYhLnelSTFfU+JQfU33TprhDRUxBTqIl2i0pWhs3OHfymUCE9K/R8kg9myhHi7L8YdvQ9Kdm czBmzSTsiklkxuv6NU3Z5Jv96RSAWkmJS9/gnAzhW5/356yxONMUOq1R/AuusSe+VuMyeT8EWdS wV7J0HTBrRDCWlyeSPuFojXM9baQ0m9U9D4IK0NgT7Zj3Vv1ucLXlKYOkH+DbyoaatCUngSUPoq
 M7piIWfZrUSptReEEGuhueMgzog1yUGeXgbHEDRV2twqxzYisANY2YpaNSauJ4kzMD4yc03j
X-Authority-Analysis: v=2.4 cv=MeNsu4/f c=1 sm=1 tr=0 ts=685d90c2 cx=c_pps a=ZaBEM9QpNs1KnoijQxduGg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VBpePjWByFEUzHEUCXUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rMzUkh2qSCUYRxVS6nSu4EuHmTlBpOj7
X-Proofpoint-ORIG-GUID: rMzUkh2qSCUYRxVS6nSu4EuHmTlBpOj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1031
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506260157

Hi,

I've got an Ice Lake server running 6.6 PREEMPT_RT, currently using the 
acpi_idle cpuidle driver and the "menu" governor.  I'm seeing some weird 
behaviour with cpuidle and C-states and was hoping someone might be able 
to shed some light on what's happening.

I'm doing a test with qperf, running a qperf server on one CPU and then 
on another CPU running the client in a loop to test latency:

while [ 1 ]; do date;  qperf ${ip} tcp_lat;  qperf ${ip} udp_lat; done


CPU 34 is running the server, and CPU 3 is running the client.


Initially, both CPU 3 and 34 are allowed to sleep in C2.   In this case 
the qperf tests report a latency of around 120 usec.   Tracing the 
cpu_idle events on CPU 34 shows it asking for C2 and sleeping for ~175usec.

<idle>-0       [034] d..1. 763120.481960: cpu_idle: state=2 cpu_id=34
<idle>-0       [034] dN.1. 763120.482140: cpu_idle: state=4294967295 
cpu_id=34
<idle>-0       [034] d..1. 763120.482199: cpu_idle: state=2 cpu_id=34
<idle>-0       [034] dN.1. 763120.482373: cpu_idle: state=4294967295 
cpu_id=34

CPU 3 sees similar behaviour:

<idle>-0       [003] d..1. 763120.479151: cpu_idle: state=2 cpu_id=3
<idle>-0       [003] dN.1. 763120.479329: cpu_idle: state=4294967295 
cpu_id=3
<idle>-0       [003] d..1. 763120.479390: cpu_idle: state=2 cpu_id=3
<idle>-0       [003] dN.1. 763120.479575: cpu_idle: state=4294967295 
cpu_id=3


If I disable C2 on CPU 34, the reported qperf latency goes down to 
around 17 usec.  Tracing the cpu_idle events on CPU 34 shows it asking 
for C1 and sleeping for ~20 usec.

<idle>-0       [034] d..1. 763619.245990: cpu_idle: state=1 cpu_id=34
<idle>-0       [034] dN.1. 763619.246009: cpu_idle: state=4294967295 
cpu_id=34
<idle>-0       [034] d..1. 763619.246021: cpu_idle: state=1 cpu_id=34
<idle>-0       [034] dN.1. 763619.246042: cpu_idle: state=4294967295 
cpu_id=34

On CPU 3 however, we see it repeatedly asking for C2, sleeping for ~20 
usec, and reporting a cpu_idle_miss event.

<idle>-0       [003] d..1. 763619.464429: cpu_idle: state=2 cpu_id=3
<idle>-0       [003] dN.1. 763619.464441: cpu_idle: state=4294967295 
cpu_id=3
<idle>-0       [003] .N.1. 763619.464441: cpu_idle_miss: cpu_id=3 
state=2 type=above
<idle>-0       [003] d..1. 763619.464464: cpu_idle: state=2 cpu_id=3
<idle>-0       [003] dN.1. 763619.464475: cpu_idle: state=4294967295 
cpu_id=3
<idle>-0       [003] .N.1. 763619.464476: cpu_idle_miss: cpu_id=3 
state=2 type=above

Interestingly, turbostat reports that we're not actually spending much 
time in C2 (aka C6) even though it was requested:

CPU     POLL    C1      C2      POLL%   C1%     C2%     CPU%c1  CPU%c6
34      1       152881  0       0.00    62.25   0.00    58.10
3       0       54      152813  0.00    0.01    34.00   26.78   0.08


Similarly, if I disable C2 on CPU 3 (where the client is running), I 
*also* see the reported qperf latency going down to around 17 usec.  In 
this case the roles are reversed, with CPU 34 asking for C2 sleep, then 
sleeping for 12 usec and reporting a cpu_idle_miss event.   During this 
run CPU 3 asks for a C1 sleep and then sleeps for ~22usec.


I have several questions:

1) Is this qperf behaviour expected?   It looks like there's a sort of 
vicious circle where the server sleeps in C2 and so it takes longer to 
handle an incoming packet, the wakeup latency means the client sees a 
longer latency, so it sleeps in C2, which causes a longer latency so the 
server sleeps in C2 again, etc.   As soon as either end is restricted to 
C1, the other end also sleeps for shorter periods.

2) How is it possible that CPU 3 is continuously asking for C2 sleeps 
even though every single idle sleep results in an early wakeup after 
about 20 usec?  Shouldn't it eventually clue in and start asking for C1?

3) How does CPU 3 end up mostly in C1 when it's asking for C2 (aka C6)? 
Is the processor essentially overriding the request for C2?


Thanks,
Chris Friesen

