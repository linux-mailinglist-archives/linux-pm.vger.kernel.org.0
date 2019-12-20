Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35E3C1277D9
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 10:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfLTJRS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 04:17:18 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45585 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLTJRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 04:17:18 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id b0db5a8dbd577916; Fri, 20 Dec 2019 10:17:15 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     daniel.lezcano@linaro.org, shc_work@mail.ru,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: clps711x: convert to devm_platform_ioremap_resource
Date:   Fri, 20 Dec 2019 10:17:15 +0100
Message-ID: <1695381.X16qlkCt6g@kreacher>
In-Reply-To: <20191215130206.30265-1-tiny.windzz@gmail.com>
References: <20191215130206.30265-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, December 15, 2019 2:02:05 PM CET Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-clps711x.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpuidle-clps711x.c
> index 6e36740f5719..fc22c59b6c73 100644
> --- a/drivers/cpuidle/cpuidle-clps711x.c
> +++ b/drivers/cpuidle/cpuidle-clps711x.c
> @@ -37,10 +37,7 @@ static struct cpuidle_driver clps711x_idle_driver = {
>  
>  static int __init clps711x_cpuidle_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	clps711x_halt = devm_ioremap_resource(&pdev->dev, res);
> +	clps711x_halt = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(clps711x_halt))
>  		return PTR_ERR(clps711x_halt);
>  
> 

Applied as 5.6 material, thanks!




