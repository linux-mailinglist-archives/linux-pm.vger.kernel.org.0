Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0096125838
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 01:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLSAIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Dec 2019 19:08:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38824 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAIe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2019 19:08:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 0A5DA291E6E
Received: by earth.universe (Postfix, from userid 1000)
        id 8E8B63C0C7B; Thu, 19 Dec 2019 01:08:30 +0100 (CET)
Date:   Thu, 19 Dec 2019 01:08:30 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     tkjos@google.com, gregkh@linuxfoundation.org, tsoni@codeaurora.org,
        rananta@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: reset: Enable tristate on restart
 power-off driver
Message-ID: <20191219000830.wjzejwxicduamwq4@earth.universe>
References: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
 <1573256452-14838-3-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xaw3wi3ladlj7aew"
Content-Disposition: inline
In-Reply-To: <1573256452-14838-3-git-send-email-eberman@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xaw3wi3ladlj7aew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 08, 2019 at 03:40:52PM -0800, Elliot Berman wrote:
> Since reboot_mode is an exported symbol, restart power-off driver can be
> compiled as module.
>=20
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

I tried applying this for 5.6, but it fails to build with
allmodconfig on arm:

ERROR: "machine_restart" [drivers/power/reset/restart-poweroff.ko] undefine=
d!

-- Sebastian

--xaw3wi3ladlj7aew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl36v3IACgkQ2O7X88g7
+ppEUxAAg+YUjFe1eRIylM8rr6iVRtV8RacUdUbhVG2EmmarXVVA828WFhIqvJ0Q
ds8TqnEBQsf9UBxoYRR7/g9H2lt6pbHa+S+IKbejgxfy85e8cIecm9ATmKUm0oxH
6hq0mcF/0IbAdFpNJuSTuIRN5IhCUGdmm6OQmfZLtaozwXPdPzL6qxdugHmM8NgF
NaQtAQWgFO24oFBzT3CvoZQUHYG29kos2Z578gyTRyiSR3DP1oX4z+3/FwvT+Hch
K+Fo+ZohsO0xydobuXJh8oQGFzVJXwWYud2poxPwbBsJrhTF68zfJg44IY1xKujS
N3IBDpCvi4N0jE3v2u7HcnvzIRZRdfDinrQcSyhgKyoLZQgWBu+2F3AlcgJZaXpF
Dqwrx0WWehjrBxkMdUFxc1in1wdq1P/SSlGs2/rQ9DY4l0duFm5eJzIKNlCmxJ/d
SiE2up7MqbT+V4EFrj0pFH5/3hTvd7mXwwYqhGmMQi6wSPpG1Z9toVPz8Ec5QC7r
cIrOYBArC6ljPHTfEDhGt44stLGWRdDX/K+miH2ZQk29Nnd+RZBqXKcRyTx7IUN6
PVG0uSgXNQqLiQMN7ikBQGKg7ZEmOLAtGAxpIT2JC9SFdajSkqKn/E5mi8XSAcbI
wLlUmWPaUWe3ODC6gzeRqgbEUZjwETTSf3LnfMCAYKnmZcyag6o=
=YYmC
-----END PGP SIGNATURE-----

--xaw3wi3ladlj7aew--
