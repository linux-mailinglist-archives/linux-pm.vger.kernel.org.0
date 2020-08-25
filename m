Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96B251A4E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHYN64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 09:58:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYN6z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Aug 2020 09:58:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id BB4CB293A98
Received: by earth.universe (Postfix, from userid 1000)
        id 516003C0C82; Tue, 25 Aug 2020 15:58:50 +0200 (CEST)
Date:   Tue, 25 Aug 2020 15:58:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Lechner <david@lechnology.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Go??aszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] power: supply: Add dependency to lego-ev3-battery
 Kconfig options
Message-ID: <20200825135850.4ryqn53hacvor3tm@earth.universe>
References: <20200809185444.54247-1-alex.dewar90@gmail.com>
 <d6c98ee6-f2f3-c55a-be16-3794ccf30a28@lechnology.com>
 <20200812133711.ddwhxypmvr27pxdu@lenovo-laptop>
 <ce0ae241-10e1-de5c-e694-2c00dc01a2c4@lechnology.com>
 <20200812190253.zewvdfvyu6cnggcl@lenovo-laptop>
 <0927eaf0-62d6-adaf-c4b0-89d7f4cc7b4a@lechnology.com>
 <20200817174344.lxuzlly4it5vpfmz@lenovo-laptop>
 <dc296c76-b997-c711-7f60-a7a993601443@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7bkr3oqpz5rqps6"
Content-Disposition: inline
In-Reply-To: <dc296c76-b997-c711-7f60-a7a993601443@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--e7bkr3oqpz5rqps6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Aug 17, 2020 at 01:25:45PM -0500, David Lechner wrote:
> Acked-by: David Lechner <david@lechnology.com>

Thanks, queued.

-- Sebastian

--e7bkr3oqpz5rqps6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9FGQMACgkQ2O7X88g7
+poC/RAAgbWtpuuazZqMmp/RL4+F60nh/UTLSn0PevcfDdmaM2zTmz8w5mM+WyM0
0o3etP3j64iAVZoAdmsCbj6wHrrdcE2PqjKHcKD9uXpK8CmWot3L1tlQEXJBaKFr
exbvszE/5fKjYBlIvdgh1wKzhqbr0F2/KevJOM3ZU3f/P2orNihQ6lJe2bmoiBDs
gU8uyPOYBnfucR6iYXlJIMcKYVulDFnexoXlGjJh2MPZmycfF4ByL3zCho2ISTW8
PQ2HlcFgtDCr0bgIxy6W0vmy82jB0Sj9bEz7TC9JqHzGZqdDjgFeFMuq5vO9XeCp
u4MnauXMlaSxoSV6dM6saRIUdPkradH/4k+Nf02a2vbcRD28ZK9DVFTVCYMFjw35
RoCYmkgz9CKNK82iM2JGRe8ct8X1nNW/HMdwJjjkXt83QL8Av+6ZZb/676hIngIh
vhKoASKPy2NQmKE//Ornkd+/TzBgcLzFnsRqJCENGeu2T1hUmqhyfJuA75pB84vX
+Vz6gJbnlIKYuKLfD6pTHktUdlsFx/iaHKpm/ykdXFeFrV9FlW8PWYEWu/LTFzoH
QLuBftfiVUAbhpPqYdXZ9NzG1MZ+VjhoaTP/XiY+8b5oJwO3c2MaAvpRr8ixOEM9
H+FPOTewMuJYZfdFuyeF1DnV6kNp7DxZNK61svLTZxdu7ees/3g=
=ybwy
-----END PGP SIGNATURE-----

--e7bkr3oqpz5rqps6--
