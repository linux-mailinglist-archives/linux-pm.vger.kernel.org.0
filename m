Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC24538B1
	for <lists+linux-pm@lfdr.de>; Tue, 16 Nov 2021 18:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238979AbhKPRpU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Nov 2021 12:45:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:6771 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238906AbhKPRpT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Nov 2021 12:45:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="319970946"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="319970946"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:27:51 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="567329979"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:27:49 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3CF6C206F9;
        Tue, 16 Nov 2021 19:27:46 +0200 (EET)
Date:   Tue, 16 Nov 2021 19:27:46 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@puri.sm,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] media: i2c: dw9714: use pm_runtime_force_suspend/resume
 for system suspend
Message-ID: <YZPqEu4W+JnY6LMY@paasikivi.fi.intel.com>
References: <20211109125505.2682553-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109125505.2682553-1-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

On Tue, Nov 09, 2021 at 01:55:05PM +0100, Martin Kepplinger wrote:
> Using the same suspend function for runtime and system suspend doesn't
> work in this case (when controlling regulators and clocks). suspend() and
> resume() are clearly meant to stay balanced.
> 
> Use the pm_runtime_force_* helpers for system suspend and fix error like the
> following when transitioning to system suspend:
> 
> [  559.685921] dw9714 3-000c: I2C write fail
> [  559.685941] dw9714 3-000c: dw9714_vcm_suspend I2C failure: -5
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/media/i2c/dw9714.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
> index fcbebb3558b5..f6ddd7c4a1ff 100644
> --- a/drivers/media/i2c/dw9714.c
> +++ b/drivers/media/i2c/dw9714.c
> @@ -267,7 +267,8 @@ static const struct of_device_id dw9714_of_table[] = {
>  MODULE_DEVICE_TABLE(of, dw9714_of_table);
>  
>  static const struct dev_pm_ops dw9714_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(dw9714_vcm_suspend, dw9714_vcm_resume)
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(dw9714_vcm_suspend, dw9714_vcm_resume, NULL)
>  };

The purpose of the vcm suspend / resume callbacks is to gently move the
lens to the resting position without hitting the stopper.

The problem currently appears to be that during system suspend, the VCM may
well be powered off and the driver isn't checking for that. How about
adding that check?

-- 
Sakari Ailus
