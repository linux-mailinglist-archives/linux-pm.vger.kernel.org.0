Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469336083E5
	for <lists+linux-pm@lfdr.de>; Sat, 22 Oct 2022 05:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJVDjj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Oct 2022 23:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJVDji (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2022 23:39:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2013.outbound.protection.outlook.com [40.92.23.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2692AA151;
        Fri, 21 Oct 2022 20:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMH7Dzs0Yzw7wsDEMwJLBOPHNcADXYgAONwRJaVUh2nF+tZisbRuKCx19dUSZdrxa7chfiQpO5uCikDYMhVIGM1Gx8VRgRFov/zkZ9NOBSbggYmseTwRdzShdSZkW/HS5pqHyzmvhUkbHB/yApEawDHvaoclVxEZwguLflhsxEiZBjhRjM9NnOOUcWsJrzcFEIUUSuL4jp8q+FJ9hCoQME8NrlI2Uo7VaNd89li6hBSDk3rwCTTJkWQwtpIgES9JuCKCMpAU19oFT+TJPJ1j2lKyYal7qziocNDuRB7XGDbnP1JD80SO7EgNLdXkNrUQEPvqH6+casGKWIg7URj7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPXfe/g/UxymDcXAVBWFiRNo255z4leSuktDmr1fJfo=;
 b=fXLFurJmTZf1InkIKArXv7YzkvP/NeeL60vRAOszTbhsaXB/7B0Gzgm8lp9TtTB6ztXzpJD1YIIj/uCmSNnvpQ10P+uQresoYosqbzp1+TucTBiN5VO5JtTVWhEooF3KOnA9CJEAc5pNGWJD4B1I2GcQVB16QDUKW+/K6Yt0hjQw6ESOlI8mycSOCY0s8m6AG9rYQWHGOTMyxp4gkBGfE22/dbvSIAV9QqF4Zr3nC+cgxKQvgrKqQ54OG3o3mvLLIWhXVr+5SSXGYKVmgq0VgBmHvwM3SrQJ/S0a0sfeOCzKdQnIxzr9CSJOZGwTL9eo9He7wmh0eX8GMiknwGllJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPXfe/g/UxymDcXAVBWFiRNo255z4leSuktDmr1fJfo=;
 b=U+ZGrJNHStxGI/3NgMqA936M4tLAveqTyjvY5pWVfAmPS2y6wHo/P+2JDwCk7jQlDAGHnsoWJJp7UrrqyJDJo1CFA3AsZjaL5qI1AZnHKzQQMAZAyS4QNe4WER0wmOIaGPE1P1dmPYgEEIOlwdbv13lCVqlkp1ZFeyjyWuQY6isEDyArI6GjxzWfYejWwzrmYYOmHNiq/nue+Pfxq2fn0aW2xq+dti8VDF9PVPiVQejVL6JbW83xDlQsdIkvTr1qEHCXZ9/54Ly470c64CyFeeGJaRC1FoMLwhyTIrj8I0ttBOSvEJHF9UBUf8WEBBqQv/+vMbA+13S7VCu2P5PuGw==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by SJ0PR06MB7469.namprd06.prod.outlook.com (2603:10b6:a03:323::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Sat, 22 Oct
 2022 03:39:15 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::b849:682e:6222:2b2d]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::b849:682e:6222:2b2d%5]) with mapi id 15.20.5723.035; Sat, 22 Oct 2022
 03:39:15 +0000
Date:   Fri, 21 Oct 2022 22:39:09 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] power: supply: rk817: check correct variable
Message-ID: <SN6PR06MB5342BF344D2BF6D10F3B4ADEA52C9@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <Y0puvQLWS/rQ7hSb@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0puvQLWS/rQ7hSb@kili>
X-TMN:  [S55Q1pbTv12aDLIzaDk5HIiIqbjLpSgx]
X-ClientProxiedBy: SN7PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:806:f3::33) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20221022033909.GA31478@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|SJ0PR06MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 68796291-5503-48d2-d1ab-08dab3defd9b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMT2eXzekpKAwyEoEkbd9+ybnLHeV6JSHRQXvtZurO7xhDmbRu5l0vwLaTces2EfVNkJZVlmjDA3uM/kSuY56C8coiP5OwI2B/gPtvFpdEOSt3KkXgleIRz69N4NDQYnSEJML46SGhLatgXGGxN40/zSAjvJChPcWz8xo4hlUmAY5ewPNdu4NC+bIXCB6J67KGSryG8l7F6kJqS2qtSRrtWvpRjZxzYE+Kta8ZnrH/5CMDLiQfQjI4Pj7QzobN3D+mYqdxtpT3WwjJ1Pe9g9Rji1GXzUnp6Z/chDQQIEVC8Hy1i7y43Cyt93neVIJwH3BVb3pztlUzNudMwX2cgS7RiEas336pSb4Bc/rEPv8AbaDPX/RWsV8ujrv6hIsM70fGYoyaIiG7XQMjPEWb3VuqQp0cytxSg2KFVn5GQ9y3tqijtdVusva3aWtcQ0eK8vzEoaneNcl7QiTDj1PTqFZydS/cA1o7W3u6RukE4H7nHjN/3jf8kuJXQm74U3rZAVJWbsv7yFdtb6XDHwqMjNPwBNPkKzStE/ErOp6JDpHLGpY9UZ3s0gxUR/Tn2FK/i9RcrspFkFQIZvz1o9oq/0csHYuTKkx8klhSAUiKGpqpqlvSUOyk5hAEATAl4uhgIQQYF51FVaqmUXg9DCL16hK3bdSdwc6UtLAzrxCJNTCrKcN+BPUdpsP2REj4gKyfLU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8ae3OxsGsuY5y2ofYFGuQe246WcLQIsxXIeBmt9DadMYuJgEcL6+rsrzWwse?=
 =?us-ascii?Q?RbUEm45fu2Pn7psmd6MyfnYNqTtN9iiBVFDHBxYiKcYFdOOeKojU+2t4Yds1?=
 =?us-ascii?Q?m+l8pIQg/1OL8JykBhbRiTi5S/EwC35877ShgUriSLa9GV7vFr5LH67CJpxT?=
 =?us-ascii?Q?Cd5kBzoTWQ/kCLvrN8uSFin5e2edxa/NVmxod+06g9NwY7Wg8gL0/iZqbKz2?=
 =?us-ascii?Q?HivBToU4siHAANJjlbT8bj3c9lVSKN6NA/lxbjbqQ3H5OV8UAYuarqoRzm86?=
 =?us-ascii?Q?codKBP00thK6oq7tQvHj2u5yC3Z3b1laT4x2NwNPFS9k/6KrmhDgP2Pkbp19?=
 =?us-ascii?Q?RBTL/CYOxLolknoVBDerZ+IUfXfHxEXnw0suwLSr70NTXRh3dhlZlQBQbiuH?=
 =?us-ascii?Q?siyrKPsHUqUU4JfnUJBP6E6VzIXHjESsdwobwBBx7fg7Xhdta/PhwMAe3XXf?=
 =?us-ascii?Q?SL7OoobWt+HOJcAfYm6d6mgQ+GocIVPvxgXnzHe0CY+0xpKYDIqriAoM2Rj0?=
 =?us-ascii?Q?A8yLYoo7Kd3OTtaQ7nYblpNCzMxeIP6r4P/syn10Nkwo2zyzAqd1pRsJbQ2u?=
 =?us-ascii?Q?38kQukUsTJ/zOc556U7qI4KG5yNHWtMgTMVTDpZNAq47Qr8wzgJq9Tag5sz8?=
 =?us-ascii?Q?825bKbqviv38BdIBRQMHWyP6AK7R8E/N5aljXGah141O0XeNA5RdFvn/HjTe?=
 =?us-ascii?Q?weypCoMV9kOnpnHLzDNYfsFDDsYQzJdz2KNkaox9PinxMVE9gGHBkzcnowE5?=
 =?us-ascii?Q?VUZ17JYZNjlz+Hdu3GCaaqBfsjGx2VTy6Yc5IrzhZ5mq47ej2TYjQ7LT5mYp?=
 =?us-ascii?Q?kD5kapzMpqVMy6ifTHc4wgWFtVtvGCmFYVXzQ5aro1XDKdkT1H3wOG5+j1vY?=
 =?us-ascii?Q?h0twVezVofzt5wWjOj5J5v3ckXgGSKbUTairjR2GvRCEnKdpih9nbOZSEnX8?=
 =?us-ascii?Q?xre3Nc3cmjne6rJnR7BFkiOtmxit9x6d3vskLi9maIVIzM92hG+7rBsTz1v0?=
 =?us-ascii?Q?rKfXywG453qwfkCIvF13UUO+TLWigChHbPvWJDi1x4u8EB4yMl3nlb4JqRPN?=
 =?us-ascii?Q?OaWu3RPmhrHp6c0LyzZQIZeJQjeil37IJjEPSe0/psZbhtiR3YYSbfwEIs/X?=
 =?us-ascii?Q?LS7F6aj6VuIFt/tr2IuTl+bUAgZPowadTCxY3ohZxRTFFtLrWNS0uZyK64Hi?=
 =?us-ascii?Q?1CH6CsxGe7dS8nYeJJjOt9UHIFVTtYqAPeBsyeKeEUxZx3Kyf6m7xok6UCiJ?=
 =?us-ascii?Q?CT83/xG3J/TRLy0KxPj88Dq9chWrQgTFJ0sXptCLWw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 68796291-5503-48d2-d1ab-08dab3defd9b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 03:39:15.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR06MB7469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 15, 2022 at 11:26:37AM +0300, Dan Carpenter wrote:
> This code checks "->chg_ps" twice when it was supposed to check
> "->bat_ps".
> 
> Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Not sure how I missed this, but good catch. Sorry I've been away all
week doing work stuff.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

> ---
>  drivers/power/supply/rk817_charger.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> index 635f051b0821..4e9c7b191266 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -1116,14 +1116,12 @@ static int rk817_charger_probe(struct platform_device *pdev)
>  
>  	charger->bat_ps = devm_power_supply_register(&pdev->dev,
>  						     &rk817_bat_desc, &pscfg);
> -
> -	charger->chg_ps = devm_power_supply_register(&pdev->dev,
> -						     &rk817_chg_desc, &pscfg);
> -
> -	if (IS_ERR(charger->chg_ps))
> +	if (IS_ERR(charger->bat_ps))
>  		return dev_err_probe(dev, -EINVAL,
>  				     "Battery failed to probe\n");
>  
> +	charger->chg_ps = devm_power_supply_register(&pdev->dev,
> +						     &rk817_chg_desc, &pscfg);
>  	if (IS_ERR(charger->chg_ps))
>  		return dev_err_probe(dev, -EINVAL,
>  				     "Charger failed to probe\n");
> -- 
> 2.35.1
> 
