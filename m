Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCB1C768D
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgEFQeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 12:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729444AbgEFQeE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 12:34:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E433DC061A0F;
        Wed,  6 May 2020 09:34:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so3463264wmg.1;
        Wed, 06 May 2020 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q8sZQSMERASH94Sij/wps+JkNYz0VWUUx51TDJrhZWo=;
        b=gNZWMgL7v5TpvCTEDOk2L/ZDeU/aluuwXOndDHrKHmyWZcD3Yv5ANBfdqY9uuZn9Vy
         R3OOUjM8YBPJQBPGmr8rQpB7Opr3UWxKjT69ihzkpcC9vz8K523/Rya/gdHpePmnep9f
         fd1imP4VNrrvx/JTlbWfXspzaLhtjqcd3fhRyDibJC0xAeyliULmphDuFKVX9HGpuJbY
         72Slskb/I2AQhArYkVAEGoVjHoyUN2g2CVRFaOp8WwyZWvX54kf8IJdDiaXLfjUmfKtl
         Zk87Ppx9KSvAoaEz2VFx7vtTSPdYZMv1xA/UXmgqqYpHnAc8xTqUx1yLCY7oX3BFnjAQ
         5oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q8sZQSMERASH94Sij/wps+JkNYz0VWUUx51TDJrhZWo=;
        b=pSpn0VA0bRGjGNwOeXf8S6IVQxWbfklqrdBU4v7j/PlfYOpedjjNKO4LrpY84ohLr2
         RcdJDSfOTLiietw8gWFRcxsYfe2X42JlEKfhc39R5rg4F9/R5BVd80ro9nIQ2cdLaRhc
         1dTIS5hBwu7ampZ/MI+xUdk8Sqiit10gx3NDkOInUxRBKOZgPbEslMsJsERO04DGkAg0
         WIq1pzmTL3tHmcEjuK5PjNr3bxIFKXPbGj6Lyfa0S9QzQ9g81YVLFnBCOxGaevCJUD+v
         2guw2Q8+5UDuuTy5wJqEiq0ZFGSh/8PRJinzONMmulwCA3XCRw+XKr4CLho4lqldV8Mo
         mj3Q==
X-Gm-Message-State: AGi0PuatZLhBkfnABp3qHrAbcUNPx5Ln9HM9eQCJdT6Lan3NvPQ5uHUe
        PoAf2j3hVwfquQZ+SSqgGcY=
X-Google-Smtp-Source: APiQypLYy3YyWbFmNmplgPZ7qjDnRa1vssONWXPoYvSMk7IsRP7T0xshAFYGPqx3uix25l6x+I3W6Q==
X-Received: by 2002:a1c:6142:: with SMTP id v63mr524778wmb.61.1588782842639;
        Wed, 06 May 2020 09:34:02 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id d133sm4203098wmc.27.2020.05.06.09.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:34:01 -0700 (PDT)
Date:   Wed, 6 May 2020 18:34:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] ARM: tegra: Initialize r0 register for firmware
 wake-up
Message-ID: <20200506163400.GB2723057@ulmo>
References: <20200324224335.5825-1-digetx@gmail.com>
 <20200324224335.5825-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20200324224335.5825-2-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 01:43:33AM +0300, Dmitry Osipenko wrote:
> Downstream kernel of ASUS TF300T sets r0 to #3. There is no explanation in
> downstream code whether this is really needed and some of T30 downstream
> kernels have and explicit comment telling that all arguments are ignored
> by firmware. Let's take a safe side by replicating behavior of the TF300T
> downstream kernel. This change works fine on Ouya and Nexus 7 devices.
>=20
> Tested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/reset-handler.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to for-5.8/arm/core, thanks.

Thierry

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6y5vgACgkQ3SOs138+
s6FeZw//bsTtyKAUaZPjgynbaktNBPBlZ19Zn+dT5GDNmvazxZUBprVCYl3AY1Qj
OJ1v65x2LXKFcPmJ4xRMk/M8mnZLchWeIfHIWRtMjUepgQ7Y4VlVB5U6GjuQfNa2
BJxCoW/XyLLYFp9Pz1lfrpcsaVAMZ9YI5zk4XfKoFvWLlLbO0FHkg4pF62uZ/+sy
rSYWNF5X9Cteqjm6R0LddQmx2ari9nFr2UqYv2jX86OaalBgoh4UfSu/cuYSu5bH
3B/6GUNLWh5tIiMpCa7+mn5FvCYXrF38HWQdIvZm2QBM0TDIDWaGfC0VyQFppu0H
QxDOtpxiXqDVGYZ820XApvM/pqULDdeEyGxUgX7kdlR6ecUPQUaivIleEYvWMrkH
RphS2Ddf4tCc+KPt64bX+emiEX2yNDiqnj1ow99pPq+UqTtCmbbpSsePFPyujAyC
KmHS7j8zbJvXG8MpHF2JVNjcH1pcmQ39r0r/97YMH86iS69sdpAkvOVr1I7uHyJH
kwmPLu2n8XvzDpqWCMm3OCfqF5xApGlaac3zy2hfwd3YJzmoOduRVNmZMVxCMcmn
G/905hO8upsMCvFOFkAO2gGqnzAhg7A4nYWVMqdTM6dMPJ4jEyVKCVdTq8yLS6z4
xvJd7HDSbY2p2ETt79uQe7hSGzacHO34JBBxkqLYTsOMb7/oFkE=
=kqr0
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
