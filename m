Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDFC2C5A7C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391653AbgKZR0K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 12:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391347AbgKZR0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 12:26:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAEFC0613D4;
        Thu, 26 Nov 2020 09:26:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so2935880wrg.7;
        Thu, 26 Nov 2020 09:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6I0lhLGzPPM0MoECXGUi5YFC71JrYnGKvoQDQPmtiJ8=;
        b=l06CNRd31zgbywkafp4M3M36NmeEp98oXvZIbgFZaXjPDiITJXkrhLw6e82PRokFMq
         kSV+0rsWu3t278MiKn8FxZ0GpnGOdkRNRc8kI1ao3FfuuXk6Psqs49YxCD+ES1ohhwHn
         778H50Vz+qsL2LOxPPnWXeM9yik6M3kLd5UNS8iViAW/shl88g/0RGv+uzDhvTh02TDU
         G2JiVIVyK5ICAVInvipDuRW8GKiL5EgPM4rcdsxRdWxIgGHo1Ciw4FZ6SmbNfL7H12Gh
         po6yduAQos4jRyU+BqDlJWwB5xzD/y7S8MFJIyFKNtTN5wOfjlurvHwLREINC+5TBPxt
         BhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6I0lhLGzPPM0MoECXGUi5YFC71JrYnGKvoQDQPmtiJ8=;
        b=VYPXWMsYf4+FDeXqIsuYWkmCcOnJ56GBo2L9mcCD1JNDaDWZ/z5u9MwufJ6S3YPyEl
         UoQQl0FNRDjRPfZbaOvSaCerL6Op3UAqxFg/kH7AsY49pfcljj+920w4+VWpscWl4aOj
         t6DRjBLIc90t+s6y2GiQAD5U9r+mIqA/M6/h+THn9DeGGCaBeIeIeIONGGzBJMXLRmCI
         qjYNczZTfEP+0JCK799oXJKezY+seqxqaSy3qHsLttNudLdjIwQ+va/y6JiViHCkgI5w
         kiTDb7cZNijC10UqoNXTbUy4yJobj+i5x4WfV7xqqz4G1GYcwMxQDrLMHJRGvtG25y4A
         vqhg==
X-Gm-Message-State: AOAM530iQTbRUNTvRBxi4nrUe/sbg6YhWIGK9XCaiwb7mPpAs3EVs2Rp
        iG7ey2hCpXJ4n4MxVCjgSwk=
X-Google-Smtp-Source: ABdhPJyaBeHdgoQF3J1Ovn0wtkH7fvTi8SaOzT7ic/NJzEli3QaHlrGWzuvtjGLemmZWpI00pWevgQ==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr5123901wru.405.1606411568938;
        Thu, 26 Nov 2020 09:26:08 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id s4sm9982577wru.56.2020.11.26.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 09:26:07 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:26:05 +0100
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
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <X7/lLaZJNp+Vfczk@ulmo>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u/+LBcE/GZY9+OI4"
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-18-digetx@gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--u/+LBcE/GZY9+OI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> Each memory client has unique hardware ID, add these IDs.
>=20
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Is there any chance you could drop these dt-bindings include patches
(17, 18 and 19) so that I can pick them up into the Tegra tree? The
device tree changes that I was going to pick up depend on this and
fail to build if applied as-is.

I was looking at your linux-mem-ctrl tree and had initially thought I
could just pull in one of the branches to get these dependencies, but it
looks like the dt-bindings patches are on the for-v5.11/tegra-mc branch,
which the ARM SoC maintainers wouldn't like to see me pull in for a
dependency on device tree changes.

If this is all fixed at this point, I'll just have to push back the
device tree changes to v5.12, or perhaps see if the ARM SoC maintainers
are willing to take a late pull request that's based on v5.11-rc1.

Thierry

--u/+LBcE/GZY9+OI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/5SkACgkQ3SOs138+
s6E7hA/+KCUsyWXHkq1zseaJ5gCXuvTLINqhxC1oK5TJvCQ7BFh3567X8Qg1Sd85
W4KQS5u4lGrHEfDgGILPcdO/GdlOWrYLUpLVnwHMX4/F2Jy8Ey/cPHPDLN469A53
B0qntX6JoeJKFU/mGmvf0xQie/QpZvjBfMFrCdQhA/UueGOdJYBMKb8o5hmQgLi9
LWVnTdSrxaht6vl32SeO452KjQvUBZSnCh9weUvpzhcPtOJm8hn6Fnmc1erDw9bX
QokJFiB0XDvsFJoBtbQQx2/jHXFihBCdlxiuxJvEKb/0n3qrYzr6n9Vasjpb0gap
83nRKdl4MNJsJ6KjoMZtjVt93x37sam6giILq98SIKJos5jz4WK8PKUiOIyQZryb
AJL2NRM9gdtfUkm3YHcePioeyNsr2baRqF2kuv+VsnyYOHKqSilmRX0fOXn63kKg
0wNfDmMPA63/UfYSweeTnDZerFZdJwV04+PFOt6OCffoZEe+uDCnpmrn0Gv91Hrp
HJEai7zzj8yZqHUCqNRP8SadYHWXQjz0a42CoD1UHyoeMQnvApxCdAn3vQ9R6WBM
n0BdCx0blXhamA3xb2EPVwPZ4huLcxwCRTKDRcRMbMUL400k3MGk9EnHeXa85YgU
NKeI2QOdzGQ788QbBHfdD7iBjEPcHLx98w3zxgISsEElIUXDMfY=
=f5yy
-----END PGP SIGNATURE-----

--u/+LBcE/GZY9+OI4--
