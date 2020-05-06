Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0E61C7A1B
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgEFTUz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 15:20:55 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:33468 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgEFTUz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 15:20:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 92CE48030808;
        Wed,  6 May 2020 19:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Wr0HOHLMXTqE; Wed,  6 May 2020 22:20:51 +0300 (MSK)
Date:   Wed, 6 May 2020 22:20:49 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mips@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/20] dt-bindings: Add vendor prefix for Baikal
 Electronics, JSC
Message-ID: <20200506192049.bznhiwra5a43ao26@mobilestation>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <20200506174238.15385-1-Sergey.Semin@baikalelectronics.ru>
 <20200506174238.15385-4-Sergey.Semin@baikalelectronics.ru>
 <20200506175553.GA7775@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200506175553.GA7775@ravnborg.org>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sam,

On Wed, May 06, 2020 at 07:55:53PM +0200, Sam Ravnborg wrote:
> Hi Sergey.
> 
> On Wed, May 06, 2020 at 08:42:21PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Add "BAIKAL ELECTRONICS, JSC" to the list of devicetree vendor prefixes
> > as "baikal".
> > 
> > Website: http://www.baikalelectronics.com
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-mips@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > 
> > ---
> > 
> > Changelog v2:
> > - Fix author and SoB emails mismatch.
> 
> > - Add 'baikal' vendor prefix instead of ambiguous 'be'.
> Agree, much better.
> 
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index d3891386d671..674c0d07c0ad 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -139,6 +139,8 @@ patternProperties:
> >      description: Azoteq (Pty) Ltd
> >    "^azw,.*":
> >      description: Shenzhen AZW Technology Co., Ltd.
> > +  "^baikal,.*":
> > +    description: BAIKAL ELECTRONICS, JSC
> Baikal do not use ALL UPPSECASE on their website for their name.
> So please use same case use as they do themself.
> 

It's not like me can't be considered as part of them.) I discussed the
upper-case and normal version with our managers half a year ago and we
came up to use the upper-case version. From Russian legal point of view
it's also the upper-cased version what counts. I don't really know why
the site use different naming, but in the internal documents it's always
as submitted. Anyway I asked this question one more time to our managers.
If they say to use as you suggest, then I'll resend an update in v3
patchset, if v3 doesn't get to be necessary I'll send a followup patch
with fix.

-Sergey

> 
> 	Sam
> 
> >    "^bananapi,.*":
> >      description: BIPAI KEJI LIMITED
> >    "^beacon,.*":
> > -- 
> > 2.25.1
