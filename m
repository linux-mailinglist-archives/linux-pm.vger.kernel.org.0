Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4B22516F0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgHYKzu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 06:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKzu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 06:55:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F25FC2068E;
        Tue, 25 Aug 2020 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598352949;
        bh=sG5sWRvSzPP9GgzIjue9lvipcy0Ffb/6EEMGfIMIqX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+2d6Bz0nXKJEoMURRW/D9yY4cAw4E5liHVuWIok6ae6LlFvqCwamFk+XOnGZc1Eb
         fQyA+rdOd7ivu99Y98A6pxrI+7+RO8V8xQZ4H6DclFp2cTZJzv0E2EmwvUyQXWQaAd
         WAl0JrY4s8JyiL4+qhz27TsGJNjmBEXxAMEvaOyw=
Date:   Tue, 25 Aug 2020 11:55:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/6] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20200825105513.GE5379@sirena.org.uk>
References: <cover.1598043782.git.cristian.ciocaltea@gmail.com>
 <8da70f0b19de17fb8edead7ff06461ae2451b0e9.1598043782.git.cristian.ciocaltea@gmail.com>
 <20200824110045.GA4676@sirena.org.uk>
 <20200824232310.GA2301286@BV030612LT>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <20200824232310.GA2301286@BV030612LT>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 02:23:10AM +0300, Cristian Ciocaltea wrote:
> On Mon, Aug 24, 2020 at 12:00:45PM +0100, Mark Brown wrote:

> > Please write normal conditional statements to make things easier to
> > read.  It also looks like this would be more robustly written by just
> > having separate ops for DCDCs and LDOs, this could easily break if
> > another device is supported in the driver.

> Sure, I can provide separate ops, but in this case we duplicate almost
> all of them. If this is not acceptable, then I will just rewrite the
> conditional statement.

That's fine, it's just a fairly small struct that's being duplicated not
code.

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E7hEACgkQJNaLcl1U
h9Df2wgAhaKs443tKsiDZZ8WadCi+JBgtmmpe6/05aaejbq3Nn4RXhrEDvX/T65I
SNnwAjQuMoWveIJyW/e/Cw5/M9E+0pE55HJ6XG8yXvSs6nnd8XNgNwqQNIz7EC5s
qRMoneTdQLpF1ehrgf8zzuvEtwTK9nQ0EfGam7Hy0kLjJgTU+cRziiXnj8sWN8Hm
t6DbJYJwoS5fP1dBZ6OHeaPVW4ke8ioc5KFXkJasHPdyuMuwzsOHQ79zA4DqT9tz
tBlPp+S74k8jiPPO88gr88Zyfy2THWdJgzzaJtgM4Qxne8XKlFrADDzLOohfsi7i
7MQ6Z6DdX9PLBC3CA7miaoTjus/FFQ==
=ZIz+
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
