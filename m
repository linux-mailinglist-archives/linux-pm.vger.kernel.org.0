Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87600583AD1
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 10:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiG1I6T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbiG1I6O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 04:58:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EB5665654
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 01:58:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D584106F;
        Thu, 28 Jul 2022 01:58:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 254E03F73B;
        Thu, 28 Jul 2022 01:58:12 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:58:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PSCI: Print a warning if PSCI doesn't accept PC mode
Message-ID: <20220728085809.sct3swhs7xuls27t@bogus>
References: <20220727182034.983727-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727182034.983727-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 27, 2022 at 09:20:34PM +0300, Dmitry Baryshkov wrote:
> The function psci_pd_try_set_osi_mode() will print an error if enabling
> OSI mode fails. To ease debugging PSCI issues print corresponding
> message if switching to PC mode fails too.
>

Are you seeing that even setting to PC mode failing on msm8996. The platform
must boot in PC mode, so even if it fails we ignore so not sure if the logging
is of much help here IMO.

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/firmware/psci/psci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index cfb448eabdaa..b907768eea01 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -597,7 +597,9 @@ static int __init psci_1_0_init(struct device_node *np)
>  		pr_info("OSI mode supported.\n");
>  
>  		/* Default to PC mode. */
> -		psci_set_osi_mode(false);
> +		err = psci_set_osi_mode(false);
> +		if (err)
> +			pr_info("setting PC mode failed with %d\n", err);

Since we don't care about error value here, does it make sense to add the
log in psci_set_osi_mode() that covers both PC and OSI case whenever it is
called ?

-- 
Regards,
Sudeep
