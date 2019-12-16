Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D91203B5
	for <lists+linux-pm@lfdr.de>; Mon, 16 Dec 2019 12:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLPLVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Dec 2019 06:21:10 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51835 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfLPLVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2019 06:21:10 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id e45c4e508fae84d8; Mon, 16 Dec 2019 12:21:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     daniel.lezcano@linaro.org, shc_work@mail.ru,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: kirkwood: convert to devm_platform_ioremap_resource
Date:   Mon, 16 Dec 2019 12:21:07 +0100
Message-ID: <6350875.0eM1BVzdex@kreacher>
In-Reply-To: <20191215130206.30265-2-tiny.windzz@gmail.com>
References: <20191215130206.30265-1-tiny.windzz@gmail.com> <20191215130206.30265-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, December 15, 2019 2:02:06 PM CET Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-kirkwood.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
> index d23d8f468c12..511c4f46027a 100644
> --- a/drivers/cpuidle/cpuidle-kirkwood.c
> +++ b/drivers/cpuidle/cpuidle-kirkwood.c
> @@ -55,10 +55,7 @@ static struct cpuidle_driver kirkwood_idle_driver = {
>  /* Initialize CPU idle by registering the idle states */
>  static int kirkwood_cpuidle_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	ddr_operation_base = devm_ioremap_resource(&pdev->dev, res);
> +	ddr_operation_base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(ddr_operation_base))
>  		return PTR_ERR(ddr_operation_base);
>  
> 

Daniel, any concerns here?



