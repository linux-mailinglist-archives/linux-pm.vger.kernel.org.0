Return-Path: <linux-pm+bounces-163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3D7F6DF3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A613D2812C7
	for <lists+linux-pm@lfdr.de>; Fri, 24 Nov 2023 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C29465;
	Fri, 24 Nov 2023 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fTCDigKu"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19368D64
	for <linux-pm@vger.kernel.org>; Fri, 24 Nov 2023 00:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F55TJVa4dWdKt094ojwBroEfvZmZHQOPWI8dnvpa/Rz6/TBGOOkSkY1tsAZIL5jCXJCrnzzvyAX2oiUSpejUwljuuqGjqRdUCSMGn2fVt7AvYz4dtnLLHHevMvHo5BEyrB+76XbATvzqj+85dVj5e6DgifDWWP+WIPJSStiecixvlyAw7pqUAYh3nkYYGPdsmrRelmSSrJeBJUqRt3gwcyGWaiwFhcbahAiVF6feneoTilAocyg535W95DK/QFCkQrfgukW335sqdbbdh7WpzsAk6cvvabLaPgdqgkTGUro8YG5PvWbkJ4LiNDz7AiPVz2/MYV1uxRlJjThwCVG4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EATW4kCIMtr7jokdMjITD4ricAcRyuEzzQDz7h8gUCc=;
 b=OnXWr5D37JUlt2H0A7WZ6sjwH8dg8Z790spA5j4uGrn4AkjQWuwQQquLP72JOYQ1reubm39KGNtuLKWw9xxSAa4nuzBibSzvWYGchzdmbDqp7llcFWG4mFxDLD/OtJHXrxM0aMBxWTF9Esr8n7z70//kQ1yfaCWVVKU2Eyb3lYrLnQ4mvI128wsJM6DLdMq94glEn8AHLyS8GLn8cc7gJIF/Z+3bqmSTde/k9MSMxHZtWsmP9zYKFtwaGNbxNNT0osYYjSeRJ5l0pghCtg2WukPwrsjIQUxjVJfOdwpN9JTRglThfGpsh/RxVUjvD+PtYwWZksecPjB11kzMaX3+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EATW4kCIMtr7jokdMjITD4ricAcRyuEzzQDz7h8gUCc=;
 b=fTCDigKuyOCet2TcrCmDlRitEFGugxNATpqH1ag8/eidDcQtUAZ33QpGuDv1ZpLVtrXeo+h4fCwPZtX9WJtzztu9Tk9+3cxVm4KqB3GyfvZrMTGNj23bFWykbd68LyZjcwcPoiJen3Xa5VXbT4n5w4G/WCL1H2o4g9fPphTnvWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 08:19:17 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 08:19:17 +0000
Message-ID: <5500c7f8-6dfc-43d9-8914-311d1a4119b2@amd.com>
Date: Fri, 24 Nov 2023 09:19:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] pmdomain: xilinx/zynqmp: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231124080623.564924-1-u.kleine-koenig@pengutronix.de>
 <20231124080623.564924-10-u.kleine-koenig@pengutronix.de>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231124080623.564924-10-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::24) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d3fc83-5221-41d2-dadf-08dbecc60d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LkzN7rXYH4uuKAqZlpD9jrW3qQRgbrHS4jbznYxzqIWfno2e7PLFEDFhLBqAf5Vft2UPx5Tr7I9BBjXQoFN1ySfK5VFU13vxgj+GcT6eZ0pi/LdIIXkTbZ1AeLq3p4I6sC92xASucPx0xV1WKb6tYsmLzSmbWcP1essxefjdGXH4P+/5ekFEl/PfHChE2sgTjCbO0wAi9XHKAetFmH8TyWk7XeEJadghtPuEY0cOHxx2Xp08U202uo8cBcy7+5SxuXCSrDGOIP2IjXUI09fNHtXmu9FkV18LRBWIhlOwA0tu7DVCFzy4B0O9QDmf1fygJ6rKY6Iiziwc4JOYW8j4ppIkNuyOxIJPLxiYqR1GiPS6damszon4gniYVAWpLfYqUCCdTY1ilhczC4kNGAEVJVMeUXN9Zw6o9kGAfScOt/VQ+kOWhMQ6gJjRjoHmz02BluSDlQWiwBCBfri5xXu9LOR+GRkiBT3VZhuDsNlKut6G0/tLm7WOTYmp5dJrIHwthj9SBmHhiMZa7UyirAJskEoat5T4m0uOt4NqTjReKaIsyn6RRFK+ZkF9bCIaY1Am5B6Ga4530PEp1Md61GozjY71IY8qLmaUvHiGyTpcXO5kyKrp89gCAYkRh72gHZxy5GcLrDbkVGizRXUmMcCfhyuHtlywb0IrDrfLJvZp1JVm2zPGc7JIMx0cs4UU83DW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(83380400001)(2616005)(6666004)(53546011)(6512007)(6506007)(66476007)(41300700001)(44832011)(5660300002)(2906002)(6486002)(316002)(478600001)(66574015)(8936002)(8676002)(4326008)(66556008)(110136005)(66946007)(86362001)(38100700002)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tXZHRycExmOHdGeVo0NW1XN25ONG5vQk5MaVEwNFZvTSs4S2tPdDRYUlg5?=
 =?utf-8?B?TmQ4WHRIMkM4M0NKQXByMUJ4WERWR0xBVzNML1YybDJsaC9lRXdiUStSanhX?=
 =?utf-8?B?SkZodTZrOHRCQUFKRHRreEtuaDdHUGExZE5WTCtndVFsNGJGd1dtV2hUUm9j?=
 =?utf-8?B?bldMYSttWFlCZnR0VmRqN25sYy9Ga1VnSWdHdWdzYmJXOGM3aFFqZDQ4VkhD?=
 =?utf-8?B?Rlp1T1NqYXZHeVFFSXNxdThvVnV5d2FZS050TVBEUlUrK0lyYWdPdzIxQnEv?=
 =?utf-8?B?aGRmYms0YTBWODVGcjZ4aUk3bWwydjRkSTJ0cFdzKzdIQTlVc2huZHg5VFVP?=
 =?utf-8?B?YlMrZ2wyYk1ESG92eFFKVTdtYXhzSW9MNmp1V2FrdkFFa29vc09zZm9qZXZK?=
 =?utf-8?B?YnAxYlVVeFVhbmZXOHl4dlN0TDMvMXMzZU9SYndMSU5Ua08wb2orM1RSaDFu?=
 =?utf-8?B?MG5VV2VRaUFRN0JjNHo4bFl2K3l3bGgyWFNMeWV6QTdSSWpoeUJaazBhYXY1?=
 =?utf-8?B?SGoyK3l0U1pVeHQ0TVBiNHhheGg0ZVZrbnA4SXNGYnRlbTMxNTFTSHZEaVlu?=
 =?utf-8?B?dVl2Q1BBbDcwY1NlNWdvQ1BlRFQ4bEJHdmNPMWtBVDA0TTJxN2pxd3JtU3lJ?=
 =?utf-8?B?Y05xQ1JGMk9XSFh3aEEwU1NhR3Zjbk9OVERsYkYxSVU5QVlxbmEyMFBUVzBj?=
 =?utf-8?B?dW1lWXJkV2RmcjRoc3BmVjlwNVo1a3NXb3NtZStQTkZmclE0VVNYSDdMcUZW?=
 =?utf-8?B?bWNiUG4xeFNOOVlTT0gxbjdoN2orNldJZE9weXA3aTdHQTF5K3B3RTZTT3Mv?=
 =?utf-8?B?alczN2oyTjdSTmVCcHZRdElsdkJlKzZPNzA0SkgxUThjTzB0aXV0OVhka2xO?=
 =?utf-8?B?ZWw3T1FvNVZ6eVlqTkR4RVV0VjRvc1NCeitINGkramVvZjlmaTFOdGVVVEJI?=
 =?utf-8?B?UmhRWCtiMVZuZ1k3QWd5T1A3dGtDNzVZR1dZS2cvK1JBR3lsdTVaN1Foczdv?=
 =?utf-8?B?TGRHQjRmK3BSemRhZ1I3c295d2U0a09jNGl1d0xEUWlzbW84ZnAwdDZtV3Fp?=
 =?utf-8?B?cy9YQUpWbDBkSlErR0Y0cEdTamIvVTdnRHBnZEsrNnFVbkg4dVRFdjJKczV1?=
 =?utf-8?B?RFpldHRad2o4NlRDakxMWjQ1OWx1MkFpcXlSb01BWWxrc052cXFNLzZFOGNU?=
 =?utf-8?B?RXEwQTk2N0NXQXNNTjRjNklNYmNaNXNUK0J5WWFacGthVS9TR1BhQjFxa2d1?=
 =?utf-8?B?dnVNZ1UvSzVZZTVvOE1JSFMyTHM4ZlY2dDBkSTJxbmlvU0FnVTc3UHZpNkhS?=
 =?utf-8?B?aEtWa0c2QyszOFlZTGpuYXQ1TTVtQVNzWFNaWWtRQ3c5Y0wxcHZKZDNYN29N?=
 =?utf-8?B?dDZZc3BDTVhCZTArZkM1blhWWHBQR1N3RE1TVVgyTGpFb1NKMU43RVJIUjdD?=
 =?utf-8?B?VHlFZG5wS2hJZ0xJcDlzWlo1b3dGdk9EMWY0aGdrcGIyaUlPNXp6RElObDcw?=
 =?utf-8?B?UW5OTGZaVkNmNU1ZL3VoNUNNZmdMTHh4S1RSc1oybXNlVEVScjlaOGdFdWNi?=
 =?utf-8?B?eFZNMS8wUFFiQnl1Q0FFNmJPYytjcytDNUhmWnZicjJsM29pMTNRZWNsUFo0?=
 =?utf-8?B?RFRHeXNqMFkxWldwektDcjFab21hc1RpOGFZeFRkWVpsNnlCL2VnR2Yzbjdl?=
 =?utf-8?B?bDlKMUJhbWhlWDBLSitmaDVGdDhLWnFXTzdESVp3clpXaWp2UDVMMUtraXFy?=
 =?utf-8?B?Vi9kdk9oVzQvcWJsRjNCRktxZU11cFA4YlZpOXhJN01HZzV4SGIrNHluVUtU?=
 =?utf-8?B?NUtKaStNQUJubkFONHdUOGFpTnpCVkQ2Mm14MTcySFpmbGRMVHRHOTl2VHd6?=
 =?utf-8?B?Q3N6QlJjSjl5ZjdQYUp5aGJ3OE1pWkJOTi9Fa2ZzWjlYZmFxZkxTY0s2R1Mw?=
 =?utf-8?B?S1RtUXRPQ3JzdkxPOG9LN0FIc2hGeHo4dGNIc2MwUDExalhXNUVmdzdhK2tB?=
 =?utf-8?B?VTQ3NDRyVm5hZFBBa1liNThQd09MWlZyVnpHOVlSMEphU0RmK1dRbXM4ZHZD?=
 =?utf-8?B?WGU2eFZjTmphVFRjdUFzTVlOOXNkd0JEY3lFWlpSZDgzaUJ4NGtWbkdJWUk2?=
 =?utf-8?Q?dk8c6X6UXwBTj6sxCCl4XfKxf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d3fc83-5221-41d2-dadf-08dbecc60d2d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 08:19:17.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmD05du1Ucrvr1gQEJA7Bq9+OV3tYWN9OdSgyOZa+YcLlxMz7eS9IXkRttbc46Th
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351



On 11/24/23 09:06, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pmdomain/xilinx/zynqmp-pm-domains.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
> index 69d03ad4cf1e..6fd514286d82 100644
> --- a/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
> +++ b/drivers/pmdomain/xilinx/zynqmp-pm-domains.c
> @@ -293,11 +293,9 @@ static int zynqmp_gpd_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int zynqmp_gpd_remove(struct platform_device *pdev)
> +static void zynqmp_gpd_remove(struct platform_device *pdev)
>   {
>   	of_genpd_del_provider(pdev->dev.parent->of_node);
> -
> -	return 0;
>   }
>   
>   static void zynqmp_gpd_sync_state(struct device *dev)
> @@ -315,7 +313,7 @@ static struct platform_driver zynqmp_power_domain_driver = {
>   		.sync_state = zynqmp_gpd_sync_state,
>   	},
>   	.probe = zynqmp_gpd_probe,
> -	.remove = zynqmp_gpd_remove,
> +	.remove_new = zynqmp_gpd_remove,
>   };
>   module_platform_driver(zynqmp_power_domain_driver);
>   

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

