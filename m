Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB104F9DD
	for <lists+linux-pm@lfdr.de>; Sun, 23 Jun 2019 06:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725294AbfFWE2f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 00:28:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39957 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfFWE2f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 00:28:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so9419422ljh.7;
        Sat, 22 Jun 2019 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Oo9cNc82J3NB8Wf3wFWueRKXEdY5g8r6dw07fnu/otY=;
        b=VjEcrtZADQrkDe4car+3l/WpE1pNXOzWsdS09GNpkkT9K6tPPsdgi10MVkSKUluMHC
         xkNBUDeg+KHRQI6QI5HPAx9JY1CLbqFp66QDbyZwU2+BYeJd9rnsMU/KzFo+nJ7G5WEv
         65NrbEkIU5b1uz7mEwG6RQlEzac88NnaKfkFoa+xXI4CYVuFpm4L4lWj5eBl91lwSm+f
         OK1clB0O+DNo1Yb9YAnOlxWLgoXktfqX3YhFfIQWXFQaHvC+CXZt8MdHQJG399V/NYz5
         6ibUJ3yDNd8EjmHDQv9xL5fcwUWQPiTKBiV1oafGo/qK8k9DJ/sPu5sx5/eVv5VR2wyT
         0l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Oo9cNc82J3NB8Wf3wFWueRKXEdY5g8r6dw07fnu/otY=;
        b=RfNFIo2CfEOLk6EKkII1W8sYMB5nZBD58tgpBsBu+5911JTXTkNl9PzuwDTnZs/Zxf
         ZuRGN1QaxeQj/TGMQnpzrf6oNYMxhvRmZphwrfsMJNePO/Lp4WU1gF8LleLwSDB5rBZs
         CrWINeOC1vGadfaJw8lH4z1Pg080ojHpqFffLzBlLjoiF7LC7lTIJpDh5R7x4xsqBUr2
         zlpwOgG2xYaf20vPykd8mOP2c0dclz/azZEITyHefeTdKCGvVAy/HNFUAC46Qu46Xtbp
         K9S5oZWzu/QYyHpS+t27yFgzi2MOjTXK+gIr5pmbIgcCIkrSnwL/rnmDwMRNjoYRpoJu
         nlTg==
X-Gm-Message-State: APjAAAURKDI6seE5BuZ3BMh0MA5TVlB61oN2t1Bc7ES3/2k2p9cnO6fe
        iatYCjPUJl/yxLeNbLwmzXhizbn2tzoLv3QkUaw=
X-Google-Smtp-Source: APXvYqwRLGAAMnEfA3C7vLeOjvTiCm9F8jL0MsiSN61Vn76PvA4CY8WaoHwVFSVKRxlGi9PYOwY7wK8/zhh3E6KekaI=
X-Received: by 2002:a2e:9198:: with SMTP id f24mr31667083ljg.221.1561264112772;
 Sat, 22 Jun 2019 21:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190622003449.33707-1-saravanak@google.com> <20190622003449.33707-3-saravanak@google.com>
 <CAGTfZH18SQXj_2TpUf7iQPzWrZ5RP8-OCb_t6fp7qhuutGWz5A@mail.gmail.com> <CAGETcx9Gi24bng_PCqc6=9S584va4hRc4HHZtBLevKHgYGSNDA@mail.gmail.com>
In-Reply-To: <CAGETcx9Gi24bng_PCqc6=9S584va4hRc4HHZtBLevKHgYGSNDA@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sun, 23 Jun 2019 13:27:56 +0900
Message-ID: <CAGTfZH2jK8s=5d_R7=kbUsPwE6s3fmz2_srZVyr32EU5qcB07Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] OPP: Add function to look up required OPP's for a
 given OPP
To:     Saravana Kannan <saravanak@google.com>
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

Hi,

2019=EB=85=84 6=EC=9B=94 23=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 6:42, S=
aravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Jun 22, 2019 at 4:50 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
> >
> > Hi,
> >
> > Absolutely, I like this approach. I think that it is necessary to make
> > the connection
> > between frequencies of devices.
>
> Happy to hear that.
>
> > But, I have a question on below.
> >
> > 2019=EB=85=84 6=EC=9B=94 22=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 9:3=
5, Saravana Kannan <saravanak@google.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > >
> > > Add a function that allows looking up required OPPs given a source OP=
P
> > > table, destination OPP table and the source OPP.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/opp/core.c     | 54 ++++++++++++++++++++++++++++++++++++++++=
++
> > >  include/linux/pm_opp.h | 11 +++++++++
> > >  2 files changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > index 74c7bdc6f463..4f7870bffbf8 100644
> > > --- a/drivers/opp/core.c
> > > +++ b/drivers/opp/core.c
> > > @@ -1830,6 +1830,60 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_=
table *opp_table,
> > >                 dev_err(virt_dev, "Failed to find required device ent=
ry\n");
> > >  }
> > >
> > > +/**
> > > + * dev_pm_opp_xlate_opp() - Find required OPP for src_table OPP.
> > > + * @src_table: OPP table which has dst_table as one of its required =
OPP table.
> > > + * @dst_table: Required OPP table of the src_table.
> > > + * @pstate: OPP of the src_table.
> > > + *
> > > + * This function returns the OPP (present in @dst_table) pointed out=
 by the
> > > + * "required-opps" property of the OPP (present in @src_table).
> > > + *
> > > + * The callers are required to call dev_pm_opp_put() for the returne=
d OPP after
> > > + * use.
> > > + *
> > > + * Return: destination table OPP on success, otherwise NULL on error=
s.
> > > + */
> > > +struct dev_pm_opp *dev_pm_opp_xlate_opp(struct opp_table *src_table,
> > > +                                       struct opp_table *dst_table,
> > > +                                       struct dev_pm_opp *src_opp)
> > > +{
> > > +       struct dev_pm_opp *opp, *dest_opp =3D NULL;
> > > +       int i;
> > > +
> > > +       if (!src_table || !dst_table || !src_opp)
> > > +               return NULL;
> > > +
> > > +       for (i =3D 0; i < src_table->required_opp_count; i++) {
> > > +               if (src_table->required_opp_tables[i]->np =3D=3D dst_=
table->np)
> > > +                       break;
> > > +       }
> > > +
> > > +       if (unlikely(i =3D=3D src_table->required_opp_count)) {
> > > +               pr_err("%s: Couldn't find matching OPP table (%p: %p)=
\n",
> > > +                      __func__, src_table, dst_table);
> > > +               return NULL;
> > > +       }
> > > +
> > > +       mutex_lock(&src_table->lock);
> > > +
> > > +       list_for_each_entry(opp, &src_table->opp_list, node) {
> > > +               if (opp =3D=3D src_opp) {
> > > +                       dest_opp =3D opp->required_opps[i];
> >
> > Correct me if I am wrong. This patch assume that 'i' index is same on b=
etween
> > [1] and [2]. But in order to guarantee this assumption, all OPP entries
> > in the same opp_table have to have the same number of 'required-opps' p=
roperties
> > and keep the sequence among 'required-opps' entries.
> >
> > [1] src_table->required_opp_tables[i]->np
> > [2] opp->required_opps[I];
> >
> > For example, three OPP entries in the 'parent_bus_opp'
> > have the different sequence of 'required-opps' and the different
> > number of 'required-opps'. Is it no problem?
> >
> > parent_bus_opp: opp_table {
> >     compatible =3D "operating-points-v2";
> >
> >     opp2 {
> >         opp-hz =3D /bits/ 64 <200000>;
> >         required-opps =3D <&child_bus_a_opp2>, <&child_bus_b_opp2>,
> > <&child_bus_c_opp2>;
> >     };
> >
> >     opp1 {
> >         opp-hz =3D /bits/ 64 <200000>;
> >         // change the sequence between child_bus_b_opp2  and child_bus_=
c_opp2
> >         required-opps =3D <&child_bus_a_opp2>, <&child_bus_c_opp2>,
> > <&child_bus_b_opp2>
> >     };
> >
> >     opp0 {
> >         opp-hz =3D /bits/ 64 <200000>;
> >         // missing 'child_bus_a_opp2'
> >         required-opps =3D <&child_bus_c_opp2>, <&child_bus_b_opp2>
> >     };
> >
> > }
> >
>
> I get your question. If I'm not mistaken the OPP framework DT parsing
> code makes the assumption that the required-opps list has the phandles
> in the same order for each "row" in the OPP table. It actually only
> looks at the first OPP entry to figure out the list of required OPP
> tables.

Thanks for description. It is the limitation of 'required-opps' until now.

>
> Technically one can write code to deal with random order of the
> required-opp list, but doesn't seem like that's worth it because
> there's no need to have that order all mixed up in DT. And even if
> someone wants to add support for that, I don't think improving the DT
> parsing to handle random order would be part of this patch series.

I understand the existing ' required-opps' only consider the same sequence
of entries which are included in the same OPP table.

One more thing, 'required-opps' properties doesn't support
the other OPP enters of the different OPP table. Is it right of 'required-o=
pps'?

Except for the random order, just each OPP might will requires
the different 'required-opps' of different OPP table. Even if it is
not related to random order, I think that this approach cannot
support them.

For example as following:
- opp2 used the OPP entries of 'child_bus_A' and 'child_bus_B' opp-table.
- opp1 used the OPP entries of 'child_bus_C' and 'child_bus_D' opp-table.

parent_bus_opp: opp_table {
    compatible =3D "operating-points-v2";

     opp2 {
         opp-hz =3D /bits/ 64 <200000>;
         required-opps =3D <&child_bus_A_opp2>, <&child_bus_B_opp2>;
    };

   opp1 {
         opp-hz =3D /bits/ 64 <200000>;
         required-opps =3D <&child_bus_C_opp0>, <&child_bus_D_opp0>;
    };
};

--=20
Best Regards,
Chanwoo Choi
