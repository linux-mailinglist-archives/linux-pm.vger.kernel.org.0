Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC8D1CCC1D
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 18:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgEJQEt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 12:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgEJQEt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 12:04:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B85CC061A0C;
        Sun, 10 May 2020 09:04:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3DBF02A0563
Received: by earth.universe (Postfix, from userid 1000)
        id 55D2B3C08C7; Sun, 10 May 2020 18:04:45 +0200 (CEST)
Date:   Sun, 10 May 2020 18:04:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        brendanhiggins@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 00/11] Support ROHM BD99954 charger IC
Message-ID: <20200510160445.6fg2v7jug2vlepkv@earth.universe>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k67hcptim6stu57b"
Content-Disposition: inline
In-Reply-To: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--k67hcptim6stu57b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Fri, May 08, 2020 at 06:38:17PM +0300, Matti Vaittinen wrote:
> Please note that this series should be applied to two trees. Patches
> 1-4 (or 1-5 as suggested by Sebastian) should go to regulator tree.
> Perhaps Mark can provide an immutable branch to Sebastian? Rest of the
> patches can then go to power-supply tree.

Thanks, I merged the pull-request from Mark and queued patches 5-11.

-- Sebastian

--k67hcptim6stu57b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl64Jh0ACgkQ2O7X88g7
+prR0A//aCqBAlia1d0xSZZue2lV8hlTJIUPfa6+6b+Mkl9YmFWu0vJFxwRdpsj1
bfgv1N4s6Cvj7JLfEMQ5WbNFz89qRKk5zuB8qZVR5ZwfKd0hZXDipmob3lViBqZP
y+cYm1RBvfnvoZSY/+zUdRJS7UzmNytb6sSjZze7Hys6BXS+5H54X0wDVSShxOoI
GcCD7jDswjYqvPQzlZQXGQ4RlYsvBsazNLKWTKZnuRLIeGjX1IWmTq58TKB8albF
/UgdURZiuEUZc4Ybr6RDyuARquTGxj/ZcUHtiboNbkBnj6436D/RKAKE80WqMYzu
X/yxxGHlF3jFWvvr83Yr7NMZJigfi9k2pyvEBMcbEyJErgEjE5qeJ85xiLGd9ga2
E0XQuaogbcIn9u7H0JId1eysKDn4Tmt0B1NlN6+2OQcOnkOvjDP/oeOuClQHgts4
Vj+dmxBzP3XdjdK6SeRuU+Gpia+bVQKcwBMOCVaT5CZEoQkEBcDhlZb78KY04pi1
bw2ceIkMrFe012hqeqHjlAdsOzUZGRTFZDpvdRfGf9hBNddMbaKl/UmnpaircnWf
XHVFqiw5HLO7FCt3R5V3+qqp60m+e8Ljq02wNrjOw2wUyIfRHoYFVIBX30W979py
q4Eis19au99FpOHZXgFZoR9A2Mw0zzOnv5vap6N9dwt/xYSY9wg=
=vbvd
-----END PGP SIGNATURE-----

--k67hcptim6stu57b--
