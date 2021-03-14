Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987CD33A894
	for <lists+linux-pm@lfdr.de>; Sun, 14 Mar 2021 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCNWfm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 18:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhCNWfP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 18:35:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74B4D64E4B;
        Sun, 14 Mar 2021 22:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615761315;
        bh=12OnKRkqX5g64yW9uY5bUVtXvUIalcP4i5GFus8Oivc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eD7u1/Qn9juB8atWruFF01HUuJ7SKzOAevrW0X4nK/PimPg+JP/aNnNky3EMZqwrM
         e4p3/aS07aOjjNnP10UKR+a32mPgAAujk8i3CpMZ2kIZWklIr3NmBl93djkXZa+VqB
         BHrJL0yVxMkBw/tDV7TBArdLzLN4P/Be2fGTTS5jQdBaLx7zvDp7glN80JwfbQ5KN6
         FryfRYJ1w0bnmT9t9T5940LpsiSBr8OGTrppukxodg0JmKgRBBtxu2EUjvCd+nmjHI
         V3zMbBpQGN9NT3lG+BTrz9HVu+Fx0kW7yVYrwufDb8510L8L0pxq9m9VypeF5gxYWy
         ZuXP6rfblTkMQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 6FEC73C0C96; Sun, 14 Mar 2021 23:35:13 +0100 (CET)
Date:   Sun, 14 Mar 2021 23:35:13 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Ray Chi <raychi@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, naresh.kamboju@linaro.org,
        Kyle Tso <kyletso@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not
 enabled
Message-ID: <20210314223513.tznvhuq7phxxvjfo@earth.universe>
References: <20210308133146.3168995-1-raychi@google.com>
 <20210309185807.ka4iljasq5cmpmil@earth.universe>
 <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r6xtjzuk4er6qt7g"
Content-Disposition: inline
In-Reply-To: <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r6xtjzuk4er6qt7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 12, 2021 at 09:57:56PM +0800, Ray Chi wrote:
> > While I'm fine with merging this after fixing up the subject, the
> > original patch for dwc3 [0] looks completly incorrect to me.
> >
> > First of all it uses wrong scale (power-supply uses uA, not mA),
> > so you are charging 1000x slower than expected. Then the patchset
> > introduces a new DT property to get the power-supply device, but
> > does not update the DT binding documentation and does not Cc the
> > DT binding maintainer.
>=20
> Yes, it should use uA and send this information, and I will update a
> patch to fix it and add the DT binding documentation.

Considering your programming is off by a factor 1000 I wonder how
this patchset has been tested.

> > Next the property itself looks not very
> > smart to me. Usually one would use a device reference, not the
> > Linux device name.
> >
> > Finally all existing devices solve this by registering a usb
> > notifier from the charger, so why are you going the other way
> > around? This is going to break once you want to use one of the
> > existing chargers with dwc3.
>=20
> Only the USB controller will know USB state/speed so that I think
> it is better to send this information from the USB side. For
> example: For USB high speed, charging current should be limited to
> 500 mA in configured state.  For USB super speed, charging current
> should be limited to 900 mA in configured state.

usb_register_notifier registers a callback to receive information
=66rom the USB subsystem. Then power-supply drivers can query specific
info, e.g. call usb_phy_get_charger_current(). This is already being
done by some power-supply drivers, so using one of those
power-supply charger drivers in combination with dwc3 will now result
in potentially racy behaviour as far as I can see.

> > I suggest to drop/revert the whole patchset.

-- Sebastian

--r6xtjzuk4er6qt7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBOj5MACgkQ2O7X88g7
+ppi5RAApUHg055QRJZ6hx9Eogf6zuWpbYCUC+z5bJ6WB7c9Nt4AsyAGH9GK2GvZ
phHQyxlB1Vx/AMGyOunitrkAh3qx0OZoLTJlxyY2SwTeMfVM1DIcr2s7VE//jotU
hCK0r79bYCx74aLwFVRYRKnnSlQjT/GJcs+Tx36pNdg52/Ius/tXQW/kP8DhhrHS
rL0xANsxf5TTsb5Hsv+ZCeQdYf5Ctt0ms+T3kPyHpAWcgyLP7puMhYDSb/ijkB18
pDnlpgKCG1xBPRNbSvKtoTVILYC+/BQWGn0venJn1lcjznX8JhoAD2gttQdqZWQK
8DvmOtIFUJQZz92UH1l9GBIPWqWJxSiIvewJwN0348WwTrQS9f+28fngMK0iYAWl
kBTwou5QJspoG+ydFv1VW/mdPVSBek8+T1kf2Jo+5aCrsu7XzdQc9Vrd0VaHvje9
DsrMiQDUz6Z4J9FIuzPERrGVBwVky7j1FjrK/WVuAI4Q/G3OtkLBqWEPFX+U361S
8zWUwZvbUmpHAwLadR7/Pw+9VX3dGyxR02y0uaIkXpug/oBx1dPeRMuCgqFBwrU1
iS/ggl82GiHt7f705DGz6jwZf8lGpHVDSGThA6WOF8OhYTNxtp/ZmSXgQTitoJ9j
fsbaPue/oDCAtFv6NRzRoqnSJ5PTVusVK3LDuJwrAANNsOrCNCE=
=E8+B
-----END PGP SIGNATURE-----

--r6xtjzuk4er6qt7g--
