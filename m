Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE742178F37
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2020 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCDLGJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Mar 2020 06:06:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51309 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCDLGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2020 06:06:09 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 23ba990a84e430d4; Wed, 4 Mar 2020 12:06:06 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powercap: idle_inject: Replace zero-length array with flexible-array member
Date:   Wed, 04 Mar 2020 12:06:06 +0100
Message-ID: <2823796.V19jU70VZq@kreacher>
In-Reply-To: <20200227190721.GA19083@embeddedor>
References: <20200227190721.GA19083@embeddedor>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, February 27, 2020 8:07:21 PM CET Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> Lastly, fix the following checkpatch warning:
> WARNING: Prefer 'unsigned long' over 'unsigned long int' as the int is unnecessary
> +	unsigned long int cpumask[];
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/powercap/idle_inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
> index cd1270614cc6..e9bbd3c42eef 100644
> --- a/drivers/powercap/idle_inject.c
> +++ b/drivers/powercap/idle_inject.c
> @@ -67,7 +67,7 @@ struct idle_inject_device {
>  	struct hrtimer timer;
>  	unsigned int idle_duration_us;
>  	unsigned int run_duration_us;
> -	unsigned long int cpumask[0];
> +	unsigned long cpumask[];
>  };
>  
>  static DEFINE_PER_CPU(struct idle_inject_thread, idle_inject_thread);
> 

Applied as 5.7 material, thanks!




