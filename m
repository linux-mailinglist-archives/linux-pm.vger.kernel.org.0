Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EFC75A086
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jul 2023 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGSVXx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Jul 2023 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSVXx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2023 17:23:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296E1FC1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2023 14:23:52 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA9916607078;
        Wed, 19 Jul 2023 22:23:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689801831;
        bh=icVO9kwnde8EmFEddhZNuImUN/tsfWN1GD/OVsXoz9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n4I1QHLbQN60JHQnkLwYwxqevkMeAhir9fh197sNBuWOa8e8BQRYhcJzCcsU1e/jk
         ynmvOLR+oZB2falVhPd5rnsO4IY/uOX+lgGsbDve4XpF8bc9RY79tiozJG0qA0wusP
         qk6LQdTe63yiRJcbpNVj9NWx7/a+iTA69Ap0yF8Sae4Ryza8LP1kWLay0oipD1cjg0
         avJRzxD/Gq9c/VMgYf4vci25PkPFuvBSmYtoFTryZ4XW/xIEFZdAfq28NCj022Cx18
         E71tuUPiGBONBGbap59OONufEOcxRyl+hWAznECZ5yB90W5t0QXqN4zUlTPvO4zLSA
         UW9TbAucE+Oog==
Received: by mercury (Postfix, from userid 1000)
        id 3D5861061639; Wed, 19 Jul 2023 23:23:48 +0200 (CEST)
Date:   Wed, 19 Jul 2023 23:23:48 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v4] power: reset: at91-reset: add sysfs interface to the
 power on reason
Message-ID: <20230719212348.givbagnsudomdwte@mercury.elektranox.org>
References: <20230620062657.3127468-1-miquel.raynal@bootlin.com>
 <20230712175853.35184e92@xps-13>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oxafe4xibol3usvk"
Content-Disposition: inline
In-Reply-To: <20230712175853.35184e92@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oxafe4xibol3usvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 12, 2023 at 05:58:53PM +0200, Miquel Raynal wrote:
> > From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> >=20
> > Introduce a list of generic reset sources and use them to export the
> > power on reason through sysfs. Update the ABI documentation to describe
> > this new interface.
>=20
> I just rebased this patch on top of -rc1, no conflict whatsoever, do
> you need a resend or are you still considering this version?
>=20
> > Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > [Miquel Raynal: Follow-up on Kamel's work, 4 years later]
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks, queued.

-- Sebastian

--oxafe4xibol3usvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmS4VGMACgkQ2O7X88g7
+pqzIg//ZmcUJ5fqx9hj+K6EaA8YUkk9OCaxpxcF3pPuAmmP7gqR10FoHKLhrVXv
h8r8vb0jXPAdv3PhefckC3SHKIQOv5nLMa2f7g+6BRbhMHdnyaEfGb4CF9f1sWyJ
HGVXjlLyOF5rEBK6ePPPiAXNiIfl30mFTlxtb8LZUVObdpZqp4Cwn/kycB4IaaWX
bxZ/rsJptvORNlP6kZpV7qEMtoWFMtPEjJQQAmFs9c6E6Aee/dMAB9mQv3Gkz+/6
K7dKE59bh+me+Bs19Ui2j9hwCNTCA4bCpeO+AwXlOBC06HHI9iEKrYBDOZ6Ms/oH
ufLm77JyoxjVIuWi86FRYLred2rWJOop3qP0i7G3ktQHZe0TI3W1vT3eYAYnJCLL
KxPG98L3OOw7g6RxKW+Ap488etufFHwGKUaosFfrwb+54B2p37x+8j/kS67ZZ7Yi
PdL5Ua8Burv2LQEhIAuXL3fudD+7U8YGpy5Xl4HhNvLPqtP+369TJlcwA1AWUAHb
b2z+A0FpOnSGcs3SRD78Qw3FUQXiCkZRECd7njykxBF4VFvC/oQIqmk7zXMayNQg
nfQUTNsLm4kdVbZdZj9JpcqXAbt7rcWb+RN3Hhsk7wVp7O7SKWRf2zTSXmeY/diO
mz3kRQkLiYJdHI1+1mycTNc9I6RQa5/lKqkUPGcB/6fK1PMsSVc=
=jgIH
-----END PGP SIGNATURE-----

--oxafe4xibol3usvk--
