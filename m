Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC2C589EF5
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiHDPyF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 11:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiHDPyA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 11:54:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF425B07B;
        Thu,  4 Aug 2022 08:53:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEF1613E9;
        Thu,  4 Aug 2022 15:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB951C433C1;
        Thu,  4 Aug 2022 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659628438;
        bh=3+yt9YIHBchO9DnsiT+NvJ7s3l9R3MOw9bV7x2ryNEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzhJFzVXGXsXz3W0HX6kXyNsXjptqhyKi8Iv22CgUs2IigvVopIOpmPT9qtsPfDoh
         dcLtS09L6xGjVIX0+RLDW0xLwqBH7tTznLJWq6xZMwdl0yYABdZAu+GUmGDwJJv2ss
         EYnmU4ILnHkatI1+9L+1rq7bCPrfgGPcjFj98oWl9A2+HH8nj+WBb3OcaPEW4CIWTP
         npWEWnd1KM6BgB299TJYrM7BqqX3U9JzpcWUIZpGhBdldE3YExeJB5rJ2vrLA/Dr+I
         CG70cYkYbCM4aEmcYIOvr12TzIfEi+/fxMxMqVsXtr7SOYb9yR2mrhMXqhKbBPS47b
         1ULT17gYvTEng==
Date:   Thu, 4 Aug 2022 16:53:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] firmware/psci: Add debugfs support to ease debugging
Message-ID: <YuvrkcLMiDz9Zq7C@sirena.org.uk>
References: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org>
 <YuvchxwbbI3H+kxY@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dOEFrV0R2FjGRrFd"
Content-Disposition: inline
In-Reply-To: <YuvchxwbbI3H+kxY@FVFF77S0Q05N.cambridge.arm.com>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--dOEFrV0R2FjGRrFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2022 at 03:49:43PM +0100, Mark Rutland wrote:
> On Thu, Aug 04, 2022 at 04:15:07PM +0300, Dmitry Baryshkov wrote:

> >  drivers/firmware/psci/psci.c | 116 ++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/psci.h    |  14 +++++
> >  2 files changed, 129 insertions(+), 1 deletion(-)

> TBH I am really not keen on exposing this to userspace. AFAICT this is his is
> incredibly niche, and is going to be very painful to maintain.

I'm not clear what you see as being very painful here?

--dOEFrV0R2FjGRrFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLr65AACgkQJNaLcl1U
h9AX0wf/c633Vs7l+WHcwQqfuwcKqQwQD7kcCnSTI/KE1HwvTDc1GC36kA2AFaOH
bs0utTFGl+eMa2Sf7VlrSr4zkl3eW28O1NopNPnxMuLxhCMl8jTi6MMD8gHu45Wi
sM4FWY+bYP+VhTQi4gie1o3p3KIFWKPwHDXptVhi5kBdmnvKUUb+80bdJgJ7AZjB
POy7pOyBZGOhI6/e5tFnwpQqzWSq+P3Us7W4CEzOf73EnWlVccZnE1M0Tb5BsZbO
6vGV3BbWW6slv4JoHsgNLitKpbaR0+B3Frg4A2Vy9AaPoXGUbikRfLjBAs1hyFUg
UV8TTRQb9V03k8F8YQgIYvK3LJX0lg==
=7BzF
-----END PGP SIGNATURE-----

--dOEFrV0R2FjGRrFd--
