Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A5A22599D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jul 2020 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgGTIEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jul 2020 04:04:32 -0400
Received: from relay5.mymailcheap.com ([159.100.241.64]:56951 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGTIEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2020 04:04:32 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 04:04:30 EDT
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 564BE200EA;
        Mon, 20 Jul 2020 07:55:59 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id B9DA83F15F;
        Mon, 20 Jul 2020 09:55:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 967742A8B1;
        Mon, 20 Jul 2020 09:55:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1595231757;
        bh=JDIzmC6xzWVV+edmzQ2cj84tjI5FaofU5GCv/dpHT/U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B2Eh2bjm0yxlT86fQf4ccOV63/dFBj3EfHSM8yVkHRDetMG7XTzId7/frV3RpS5wL
         ltyTOQHmfkPylDTYID8gPaoAIQhe3yC16nCBNIiApdVORaGqy0FcrL68hUNsBCHCxS
         5281KtsS8tH1dE/WJys0jijhML5JhvQx5JXH1oIo=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SY47Ma7yVLDD; Mon, 20 Jul 2020 09:55:56 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Mon, 20 Jul 2020 09:55:56 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 413BD40143;
        Mon, 20 Jul 2020 07:55:55 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="SwXXCHi4";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.local (unknown [59.41.162.238])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 51ADD40143;
        Mon, 20 Jul 2020 07:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1595231735; bh=JDIzmC6xzWVV+edmzQ2cj84tjI5FaofU5GCv/dpHT/U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SwXXCHi44C7Qrhq27xC5WSDidT3TJJzjZl2oG9Z5x3CyoYh1Li9OQGTk5+w589zcF
         KjsiQ/wJ/84ankootRmH7ZtsJKfrKp9J9DD7YR7VYZ9BqG3IgS0acWqxiAm9nGRPEx
         DDiWjuk8lwi4hKGkn9nsdnLYAClk8R5m3RYf5u7U=
Message-ID: <86689f81367716e3f88ec363edd0d302deca0a1f.camel@aosc.io>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Ondrej Jirman <megous@megous.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        linux-sunxi@googlegroups.com, Zhang Rui <rui.zhang@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 20 Jul 2020 15:55:26 +0800
In-Reply-To: <20200708110301.GB1551@shell.armlinux.org.uk>
References: <20200708105527.868987-1-megous@megous.com>
         <20200708110301.GB1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 413BD40143
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[13];
         RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.238:received];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         FREEMAIL_CC(0.00)[verdurent.com,vger.kernel.org,gmail.com,linaro.org,kernel.org,googlegroups.com,intel.com,csie.org,lists.infradead.org];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

在 2020-07-08星期三的 12:03 +0100，Russell King - ARM Linux admin写道：
> On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> > I noticed several mobile Linux distributions failing to enable the
> > thermal regulation correctly, because the kernel is silent
> > when thermal driver fails to probe. Add enough error reporting
> > to debug issues and warn users in case thermal sensor is failing
> > to probe.
> > 
> > Failing to notify users means, that SoC can easily overheat under
> > load.
> > 
> > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > ---
> >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++---
> > ----
> >  1 file changed, 43 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/thermal/sun8i_thermal.c
> > b/drivers/thermal/sun8i_thermal.c
> > index 74d73be16496..9065e79ae743 100644
> > --- a/drivers/thermal/sun8i_thermal.c
> > +++ b/drivers/thermal/sun8i_thermal.c
> > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct
> > ths_device *tmdev)
> >  
> >  	calcell = devm_nvmem_cell_get(dev, "calibration");
> >  	if (IS_ERR(calcell)) {
> > +		dev_err(dev, "Failed to get calibration nvmem cell
> > (%ld)\n",
> > +			PTR_ERR(calcell));
> 
> Consider using:
> 
> 		dev_err(dev, "Failed to get calibration nvmem cell
> (%pe)\n",
> 			calcell);
> 
> which means the kernel can print the symbolic errno value.

Oh interesting format here.

When we need to deal with a int return value, is it "%e"?

Thanks

> 
