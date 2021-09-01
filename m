Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5843FE56F
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 00:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbhIAWZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 18:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhIAWZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Sep 2021 18:25:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62735C061757
        for <linux-pm@vger.kernel.org>; Wed,  1 Sep 2021 15:24:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k13so2266960lfv.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Sep 2021 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSrqC262T8NUB0z+G7cuqZyTjDbbZ5eGxKOQFITyM2E=;
        b=qDwLQhGYrB22soJfUXno1pdMrJzN5jRG3UZDfmRzLVIwRWnWqqHVi0xA7kLs8nQ334
         d1oSpSTNnBfIIdS4HqOva/pJLn0cN3u1tc18c51cdLnIRrLDO7TbQ1mCAxs2VFaJQ45V
         +6l4DEYv/X11vTi+Xj/kd57zxlsM2p7KL7oFz8RIwlWH+kPC9thWnPINiq2JS2Cq8rtl
         N0sWY8K3EYwpzAAr+H4ongTLXJ6+J/kbwOHmDqGmfKEnydSo318QNn5YaPFLFYJz3G3c
         9f+w2z5McF0PqOPiD5spGZD5b4/AIIc8MKCn7hSmKV35EZy4kwjzWC+UIm9ewMx1e5ts
         4EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSrqC262T8NUB0z+G7cuqZyTjDbbZ5eGxKOQFITyM2E=;
        b=JPZxDS9QmHnWTl0KZQDNMxAQPhsmKrWNdocuMr3aDYhLy2bYeOkyEz3eEIVyzm73SU
         5NCsRLvWPoKxnBjkfcAxw8Cm06t8zQaU4lxjLebubfOnxIrnse50Fq+4gdfvUdZcrE6e
         U/Ly9AoFRMmopvNMtuTK357yB13JmIvPOWdOwy5usz/bjNc74kHMTASOixN3QY4956Nw
         80VFiCqO8QyHuj88DybrLD2XTzJkDXHerbXNc9LT6MiiyNK9Jb/UzF7kF1IfEKyvV4pB
         J7yyKkPzdQ8RG1D2hdVDOk7vXe53kVbeQ2y3ap1HOD6WCu/Iq1YiLMFTH9T1CaIhpJCO
         ObcQ==
X-Gm-Message-State: AOAM532D2oH9EM2QWXGVWbhfVmQrLOvyJt+fEazb3hAqPaAvNuVGUeRK
        bFI0TrdpS/FnMs1gtDL4lmcwlxpfwXCLVNAq9hCZxdytz0Lx7ZNA
X-Google-Smtp-Source: ABdhPJwaH2UrQbVfXnJ0/QOMt3tqghHniLDTR5CwcH12OP3qXxrOU7CX/i5jcRi/yQWAP41gIFamBwg5xYS3nqwI4Vo=
X-Received: by 2002:a19:655e:: with SMTP id c30mr81611lfj.142.1630535080753;
 Wed, 01 Sep 2021 15:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210831102125.624661-1-ulf.hansson@linaro.org>
 <CAGETcx868QWj0jMJ+U-eL62jT-LO_LTOw5EcwEKptfFOVa=A5A@mail.gmail.com>
 <CAPDyKFopTW=ZoB9FYJ-ozRZTnJDTT_gFtz0XDiU-weYb1Q9bkQ@mail.gmail.com>
 <CAGETcx_e7kCQ_0yC9=k1jzjJJEqdOMuA=JkD81=2-Nb4fcS0+w@mail.gmail.com>
 <CAPDyKFranX4Yz8546C1E3Gq_ZkQi34Xb=Rxi5mPtw-s_J1QPoQ@mail.gmail.com> <CAGETcx_DXQyaH2te1cxV+yCS+kdfjWOFbxQkhEKCbXtU0FWS1g@mail.gmail.com>
In-Reply-To: <CAGETcx_DXQyaH2te1cxV+yCS+kdfjWOFbxQkhEKCbXtU0FWS1g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Sep 2021 00:24:04 +0200
Message-ID: <CAPDyKFpd1OCiSX-g4sJNjHhLs41AVzyE=O7gw7+YQ7RUOOk6rQ@mail.gmail.com>
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

On Thu, 2 Sept 2021 at 00:06, Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Sep 1, 2021 at 2:27 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 1 Sept 2021 at 22:56, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Wed, Sep 1, 2021 at 12:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Tue, 31 Aug 2021 at 19:31, Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > On Tue, Aug 31, 2021 at 3:21 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > > >
> > > > > > In the struct supplier_bindings the member 'node_not_dev' is described as
> > > > > > "The consumer node containing the property is never a device.", but that
> > > > > > doesn't match the behaviour of the code in of_link_property().
> > > > > >
> > > > > > To make the behaviour consistent with the description, let's rename the
> > > > > > member to "optional_con_dev" and clarify the corresponding comment.
> > > > > >
> > > > > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > ---
> > > > > >  drivers/of/property.c | 9 +++++----
> > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > > > > index 6c028632f425..2babb1807228 100644
> > > > > > --- a/drivers/of/property.c
> > > > > > +++ b/drivers/of/property.c
> > > > > > @@ -1249,7 +1249,8 @@ static struct device_node *parse_##fname(struct device_node *np,       \
> > > > > >   * @parse_prop.index: For properties holding a list of phandles, this is the
> > > > > >   *                   index into the list
> > > > > >   * @optional: Describes whether a supplier is mandatory or not
> > > > > > - * @node_not_dev: The consumer node containing the property is never a device.
> > > > > > + * @optional_con_dev: The consumer node containing the property may not be a
> > > > > > + *                   device, then try finding one from an ancestor node.
> > > > >
> > > > > Nak. This flag is not about "may not be". This is explicitly for
> > > > > "never a device". It has to do with stuff like remote-endpoint which
> > > > > is never listed under the root node of the device node. Your
> > > > > documentation change is changing the meaning of the flag.
> > > >
> > > > Okay, fair enough.
> > > >
> > > > Although, as stated in the commit message this isn't the way code
> > > > behaves. Shouldn't we at least make the behaviour consistent with the
> > > > description of the 'node_not_dev' flag?
> > >
> > > I know what you mean, but if you use the flag correctly (where the
> > > phandle pointed to will never be a device with compatible property),
> > > the existing code would work correctly. And since the flag is relevant
> > > only in this file, it's easy to keep it correct. I'd just leave it as
> > > is.
> >
> > Sorry, but that just sounds lazy to me, I am sure we can do better.
> > The current code and the name of the flag is confusing, at least to me
> > (and I bet to others as well).
> >
> > Moreover, I don't quite understand your objections to changing this.
> > Why leave this to be inconsistent when it can be easily fixed?
>
> If you feel so strong about it, go for it. No strong objections. Just
> double check the refcounts are done correctly.

The refcounts should be okay, I think.

I am fine with either of the two suggestions I have made. But another
option could be to come up with an alternative name (and a
description) for the flag, instead of "optional_con_dev", if you
perhaps have a better suggestion?

>
> -Saravana

Kind regards
Uffe
