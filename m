Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5EB16638E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 17:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgBTQ4R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 11:56:17 -0500
Received: from foss.arm.com ([217.140.110.172]:46790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgBTQ4Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Feb 2020 11:56:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6857431B;
        Thu, 20 Feb 2020 08:56:16 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D28823F68F;
        Thu, 20 Feb 2020 08:56:15 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:56:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] regulator: max14577: Add proper dt-compatible strings
Message-ID: <20200220165614.GD3926@sirena.org.uk>
References: <CGME20200220145134eucas1p288ae1910d3e8d12dc12f010ed0b07b45@eucas1p2.samsung.com>
 <20200220145127.21273-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <20200220145127.21273-1-m.szyprowski@samsung.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 03:51:25PM +0100, Marek Szyprowski wrote:
> Add device tree compatible strings and create proper modalias structures
> to let this driver load automatically if compiled as module, because
> max14577 MFD driver creates MFD cells with such compatible strings.

> +static const struct of_device_id of_max14577_regulator_dt_match[] = {
> +	{ .compatible = "maxim,max77836-regulator",
> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX77836, },
> +	{ .compatible = "maxim,max14577-regulator",
> +	  .data = (void *)MAXIM_DEVICE_TYPE_MAX14577, },

Why would we want to encode the particular way Linux happens to
represent regulators on a MFD into the DT binding?  It's not clear that
this is a generic thing (another OS might choose to have a separate
object for each regulator with no parent for example) and the compatible
isn't adding any information we didn't have already knowing about the
parent device.

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Oui0ACgkQJNaLcl1U
h9B+tAf+O5wXN8/UCmxlhMHjjjsn7O63zZZ7rqMfIafoctlUWeySnrJfhBzLPRv2
0ymUV/Z1QPobWCjwgq05dJz0Nhb3IGdMc1lYSaNd52YtP2o2E+Ru8mLGa8By7NOh
mkfBkbjkqcn6Tteg3aihHhRzAiwkyCW6o9jQ3OxfZIdjUwMbQkZqUSKn65Vt22b7
AZp7PiqicQawrv22ob1b40v0+nMcdd6HXoHTBCXPQoTniobWf2dskNDr/SucOifC
3gbU7DAZXG4i023KOw31b4RWvgpb+dypKFyit7/8fQCvt7hcv/jfExZIWXTRmN7K
LpXRFJaCw1vAhQgRLyredfngs/DNlg==
=bBti
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
