Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9519E6B8C1A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Mar 2023 08:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCNHjz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Mar 2023 03:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCNHjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2023 03:39:54 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC76A8C533
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2023 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678779593; x=1710315593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bGnt/g+jzGoM6d9RDIJs6Wtfqozp1RiVkvq2PhJw+DI=;
  b=MyS0L2LOijBxgb979yt+CTFm4JCu9IVSmpgYEH2+NgvQapzE52n5JH8f
   6s7BJdBgsyf45o9Ynb/f11zWzQYt8+Mz23M2mPXoeQHw9TLvT7gmgWNll
   b9kvbt3dPOmkg9R/EEXZLWj/iFxoUj0ltIYqkeyaR3uTGZLra9BMjR7Ef
   wydF5Q4VECYb++msrOVaUM/mmrA8NdkIkYIJUgY4QIGoL7aBU3ofbOw6g
   qKJev28JBKvcdc0vL8/QTRxHACtPe0zYQRIozXw72qfdNw5bSjIczEQsR
   BPNPJO2eoG8IGX+b8nhKvqSJvxAjIUg76lOiczpdYHrGV7xnBaYuqiHle
   g==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673910000"; 
   d="scan'208";a="29665317"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Mar 2023 08:39:51 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 14 Mar 2023 08:39:51 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 14 Mar 2023 08:39:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678779591; x=1710315591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bGnt/g+jzGoM6d9RDIJs6Wtfqozp1RiVkvq2PhJw+DI=;
  b=Jn10Ljf0eDAPhynhubiolzDu2zIEQKAH6ZDElFnb80VdJec/qAVSBX0L
   zosqS/s2tEJl/ILlNHaxMR5FNVrOEMp8LJuvYqzKMPBsVrJaQxXXeC14R
   IP92djL1dtYP67jPC0wECnFOly2lUPiPkB3JVI5R/PVTfZNWPoi0igmrc
   79SggibIZ3GHATRF9KbI3moeRytGZMHDvsBARl0bhaYyi9jjEYPcogB5+
   OhhAiUTLqzSQuW2OWWLGbJ29gqjGf5p3Zl93AaeU9ZCiO/wbevTOprDSG
   lEGvnB9jPDJg9vu/n6DnLW6k51rSolams4JJRHZ/2sKSYyROSi2ZqP6YR
   A==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673910000"; 
   d="scan'208";a="29665316"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Mar 2023 08:39:51 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DED05280056;
        Tue, 14 Mar 2023 08:39:50 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: NOC (interconnect) lockup on i.MX8MP during resume
Date:   Tue, 14 Mar 2023 08:39:48 +0100
Message-ID: <2220041.iZASKD2KPV@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CAHCN7x+rEcXfC9GcJxPgro7XBb=K9kvF60htxtHRG0kVXHF0LQ@mail.gmail.com>
References: <2176690.usQuhbGJ8B@steina-w> <CAHCN7x+rEcXfC9GcJxPgro7XBb=K9kvF60htxtHRG0kVXHF0LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Adam,

Am Montag, 13. M=C3=A4rz 2023, 20:17:55 CET schrieb Adam Ford:
> On Thu, Mar 9, 2023 at 9:11=E2=80=AFAM Alexander Stein
>=20
> <alexander.stein@ew.tq-group.com> wrote:
> > Hi,
> >=20
> > while debugging another issue regarding suspend/resume I noticed that t=
he
> > imx interconnect driver locks up the system when writing into registers.
> > This happens during resume of the 'g2' power domain.
> > imx8m_blk_ctrl_power_on() will eventually call down to
> > imx_icc_node_set(). Using the debug diff furthe down I get this output:
> >=20
> > [   71.493062] imx_icc_node_set: node: VPU G2
> > [   71.497163] imx_icc_node_set: peak_bw: 1
> > [   71.501091] imx_icc_node_set: prio: 0x80000303
> > <freeze here>
> >=20
> > Unfortunately there is absolutely no documentation regarding NOC in the
> > reference manual, so no idea whats happening here.
> > This is on next-20230309 using imx8mp-tqma8mpql-mba8mpxl.dts with USB
> > disabled (prevents suspend) and Ethernet-PHY-IRQ disabled (the issue I'm
> > tackling).
> > Is there some idea what do in order to support resume on i.MX8MP?
>=20
> I haven't played with suspend-resume myself, but there was a thread
> [1] with discussions about fixing a race condition on the imx8mp
> interconnect.

Thanks for this link, but I think this is addressing a race condition durin=
g=20
(un)registering. This works for me so far. I'm dealing with a freezing=20
hardware write upon resume.

Best regards,
Alexander


> adam
>=20
> [1] -
> https://lore.kernel.org/lkml/20230201101559.15529-5-johan+linaro@kernel.o=
rg
> /
> > Best regards,
> > Alexander
> >=20
> > ---8<---
> > diff --git a/drivers/interconnect/imx/imx.c
> > b/drivers/interconnect/imx/imx.c index 979ed610f704..93ec79cc7c06 100644
> > --- a/drivers/interconnect/imx/imx.c
> > +++ b/drivers/interconnect/imx/imx.c
> > @@ -44,13 +44,18 @@ static int imx_icc_node_set(struct icc_node *node)
> >=20
> >         u32 prio;
> >         u64 freq;
> >=20
> > +       pr_info("%s: node: %s\n", __func__, node->name);
> > +       pr_info("%s: peak_bw: %u\n", __func__, node->peak_bw);
> >=20
> >         if (node_data->setting && node->peak_bw) {
> >        =20
> >                 base =3D node_data->setting->reg +
> >                 node_data->imx_provider->noc_base;
> >                 if (node_data->setting->mode =3D=3D IMX_NOC_MODE_FIXED)=
 {
> >                =20
> >                         prio =3D node_data->setting->prio_level;
> >                         prio =3D PRIORITY_COMP_MARK | (prio << 8) | pri=
o;
> >=20
> > +                       pr_info("%s: prio: %#x\n", __func__, prio);
> >=20
> >                         writel(prio, base + IMX_NOC_PRIO_REG);
> >=20
> > +                       pr_info("%s: mode: %#x\n", __func__,
> > node_data->setting->mode);>=20
> >                         writel(node_data->setting->mode, base +
> >                         IMX_NOC_MODE_REG);
> >=20
> > +                       pr_info("%s: ext_control: #%x\n", __func__,
> > node_data->setting->ext_control);>=20
> >                         writel(node_data->setting->ext_control, base +
> >                         IMX_NOC_EXT_CTL_REG);
> >                         dev_dbg(dev, "%s: mode: 0x%x, prio: 0x%x,
> >                         ext_control: 0x%x\n",
> >                        =20
> >                                 node_data->desc->name,
> >                                 node_data->setting->mode, prio,
> >=20
> > ---8<---
> >=20
> > --
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > http://www.tq-group.com/


=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


