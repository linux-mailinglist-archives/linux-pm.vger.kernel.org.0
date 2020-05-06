Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D91C7A44
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgEFT1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 15:27:00 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:49622 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbgEFT1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 15:27:00 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 800CC803E8;
        Wed,  6 May 2020 21:26:54 +0200 (CEST)
Date:   Wed, 6 May 2020 21:26:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/20] dt-bindings: Add vendor prefix for Baikal
 Electronics, JSC
Message-ID: <20200506192653.GA30135@ravnborg.org>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-4-Sergey.Semin@baikalelectronics.ru>
 <20200506175553.GA7775@ravnborg.org>
 <20200506192049.bznhiwra5a43ao26@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506192049.bznhiwra5a43ao26@mobilestation>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=8TNDbFa_6LcrRd7mousA:9
        a=4rAq1Kjot4Fw8Xj5:21 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sergey
> > > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > > @@ -139,6 +139,8 @@ patternProperties:
> > >      description: Azoteq (Pty) Ltd
> > >    "^azw,.*":
> > >      description: Shenzhen AZW Technology Co., Ltd.
> > > +  "^baikal,.*":
> > > +    description: BAIKAL ELECTRONICS, JSC
> > Baikal do not use ALL UPPSECASE on their website for their name.
> > So please use same case use as they do themself.
> > 
> 
> It's not like me can't be considered as part of them.) I discussed the
> upper-case and normal version with our managers half a year ago and we
> came up to use the upper-case version. From Russian legal point of view
> it's also the upper-cased version what counts. I don't really know why
> the site use different naming, but in the internal documents it's always
> as submitted. Anyway I asked this question one more time to our managers.
> If they say to use as you suggest, then I'll resend an update in v3
> patchset, if v3 doesn't get to be necessary I'll send a followup patch
> with fix.

I had expected it was upper case because others used upper case.
But there is a good explanation and then all is fine wiht me.

And it is an alphabetic order - so
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> 
> -Sergey
> 
> > 
> > 	Sam
> > 
> > >    "^bananapi,.*":
> > >      description: BIPAI KEJI LIMITED
> > >    "^beacon,.*":
> > > -- 
> > > 2.25.1
