Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404FF771DA
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfGZTIv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 15:08:51 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41870 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbfGZTIv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 15:08:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so56369745ota.8
        for <linux-pm@vger.kernel.org>; Fri, 26 Jul 2019 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qv/TYWK6NOYekEaLft+v7J5eS4Mf0pr3nYuBj6c8hlQ=;
        b=Qa7vSe1RB8VnZOGBb0s+Kj+fpIDyeE6S/eOwpwfNE4z9MOYNwqpVwrdVgJH3WTo6R2
         DUvJoADoLeswvTnOfIkZz29zTpMtaOUHAJbEC6boa+hc8cCAFuK7jnCqjmRsKuVsayJv
         XGc/OTQyUT8FIl/T4thWlWIb0cB6Vpsy+3ZNoggtUSk7qWfPNebILKpjDLxrq9RvGxTt
         qvCTlRo6Ods1D0ImSaDz5TGTQlNtzPORLqOTfxes56X7+qgfUM43q2cZkEAvoGWM5ykh
         UajSesiCEwB4DHkJy2IPmVd48UJbLbwKJiDD8AItzwacWT5OYOLRvykef0EgO4Sb7jkV
         Ny+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qv/TYWK6NOYekEaLft+v7J5eS4Mf0pr3nYuBj6c8hlQ=;
        b=ixYCGKLf+Y/ihO2G1IZYf4c2jZcniwHEOk99Pqu/hUxtNgfyMdQsjGoY7Sa8Ue2lKt
         YUHRkVAhSeU1YAK5shfldDQTR5Fx8C0R2IcUm4WOKXxlRQi7KgmXUsJqJw6JFwdvJ3CW
         yS+mGqRQbKjf39bNmWYr84wkF/n3cl5/jugYy73LIKnJNkVwoXNg1OOZy5lxKwKKHFiU
         v+jjAvLbV5nTTMYmQc2yetMbQZUkEzXrrpskY+MO/pfqD9m2eRogejWCZzsXado37LuH
         pA8VlabHYZQMVcxBTZDgs0mgfBeBzQalZiT0z+B92DZFNSRaQnGjIOoFIj3Bhlt3oyJ7
         nPPg==
X-Gm-Message-State: APjAAAWYrhWz2Z2aZPaWjsTYv0SSdIXNPz/ifovXBri9z58BKQFQQzV3
        bwEIqqxPPJ2vf3ugx0LaiiLOoFeaiDJbmgEPA0TA/Q==
X-Google-Smtp-Source: APXvYqwswxBkVVGVTDXag1cBSCnrtLh/NFlUrBDxo9q0yG5wk2PUY/8LeoOx+VOVO9FtYtjmDs9baSxZ1cuMp/QUZNo=
X-Received: by 2002:a9d:6201:: with SMTP id g1mr72758418otj.195.1564168129789;
 Fri, 26 Jul 2019 12:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190703011020.151615-1-saravanak@google.com> <20190703011020.151615-7-saravanak@google.com>
 <fde02417-dc72-acad-727d-452a3ae3cbd0@linaro.org>
In-Reply-To: <fde02417-dc72-acad-727d-452a3ae3cbd0@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 26 Jul 2019 12:08:13 -0700
Message-ID: <CAGETcx_y=6XJi-1YroB3wzMZ9UF1zunqPc4NLhEy0DdHJXYnNQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] interconnect: Add OPP table support for interconnects
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 26, 2019 at 9:25 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Saravana,
>
> On 7/3/19 04:10, Saravana Kannan wrote:
> > Interconnect paths can have different performance points. Now that OPP
> > framework supports bandwidth OPP tables, add OPP table support for
> > interconnects.
> >
> > Devices can use the interconnect-opp-table DT property to specify OPP
> > tables for interconnect paths. And the driver can obtain the OPP table for
> > an interconnect path by calling icc_get_opp_table().
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/interconnect/core.c  | 27 ++++++++++++++++++++++++++-
> >  include/linux/interconnect.h |  7 +++++++
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> > index 871eb4bc4efc..881bac80bc1e 100644
> > --- a/drivers/interconnect/core.c
> > +++ b/drivers/interconnect/core.c
> > @@ -47,6 +47,7 @@ struct icc_req {
> >   */
> >  struct icc_path {
> >       size_t num_nodes;
> > +     struct opp_table *opp_table;
>
> I am a bit worried that these tables might be abused and size of the DT will
> grow with many OPP tables of all existing paths.

A ton of stuff can be abused in downstream code. We can't do anything
about that.

We just need to keep an eye on OPP table abuse in upstream (whether it
frequency or bw OPP).

> >       struct icc_req reqs[];
> >  };
> >
> > @@ -313,7 +314,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
> >  {
> >       struct icc_path *path = ERR_PTR(-EPROBE_DEFER);
> >       struct icc_node *src_node, *dst_node;
> > -     struct device_node *np = NULL;
> > +     struct device_node *np = NULL, *opp_node;
> >       struct of_phandle_args src_args, dst_args;
> >       int idx = 0;
> >       int ret;
> > @@ -381,10 +382,34 @@ struct icc_path *of_icc_get(struct device *dev, const char *name)
> >               dev_err(dev, "%s: invalid path=%ld\n", __func__, PTR_ERR(path));
> >       mutex_unlock(&icc_lock);
> >
> > +     opp_node = of_parse_phandle(np, "interconnect-opp-table", idx);
>
> Can't we figure out if the device OPP table contains bandwidth even without this
> property?
>

Rob pointed out that the property isn't necessary because the device
binding should document which OPP table is used for what. That takes
care of my main concern of how do we know which OPP table is for what
path. So I'm dropping this patch.

-Saravana
