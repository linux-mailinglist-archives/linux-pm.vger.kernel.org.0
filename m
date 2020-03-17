Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43A9188DFC
	for <lists+linux-pm@lfdr.de>; Tue, 17 Mar 2020 20:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgCQT1x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Tue, 17 Mar 2020 15:27:53 -0400
Received: from mail.v3.sk ([167.172.186.51]:46890 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbgCQT1w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Mar 2020 15:27:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AFC98E0116;
        Tue, 17 Mar 2020 19:28:11 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ls6VIZjKMfxz; Tue, 17 Mar 2020 19:28:11 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E41ABE021B;
        Tue, 17 Mar 2020 19:28:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wSR1zRWsKMFz; Tue, 17 Mar 2020 19:28:10 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A044CE0116;
        Tue, 17 Mar 2020 19:28:10 +0000 (UTC)
Date:   Tue, 17 Mar 2020 20:27:48 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        kongxinwei <kong.kongxinwei@hisilicon.com>,
        Wangtao <kevin.wangtao@hisilicon.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: hisilicon: Don't enable by default
Message-ID: <20200317192748.GB24359@furthur.local>
References: <20200317174130.23523-1-lkundrak@v3.sk>
 <1940ceca-c791-5fa6-c680-461a27c09ccf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1940ceca-c791-5fa6-c680-461a27c09ccf@linaro.org>
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 17, 2020 at 06:45:29PM +0100, Daniel Lezcano wrote:
> On 17/03/2020 18:41, Lubomir Rintel wrote:
> > Users are generally unlikely to have a HiSilicon thermal sensor.
> 
> Why ?

Because most computers don't run on HiSilicon chips.

> The thermal sensor is needed for the thermal mitigation.

If it's really needed, shouldn't ARCH_HISI depend on it?

In any case, I submitted this, because the driver enabled itself when I
turned on COMPILE_TEST, which was entirely unexpected. Unless I'm
mistaken, defaulting to off seems to be a standard practice for most
drivers, including thermal.

Would this be a better idea?

  default y if ARCH_HISI

Thanks
Lubo

> 
> > Like most other thermal drivers, don't build it by default/
> >
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  drivers/thermal/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 02c3aa322a4a6..2062f8ec272b6 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -233,7 +233,6 @@ config HISI_THERMAL
> >  	depends on ARCH_HISI || COMPILE_TEST
> >  	depends on HAS_IOMEM
> >  	depends on OF
> > -	default y
> >  	help
> >  	  Enable this to plug hisilicon's thermal sensor driver into the Linux
> >  	  thermal framework. cpufreq is used as the cooling device to throttle
> > 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
