Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4A2589D74
	for <lists+linux-pm@lfdr.de>; Thu,  4 Aug 2022 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbiHDO0j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Aug 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiHDO0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 10:26:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5381E1D320;
        Thu,  4 Aug 2022 07:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1619B82543;
        Thu,  4 Aug 2022 14:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F69C433D7;
        Thu,  4 Aug 2022 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659623194;
        bh=kJ43JWsEz+uMpFYqJXj4bQ6eXVdUikHcsKfdWWwD/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsLMLOOiFTw4tVszTY+DQBv8Ekmh9xZpWhAYBKbaJA6Ly4nkrq6Q3cAwRsyHgrs/U
         6UYQZlOupk2YCA4ebQ0N+irI+BoQA5UsYnP9o9R2zQuT5cfQiE5cSe72tCH2HeVSTy
         y6a4HO/fBjz4ZRbE0MfILE5CC/uoqX3yI+4vdzjJDVeus0T2vAHgv3hqDHyslN6bX1
         TcN1a+Gwjr0zTWLaO2DYGhHLZ+jGQMumPrzMPDd/88gf0+xM15cZJVCC11T2crFNSb
         BepRZJGMxCjqHKFRD+nDChYZ5eUFKSSz0OAr7lPmkz2xmZ+FbbT8VTAfjOPzvyo/FL
         HShAVY8iFXsfQ==
Date:   Thu, 4 Aug 2022 15:26:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] firmware/psci: Add debugfs support to ease debugging
Message-ID: <YuvXFhvecggOlSNP@sirena.org.uk>
References: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lLA8ezdjSYFQcsDA"
Content-Disposition: inline
In-Reply-To: <20220804131507.3738094-1-dmitry.baryshkov@linaro.org>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lLA8ezdjSYFQcsDA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2022 at 04:15:07PM +0300, Dmitry Baryshkov wrote:

> To ease debugging of PSCI supported features, add debugfs file called
> 'psci' describing PSCI and SMC CC versions, enabled features and
> options.

Reviewed-by: Mark Brown <broonie@kernel.org>

--lLA8ezdjSYFQcsDA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLr1xUACgkQJNaLcl1U
h9AdvQf/QoCaOK9nXSAn5nJhNIpJB+a5M/pKd52iK7mLTaAfaiYE1kIfkqnn0Mf6
fDeqGp7Jl7ICGToafNQZax2Qexmk3J4X+Xsi9cfjQbMYmpxJVVKtoaZNfm1aGeJ9
M4tVWm00BabZYACaAbZvBryc4tMlELq1oVldu6NZ2u7YMSyE2SqBiiOMX6JPFQec
xqv7psfSYDp4rMRKJ+2vaehyKEXeVWgnrH24sdWIywooWrI+VLG2+LBFfIdOszuB
YdXXfLWkC16LgrLGmXoPT5kH7r+B1DXKIDazLnnz/qa2B7S3xJk0TV1ov73AlWYN
pKe1V7tNR83Bbkcrq6zrG+lkYoatgQ==
=Cw/3
-----END PGP SIGNATURE-----

--lLA8ezdjSYFQcsDA--
