Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820FF727B94
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jun 2023 11:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjFHJhp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jun 2023 05:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFHJho (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jun 2023 05:37:44 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A655173A
        for <linux-pm@vger.kernel.org>; Thu,  8 Jun 2023 02:37:43 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bad010e1e50so496087276.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Jun 2023 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686217062; x=1688809062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k0aUfso+mqed718DXVZBOh7dWuv36gH3PMUsz0/Om4Y=;
        b=RR9fneaGbSjT8vSD0NNMv3dAoiwDN/Po6A7iO6KQqhAtQV7KeeXJIdW01wkDjczV27
         S/Q85c+80/41rffy1DjN7lKodqzjmCo+scaeyuBhQSs7G0D6JYcIhss3GXHW8imXsP60
         bg3KfGqWUsPQn8WY+lmaHOxAYItdjVdfOJWlY++3ZPY0woVVvgKhG00KB9jjtr1dpdTy
         bGJ5T5sDUJYnSMHNaNhCI4TR09T4Q3xpXhK8/uDmJ4+hB0p/aZEP4dwRe/PQJRoo6Jaq
         PXw5SSF77ZLkdzz5X+Ow9AUKnE21QtyvkHN4Jq55zrDNLiNIuztFDugBBeQpmWHG77O+
         1LMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217062; x=1688809062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0aUfso+mqed718DXVZBOh7dWuv36gH3PMUsz0/Om4Y=;
        b=cF0SnY4b9Pjqt5KFSgwoUdngJiZch3riO1CpBOln29bi8wxKltZR9rkhWzrBzIYao/
         l05PjXumImTr1NvuS2ZgFgUxDZEOjg6Ynt12P0NeMI7j8SP8QRcl+mbnZ61wJaOGbBuo
         jniTRYPGh1uwvYJ5BEglPYWcuUVsNvd/8SHDNHKAym/NFMr8SoeZ3L+3DoLzYTvauKDa
         kldFRLkQtSPmo2LqKEXaXsmK1DLXJfmpm5oWRoO6VcGrP/mwTMMb0nz4seqF+GoRASNI
         xTnJmcAe6P7hSG+NwJTtbA8tVljBLcd+D52yU9HRSXWNQGegeouPXPOWFHP91929GZyH
         PgFw==
X-Gm-Message-State: AC+VfDwaeBZQEqlSlc0QDk2BG/90movZpc8VqHQkCf64dinFVn1XDinE
        gu+qXKw005FU1UkDUp8+l1MCIn4++VXXBE86JoAmPA==
X-Google-Smtp-Source: ACHHUZ7ax+5DTFnXlFyad+qoF5ItYOEatii5YFpBjAQeo0J9NB8fvXLq0abd1Ja5JDM2gGgJeN3c9yi24RybtdjhXmk=
X-Received: by 2002:a81:5b8a:0:b0:561:e724:eb3 with SMTP id
 p132-20020a815b8a000000b00561e7240eb3mr9721264ywb.17.1686217062552; Thu, 08
 Jun 2023 02:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-14-ulf.hansson@linaro.org> <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
In-Reply-To: <20230608053446.ngoxh7zo7drnr32z@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 8 Jun 2023 11:37:06 +0200
Message-ID: <CAPDyKFqUWhdmctKRpQoqwZ2nsx_P2FiWvLzfm_d39QdECWoytA@mail.gmail.com>
Subject: Re: [PATCH 13/16] OPP: Extend dev_pm_opp_data with OPP provider support
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 8 Jun 2023 at 07:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 07-06-23, 14:46, Ulf Hansson wrote:
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 79b4b44ced3e..81a3418e2eaf 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1112,6 +1112,15 @@ static int _set_opp(struct device *dev, struct opp_table *opp_table,
> >                       return ret;
> >               }
> >
> > +             if (opp->provider == DEV_PM_OPP_TYPE_GENPD) {
> > +                     ret = dev_pm_genpd_set_performance_state(dev, opp->level);
> > +                     if (ret) {
> > +                             dev_err(dev, "Failed to set performance level: %d\n",
> > +                                     ret);
> > +                             return ret;
> > +                     }
> > +             }
> > +
>
> I don't like this :)
>
> We already have these calls in place from within _set_required_opps(), and we
> should try to get this done in a way that those calls themselves get the
> performance state configured.

I was looking at that, but wanted to keep things as simple as possible
in the $subject series.

The required opps are also different, as it's getting parsed from DT
both for the genpd provider and the consumer. The point is, there are
more code involved but just _set_required_opps().

For example, _set_performance_state() (which is the one that calls
dev_pm_genpd_set_performance_state()) is designed to be used for
required opps. Does it really make sense to rework
_set_performance_state() so it can be used for this case too, just to
avoid another call to dev_pm_genpd_set_performance_state() somewhere
in the code?

One improvement we can make though, is to add a helper function,
"_set_opp_level()", which we call from _set_opp(). This can then
replace the call to _set_required_opps() and the code above that I am
adding for DEV_PM_OPP_TYPE_GENPD. At least that should keep the code
_set_opp() a bit more readable.

What do you think?

Kind regards
Uffe
