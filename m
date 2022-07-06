Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F9568C85
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiGFPUv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiGFPUu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 11:20:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 393C3DFE9;
        Wed,  6 Jul 2022 08:20:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26587106F;
        Wed,  6 Jul 2022 08:20:49 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0555A3F792;
        Wed,  6 Jul 2022 08:20:47 -0700 (PDT)
Date:   Wed, 6 Jul 2022 16:20:41 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] powercap: arm_scmi: Fix a NULL vs IS_ERR() bug
Message-ID: <YsWjxiXeBXImW56A@e120937-lin>
References: <YsWbsKolf4UFeEYz@kili>
 <YsWb0JLVFbXS+qGj@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWb0JLVFbXS+qGj@kili>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 05:27:28PM +0300, Dan Carpenter wrote:
> The powercap_register_control_type() return error pointers.  It never
> returns NULL.
> 
> Fixes: 31afdd34f2b9 ("powercap: arm_scmi: Add SCMI powercap based driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This functions should really clean up after itself if scmi_register()
> fails.  I need to fix the static checker for that and then I'll come
> back and fix it if no one else does.
> 

Hi,

thanks for the fix and the suggestion to clean up better (this part was
indeed reworked in V4 and I think it's where I introduced the missing cleanup
when scmi_register fails...)

As said, the SCMI Powercap driver was NOT pulled for this cycle
due to insufficent reviews so I'll pick your fixes and suggestions
for the next version.

May I ask which static checker you use ? Sparse/smatch and W=1 did not
spot any of these issues (including other in the series) in my workflow ...

Thanks,
Cristian

>  drivers/powercap/arm_scmi_powercap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index ab96cf9a8604..2d505ec7ff81 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -519,8 +519,8 @@ static struct scmi_driver scmi_powercap_driver = {
>  static int __init scmi_powercap_init(void)
>  {
>  	scmi_top_pcntrl = powercap_register_control_type(NULL, "arm-scmi", NULL);
> -	if (!scmi_top_pcntrl)
> -		return -ENODEV;
> +	if (IS_ERR(scmi_top_pcntrl))
> +		return PTR_ERR(scmi_top_pcntrl);
>  
>  	return scmi_register(&scmi_powercap_driver);
>  }
> -- 
> 2.35.1
> 
