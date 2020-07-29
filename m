Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC72322FE
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2Q4Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 12:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG2Q4Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 12:56:25 -0400
Received: from earth.universe (dyndsl-095-033-172-175.ewe-ip-backbone.de [95.33.172.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A4D2053B;
        Wed, 29 Jul 2020 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596041784;
        bh=+MZqyVWBIfhGZ4yHMK6lksl+VqeE7shOnnLZ4HlPZvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q6CCe3yu1QwaqqVA8UrDH8H4DrJJwH0O8OmUh5UDF5KXrpMsGbrJOeK90O7zzk/tG
         M/bnifCx2HcU53xmXAP+txGCY29m9JPxFaPbx7kQEdQ2u7JaOSC5COibw/e1SeUd7t
         3fC91zZSGIgmUgEdt2MMQbcY84PAF7hEN1N9GTRk=
Received: by earth.universe (Postfix, from userid 1000)
        id DC4883C0B87; Wed, 29 Jul 2020 18:56:22 +0200 (CEST)
Date:   Wed, 29 Jul 2020 18:56:22 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     afd@ti.com, pali@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: Re: [PATCH v5 2/4] power: supply: bq27xxx_battery: Add the BQ27z561
 Battery monitor
Message-ID: <20200729165622.jbncn2dqgugrhykx@earth.universe>
References: <20200729120609.22427-1-dmurphy@ti.com>
 <20200729120609.22427-2-dmurphy@ti.com>
 <a757fcf1-0215-3926-f74c-22183457be3e@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oka4kkleniibgdes"
Content-Disposition: inline
In-Reply-To: <a757fcf1-0215-3926-f74c-22183457be3e@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oka4kkleniibgdes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 29, 2020 at 10:55:54AM -0500, Dan Murphy wrote:
> > +<<<<<<< HEAD
>=20
> Need to remove this artifact from a rebase.
>=20
> Not sure how this got here as it does not appear in my source.

You don't see it in your source, since you removed it in patch 4.

-- Sebastian

--oka4kkleniibgdes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8hqjYACgkQ2O7X88g7
+po97g/+LBZX+P6d3sqAAtfAiF+zlxy/54zNauGdOIgBFFPdjUmTgX8t3ial8BHm
OrW8wY5LOqqM5teVkFfufBt8H3GQzMvHqcnUjK2+pRpW1sPXhYimsJxIfXvwsmZQ
JTUkfJ0HmMpZfaT0l4bwv8CU+1fYsNbJdGr2737wLYZRvqT+I65IDaQCjgSlV7Oi
ySGNCVJBwgXuoERB0k/eXxUeeny5qM0KelnGp1xNOJ1UyVqz8Uln6uZzfTm2PF2F
u2hTogPS45ar9VORhje2F3WNEbZja8k7OiWpmoMNg8aPy8XZZnf48s7G1XczjXDU
jbNRhpbL1X6Eh0jpJoqG6u/t2AgOIaSY+c8DvHVwDL0bV5oYk+Mb/PKrIWY4dRfw
zWbYdVr+j792AKeKc62rbaFz4d+N+d73zw169qyRP+Wfm+zeE6AQGxlLPd3vPMNJ
4Hv7tw3kTvPAuL0LVIr69v1js0cYVesfVpB+MuoCpnNTV+vAUgJGIVQOoIAX7bTM
CK3DmrfjcWyZMx0b1ZWRw8iqaUMijvL1Wg91m5NOI93SkMPRYd5Pt4MDlAI+z1hp
LQAYzIwv2qX+MrVF70rrSIZsTWj4YTKXVCAVPB+Z1cYYqAck9htK9YHWMXITgCvE
MEoz8MBM27qKXeaLgfEYnWpHC/j4UYOBZCL42U2088btM/RLThA=
=J8uF
-----END PGP SIGNATURE-----

--oka4kkleniibgdes--
