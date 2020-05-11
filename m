Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7A1CD620
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgEKKN0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 06:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgEKKN0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 May 2020 06:13:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA86E20720;
        Mon, 11 May 2020 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589192005;
        bh=1NYiY2OhyjCAXz5EXMzPMvSmvFwy7WzuyixKljs2AwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnGTixrivZ/tS7bBfNcTRJ2yW0bCaC0edxT3lJOwmpCnkuVQP0YRCAi3ZxwUhUZVi
         mcR2OZQ0Za0tpOCgRJINKywvQAVFEgJInq7AsHSxCjj2WpuObAbrPfvSC1I9F+8vtF
         iXwjauffxGQ9TmwgWRQvEkvz0GwIaahXIOeSFL4I=
Date:   Mon, 11 May 2020 11:13:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v12 02/11] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Message-ID: <20200511101322.GA8216@sirena.org.uk>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
 <311fea741bafdcd33804d3187c1642e24275e3e5.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
 <20200508171751.GM4820@sirena.org.uk>
 <a34578a06c991119519e53b0cf87f438fffcc808.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <a34578a06c991119519e53b0cf87f438fffcc808.camel@fi.rohmeurope.com>
X-Cookie: TANSTAAFL
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2020 at 06:42:25PM +0000, Vaittinen, Matti wrote:

> I'm sorry. I did build allmodconfig build but missed the warning :/ I
> saw you applied 1-5. Do you want a single incremental patch with
> MODULE_LICENSE() or should I resubmit of whole series? GPL is the
> license I would like to use for linking and SPDX should cover more
> accurate version information.

| If any updates are required or you are submitting further changes they
| should be sent as incremental updates against current git, existing
| patches will not be replaced.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl65JUIACgkQJNaLcl1U
h9ApUAf/SxALvl7gmtjRjBKtRgbdZAqOsfHLhT12XuJhsK0xfjxG7hUZfarwn5zM
rTZFbR7bKU11/N3534hOqIgI1wZmpb67l4FvBjuMcbZH46T7vhB6MPReL2v356g9
AF9AzkczQOwewK4oCd9AUGuAM3uwpRsD/I7Pe18wtMaSlqX3Z3/581cbEkr9Bt0a
QCH8758hvxZLvcpPzlvvXhVdCxIAMOQqKMkQ98vDgsANSw5Blpshm1ngK1yAlKhp
kv0B6B82oadWtWxH5zBF5CSfk7nG65IrcW/NpBxu8XayJL9zsQs2/ji88LDyiam8
Ocy8NOF8GY6iJGvh4/fzfZAPcB6oOw==
=Y3YB
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
