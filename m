Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39671B913A
	for <lists+linux-pm@lfdr.de>; Sun, 26 Apr 2020 17:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgDZPkq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 26 Apr 2020 11:40:46 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50700 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDZPkp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 26 Apr 2020 11:40:45 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 0e8da9b97d105e2b; Sun, 26 Apr 2020 17:40:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>, od@zcrc.me,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PM: introduce pm_ptr() macro
Date:   Sun, 26 Apr 2020 17:40:43 +0200
Message-ID: <2708095.iQXV2FnTNx@kreacher>
In-Reply-To: <20200413123207.74552-1-paul@crapouillou.net>
References: <20200413123207.74552-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 13, 2020 2:32:05 PM CEST Paul Cercueil wrote:
> This macro is analogous to the infamous of_match_ptr(). If CONFIG_PM
> is enabled, this macro will resolve to its argument, otherwise to NULL.

Well, this is going to result in quite a bit of unused code being
added to the kernels built with CONFIG_PM unset.

Is there any way to avoid that somehow?

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Remove pm_sleep_ptr() macro
> 
>  include/linux/pm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e057d1fa2469..1c0eec06905d 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -374,6 +374,12 @@ const struct dev_pm_ops name = { \
>  	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
>  }
>  
> +#ifdef CONFIG_PM
> +#define pm_ptr(_ptr) (_ptr)
> +#else
> +#define pm_ptr(_ptr) NULL
> +#endif
> +
>  /*
>   * PM_EVENT_ messages
>   *
> 




