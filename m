Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841AC5983E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 12:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfF1KQj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 06:16:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50117 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfF1KQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 06:16:39 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id cb4a160a3ff2ad5a; Fri, 28 Jun 2019 12:16:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/27] kernel: power: use kzalloc rather than kmalloc followed with memset
Date:   Fri, 28 Jun 2019 12:16:36 +0200
Message-ID: <1609978.ayZxNtafmO@kreacher>
In-Reply-To: <20190628025036.16135-1-huangfq.daxian@gmail.com>
References: <20190628025036.16135-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, June 28, 2019 4:50:35 AM CEST Fuqian Huang wrote:
> Use zeroing allocator instead of using allocator
> followed with memset with 0
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  kernel/power/swap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index e1912ad13bdc..ca0fcb5ced71 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -974,12 +974,11 @@ static int get_swap_reader(struct swap_map_handle *handle,
>  	last = handle->maps = NULL;
>  	offset = swsusp_header->image;
>  	while (offset) {
> -		tmp = kmalloc(sizeof(*handle->maps), GFP_KERNEL);
> +		tmp = kzalloc(sizeof(*handle->maps), GFP_KERNEL);
>  		if (!tmp) {
>  			release_swap_reader(handle);
>  			return -ENOMEM;
>  		}
> -		memset(tmp, 0, sizeof(*tmp));
>  		if (!handle->maps)
>  			handle->maps = tmp;
>  		if (last)
> 

Queued up for 5.3 with minor subject changes.  Thanks!



