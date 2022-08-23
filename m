Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC78359ECA4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Aug 2022 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbiHWTnW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Aug 2022 15:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiHWTnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2022 15:43:08 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02olkn2079.outbound.protection.outlook.com [40.92.44.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BC26F;
        Tue, 23 Aug 2022 11:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAO4LD+okeZ1GtoLkmghqU6UTKliwOTqYQJd3VClSIxj+uX4wF6Ty7NV5f/yoLzT3x8vPX9noWB++XnyUbz8z4TfGSMrHlaC9kqHQFqt7enFTZv4EZQBzlDR8t7qkWemN1Cdnq+SBPGFhalw60Lg/uNj0FNDA2I683Aym+/0b5qgW8xufMeKk4ANZxZlDisIe+XLk2N33vgxeqta6kSbLBnBl2vgOmC9WJBLEhUuFlaGHID5WNV3cmR6w2yUkpi/Xle4X/6ythOrSSQ9fVSQU4SsXw8ID8YFTM/XLSEijJoEeD0CX+6+lq4ZRKBvxnrxBb3E31fKK6WZyKSmXAC3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4XMeTBAHoz5LjOdOQIqEJI7eMkB95Li4Bw88vlAjTE=;
 b=V35JndU9nMOZCf1ly+zZGd9jhILLI7xPd+NaLS/fLDAyc6MvCkLsOkIpR4rELXNSpy7BjhVBd9GhrUKT+IjWwj+Of1VM+ha/Y3TXZAPab7eyZWWurtLgOrlHX9N7Lv0SMESrXY1n6zgQSdCNrKe6sk7RZugz+uJuVUQ9aP4gBh6/DgWWlGIAR7W97P6vzaL1q1YMcnRamZaAwNl6QnS3gKUs0zbQkaFtMt4fdYtTIxb7/WfUS+4zwEd4kQZWSo085auXkEYqhjyCWFXM5PuPlUSn2s7dywLB7aUNBqf+RNt6s3+NWL0n4GrH9wk6BR1lfKxd6KHDbwuvSQq7d2LiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4XMeTBAHoz5LjOdOQIqEJI7eMkB95Li4Bw88vlAjTE=;
 b=IOUldoxxDLztXbBMedFidS82wjpEf73jBoIqQB3FqDd3e/YdOhGj8Yj8YV8YTEo7vd8P6yzYXxAdjc2JCdcQRh/BssgIKecnatfRmB1jnkd4Q0+5jwZ6QKZ37L0EvFWgiwmjban7/R8odjScapvFRA6veaWrMPf8Y5DNC/b6do4/TjRx6VSyfubyVCoevYXjGNo6m81++E6InkBsLOem9U1tCfn/kedjJsWLKo2AZ3k2CZTYy56bXFurcNlbQJoFgz6nu9e+Jx6NKwiO4ikboHdx8e1S2TbyKV/+HjDZhPbqTrkfheVIEgl4jzp+D00ANlSNc9uiF1sftFsoK05g1w==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by BYAPR06MB5349.namprd06.prod.outlook.com (2603:10b6:a03:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 18:43:40 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::20e7:bc40:7e9d:b46e%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 18:43:40 +0000
Date:   Tue, 23 Aug 2022 13:43:37 -0500
From:   Chris Morgan <macromorgan@hotmail.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Chris Morgan <macroalpha82@gmail.com>, linux-pm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org, Maya Matuszczyk <maccraft123mc@gmail.com>
Subject: Re: [PATCH v8 3/4] power: supply: Add charger driver for Rockchip
 RK817
Message-ID: <SN6PR06MB5342D31AA67E4BBBAC1F934EA5709@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20220808173809.11320-1-macroalpha82@gmail.com>
 <20220808173809.11320-4-macroalpha82@gmail.com>
 <20220823163540.dg2z7fngaqklejvx@mercury.elektranox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823163540.dg2z7fngaqklejvx@mercury.elektranox.org>
X-TMN:  [JQ2eVutySnoXgGeTYuRolKvpsDL21Avu]
X-ClientProxiedBy: SA9PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:806:a7::20) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <20220823184337.GA9384@wintermute.localdomain>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ff96dc-69e5-4f80-f24c-08da8537657d
X-MS-TrafficTypeDiagnostic: BYAPR06MB5349:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wORwy+FalHdtJIMyKqzBEkiBSOoHQFW8KocwOWLTacRHJjtVP8iRSSmpFpazEp5VMJwMc8Nxqsg4xc7ucVS/TGE1gfFBaO/U04/nCe+Mei92GumM6ONFsUt3J/l7MhH9A8Nb58fmzlc1BFCqfRUkdIb7VwCLxeMeVRUGQvkLpXZwkYfEQzQqFSFaEGI2CLGGA1CdCCyLc6EPQJSSWg/dEdEm9X0JvaQPZiXRNfazZrT649+b7X/yx3mMR8SayUuW60BVi1go8E+Ytjkzin35je3msq2a8fhh5xxWiKWmys1x9gypFJE/S1MnIqKspaZeznf+w3jnxJfTFSgvI8Atf0Wztg3rFqT1Bft0adBKLokSqi9c8et3pDzV9lcKf6LZSCc2lNYb9vCnq0X0q34OmcNDHq0CAZd9d8JyZHq4KXEPDRWOCpa23QAQz4aO7WJtS1yCl2SbSH2kAQ0KAwrZrooqiTCbDS/wR9BHg2w87htnmJ57MhtBD9VCd/CE+pOKp57SBDOWy6RsnT6NaL1WwYshSlYhlidXClhvJaKSuikcvOY65oxephjzz22xZu8hyI5t5GUr1TrTuz9gM4xGGFEsxyj4J9Bz7o7viZ75xA/2m8/LCWhlsy2gaL+AMEiRXNwUNGzb/ox3CYwxYtPYFUxNboxEmAGJhJRnnSieBCskDwi7UZhTp+Hyl0TQHMhG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSaTCkaOXZO/Ar1QzOUF1TO+HRLEZgC1NidBbcra6Kbd5ww+wL5noaETtDKM?=
 =?us-ascii?Q?RGZeePrmtU3Iu3QOx3yZTQ9qNWlBm17ZQiUtHX+KvxmtwYOV58X/6ldC9bY2?=
 =?us-ascii?Q?UtGvF9NCkyO7CXs3akSu2itZgj566HdlTTkpX/95Dvgewt+AW+0bTV0rvxSe?=
 =?us-ascii?Q?DqEONFSH4ZQiZqruLdsgzWRaJz7Sqqxvv214nnqrvzZIAPAS/Y792N1IVc2e?=
 =?us-ascii?Q?06Od5FDIKXHaM9YVRDvUSj4enLCKQSGXpClBc6oxhnURUEIGkFygCxi8godK?=
 =?us-ascii?Q?6jd+i8HqmmpCv3Ro8psGoWyfiBNEMSLtnRjh2U+5yRmrLRgu019tA7XPNSdE?=
 =?us-ascii?Q?N8Zzu9x4vSpq9YYqOBrssSJRRzDNu4HI/DsgShlZ3djICR6GLW34k5LQSUL6?=
 =?us-ascii?Q?qHqKHlM4uRJaC/2M9GVarbo4ir6dgmcs5cRiSeGuESJYtFTVIxLeyQiRJ7gV?=
 =?us-ascii?Q?4tysy+Gx7lR4GDHBHulK1H1iRWD+C6GMyXJi933A3sHh7h5g8eGHt8S635lX?=
 =?us-ascii?Q?F2KweF5DfFbZDPMhRl+VJehP15xLh2szR+aX9yanhc3LarQ2PpU1pw4anUnT?=
 =?us-ascii?Q?lW+zqi10gvoqbmEYp8n9h/dJ/2ilZgVZ5grVzGZ4WFZD11XiDxlomhLz/VIV?=
 =?us-ascii?Q?EffxCM/6/34Q4fP8294i+tuPHqUhsFvzfVWkoFhVA+g+CVTmvEDRVHuXLcDJ?=
 =?us-ascii?Q?WJpXfKHkSfSuC9SfMHsaMy9ZZPhWIvC4277ODWvJ17Lz96C+UlGMRqbg/x//?=
 =?us-ascii?Q?DVu0X13Ff3Nn5WDy7NYjfBv8B55z/ANkGvVx3P9JnMaHI20tSh+WaL4tN/0g?=
 =?us-ascii?Q?7vaPpvsh/VWmoLgqs748CZIiuddh4pOd63Mttg+EMG3j1OZGFQNHWv4LiR1H?=
 =?us-ascii?Q?t/rdp7jvea4PCJiVAFVLyPSDPUu0aKjIYQmhAePtz6jRalxIloaVgs9sC1fx?=
 =?us-ascii?Q?e+7zFSHFbLibncYRE3R6HOVNBrc33OANnG7BpbVK4ws+CD1S4U0H+qg66MZt?=
 =?us-ascii?Q?ZRP4Y63IzYKO3LtWba30UilZtDPiT+/D6vWD4V4SZKBTjLFRxvZUX5P1kM1M?=
 =?us-ascii?Q?ygZolU7Y7g1fxPXzFPFYYakRd+J6prnIRs/uBnAWOqo5nWBKYjfjiQbNSsBG?=
 =?us-ascii?Q?P6PHig8uoaUVy8Zh+qwWdPuU01hbdabJDLEkXdx7GMnQ7OHWdQytUbGL0SiA?=
 =?us-ascii?Q?ep9VyPNdVIZOG/34VViGHrt+CdYs34kDo2C6vyuroQ28D/y+QFTflZqjNqcg?=
 =?us-ascii?Q?HqdrlAtt2+YoiZbYK/WnQHI7KxEpkyaQHNgRr0kgDw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ff96dc-69e5-4f80-f24c-08da8537657d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:43:40.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5349
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 23, 2022 at 06:35:40PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Aug 08, 2022 at 12:38:08PM -0500, Chris Morgan wrote:
> > From: Chris Morgan <macromorgan@hotmail.com>
> > 
> > Add support for the Rockchip rk817 battery charger integrated into the
> > rk817 PMIC.
> > 
> > Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> > ---
> 
> Looks mostly good. Just three things:
> 
> > [...]
> > --- /dev/null
> > +++ b/drivers/power/supply/rk817_charger.c
> > @@ -0,0 +1,1151 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Charger Driver for Rockchip rk817
> > + *
> > + * Copyright (c) 2021
> 
> The Copyright line is incomplete.

Thank you, I'll update it to say 
Copyright (c) 2021 Maya Matuszczyk <maccraft123mc@gmail.com> since
while it's heavily modified it's based on her original work.

> 
> > + *
> > + * Authors: Maya Matuszczyk <maccraft123mc@gmail.com>
> > + *	    Chris Morgan <macromorgan@hotmail.com>
> > + */
> > +
> > +#include <linux/mfd/rk808.h>
> > +#include <linux/irq.h>
> > +#include <linux/of_gpio.h>
> > [...]
> 
> Why are you including of_gpio.h? You are not using any.

Thanks, sorry. I'll change it to just linux/of.h since I am using a few
things from that. Might have been from a previous version where I had
used GPIOs instead of PMIC registers to detect charger status.

> 
> > +	INIT_DELAYED_WORK(&charger->work, rk817_charging_monitor);
> > +	/* Get and populate the first set of values. */
> > +	schedule_delayed_work(&charger->work, 0);
> > [...]
> 
> what happens with the delayed work when you remove the driver?
> Check for devm_delayed_work_autocancel().

I'll test using that and submit again once I've confirmed it works.
Thank you for all your feedback.

> 
> 
> -- Sebastian


