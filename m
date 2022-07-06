Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81F568BA5
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 16:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiGFOtu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 10:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiGFOtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 10:49:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E27A22BCE
        for <linux-pm@vger.kernel.org>; Wed,  6 Jul 2022 07:49:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18354106F;
        Wed,  6 Jul 2022 07:49:49 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49ADB3F792;
        Wed,  6 Jul 2022 07:49:48 -0700 (PDT)
Date:   Wed, 6 Jul 2022 15:49:46 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] powercap: arm_scmi: Add SCMI powercap based driver
Message-ID: <YsWg/AA4oGL2917h@e120937-lin>
References: <YsWXievahG19PODw@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWXievahG19PODw@kili>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 05:09:13PM +0300, Dan Carpenter wrote:
> Hello Cristian Marussi,
> 

Hi Dan Carpenter,

> The patch 31afdd34f2b9: "powercap: arm_scmi: Add SCMI powercap based
> driver" from Jul 4, 2022, leads to the following Smatch static
> checker warning:
> 
> 	drivers/powercap/arm_scmi_powercap.c:214 scmi_powercap_get_max_power_uw()
> 	warn: cast after binop
> 
> drivers/powercap/arm_scmi_powercap.c
>    203  static int scmi_powercap_get_max_power_uw(struct powercap_zone *pz, int cid,
>    204                                            u64 *max_power_uw)
>    205  {
>    206          struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
>    207  
>    208          if (!spz->info)
>    209                  return -ENODEV;
>    210  
>    211          if (spz->info->powercap_scale_uw)
>    212                  *max_power_uw = (u64)spz->info->max_power_cap;
>    213          else
>    214                  *max_power_uw = (u64)(spz->info->max_power_cap * 1000);
> 
> What's the deal with this cast?  It would make more sense to do the cast
> before the * 1000 so that it doesn't overflow the 32 bits.  Is the cast
> even required though?  The cast on the line before is decorative so
> maybe it's not required.
> 

Yes indeed, I suspect it's a leftover from a previous implementation I
did. There are also other unneeded u64 casts indeed.

In fact this driver was NOT pulled with the last SCMI v3.1 updates/fixes given
the very scarce review it got upstream (as you can see...)

I'll review all of these and integrate your other fixes in my next post
of the SCMI Arm poercap driver.

Thanks,
Cristian
