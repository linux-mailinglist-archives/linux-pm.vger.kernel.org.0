Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436CDEC672
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 17:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfKAQPj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 12:15:39 -0400
Received: from vps.xff.cz ([195.181.215.36]:60268 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbfKAQPj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 Nov 2019 12:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572624937; bh=DUJ21suT9UFTz9RcE01mK2DkoJaOFwuKLOjW5+4c7js=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=bHux83oE+gyWLkQFblsmIXq+x2TReluLU64ZFrLrHnGg8o6LECme6g+JEVaqzN/A6
         /zWD1G5F3nTrfQ6cle/Xsw7cg+fWXUc7kRyxMHNCOuZKz8EUB8DOFANuM7RTOfBVTQ
         q2weXI4DwqROBU0BZ/z8RgZtJecPLtByFvbWOWrY=
Date:   Fri, 1 Nov 2019 17:15:37 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-sunxi@googlegroups.com, Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: sun50i: Fix CPU speed bin detection
Message-ID: <20191101161537.xqywdnwlrxgjf7hf@core.my.home>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        linux-sunxi@googlegroups.com, Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191031181359.282617-1-megous@megous.com>
 <20191101150701.fgke7hoad5zn3vn2@hendrix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101150701.fgke7hoad5zn3vn2@hendrix>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 01, 2019 at 04:07:01PM +0100, Maxime Ripard wrote:
> On Thu, Oct 31, 2019 at 07:13:58PM +0100, Ondrej Jirman wrote:
> > I have failures to boot on Orange Pi 3, because this driver determined
> > that my SoC is from the normal bin, but my SoC only works reliably with
> > the OPP values for the slowest bin.
> >
> > Looking at BSP code, I found that efuse values have following meanings
> > on H6:
> >
> > - 0b000 invalid (interpreted in vendor's BSP as normal bin)
> > - 0b001 slowest bin
> > - 0b011 normal bin
> > - 0b111 fastest bin
> >
> > Let's play it safe and interpret 0 as the slowest bin, but fix detection
> > of other bins to match vendor code.
> >
> > Fixes: f328584f7bff ("cpufreq: Add sun50i nvmem based CPU scaling driver")
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>

Self-NACK :) Please don't merge.

Please see the other e-mail for why.

thank you and regards,
	o.

> Out of curiosity, which OPP table is being used? I guess it's one of
> the dozens of patches sitting there...
> 
> Maxime


