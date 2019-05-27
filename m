Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB4102B23C
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2019 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfE0KeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 May 2019 06:34:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56694 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0KeF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 May 2019 06:34:05 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 6298d57505205ada; Mon, 27 May 2019 12:34:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drivers: base: power: Use of_clk_get_parent_count()
Date:   Mon, 27 May 2019 12:34:02 +0200
Message-ID: <2586134.4dTKnEaoxt@kreacher>
In-Reply-To: <20190525120155.108948-1-wangkefeng.wang@huawei.com>
References: <20190525120155.108948-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, May 25, 2019 2:01:55 PM CEST Kefeng Wang wrote:
> Use of_clk_get_parent_count() instead of open coding.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/base/power/clock_ops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 59d19dd64928..9c7e83267eac 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -195,8 +195,7 @@ int of_pm_clk_add_clks(struct device *dev)
>  	if (!dev || !dev->of_node)
>  		return -EINVAL;
>  
> -	count = of_count_phandle_with_args(dev->of_node, "clocks",
> -					   "#clock-cells");
> +	count = of_clk_get_parent_count(dev->of_node);
>  	if (count <= 0)
>  		return -ENODEV;
>  
> 

I need someone to look at this from DT perspective.




