Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D239568E45
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiGFPvC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234472AbiGFPus (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 11:50:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CE8B2AC5C;
        Wed,  6 Jul 2022 08:46:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C8FB106F;
        Wed,  6 Jul 2022 08:46:59 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B6723F792;
        Wed,  6 Jul 2022 08:46:58 -0700 (PDT)
Date:   Wed, 6 Jul 2022 16:46:48 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] powercap: arm_scmi: Fix a NULL vs IS_ERR() bug
Message-ID: <YsWuaJCrf+K0W4BE@e120937-lin>
References: <YsWbsKolf4UFeEYz@kili>
 <YsWb0JLVFbXS+qGj@kili>
 <YsWjxiXeBXImW56A@e120937-lin>
 <20220706153233.GH2338@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706153233.GH2338@kadam>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 06:32:33PM +0300, Dan Carpenter wrote:
> On Wed, Jul 06, 2022 at 04:20:41PM +0100, Cristian Marussi wrote:
> > May I ask which static checker you use ? Sparse/smatch and W=1 did not
> > spot any of these issues (including other in the series) in my workflow ...
> > 
> 
> These are Smatch warnings:
> 
> $ kchecker drivers/powercap/arm_scmi_powercap.c
> 
> Using test/ version of smatch
> 
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND objtool
>   CC [M]  drivers/powercap/arm_scmi_powercap.o
>   CHECK   drivers/powercap/arm_scmi_powercap.c
> drivers/powercap/arm_scmi_powercap.c:429 scmi_powercap_probe() warn: unsigned 'pr->num_zones' is never less than zero.
> drivers/powercap/arm_scmi_powercap.c:494 scmi_powercap_probe() error: uninitialized symbol 'ret'.
> drivers/powercap/arm_scmi_powercap.c:521 scmi_powercap_init() warn: 'scmi_top_pcntrl' is an error pointer or valid
> $
> 
> The problem is that the "is an error pointer or valid" requires the
> cross function DB to work and that takes forever (over night on my
> system).
> 

Thanks.

Turns out even my setup can spot it now (beside the last one), cause my workflow
self checks were targeted at where is usually rooted my work drivers/firmware/arm_scmi/

...so missing out completely on drivers/powercap ... my bad :<

Regards
Cristian
