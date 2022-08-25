Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533F35A15E7
	for <lists+linux-pm@lfdr.de>; Thu, 25 Aug 2022 17:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbiHYPiI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Aug 2022 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiHYPiH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2022 11:38:07 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2072.outbound.protection.outlook.com [40.92.18.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A085B7EC4;
        Thu, 25 Aug 2022 08:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNIYHlmQKkmOhiQ3UMC1lSruGQGZ6LHvXiMOdOng3OhxnHxUwGzvBLJ4xpT3OzJdBlC61g8zFkUwlpp3zWL8lXIkvurGBhyhG8Ziq0+8VFDIzkCnpM+4PTmkYh69slrXH7EiY+4ww18FZ0g+kY0jYjzJ14NVQQSPU7mzRg7K+3QNfMoCZxr+c3IQtYxC9ej91RLHR86fyU9urCcsGHPWTGR0SYDEQu+ODcW1od7VesODrbOTE0tZCPr6zAcik1moKi0Z+plSvMGPRpFq5NBaVnMXnV7+MBakGgRClQ/Z4uvk8Uyrn7Syv9+nsAygcvw30gZXqqW02tL3hzpYZaGsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqE4kQGGR1YeRU1I1vYPjRd/dyVVuSi/6AB9Uon3sdc=;
 b=lTAJ0bZAQT5/G4AcGSK5tJBZMO/u4XfW6Q7xGOujudR3OznZ6MpnMuhW5XATpPvjTYNEYXwHm7D4E+3Z4jpN2D5TqKvgU+Z8ZMRTF/2nMa+3Fqo5aOzav5kXnaOq6AGYcy89pJgzwQsNeiCjqPet1lQKzd6lwSp5op8Yi5x5J4LLiUQjSmEcAcNboWhE5BLHGnojNvEMmPyk/vjgVRT35J1yBjhDOlaFcGfdhGWe9gXJGZH/IBFCwueoEy+KiHH2/zdZE8sU5I0Dv1cnxcNlOGMGqeq9s4nq6ysC9u0bgcKxuc789ddBOwfUIuaXqVAaObh98pd4CU1wspKi/WdBQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqE4kQGGR1YeRU1I1vYPjRd/dyVVuSi/6AB9Uon3sdc=;
 b=psNbsKO6JWfQxPKnOqzkar7E34kuoSuuNXL/2yZSHLm1Bd4x969+lT+gZSnRZeBoylWYjGkcfQy53AGSSL0/MZCHfVcdnaz25z33PmdOipjHTxyyA/sdSTs8cQIpxVlG6pnpSlyBp1X9WdgEcKpJj8xgA4P7FsVrHkftU7EFmVBD6ewPCN3XvQ3aChsdyzGDleWTrAAg3pDDEHwAJrcZt2u/Aw1VLvShuNLVnPnEzoX7/FOTXSeyoJVO7yVgqWHjpzTJf8AX/aZ3CvEu3aWfH7JROxy8RPPpqbC/NR/BYRNhtw2ulC9txkirPH2MNFVcEPasJrydskdukWztIjIfrw==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BYAPR06MB5701.namprd06.prod.outlook.com (2603:10b6:a03:159::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 15:38:04 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e%4]) with mapi id 15.20.5546.025; Thu, 25 Aug 2022
 15:38:04 +0000
Date:   Thu, 25 Aug 2022 10:37:59 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, zhangqing@rock-chips.com,
        zyw@rock-chips.com, jon.lin@rock-chips.com,
        maccraft123mc@gmail.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org
Subject: Re: [PATCH V9 3/4] power: supply: Add charger driver for Rockchip
 RK817
Message-ID: <SN6PR06MB5342ACD1362403FC9FE38627A5729@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220823193015.10229-1-macroalpha82@gmail.com>
 <20220823193015.10229-4-macroalpha82@gmail.com>
 <66b99ce4-752a-17e7-3213-26a898abd4a8@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66b99ce4-752a-17e7-3213-26a898abd4a8@gmail.com>
X-TMN:  [9V5LdPFTU3C7mVYtMKe5rcA/3hUQZE9a]
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220825153759.GA25925@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad132d17-0b95-4fc6-e0c0-08da86afcc77
X-MS-TrafficTypeDiagnostic: BYAPR06MB5701:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x9EWNvRgDojYVjSc1Q2K1egNu/ZywPhb6DgCkEvrxnkafN0hOHfE1kSX+bYGPf+eKrWHDYzZPXXj+OkiM7jw6o6IiOnc6g0w8tZVHyZRMribX5tRmKoNSHTG+3gTnFualnAn72JXyzQV6CKcV2kWOWlrirHes4YwfkywSZRiY0cvhmWvGd0GGYJFPz366i2xIKmN8w0867bHepOhJsHK7DRPg3ipML6YlBa3TPl06NHUDDtKSIwCRBXpvT9nH5MKOBS1ZOcRV9JpNjvLm+QuSluwR4hSZTuaO8CeEevRJOjI+annIbQDVRcpf5b0wwNy01kaT/LYpz/ULcbyvkKtsFSYhURY1NRWdI/PX7LX4ylBoYZjo9TrSSHEkz4ilquw0MnGAnyGXoxYYeIsRqywqt85sw2KisRnDl9ggrObVy3/6QorfUqMClXjjvgrp//zobkkNv7Lor/d0XRlRn9VUPA1tXsUSYEJBFR2y6noCvsTXUuQK89U0cGtDRhJBIQzCMUbKnP8qFm5kAu9R8WT7HweQtFdx5YEAZP8P1NMqpKOX7V5hfFnMhMZwTm2ha3tqKbepdykYGx6MecReROF1ytvudfXjtqlgbVm3NGb8QBeWx5fbXpRkanur35TU9fA+skzoGhs+xbWHmkj7XMsjrQwb2R9rTM4hQZqssf2pcm3D+PYUrpoNeodePZiQ6fG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eriTZH3lsuXFMyLoqiol1ACOuQ/4Sr0w1TCBlaEzSxva1Mk2Es53OtWF6Y7a?=
 =?us-ascii?Q?bulb7xYXFZBp4acbASnzpE/jZLrDjbjxTeyTp0VpyH4zeuPvm4htVHsxLLpq?=
 =?us-ascii?Q?oJVkTA4J925olMOGBuiqukVOBnqtJrMUFZu0PxnLCrJcRKs1Di8AWzQqF+Rg?=
 =?us-ascii?Q?0crGc2xRsylQv2hHE/KCYCCsNEFf5N2/82/x9a2+iUPK5/diCX+YpkwcHTVT?=
 =?us-ascii?Q?FALvsRhOKiHyGfrO5/eMO2/rQSVqAg5F6d0NNAYyGgyn110ZfoCzygVWUyYG?=
 =?us-ascii?Q?4wEY501KxuYmpum2hGr/imtBE49eoWusLVwmDMnJjX0HeMDUxQCCQQm5jX0H?=
 =?us-ascii?Q?sOXkb56ZAy8nbuLEZgRprSC24mKaoImRUT2tBby/x6iooZvNbSWtt05WFIP8?=
 =?us-ascii?Q?JIwXMHns0z+1jHXeJzx3Y2mQH2lBf86qKQhsziBtrp2ixalykJKCcEAqHyb9?=
 =?us-ascii?Q?FXbwUtod5qPbt6BDZxX6CpuAREDkB4ljPHLJEst5Y1CMHPO105VUBGX1/WUn?=
 =?us-ascii?Q?VMsaWK64FTd+Fu3HDhhaQUrLnp+yWmIBlDqpVTTLvpZsuFxH8bRx8e1u1Ftf?=
 =?us-ascii?Q?YyaxH/dYFX713s0IvBLM7GDId2TuXu0o423t53JPOBejMwtxjSHDKKj6/vs4?=
 =?us-ascii?Q?c+kJX6QcaXxasXfwBWYPjiJ0Gv1leihCqRgyqg/ntz4+tT1mOlZTDNRqRcwJ?=
 =?us-ascii?Q?RlzWc0AfgWQ/jxZuy1TjT5scTb+FUH8t8Z4zggek1m8F7z5UKjZ3dUZ2lGae?=
 =?us-ascii?Q?CICShEKtNskDeyaokjq0rARhDXBzDSneOxVmPZDyQiIeHWgtODFGS8pqxf4N?=
 =?us-ascii?Q?RHEdfx7/VZHa23BV2B7kTaP78/ATXOIMixHXRnHaV5JJ4kf0C9yWAAhvLcvY?=
 =?us-ascii?Q?05IhnbKKRMuAxdepMIN4K36uoidKI8IyVCfJJYIincJyRO/Fv3R9DajsFHxI?=
 =?us-ascii?Q?YgjXLncPO+/YVet4NqxcrzXNwinGxdrhljbC5vS0Hb+yxbHs1eJKTafJ/vt2?=
 =?us-ascii?Q?5chhdwAvS2RaOaokZRU3BSIYYzcCw9xtg//unmYw8QWq0UPQ6atDGUYrqikx?=
 =?us-ascii?Q?JnzO+/IHmLqZQqg58zYm+CQaQzHzFAsDZ7fV0mXJ+O32FByAWAxXQ4kFMBgK?=
 =?us-ascii?Q?H7poXABdYXjYj954Fqx9SKOFq+QTEco8N3sIFVW+HjZzkHZZuzvoRZz232XA?=
 =?us-ascii?Q?GJvcwJBCmBbVMH1d+P/K4SbcGvUmep9XjJbT/+tTyQMg2lKKdC+y/hnCyN+i?=
 =?us-ascii?Q?WVrmnC9SxlWP//hUFW35wO6ZRLg5haT01rbNz2MJmg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ad132d17-0b95-4fc6-e0c0-08da86afcc77
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 15:38:04.0871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5701
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 25, 2022 at 03:54:06PM +0300, Matti Vaittinen wrote:
> On 8/23/22 22:30, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the Rockchip rk817 battery charger integrated into the
> > rk817 PMIC.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > ---
> >   drivers/power/supply/Kconfig         |    6 +
> >   drivers/power/supply/Makefile        |    1 +
> >   drivers/power/supply/rk817_charger.c | 1157 ++++++++++++++++++++++++++
> >   3 files changed, 1164 insertions(+)
> >   create mode 100644 drivers/power/supply/rk817_charger.c
> > 
> > +
> > +static void rk817_charging_monitor(struct work_struct *work)
> > +{
> > +	struct rk817_charger *charger;
> > +
> > +	charger = container_of(work, struct rk817_charger, work.work);
> > +
> > +	rk817_read_props(charger);
> > +
> > +	/* Run every 8 seconds like the BSP driver did. */
> > +	queue_delayed_work(system_wq, &charger->work, msecs_to_jiffies(8000));
> > +}
> 
> I really think we would benefit from some more framework code which could
> handle the periodic polling tasks and the coulomb counter drift corrections
> when battery is full/relaxed. I think I might revive the simple-gauge patch
> series...

Possibly, does such exist or is that a future endeavor? I'm only really
doing the polling because that's how the BSP driver was set up (and I
think it makes sense to not repeatedly check for teeny-tiny changes all
the time). If there's an existing framework let me know, otherwise I'll
keep my eye out in the future and revise this if I can when it's live.

> 
> > +
> > +static int rk817_charger_probe(struct platform_device *pdev)
> > +{
> > +
> > +	charger->sleep_filter_current_ua = of_value;
> > +
> > +	charger->bat_ps = devm_power_supply_register(&pdev->dev,
> > +						     &rk817_bat_desc, &pscfg);
> > +
> > +	charger->chg_ps = devm_power_supply_register(&pdev->dev,
> > +						     &rk817_chg_desc, &pscfg);
> 
> Hmm. I think I should respin the patch which added interface for getting the
> battery info w/o psy-device. Now we need to take into account the situation
> where the psy-core accesses the driver after the registration - and prior
> filling the battery details from the battery node (below) :/

I used the AXP209 battery driver to help me fill in some of the gaps in
my understanding, that driver gets the battery details after
registration (ditto for the ingenic battery driver, which I also looked
at.

> 
> > +
> > +	if (IS_ERR(charger->chg_ps))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Battery failed to probe\n");
> > +
> > +	if (IS_ERR(charger->chg_ps))
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Charger failed to probe\n");
> > +
> > +	ret = power_supply_get_battery_info(charger->bat_ps,
> > +					    &bat_info);
> > +	if (ret) {
> > +		return dev_err_probe(dev, ret,
> > +				     "Unable to get battery info: %d\n", ret);
> > +	} > +
> > +	if ((!bat_info->charge_full_design_uah) ||
> > +	    (!bat_info->voltage_min_design_uv) ||
> > +	    (!bat_info->voltage_max_design_uv) ||
> > +	    (!bat_info->constant_charge_voltage_max_uv) ||
> > +	    (!bat_info->constant_charge_current_max_ua) ||
> > +	    (!bat_info->charge_term_current_ua)) {
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "Required battery info missing.\n");
> > +	}
> 
> Just a question - should the values be compared to -EINVAL (I think the
> power_supply_get_battery_info() did internally initialize many of the fields
> to -EINVAL and not to 0?). Maybe I am wrong...

No, you're not wrong. The power_supply_get_battery_info does set the
values to -EINVAL, but it also then sets them based on the devicetree
without checking the return values. I'm not entirely clear if in the
event of an error it could set it to another value though or null,
so do you think performing a check to see if the value is less than or
equal to 0 would be sufficient?

> 
> > +
> > +	charger->bat_charge_full_design_uah = bat_info->charge_full_design_uah;
> > +	charger->bat_voltage_min_design_uv = bat_info->voltage_min_design_uv;
> > +	charger->bat_voltage_max_design_uv = bat_info->voltage_max_design_uv;
> > +
> 
> Generally, I did _really_ like the proper commenting/documenting of the
> driver. In my eyes this looked like one nice piece of a driver.

It's confusing as hell (my first battery driver, so the comments
hopefully help everyone else as much as they helped me). There was
also a bunch of weird errata like resetting the max charge current
when the plug-in IRQ fires that I felt needed to be documented.

Thanks for looking at this, I value your input and will make the
changes once you let me know about the -EINVAL check.

> 
> When the error checking of values returned by the
> power_supply_get_battery_info() is checked - FWIW:
> Reviewed-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> 
> Yours
>   -- Matti
> 
> -- 
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
> 
> ~~ When things go utterly wrong vim users can always type :help! ~~
