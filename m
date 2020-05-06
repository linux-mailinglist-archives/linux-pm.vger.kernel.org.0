Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9C11C768A
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 18:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgEFQdp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729782AbgEFQdp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 12:33:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F3CC061A0F;
        Wed,  6 May 2020 09:33:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k1so2973632wrx.4;
        Wed, 06 May 2020 09:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hs7hesXGArHThfGx/Rh9jc8uqq11ihzRu7Lngz0Mp+c=;
        b=TajA5uNgt7j4IfZTONS9SHkbj1pbInQ4t0SL1A1H9EHKxtsvFfceanjr/TdZknXBUm
         25uidV9QUXQ+W/Mk4YkCBmNtUdWcSqWkOD1i9FuhW3ored27bZbeFtM/4sQwXX8mJSKY
         C+CLkM4xtP1mX63UQ0baE+x1UQSFicN2Ui0fSqWJsjoaZkPKjjSqT4yYumtZ4j9MBkiG
         /3dLWp9ZFAyCfXC8gk6+190MUy0jR7RZ8sqzqDWGBhLmAWFACZrITUWmZgQYQFg03aAg
         3Y1iXjeK1ZECzdkGO7W2VlO9etroYGyk1d4xvjYLXN03vnezIVNN/R0Jjs0R5cc1APty
         1v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hs7hesXGArHThfGx/Rh9jc8uqq11ihzRu7Lngz0Mp+c=;
        b=TXpRbqNJkeZs98yVSLwbnbrkdp/5AKaZN7Lu/e6qVTcuiD9dJVyUVumIXsLAy4nJeC
         KcT1skoADDnqtLtmkKHkq/R4h8ePwcPmVY3BOyzuMoYy7yFOLhoN00WHN5pwKl9/g8K8
         sdocrI7B1ZhQw6N+J7z+Hcq7fl6FeWj4k4gJNdpj00dk4ZMoxbTg2df14reS5tQgtJzn
         cZYFXnLiYgYoTtjcXl2EUccVbaM/gPZ7Pfq/jkNzDePM4NTIb8+kAiMwXt7wEj9HYVBW
         PMGtP15gyZ1bA5LnQ9eRQNL+hi8Bze6o9yu8tY2uc9FP6yF0UVAwzN3KCiGnHybzVXw+
         4BHQ==
X-Gm-Message-State: AGi0PuY+92a6pcPteM3z8Fr+6yleiRBUAelNDalWuEXG5fO7xw5gxgkC
        h1cIYO1KiDD3qkoH4lf7lS8KSNLsTWQ=
X-Google-Smtp-Source: APiQypLy2E6xNuMya2A6Hba9VAH45cA6Od8lBs2p4mPUaM1iugwvbBr7orC41puRJGF8nZmg9OUauQ==
X-Received: by 2002:adf:f648:: with SMTP id x8mr10292985wrp.257.1588782823577;
        Wed, 06 May 2020 09:33:43 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id i17sm3753649wml.23.2020.05.06.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:33:42 -0700 (PDT)
Date:   Wed, 6 May 2020 18:33:41 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] cpuidle: tegra: Support CPU cluster power-down
 state on Tegra30
Message-ID: <20200506163341.GA2723057@ulmo>
References: <20200324224335.5825-1-digetx@gmail.com>
 <20200324224335.5825-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20200324224335.5825-4-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 01:43:35AM +0300, Dmitry Osipenko wrote:
> The new Tegra CPU Idle driver now has a unified code path for the coupled
> CC6 (LP2) state, this allows to enable the deepest idling state on Tegra30
> SoC where the whole CPU cluster is power-gated.
>=20
> Tested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-tegra.c | 1 -
>  1 file changed, 1 deletion(-)

Daniel,

do you mind if I pick this up into the Tegra tree because of the runtime
dependencies on the firmware and ARM core changes in patches 1 & 2?

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6y5uIACgkQ3SOs138+
s6ELSg/+ODvaAUgkUW/e00mnp5rjl66/K9AQ6QUsvJwNoMl/3hKUNb2YOSIsiLck
h0POrtB4ShVEuibgWQqHanbVX90LC45500sxKDSpEz7ypUiuj+WyRLcsoV1PxEIK
SluqiHdGV+hELIlD3OiZSayTrWefPrzVTBotXomJWiEBhsL4333gvhiFQJmRvQAL
MKV1XBC1ay7FG2cdww33YpW8JAYgQnO1+ABVbI/d8LKbEXJFKxIOtpUOMWRc2AGH
MV/60S4fnebPWrF0psf6kGka5z0BDgxwYD5Cs2KjARpefJ5U6VQyW9k+B16F3Ul3
ID6C/EhM/uGwVvERaFI7TbJEaNGCaNdhC1c1Qm7b+Ez5p/iWBzZ/o72OV4gnXkqr
CSWVS7323VtouMc+Rd0sXNnZkOtBFrRPJkdC/Pjt9lfbfYwFbigDlbAmWuQ8PvLS
eXOH3JiSnrYHgjximbzLjcq4GHP20wMC6CImAb9xrHj2sndAvuBXMwaOw2TKKYY8
lXZSG/k3OACXIMzU1+FGvG4MHeBq/vcz9cRxduTMMI1gwcnRof5fXBJyDtxf/Q6Z
Sa1/Jpvw5Hd7hPHb44AyGoc+CEZpbnRFG89oLAzu/bPIbu5rqiA2eHF2zyUL/h2s
/68FiSsJiX2agbiyxrACmlJgn7HXPNnfql/i9Zhre4HA2my/kRo=
=EK7n
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
