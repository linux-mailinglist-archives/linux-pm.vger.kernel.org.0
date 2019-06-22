Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388244F851
	for <lists+linux-pm@lfdr.de>; Sat, 22 Jun 2019 23:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfFVVmQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Jun 2019 17:42:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34597 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFVVmQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Jun 2019 17:42:16 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5so9828683otk.1
        for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2019 14:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sA7VtGDWxs1PvSfqLqhiT/lLON+GJR9IC0w/w0nnIBM=;
        b=D1cL17iXU3Cpd4uakFKBHIz8GMmCUH5nrcvqcDGaon2xlXNfslYTXhkTtRifrfVG/Z
         G3YYQXFKfq/+Dzt6rVrp1JNi0dLGFgYpyQfX92jwIdyFFRA4EhB8/6pytGmN8emCTaz2
         dHCumVKE9pU4EMrF8d+UvZG0Zn8kl4ol0gtTlfQnk5ahVtCY/D3mSFoM2ZQfAvnt6nie
         20oM8ReSSzw4+m1p7ATYl23pNdKay5szlUme+U+O32iMW9x/3sYPUqw7+hLBVOIT4FCr
         qCD6JZCSHHdmlu8DsAD38HOW8qHTyZcrVH361/E+ThQK36QMPfbZibbr5pfFWXfljSSh
         STQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sA7VtGDWxs1PvSfqLqhiT/lLON+GJR9IC0w/w0nnIBM=;
        b=BqZNpurVUvXUT6cyHgO0lYoKJ3yHBcnNsTBOq3lmmyMMIGn2Z+Dq0hMnL22AehEThx
         b1kL8d2P7M3185NB6coCV6EuEOzpY8EF/+FHjlJ1VtReS+HUvrpB6cM6pOKgOTOSF8Gb
         98gAOh69e9S7G53ERLnfcvyIomvzKQ2U9xO7GJUsp+90B2xoLwLNh3y+webyBsPzzcgY
         j1qGJu7qmms/a/NZreg/j/F5C2/G8BMhLsp955noDBczkmwa/J7Be5vMI3MuUp5GZW4Y
         BqsW65Bz4d33q3gXD5c66O159MJZn4uVjYPUnsIrlsEuynuY4Qc79qMHlozjFb2itUhu
         rT9g==
X-Gm-Message-State: APjAAAV8B05jUx8VQS9FsKRPKUBPp5N0J5M/JNQKi2kVgGQctM01PB96
        LPtVEQ5UNktz59xYu3AT3lyoF5ZE4zpLyVntNoL8rA==
X-Google-Smtp-Source: APXvYqw1/VjNqqLNPPsWgbEg0uYYz6v4taHFtKPb4IB3PluWVhoRJoIluqDxel0TkBM5NJ24l3ImDzXl+daUjAUK8X0=
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr21774228otr.231.1561239734747;
 Sat, 22 Jun 2019 14:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-3-saravanak@google.com>
 <CAGTfZH18SQXj_2TpUf7iQPzWrZ5RP8-OCb_t6fp7qhuutGWz5A@mail.gmail.com>
In-Reply-To: <CAGTfZH18SQXj_2TpUf7iQPzWrZ5RP8-OCb_t6fp7qhuutGWz5A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 22 Jun 2019 14:41:39 -0700
Message-ID: <CAGETcx9Gi24bng_PCqc6=9S584va4hRc4HHZtBLevKHgYGSNDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] OPP: Add function to look up required OPP's for a
 given OPP
To:     cwchoi00@gmail.com
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Jun 22, 2019 at 4:50 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Hi,
>
> Absolutely, I like this approach. I think that it is necessary to make
> the connection
> between frequencies of devices.

Happy to hear that.

> But, I have a question on below.
>
> 2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:35,=
 Saravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > Add a function that allows looking up required OPPs given a source OPP
> > table, destination OPP table and the source OPP.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_opp.h | 11 +++++++++
> >  2 files changed, 65 insertions(+)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 74c7bdc6f463..4f7870bffbf8 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1830,6 +1830,60 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_ta=
ble *opp_table,
> >                 dev_err(virt_dev, "Failed to find required device entry=
\n");
> >  }
> >
> > +/**
> > + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> > + * @src_table: OPP table which has dst_table as one of its required OP=
P table.
> > + * @dst_table: Required OPP table of the src_table.
> > + * @pstate: OPP of the src_table.
> > + *
> > + * This function returns the OPP (present in @dst_table) pointed out b=
y the
> > + * "required-opps" property of the OPP (present in @src_table).
> > + *
> > + * The callers are required to call dev_pm_opp_put() for the returned =
OPP after
> > + * use.
> > + *
> > + * Return: destination table OPP on success, otherwise NULL on errors.
> > + */
> > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> > +                                       struct opp_table *dst_table,
> > +                                       struct dev_pm_opp *src_opp)
> > +{
> > +       struct dev_pm_opp *opp, *dest_opp =3D NULL;
> > +       int i;
> > +
> > +       if (!src_table || !dst_table || !src_opp)
> > +               return NULL;
> > +
> > +       for (i =3D 0; i < src_table->required_opp_count; i++) {
> > +               if (src_table->required_opp_tables[i]->np =3D=3D dst_ta=
ble->np)
> > +                       break;
> > +       }
> > +
> > +       if (unlikely(i =3D=3D src_table->required_opp_count)) {
> > +               pr_err("%s: Couldn't find matching OPP table (%p: %p)\n=
",
> > +                      __func__, src_table, dst_table);
> > +               return NULL;
> > +       }
> > +
> > +       mutex_lock(&src_table->lock);
> > +
> > +       list_for_each_entry(opp, &src_table->opp_list, node) {
> > +               if (opp =3D=3D src_opp) {
> > +                       dest_opp =3D opp->required_opps[i];
>
> Correct me if I am wrong. This patch assume that 'i' index is same on bet=
ween
> [1] and [2]. But in order to guarantee this assumption, all OPP entries
> in the same opp_table have to have the same number of 'required-opps' pro=
perties
> and keep the sequence among 'required-opps' entries.
>
> [1] src_table->required_opp_tables[i]->np
> [2] opp->required_opps[I];
>
> For example, three OPP entries in the 'parent_bus_opp'
> have the different sequence of 'required-opps' and the different
> number of 'required-opps'. Is it no problem?
>
> parent_bus_opp: opp_table {
>     compatible =3D "operating-points-v2";
>
>     opp2 {
>         opp-hz =3D /bits/ 64 <200000>;
>         required-opps =3D <&child_bus_a_opp2>, <&child_bus_b_opp2>,
> <&child_bus_c_opp2>;
>     };
>
>     opp1 {
>         opp-hz =3D /bits/ 64 <200000>;
>         // change the sequence between child_bus_b_opp2  and child_bus_c_=
opp2
>         required-opps =3D <&child_bus_a_opp2>, <&child_bus_c_opp2>,
> <&child_bus_b_opp2>
>     };
>
>     opp0 {
>         opp-hz =3D /bits/ 64 <200000>;
>         // missing 'child_bus_a_opp2'
>         required-opps =3D <&child_bus_c_opp2>, <&child_bus_b_opp2>
>     };
>
> }
>

I get your question. If I'm not mistaken the OPP framework DT parsing
code makes the assumption that the required-opps list has the phandles
in the same order for each "row" in the OPP table. It actually only
looks at the first OPP entry to figure out the list of required OPP
tables.

Technically one can write code to deal with random order of the
required-opp list, but doesn't seem like that's worth it because
there's no need to have that order all mixed up in DT. And even if
someone wants to add support for that, I don't think improving the DT
parsing to handle random order would be part of this patch series.

-Saravana

> --
> Best Regards,
> Chanwoo Choi
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
