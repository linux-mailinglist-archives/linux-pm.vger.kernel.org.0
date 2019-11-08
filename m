Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972C5F45C5
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 12:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfKHLe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 06:34:26 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57883 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfKHLeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 06:34:25 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 2cb5217da455c9c5; Fri, 8 Nov 2019 12:34:23 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     zhuguangqing83@gmail.com
Cc:     gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhuguangqing <zhuguangqing@xiaomi.com>
Subject: Re: [PATCH] PM/wakeup: Add print_wakeup_sour_stats(m, &deleted_ws)
Date:   Fri, 08 Nov 2019 12:34:23 +0100
Message-ID: <2538968.KVf98yYfh7@kreacher>
In-Reply-To: <20191021085140.14030-1-zhuguangqing83@gmail.com>
References: <20191021085140.14030-1-zhuguangqing83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, October 21, 2019 10:51:40 AM CET zhuguangqing83@gmail.com wrote:
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
>  drivers/base/power/wakeup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5817b51d2b15..29e9434ccaaa 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -1071,6 +1071,9 @@ static void *wakeup_sources_stats_seq_next(struct seq_file *m,
>  		break;
>  	}
>  
> +	if (&ws->entry == &wakeup_sources)
> +		print_wakeup_source_stats(m, &deleted_ws);
> +

That would be when NULL is about to be returned, right?

Why not to check for !next_ws instead, then?

Moreover, why to call print_wakeup_source_stats() directly instead of returning
&deleted_ws?

Also it looks like you need a similar change in wakeup_sources_stats_seq_start(),
in case n is greater than the number of list entries, don't you?

>  	return next_ws;
>  }
>  
> 




