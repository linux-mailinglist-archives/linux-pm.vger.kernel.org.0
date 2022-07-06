Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30B9568BB6
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jul 2022 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiGFOwM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jul 2022 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiGFOwL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2022 10:52:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1762725C7A;
        Wed,  6 Jul 2022 07:52:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37323106F;
        Wed,  6 Jul 2022 07:52:11 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 173163F792;
        Wed,  6 Jul 2022 07:52:09 -0700 (PDT)
Date:   Wed, 6 Jul 2022 15:52:07 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] powercap: arm_scmi: Fix signedness bug in probe
Message-ID: <YsWhihOiZ6MZj6Mr@e120937-lin>
References: <YsWbsKolf4UFeEYz@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsWbsKolf4UFeEYz@kili>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 06, 2022 at 05:26:56PM +0300, Dan Carpenter wrote:
> The "pr->num_zones" variable is an unsigned int so it can't be less than
> zero.
> 
> Fixes: 31afdd34f2b9 ("powercap: arm_scmi: Add SCMI powercap based driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi,

Thanks for having a look.

This driver has NOT been pulled in this cycle due to a lack of
reviews/feedbacks so I'll integrate your fixes in the next version.

Thanks,
Cristian

> ---
>  drivers/powercap/arm_scmi_powercap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index 2273768d70ce..ab96cf9a8604 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -425,11 +425,12 @@ static int scmi_powercap_probe(struct scmi_device *sdev)
>  	if (!pr)
>  		return -ENOMEM;
>  
> -	pr->num_zones = powercap_ops->num_domains_get(ph);
> -	if (pr->num_zones < 0) {
> +	ret = powercap_ops->num_domains_get(ph);
> +	if (ret < 0) {
>  		dev_err(dev, "number of powercap domains not found\n");
> -		return pr->num_zones;
> +		return ret;
>  	}
> +	pr->num_zones = ret;
>  
>  	pr->spzones = devm_kcalloc(dev, pr->num_zones,
>  				   sizeof(*pr->spzones), GFP_KERNEL);
> -- 
> 2.35.1
> 
