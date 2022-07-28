Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B565C584025
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 15:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiG1NiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG1NiM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 09:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6514D178;
        Thu, 28 Jul 2022 06:38:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 518A061D45;
        Thu, 28 Jul 2022 13:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D982C433D6;
        Thu, 28 Jul 2022 13:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659015489;
        bh=mmsn/t+5QNmM/FD9heL+FjFHsGTIQcd9xFxfGr8LHzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeIWgEYZiNwFxd3GVsR/NJ2ps0rFuovH3OyVXj6idgqySzM5Ia6bBFqXWnQM/K82j
         8D+xcAI3NxP4Ov82OJUtvK4jc5YjeDIo6e9n1jELfEBUv33J0xStbJTuEu42rz/te9
         IxdGUKMq4Y8wz3VeyOLqyhkpe2+OJ6dKVoOIwqBVDJ0A3ENP7bBNLNuXS72+1TWTYK
         y+RspS2qIj8PFh2e0K4tqb4R9jYPzUlZQcTWjSxaR9I+anWs7svppFS7aIOKr4/5mb
         J1+0c9F7fYrJ8jLM+iWSUdQm9cBDhGW2E1Swcgd+KQtwWxc28hkoP88qfri9H4vLAq
         D6d9pozm7mYfw==
Date:   Thu, 28 Jul 2022 14:38:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] firmware/psci: Add debugfs support to ease debugging
Message-ID: <YuKRPB/Ilb0al3ro@sirena.org.uk>
References: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YBGfuNYEyJDOClJJ"
Content-Disposition: inline
In-Reply-To: <20220727200901.1142557-1-dmitry.baryshkov@linaro.org>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--YBGfuNYEyJDOClJJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 27, 2022 at 11:09:01PM +0300, Dmitry Baryshkov wrote:

> +} psci_fn_ids[] = {
> +	PSCI_ID_NATIVE(0_2, MIGRATE),
> +	PSCI_ID(0_2, MIGRATE_INFO_TYPE),
> +	PSCI_ID_NATIVE(0_2, MIGRATE_INFO_UP_CPU),
> +	PSCI_ID(1_0, CPU_FREEZE),
> +	PSCI_ID_NATIVE(1_0, CPU_DEFAULT_SUSPEND),
> +	PSCI_ID_NATIVE(1_0, NODE_HW_STATE),
> +	PSCI_ID_NATIVE(1_0, SYSTEM_SUSPEND),
> +	PSCI_ID(1_0, SET_SUSPEND_MODE),
> +	PSCI_ID_NATIVE(1_0, STAT_RESIDENCY),
> +	PSCI_ID_NATIVE(1_0, STAT_COUNT),
> +	PSCI_ID_NATIVE(1_1, SYSTEM_RESET2),
> +};

There's other functions like the MEM_PROTECT ones which we don't
currently use but it might be interesting to enumerate...

>  #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
> +#define PSCI_1_0_FN_CPU_FREEZE			PSCI_0_2_FN(11)
> +#define PSCI_1_0_FN_CPU_DEFAULT_SUSPEND		PSCI_0_2_FN(12)

...we're already adding functions here.

> +#define PSCI_1_0_FN_NODE_HW_STATE		PSCI_0_2_FN(13)

> +#define PSCI_1_0_FN_STAT_RESIDENCY		PSCI_0_2_FN(16)
> +#define PSCI_1_0_FN_STAT_COUNT			PSCI_0_2_FN(17)

Some of these state query things might be interesting to actually call
and output results from at some point, doesn't seem like something that
should be a blocker though.

--YBGfuNYEyJDOClJJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLikTwACgkQJNaLcl1U
h9BAnwf/RzOG3aFKcvv9K/vZw2k6o3L2Of7BgJ00FEx9o/5mPNrSxvgslC9yvxev
QQVtI98A4XOjk6gFpmk9OiwlFztF1McyaaDQxmngmaOct2cPYu4NM3p8//4gJJfr
RQs9kHZSQ5Q5CbA0vycWH9+7DHPX9WUxbbMuFiDfqpd2WaJx7G+U1Uz8e1DqHyq1
wxwztBOFidoL+rQNqK2TY4RBzIIR2EFAHfKiu6Y4hFlm91qrHPe+YEbkW8Yoa+Xl
+G0L4btuYdJL7g/Dt6gUD7ApUdA17LhvifMcq+HJsaH004DuVOquZK+K9rHEmiAE
JqWJs6IX9t++1fUdsxFvgIEs2fczJQ==
=+kLn
-----END PGP SIGNATURE-----

--YBGfuNYEyJDOClJJ--
