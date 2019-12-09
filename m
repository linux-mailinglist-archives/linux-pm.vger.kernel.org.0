Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0A116CE9
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 13:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLIMSP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 07:18:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54893 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLIMSP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 07:18:15 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 70099c35fdbc405c; Mon, 9 Dec 2019 13:18:12 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Make request_queue.rpm_status an enum
Date:   Mon, 09 Dec 2019 13:18:12 +0100
Message-ID: <2128344.f0oqsL5Bda@kreacher>
In-Reply-To: <20191206132350.29040-1-geert+renesas@glider.be>
References: <20191206132350.29040-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, December 6, 2019 2:23:50 PM CET Geert Uytterhoeven wrote:
> request_queue.rpm_status is assigned values of the rpm_status enum only,
> so reflect that in its type.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Perhaps this was done to avoid the need to #include <linux/pm.h>?
> Let's see what kbuild has to report about this...
> ---
>  include/linux/blkdev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 397bb9bc230b6349..6419cd9523c370f8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -466,7 +466,7 @@ struct request_queue {
>  
>  #ifdef CONFIG_PM
>  	struct device		*dev;
> -	int			rpm_status;
> +	enum rpm_status		rpm_status;
>  	unsigned int		nr_pending;
>  #endif
>  
> 




