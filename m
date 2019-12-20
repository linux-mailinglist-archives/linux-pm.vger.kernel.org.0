Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDED41277E7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfLTJTd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 04:19:33 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45643 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTJTd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 04:19:33 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b09be8de9d95ff35; Fri, 20 Dec 2019 10:19:31 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     zhuguangqing83@gmail.com
Cc:     pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH v2]PM/wakeup: Add print_wakeup_source_stats(m, &deleted_ws)
Date:   Fri, 20 Dec 2019 10:19:31 +0100
Message-ID: <2830760.UpLSkk7Ke6@kreacher>
In-Reply-To: <20191209093523.15752-1-zhuguangqing83@gmail.com>
References: <20191209093523.15752-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, December 9, 2019 10:35:23 AM CET zhuguangqing83@gmail.com wrote:
> From: zhuguangqing <zhuguangqing@xiaomi.com>
> 
> After commit 00ee22c28915 (PM / wakeup: Use seq_open()
> to show wakeup stats), print_wakeup_source_stats(m, &deleted_ws)
> is deleted in function wakeup_sources_stats_seq_show().
> 
> Because deleted_ws is one of wakeup sources, so it should
> also be showed. This patch add it to the end of all other
> wakeup sources.
> 
> Signed-off-by: zhuguangqing <zhuguangqing@xiaomi.com>
> ---
> v2: modify judegment condition according to the advice of Rafael J.
> 
>  drivers/base/power/wakeup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5817b51d2b15..53c0519da1e4 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1071,6 +1071,9 @@ static void *wakeup_sources_stats_seq_next(struct seq_file *m,
>  		break;
>  	}
>  
> +	if (!next_ws)
> +		print_wakeup_source_stats(m, &deleted_ws);
> +
>  	return next_ws;
>  }
>  
> 

Applied as 5.6 material with some subject and changelog modifications, thanks!




