Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC837BEE12
	for <lists+linux-pm@lfdr.de>; Tue, 10 Oct 2023 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378321AbjJIWH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Oct 2023 18:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377059AbjJIWHz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Oct 2023 18:07:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AC0B99
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 15:07:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2541476
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 15:08:34 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1F563F5A1
        for <linux-pm@vger.kernel.org>; Mon,  9 Oct 2023 15:07:53 -0700 (PDT)
Date:   Mon, 9 Oct 2023 23:07:33 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: reset: vexpress: Use device_get_match_data()
Message-ID: <ZSR5pd_Uzk0s2XZw@e110455-lin.cambridge.arm.com>
References: <20231009172923.2457844-19-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009172923.2457844-19-robh@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rob,

On Mon, Oct 09, 2023 at 12:29:14PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/power/reset/vexpress-poweroff.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
> index 17064d7b19f6..bb22b2db5907 100644
> --- a/drivers/power/reset/vexpress-poweroff.c
> +++ b/drivers/power/reset/vexpress-poweroff.c
> @@ -7,8 +7,8 @@
>  #include <linux/delay.h>
>  #include <linux/notifier.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/reboot.h>
>  #include <linux/stat.h>
>  #include <linux/vexpress.h>
> @@ -108,20 +108,17 @@ static int _vexpress_register_restart_handler(struct device *dev)
>  
>  static int vexpress_reset_probe(struct platform_device *pdev)
>  {
> -	const struct of_device_id *match =
> -			of_match_device(vexpress_reset_of_match, &pdev->dev);
> +	enum vexpress_reset_func func;
>  	struct regmap *regmap;
>  	int ret = 0;
>  
> -	if (!match)
> -		return -EINVAL;
> -
>  	regmap = devm_regmap_init_vexpress_config(&pdev->dev);
>  	if (IS_ERR(regmap))
>  		return PTR_ERR(regmap);
>  	dev_set_drvdata(&pdev->dev, regmap);
>  
> -	switch ((uintptr_t)match->data) {
> +	func = (uintptr_t)device_get_match_data(&pdev->dev);
> +	switch (func) {
>  	case FUNC_SHUTDOWN:
>  		vexpress_power_off_device = &pdev->dev;
>  		pm_power_off = vexpress_power_off;

device_get_match_data() is badly un-documented but I think it can still
return NULL if no match. At the moment we're checking for a match earlier
and avoid calling devm_regmap_init_vexpress_config() needlessly, with your
patch not so. Can you not replace each line with the equivalent code and
keep the NULL check?

Best regards,
Liviu


> -- 
> 2.42.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
