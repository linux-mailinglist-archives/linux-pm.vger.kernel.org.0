Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F9F58D7D
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 00:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0WBQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 18:01:16 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62811 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfF0WBQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 18:01:16 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 80e9519a97d893f2; Fri, 28 Jun 2019 00:01:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: avs: smartreflex: no need to check return value of debugfs_create functions
Date:   Fri, 28 Jun 2019 00:01:13 +0200
Message-ID: <2352758.dtEcboNBH7@kreacher>
In-Reply-To: <20190611180547.GA13520@kroah.com>
References: <20190611180547.GA13520@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, June 11, 2019 8:05:47 PM CEST Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> And even when not checking the return value, no need to cast away the
> call to (void), as these functions were never a "must check" type of a
> function, so remove that odd cast.
> 
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/power/avs/smartreflex.c | 41 +++++++++------------------------
>  1 file changed, 11 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index c96c01e09740..4684e7df833a 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -899,38 +899,19 @@ static int omap_sr_probe(struct platform_device *pdev)
>  	}
>  
>  	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
> -	if (!sr_dbg_dir) {
> +	if (!sr_dbg_dir)
>  		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
> -		if (IS_ERR_OR_NULL(sr_dbg_dir)) {
> -			ret = PTR_ERR(sr_dbg_dir);
> -			pr_err("%s:sr debugfs dir creation failed(%d)\n",
> -			       __func__, ret);
> -			goto err_list_del;
> -		}
> -	}
>  
>  	sr_info->dbg_dir = debugfs_create_dir(sr_info->name, sr_dbg_dir);
> -	if (IS_ERR_OR_NULL(sr_info->dbg_dir)) {
> -		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
> -			__func__);
> -		ret = PTR_ERR(sr_info->dbg_dir);
> -		goto err_debugfs;
> -	}
>  
> -	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
> -			sr_info->dbg_dir, (void *)sr_info, &pm_sr_fops);
> -	(void) debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
> -			&sr_info->err_weight);
> -	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
> -			&sr_info->err_maxlimit);
> +	debugfs_create_file("autocomp", S_IRUGO | S_IWUSR, sr_info->dbg_dir,
> +			    (void *)sr_info, &pm_sr_fops);
> +	debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
> +			   &sr_info->err_weight);
> +	debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
> +			   &sr_info->err_maxlimit);
>  
>  	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
> -	if (IS_ERR_OR_NULL(nvalue_dir)) {
> -		dev_err(&pdev->dev, "%s: Unable to create debugfs directory for n-values\n",
> -			__func__);
> -		ret = PTR_ERR(nvalue_dir);
> -		goto err_debugfs;
> -	}
>  
>  	if (sr_info->nvalue_count == 0 || !sr_info->nvalue_table) {
>  		dev_warn(&pdev->dev, "%s: %s: No Voltage table for the corresponding vdd. Cannot create debugfs entries for n-values\n",
> @@ -945,12 +926,12 @@ static int omap_sr_probe(struct platform_device *pdev)
>  
>  		snprintf(name, sizeof(name), "volt_%lu",
>  				sr_info->nvalue_table[i].volt_nominal);
> -		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
> -				&(sr_info->nvalue_table[i].nvalue));
> +		debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
> +				   &(sr_info->nvalue_table[i].nvalue));
>  		snprintf(name, sizeof(name), "errminlimit_%lu",
>  			 sr_info->nvalue_table[i].volt_nominal);
> -		(void) debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
> -				&(sr_info->nvalue_table[i].errminlimit));
> +		debugfs_create_x32(name, S_IRUGO | S_IWUSR, nvalue_dir,
> +				   &(sr_info->nvalue_table[i].errminlimit));
>  
>  	}
>  
> 

Applied, thanks!




