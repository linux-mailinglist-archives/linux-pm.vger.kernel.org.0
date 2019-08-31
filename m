Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44F2A4321
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfHaHkV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 03:40:21 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:47636 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfHaHkV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 03:40:21 -0400
Received: from penelope.horms.nl (ip4dab7138.direct-adsl.nl [77.171.113.56])
        by kirsty.vergenet.net (Postfix) with ESMTPA id B3F8F25AE77;
        Sat, 31 Aug 2019 17:40:18 +1000 (AEST)
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 92FBBE218F0; Sat, 31 Aug 2019 09:40:16 +0200 (CEST)
Date:   Sat, 31 Aug 2019 09:40:16 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nathan Huckleberry <nhuck@google.com>, edubezval@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] thermal: rcar_gen3_thermal: Fix Wshift-negative-value
Message-ID: <20190831074016.nqjtvqf3lesyz77z@verge.net.au>
References: <20190613211228.34092-1-nhuck@google.com>
 <fd8b8a48-dfb7-1478-2d8d-0953acee39d3@linaro.org>
 <82458318837ed1154a183be0b96337fc7809c645.camel@intel.com>
 <20190829131124.GA2437@kunai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829131124.GA2437@kunai>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 29, 2019 at 03:11:24PM +0200, Wolfram Sang wrote:
> On Wed, Aug 28, 2019 at 04:52:20PM +0800, Zhang Rui wrote:
> > On Fri, 2019-06-14 at 12:52 +0200, Daniel Lezcano wrote:
> > > Hi Nathan,
> > > 
> > > On 13/06/2019 23:12, Nathan Huckleberry wrote:
> > > > Clang produces the following warning
> > > > 
> > > > vers/thermal/rcar_gen3_thermal.c:147:33: warning: shifting a
> > > > negative
> > > > signed value is undefined [-Wshift-negative-value] / (ptat[0] -
> > > > ptat[2])) +
> > > > FIXPT_INT(TJ_3); ^~~~~~~~~~~~~~~
> > > > drivers/thermal/rcar_gen3_thermal.c:126:29
> > > > note: expanded from macro 'FIXPT_INT' #define FIXPT_INT(_x) ((_x)
> > > > <<
> > > > FIXPT_SHIFT) ~~~~ ^ drivers/thermal/rcar_gen3_thermal.c:150:18:
> > > > warning:
> > > > shifting a negative signed value is undefined [-Wshift-negative-
> > > > value]
> > > > tsc->tj_t - FIXPT_INT(TJ_3)); ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
> > > > 
> > > > Upon further investigating it looks like there is no real reason
> > > > for
> > > > TJ_3 to be -41. Usages subtract -41, code would be cleaner to just
> > > > add.
> > > 
> > > All the code seems broken regarding the negative value shifting as
> > > the
> > > macros pass an integer:
> > > 
> > > eg.
> > >         tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> > >                                  tsc->tj_t - FIXPT_INT(ths_tj_1));
> > > 
> > > thcode[1] is always < than thcode[0],
> > > 
> > > thcode[1] - thcode[0] < 0
> > > 
> > > FIXPT_INT(thcode[1] - thcode[0]) is undefined
> > > 
> > > 
> > > Is it done on purpose FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]) ?
> > > 
> > > Try developing the macro with the coef.a2 computation ...
> > > 
> > > The code quality of this driver could be better, it deserves a rework
> > > IMHO ...
> > > 
> > > I suggest to revert:
> > > 
> > > 4eb39f79ef443fa566d36bd43f1f578d5c140305
> > > bdc4480a669d476814061b4da6bb006f7048c8e5
> > > 6a310f8f97bb8bc2e2bb9db6f49a1b8678c8d144
> > > 
> > > Rework the coefficient computation and re-introduce what was reverted
> > > in
> > > a nicer way.
> > 
> > Sounds reasonable to me.
> > 
> > Yoshihiro,
> > can you please clarify on this? Or else I will revert the above commits
> > first?
> > 
> > Also CC Wolfram Sang, the driver author.
> 
> CCing Simon Horman who worked with Kaneko-san on these changes.

Hi,

I think that what has happened here is that these patches and moreover the
driver has been through quite a few hands and I agree that zooming out and
cleaning things up would make a lot of sense.  Personally I would take the
approach of incrementally cleaning things up.  But I don't feel strongly
about this.

As for the specific question about a negative constant, I don't know of a
specific reason that approach was taken and I don't recall investigating it
at the time.

Kind regards,
Simon

> 
> > thanks,
> > rui
> > > 
> > > 
> > > > Fixes: 4eb39f79ef44 ("thermal: rcar_gen3_thermal: Update value of
> > > > Tj_1")
> > > > Cc: clang-built-linux@googlegroups.com
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/531
> > > > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> > > > ---
> > > >  drivers/thermal/rcar_gen3_thermal.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/thermal/rcar_gen3_thermal.c
> > > > b/drivers/thermal/rcar_gen3_thermal.c
> > > > index a56463308694..f4b4558c08e9 100644
> > > > --- a/drivers/thermal/rcar_gen3_thermal.c
> > > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > > @@ -131,7 +131,7 @@ static inline void
> > > > rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> > > >  #define RCAR3_THERMAL_GRAN 500 /* mili Celsius */
> > > >  
> > > >  /* no idea where these constants come from */

Regarding the line above, I believe the constant comes
from the documentation.

> > > > -#define TJ_3 -41
> > > > +#define TJ_3 41
> > > >  
> > > >  static void rcar_gen3_thermal_calc_coefs(struct
> > > > rcar_gen3_thermal_tsc *tsc,
> > > >  					 int *ptat, const int *thcode,
> > > > @@ -144,11 +144,11 @@ static void
> > > > rcar_gen3_thermal_calc_coefs(struct rcar_gen3_thermal_tsc *tsc,
> > > >  	 * the dividend (4095 * 4095 << 14 > INT_MAX) so keep it
> > > > unscaled
> > > >  	 */
> > > >  	tsc->tj_t = (FIXPT_INT((ptat[1] - ptat[2]) * 157)
> > > > -		     / (ptat[0] - ptat[2])) + FIXPT_INT(TJ_3);
> > > > +		     / (ptat[0] - ptat[2])) - FIXPT_INT(TJ_3);
> > > >  
> > > >  	tsc->coef.a1 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[2]),
> > > > -				 tsc->tj_t - FIXPT_INT(TJ_3));
> > > > -	tsc->coef.b1 = FIXPT_INT(thcode[2]) - tsc->coef.a1 * TJ_3;
> > > > +				 tsc->tj_t + FIXPT_INT(TJ_3));
> > > > +	tsc->coef.b1 = FIXPT_INT(thcode[2]) + tsc->coef.a1 * TJ_3;
> > > >  
> > > >  	tsc->coef.a2 = FIXPT_DIV(FIXPT_INT(thcode[1] - thcode[0]),
> > > >  				 tsc->tj_t - FIXPT_INT(ths_tj_1));
> > > > 
> > > 
> > > 
> > 


