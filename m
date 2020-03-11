Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBD18249B
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 23:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgCKWS7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 18:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729328AbgCKWS7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Mar 2020 18:18:59 -0400
Received: from jupiter.universe (dyndsl-037-138-186-138.ewe-ip-backbone.de [37.138.186.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08C520575;
        Wed, 11 Mar 2020 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583965138;
        bh=uN0EJfxB926vAIL9U8wcBm3Xwf+Zv5Hg2uC/q6DUe9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vvmzBbVCrsuXf7GEoXVgARY7+LxGRp6ukQN+JzzKg+RfYKTd7NDdV6fbJGD4Q+4Zb
         xWKdD5CeKU42P2oeJ1nj+Ky/9eean8XAc1UuHq81tXfBQe94lqBOkB91NzAvkiiJ/B
         bV9uPoi7/fHACmzCs5MJdM5Mudlvm61dEvlufJJs=
Received: by jupiter.universe (Postfix, from userid 1000)
        id CD0E24800FC; Wed, 11 Mar 2020 23:18:56 +0100 (CET)
Date:   Wed, 11 Mar 2020 23:18:56 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] power: supply: Allow charger manager can be built as
 a module
Message-ID: <20200311221856.yh2vr3fybwm3krfc@jupiter.universe>
References: <5e098be25c70e07c37e743f84a901f6f756090e0.1583461755.git.baolin.wang7@gmail.com>
 <20200306204712.dgomi52jzyakylky@earth.universe>
 <CADBw62owL-G_B7pU87sH2U+0vCNEG9rkMRpHZXL5_9YZcvQfxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ajojohcuwaygc775"
Content-Disposition: inline
In-Reply-To: <CADBw62owL-G_B7pU87sH2U+0vCNEG9rkMRpHZXL5_9YZcvQfxg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ajojohcuwaygc775
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 09, 2020 at 11:20:41AM +0800, Baolin Wang wrote:
> On Sat, Mar 7, 2020 at 4:47 AM Sebastian Reichel <sre@kernel.org> wrote:
> > On Fri, Mar 06, 2020 at 10:34:10AM +0800, Baolin Wang wrote:
> > > Allow charger manager can be built as a module like other charger
> > > drivers.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > ---
> >
> > Thanks, queued. I do not like this driver, but its the best we have
> > at the moment.
>=20
> Thanks. I understood your concern, do you have any plan to re-design
> the charger manager driver in kernel? Or do you have some thoughts
> about re-designing it? Now we have some out of tree code to use the
> old charger manger, and we'd like to change to the new charger manger
> driver and upstream them.

I don't have anything ready yet and not enough time unfortunately.
The proper way would be to have something equivialent to charger-manager
in the power-supply core. The core should be able to monitor batteries
and handle connected chargers automatically.  Also there shouldn't be
any DT entry for the software managing the charger, since DT is about
hardware.

-- Sebastian

--ajojohcuwaygc775
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5pY9AACgkQ2O7X88g7
+pqIIw/+OyAwCPmBxCOrmqKB/CxvHVZgBJCgJXNyVj8tBQHqtteGDqw10tEzpWI1
A3B89gB0j/kEW3REgvzm1L9aFHGPcG6tfjBmnXanaqKgzb4vbZuKwks5g1OwFHsF
j06oDex6FQ39W0ve17NG+FUZwVN5v9MvUcKhtJDOnZ6KOqfuZT6cPP8NX5rmTsI/
kDEle70hiAOwxGWC+JPifxtre47NL+OS9J30lw0BULgrs+8lYHIASlfilQE0LI+H
gYUcVQdT/zTtFpFjFK8OpGAP2uTYaojx7SISdjR1Wwg7ghZ+t/iyWNIdP0ix0BYZ
mx8hPv/8TiIy41hB1Xxyc+q8Vzee7I0P7H3242g3TWYaJYuh7NO9qegNKQaiM0wH
O67c1UOz+ausgha/WGO7gZpXpDgBxzUOu4up38O0kAicfhaD0V3l8HTA9AWhcdbh
kXpllhDJKEZbTLLOqRQ0scuJWt0IBQ53ES2dh0noV+g4mTCUswsgt+Xxqv5z/+Mx
qmU1zEcruMsQvmQ4Lwk7X363INgNDOQSK4cbx8u4iou3VdYICBaah7AKabK1aqCl
ZLQ1AP3d3PTUUd9wTGSHIWCpB6Nb8+ZkKKC4T1M6Xf+AUVKSXYOVQMxKWYqpDZAN
7lw4kjR8SFlon0N0s6hOLRcF+B3oRhhtgoWPTFESsti7tEopOUM=
=j3t3
-----END PGP SIGNATURE-----

--ajojohcuwaygc775--
