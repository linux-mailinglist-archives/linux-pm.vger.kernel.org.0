Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C473A8169
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFONyA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 09:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFONyA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 15 Jun 2021 09:54:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF2226105A;
        Tue, 15 Jun 2021 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623765116;
        bh=gyk+gW3hsWR9nvhsJkoEzP/weUoAI4+NXfCjLM+KHRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ITFZOrRgCAqQuNh58PTnq39skr8I2alda4wwdQLbxDk8wxPP3/ZBk3azvd2IbxPdy
         fkgqOsRFBZl4cYMq8X4LesVPb1XniFtrPRUdaDw/G5ir4C3mh9VOMuVIJ/623R7kfO
         axnYdbHZTAFUqsB3pGLFslEDsotl1heNMxJ7Cmyk=
Date:   Tue, 15 Jun 2021 15:51:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PM: domains: call mutex_destroy when removing the
 genpd
Message-ID: <YMiweYHi1zgv6rd+@kroah.com>
References: <20210611101540.3379937-1-dmitry.baryshkov@linaro.org>
 <20210611101540.3379937-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611101540.3379937-2-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 11, 2021 at 01:15:39PM +0300, Dmitry Baryshkov wrote:
> It is a good practice to destroy mutexes with mutex_destroy, so call
> this function for releasing genpd->mlock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/base/power/domain.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b6a782c31613..74219d032910 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1910,6 +1910,11 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
>  	}
>  }
>  
> +static void genpd_lock_destroy(struct generic_pm_domain *genpd) {
> +	if (!(genpd->flags & GENPD_FLAG_IRQ_SAFE))
> +		mutex_destroy(&genpd->mlock);
> +}

Did you run this through checkpatch.pl???

And what does mutex_destroy() do that is required here?

thanks,

greg k-h
