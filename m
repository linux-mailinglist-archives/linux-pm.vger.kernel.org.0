Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E775430B81
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2019 11:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaJ3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 31 May 2019 05:29:19 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52236 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfEaJ3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2019 05:29:19 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b1c8d75ad1f69e80; Fri, 31 May 2019 11:29:17 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / clk: Remove error message on out-of-memory condition
Date:   Fri, 31 May 2019 11:29:16 +0200
Message-ID: <4033832.t2mNCoI3x2@kreacher>
In-Reply-To: <20190527122751.6430-1-geert+renesas@glider.be>
References: <20190527122751.6430-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, May 27, 2019 2:27:51 PM CEST Geert Uytterhoeven wrote:
> There is no need to print an error message if kstrdup() fails, as the
> memory allocation core already takes care of that.
> 
> Note that commit 59d84ca8c46a93ad ("PM / OPP / clk: Remove unnecessary
> OOM message") already removed similar error messages, but this one was
> forgotten.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/base/power/clock_ops.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 59d19dd649289287..1cf86fcaeff8faac 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -92,8 +92,6 @@ static int __pm_clk_add(struct device *dev, const char *con_id,
>  	if (con_id) {
>  		ce->con_id = kstrdup(con_id, GFP_KERNEL);
>  		if (!ce->con_id) {
> -			dev_err(dev,
> -				"Not enough memory for clock connection ID.\n");
>  			kfree(ce);
>  			return -ENOMEM;
>  		}
> 

Applied, thanks!




