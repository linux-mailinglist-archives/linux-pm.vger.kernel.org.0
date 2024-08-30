Return-Path: <linux-pm+bounces-13211-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5911C965D44
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 11:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5441F2163A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Aug 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902EE17A5AA;
	Fri, 30 Aug 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="qQJT4st+"
X-Original-To: linux-pm@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF09176252;
	Fri, 30 Aug 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011110; cv=fail; b=XmmwqF6wricGHus0aEbKW/YWoKqId1quC1cGjO0i2IgyYwyoDBt1rSrNvooZp8j4quT574S0MrgRY4MmFTfdaQh9+4ju/eX3VUjprZKuY5EMloRX2C12P57QhUX85hxbNwl4lvhEePNEU+yK/zSSCq9b9bhd8GX9SM49LUP9rtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011110; c=relaxed/simple;
	bh=u4jXBcSinh+yqbyYYbkDCcLb6AUB2tAmtEZbtmbBh1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/1Z1DlqsrviYjcb7ZAN/woJBnXJlIhAi64a7EsWOJGwWlkIghad5zxe5+DN3fkXISr/D10DsYNY7CREB8fkIPDaRsevYBcQXHCyFyWNR3lUYAcM9L1h84KqB80fkB8lZQvm1HZXU7E5wPQQbODY4fQcrBDpXpKDSUQAHa/WAHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=qQJT4st+; arc=fail smtp.client-ip=40.107.255.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYdSwB5gXlum6OQtDIju2bnNEg44zkrYY9HlVSrl6X5+0QjapGInEKtagZmXMZu7xH8qBkPMTHAtTWQgstw0GV069pYCQ7kQimnpEw1d7iHXULwh269qAfny+1lm+fl0PuVnX+CWxo7n7RqaHX9Wmu4WBv6B7Siz1TrlM4hgTI7I7Us7qnBaHlTIxjHjzvxQpyXNITss3GbqjZnniPJqSLkdsT0UJ68hxpYdt08y5n6OS034zCVwNRSrFvlL8YxyZEJtO7b4YOh3AhYYvMU15xvGCiO4HloXD1yYKoLjmTI05n5xhPqDYskHqCd41VK6iC6kJx6iBHNUnXhyv1CVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5swmoG+gYnEXV1pY1OxihFZMcFESuMOmo+zisp/Zm0=;
 b=sjBmbOOJLE8A8SxCCweX6dFn5Z9H4e8P6DHPOfWMPvOIsv53c1XNIaZoBS0Uk1vSBXrtkfELO9yQxps6MBXhFthcq/8qAQ1ngYXNOPINrpuWA/+h1Ngs1S2IXwLbEmRzpwGfpIvenqQRI9lARXcg9g63LyohLgL66L83fiue2lU2gsE/r89TlEy49XHPo7+yZwFwh5JAAvXu3FtYlztVZbiseJrxa3lrI8isdHqAEoxsZnobhcso2KOHZ9vX1ELyDcTk8gNFPklrRnaZGgB2J7iCnoPg8St+i+s57zXMZjVtkVAlsmXKprMT5DFHElPZGd66YhBIm6zz+ltNbOtwxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5swmoG+gYnEXV1pY1OxihFZMcFESuMOmo+zisp/Zm0=;
 b=qQJT4st+Vn4Y2bo9Evscaa9d1suZWhCOKvFDFek0k/RB9poSv52rEw3rx3IgxfOIzCq7I+Sn1gcEL4iHY0pFYkQk5L84RJm0GRuv6IBp/mEfDepa0dQZrroiK4vLDQjnW6MiYmjCUMcJviMS4/rXD8ONbxm2jQE7EufrqSiyXPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
 by SG2PR02MB5482.apcprd02.prod.outlook.com (2603:1096:4:1c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 09:45:04 +0000
Received: from SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7]) by SEYPR02MB8152.apcprd02.prod.outlook.com
 ([fe80::6bae:c194:2032:70d7%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 09:45:03 +0000
Message-ID: <8f1585ed-06df-400b-b0d4-c0091d980cd4@oppo.com>
Date: Fri, 30 Aug 2024 17:44:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: queue policy->update work to rt thread to reduce
 its schedule latency
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240717063321.629-1-pugaowei@oppo.com>
 <b07c39fab5ac0e32e7768ed3e8a799c8eb68802a.camel@linux.intel.com>
 <06ce2143-cc74-41e5-b39f-15053133b232@oppo.com>
 <CAJZ5v0jno7jvzFY880wZi9ft6GsKXbrEintdCrP3sFuxuwJZUg@mail.gmail.com>
From: Gaowei Pu <pugaowei@oppo.com>
In-Reply-To: <CAJZ5v0jno7jvzFY880wZi9ft6GsKXbrEintdCrP3sFuxuwJZUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To SEYPR02MB8152.apcprd02.prod.outlook.com (2603:1096:101:206::6)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB8152:EE_|SG2PR02MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 690684b7-4728-4231-dd6a-08dcc8d86c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhyZnl4Y3Q5eTdmbDhZRmUvTlRIMmx4cnl0aTBUZjhDRk1LS0ZVbTFFUWdT?=
 =?utf-8?B?Q0FCVzRSeDNPNG0yNU8vQ3BzbzNFUVV3U2EyK3FJaUxQRnZNZ2QyYW9PbzlH?=
 =?utf-8?B?ZGRNQ1g2dnBWUzR6RlkwQktEaFBQdUFqT2tsa2dVc0VWZkxzSHZFYmVoekFk?=
 =?utf-8?B?Z0lSVEVwcndUdzNuaFQ5b0tCeEU4bUcwQnAzNTRPQWZ0bUo1TUxiYXZGY2ND?=
 =?utf-8?B?eENxQWFkc2J3QzRKT2QxT1NCM0tBZWVlWk83VTkvWUlCc0NnMS9UZThxS1g0?=
 =?utf-8?B?NUdWUkhaNGxXUlQ1cG9tajc5OVAyck9GSTVDQ0pxOGRUMzYrTzE2a1ZFNHYz?=
 =?utf-8?B?TDJsZmdhY1VkUmJrL3dNVll1L0hNaThEUkRJOXRmeGV1dDU3b1NSNmMvR1Nr?=
 =?utf-8?B?eEdiU0hUZ0ZJb1k3dDVjUnhaM1V4OENMUFlGZXNnaStJSnBmN3RzcU40VkF3?=
 =?utf-8?B?SXdRVEV0NzA2bFNZR0o0a0M4NkNmK3htYjcxakFIZldUaEdZTXdXZVFuQ2x3?=
 =?utf-8?B?WTNvZDIvL0ZBK1dCekJOaEZ5eUpzQXNUY1lTclFuSVFPZW5JZTRqRGRKWjVW?=
 =?utf-8?B?TGxHK0VtckZnUUg0c3A0SHRuNHJUeHd5YXB3NDRsN0l4SVdpakR6ZTdnZ0Qz?=
 =?utf-8?B?N1BJZExqVkhOWURrekZSNXQxRG9hUHdlWUV0R1ZOTmUzajAwZzVZL1hsTm1z?=
 =?utf-8?B?ZmpGVEZ2VThkM21PUllkaDZqcW95V0hlR2FxbnR3QU1JaG44WEhnYXNMQ1A1?=
 =?utf-8?B?N2ozU0cxVEMycGlVQjFlUldseVJ5MHZIM1NKSnJqc0JEMUlwRGpSUk9Bcmkv?=
 =?utf-8?B?MzJ6NjJCa1YrZnlOQTdQMGZVa2J6UnJ1eGJtQ2tEUk5Ed2tXK040S2djRXBu?=
 =?utf-8?B?VHdiWWZYSTRDK3YyRFJaNUlCVkVwNTdDaEpnK1JIeC9MS2hiOGV6N1JkdE84?=
 =?utf-8?B?ZHZSaUFNR1NQZUN3b2RPUEFPT3paS3NhM1FsSmJ3VWRVbEtRci84eHJOZk5I?=
 =?utf-8?B?S01Ra1BhdjRHT1ZYNUxDUTd2M1ZLK0NwTzN5Wm93TytVNTVGd0kwZFhhVk14?=
 =?utf-8?B?UkRlUExUb0RhWmRvakNqTDA1NXJ2WXhoQ1NHUkR3Y29vSStQRUJCTXB1czlq?=
 =?utf-8?B?VHFEbndYSlhSRURhVUppMkI3VFpUM3lIR0pnZkZCdXVxVDd1UU1JbFhpQlFn?=
 =?utf-8?B?UmpmMm9CdmNqTVVRblQ3ZURqTVByK3c2ejdmdzUyYnI1QXBKaGpKS0VEeVhs?=
 =?utf-8?B?QlUxakh3eWpuNXRFVVdSM09LaHA1TFdDMHFSK1BBQUt5KzdqbmxXZzNEUzNj?=
 =?utf-8?B?TGhIbk9ZUlg3WW82WTN6YUpBVWRPY1IvNDBXc3l1VzlZaDIzVFAzNjhiMjJN?=
 =?utf-8?B?bGU4bWE1amtxZ052bDgyckRQVEp4RlB6UHF0c09OSW9LMlZhOWtobEI5UEdK?=
 =?utf-8?B?djZOUEhQWHRQSmNFWm5acFRxU3QrdlJnSUFiZXVYOFIrSXhVNU5waHlDNzN5?=
 =?utf-8?B?cHBQMmZIL2pwT2lhQTBMUHlhb1daRU9RZnBIM2dxUjhZVUhSUWNZZXR6aFpa?=
 =?utf-8?B?WXdkYThVZ2x5akZQUS9xMFc0U3pCditXOWFzR1RKdHpzV3lqbE5uMmIyNjI2?=
 =?utf-8?B?NzhUaVp6OWUzTUZEOCt4UE96OVhEQ0VJNlU1dms5OTd3N3gzYkRMUTh6aG8w?=
 =?utf-8?B?cXpqZ0FrSlVkaHB3ZmhKeUpLSWxVb2pNT3pPV1dVSFNZRUVTQlQ1ekVtQXZq?=
 =?utf-8?B?amJmbUJaUHdBOTFscjRZWkduVWhhNXJCRDZUdWtocjJITUZmMGcrVEIyVmZE?=
 =?utf-8?B?bEpEanFGdTJRMnVBUWsrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB8152.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0xZWlV4dUVOUzdEWjJPM21Nb1U1OGk0Mm5rU083VlBXSkQ1R2lFc3lUZTJJ?=
 =?utf-8?B?NG9sTkNabUxZck1aUzFNaGxmUklMbUlwMTZvV0lrKzdCWTlvTDBhTENXZ1ZL?=
 =?utf-8?B?WmdnTWY3ZkUveU1UckFTemJoQ3ZVSnhqTEozUEpmY2NkRkdDaW85Z0x1dFE1?=
 =?utf-8?B?cW1iMU96cTJESUNOU0MvbU9zLzZUeGcyT0NnTU1pdzZGN255bFUrajJlVFFz?=
 =?utf-8?B?Q1dhUC9xVk9YTGJsTlVZMG5kdmI4dnpRaEdSdURqTU9ETnNrOFN6R3VrTW5T?=
 =?utf-8?B?M29tQm9sb1N3V29MaFNsZGhzYlRHTEFwdzJZeVBLQ1RFNjh0UUxNLzE4dDQ1?=
 =?utf-8?B?RFVhRGRPcnA1WGRkSlVpcXc0cmNWc0lyRTY0blI2V2EzR1NxN0IxVy9TcWli?=
 =?utf-8?B?Wlk1SStXd1Y2NGhTVU5XNURKTDE1dHdXQmcvY3B6VE04cFpVaUpvQkhIV2hN?=
 =?utf-8?B?R2VoOGpQaVBZalBWM2JDbCtBZUFmK1J4VGc1OGgwMnk3U0luZkdMTWdneVFB?=
 =?utf-8?B?YU5qQ3JGQWVSeFdGdlUxOHB6UDZVb0hIWHZPcHRWd1pTNEl0SHo3MTZ1UHNw?=
 =?utf-8?B?bXVmY0tkSy80aXlBaUVKRHJ4c245cnVTY3pVNUlRdThuYTA0RTNmcUtxZDRj?=
 =?utf-8?B?QzVwaE5NeTArbXBDWU9XVnhRdmp3QUpyNC9Ed2lLYWFFbjhoWmNkUmdXcnZh?=
 =?utf-8?B?V2dpY1FVOGQ0U3RPTXNVKzNjUlFTZnVuQ0pNYjNTZS9zZnBXenh1MlVCRURY?=
 =?utf-8?B?RnVvb2hVdXJHNFE2NzljcnJjU0I1K0hoMm9wRSt6WUx2dXIxWVNyMkQvcENS?=
 =?utf-8?B?TEEzZDhvelhlbXU2TEFSeHBab2pId05iaVVCc0JoK1hyZ1ZReHBzdUkzZXph?=
 =?utf-8?B?ejNRLzBscXNHZm9IQkdZQlQ2RG5yR21IMTAxSkx4MjM3S0tybGF4cGh4QXRZ?=
 =?utf-8?B?NXMzcG94Zi9JNjVFeW9xeDJ1WFdJRlA4TjFhcm9kRUc3TTY2aUxrTk9ydUpR?=
 =?utf-8?B?TVd2ZWtXaTVPRy9GUXpOOEpFSUNIVFZtaTNJVTU1OGdoekQybkNCTXpjcEEx?=
 =?utf-8?B?RGpjaUNxV0lMeHFHYTRIVGluWkpIMGlYbDBQYzZWcndCSklvdDNRVy85YkV5?=
 =?utf-8?B?L0xLc1ZQTWNMQUliS0x4U0dzcUJWUHRKR21zMmVHaTBWMDdpekpma2l1QmNn?=
 =?utf-8?B?dkM2dmlPWmV4VUN1cmE2WUpUaURDTDJLc0o0U3oxRFVhUDhxais0VWFNUDQ3?=
 =?utf-8?B?Sm1EakZBR0libExJdDg0RjVpTS9KWTlTaGFzaFo4UnFjZ3VubzJZSTFMS0Nt?=
 =?utf-8?B?M2lhaW1Tb1lQRmlTS3BhK2lQbG1XSzFkVThBZ252MEtRLzZURFVSbWVabDFr?=
 =?utf-8?B?aDlMWFdLY0hDWkVjS2xnUWRtYmRLd0JiMnJYNlBsQTdYbU1oMFZSYUVjRC9M?=
 =?utf-8?B?NHJuK2YrYzRCMTNpY01FN3RDejlsUjVhUjVyb2NFOGE1ci9EbnBXMmdVM1pM?=
 =?utf-8?B?czQveWRGaVJ6UFIzUWNsSCtqYlFMVWdFVlQydERidU15THNvRkI2NkVSTVpU?=
 =?utf-8?B?VVExeFdZQ09ESVdNRnlmeWdvc3BvTlhXaytEWFRLbHFhTGZ6d3FWK25kdXEy?=
 =?utf-8?B?cXU2Sk1tSXdORHg0QkdSS2VTcXVkeXhjY09JVzhjVDhoamllRjg1YlhOVXFO?=
 =?utf-8?B?WmplZ2tidW43N1BRd3hZVVg3TmhzNlZyMWVjVTF4dXB0S2dpNm9SaGtCVzYr?=
 =?utf-8?B?U2lseEFwT2FDcThPYWE4OWJqcXZnYUNhb285TEZLU0VXQWtkc0liTldXc2NW?=
 =?utf-8?B?U0FUN2NlZ21WbDBQNnpvc2dEdnlHdlBGd1lqTjBHamJTT3cyWm5PZTg1SVN4?=
 =?utf-8?B?L0ZmV0tPVlVHc3M1SXFHaFYvU1lEdExlNGl6Tk04UW5IYlY2bTl4bzViY1Bs?=
 =?utf-8?B?OHhxZFErWXBqcmNxY2lMY3l5aWtuZ0ppY3RXWTl2S0RSZHVnUDFqYmNJOS83?=
 =?utf-8?B?M0NNWGI2SDJhL1VjRGFNZy9Ea29qOE5Sbk0ybUJjUnNOYkkrVXFrZFVLYUs2?=
 =?utf-8?B?OHpMdzg5ZXlIZWpjcDBUalFBcTQ2T3NnQzVvRE1NOFZDMk8zVXEzYjFsOVNT?=
 =?utf-8?Q?1poJnJYQX5qGg7y7wTxmMsWxy?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690684b7-4728-4231-dd6a-08dcc8d86c51
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB8152.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:45:03.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PGK2XA4S2hfaPQTP1nvGsPssd6b454NF+U07X1GTGdp70GeQb0TrL1jUZymzFbxGDhEDCw77AV+Dy05rJo9Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5482


Hi Rafael J,

On 2024/8/27 1:48, Rafael J. Wysocki wrote:
> On Mon, Jul 22, 2024 at 4:30 AM Gaowei Pu <pugaowei@oppo.com> wrote:
>>
>> Hi Tim,
>>
>> On 2024/7/19 6:03, Tim Chen wrote:
>>> On Wed, 2024-07-17 at 14:33 +0800, Gaowei Pu wrote:
>>>> Currently we encountered a problem that the cpufreq boost latency
>>>> is about 10 milliseconds or worse when we boost through cpufreq QOS request
>>>> under high workload scenarios, while the boost latency mainly consumed by
>>>> schedule latency of policy->update work.
>>>
>>> What is the tail latency now after your change?
>>>
>>>>
>>>> We should ensure the low schedule latency of cpu frequency limits work
>>>> to meet performance and power demands. so queue the policy->update work
>>>> to rt thread to reduce its schedule latency.
>>>
>>> If my understanding is correct, kthread has a default nice
>>> value of 0 and is not a rt thread.
>>>
>>> I think the gain you see is
>>> your patch created a dedicated kthread work queue on CPU 0.
>>> The work from policy change no longer have to compete time with other
>>> requests coming from schedule_work().
>>
>> It's not just other requests coming from schedule_work(), also some normal
>> cfs tasks running on the same cpu.
> 
> Do you have any data to support this statement?
Yes, i have some systraces in high workload android scenarios. 

will send to you if needed.

> 
>> In order to not competing time with the above threads, i change the thread
>> policy to rt and prio set to 98 to reduce the schedule latency.
> 
> By how much?

the tail latency now is about within 50 microseconds after my change.

> 
>>>
>>> If the policy change really needs to get ahead
>>> of other tasks, I think you need a dedicated
>>> workqueue with alloc_workqueue() using WQ_HIGHPRI flag.
>>
>> I think the cpufreq boost or limit action should be trigger in time to meet
>> performance and power demands. An dedicated workqueue with highpri will be
>> better but maybe not good enough because cfs pick or preempt policy is not
>> purely based on thread nice value. So i think the final solution is rt thread
>> and the policy change work deserves it :)
> 
> The "I think" and "maybe" in the above paragraph are not particularly
> convincing.
> 
> Switching it over to use a dedicated workqueue would be a no-brainer
> as using dedicated workqueues is recommended anyway and if it
> measurably improves performance, that's for the better.

Ok, thanks for your and Tim's advice. 

I used the dedicated workqueue with highpri(tested and the sched latency is within 1ms) 
to replace the rt thread and will send v2 later.

> 
> However, making it use a worker thread the way this patch does
> requires quite a clear demonstration that the above is not sufficient.
> 
> Thanks!

