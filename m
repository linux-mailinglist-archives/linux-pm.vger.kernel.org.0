Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 729BD175C7
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 12:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfEHKPB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 06:15:01 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47620 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEHKO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 06:14:57 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 230C025AF6B;
        Wed,  8 May 2019 20:14:56 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 25D989403E0; Wed,  8 May 2019 12:14:54 +0200 (CEST)
Date:   Wed, 8 May 2019 12:14:54 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH/RFT v2 1/3] thermal: rcar_gen3_thermal: Update value of
 Tj_1
Message-ID: <20190508101453.wd437arikt2ohifa@verge.net.au>
References: <1555436655-5262-1-git-send-email-ykaneko0929@gmail.com>
 <1555436655-5262-2-git-send-email-ykaneko0929@gmail.com>
 <20190424145436.camftb32c7v2ya2f@verge.net.au>
 <CAH1o70LX97ir=T1R5SjBnsTQmnbUdN8LadByTH_-4eRgp27PzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH1o70LX97ir=T1R5SjBnsTQmnbUdN8LadByTH_-4eRgp27PzQ@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, May 08, 2019 at 03:36:36PM +0900, Yoshihiro Kaneko wrote:
> Hi Simon-san,
> 
> Thanks for testing this patch!
> 
> 2019年4月24日(水) 23:54 Simon Horman <horms@verge.net.au>:
> >
> > Hi Kaneko-san,
> >
> > On Wed, Apr 17, 2019 at 02:44:13AM +0900, Yoshihiro Kaneko wrote:
> > > As evaluation of hardware team, temperature calculation formula
> > > of M3-W is difference from all other SoCs as below:
> > > - M3-W: Tj_1: 116 (so Tj_1 - Tj_3 = 157)
> > > - Others: Tj_1: 126 (so Tj_1 - Tj_3 = 167)
> > >
> > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > ---
> > >  drivers/thermal/rcar_gen3_thermal.c | 41 +++++++++++++++++++++++++++----------
> > >  1 file changed, 30 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
> > > index 88fa41c..a2fd0fd 100644
> > > --- a/drivers/thermal/rcar_gen3_thermal.c
> > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > @@ -124,11 +124,11 @@ static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> > >  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
> > >
> > >  /* no idea where these constants come from */
> > > -#define TJ_1 116
> > >  #define TJ_3 -41
> > >
> > >  static void rcar_gen3_thermal_calc_coefs(struct equation_coefs *coef,
> > > -                                      int *ptat, int *thcode)
> > > +                                      int *ptat, int *thcode,
> > > +                                      unsigned int ths_tj_1)
> >
> > While testing I found that the type of ths_tj_1 needs to be int
> > rather than unsigned int, in order for the FIXPT logic to work correctly.
> >
> > And with that change in place the entire series appears to work correctly.
> >
> > My suggestion is to change the types of ths_tj_1 here, rcar_gen3_ths_tj_1
> > in rcar_gen3_thermal_probe(), and rcar_gen3_ths_tj_1 and
> > rcar_gen3_ths_tj_1_m3_w, which are gloabl to this file accordingly.
> 
> I understood. Why did I decide to use unsigned?
> I will fix it in v3.

Probably due to an earlier suggestion by me.
Sorry about that.

...

Could you post v3 with this fix and the changes suggested by Niklas
for patch 2/3?
