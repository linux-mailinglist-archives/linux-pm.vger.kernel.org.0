Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9935A136BC8
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgAJLQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 06:16:17 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgAJLQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 06:16:17 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 5cd8c14a109a28dc; Fri, 10 Jan 2020 12:16:14 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Colin King <colin.king@canonical.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PM: hibernate: fix spelling mistake "shapshot" -> "snapshot"
Date:   Fri, 10 Jan 2020 12:16:14 +0100
Message-ID: <1732016.surcVlZrUL@kreacher>
In-Reply-To: <20200110100812.236881-1-colin.king@canonical.com>
References: <20200110100812.236881-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, January 10, 2020 11:08:12 AM CET Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_info message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 353c5e9070ed..befe3c94767c 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1841,7 +1841,7 @@ int hibernate_preallocate_memory(void)
>  
>   out:
>  	stop = ktime_get();
> -	pr_info("Allocated %lu pages for shapshot\n", pages);
> +	pr_info("Allocated %lu pages for snapshot\n", pages);
>  	swsusp_show_speed(start, stop, pages, "Allocated");
>  
>  	return 0;
> 

Applied, thanks!




