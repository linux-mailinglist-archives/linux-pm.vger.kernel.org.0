Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B31F2CF1E5
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgLDQ2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 11:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbgLDQ2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 11:28:15 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739C6C0613D1;
        Fri,  4 Dec 2020 08:27:29 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l5so6401283edq.11;
        Fri, 04 Dec 2020 08:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+HmOhYRAWoPzFvO+6AKczOw7jzGt+H4bxGuXLCQXoc=;
        b=kgiRgJ4ywoZVvlEdS4dzVI217OLzYENw/cza8A9shThLkxM/Vo/JQhk1OFW+iwbf8p
         faqrHR4b0hyVBjAlknDZRqu5bNRkd1mMhJKxJuE+31Go9GbP7LcCSSw7WMt2KQqF+jnp
         nac4bYVxJ8GzsKoxFjCJTUGBOFwvRPzSEza0YzSseFzSvguVeQ1oOXIkKrvYZg1LRvis
         cuP011H/Rq04vO7HYRunZBmJ7vXbGr/7Hv8gnUIC5g75DzPP/+kqMsMqs3FUJxsSm2EN
         Na3R59zfW/HnR9eNGEzKA6RRdpSTpUCkBi6skZyrKB3QHHBeql3rinhsWPnH2THiFv/n
         HiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+HmOhYRAWoPzFvO+6AKczOw7jzGt+H4bxGuXLCQXoc=;
        b=Ak6JmA7yWPZiRDMZ67edZcOxjes6dgXcvXwwpCnuYyXvciouqYRUJFJu4gpMSCvW2M
         1FOe9IZe9nBXM00S/L4muxQ1qxYTpspkQ3AtwcuXvXdtr3Bgk4uZlqjFcdUNSFwTWDlu
         fpaKTAXKq+UhsaEG4tbfS8caU45vp80sIbih/v83N4LQSkasqCfbw6kc2zE2pOhDwnp5
         sEtu0s+CVq6AfXlIUlbBuNOdIBEXc1QR9cxRLHQjlm/CqCjzqCujt4btasSSIGlhPHIL
         1M2klsyOY9kJkRm18ElacWi2mG7EDrQcYrqG89kPz2b+WEdd7EX+eGl4NUZa9Z3aspAi
         OGxA==
X-Gm-Message-State: AOAM531KH4YoEy6F0r2+eqkwm0ZcujXHYfxcZCu2yjPbr3BIxwW6pNqD
        0YawIaSSDWLT9i5rmROJrIc=
X-Google-Smtp-Source: ABdhPJz4k6hB4aIWeMlptTvr8/KtGOvqe1S5zLT5t102zABDLV44vRb0th7M+TZOofj//Zr2RU6sgw==
X-Received: by 2002:a05:6402:746:: with SMTP id p6mr8397102edy.313.1607099248170;
        Fri, 04 Dec 2020 08:27:28 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b7sm3521209ejj.85.2020.12.04.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 08:27:26 -0800 (PST)
Date:   Fri, 4 Dec 2020 17:27:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v11 03/10] memory: tegra30: Support interconnect framework
Message-ID: <X8pjbV/gEIOp/2sM@ulmo>
References: <20201203192439.16177-1-digetx@gmail.com>
 <20201203192439.16177-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bTHofWPXsdPAY1Vz"
Content-Disposition: inline
In-Reply-To: <20201203192439.16177-4-digetx@gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bTHofWPXsdPAY1Vz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 10:24:32PM +0300, Dmitry Osipenko wrote:
> Now Internal and External memory controllers are memory interconnection
> providers. This allows us to use interconnect API for tuning of memory
> configuration. EMC driver now supports OPPs and DVFS. MC driver now
> supports tuning of memory arbitration latency, which needs to be done
> for ISO memory clients, like a Display client for example.
>=20
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Acked-by: Georgi Djakov <georgi.djakov@linaro.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |   1 +
>  drivers/memory/tegra/tegra30-emc.c | 344 +++++++++++++++++++++++++++--
>  drivers/memory/tegra/tegra30.c     | 173 ++++++++++++++-
>  3 files changed, 496 insertions(+), 22 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bTHofWPXsdPAY1Vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KY20ACgkQ3SOs138+
s6Engg//drHa8HENx4EvSwA5eoE9FKgNLKJPQdW/7BBtgBPmv0ImXomL5kKddSn5
O6SomluwfhV8QxJZR4eiIv04ptvLC8CuKtY21mgZFLZwJRBrVYq40h+VIqt3guAd
y5nEw3fALyFOeqOK76P80q2Qa7aLQguoPzfaa3dsDsBfnNG/CbgBj9vCL868UoB9
3u7oEv58jd+3YYx4HhlilcoHQp9yL2S5N3PEt/9hxxVTo+k6j6Vxk5+LnUz4Afl3
JsP4sOuwvFxWDIPoghYuaCc5dZ9qJurZ9z1SRIf6sYl/NU2t5ob+0Ec3f8X5OcuR
6tL1vHwlZ9UbB5t+qOJDfwdPO4Lx2dcxT70lxsBimV3Jc0i2oamRDMhK5VTBlKoQ
11GwxrrrS5uxuIr/60KA94IAptu+X98Nn9sZEJznuMZvKbBUBC6X2vJGd9WuL7uD
rx9xU3rulWs9BsBf9Rd+LeiJFpdVIukDTerJTIDsx2x9FEVc1m5gnz/2yVkcpCdU
AvpsRwbwO5pcl56U+fZ/EwljblwRLY3sX3mGTA7vk2PKSgigLDgB7itXStFPNR5j
PLMih36DUjxruXDwUK9R2P4o9Uxfb+A26WwPd/o84qIHj6hJneG3kW0WioV6dnwk
oItg/WELcMS+7DveCKW2IdpVkzJMc4PzeNqeGZxYvIbZc1BSPL4=
=UulD
-----END PGP SIGNATURE-----

--bTHofWPXsdPAY1Vz--
