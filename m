Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A92D3E8D87
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhHKJuM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhHKJuL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 05:50:11 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD98C061765;
        Wed, 11 Aug 2021 02:49:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r6so2197829wrt.4;
        Wed, 11 Aug 2021 02:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InP9e9WSss+4zqBvpjB1Gp8No7Ucwrc7WwdGFVYJuz0=;
        b=CiaLFTJR+kcHgWHKg5doWB9jQVcCR9DmVQ5ocqm+wbnC17KPScsd4ET9T1cSU5xsWd
         aEbiCsmxUjVcZmcSEB2XZUd6ClT5covp0XCPWPUEufgDuLHKuIJfMept/gYCYfNF2snN
         s5NHbmnnXQyw0O/T+xQn+qXplvLvISHqqYAoeYGpSJdUZrAeiPZnCvKxUcY/uCD1s786
         HwiX4ByQUZVQe1s/8XgzfJB/cQMXReR1KuAGjgLMdcp0WKDldD+3eZZAYSUxrU4eIsoN
         lzZWTYevf18V6wlU1aU4Ud5xuBcltjw7YmWRo2vvG/2Bvt1mwYa2XS22YhLrvRscwgTP
         y+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=InP9e9WSss+4zqBvpjB1Gp8No7Ucwrc7WwdGFVYJuz0=;
        b=WWqKq/fLDZjnRmQp1MLiTjK8xlJJMOhoSm+tw3yvmjgfWLCOKDZR+CvTUJyoEZVWg5
         JLrWxsS2egfIB9gj+vcZdDPTt5/qpq6rWiAgdnFlcg/AWjNjbTKANBW6z60s+5GJ85yH
         yAFLQzts4+V+WnyJT9wZwi0cMB8OdsRIY84ecP+dv/gN+pP5/PiKnBZeQsrxGYE7CBhq
         Yym2cw+y+cFs5JCq1OA+Ma4fZXPfaRcUH75q0ixeoUVDPrDls+SWEp0y3NLyPsfoBWYq
         FbujhdDtE5fGkFFn8NQX5h33XPh+Wx3OreimMF6rYMy3DFNk1Bm3LD7pljyIjpgGhs/i
         gzFw==
X-Gm-Message-State: AOAM530DK/JGvBuVUeL2XWrZmJ/Zi6gXW9nzP8FhH6U3UUim1ucSPgrD
        N1Y2oUmLgxPfOXuscHm4hA0=
X-Google-Smtp-Source: ABdhPJzcxpNl5KEbAU1AgAatUuCL5jXG9xEZHZlf1qYq7pV03jPHJJNb+AkVZxRFrTsGNJfTVp7ACA==
X-Received: by 2002:a05:6000:9:: with SMTP id h9mr22221085wrx.396.1628675386236;
        Wed, 11 Aug 2021 02:49:46 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c2sm25828931wrs.60.2021.08.11.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 02:49:45 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:52:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] soc/tegra: pmc: Prevent racing with cpuilde driver
Message-ID: <YROdyssO7qQU5kFR@orome.fritz.box>
References: <20210718212706.21659-1-digetx@gmail.com>
 <20210718212706.21659-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GO/E5Ljb5DmwgjgQ"
Content-Disposition: inline
In-Reply-To: <20210718212706.21659-2-digetx@gmail.com>
User-Agent: Mutt/2.1.1 (e2a89abc) (2021-07-12)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--GO/E5Ljb5DmwgjgQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 19, 2021 at 12:27:05AM +0300, Dmitry Osipenko wrote:
> Both PMC and cpuidle drivers are probed at the same init level and
> cpuidle depends on the PMC suspend mode. Add new default suspend mode
> that indicates whether PMC driver has been probed and reset the mode in
> a case of deferred probe of the PMC driver.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/pm.c    |  2 +-
>  arch/arm/mach-tegra/pm.h    |  6 ------
>  arch/arm/mach-tegra/tegra.c |  2 --
>  drivers/soc/tegra/pmc.c     | 14 +++++++++++++-
>  include/soc/tegra/pm.h      |  6 ++++++
>  5 files changed, 20 insertions(+), 10 deletions(-)

Applied, thanks.

Thierry

--GO/E5Ljb5DmwgjgQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmETncoACgkQ3SOs138+
s6G1rg/+Nkee2koAygYhXcPkVKL8bYEaz97g0KV6s6NbEJTNWZz3+vJgXx2KNmvZ
fn0MbmBiF248O+6x6J076aFF3BPZEQ3E7PYpvQfRz6Wcxe7dyDsJkC1e9WsN6+eM
o+9oSxklTO0GDyWlxAKQcjYBEOMJchxlR+jI40f8h8ex6c0CRUzjddltq4tbkK5g
tZReiYugPjKRyGeFGavvwGk4YZ6ZIeIdqmPE2EpVwCL+EBIF+gkMsFchGCDtsYxA
sCohdR9cfh6IfTAKPyz+Hk+LmbzgnFPchKmDV9WG7WAByWBurvF70EBzrB9DgeEM
7+AlNDBvzpvRcwqaso+Lw895cLJj9ZA6l4OGBg/0wFdqJyG0WZY8p81/K+budNea
5ReAKyBSFxiZGnU4Ygds4uOBsgk6LNAgXTjRU5hQSwrXy7TIJvlQ9t94zxSSVtuH
UrwND34ms56cqKxhH3wyV7fmNigymGPy1rurlBNhNwT39nK20IjjK49qoYCKO2IS
IogQHySphEHIsEh++ESjcb8zurGIwPQ5MS7V/VwTSLI78SJI3xdKoLPEdU51yHjK
aKyOZ3KVA6eUUYk5qDAmaYxlkSURm5NHSUQt7d+mArMoWopHvZ93GV+UHc+D8thp
sYZhN+15y2eAY/b1xdU+oXWLQv9EDQxFrvH75J0NVEp00pDgME0=
=+7DF
-----END PGP SIGNATURE-----

--GO/E5Ljb5DmwgjgQ--
