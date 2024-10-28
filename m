Return-Path: <linux-pm+bounces-16621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA7F9B3B0D
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C311C21B29
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2024 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89B1DF736;
	Mon, 28 Oct 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MM+3jkAr"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA581DBB2C;
	Mon, 28 Oct 2024 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146054; cv=fail; b=X3gje7/RpeQys2Ka/ej9U7AJS8FGTKjz5KmvOTf45GTdEsBGrA6OmaXnJIRycsrU/ZWFBmEJ7LVL8eRlm0UG6QibfBr1Wbw54/vnDshObOg5I9eHky/qBKHFboNRgR6byKA3YvoGBmP5yjpM4WTxPziM5RNPdURI36DpMlvJTxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146054; c=relaxed/simple;
	bh=/LjHIQ7H56twHXMwPoYauiI6znY/NuXlnREPhBQKdT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=txU0CYNEV08/TaNjSiKsm83sD+nx0DX58SnoeOFLz4hY61hq2fga0BK42B+1hiDhPBaSyob5F4N6qBvFuPB1APUxighovCzxOs24qBOY4wSnnlVI/wG9Q1r73XQbc+vwEfejgaIEVw1vZfuhHGRQl5XWKP3iHrcrRM60Ku9N0D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MM+3jkAr; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFdi19+fs9gKyCP+xI3OxfKdcSPQVG+sUhGBxmQ7UNlUMTP8UPmplZuZyQTCXJGdo8SzveYP0AO+glMM+fLkdxCMSdHPEQRtQk9K6cbdDs7sjiRJwE3vLpjkH3v7/bbC88/tT8FrYcrBAwRQSiP7Txq3x6Vz+LyJAiIiQxKs7R+jPlXquEMAqGfcv+Sq2p1krLrgymEsPHd/MKVHrpNyHBUpR1EMtEpPGx321x+t4SDrfh1ZpqRXil3af5q07kOTNhxjlTgNsyVqzoy7pNAIwOoGjKPJK2guAxTQ9AEK/bRwSHGDY6tJD9dI5X/N0bbB5Hb19tkyUDpLyXc2DgqBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhJnA5n3vInyuqiPhnIOSegpdEbahMKN6tii9E2D+GU=;
 b=DPzhc/tWS9i25RjqGAQk0tl6f8gVLqLIjds/tKEu9N47MVuTy9BC08mLwiwoQUvTTgHDA7Xma3tyNOo++nwQ9j/f+FTmV3JrJzXJIBtGsuM8ZO/DJse3U+EUyPcGNVKdAmXwjjM2MqL46yfYwSsNTM8J5sCzQbLOrauJ4aI/1oj0CYPae2E3j+yMFRtGtWCSy6Z0gD9aeXvRRHO6y6hFkFzGnRCa5k/XKRdcZTC4+xb/X9UxMN9VNBhN0rbOm31x9pzPhCV1tnxteFee7UCISOMnJuKCF0eotq/OlvIhvkSCrL5Km8nfe+ZC+1OghEkRm9jMnIe8eD+UCdPlWpBAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhJnA5n3vInyuqiPhnIOSegpdEbahMKN6tii9E2D+GU=;
 b=MM+3jkArkIk7gjHOWtNV9xMjKugrGO9W5jYKSL0zWVTj8Pu7xJi0jkocuLad2ScjudfZAkvIu7AbjS8aBfOiRkA7V+RMUVRqfSzs+FKBMR4zDc/l+o8rKsAssWaW4fcs+IJTDzIJC37qY2jAFhrzAaDiqqSqDVZjeF8dhxuRQOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Mon, 28 Oct
 2024 20:07:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 20:07:28 +0000
Message-ID: <3a4596ba-1a83-4cd2-ba17-5132861eac00@amd.com>
Date: Mon, 28 Oct 2024 15:07:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in
 passive and guided modes
To: "Yuan, Perry" <Perry.Yuan@amd.com>, "Nabil S. Alramli"
 <dev@nalramli.com>, "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc: "nalramli@fastly.com" <nalramli@fastly.com>,
 "jdamato@fastly.com" <jdamato@fastly.com>,
 "khubert@fastly.com" <khubert@fastly.com>,
 "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Huang, Ray" <Ray.Huang@amd.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <Zw8Wn5SPqBfRKUhp@LQ3V64L9R2>
 <20241025010527.491605-1-dev@nalramli.com>
 <CYYPR12MB8655545294DAB1B0D174B2AC9C4F2@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CYYPR12MB8655545294DAB1B0D174B2AC9C4F2@CYYPR12MB8655.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:806:a7::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0091daee-5687-4245-319f-08dcf78c2596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWVFOTVtUi83bGZBVlhBSlhycjVkUjhRUUh2SHFBWFNkUzd1STZvc0tsay9k?=
 =?utf-8?B?bXMxRmdCcFU2UCtiUzZRZlMwRC9mNlRJSUQ0L2llS0J4VEJlZVYyTjdOcTNY?=
 =?utf-8?B?dDNya2dBcTJqTk5ZM2JLeGlsWVEralNYV2ZLSFFaTnl2YlVUVm5DVEd1NGNl?=
 =?utf-8?B?L2NDTWd5NFcxb3p5Mk9nc3N1bW1WT0d0dW1GRTk3NS9lWUNTRVYrelFOTTNW?=
 =?utf-8?B?MzRRNks2NldkUkRQd2ExQzUvdUhxVlluOWNFMHFYVXFuQVRROXM3UE1zK0Zo?=
 =?utf-8?B?Y2Jwa0ttV01oUWcvNzJpbDJRTXRFY250QzdZcks3VE5aMkJIOTVZdm1qSFZK?=
 =?utf-8?B?aE83S0tVZzhEQ0c2bWRuSDZrdEdIaWIvQWVHVDRZQXlHL1hlWlRxM1JGbDRQ?=
 =?utf-8?B?TVJzbUR4SFRjVjI5L1lhWXUvWktiWk5GUlFXWWlvTDFodExJTlNRS3JPYkJY?=
 =?utf-8?B?M0NVUU1hWXV1ZTY5elRUdTg0ZUZoZERhQ1FWYUp1UkxJV3pzNjdHcDJIaWxw?=
 =?utf-8?B?elhnMmpDRUQ5Yk83blV4QVBHMmFva29HRFlVSDFHOXhiRDNSQ0Rka2o1MWRR?=
 =?utf-8?B?MkxxOFprMisyZk5xTXhJbnlrWmN1bXNvQzN3d2pVVDd0OGsrK0tMYjBuYkZy?=
 =?utf-8?B?c3JCRXVXTGFsMFJUeHBLOUp0SlJkOFdZYURRVVBjTnFHUUlZVEVqUlA2MUVl?=
 =?utf-8?B?ZmlQTjlPNzEyM1RLSWp3RFBON1ZjNDBwZHNTUFhHOFB1cDh4dVNldm9wQkYw?=
 =?utf-8?B?TDYzY2FtQ0Z2ZnBubmxISEVDTXd3OGRTTk5laEo0cjhmdVdscUxvRnpaNk1i?=
 =?utf-8?B?RUNFQTRaSkZyTy8yT0MzdmtOYTBITHh2QkpMbXBzaGJjMDV0dGFCVkRMWFcx?=
 =?utf-8?B?eHdIaGg5OEpSc3RvOXhFWGlhelBVY3p5dTVkTDlvU1BKb2NGbGhqRTV2dU53?=
 =?utf-8?B?VTZST2VnbUErQUdPVDVlUXVoMnFoaVB0TUJWNGtUa014bEZLVnUyTXN0V1dC?=
 =?utf-8?B?QkJJUzdXYXE4Sm1xTjNla1VHTGpCTWFZdEM0N2piZ0JLRy8zKzV6SlBLdk9a?=
 =?utf-8?B?RGl1T2RBcllhdXd1bG43Zmg2dFV5TDVmb1BMVERwRlVoekJIM0ZUemdDQ2ZM?=
 =?utf-8?B?aGNjQ3ZrTmludmlKbVRLWkZ4N2lhUEJSM216dktOWjYvSjk3NWxnS09ZN0dP?=
 =?utf-8?B?ck80Z1oyTDdjSmNINDloM2ZUSTlOS252Yzd3Q1F0NHBQZjNWRnk0VEg4V2pB?=
 =?utf-8?B?WFc1cFlLM0VlOUtCc2ZmSmdaQm9CV0kyQjl6UE50YkFBL25UN1ZuKzRhbnNR?=
 =?utf-8?B?a1RLSXB4eVV5QndBSGtJTUZNWE5lM3U3aWJYSEJmMTJic0R6QStOYWxkOXBr?=
 =?utf-8?B?OCtlSVNZRFBibjRPZzYvTnNZdlZwMUtMN2VxdzRNc3A4c2s5SUsxMUZEVkhs?=
 =?utf-8?B?b25KVWRQQTNnaDM3YzZQbHgrWTZ6SE4zZlNTTFJZWXpTVzZDSitCYnV4UVJv?=
 =?utf-8?B?SEZONVhnTzMxQXpjTUFVN0lsa29ZWlBlMGVTdVlZZU54a28wWmd5dmRyMGxs?=
 =?utf-8?B?Z01yODV5emV3eEQxc2dTTzBHUGZCdmZXb2puS29XMjZ5WDlJeFVDYXAxZkNT?=
 =?utf-8?B?T2w0UGtIUGovVUtYRnJGbmlQT1BKQUU1c0puTGt2STRxMis3dnhEanNzcW80?=
 =?utf-8?B?bUZIL29LNFRCS290Vm5jd3BOT3VZWll4TDdUSjEvUmF0RTUrUk1Yc0c3K2Nt?=
 =?utf-8?Q?rSAcjVAF/kzD+aqRaVe8k/5UoYUQCc0BamqZREe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0ZNVnMzK0RyRnFHenpKK29LVXdpSW5QbXlNSjhBdE0wczJGaURtZmV3ckRt?=
 =?utf-8?B?cXJ5ckFSOXc2cERrYXVZYXB5UVBuZExvcXdVVExySURhTG4waHAxR2pCSmZY?=
 =?utf-8?B?WE1CWmRNVmV6UEFtYlpjOWpGUmFqVzg0aERZd2dmUGFtQWhxVUFnNHh3L0Zi?=
 =?utf-8?B?akg3SDVlNXpUQXJLbDV5dzhKVVF6ckdmZlN1Wk5qek1WL3Q5bUduQ2lYMXVX?=
 =?utf-8?B?bmszZTZVS1pEcmZQLzl1cEFkTjc2eXVTUDFVQ2VzKzAyRktsR0RZZEZsb0pS?=
 =?utf-8?B?WEhoL2pMdTIyUTlFeGlleHNHaHJ4MnpQZHlFczBXa0dVTTF6K2x2QnpnT0N0?=
 =?utf-8?B?UGpXMHdlQmRoNkdMWituaEZCMWFsbVkyQ3VYRjgwanNaRkQydXMrUzdOQXY4?=
 =?utf-8?B?ZlEvWmhtVUdlVWRkSVNNV09peWFWM3didjlqNm83Ri8zT291ZDc3YXhxODJB?=
 =?utf-8?B?bzVOM1pScWFYbXpRMFNHbXB6czJ1eWxxTlM5cCt4eG1nUVRMeG5neHhRR0l5?=
 =?utf-8?B?ZnplaFk0S291NmRKbW9BQlArQ04rcFM1cGdRR2V1TGozQkFkWmV6NjVUcWlj?=
 =?utf-8?B?bTlvSTJmTUhWMHo4ZGI3TlYxNGFabGFMQlNFdWdBSVZpd20ydU92VWVoQzB0?=
 =?utf-8?B?aFNLU3U1ME9GdFhsYXRrVW5iTE5GZE9LeGdIYURSbjRXRVJVY244RmZ4SXM1?=
 =?utf-8?B?TGJSemdsSWZ4UDBydWQ2MS9DNGRjeUdjREpLdXpmMkI4cnNSYmVjaEVLWktl?=
 =?utf-8?B?dWJqV2lRVGliTkJ0UEh5YjNJdk9kMGlha0NSQTFieUxDdGpvMWMzTStxWXBa?=
 =?utf-8?B?bXowSWtzUFZCWlQ4eWxOZ05xTk9td0hHK2kwRjJIZmhWOEdENHl6U1pRNlhS?=
 =?utf-8?B?T0RZdTZlN1JLanF3aVVPb0FIR2drSmg4TlZUaXhhZFRodW9aakFmWkdMYTh1?=
 =?utf-8?B?dG5rTjNicGlHMS9ZZW5QK1VKNVYrUkJxMk5tV0JJSFkvdWtrRmk3bnY1MzU0?=
 =?utf-8?B?WitWN2EyWjM1QUcyMVlwc2dFUEpKK04vSEI5dXdLbWJGZlJ1SW1mZ08xc2tw?=
 =?utf-8?B?WityelYrMzEvOXByZ1U1QXRUMWFwdU9tWDUySC9VMDdQQkRzQlRKaVRkbEhh?=
 =?utf-8?B?aFk3R1V6S25wOVB2K1p3SFFRYWtMNVJhQmNsQ2F2bGtPY1hWNFJocVNXaDVW?=
 =?utf-8?B?amFLU2JDVVJLL3NWTVVNclQ4MzZkTVVWcVduSGpocTEzeXJxbzRwWjNqcGor?=
 =?utf-8?B?WEhDZWIxUUNCb20wZExyeTdiQnUvcldIc2xkVXlSbDZDRUVoWmI4OU9GVHI0?=
 =?utf-8?B?MHpjOENqWWx2ZXlpcXRFdFJOMDVPTloyRU8xM0F3K2hia2x2a3g2ODJVckwz?=
 =?utf-8?B?bVEwTUVwUTRrUVRaejM5RDRDeEt1TFpQbEtLK0U1ZUhpaE95bGdBVjVkRnJI?=
 =?utf-8?B?NjArTWM2Um1QcFp0ditGQmptS2J2d0xQSlpXQXFQZEREK2JRV1FXaURtQ21y?=
 =?utf-8?B?b252c0R5dXlFM3RPUUduSElmMjdkL3E5NzBDMjMrS1FheS96WHZqUTlPWmJK?=
 =?utf-8?B?WFhGZE55WURIVkY1dXZLV3l0MmlqOWQralNEMUVYVE9kSnhvY3dBTFdUOVkz?=
 =?utf-8?B?bzk4bnlHRmpjZ25FR292eHRUTmFDUjVGT3cxaGxTclJsNk43dEhpVVM4Tk5Z?=
 =?utf-8?B?dTFpeXRySWFwYVdmVHpoTzN1UXI4RXVkLzFOS0U2U3BkWDBYWFlLa1NHMTBw?=
 =?utf-8?B?aGpCOEVDd2Q2blJsYzBVdHptdStCUUgrNDVzTnRIMkIxMzVnRmNleGlzV0xN?=
 =?utf-8?B?UWs5SzVkajRHRjNGQ0xiU1ZFOC9pdUpMUzgrRkJFcDFkejdoSTg1WUZiNHZ3?=
 =?utf-8?B?clZFeEdValhRTTBaQXA5dTE3M1Q1a1ZWeDNSd3UwRWdOL0JlNTcxZ2dNMXov?=
 =?utf-8?B?L0FEMVl5Zm43eTZ2aEFSMEsvNjArekZPMlhma05Kb0pHU2tXdTNlRE1KYis1?=
 =?utf-8?B?dm1PYUtqSiswRTFobkllcElHenpBQUFSaFZWenlpYS9ydVRhanZwOGd0L0Z2?=
 =?utf-8?B?TWlhbFZ0N0pzU1cvQ0ZuWlE5dWorK3c0akZxME1PODR0UE5qaHNaN05MR0Za?=
 =?utf-8?Q?oVUn677Wje6euHb1S6zqf/2x5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0091daee-5687-4245-319f-08dcf78c2596
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 20:07:27.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So5a3eVbNocRbuNgwZrS5Inp6QFs+UgIpm6AEFWEYZNG6f04bXFzk2ibaGuSVXPGKYZg/3210xohpp0IAMDhMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

On 10/24/2024 22:23, Yuan, Perry wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Nabil S. Alramli <dev@nalramli.com>
>> Sent: Friday, October 25, 2024 9:05 AM
>> To: stable@vger.kernel.org
>> Cc: nalramli@fastly.com; jdamato@fastly.com; khubert@fastly.com; Yuan, Perry
>> <Perry.Yuan@amd.com>; Meng, Li (Jassmine) <Li.Meng@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>; rafael@kernel.org; viresh.kumar@linaro.org; linux-
>> pm@vger.kernel.org; linux-kernel@vger.kernel.org; Nabil S. Alramli
>> <dev@nalramli.com>
>> Subject: [RFC PATCH 6.1.y 0/1] cpufreq: amd-pstate: Enable CPU boost in passive
>> and guided modes
>>
>> Greetings,
>>
>> This is a RFC for a maintenance patch to an issue in the amd_pstate driver where
>> CPU frequency cannot be boosted in passive or guided modes. Without this patch,
>> AMD machines using stable kernels are unable to get their CPU frequency boosted,
>> which is a significant performance issue.
>>
>> For example, on a host that has AMD EPYC 7662 64-Core processor without this
>> patch running at full CPU load:
>>
>> $ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>>    do ni=$(echo "scale=1; $i/1000000" | bc -l); echo "$ni GHz"; done | \
>>    sort | uniq -c
>>
>>      128 2.0 GHz
>>
>> And with this patch:
>>
>> $ for i in $(cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq); \
>>    do ni=$(echo "scale=1; $i/1000000" | bc -l); echo "$ni GHz"; done | \
>>    sort | uniq -c
>>
>>      128 3.3 GHz
>>
>> I am not sure what the correct process is for submitting patches which affect only
>> stable trees but not the current code base, and do not apply to the current tree. As
>> such, I am submitting this directly to stable@, but please let me know if I should be
>> submitting this elsewhere.
>>
>> The issue was introduced in v6.1 via commit bedadcfb011f ("cpufreq:
>> amd-pstate: Fix initial highest_perf value"), and exists in stable kernels up until
>> v6.6.51.
>>
>> In v6.6.51, a large change, commit 1ec40a175a48 ("cpufreq: amd-pstate:
>> Enable amd-pstate preferred core support"), was introduced which significantly
>> refactored the code. This commit cannot be ported back on its own, and would
>> require reviewing and cherry picking at least a few dozen of commits in cpufreq,
>> amd-pstate, ACPI, CPPC.
>>
>> This means kernels v6.1 up until v6.6.51 are affected by this significant
>> performance issue, and cannot be easily remediated.
>>
>> Thank you for your attention and I look forward to your response in regards to what
>> the best way to proceed is for getting this important performance fix merged.
>>
>> Best Regards,
>>
>> Nabil S. Alramli (1):
>>    cpufreq: amd-pstate: Enable CPU boost in passive and guided modes
>>
>>   drivers/cpufreq/amd-pstate.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> --
>> 2.35.1
> 
> Add Mario and Gautham for any help.
> 
> Perry.
> 

If doing a patch that is only for 6.1.y then I think that some more of 
this information from the cover letter needs to push into the patch itself.

But looking over the patch and considering how much we've changed this 
in the newer kernels I think it is a sensible localized change for 6.1.y.

As this is fixed in 6.6.51 via a more complete backport patch please 
only tag 6.1 in your "Cc: stable@vger.kernel.org" from the patch.


