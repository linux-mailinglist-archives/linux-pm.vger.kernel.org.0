Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819147A96BC
	for <lists+linux-pm@lfdr.de>; Thu, 21 Sep 2023 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjIURIz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Sep 2023 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjIURIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 13:08:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2023.outbound.protection.outlook.com [40.92.45.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4858C5FC3
        for <linux-pm@vger.kernel.org>; Thu, 21 Sep 2023 10:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJjHJt+Pib+HIleZiztFXqYrRuIaqFijuX7osk9wdxb9i0VCqeeXlag2cATQDhrLg4ijvHaWukk0jfHqh/bwztPKAnZtEWV2KaKqyvDoGBbEnhEhNey1fgInXeFXJ7Atz1NLBGDyVoEfq4KjGwsxHZEyPXgCHG6JmTMEliJmDiAkl8pxohDpN3lmnmSJYR1jzc3AJ24rm5IcmbzYjtZvBG8QvwQn0zOkgsBj5H75hPMniCFYJTbFk5K8FrxUi+w/5OdvrS0UlbWqgXqQ9Vrz3kRR6ucf/GWvP/rBzJengiZPvqjUaJ4buSx5uzpd/TUwJCJ09Ul7rwMbhHZKe8+ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDT7xJfEQLLkXHzmbcdEMwH9jTZvWut3jSWYydkiLPM=;
 b=FZbkBruhW2tnrC7iYU5bE2ff6v+v8JUrFZjum60ZwerNLvGqRy1DpVWmTGsn3hjPKx6DAJa3aJY3A03a6laW3auOV8w6+fZvdnRzAMAA9nFkV3Zh9vQyumQrNyGNGaN9tVHNPag6KIqLqpyyE4zLs9+YAvud/Bo9N4p2BlsXgMMDQM/RsX/gXyd44EjlqTWNLm0EGAGxQJUlP2TLzrJLM7Ij9mXhqKmzKZIhOGvuZWd/X5JmnwO+qoBJ562w9Q75NMfjNcO9v/BOTRVKsNG4AFiXrLQQ477HGck6NgBDAfacZYyGkKhNcEtKZsPd1LRXInzr0vAPvGyKsr3Ywb8NsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDT7xJfEQLLkXHzmbcdEMwH9jTZvWut3jSWYydkiLPM=;
 b=pXTK7utFCFty6OCx924+YFdURF19kifLAZteyBRyAlSW8dwIg9tw4YWs1kyu5ijNfnm390yPHs/yNaCoANs54HrCeKp985hmPcvpT6TgVW2i9f35DSQGEXghbk+kK57VTm2ImYKYng/8v18H6yMMcaJ23q40ypTA3E7lNvHg6YS6Vqp/NoyeKtTmDdguPOsYOhswxOWbjXzGx2/WDIaveglyRjSKO2zwLaMIDA7j/ToMZcSEia4SrrpWHseOLDkDZwx4ZWeQDtGorEIcZfe3R3NqlQ4ukhEWYhRhNhggLplHARKsVVcBkP2CfdX00StSRz5GVhNme6vXEKr3AIXbzA==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by SN7PR06MB7134.namprd06.prod.outlook.com (2603:10b6:806:10c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 13:18:12 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c%2]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 13:18:12 +0000
Date:   Thu, 21 Sep 2023 08:18:07 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
        linqiheng@huawei.com, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH V2] power: supply: Fix additional refcount leak in
 rk817_charger_probe
Message-ID: <SN6PR06MB53420B9BB86406D91E46D5E2A5F8A@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20230920145644.57964-1-macroalpha82@gmail.com>
 <20230920203106.rbghsn24fsey73ma@mercury.elektranox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920203106.rbghsn24fsey73ma@mercury.elektranox.org>
X-TMN:  [FhsmCGn5+LVGpHgo/0rnNDeRpgDzQO4S]
X-ClientProxiedBy: SA9PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:806:23::31) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZQxCj1ycXrfe94Hq@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|SN7PR06MB7134:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a988cd-5471-4afa-58e9-08dbbaa5347f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mcHxfvLX9NOzh8PhJfNkTGuug3WPBcfXbb0hClMISqwDWuiOEe5A4E3hNfibbIlP0Gq7LdUeN73fEgg42rFCnF33O36KpFx9V2R/1rXv8I3QHVW/sgRkZpWdjcXGoyaiHoRmOAPMKsWDWGZ+YYn3hfwU9EyIWPPqdXGeJGupz5qpwEA8kPhulzByOSXjB5Qog0gxKkGJMTjQyns9BhyWV9xtWM+jqbcJ+4Nqg3E06OPUK4wFRQ+9zbIrw7GS2dQNKiZiCpeaIvqc4w9nVmCgFAvsQDbyl+9Q05/erhJ0QCZKeagqDvh9l1YaTubRtQmnf8OfgFR0oBkJCxOTGlYPIeYvjPXgd3rQYTCTrFrQOOB7mpk+cp5rSY0tiPuur6ZOsiifwsj/1o6O/GdXVFShgMFRPO7bHSAW+Lf48wieT1CG1hLCMosO+9qQYW5pOTGs3+uBY/CwDApri4tPodvdvPIXJ4+AjhHXNQGa2mTICxMyhCbha6EaJWw+Xv9JR7uF9nZLQWNSW6+jG4XM+TYMHmYCqoEwaH3ev9dUykVjDhTVM8VdESbVhs+kkyeC3uw3b87B/fn/cQOSfhm8yYPUvAfgKVFcHaAUgsTs7c0RfG0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uUA0sa3C0pC6viOnnoLLQv3XbyxxpFRaEufNCKFEXZBP2Ng9rVZjvYm3NfET?=
 =?us-ascii?Q?sTfKW9T+jPI1DF6ygXH63xyq0CKbzdrjOaTvW5X7dzYhKjofyaUzemhQ+7oj?=
 =?us-ascii?Q?EiLV2cB4FymwfuKqWN1otg6kWj/HsGmI0gQydW9+HMsSUpddNKQpwgHWUWPi?=
 =?us-ascii?Q?4NNt7AITRPS3DTfDB2uIy1lIY71Pf5kIAf1HWstC5PI3ZsXPL1PmDvO2msb6?=
 =?us-ascii?Q?VEjpg1Jb+XNcPBeQdQgU2QyA+IsODw7K1MTORDOHYudJK8hXXMyGKwRaaAL/?=
 =?us-ascii?Q?mWpJswJJXTmmsLRCkZqv3H7HqO6ujv/51H7zbBeobcyHYpi8mJFQQ1gfT/kc?=
 =?us-ascii?Q?Fht9HR6beaMIa9BL98u4Di0cyntNfcN+5/J/TIhmwUJrroUxwbMtAqH4I022?=
 =?us-ascii?Q?JvYSAG0Zgrh+k1uEhh+8AjKmbWtzu4aRBwhXznST1pIWsOpHGnBTkHy8qKb9?=
 =?us-ascii?Q?tMAOxmVacrRH3JF/0Kqqg9NA5g9tj9Oqg+rPv68ccLf9A3FWJViG5trS+CHy?=
 =?us-ascii?Q?AmWpolJAaMmopQvF790kGl8d9fZPiFxnsm3wse667y6F/f3NsKPKWpOPMFnA?=
 =?us-ascii?Q?gKLKom5x7nqPbUirv/1v7CS33w73pAFavuFevPmlVYy3LF+RlGC3uU31bNoL?=
 =?us-ascii?Q?dzM9SBM2v0UCvU+5ptDWZJA2cKdegwbpHjB4Dh38DULbSbPskfemGzKqUN+4?=
 =?us-ascii?Q?9FGAy6aVk04dNhMYHY5OXlGJDrQN+bHUs/CVzC7nwxqlC8JV7bwXSUbj5+LP?=
 =?us-ascii?Q?fvcaMd+yehPj1fYiyHgd5R/InfIF8OqoQYsO/Nwnz/FGO+TgVJ3eLXSmcaEq?=
 =?us-ascii?Q?2dyIOGlH5e6DW5W2Ac6QifYAimD81XKt6fSqUZEB76SnHWllzwnLcvboeoqk?=
 =?us-ascii?Q?XGzlT6Cq7nWru9D9vn3TDzEyuh+W23UxGIVfLelAfm5lqWrk0k0Y5PmSiosv?=
 =?us-ascii?Q?ORLtlsXWg0JyQwRkDEyZJjcy60kmZwVlIPkf371LAQFfhXK1qmVq/4khjC9m?=
 =?us-ascii?Q?IJt5Edod/s8hOHbOsXiX23dduXiusA6C0CiG3Ni5cD/OkELV171g9pd7VwdT?=
 =?us-ascii?Q?lgQfyFpeHnrSWdHVgepDeS1sobIIJG6498t6scepAYO1J37itfcSGs08Hnnm?=
 =?us-ascii?Q?Uy0oeFw/9y/te4Vq6o2RIJPLT/RO0Ei/eFlj60/MQ7cUbCCZ8j1I3ONmmNLW?=
 =?us-ascii?Q?aJ1ZYU+LK4t1D0xcuH9JcBtTEaUG2ByAzYsFnoFL2aKDj6RUzI4PxP00OKw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a988cd-5471-4afa-58e9-08dbbaa5347f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 13:18:12.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR06MB7134
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Sep 20, 2023 at 10:31:06PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> As you saw I applied this, but I did some modifications:

Thank you. Still learning so I appreciate all the help.

Chris

> 
> On Wed, Sep 20, 2023 at 09:56:44AM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Dan Carpenter reports that the Smatch static checker warning has found
> > that there is another refcount leak in the probe function. While
> > of_node_put() was added in one of the return paths, it should in
> > fact be added for ALL return paths that return an error.
> > 
> > Changes Since V1:
> >  - Use devm_add_action_or_reset() to call of_node_put() instead of
> >    calling it in every single error path from the probe() function.
> 
> ^ this should be below the ---
> 
> > 
> > Fixes: 54c03bfd094f ("power: supply: Fix refcount leak in rk817_charger_probe")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Closes: https://lore.kernel.org/linux-pm/dc0bb0f8-212d-4be7-be69-becd2a3f9a80@kili.mountain/
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > ---
> >  drivers/power/supply/rk817_charger.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> > index 8328bcea1a29..708689d34959 100644
> > --- a/drivers/power/supply/rk817_charger.c
> > +++ b/drivers/power/supply/rk817_charger.c
> > @@ -1045,6 +1045,13 @@ static void rk817_charging_monitor(struct work_struct *work)
> >  	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
> >  }
> >  
> > +static void rk817_cleanup_node(void *data)
> > +{
> > +	struct device_node *node = data;
> > +
> > +	of_node_put(node);
> > +}
> > +
> >  static int rk817_charger_probe(struct platform_device *pdev)
> >  {
> >  	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
> > @@ -1061,12 +1068,16 @@ static int rk817_charger_probe(struct platform_device *pdev)
> >  	if (!node)
> >  		return -ENODEV;
> >  
> > -	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> > -	if (!charger) {
> > +	ret = devm_add_action_or_reset(&pdev->dev, rk817_cleanup_node, node);
> > +	if (ret) {
> >  		of_node_put(node);
> 
> devm_add_action_or_reset() calls the action on failure (that's the
> '_or_reset' part). So this of_node_put() is wrong.
> 
> Thanks,
> 
> -- Sebastian
> 
> > -		return -ENOMEM;
> > +		return ret;
> >  	}
> >  
> > +	charger = devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> > +	if (!charger)
> > +		return -ENOMEM;
> > +
> >  	charger->rk808 = rk808;
> >  
> >  	charger->dev = &pdev->dev;
> > -- 
> > 2.34.1
> > 


