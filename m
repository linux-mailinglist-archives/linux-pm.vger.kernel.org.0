Return-Path: <linux-pm+bounces-38331-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4B5C77230
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 04:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA0D5358D3B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 03:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEABC238C1B;
	Fri, 21 Nov 2025 03:16:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022093.outbound.protection.outlook.com [52.101.96.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C01A9F88;
	Fri, 21 Nov 2025 03:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763694994; cv=fail; b=nhO2zBwGa/tD6uJDJ1HLKdPOSmyS5d8y48I0w3T0xYadv/PMjg9jpwNYUKxsPgfN71uewR8JXYYj2E6uK2cvnJrbi82+0zSnlM6qJkrYUyGciJEUmpI1V7xOEufK9vKbXx69G4xeW024AxjbWGDiVU4pm81JcLGbsXgpQy1Dfbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763694994; c=relaxed/simple;
	bh=FhQ1PTZuhyJk/Ll6Stb/OboKkkm1n5Sr8UqZD2xbrbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dkifQE3o447jbBzaTx7kbkTgQYvlev92rvTtEHf/1Vkj/wapkscZkCor174mwSWaD5sR/CHbky7HJYG+ptGFmcoVkRMN9C2Bk27JmENiHM7Lzb3M8aNbruGwLh0/Ddu9XVTm6I9eWqndlMgoYJnZwsPr7HHKOFCbWjQK7VR0gAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVsT42zNpDnWXZNr/8QhWVz8RRy0dexKV3PvwTwVPvY3w+NwKvksgjcVA7iXmD3t2Ku9H8SZuxRExI1lb61Cq4f6yaIbhd0QfpyTmx9oC1dVbZ+9rRitoNb2u352/bPefKGQRv3Sa42godWd82p+GcMEx4EZgiYzZipzi4eblAnINGMvFGKvkfxl1TdF2Jy67iOd9H6OtIvPbpS7LAdiL3+Gmg7x+H5+XzLoe5aQyMltawKWbhcaBi0/XOihwIXjw/LyRZlMjDd+knfNh26Yn0YURG57OTvEtuqf0W9AThtrWs936Yaw/WBHFCRreMJUIa3orBVA0sgOUOYd8CAmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HvqcOSPdNOkL8bVRvtBoetrxcngvo/oyQrWLzNz5ukk=;
 b=i297QuzvzsecwL2VPUcGsqOopYgidew+FGm6DzvNJTcMgz+YPNL7XRIfi5xifzO5PtW6opn2rK9rcDgU6FuwzE9lyX0hUrzS/lYKMu8Izx/5td6q+e1VS4hHfCjd2AILdYmPZDlAhCb3TA9RZ3a9uDt5d78paY3QY1Fs9CnfZxeL7RfKYBvR2vggFn7V3e11K2ZwJPUtYaYIf2NBrl4kZa3+Tb/3MZy1IiLzqPrxOu+M7yPw7J1okL57ZSBUkbA+xXBwzMYtchVFBApO+tieOIJtrFDROFQ9Y4YShzQM7C5+w2nsmScbsZtfCadXJEb/X6PKG8L+hF3aGcNJWMMgCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB7815.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:407::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 03:16:29 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 03:16:28 +0000
Date: Thu, 20 Nov 2025 22:16:22 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, 
	nathan@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cpuidle: sysfs: Display idle state enter function
 name
Message-ID: <oifgpnkuupj4s7picyujw3jp2b22dcdrr7kqejho6uhxh3juam@7bqtbuxzjt5p>
References: <20251119002545.666251-1-atomlin@atomlin.com>
 <20251119002545.666251-2-atomlin@atomlin.com>
 <CAJZ5v0hUWMgJVAZ36_9k8N3AdZ_rGajKpQSprF6QwUtxmpH2qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hUWMgJVAZ36_9k8N3AdZ_rGajKpQSprF6QwUtxmpH2qw@mail.gmail.com>
X-ClientProxiedBy: BN1PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:408:e0::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 675b4bf3-7d0c-4dc8-4734-08de28ac5b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2hhcFM1WmEzNlRqSU01QUowY3lpaWUwQXl6Tk9IVHlWdFZ2cjVBdkRScFh4?=
 =?utf-8?B?RHVvdUdHbkhYWnh3TWppaVNVM280TU1NMDFZK3NaR0g2T0g2UjFFOGRiUWFU?=
 =?utf-8?B?cUZmd01XZjR1anVZc25ybnZzR1licHhpaUNwVEVRYndDSnBuTTdHRXZMaGc2?=
 =?utf-8?B?L1c5a0Rhb2FraFIzdFlVYVc2ZUVDY0VWQmk3dzVSSGUxZ1QwOThSYjBXLzdq?=
 =?utf-8?B?VUVXVndIak1NUGhNVmVlYm54Ry9BeE05dllacThiTFpGQ3dBZEdkR04rWHla?=
 =?utf-8?B?WW50S0tvT3l5Tm01L1RETUFiQnljQkU2UkgrNGZ4V1IvOXA0dG12SFdqaldW?=
 =?utf-8?B?UUVFQy9RMnRyODB3c0Y0SVA0NURQbmFySnQxNFRBOHVKek5SaGhnd2RsR0VS?=
 =?utf-8?B?UlB1R0VWYXd2d3NKMVl4SkxWdG1Ya3hQTVpoSUtlbDNLQUpIczhRZGNhNklW?=
 =?utf-8?B?aVdFK1hHaXN2REs5LzVENHhHUTFLYkZFT3dJYm9lUFZjdFhwQXVDdUphN0JK?=
 =?utf-8?B?MkFjRlZpTExTTENYL2srTlVKaTRxODg5Nm13YzlHeUxST2dpQkNrVU9tYVBT?=
 =?utf-8?B?THBhTVgxeDZOSjZGQTdlSGNWZXdZZ0VlSWsvYm9CWTJzeGw0b2FBS1d6L0RH?=
 =?utf-8?B?Z1k2OW5ta1U1MXllRkRDemNrY2VrampsVnJRUFdZLzJNZVZZdUtXTy96NGFu?=
 =?utf-8?B?K2h6T1VZQ0VoL1kySWxmamwyZjVFWmkxV2pGU1gzMENSb1lOS0xhZ1JQWHAv?=
 =?utf-8?B?YzBuSjZxVkxNY3QvM1pyWlpBZVQzWWQyVU9WWndCaytSL3NldGtpR2NLMWpK?=
 =?utf-8?B?TStRS043enNaWW1QelJydTVUdVVLMDVBdy92VUlYdTlqZUNiNTQ2ZXRkbmF3?=
 =?utf-8?B?RVdFS2llTHdsVFFVTUxLKzhrZkNzdXRHckdrdCtJVHFldHA2Rzh5L2pmV2ZY?=
 =?utf-8?B?MmFENDIwbjdSUy9aUkVTSVR6alJKVTZ1NHprWFBHdFZMQTJQMktJWXNPMm1m?=
 =?utf-8?B?RDVwM282STVBakxJNVRrOXczY3h1RURyUm9ZT3E2SWtCa3JGYVk2RkkrbDdN?=
 =?utf-8?B?c2FUbGpmazlnUXZtTVFjY2tWMUpneThPdDMrSFNBakdsdEpWa3M5NXZldU1X?=
 =?utf-8?B?SGp2MXNhak5OMWlrS05ZaklZcEhiL3U1clpZYXgvQ1JZWGFQdkp5cXpTblcr?=
 =?utf-8?B?bERYNlpILzlndFdKaXBvcWE5emE4dyt4eHh6MjA1elAzdXV4UGpKYkEzT0h5?=
 =?utf-8?B?MXZjNjI0Ym1UYmtqSS9TVWtZUy84eko4RTg1Q01wK2JsQ01zNW0xU2NScGh0?=
 =?utf-8?B?eWpFZnhFNEFOMEhKaU0ydlBYV0RnSFM4Q3k4U040Wkh0RzhUaXhjM00yK0VE?=
 =?utf-8?B?YW9MV2Y1YXNRVUo0UUpHdXVxUjF3UzZjWmhGQ0JSOS9uU0pVeHFPa3FvL0RS?=
 =?utf-8?B?RzBrMWxFQUQ3OEloVUVZTWkwaDhnMVk5QUJkdFByOXhJQWtqa0lGc0p0cUlj?=
 =?utf-8?B?b1owZWFHOXpWUlE3Sk81YWJWSTlMdjVScWJNdytYUjYzUVpVU2tTQ3RMTld1?=
 =?utf-8?B?SE56WDhxUTExbDEyZWJKY251RTh0NlMwSTBvN1ExeFIvaklHRzdWK3hPNjJQ?=
 =?utf-8?B?N2thN2JuRWw2NjEwa3I2S1NINERHZy9WOUx6N2J5bi9OWTVBNTVhTEJsMnN4?=
 =?utf-8?B?MjdDVU1iYnQzWWRldWk5bUpSNjd6Y0NTWjJUdFZyWmJHdjFjQmg2UjRZOFRJ?=
 =?utf-8?B?RUVleXF6a1JVdXNtRXRPNTBmaGMxMXl1MFVFQUZsV2NhSzlEN01xc2pxOS8v?=
 =?utf-8?B?cFFkcXJtdTFSWjM0N2VHdVhOcWVLalp1T3cwTitVYXpvTFRMTHBDQ1J5aVF5?=
 =?utf-8?B?RWF1TFF4ajFQaFhCa2pZVXVQRktqSHE3MGFNTGdWOWFXWnloZTI4OUhVVzhq?=
 =?utf-8?Q?DqDTUZMcBaxBGTqQ1IWVf/XbW2h25zmu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTgrTWpQV0tHM1EvSXZuSUN5TVo3blFTTWRTR3lNWGY3WHZmOXcvS1JCaTRv?=
 =?utf-8?B?aGNjTHhuUWlyTW1BZUc0cUI5RzVxUDdIVUNyZ2dUb2RuSGdaNktpandGY2pP?=
 =?utf-8?B?d0p3M2FFRkxOeG1oRFNZdDYzdnVtRk9IT1lKc3lkR2lEb0NHZWwvRHVIUDJO?=
 =?utf-8?B?bjJzUVA4TVNGRENRNC9kbjdhSEZoTU5aTVJKRlpqWUtqYnUraFdaTUlJZkZj?=
 =?utf-8?B?QWs1aUxIdXl6OHFWVk9uYTlLamg0SmNPSGo2ZXR1bURJVXNHdytwa2NOcEhW?=
 =?utf-8?B?UDRUZ3JCaXpqTEtqYWp5K0ZhbVpyTnNjYnBtWjJ4bFpHdEoyQTg5V3YzZk1F?=
 =?utf-8?B?T3lyU3VmTUNKdks2T04wQU8xcEFvL09wdW16c1Fua1NzUGJGR2FLb3JLREJJ?=
 =?utf-8?B?OWtnSXhnellhSkR6Qlk0REFWSjFnM1dveFZaaDlzbGFJWEhZdjN6RU9PZ2la?=
 =?utf-8?B?bytiWDJOb01mUEFsK3lkSlREbzVlYk1sUVNiNldIMlVmLzE5MG5vNml2bmpU?=
 =?utf-8?B?M2dubWNvTm5UWGxCRlNlSTZ0aW5UbDFaakNVUWFQaWg0ZHhhRFQxZGpDTUV3?=
 =?utf-8?B?QldVYUhXcXJHRmh1SUJUOTVwaW1PeWZHRGxDbXh2K0szRTlHeUJpWFQxNUJv?=
 =?utf-8?B?NGJpajhNVDhhZm4wdWZFQ25BK2JKbjlGeGtWVzZUWGZrOUxrTDJQSVB2dWxE?=
 =?utf-8?B?UUhoZTBYS3NwVDRyS001N1l6S3BNcEh3ZisvRFlheDkxbzdHMFdrdVVtY3ln?=
 =?utf-8?B?RzlRem9selZ4M2psU05zcVU5N1RrYzJEUnlnY3graEU2K0taZUt4NHY5alRE?=
 =?utf-8?B?MTRQMXFvWVhIdmdUNEg4aWZ5UTZHanloQ25uU1ZtdEl1UlFWMGJPOXEwNjZC?=
 =?utf-8?B?bUZ1dldkSk1GZVU1aDR1UVRKY2wvelE1UldkOXJyekdhNnlIKzJRSWRNbGNy?=
 =?utf-8?B?ZTlUR25ES1ZaaUNna3RBb0x6ZDQ5NFJHOUdGb1Z0RHZWTUxxbUJRQnpScDJq?=
 =?utf-8?B?U015RFlrYlRBRmZvZDdBOFYyaWg1SGpkUWppQWxoZGJZS0x5UUZQczJSSlhh?=
 =?utf-8?B?b0c2Z0UyZ1JQTjhVd3Y3U2liYXkydlhwYUpvdlN2RklGMFpkWHIwaXJYTWgv?=
 =?utf-8?B?VXJucDJPdG1nVkF2aXZRVzI3NHJzaUJjdE5kN2pLZFV4MGZuV0QyNWpBZ2Zn?=
 =?utf-8?B?blkyTmora3hlSDdjKzRLVmVGdzZ4YjhqVWVHb3U2K1BPbDJiZ0wxMVBoOVg5?=
 =?utf-8?B?c3RlUkN4QnNkbHlabXZvNjFPTzV0QSs3OVMvUDlybmlrV3UxU1lBdkFwNFhH?=
 =?utf-8?B?cDVLOThwOHJXNjQ0SzlWaXJCelo3N2c5emNyQzdwS3pVeW8wbU5VSURIMGdl?=
 =?utf-8?B?WnhaUmM4bEhCazREeTdtNUI5a290U2tVbzBtUG5XRVhkVk1HMUt4eHJybXhk?=
 =?utf-8?B?aWF4bWtKd0lQUUFmT3ovc1RBYVdWRjZuK2RpbGh2ZkdiUGFjMnEwc0pScWxD?=
 =?utf-8?B?cXJxUDdIVXR4Qlh1WjkzM2tqenNReVd6R1d1Wis1eXltWkRZYzM4MElNbnNR?=
 =?utf-8?B?b0o5YkZHTjVuQnArejIxOW15TFVmL2d6VkU5ckVSQ3NOcFVaemhFQWRMQ3pJ?=
 =?utf-8?B?S3J4ZSsxaHpwdDhzMGYwaVFyNjA0SC9ERFFrZ2VjbytVTlFUYkw4QVlGVHFl?=
 =?utf-8?B?OThiSndYRlV5UnRoYmFtT05LRlZXTFRMSk93L3Vud25CdGNzY1FIN3Z2QTZk?=
 =?utf-8?B?WW1BUWJjY2hiQUVnYmNXWm5SWUFXL284em9iL2EwT2Y2ZlNtSlE3S21UTjBr?=
 =?utf-8?B?ZjdORXN3dTdTWGhTSHRvSHI3L3VYQXRzejVOZEVnaER0SmJ4OG5XYktOdkhR?=
 =?utf-8?B?bUVvZ0ptQWNGd3ozRElLNU14T3l2MTEzcG5nT1dRa3o5UEp6N2tqU1A5US9P?=
 =?utf-8?B?NFNTT0podkE0UUx1Q005Tko0OUFKK2k3RDZHWWtuRmptaTJEeEQweXpsTmRZ?=
 =?utf-8?B?ei82WlM2NWdFbWFpYkN3WWdmejFTdTJKTisxTHNQNDFhU2V6QmtMMEVPczdT?=
 =?utf-8?B?N2dTV0hGa044ajIxNWMzbDY3dFJMTlNOZkFETFVhbG1pRkUzNjl5ZUQyK2JG?=
 =?utf-8?Q?kMdiVONeP1SkxsIafYZ7MWQF+?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675b4bf3-7d0c-4dc8-4734-08de28ac5b3e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 03:16:27.9322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7IzGLzYV5EiR1glqsDqOXtWQq+I4omwXaSCATvs8ji9UM5YU3VR8hRcDblrSl5dYnKfRvGKsZTlFXGcetkNbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7815

On Thu, Nov 20, 2025 at 04:36:21PM +0100, Rafael J. Wysocki wrote:
> I'm not really sure how this helps.
> 
> For example, the intel_idle driver uses the same function for all idle
> states except for the polling one, which is already advertised as
> polling.
> 
> Besides, why do you want users to look into the kernel source code to
> figure things out?

Hi Rafael,

While intel_idle uses a single function for most states today, other
cpuidle drivers, different architectures, or future changes might implement
per-state variations.

The mapping from abstract C-state names and descriptions (e.g., "C1", "C3")
to the actual kernel implementation might not always be clear. Exposing the
enter function offers a direct, cheap and reliable way to easily identify
what is being executed for each state without using a kernel debugger
(e.g., crash(8). Finally user-space tools might benefit from introspecting
implementation details at runtime to validate configuration. This is
primarily for the advanced user.

Please let me know if this clarifies the motivation. 


Kind regards,
-- 
Aaron Tomlin

