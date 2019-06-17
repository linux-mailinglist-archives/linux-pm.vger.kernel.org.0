Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 459CB47FAF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2019 12:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfFQKbS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Jun 2019 06:31:18 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFQKbS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Jun 2019 06:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TSyEikwRmMeCR1bDMoxiHnUHKSbz82o6XWDHp751sE8=; b=V0bCupC+fPPlIT6U9yltJLPOm
        3m2GY3ZyZB8EzOkTf2juEOeWdQnkcC1qO276A140mr7s3g6n6wKcZjQn1b8dU+HF5+ML21PBO8Ar0
        pF6bVAIAHmsdaUqWaWgWnj9VoChqZxrPKQxNY84eykDQiRbUR47VU/CIGh7Ss94nC3/Qo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcout-0001Ms-Qe; Mon, 17 Jun 2019 10:31:11 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 311C2440046; Mon, 17 Jun 2019 11:31:11 +0100 (BST)
Date:   Mon, 17 Jun 2019 11:31:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] regulator: twl: mark vdd1/2 as continuous on twl4030
Message-ID: <20190617103111.GM5316@sirena.org.uk>
Mail-Followup-To: Andreas Kemnade <andreas@kemnade.info>, tony@atomide.com,
        lgirdwood@gmail.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org,
        letux-kernel@openphoenux.org
References: <20190615163314.28173-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bNLLTo5eXWXFd6av"
Content-Disposition: inline
In-Reply-To: <20190615163314.28173-1-andreas@kemnade.info>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bNLLTo5eXWXFd6av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 15, 2019 at 06:33:14PM +0200, Andreas Kemnade wrote:

> The VDD1/VDD2 regulators on twl4030 are neither defined with
> voltage lists nor with the continuous flag set, so
> regulator_is_supported_voltage() returns false and an error
> before above mentioned commit (which was considered success)
> The result is that after the above mentioned commit cpufreq
> does not work properly e.g. dm3730.

Why is this a good fix and not defining the supported voltages?  These
look like fairly standard linear range regulators.

--bNLLTo5eXWXFd6av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Ha+sACgkQJNaLcl1U
h9CySgf/QMQ2EqpD1L/XFhmLo/ZBQ0MxTTbrhP3mxCoktiXaHq/8rC1GKin90FQ+
63Z79sD50NvjwOao024deSYu+7MVpCoojPdVwdizjH/B2meplYkB5fw3yhHKvsKc
+r1BYXVYODtZC590X8RcFCT4nO91acJoSbkA9dbHhp16+qnyjy/7sr9OmtDwTYkw
qVjma1T5nDgWfw1G9bQ6WAdQHSdZtuo7LYmPbrvpPXNAaTv2Va2YssbniIOWNgsW
sC/YRIuwWUztdeRwfhWIbyt3elAP0kUmoRVD1O3WzQx4STBpn97C++fDwjDwgn7H
F99QnvGMDroMdwasCwHr5TcSfoWAKQ==
=Awof
-----END PGP SIGNATURE-----

--bNLLTo5eXWXFd6av--
