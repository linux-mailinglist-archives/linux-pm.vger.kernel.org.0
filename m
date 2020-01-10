Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B996136BC3
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 12:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgAJLNb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jan 2020 06:13:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54139 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgAJLNb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jan 2020 06:13:31 -0500
Received: from 79.184.255.90.ipv4.supernova.orange.pl (79.184.255.90) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 72f2d2c43d24f829; Fri, 10 Jan 2020 12:13:29 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org,
        "RafaelJ . Wysocki" <rafael.j.wysocki@intel.com>,
        DanielLezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG-REPORT: cpuidle: teo: intervals[] array index out
Date:   Fri, 10 Jan 2020 12:13:28 +0100
Message-ID: <2821853.MfSkROXiEm@kreacher>
In-Reply-To: <20200110015917.32825-1-ikjn@chromium.org>
References: <20200110015917.32825-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, January 10, 2020 2:59:17 AM CET Ikjoon Jang wrote:
> This seems to be a simple bug in rotating array index.

That's correct.

Please repost the patch with a Signed-off-by tag, so I can apply it.

> ---
>  drivers/cpuidle/governors/teo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> index de7e706efd46..6deaaf5f05b5 100644
> --- a/drivers/cpuidle/governors/teo.c
> +++ b/drivers/cpuidle/governors/teo.c
> @@ -198,7 +198,7 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
>  	 * pattern detection.
>  	 */
>  	cpu_data->intervals[cpu_data->interval_idx++] = measured_ns;
> -	if (cpu_data->interval_idx > INTERVALS)
> +	if (cpu_data->interval_idx >= INTERVALS)
>  		cpu_data->interval_idx = 0;
>  }
>  
> 




