Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64533D9339
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393751AbfJPOB2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 10:01:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50273 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393750AbfJPOB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 10:01:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so3071951wmg.0;
        Wed, 16 Oct 2019 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tkwolCFpRKx5qnqNxGR6We20ScAxiOW+QzsdK04jT4=;
        b=K0NeTObnG71lXifvS94m4TId7eL58ETa2T/GnPUYyqbCUBGXmDXHSPOKY6IYR/bF91
         Qq0KQsRo1HOV6JDWiRhUmxITUnexlMjNH07gFq0AL6852pAnsw5tpRrms2uMDw1aH3AY
         gnA0dvo9MujjDYxmytQ0G0TuVQdobcSzybGhJ2J8YhGLdjL9lMCDEjvKECmBsjzl6tx7
         ry8aZs38gaX4lcix+cNWHPx3fMNr4ufNCh1YSMsrjOgWufpA7saBAxcc6FfA/VSYdYKP
         eRyVSGWBU5v/qSMPJzXeUuljW5QEi18nRpENWRIwRRn/ixwH+WoVyEkMA2Ww2R99p26q
         Grbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tkwolCFpRKx5qnqNxGR6We20ScAxiOW+QzsdK04jT4=;
        b=SeI2DOQxOvO89orNryvKpub1yF9ubLRmJ4g9pQMKDV87cy4/8wj2U3roqwY4gvCjRM
         XHxeuwl1M1cuGv5f2No5EY6LMFxVGVdNI7J1wn7nPdG3JWUSqEo8JwN4w59jmzcG6nFj
         QKlLhyKbUPbKR9xObWRF3RmtWRnxaOCHaJwiGdYUrBvQ/+Pxji8t27X4gw3F03LLd7vE
         Dz43t+D8SKuUOzSzF6qNjqTqlS/+Shz5ji6P78nD3SZEVh1fAgj7UoTRetRYRYE3p+2w
         blNZRH8LB704BoVCaATRNl3jGOPdikcJnjDn7aTu9sXBRaYLwKuqT10KjOnW2A0OrWsb
         ytdw==
X-Gm-Message-State: APjAAAUZ3fwdnUaNOfur4/O7H/KpkXPgFLcxCY1M1Mf6meQafzUbO1mg
        4v0YcQ+85dVmUilCB3NvmoI=
X-Google-Smtp-Source: APXvYqz3fMJ3QIVHe9ejYBeq2FoKIVagsDUuq0HAJ3lgCd2RE2GNj2OiV2pOouE2sFRNYWoY0LhsSg==
X-Received: by 2002:a05:600c:1088:: with SMTP id e8mr3633948wmd.27.1571234485934;
        Wed, 16 Oct 2019 07:01:25 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p85sm2930949wme.23.2019.10.16.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:01:22 -0700 (PDT)
Date:   Wed, 16 Oct 2019 16:01:21 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/17] NVIDIA Tegra20 CPUFreq driver major update
Message-ID: <20191016140121.GA1862769@ulmo>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191016052716.yipztnpg7bcuzhfn@vireshk-i7>
 <8cf055a3-57fd-c275-9e74-a9fb5d284866@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <8cf055a3-57fd-c275-9e74-a9fb5d284866@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 04:16:27PM +0300, Dmitry Osipenko wrote:
> 16.10.2019 08:27, Viresh Kumar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On 16-10-19, 00:16, Dmitry Osipenko wrote:
> >> Hello,
> >>
> >> This series moves intermediate-clk handling from tegra20-cpufreq into
> >> tegra-clk driver, this allows us to switch to generic cpufreq-dt driver
> >> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
> >> of the box. All boards need to adopt CPU OPPs in their device-trees in
> >> order to get cpufreq support. This series adds OPPs only to selective
> >> boards because there is assumption in a current device-trees that CPU
> >> voltage is set for 1GHz freq and this won't work for those CPUs that
> >> can go over 1GHz and thus require voltage regulators to be set up for
> >> voltage scaling support (CC'ed Marcel for Toradex boards). We could
> >> probably add delete-node for OPPs over 1GHz if there are not actively
> >> maintained boards.
> >=20
> > How do you want to get these patches merged ? Can I just pick the cpufr=
eq bits
> > alone ?
> >=20
>=20
> The cpufreq bits strictly depend on the clk patches and the regulators
> coupler/balancer series. Hence all patches in this series should collect
> acks from relevant maintainers and then Thierry will pick up the
> patchsets in a correct order via tegra tree, at least that's my vision.
>=20
> Thierry, are you okay with that approach?

Works for me. I already have a set of clock patches that I'd like to
merge via the Tegra tree because of a runtime dependency, so it'd be
easy to apply these on top of that.

Thierry

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2nIq8ACgkQ3SOs138+
s6GKPg//XbFKPZrgCH3A4swB3MFOPVjalYqN2cVsMYZH/R73AJYSjqvMPnj44UM1
ecM/LKBu0RC/xZ9C6mU2DDKEbRDDLDSVIrNLhjh9tulMl267gWIqyCE5tqrkVnjy
3S50icwwg+Sxs4mgdnox6ZoPPWiCQrfq4bvv+03OMMZqgXISEKzegvOETGziIhaL
FANIUKkpZ8Kv+9+egwIcjCM32611IfpNAub/KuRpmZghvib1SV/SxgpLZ1hc3jND
ZkpzmUmAuwZbB/sco/f17FlfZ16+cIRE5D0NSlWH1cTt9YHfhuD1Rv/o4C9HLHly
rpXCJC/WHmevNz7RqheqKwXMc8ixqTcWeNoRpKFDiYfscGB0rR73uzmTMlRXdbch
JDD+Xa5BYBZrneP6GfIVHdouiDD3DhPkHoDvXdmyWmnrpZwQG6465b4+TAgEpR/o
uXmaYn4HtjGic6mYpbPUopYCg5awM7u4Of4PQdJLZcDI45UJzlpNVTXMS+pRpbkZ
YHPbcvPDL+jRE9Jnbl/rxHu+KQV/UmmKV5JPIEyoQKSaVkw/cFnXSyqARqaWds56
QJ2vZ7kZ2O08MkWzMamVcVqbdx8U1FX//09377bHHFbWhRsrAMcAX6keNq7hz7ZM
/a2zZszFLhQnisBXpX9RMUW37jiFYFn4rZYFM1feQZ/E+rtvIJ8=
=td2z
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
