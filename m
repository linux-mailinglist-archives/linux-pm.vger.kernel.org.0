Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA89F1203B1
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 12:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLPLUy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 06:20:54 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61473 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfLPLUx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 06:20:53 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 8f1ea1b690dcc29b; Mon, 16 Dec 2019 12:20:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>, daniel.lezcano@linaro.org
Cc:     shc_work@mail.ru, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: clps711x: convert to devm_platform_ioremap_resource
Date:   Mon, 16 Dec 2019 12:20:50 +0100
Message-ID: <5309821.Xs2qqjuCkx@kreacher>
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

Daniel, any concerns here?



