Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963D53FE4EA
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245507AbhIAV2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhIAV2O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 17:28:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0777C061760
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 14:27:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id m28so1958274lfj.6
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 14:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kp1zZ8oUcZ6p8ZISnr0CfDT7SbmamrRkIp/MXGOiwqw=;
        b=uPkzSwtV0JCTtIeTfxOsy6gZjHoRBQvkjnf01PQsw4jqyCf5LwtG+3iHWbW6KEH2Yv
         WYFmanWj8ia18DAfha3fhlfSt7hvhLwNjW0re/0++RVDYgKp+UCJnFiwnYWpdm0vIz9o
         JGd14R96vucstjy663XgvEB7+goauNT++cuAmUlMQKnqsVVQdhpd7ZG+zo75FCEEozDg
         n+fvHpWHGvncvrrMAdawqgVr+z7PojFv5Wa7gllRnO/r7mMqX5Lav/GvmhnyqIZxd+e0
         4bpneRcGtzw/k8Imht0YP5gcB6JpjVXl3UzzbtF8IAgZhIfpW8Rr9bsqfOdKYPy/w8hP
         tGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kp1zZ8oUcZ6p8ZISnr0CfDT7SbmamrRkIp/MXGOiwqw=;
        b=GRREQEmFnDykmKSj8CzpdXMO7SZ5/X2CWuXcHAFyDjqHEgrzGd6KprtRKSy2t0FygX
         dClAgimd7cCmOcrCTDdGDNwT2WO+HfMR/KFwqeyTy/Z8nqlp9/sNpGiWEP7dv0LjsGgx
         tmUCsQxnoM5ulZmUrqogiuaoJNI2pIaM8xKYh7mTSaqT9Kcig+Gyzd2X81spnhf6hMql
         z+g0FF3b6vSQva81ERqNESIlEAcks2xAO38JlW9IjeI209Ml3HwJ2N72G2dFz11oULw0
         lL8gXXOVLrnJHEzSfMeoHsNWc5dL6TK4JhE3gAmMf5rpitVr0EHSxJhaBhPRdsY2NR76
         HL4w==
X-Gm-Message-State: AOAM533SqP3/ucFj3Dfou6UOAubXTOu/KHpljGUK8epX/y0fN7ToLDGW
        pW+ySCB8Z7lXnKapioOuwpbXweSKRo4eNlD2s9iLzA==
X-Google-Smtp-Source: ABdhPJw6FqjnM+BwCpR6avDzqjqcq19MYWghw6oY0nCvx9HKhKNeaYI5uAgum8g7fztPINA/pBN5yZWa2g8lPJugFHI=
X-Received: by 2002:a19:c107:: with SMTP id r7mr1096127lff.29.1630531635257;
 Wed, 01 Sep 2021 14:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102125.624661-1-ulf.hansson@linaro.org>
 <CAGETcx868QWj0jMJ+U-eL62jT-LO_LTOw5EcwEKptfFOVa=A5A@mail.gmail.com>
 <CAPDyKFopTW=ZoB9FYJ-ozRZTnJDTT_gFtz0XDiU-weYb1Q9bkQ@mail.gmail.com> <CAGETcx_e7kCQ_0yC9=k1jzjJJEqdOMuA=JkD81=2-Nb4fcS0+w@mail.gmail.com>
In-Reply-To: <CAGETcx_e7kCQ_0yC9=k1jzjJJEqdOMuA=JkD81=2-Nb4fcS0+w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Sep 2021 23:26:38 +0200
Message-ID: <CAPDyKFranX4Yz8546C1E3Gq_ZkQi34Xb=Rxi5mPtw-s_J1QPoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: property: fw_devlink: Rename 'node_not_dev' to 'optional_con_dev'
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 1 Sept 2021 at 22:56, Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Sep 1, 2021 at 12:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 31 Aug 2021 at 19:31, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > In the struct supplier_bindings the member 'node_not_dev' is described as
> > > > "The consumer node containing the property is never a device.", but that
> > > > doesn't match the behaviour of the code in of_link_property().
> > > >
> > > > To make the behaviour consistent with the description, let's rename the
> > > > member to "optional_con_dev" and clarify the corresponding comment.
> > > >
> > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > ---
> > > >  drivers/of/property.c | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > index 6c028632f425..2babb1807228 100644
> > > > --- a/drivers/of/property.c
> > > > +++ b/drivers/of/property.c
> > > > @@ -1249,7 +1249,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> > > >   * @parse_prop.index: For properties holding a list of phandles, this is the
> > > >   *                   index into the list
> > > >   * @optional: Describes whether a supplier is mandatory or not
> > > > - * @node_not_dev: The consumer node containing the property is never a device.
> > > > + * @optional_con_dev: The consumer node containing the property may not be a
> > > > + *                   device, then try finding one from an ancestor node.
> > >
> > > Nak. This flag is not about "may not be". This is explicitly for
> > > "never a device". It has to do with stuff like remote-endpoint which
> > > is never listed under the root node of the device node. Your
> > > documentation change is changing the meaning of the flag.
> >
> > Okay, fair enough.
> >
> > Although, as stated in the commit message this isn't the way code
> > behaves. Shouldn't we at least make the behaviour consistent with the
> > description of the 'node_not_dev' flag?
>
> I know what you mean, but if you use the flag correctly (where the
> phandle pointed to will never be a device with compatible property),
> the existing code would work correctly. And since the flag is relevant
> only in this file, it's easy to keep it correct. I'd just leave it as
> is.

Sorry, but that just sounds lazy to me, I am sure we can do better.
The current code and the name of the flag is confusing, at least to me
(and I bet to others as well).

Moreover, I don't quite understand your objections to changing this.
Why leave this to be inconsistent when it can be easily fixed?

>
> -Saravana

Kind regards
Uffe

>
>
> >
> > Along the lines of the below patch then?
> >
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Date: Wed, 1 Sep 2021 09:28:03 +0200
> > Subject: [PATCH] of: property: fw_devlink: Fixup behaviour when 'node_not_dev'
> >  is set
> >
> > In the struct supplier_bindings the member 'node_not_dev' is described as
> > "The consumer node containing the property is never a device.", but that is
> > inconsistent with the behaviour of the code in of_link_property(), as it
> > calls of_get_compat_node() that starts parsing for a compatible property,
> > starting from the node it gets passed to it.
> >
> > Make the behaviour consistent with the description of the 'node_not_dev'
> > flag, by passing the parent node to of_get_compat_node() instead.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/of/property.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 6c028632f425..16ee017884b8 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1075,6 +1075,17 @@ static struct device_node
> > *of_get_compat_node(struct device_node *np)
> >         return np;
> >  }
> >
> > +static struct device_node *of_get_compat_node_parent(struct device_node *np)
> > +{
> > +       struct device_node *parent, *node;
> > +
> > +       parent = of_get_parent(np);
> > +       node = of_get_compat_node(parent);
> > +       of_node_put(parent);
> > +
> > +       return node;
> > +}
> > +
> >  /**
> >   * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
> >   * @con_np: consumer device tree node
> > @@ -1416,7 +1427,7 @@ static int of_link_property(struct device_node
> > *con_np, const char *prop_name)
> >                         struct device_node *con_dev_np;
> >
> >                         con_dev_np = s->node_not_dev
> > -                                       ? of_get_compat_node(con_np)
> > +                                       ? of_get_compat_node_parent(con_np)
> >                                         : of_node_get(con_np);
> >                         matched = true;
> >                         i++;
> > --
> > 2.25.1
> >
> > [...]
> >
> > Kind regards
> > Uffe
