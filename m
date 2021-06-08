Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1435D39F8E1
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhFHOW1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 10:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233171AbhFHOW1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Jun 2021 10:22:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D36B660FE9;
        Tue,  8 Jun 2021 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623162034;
        bh=HIjfdYmy1mTiOKJ3G+Wb1ajuH0CxVdj2NhvkjfwnlVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QHufanTg9UstcH6XnmIY5hfMbAyyjEWCcYNeq6ejN46KO2ixz/O3roSV/N8B5ved3
         Jk1NcZjY74jq4e3PpHKbSLLqaJ3qmBoARv/3fwNPCZ39j7ONyOkqi8gkC9Xaj2mbY4
         OTooSz8XU/nit0Sb82mKxXYPSLBUtjqZadIhQadXjgkdYwF1G/AT1GOQKCPOQlWKXH
         XNBvOas/pnUUYtUvz+czv5golUSRz/f9XqB6+GzhRs0JJ1dEDvSV7w7pJ+4GDHqaIU
         0RY8NCctwSxOFcWsl18VWkQROP82cwR6ZHvPhRxnGKn0N5FxOgFfFuGKMG86zJ7jjv
         3W1tSFNkQr0qg==
Date:   Tue, 8 Jun 2021 15:20:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 4/4] PM: domains: Drop/restore performance state votes
 for devices at system PM
Message-ID: <20210608142019.GG4200@sirena.org.uk>
References: <20210603093438.138705-1-ulf.hansson@linaro.org>
 <20210603093438.138705-5-ulf.hansson@linaro.org>
 <CAPDyKFp2dKFQpLMgazXumCxf=FHQ9bdadXUkGsjiAwniF8p2dw@mail.gmail.com>
 <YL9oMVqox7GVASen@gerhold.net>
 <CAPDyKFrvrikCZLX1EvmLZumeCnfAxUUssO2OWc130TG8oey=qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <CAPDyKFrvrikCZLX1EvmLZumeCnfAxUUssO2OWc130TG8oey=qw@mail.gmail.com>
X-Cookie: Auction:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 08, 2021 at 04:08:55PM +0200, Ulf Hansson wrote:

> Honestly, I am not sure about what the regulator-fixed-domain intends
> to model, but I assume it's something that fits well to be modelled as
> a plain regulator, to start with.

> Perhaps Mark can chime in and spread some light over this?

IIRC it's for situations where there's a device that's normally built as
a separate chip that got built into a bigger SoC and wants to rear end
something onto a power domain, I guess especially if the power domain
doesn't cover the whole of a Linux device.

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC/fKIACgkQJNaLcl1U
h9CDbwf9Ett6A9yT6kCMwKY16CHTSdgFwOxfrV/bgjoSyph+f3tT31mZLbM3DHol
7D4nq6EAVR/AGYB7OAsZoHgr9yur2RvWWwA1hKlLTle8H+kL0HuK3kZuUqeyqSpU
s8FrLDH88MCUgjLc9pU0j0hINcD3e1qANqflGK/3cXB8+G2WAjSh0719iRYdbw1Z
k+nvcrw5UC8yBm7aoaeNUL81gCcEvanLnjvKg6ht9/lxRi9+KfOjiib3vW9hTk64
NCOJXBGsi/+83s2x+WZXi+B/2SwjhmCqODilMwj61QP6kihLxXmb26iCJK5imt2q
/bNYGkW36TdNg5hA4/Cvj5ANJCOpTw==
=R/90
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
