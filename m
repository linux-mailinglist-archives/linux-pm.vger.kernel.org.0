Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8746616D70
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 00:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEGWOu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 18:14:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41987 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGWOu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 May 2019 18:14:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id w23so12994550lfc.9
        for <linux-pm@vger.kernel.org>; Tue, 07 May 2019 15:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mFHlOpzADIsLrMHX2bCJUB1TTgI0AYRZ5LSjKxTsWv8=;
        b=iN/QF2cYDVLZHPrKeWMr/UiSOrZL2wO2/u7+gIWaQlrcPX5k/lOZJMoMyxbMhsINjX
         o/kk9wcuj74xiewm/PN9DnCIGa1cKH0N+0tsoiUvFKoui1xHYOu+6N7uqnfaURKuRekE
         yAaXW2P0oKF09OOnAcNoJPoZYthzIZKX3qxRgOCh6GusIgYjJIodVDCbrgxeIMfdSY0T
         VngU6u8u3yIAH4xzloHNa3sBvVth4mes4HsFlE6DOzm7L+XlOFe1QqnhMeqfDZqbIWhA
         C8ikZTi/3NqGLqrUiA9iIMJiEuMDYNLhDGS+dbYDBXDtjQ7/SZI2Wpz+x72PIM2X/ncc
         VGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mFHlOpzADIsLrMHX2bCJUB1TTgI0AYRZ5LSjKxTsWv8=;
        b=iEAdbVYZuLT4tiymanphpkIN65bCvyVF/9v0tJ4GMnOfCjQj2d5gem8MaZ0IdVn8hA
         6wxsAQe3Azj2DaeNnFnwCy593iYT7k2zh0sjuC2OupQ2AU6FBCoIgZuQdg7KtJ/0F+Vu
         mv/NqeAE4+Sqw6QMJLw2a8re0gqpO4OOUx3ciV9WLtbOAc8v77b9LQ0Xvbaai4MlbcoX
         r0pHwEjduzJlQR2EIMemV29PgCbWuzNW2fbY3XQm8R1srgUSIu+7l/vuqMj/7hYiYQUX
         CSGjeZCW3vXbkegCNdrwmOElA2XUleXBu8KpJP5SGccnrfo9D41VCk0cbwveltJbG0rh
         JVVg==
X-Gm-Message-State: APjAAAXrClKrUDKeVbEDlxXxs2RJtXKc6sWMVrnyAUBjpXXTzs+CUMuf
        U6J1e8FmDf7g0VxFGogDOyttOUiiA+4=
X-Google-Smtp-Source: APXvYqxYobQnx20Gdvpbk7T26X5A6p73Pw8k4/eFtH0prJyY57De4FlGE/wYJiCSLt4JsFDFnqWtpQ==
X-Received: by 2002:ac2:554a:: with SMTP id l10mr16320812lfk.45.1557267287737;
        Tue, 07 May 2019 15:14:47 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id v11sm3621141lfb.68.2019.05.07.15.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 15:14:46 -0700 (PDT)
Date:   Wed, 8 May 2019 00:14:46 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Simon Horman <horms@verge.net.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: Re: [PATCH repost] thermal: rcar_thermal: update calculation formula
 for E3
Message-ID: <20190507221446.GB16573@bigcity.dyn.berto.se>
References: <20190418071514.13027-1-horms+renesas@verge.net.au>
 <20190418081209.GT28515@bigcity.dyn.berto.se>
 <CAMuHMdVX5t-Q5tM5bj95muAZ+8+phohtQSsAO-rCeCofiqVMKQ@mail.gmail.com>
 <20190426095511.tkgbxkf43psesgkv@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190426095511.tkgbxkf43psesgkv@verge.net.au>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On 2019-04-26 11:55:11 +0200, Simon Horman wrote:
> On Wed, Apr 24, 2019 at 09:10:56AM +0200, Geert Uytterhoeven wrote:
> > Hi Niklas,
> > 
> > On Thu, Apr 18, 2019 at 10:12 AM Niklas Söderlund
> > <niklas.soderlund@ragnatech.se> wrote:
> > > On 2019-04-18 09:15:14 +0200, Simon Horman wrote:
> > > > From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > >
> > > > HW manual changes temperature calculation formula for E3:
> > >
> > > Is this not also true for V3M and D3?
> > >
> > > > - When CTEMP is less than 24
> > > >    T = CTEMP[5:0] * 5.5 - 72
> > > > - When CTEMP is equal to/greater than 24
> > > >    T = CTEMP[5:0] * 5 - 60
> > > >
> > > > This was inspired by a patch in the BSP by Van Do <van.do.xw@renesas.com>
> > > >
> > > > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > > > Tested-by: Simon Horman <horms+renesas@verge.net.au>
> > > > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > >  drivers/thermal/rcar_thermal.c | 11 ++++++++++-
> > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > > > index 97462e9b40d8..11df0cc63bed 100644
> > > > --- a/drivers/thermal/rcar_thermal.c
> > > > +++ b/drivers/thermal/rcar_thermal.c
> > > > @@ -52,6 +52,7 @@ struct rcar_thermal_chip {
> > > >       unsigned int irq_per_ch : 1;
> > > >       unsigned int needs_suspend_resume : 1;
> > > >       unsigned int nirqs;
> > > > +     unsigned int ctemp_bands;
> > >
> > > Would it be possible to rename this to something indicating that this is
> > > a gen3 thing? Maybe move it to the bit fields above and name it gen3 ?
> > 
> > Is that really a good thing to do? This structure describes features of
> > the thermal module, and we're already beyond the point where a simple
> > check  for gen2 or gen3 was sufficient.
> > Here the feature is having multiple temperature bands.
> > What if some other Gen3 SoC starts having 3 temperature bands?

Good point, after reviewing your comment I now agree with the original 
patch.

> > 
> > > > @@ -263,7 +267,12 @@ static int rcar_thermal_get_current_temp(struct rcar_thermal_priv *priv,
> > > >               return ret;
> > > >
> > > >       mutex_lock(&priv->lock);
> > > > -     tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > > > +     if (priv->chip->ctemp_bands == 1)
> > > > +             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > > > +     else if (priv->ctemp < 24)
> > > > +             tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> > > > +     else
> > > > +             tmp = MCELSIUS((priv->ctemp * 5) - 60);
> > >
> > > I confirm that the calculations here are correct, but hard to read ;-)
> > > With the rename about how about.
> > >
> > >     if (priv->chip->gen3) {
> > >         if (priv->ctemp < 24)
> > >                 tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> > >         else
> > >                 tmp = MCELSIUS((priv->ctemp * 5) - 60);
> > >     } else {
> > >             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> > >     }
> > 
> > _Iff_ we decide on going for the rename, I'd still write it as:
> > 
> >     if (!priv->chip->gen3)
> >             tmp =  MCELSIUS((priv->ctemp * 5) - 65);
> >     else if (priv->ctemp < 24)
> >             tmp = MCELSIUS(((priv->ctemp * 55) - 720) / 10);
> >     else
> >             tmp = MCELSIUS((priv->ctemp * 5) - 60);
> > 
> > Always fold your if/else if/else constructs to minimize the need for indentation
> > and braces ;-)
> 
> From my PoV I think the patch is fine in its current form.
> Niklas do you feel particularly strongly about changing it?

No I do not feel strongly about this and would be fine with the patch in 
it's current form. With and update commit message to mention V3M and D3 
feel free to add

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

-- 
Regards,
Niklas Söderlund
