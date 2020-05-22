Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4811DE518
	for <lists+linux-pm@lfdr.de>; Fri, 22 May 2020 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgEVLJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 May 2020 07:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgEVLJG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 22 May 2020 07:09:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBEF206B6;
        Fri, 22 May 2020 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590145746;
        bh=akm9w9vUGMm1OZtMoY9+dDiEUBKGQg7DabJxbnXOXDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrMoWA3nOKs2MGjrLolal+vz6NUhgpGFJzvHoE/v9U3gXwsd7UVDpQNjCRJh3RRa0
         0q90IBErHUS/9YGzSoj2wGN02Si616FepPxOKgt3xUZPQjgEY8KS/rwSl9ynOi3mM1
         eFY+PXz4pJ5vT7Ld/aSDfVHhIjo5AnFOHEJWQmOM=
Date:   Fri, 22 May 2020 12:09:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/3] regulator: max14577: Add proper dt-compatible
 strings
Message-ID: <20200522110903.GC5801@sirena.org.uk>
References: <CGME20200522102452eucas1p17c18de8f79e27de96474e5fcad6db5fa@eucas1p1.samsung.com>
 <20200522102448.30209-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <20200522102448.30209-1-m.szyprowski@samsung.com>
X-Cookie: C for yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 22, 2020 at 12:24:46PM +0200, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.

Same issue as before, you're putting the current Linux model into DT
without adding any additional description of the hardware.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Hss8ACgkQJNaLcl1U
h9DIJgf7BpDKzpW22MjREOy/41/5TdMCG7vybW18iFY8cHBhBjkkP/8J24jCBWS4
9MQsT4JKH4gJyZANrjPM79ARiUiSH2GIpfBieUoMVEqcoHF2IsQobLgVbji2BXHH
m8CZooQ9v5ayNjkIvXUvnJE6Dm4ynGcoeOnyQ5xoV+o2QJlcXkdARQgYll1DQsgj
QO0iqLxLGzRM3VkNlZkQ7d3dz8i8ZTnwotJesCoLL1f0dm318aHCLZPC8bAyUI6w
r7A6uxjbo05r0q8JApVUc5MoavmnIsT3samcO+RsNqh5VvfLkWoc4kDNey92eJ86
hdvteo+Qp9VPvmvdlDTfvCtdfVV89w==
=IFlK
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
