Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFA24FA75
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 08:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFWGI3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 02:08:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46006 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWGI3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 02:08:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id x21so10300171otq.12
        for <linux-pm@vger.kernel.org>; Sat, 22 Jun 2019 23:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t66uufAvHwNJ/mkUxfXbz8ahwnbdl74aYVV8PvMIZnc=;
        b=q2+Ct4cQw9v/LZaOeQ/lailHsuEiy720D2+4qPuaGO1TE8ZpbTFPR1Gki4+QGUe8E2
         q7W2emrijsQa3jXl5lzapbVpfxywuOikaQ/Wwt9vcyEUOikwusSHJQE1bqYGvJotwcT/
         nfC050jTGsFgmkw17oKMW+MIAyjiBo1ytm/uyMxYSBPB6NguRYvubMprYrQTpaoAURYU
         mnrkXncyi/kp00Q7lCdaCmYoK5+m83NbBnz2kaag1OlM7lQc/X2j/1oJfihMjGn3qGhk
         PrETQs3QIHK/UR5GrU2Xr0UlakPvMIh0HFfpehjdI37qE9bdSGzAX4OesQ5Pe1xp7+qE
         +uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t66uufAvHwNJ/mkUxfXbz8ahwnbdl74aYVV8PvMIZnc=;
        b=I35Qd9EgdZEHUE0vnmDPXx2WQZEE6qdmLm7g2yNV1jr3/66JwGZfuzBIQVJtIG/TPW
         Kda0O452Yw9OBJoXWNXzVbTCObfyazjAgnEkFnoJNltD/dsUezZJ5V8GwMRnJu1aJCds
         VFcb3TyOEeLG5l2DfkqLGxisHurv9cZc8pk7WROfa5IBr1DvYftdEt/60oMm8nS+UUPS
         Ve9B5VdQMyQZde/V6RDOmEUk51Ux63wnLZ6n/B4CvzPXb/UnQt89nk3p6xcnEWxWpdlh
         2UO7HwJWaUUqqY9ZutEqLUKm9yu7kLvgYljvlcXweLCoeXEjZAg+j7DVMfJT+Dga/74j
         30oA==
X-Gm-Message-State: APjAAAUCphhsMzGUUCi+yR+onwroGJc6nzTo2av6jH/Y6AvphdhxMpyP
        74VNo1r/EQtiLBw1L+fT1PkpAbhalDNxEdwRfr3JmQ==
X-Google-Smtp-Source: APXvYqzHVupEZBMDy7vnNmLi25Ycu/dH3MwZDz7vnub91oBB6CPtLFFSRpZ6imTuNJ1viuD1domTSfvseOopmRMjC74=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr19523334ota.139.1561270108041;
 Sat, 22 Jun 2019 23:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-3-saravanak@google.com>
 <CAGTfZH18SQXj_2TpUf7iQPzWrZ5RP8-OCb_t6fp7qhuutGWz5A@mail.gmail.com>
 <CAGETcx9Gi24bng_PCqc6=9S584va4hRc4HHZtBLevKHgYGSNDA@mail.gmail.com> <CAGTfZH2jK8s=5d_R7=kbUsPwE6s3fmz2_srZVyr32EU5qcB07Q@mail.gmail.com>
In-Reply-To: <CAGTfZH2jK8s=5d_R7=kbUsPwE6s3fmz2_srZVyr32EU5qcB07Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 22 Jun 2019 23:07:52 -0700
Message-ID: <CAGETcx9VcJ-vS_Xjy0EwYC4mdf8BnK1F2Wi6a6cSsuZrinEm6Q@mail.gmail.com>
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

On Sat, Jun 22, 2019 at 9:28 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Hi,
>
> 2019=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 6:42,=
 Saravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > On Sat, Jun 22, 2019 at 4:50 AM Chanwoo Choi <cwchoi00@gmail.com> wrote=
:
> > >
> > > Hi,
> > >
> > > Absolutely, I like this approach. I think that it is necessary to mak=
e
> > > the connection
> > > between frequencies of devices.
> >
> > Happy to hear that.
> >
> > > But, I have a question on below.
> > >
> > > 2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9=
:35, Saravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
> > > >
> > > > Add a function that allows looking up required OPPs given a source =
OPP
> > > > table, destination OPP table and the source OPP.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++=
++++
> > > >  include/linux/pm_opp.h | 11 +++++++++
> > > >  2 files changed, 65 insertions(+)
> > > >
> > > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > > index 74c7bdc6f463..4f7870bffbf8 100644
> > > > --- a/drivers/opp/core.c
> > > > +++ b/drivers/opp/core.c
> > > > @@ -1830,6 +1830,60 @@ void dev_pm_opp_put_genpd_virt_dev(struct op=
p_table *opp_table,
> > > >                 dev_err(virt_dev, "Failed to find required device e=
ntry\n");
> > > >  }
> > > >
> > > > +/**
> > > > + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> > > > + * @src_table: OPP table which has dst_table as one of its require=
d OPP table.
> > > > + * @dst_table: Required OPP table of the src_table.
> > > > + * @pstate: OPP of the src_table.
> > > > + *
> > > > + * This function returns the OPP (present in @dst_table) pointed o=
ut by the
> > > > + * "required-opps" property of the OPP (present in @src_table).
> > > > + *
> > > > + * The callers are required to call dev_pm_opp_put() for the retur=
ned OPP after
> > > > + * use.
> > > > + *
> > > > + * Return: destination table OPP on success, otherwise NULL on err=
ors.
> > > > + */
> > > > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_tabl=
e,
> > > > +                                       struct opp_table *dst_table=
,
> > > > +                                       struct dev_pm_opp *src_opp)
> > > > +{
> > > > +       struct dev_pm_opp *opp, *dest_opp =3D NULL;
> > > > +       int i;
> > > > +
> > > > +       if (!src_table || !dst_table || !src_opp)
> > > > +               return NULL;
> > > > +
> > > > +       for (i =3D 0; i < src_table->required_opp_count; i++) {
> > > > +               if (src_table->required_opp_tables[i]->np =3D=3D ds=
t_table->np)
> > > > +                       break;
> > > > +       }
> > > > +
> > > > +       if (unlikely(i =3D=3D src_table->required_opp_count)) {
> > > > +               pr_err("%s: Couldn't find matching OPP table (%p: %=
p)\n",
> > > > +                      __func__, src_table, dst_table);
> > > > +               return NULL;
> > > > +       }
> > > > +
> > > > +       mutex_lock(&src_table->lock);
> > > > +
> > > > +       list_for_each_entry(opp, &src_table->opp_list, node) {
> > > > +               if (opp =3D=3D src_opp) {
> > > > +                       dest_opp =3D opp->required_opps[i];
> > >
> > > Correct me if I am wrong. This patch assume that 'i' index is same on=
 between
> > > [1] and [2]. But in order to guarantee this assumption, all OPP entri=
es
> > > in the same opp_table have to have the same number of 'required-opps'=
 properties
> > > and keep the sequence among 'required-opps' entries.
> > >
> > > [1] src_table->required_opp_tables[i]->np
> > > [2] opp->required_opps[I];
> > >
> > > For example, three OPP entries in the 'parent_bus_opp'
> > > have the different sequence of 'required-opps' and the different
> > > number of 'required-opps'. Is it no problem?
> > >
> > > parent_bus_opp: opp_table {
> > >     compatible =3D "operating-points-v2";
> > >
> > >     opp2 {
> > >         opp-hz =3D /bits/ 64 <200000>;
> > >         required-opps =3D <&child_bus_a_opp2>, <&child_bus_b_opp2>,
> > > <&child_bus_c_opp2>;
> > >     };
> > >
> > >     opp1 {
> > >         opp-hz =3D /bits/ 64 <200000>;
> > >         // change the sequence between child_bus_b_opp2  and child_bu=
s_c_opp2
> > >         required-opps =3D <&child_bus_a_opp2>, <&child_bus_c_opp2>,
> > > <&child_bus_b_opp2>
> > >     };
> > >
> > >     opp0 {
> > >         opp-hz =3D /bits/ 64 <200000>;
> > >         // missing 'child_bus_a_opp2'
> > >         required-opps =3D <&child_bus_c_opp2>, <&child_bus_b_opp2>
> > >     };
> > >
> > > }
> > >
> >
> > I get your question. If I'm not mistaken the OPP framework DT parsing
> > code makes the assumption that the required-opps list has the phandles
> > in the same order for each "row" in the OPP table. It actually only
> > looks at the first OPP entry to figure out the list of required OPP
> > tables.
>
> Thanks for description. It is the limitation of 'required-opps' until now=
.
>
> >
> > Technically one can write code to deal with random order of the
> > required-opp list, but doesn't seem like that's worth it because
> > there's no need to have that order all mixed up in DT. And even if
> > someone wants to add support for that, I don't think improving the DT
> > parsing to handle random order would be part of this patch series.
>
> I understand the existing ' required-opps' only consider the same sequenc=
e
> of entries which are included in the same OPP table.
>
> One more thing, 'required-opps' properties doesn't support
> the other OPP enters of the different OPP table. Is it right of 'required=
-opps'?

Not sure I fully understand the question.

> Except for the random order, just each OPP might will requires
> the different 'required-opps' of different OPP table. Even if it is
> not related to random order, I think that this approach cannot
> support them.
>
> For example as following:
> - opp2 used the OPP entries of 'child_bus_A' and 'child_bus_B' opp-table.
> - opp1 used the OPP entries of 'child_bus_C' and 'child_bus_D' opp-table.
>
> parent_bus_opp: opp_table {
>     compatible =3D "operating-points-v2";
>
>      opp2 {
>          opp-hz =3D /bits/ 64 <200000>;

I'm guessing this is a typo and let's assume you meant to sat 400000

>          required-opps =3D <&child_bus_A_opp2>, <&child_bus_B_opp2>;
>     };
>
>    opp1 {
>          opp-hz =3D /bits/ 64 <200000>;
>          required-opps =3D <&child_bus_C_opp0>, <&child_bus_D_opp0>;
>     };
> };

Is this a real use case? If it is, in reality parent_bus_opp_table
always has requirements on all 4 children bus, just that opp1 is okay
with the lowest frequency for some of the children?

So, in this example, you just need to always list all 4 child OPPs for
each parent OPP. And some of the children OPP values might not change
when going from one parent OPP to another.

-Saravana
