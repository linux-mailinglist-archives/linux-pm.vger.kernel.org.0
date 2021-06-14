Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A13A6C5B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbhFNQt4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 12:49:56 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:34393 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbhFNQt4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 12:49:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623689266; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=E7v5tLD8tTSzc2/HQ4QNd8hHzdzpM6lmFxSvkK+l23umHNu6NfXW2GvSiTLw48YK3E
    YNyPHJxiqDm8WK7CF33en4aLpLTP5MNpfsvF08tg8BEcc9X/wm6N/zG7qS9mhbbaEd6r
    N3q646ytMkovJvzO7+Y9E3C9R6wHzAzz9LMx+QgEJ9ucyBrsGIikcidBaMkfU4kxtypz
    o45h/Xc+V02SrXSUvKtuFOPNbg2OQPjFyYHfcFYFbWjJ4wFPAEP99N3BI1EBUxBM4tYE
    I0JZoCIZ4sLObSZ24toB1EgfrJkVPlLc14k6/4U7DfVo6nOrHO1prQfuAtRS/Frp8T37
    6suA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623689266;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZqBYr0Nz6mA2wcJ+xak+eC4fMLx4N6rwt5mXZEANWlo=;
    b=taah575yq9kXzF9VlRjVB1hTwdAtLCaeFHRe6HY+1DzEvcIBXdYnjhBAROv8cIDe3/
    cblo4ciJQg+VKCXQdmOn3oD80t32Ue19b31QsvNHNFFSuaBl4i5yvWKNBN3EDbRHHSF7
    ZhaDgcbai9Z7kr6R3TTKhZJP8a7Clqx+WC3jP875h+oyBojqvGUU+KYb6ibsBSnkmPbm
    sjhu7R46CxFfr+rH0UAbVr6+75HRtOHi3yfLCZ3o9V2qev+B21kKAyZIu3vBbiICvjAG
    y0w9inUui9p0Z5inSmijA+IP+hP3JQZ7rRRxPRwF8pUxp+sZ4BkTGHec0bRqV705TtRO
    17ow==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623689266;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ZqBYr0Nz6mA2wcJ+xak+eC4fMLx4N6rwt5mXZEANWlo=;
    b=eikwn35OimVKNDcgiGvtW4NwGD45w5K15ibPdPTQWhnHiXCA6s53TCDqGqWbR2+csd
    FN5KTaEDjitg1bKXR5SBjj+1/ZtvQvzLW7JhH1wxk0zSN8dUVZJ4PVyxHgusA4nTiw76
    uITy9neRabxTgp/OsX0EQJY5MHRj9gzFQ2ZLm1+itBgyzXIz7epwMBautnOkIz1vD1He
    VeVZuIQ8dBlfuu0E2qcZGUIC5vkno8V94Is9APDr+984IZvgewFLvGi4Ex8TqYQJc6wn
    nsazYIYD+ZmnmK6omfveDR/bL/XAM964E60stOu6Evuod4SAe6CxbYH0nErt4HvfXFnJ
    Kl0A==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nwIc/BaYo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5EGljJ8q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 14 Jun 2021 18:47:45 +0200 (CEST)
Date:   Mon, 14 Jun 2021 18:47:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 3/3] mfd: rt5033: Drop rt5033-battery sub-device
Message-ID: <YMeILEnjOCCzo61q@gerhold.net>
References: <20210517105113.240379-1-stephan@gerhold.net>
 <20210517105113.240379-4-stephan@gerhold.net>
 <20210519144630.GC2549456@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519144630.GC2549456@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lee,

On Wed, May 19, 2021 at 03:46:30PM +0100, Lee Jones wrote:
> On Mon, 17 May 2021, Stephan Gerhold wrote:
> 
> > The fuel gauge in the RT5033 PMIC (rt5033-battery) has its own I2C bus
> > and interrupt lines. Therefore, it is not part of the MFD device
> > and needs to be specified separately in the device tree.
> > 
> > Cc: Beomho Seo <beomho.seo@samsung.com>
> > Cc: Chanwoo Choi <cw00.choi@samsung.com>
> > Fixes: 0b271258544b ("mfd: rt5033: Add Richtek RT5033 driver core.")
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  drivers/mfd/rt5033.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Since I mentioned in the cover letter that the MFD and power supply
changes can be applied independently, Sebastian only queued patch 1 and 2.

Can you queue this one through the MFD tree?

Thanks!
Stephan
