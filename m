Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA8A6B2885
	for <lists+linux-pm@lfdr.de>; Thu,  9 Mar 2023 16:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCIPRe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Mar 2023 10:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjCIPRQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Mar 2023 10:17:16 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81588367F9
        for <linux-pm@vger.kernel.org>; Thu,  9 Mar 2023 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678375026; x=1709911026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvlD9m+QCKlafLa5Wy43cXPSMfoGnO/HffnSqBmtRbQ=;
  b=nJyfJBO3zr3jTQR4zwnZqsP3iKxgCQYxMw87Mft2HPWOqSi4b9kvfq7H
   Vc6QYrW1Gu90E3qxKMMQcYSSRIUz9zzTc8FeikmVDLpU+1XurzDUhZcl/
   iDEWLueuEN6sPcP0n5w+PGeEcHb2sYQ56AYGG+JJTrxzxIO8nnD3oN34Y
   xJeYWcIlRh3h1stZf4s8/OxKW2iaIfKZ0VPIN56JgTZD/DUacoJp7PBWC
   Xoj5B039ex0VeyjKqkfEL4MDzX3S4ysDdTKs1UaN0DuQhlDbmBoY6a50w
   ZrVBq+GX63i+7HhhhkrxnXPrijvIIEzH2elBag/y3CX61kOETXyNMip7C
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="29584432"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 09 Mar 2023 16:17:04 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 09 Mar 2023 16:17:03 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 09 Mar 2023 16:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678375024; x=1709911024;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MvlD9m+QCKlafLa5Wy43cXPSMfoGnO/HffnSqBmtRbQ=;
  b=YZwWfulnIRGrUtDKKuXjPgOVyi+F+Diy0INOFseV8XCFQdZudroNO0sL
   TCqd5rYVJWEaPt/xqUVjaoaV+I8s/a/B1GW9+RlIlI455+klpPWD17WoP
   u7oQG9mydQ+61TvE/+CTy4sXD+1SZINJhHDuWTO6AjpHTnTHy5iuvMq4D
   +6vhtNUqyXihNbpIZ0273SDl5sqYOup/j5o6KNl75BgK7ngIPxZVpUE7e
   mc+ICjMiCsMQi/rTr5ggQ2Vu6Q6qtQA13hgYPkTwQ7Dx1GJiji7doB6sp
   o0CI7a8dNhKyTnncB+LGYiRcUX+4pk62K5q79KqrRBkze4X6j7rNgIpqy
   A==;
X-IronPort-AV: E=Sophos;i="5.98,246,1673910000"; 
   d="scan'208";a="29584431"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 09 Mar 2023 16:17:04 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 992A5280056;
        Thu,  9 Mar 2023 16:17:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: NOC (interconnect) lockup on i.MX8MP during resume
Date:   Thu, 09 Mar 2023 16:17:00 +0100
Message-ID: <3777249.R56niFO833@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <700de2ce-36f6-6140-92d5-75175eb709d6@pengutronix.de>
References: <2176690.usQuhbGJ8B@steina-w> <700de2ce-36f6-6140-92d5-75175eb709d6@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ahmad,

Am Donnerstag, 9. M=E4rz 2023, 16:03:26 CET schrieb Ahmad Fatoum:
> Hello Alexander,
>=20
> On 09.03.23 15:57, Alexander Stein wrote:
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
> Could it be that you don't have a fully featured 8MP, but a 8MPUL
> or 8MPL, which lacks VPUs? In that case, it's not enough to disable
> the VPU nodes in the DT, but you need to disable the VPU power domains as
> well.

That's reasonable to question this, but in this case this is a full-fledged=
=20
8MP. I just noticed that during boot those settings are done as well and th=
ere=20
I get the (expected) output:

[   12.696371] imx_icc_node_set: node: VPU G2
[   12.700472] imx_icc_node_set: peak_bw: 1
[   12.704401] imx_icc_node_set: prio: 0x80000303
[   12.708850] imx_icc_node_set: mode: 0x0
[   12.712691] imx_icc_node_set: ext_control: #0
[   12.717053] imx_icc_node_set: node: NOC_VIDEO
[   12.721419] imx_icc_node_set: peak_bw: 1

So there is something wrong during resume. Both clk_ignore_unused=20
pd_ignore_unused did not help.

Best regards,
Alexander

> Cheers,
> Ahmad
>=20
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


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


