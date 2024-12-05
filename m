Return-Path: <linux-pm+bounces-18595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824219E4D0C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 05:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5391679CF
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 04:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A53185955;
	Thu,  5 Dec 2024 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvhLHbaV"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC384C83;
	Thu,  5 Dec 2024 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733372995; cv=fail; b=UECA6123llHX5JkgXTtdrlTv3eA0jWHEOrKfodKyfOBKkxrv2WpyYmr5/t1eBDv0wNIpdm5OaGpvfXM4gt84WTkISi4G9f8SQrIHLrLScK9vMP6VxxBf15RbHDZhuetkAvZLgq96cN5hTNgK484VzhRKoG7gxS+anPbvQUNLn4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733372995; c=relaxed/simple;
	bh=smwQd90lfMOGXlUEBAY4T0apnhtWvpBbFimb5RZGsD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sK/419dfrU5CKA4ekEVZcT4dfdsduPqdX3pF4MO2kn6rupH6UaIpz5z3FfqRGQ/vXgV5+2tcpo9BU4jz9vwAjL7gi7OYb8pPP100nIoiSqPisFhEVYnXAMv80x+JHznDdWKO0km246SJnog22yn3QPb1CaFyUom/wV7GVShXEvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvhLHbaV; arc=fail smtp.client-ip=40.107.100.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mk+S/eNV8QBmxwQWtEjcJo71kQrgVxRziicN6XPepP349SDaOhuHDd6Cs6yH9ouHg+7kvy82HbW+dttGvhGapHQMlWZ6+zo+UThGjqxWT9wVY4JikkkUdUcZJmPbrBETzxoJQA6jD3S347UzuE/qPjVOn2ALEzhiL9AvESFNcVGqtaZ3eVWSyVm1F31qf3OsWQb3LRxqEqCoMH1ufITYEoxYcL0drF248Svm7sbvARm//eVFoPOf9YPc6IgmvnUORNaYfUW6H83rrsCBM2iRvueLMkW6SnA1fT8LBjPTY5AlICm2uFLbv2mEROjJnYzfcrEy43TmnIsZ8ruNrNNaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1rOmIquln1qKIj0u98skeUcQpdD8wkPtpFWebso4Ck=;
 b=w0m0WWlbvGvFXHTzlSDJW7rG59XzgR7aSZvOf/t2ap/D6aZkNc4E4GwTcPM3437EZkXxhzvPAtW1KnJuKYU+S0StocWn9rvrKTNHF7Gj2ikKGe7KWD9MxqQ2FP8NjMgW3+MUir6XNEGhCo+3Atuo+UXzQ/zrgkewQk3YHFNrmS7sziZX2d3eYVtEPS1jLBQ3Tt92CpGvHgMgdTlH0edTiTMOERXPMu3hl9WpXZj1eKVV4mMiscxbNAsbce4QVwI+HDdvP+Z857D/VHWl+vwGkNuWIq8BzJDe8Y65OJOKjN4GIs9CeBncf+MAj9TD/UjqxLt+LNcXBLAAciqcKF2+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1rOmIquln1qKIj0u98skeUcQpdD8wkPtpFWebso4Ck=;
 b=gvhLHbaVYyAb8T6yMql/Zp+02YibH4P18z3M09ZBl7MUhoUYiEDcObrHIQG6MJ1YBxExaEA9fUt3FmOfZDhn2EW3dejWQiZ8A6pKpr+IGms4rQ/3bEX1yf0VIH6OvXWjgMqVFNCH5JGOS5VucO4vLYdFHadp39+Q4/JuILKZRAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Thu, 5 Dec 2024 04:29:50 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 04:29:50 +0000
Message-ID: <9b829b10-3b95-4aea-844f-fc7b0b4b601e@amd.com>
Date: Thu, 5 Dec 2024 09:59:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cpufreq/amd-pstate: Reuse and refactor code
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 gautham.shenoy@amd.com, perry.yuan@amd.com, rafael@kernel.org,
 viresh.kumar@linaro.org
References: <20241204144842.164178-1-Dhananjay.Ugwekar@amd.com>
 <9cd10b8b-ff56-4171-ad9c-df84fdad6be2@amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <9cd10b8b-ff56-4171-ad9c-df84fdad6be2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::10) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b68717-0e7c-4d59-3313-08dd14e5754c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aytRSVBERDFVTnptUFRqWjg3cU5reTBReVBwSWZwS3FPU2UzZmxXYnI0dnB6?=
 =?utf-8?B?QWFiWENZZjlLVTBTd3kzaTFEc0c0d3Bhd2tkSEYwRDZ5cGp0RkVvUDZWQkxY?=
 =?utf-8?B?SGhsS255SnJjRVo2eGFSOHdYOGJkQzZ2eUJDVERFQmtXSEh3Qngzamgza0dD?=
 =?utf-8?B?UnVXT3ZKMzdLLzlWdTBZeENXMmZsc25Eb1BvZjlvemhBQWJiZ0Z6RXFJdWha?=
 =?utf-8?B?b2IwT0gxTmg3b2ljQnhoVFo5SWNwbWRJWTVjSWdTQllPSFA3K1VBMlpoL2Mw?=
 =?utf-8?B?VkVkTDB2VVlwU3VCQmhWUnc0NDFLbW1qOEJYSDJ0ay93UUcrcng2TW1sWTVh?=
 =?utf-8?B?MDE0bUsvb3FVT2hJOWVLTzAzVml6WDBtZ0YvMzhQenBUZzFTZEVxZVhzQ0lK?=
 =?utf-8?B?QUk3SEMzUGVJYmpjUDFRT0x5dXFLUk5SaWJoWUdMajhGekVDdmV5SXFuSkdo?=
 =?utf-8?B?akV6MHZ3MGk1UUN1VDllTEYvT1hGZVd0amFpQlVrS2NMOFZNUGMrRmN2Tkpk?=
 =?utf-8?B?MWg2OSt3UDJWY1d5d3NqT2VVMmFFOGhaTDh0OXhieks4b3pld2N6ZmUwclRo?=
 =?utf-8?B?NVVIbnJ1VUtiMmxUWDIvbW0zbjA4cDdOSG1NK3hiUmpMVGp6bnRnK2tJZzls?=
 =?utf-8?B?ejZsZ0l0MlVHSVJRZXgrelpONkZCd1JpditLVmhpWktNTXJTRGJvZWZGOWZm?=
 =?utf-8?B?RFU1SUJPU2l6U2hlWE5oR0EvSUVmYjRONmJLRGpsbjdJTFhBZnpQVnlUcVRm?=
 =?utf-8?B?SU5aN1ZOT0pUdGxWRFBGMWFVaVpmYnZSTFEvMUp6bzlGVFF2bDR1TEppNEpF?=
 =?utf-8?B?TVFrR3hoQThmWC9aRGJMU2FxNytaR3Z6N2FadDdPQlNEbjYvdWNpcng5TkU5?=
 =?utf-8?B?aG5uUisrM1pJOG8ra2U3ZHFob0hBTWVSalRvRUxwbXU4cjVsTjFNbkcvNXNK?=
 =?utf-8?B?QU15VjU3Uk5Vb0M0OVRvb2RRaUNIaEdvcDdOY0hhRFozMkhzMFlad2NMbVVO?=
 =?utf-8?B?bm9kbXRKdnRXYWJWaDdOamIrSlhDQTFKNzUyY1J1ZDl5OXZpNFBubGRyNGZR?=
 =?utf-8?B?bkhiMFRNNGpwVG9HdFo4d2Q3VFZnZThpL0x0RlAwdkxmL1VrMXFWM3pBNFhI?=
 =?utf-8?B?TFFtSkFNTFFvNkhrTlIyQVZBdDZwWnEzQzZaL1RFUkJJOGEvclA1aFhxZWt1?=
 =?utf-8?B?ZjMxZ29OWUl0azhKUkJIZkNpNm05cmFtdEdiRXQvMXJIOXMwU2JpMllpZTNv?=
 =?utf-8?B?RXZiWjJqaGdTdENvbkQ0eFhRZSt0RloxMWM2T08ra3M2WEJRS0RZM1B4S3JS?=
 =?utf-8?B?MHVXTERLSjBXRTd0YjE4bkxqczN1S0ZIanlrMHFxek5uejlTaXhKNGU4dXVw?=
 =?utf-8?B?YitjcjFSZGF0aVF6enlmd0p5cWJ1NFplam1TME5OYUxLbFBtanJGTFo2VGFy?=
 =?utf-8?B?Skl0VjRvcjVnOUdoaEcxUmlmMUJ5THQ5Qm1ZWUEwQzlJTzBDNFVUbmRIcjlQ?=
 =?utf-8?B?bGc0T1hLK21DRTk3MHF0U1c1NUQzWnBsY1Z0NXNiV3JQWW9rZTZLTENWS25M?=
 =?utf-8?B?bE81NG0xL2FwSEkzVzh5SHQ4Z2VRUjJSK1d4SW0rUnd5OGJpNFltSlpLcHBk?=
 =?utf-8?B?QSt3WUxZdS8zS2tCN0tEU2cwdExXd0R0SjZTSnBoSmlqc1VjdG9NT3FnMHVH?=
 =?utf-8?B?enYyYXpUb3hEc2ZrOE5GTHFGT3AzYUNVTUdxbTRFSEl4cVh0SmpIWDM4ZGRU?=
 =?utf-8?B?OEM5RlloN2w0M3FtNXhGckZZUnpJVEN4VTY4Zk5JS3JrNGlLU0dKdjNydkh6?=
 =?utf-8?B?Um5CMkEzWUtIN09ONVJDQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S21WUDhnVnBmZENjY3Y2bEpUVEU0MjMrK09ac3A5c0FOMkJLeGN2UlJqWk1j?=
 =?utf-8?B?Mld0ellTK1FjZm1EQ010QnJsaTlNbXJ1eXRtZHhuVlFkRkY2YXplSFBNQ3py?=
 =?utf-8?B?Z2dwMnljMUFFenduTU5INS8zNENuLy8wajBPbzBDTysyMFZiUFJQcklFZDZa?=
 =?utf-8?B?M2xHOUVoZ0Q2THp1NWE2TUVmWDFQMnRJT2JTZmVXbnovV2xzQ1lXZi9DVi92?=
 =?utf-8?B?ck1xb2hEZkRueTVsTldYVFYxdW0zVGtVekphMmMxUHJxOXNldVBiN00wdnpT?=
 =?utf-8?B?U2RxMERQMWNqQUVXY3FvcVJlRHN5QS9DbmlWb3EzaUtnYS9IVGF4UHBFcWxR?=
 =?utf-8?B?WEM3ZUoxUm96SmlxZ2wyTEZmVXhsYmRCUklNRkJ6ZytmTDVNaWg1ekFkUDNO?=
 =?utf-8?B?WWhLL3ZsOUlZcHN6SmNxVjN5RXBUS3MvaExadWxCYSt2YlozZ3ZxK1RYbUdi?=
 =?utf-8?B?bk5YOEk4VmVQVEhRTE1oNm93LzFwTC9pRkQ5WnBpWVAyVHJNOWJtR2lucDg1?=
 =?utf-8?B?ZU5GMXpIdlNCeXRieXZUeEFMSG5uUUV4VW96K0JscXNXNmNybHBNRDd1bnBN?=
 =?utf-8?B?cjlyRlFWanpEYnU2WkpjQnIxYjJWUU41NFJWdll6YzRMRlhBOEZ2NGs4RnRl?=
 =?utf-8?B?dEx4d2h2ZTVoTERvRGw4WE4yTy9sL000aTc1WkJRejd0Z1JObUpLNXdjZUtF?=
 =?utf-8?B?OEJzWkhoWGpqMUpkdmE3eTVxQkVUa1MrdmZWR2kxZnBtOE1idk9pS21jdWFQ?=
 =?utf-8?B?OXRrNHdZK2xCWmFIcGJxRk1LdHJlMis0UGxuWGtTNm9xbldLd0FQREIzWnpX?=
 =?utf-8?B?SVV4ODRFV1hCbFlyYlNSZVQxLzBtSU91N2h2azl0YndKb3QySlFiS1dGSnk2?=
 =?utf-8?B?TlJVWGlhUEtDKzJ2WnkvbVZqNk9qRnB1cVRabW9jNSsyT0NScXpkRnB0d2RC?=
 =?utf-8?B?dXUwbjR6VUtxYVdqa3AzWVdXdXB2bEU3TjRNKzc5aFgramdpZkQ5RENzQmM3?=
 =?utf-8?B?YmlSclNQYUZpUjY5a3FQT1BkaW1talNzREMwSWlWZWxObDR6dER4VU1tV0Fa?=
 =?utf-8?B?Zk9RTGljSkQ5NFNhUS9TNzdXdUU1Z0lGWm54WmRKVlBwVUNZL2hTRm1XTnN2?=
 =?utf-8?B?aUhDOEU4TlFnbjAvbjRZN09VWnhuaER0K2VUOHhvWlBXbE14eUw2a2xmUU1o?=
 =?utf-8?B?bWREcExaVlk3NUpyTXZIUDZsSGZTYk1pZDZnbUJSYVF3d1dSWXhleUhvTTRE?=
 =?utf-8?B?YkY3MFBTY2k2bytQQ20wOXhkYjlXRGxQRGFEMDBnbWtNM01jOGNvRHpRZ1JL?=
 =?utf-8?B?OUVyaS9SdndrUDhBNW0vRkR3NFFoRERzWW1UU3JtaC9yNDFIdWJnOEM1U1dP?=
 =?utf-8?B?dHBXWmE3WDVndG84NDJiTWJKK1VSWlVuZ2prekxUWkpWL2ZIM1RNYU5EbUhz?=
 =?utf-8?B?cnNPRUt1Y0NFWWE5bWlEems2OVgrYkFtcDY1NWFhMUloYXZGclVkamY0bU1F?=
 =?utf-8?B?YWtnNTRicHdFaFhpTVF0YWJucHRXaXdHVHg0Vm82RG1WMkc3S3JMMjdobEpw?=
 =?utf-8?B?NkRBSlliOVBaMHJHQytYMVNuSFhuRElKZGM5bE9CYmsveE1jcXJUeXNiYjVU?=
 =?utf-8?B?cGVBZXhoMmNyeXU2SHdKQUc3WUxVU3NabGFacG5kbnFVbVZvdURRR0wwUWQ1?=
 =?utf-8?B?U05zelRwNUdaSnFrSTlZdWM2QSttTjlzSVdUMHVTV2g2bUw2NndqMXhlRXZ1?=
 =?utf-8?B?YlpzZkJ4YkhRSTduTE1iRURtMm8xWU5WbUw4bDVLMDRoODJqT1FlQXRLYlc4?=
 =?utf-8?B?Q2pjQkpwNFMyME5xYjZ4SmNMa3cva1BMSCtRdmhZZVVrUWVTeGNDcFFRRW5q?=
 =?utf-8?B?R00zM1lva3Q4WW9hTmF2Q0tEcDFtNU5nc3FobS9RYUozSFVKVW8rMVhDc2hk?=
 =?utf-8?B?ZHR5eFF3M3ZvaUNwdTdGVEsxaXkxTDI1VWtZbnp1a1Y1K1hvZGQrMmVRWHJj?=
 =?utf-8?B?a04zMWpNMkZ0WTAvaXJTU05FMnptYWlML2FpUVBMaHAzWXJNS0ZkdVlKSlFz?=
 =?utf-8?B?UzhKK1BQeXF6Y1hsQkZFOU5CT1p2SSt2RTI0QVVGeFRPMXprOE41eGZ2cjNR?=
 =?utf-8?Q?eQ2EUbNsA+mMwqjC+owhTFbHW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b68717-0e7c-4d59-3313-08dd14e5754c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 04:29:50.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxV/LV0zjRX4BeeBNuzgw2/qKVKaToMG3OzRKu2tw6QcAUCb97KSr6A9UX06PJCk5yAz0kDfOamcVYuc9lzRCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795

Hello Mario,

On 12/4/2024 10:37 PM, Mario Limonciello wrote:
> On 12/4/2024 08:48, Dhananjay Ugwekar wrote:
>> Use static calls to avoid frequent MSR/shared memory system checks.
>>
>> Reuse existing functions amd_pstate_update_perf() and
>> amd_pstate_set_epp() instead of duplicating code.
>>
>> Remove an unnecessary check for active mode in online and offline
>> functions.
>>
>> Eliminate a redundant function amd_pstate_epp_offline().
>>
>> Dhananjay Ugwekar (5):
>>    cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to static
>>      calls
>>    cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
>>    cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and
>>      amd_pstate_epp_offline()
>>    cpufreq/amd-pstate: Remove the cppc_state check in offline/online
>>      functions
>>    cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and
>>      amd_pstate_epp_offline()
>>
>>   drivers/cpufreq/amd-pstate.c | 151 +++++++++++++++++------------------
>>   1 file changed, 73 insertions(+), 78 deletions(-)
>>
> 
> For the patches not already reviewed:
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks! 

> 
> I'll add this to superm1/bleeding-edge.

There is a small warning in the 3rd patch, how do you suggest we fix that, 
should I post a new version or you'll modify the patch at your end?

   drivers/cpufreq/amd-pstate.c: In function 'amd_pstate_epp_offline':
>> drivers/cpufreq/amd-pstate.c:1664:13: warning: variable 'value' set but not used [-Wunused-but-set-variable]
    1664 |         u64 value;
         |             ^~~~~

Regards,
Dhananjay

> 
> I have another series that I will build on top of it as well.


