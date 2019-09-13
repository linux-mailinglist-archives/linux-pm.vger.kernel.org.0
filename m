Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B23DB2254
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2019 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfIMOhI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Sep 2019 10:37:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41422 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbfIMOgM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2019 10:36:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id g16so14495337otp.8;
        Fri, 13 Sep 2019 07:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Udp1qs2PnQd+suer1OhTIlkS/OekkcPK9CiDkJDjShA=;
        b=slHt68/wZWZvVdF3p3n3Z3/kpIZrKM7cr7RoZ2CJUVnCJdw3nVxU2W9AELUPlBTQFw
         fJR1bGq1EGIN5El8UcUCoUqNK9UHci2itT0n/Wpx3baC5ZdKqT6F0SaDzVXMLoPYbQhQ
         sB+who7kl2LkF2w2KSgaltJEnHSPkAJyBtVr+SMh54W/f00wOhlQ8OxQ2HlTY6BVb4uj
         zsEyNc4Hzsy78kh2ussv9hL9Zy9Fvge6TXdqRuXeNcKeNe160RfQwmff4TMzJnI0wA/g
         KNdrEXJ/wTVmc4cpL8A6d8M3citjNPkCvTd9XespvXkUmqqL1IciAjy3g3eTv5zvpzrE
         76ZQ==
X-Gm-Message-State: APjAAAWluZmqw48+dtPVdHNyb3kyvghpIGe0u1SxpRwUxA/6+Xw+rBpn
        IY8GOGcKMBPlW/BNrUj4mg==
X-Google-Smtp-Source: APXvYqycFKRr57mlzxEV5y+yWerE/UvbEc15wS4dWm6MgJQ1ln7TuCcpwqsSqLk1VgSzUI9biggE8Q==
X-Received: by 2002:a9d:5f9a:: with SMTP id g26mr9285769oti.27.1568385371763;
        Fri, 13 Sep 2019 07:36:11 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j3sm1115259oih.52.2019.09.13.07.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 07:36:10 -0700 (PDT)
Message-ID: <5d7ba95a.1c69fb81.bfd81.77ba@mx.google.com>
Date:   Fri, 13 Sep 2019 15:36:10 +0100
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lukasz Luba <l.luba@partner.samsung.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org, mark.rutland@arm.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: ddr: Add bindings for Samsung LPDDR3
 memories
References: <CGME20190906101407eucas1p15eb0df53374b27497b4793eab24becf6@eucas1p1.samsung.com>
 <20190906101344.3535-1-l.luba@partner.samsung.com>
 <20190906101344.3535-4-l.luba@partner.samsung.com>
 <CAJKOXPfoYxTVvt_bMQOs1=BkHzUuW_WvL9zn0jTGS6LLpv=fhQ@mail.gmail.com>
 <52963d0d-cf48-7085-5581-a94c6e15e0bd@partner.samsung.com>
 <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
X-Mutt-References: <CAJKOXPfEcURr_bLRaAdjWT3cb7mcuKTk8rmn7OTO=xtvjvJ=jQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 06, 2019 at 01:50:26PM +0200, Krzysztof Kozlowski wrote:
> On Fri, 6 Sep 2019 at 13:39, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> >
> > Hi Krzysztof,
> >
> > On 9/6/19 12:56 PM, Krzysztof Kozlowski wrote:
> > > On Fri, 6 Sep 2019 at 12:14, Lukasz Luba <l.luba@partner.samsung.com> wrote:
> > >>
> > >> Add description of bindings for Samsung k3qf2f20db LPDDR3 memory.
> > >> Minor fixes in the old documentation.
> > >>
> > >> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> > >> ---
> > >>   .../devicetree/bindings/ddr/lpddr3.txt        | 29 +++++++++++++++++--
> > >>   1 file changed, 27 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/ddr/lpddr3.txt b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> > >> index 3b2485b84b3f..de0905239767 100644
> > >> --- a/Documentation/devicetree/bindings/ddr/lpddr3.txt
> > >> +++ b/Documentation/devicetree/bindings/ddr/lpddr3.txt
> > >> @@ -40,10 +40,34 @@ Child nodes:
> > >>     a given speed-bin. Please see Documentation/devicetree/
> > >>     bindings/ddr/lpddr3-timings.txt for more information on "lpddr3-timings"
> > >>
> > >> +Samsung K3QF2F20DB LPDDR3 memory
> > >> +------------------------------------------------------------
> > >> +
> > >> +This binding uses the LPDDR3 binding (described above)
> > >> +
> > >> +Required properties:
> > >> +- compatible:  Should be:
> > >> +               "samsung,K3QF2F20DB"
> > >> +               followed by "jedec,lpddr3"
> > >> +- density  : <u32> representing density in Mb (Mega bits)
> > >> +- io-width : <u32> representing bus width. Possible value 32
> > >> +- #address-cells: Must be set to 1
> > >> +- #size-cells: Must be set to 0
> > >
> > > If you decided to repeat all properties again, then it deserves its
> > > own bindings file. However I though about simpler solution - just
> > > document compatible. Exactly the same as AT24 or AT25 EEPROM bindings.
> > > There is not much benefit from copying all these properties.
> > OK, I see. I will add only 'compatible' and skip the rest then.
> > So the lpddr3.txt file will get this addition:
> >
> > +Samsung K3QF2F20DB LPDDR3 memory
> > +------------------------------------------------------------
> > +
> > +This binding uses the LPDDR3 binding (described above)
> > +
> > +Required properties:
> > +- compatible:  Should be:
> > +               "samsung,K3QF2F20DB"
> > +               followed by "jedec,lpddr3"
> > +
> > +Optional properties:
> > +
> > +The optional properties are the same as in the LPDDR3 generic bindings and
> > +values should be taken from the data-sheet. Detailed bindings are described
> > +above.
> > +
> > +Child nodes:
> > +
> > +Detailed bindings are described in LPDDR3 generic bindings described above.
> > +
> >
> > Is it OK?
> 
> To me it is still a lot of text just for one compatible and I can
> image more of such entries for other memories... However I do not mind
> and anyway, YAML will simplify it. If you're in doubt, wait for Rob's
> reply as this is his part.

We can't have multiple (top-level) schema in one file, so better to add 
in where the existing compatible strings are.

Rob

