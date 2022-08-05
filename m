Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C95358AC49
	for <lists+linux-pm@lfdr.de>; Fri,  5 Aug 2022 16:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiHEOTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Aug 2022 10:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEOTc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2022 10:19:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A0494199B;
        Fri,  5 Aug 2022 07:19:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F1FD106F;
        Fri,  5 Aug 2022 07:19:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.42.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 634633F73B;
        Fri,  5 Aug 2022 07:19:29 -0700 (PDT)
Date:   Fri, 5 Aug 2022 15:19:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: Print a warning if PSCI doesn't accept
 PC mode
Message-ID: <Yu0m6yzLr5fhEMtu@FVFF77S0Q05N>
References: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804130750.3706897-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 04, 2022 at 04:07:50PM +0300, Dmitry Baryshkov wrote:
> The function psci_pd_try_set_osi_mode() will print an error if enabling
> OSI mode fails. To ease debugging PSCI issues print corresponding
> message if switching to PC mode fails too.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> This is a replacement for [1], now moving the warning from
> psci_set_osi_mode() callers to the function iself.
> 
> https://lore.kernel.org/all/20220727182034.983727-1-dmitry.baryshkov@linaro.org/
> 
> ---
>  drivers/cpuidle/cpuidle-psci-domain.c | 4 +---
>  drivers/firmware/psci/psci.c          | 2 ++
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
> index 3db4fca1172b..821984947ed9 100644
> --- a/drivers/cpuidle/cpuidle-psci-domain.c
> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
> @@ -124,10 +124,8 @@ static bool psci_pd_try_set_osi_mode(void)
>  		return false;
>  
>  	ret = psci_set_osi_mode(true);
> -	if (ret) {
> -		pr_warn("failed to enable OSI mode: %d\n", ret);
> +	if (ret)
>  		return false;
> -	}
>  
>  	return true;
>  }
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index cfb448eabdaa..1628f1edef4a 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -163,6 +163,8 @@ int psci_set_osi_mode(bool enable)
>  			PSCI_1_0_SUSPEND_MODE_PC;
>  
>  	err = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE, suspend_mode, 0, 0);
> +	if (err < 0)
> +		pr_warn("failed to set %s mode: %d\n", enable ? "OSI" : "PC", err);
>  	return psci_to_linux_errno(err);
>  }
>  
> -- 
> 2.35.1
> 
