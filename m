Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF594E020F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2019 12:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbfJVK1p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 06:27:45 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59614 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfJVK1p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 06:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GRD7MZeVdKR1vgtr0TQS+zdY9FPxRAIwfXXcdGpmZOg=; b=Cvn5TPX6Q/YA59sDtrK567pcC
        x2Jug15Avnz0PUuMDv1tHQ9lT9p/RnP3yAdK4YvZjwosOkgjdrav3JTKUeju+DmUqD1R20db9ZlmU
        zEp0eeuDtYD8JNPmufP8I9MglkAsS5bThdcGjpGermwb83ah82Qm1B3Zs5o3tesMJxHX0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMrO7-0006NA-On; Tue, 22 Oct 2019 10:27:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 18CE02743259; Tue, 22 Oct 2019 11:27:39 +0100 (BST)
Date:   Tue, 22 Oct 2019 11:27:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: regulator: max77650: convert the
 binding document to yaml
Message-ID: <20191022102738.GB5554@sirena.co.uk>
References: <20191021124428.2541-1-brgl@bgdev.pl>
 <20191021124428.2541-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20191021124428.2541-3-brgl@bgdev.pl>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 02:44:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>=20
> Convert the binding document for MAX77650 regulator module to YAML.

Acked-by: Mark Brown <broonie@kernel.org>

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2u2ZoACgkQJNaLcl1U
h9C1gQf5Ad6I48RubPUMRfKZLJmmrTX3xcIgwSG/sD+od1xoySZz+IrL2rHEHLqJ
HSvhxiGnDgRWfdgQaZ6zigH0oMQOdHCLF1UYEiUDJfcQZQEFf0M5eC3018FHUI1E
SsT2svNjuHED+P52Ti/UPRwPJSz7g++DSc/uYoW+2qrlGYYvM28q0e6LKKqKV4oW
L7PJ3QwiZzo4zxNhmKTrBGH/nvH8lxY71DZHGEl89V87kbSx01b+MSw8iIubifM6
R2a/EowiqjZc4gvO1Uu0VlY7Lnk2h3m63hFZsYnhckRvaF/0OkvAlHOfafyZwSxE
5yM4xQKLWjHAUIuIBGEiej78Ds3+Sg==
=NvkN
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
