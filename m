Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA843583F91
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 15:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiG1NGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 09:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiG1NGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 09:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F91052DEB;
        Thu, 28 Jul 2022 06:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B765261CF2;
        Thu, 28 Jul 2022 13:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C0C433C1;
        Thu, 28 Jul 2022 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659013561;
        bh=RHdNXg2FMd7Dpr3izSu13H5wifouRTsZ4ttGOeY++k0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fx+EzAVPExp6RzDbyz4pMnd0FalmyWqhpD/NPZ+7WiNGG8GcjBn8nyp/OYK7xHJiG
         w4DgUBdA+9Geg64LnRtQw8uJ7EjTth1aNc/2pJmEu2Yyo0gyRk5e4kzCrfX+2/kZ1R
         1D8pgpoAO9N7bH5NvxyjlI7mShuPZNPi6Yn3QYwkZPjp4GReaWEN+pxrlzJJUeZDHz
         vh2YEyrIPtpZyAsfULG4JszmaDUfH6xtxrehpWABji1NvXHBxNsxAjr/R5DpQaQ6TI
         +8P4lmajPZqfYXHBVJFR3EVe+gBeihmJ8wm6flDEg9wdwxQeTciuwFtKgn4v91IK1m
         ZMFnroSCI4Jig==
Date:   Thu, 28 Jul 2022 14:05:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <YuKJtKHzoR4DUsOr@sirena.org.uk>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
 <20220728090806.nnighsbx2lcgugon@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9ApfM92VlMV+pgBD"
Content-Disposition: inline
In-Reply-To: <20220728090806.nnighsbx2lcgugon@bogus>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--9ApfM92VlMV+pgBD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2022 at 10:08:06AM +0100, Sudeep Holla wrote:
> On Wed, Jul 27, 2022 at 11:09:01PM +0300, Dmitry Baryshkov wrote:

> > To ease debugging of PSCI supported features, add debugfs file called
> > 'psci' describing PSCI and SMC CC versions

> These 2 are for sure in the boot log. Having them is debugfs accessible
> via file system add not much value as we would hit issues quite early in
> the boot for most of the things related to PSCI.

It can be useful to have something that can be queried at any point when
collecting diagnostics, even if there's been a lot of logging or log
rotation since boot.  It makes it easier to give people instructions or
a tool which will reliably collect useful information when filing a bug
report.

--9ApfM92VlMV+pgBD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLiibMACgkQJNaLcl1U
h9Djrgf/birZX09UpgOEo3CESr2Dek7AN1A7Upjzq6E7iRTeEfJsTpmAU96iU2yZ
ZDL4mCHFDdgos0VDgKY5CPqMZXA5ClqFmTGDmDv4oiQJ7oLd16/bCQQ1Mt7IEExi
ebjhHC7mG2BK7LSRK8D1v6tf6yaQpWA4Y128YVdu2RlaescUmgxn2iWyi7rcQary
uYH6fQbc853JsHYjiS4GpCPQUhqHbwegWq7tLC/aHXcZA80cjVhS/C+MCaCZRI9s
awkAwdApxEBGpSw1OEpXpg5IGnLt5ijR3NLl+uUKHkRlfiLMwi5J0CMb6ecMJnu4
+z4AttpiEFUj0KbnqMIHUFsslKiVqQ==
=awB8
-----END PGP SIGNATURE-----

--9ApfM92VlMV+pgBD--
