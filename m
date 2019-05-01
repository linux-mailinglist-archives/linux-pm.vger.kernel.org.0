Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7190F106E8
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfEAKVn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:21:43 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58967 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfEAKVn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:21:43 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id f51534df836c7de9; Wed, 1 May 2019 12:21:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / core: Propagate dev->power.wakeup_path when no callbacks
Date:   Wed, 01 May 2019 12:21:40 +0200
Message-ID: <3232066.oa1jrYo8oc@kreacher>
In-Reply-To: <20190410095516.6170-1-ulf.hansson@linaro.org>
References: <20190410095516.6170-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday, April 10, 2019 11:55:16 AM CEST Ulf Hansson wrote:
> The dev->power.direct_complete flag may become set in device_prepare() in
> case the device don't have any PM callbacks (dev->power.no_pm_callbacks is
> set). This leads to a broken behaviour, when there is child having wakeup
> enabled and relies on its parent to be used in the wakeup path.
> 
> More precisely, when the direct complete path becomes selected for the
> child in __device_suspend(), the propagation of the dev->power.wakeup_path
> becomes skipped as well.
> 
> Let's address this problem, by checking if the device is a part the wakeup
> path or has wakeup enabled, then prevent the direct complete path from
> being used.
> 
> Reported-by: Loic Pallardy <loic.pallardy@st.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> More background:
> 
> This problem was reported by Loic Pallardy, offlist, while he was working
> on enabling wakeup for a tty serial console driver.
> 
> When I looked more closely, I noticed that uart_suspend_port() calls
> device_may_wakeup() for the tty child devices, and then also the used serial
> driver check its device (parent) for device_may_wakeup(). To me this looks like
> workarounds to fix a behaviour that really should be dealt with from the PM
> core, no matter of whether the child have PM callbacks assigned or not.
> 
> In other words, it seems like the serial driver(s) should be checking the
> wakeup_path flag for the parent, solely, instead.
> 
> I haven't digested further behaviours for other subsystem, but recently
> reviewed a patch for a gpio driver [1], that seems to be suffering from the
> similar problems.
> 
> Kind regards
> Ulf Hansson
> 
> [1]
> https://lkml.org/lkml/2019/4/4/1283
> 
> ---
>  drivers/base/power/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 41eba82ee7b9..f9cfdeee8288 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1747,6 +1747,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  	if (dev->power.syscore)
>  		goto Complete;
>  
> +	/* Avoid direct_complete, to let wakeup_path being propagated. */
> +	if (device_may_wakeup(dev) || dev->power.wakeup_path)
> +		dev->power.direct_complete = false;
> +
>  	if (dev->power.direct_complete) {
>  		if (pm_runtime_status_suspended(dev)) {
>  			pm_runtime_disable(dev);
> 

Applied, thanks!



