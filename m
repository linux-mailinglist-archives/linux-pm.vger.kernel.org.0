Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D6D4B52A
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2019 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfFSJoP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jun 2019 05:44:15 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60887 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFSJoO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jun 2019 05:44:14 -0400
Received: from 79.184.254.20.ipv4.supernova.orange.pl (79.184.254.20) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 83e5fff914495b75; Wed, 19 Jun 2019 11:44:12 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] drivers: base: power: remove wakeup_sources_stats_dentry variable
Date:   Wed, 19 Jun 2019 11:44:11 +0200
Message-ID: <2312584.5JG36tZHQ9@kreacher>
In-Reply-To: <20190618153416.6786-1-gregkh@linuxfoundation.org>
References: <20190618153416.6786-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, June 18, 2019 5:34:16 PM CEST Greg Kroah-Hartman wrote:
> wakeup_sources_stats_dentry is assigned when the debugfs file is
> created, but then never used ever again.  So no need for it at all, just
> remove it and call debugfs_create_file() on its own.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/power/wakeup.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5b2b6a05a4f3..ee31d4f8d856 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -968,8 +968,6 @@ void pm_wakep_autosleep_enabled(bool set)
>  }
>  #endif /* CONFIG_PM_AUTOSLEEP */
>  
> -static struct dentry *wakeup_sources_stats_dentry;
> -
>  /**
>   * print_wakeup_source_stats - Print wakeup source statistics information.
>   * @m: seq_file to print the statistics into.
> @@ -1099,8 +1097,8 @@ static const struct file_operations wakeup_sources_stats_fops = {
>  
>  static int __init wakeup_sources_debugfs_init(void)
>  {
> -	wakeup_sources_stats_dentry = debugfs_create_file("wakeup_sources",
> -			S_IRUGO, NULL, NULL, &wakeup_sources_stats_fops);
> +	debugfs_create_file("wakeup_sources", S_IRUGO, NULL, NULL,
> +			    &wakeup_sources_stats_fops);
>  	return 0;
>  }
>  
> 

Queued for 5.3, thanks!




