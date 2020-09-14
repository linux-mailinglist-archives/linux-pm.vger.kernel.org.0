Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE8268B14
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 14:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgINMfp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Sep 2020 08:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgINMfd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Sep 2020 08:35:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3381320756;
        Mon, 14 Sep 2020 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600086932;
        bh=Fm9KDut4PaJIs4j/JpgUlSl6imPbBlCojh25pXL1dG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZQ70GjsSVMAVGAZtXl46ShJPi4R6iMklkXoESoet/WqxHw287SMHgEEGt6fjvI6l
         kcpX0jt1mklJfTpTHtQ8H3qiLxr6yC9oQ0FMUEtg73rh9WF378KQzb+0omKfYjpyFX
         NdaDHXENrXrzBvNv4LLonjthNdWuBAiP4Or9aG+w=
Date:   Mon, 14 Sep 2020 13:34:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 15/17] regulator: Regulator driver for the Mediatek
 DVFSRC
Message-ID: <20200914123444.GE4821@sirena.org.uk>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
 <1600052684-21198-16-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <1600052684-21198-16-git-send-email-henryc.chen@mediatek.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2020 at 11:04:42AM +0800, Henry Chen wrote:

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */

Please make the entire comment a C++ one so things look more
intentional, and are you sure about that copyright date?

> +static int dvfsrc_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	struct device *dvfsrc_dev = to_dvfsrc_dev(rdev);
> +	int id = rdev_get_id(rdev);
> +
> +	switch (id) {
> +	case DVFSRC_ID_VCORE:
> +		mtk_dvfsrc_send_request(dvfsrc_dev,
> +					MTK_DVFSRC_CMD_VCORE_REQUEST,
> +					selector);
> +	break;
> +	case DVFSRC_ID_VSCP:
> +		mtk_dvfsrc_send_request(dvfsrc_dev,
> +					MTK_DVFSRC_CMD_VSCP_REQUEST,
> +					selector);
> +	break;

Just have two separate operations rather than the switch statement, and
where you do have switch statements please follow the kernel coding
style.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9fY2MACgkQJNaLcl1U
h9AXygf/Y3FBNX7Td9KehegefHCUBqS15IeZhWcko9jFgTgFMHNyfGyOrSkON5XM
6cHvLPc8PdjA8nTnK7BnbTqQZC0X5waqF0f5d06fQ+ElTR2N0X9eZ4yLYldTAEaF
1SWQY/tQ+FvZKnvrGn8nMc5UUQf3UrgA7Q9KgdPTg5w+FiveJ5eSWH6r2o3DUqGq
5qVUdkgAwnsUAGQ77n8Z/PubaJUScTlesLoH7hhdZa73SZNW7yuYCmDYkM7J21/o
6CcxGJvhZfehLa9rtgn0CEJG0L1t5iFaNCzGqDA9MfPfII8mCJ5qHYLVgK+/h9fp
Ya31zSS1ZIzAjIaowtDsDJwwZRhPzw==
=jIy1
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
