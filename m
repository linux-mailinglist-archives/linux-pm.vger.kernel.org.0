Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027A41858E7
	for <lists+linux-pm@lfdr.de>; Sun, 15 Mar 2020 03:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgCOCYO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Mar 2020 22:24:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbgCOCYN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 14 Mar 2020 22:24:13 -0400
Received: from earth.universe (dyndsl-095-033-168-153.ewe-ip-backbone.de [95.33.168.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9510020788;
        Sat, 14 Mar 2020 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584209051;
        bh=UhPNJ294fjCXqVxkid7P8jGGC9UBtD1iMM/BKx+zfyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGMT6Zjq+9MI4uKGs/48pJCp19OHsF/Zxuy5tfnv7IWYCnZFUfpZRWijw01yV9kbg
         xVQFYsqaBWqq5Oipuhuw7Cpp/V9wHrqgJe7hog3KYAE4rxhAXyW5/Bmr0jyx7VNNQg
         BGS9zRLu90M7rF9Np84xdrydH/jWfNAzUHWEEolo=
Received: by earth.universe (Postfix, from userid 1000)
        id 58A193C0C82; Sat, 14 Mar 2020 19:04:09 +0100 (CET)
Date:   Sat, 14 Mar 2020 19:04:09 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: power: reset: Add regmap support to the
 SYSCON reboot-mode bindings
Message-ID: <20200314180409.5nbnrajtf4q7rriu@earth.universe>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130402.1F4F0803079F@mail.baikalelectronics.ru>
 <20200312211438.GA21883@bogus>
 <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lztyclr74vqeyf6d"
Content-Disposition: inline
In-Reply-To: <20200313130231.wrvvcttm7ofaxbfo@ubsrv2.baikal.int>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lztyclr74vqeyf6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 13, 2020 at 04:02:31PM +0300, Sergey Semin wrote:
> On Thu, Mar 12, 2020 at 04:14:38PM -0500, Rob Herring wrote:
> > On Fri, Mar 06, 2020 at 04:03:40PM +0300, Sergey.Semin@baikalelectronic=
s.ru wrote:
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Optional regmap property will be used to refer to a syscon-controller
> > > having a reboot tolerant register mapped.
> >=20
> > NAK. It should simply be a child node of the 'syscon-controller'.
>=20
> Hm, It's dilemma. The driver maintainer said ack, while you
> disagree. So the code change will be merged while the doc-part
> won't?

FWIW I do not merge with bindings being NAK'd by Rob.

-- Sebastian

--lztyclr74vqeyf6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5tHI4ACgkQ2O7X88g7
+poY6Q/8C31JO6yaOpuYy3gpP+cvQDk+qcMDKREcMJ2a0IweUsYQIjqb9YogeFYn
AGXWI8mro35GAgPbKr79toHgily7PT+bMBSFZxqv0oHG6uQW7EPMxTTwIbpN5mk9
3iJnWdp/gLXXqM8jvUh3nMOGeA+WXHorxpG9Tf0f2yGD7fhir7o3mIGNFaXjahgS
I2uV16ESz6+10+fa2iCCPEfv6LBx/azfGDF9YmD0j61fn5V57S+nWbs8foLmucbC
264b6O82tqYq9+tu+GEWL3E/2epVLLNMLpZZnptSK1F/F5qoQR2lBeZ3t0nS28rB
zVRh7kVxs1KudZOITmLfF68AXdCASbuk9HMdL+qC1covhyQvEDjbJI3Npjb3kmyX
O9LIrfBPxpnxuFDCsnKJedPcJ5lZqwGqnpttGdXGf1Nr0TWDBU8IwRVj0YoNF0xF
QLCFq9O4s8n/DQXM8wpqi0hT1SFDJ6GaVagqgvaBURQsrJEweKX3Vrnzus3d0ocA
1qx476q34aQINOL0VqjRuaCCo1VtT78p8DE9UKGa832eo2lu2i67gcCe0rFv2HC9
K9JtpSJfVZfuUVy2bppD+K6f/0uofeZmcAFmzHfFmJXNREtsnv9JMzNwoRcvJiBa
dQgjX0+DSis/TrOupSJp157LauxG79beDRJ2o14ly9c+uVDdMVc=
=9xPE
-----END PGP SIGNATURE-----

--lztyclr74vqeyf6d--
