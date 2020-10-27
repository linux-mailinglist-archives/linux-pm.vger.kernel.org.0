Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15329ADCB
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbgJ0NtX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:49:23 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36688 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbgJ0NtW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:49:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id l16so1511200eds.3;
        Tue, 27 Oct 2020 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZnQkxwgJ6i77+EDy7ii9SL2QSN3TsUPUF8gJzK7Sz2A=;
        b=C7L5ldZS0nW165WCgAWiA78F1DltzHr7uZvwIfgu1OR/PFMoHIvrDUhqmqdm91jLrr
         Uj5J7Ya4bD9GzRepdajFDKjbOzaAl75KTAaDA0T5oEZTcVIty8EFB+b7SDRB8xBBnsIz
         zaDtz8ScVAj9CunFwLuFXIgxuIav8MLQcKF7gmthk+m5ng3sRxXv3ibUiYPnpC3x2/rk
         Mzhejt14ZLAl6FDU6uZ2odTOGyT6W0C9aa1BsDTWo0lmDCu/S2itQoIy0cHBf/R2Pzow
         akVuSt4RXLEuo1VaifHUoWeN/aMhccy8yExyntXeCZAaQia1BtsQdTfFxfQ1JTpsvgZu
         71CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnQkxwgJ6i77+EDy7ii9SL2QSN3TsUPUF8gJzK7Sz2A=;
        b=HYTA1ZWQrz/nO/BP6BcADM2+gKVDE9okUK2t9mnnYFBwKo655OSs1bPMWYRz/Khha7
         BUPbm5D2VRcl/ftPl4qQawk2vKpurSRGfg73YKSWayifhAJ6CHr7hAd31vyfxMmPDmQ6
         c5SNX67CsgfnDTBMNcoAT60Hh+BK/2mmG/ABRqaEgCLA2cHU4kyesxqmHNN8RXqFtfYX
         KLr6Yn6fReBc3ik1pNymJtYpJayz9HVYNJLQdPqki1GMgfwH/J+DhntC88zOuCJLJ4JF
         ReBm9VADelUFDPPeAYPvU9yLRb2uvCRdTdOatR1vhuKaVg0/9CUu/ueWyoQoo58qKwzh
         Ammw==
X-Gm-Message-State: AOAM530IbLKrATwrx+1OJfTDdnkrjJ7H2RzsKeOdYhwvAkgaCWAx277I
        LLnAUrJkCoMX31zf5SvArMNn5/Dh184=
X-Google-Smtp-Source: ABdhPJyLImSrLnd0UnDtq1WDozpOz5Rbs7Y3xGZeJh9Wqk/YZ8OSbRrxILNooHJBec1dYS8bHABScQ==
X-Received: by 2002:a50:ab5b:: with SMTP id t27mr2314325edc.281.1603806559858;
        Tue, 27 Oct 2020 06:49:19 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id k18sm1012491eds.93.2020.10.27.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:49:18 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:49:17 +0100
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
Subject: Re: [PATCH v6 30/52] memory: tegra20-emc: Make driver modular
Message-ID: <20201027134917.GK1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-31-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yiup30KVCQiHUZFC"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-31-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--yiup30KVCQiHUZFC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:17:13AM +0300, Dmitry Osipenko wrote:
> This patch adds modularization support to the Tegra20 EMC driver. Driver
> now can be compiled as a loadable kernel module.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |  2 +-
>  drivers/memory/tegra/tegra20-emc.c | 17 ++++++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--yiup30KVCQiHUZFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YJV0ACgkQ3SOs138+
s6EUag/+OjWxEB4buJmoqYw0Rv+8ij1VT1G6Sh9iz75VISwmL6uRFeB3kAECbmpO
HY3HsZImaMg9qrDj+FRpXO+1mdKNUB3Bj0nhX3r39Ng6kfj+JQ1LB5p0zjGMXGpj
JECXzD7KIS21xiMZQDZKWF+FJQeJNwNZiBtQlpR1+CNtdLOL8kb3nwRfV1u/fwmG
v835gDSON0zLC5xgNpSchOvuf2SUze90N65hb9S7C8eo0U9fsBa64quS8+kzi/qn
h6rQVPUoElFh+rtthgslcgN/a7eiiKRfjxXfgX3yEcmEPwP6p2uCvZakf98y5stC
33H0Okyq1HynFA60lvAiArx+1U5iv6BFuMtQZelKAqMyZTiEMAUNYHWdSlEdNYp2
92HoBL98MkYM8fD1RHEhx95HFNEWnalA+45HKKLSU75YMkNSad4eQofRjFMr8+f9
45ewjoYSiPmWBsiIJ5SQrI5N7E/UWG1Stg25xAIBqBscCQXLMgv+3rkbxLe4oW/O
babLseIhIVNtYzP1bIcewYmSig/tmYG00RzBpQIddXESAzppjc4VtXRTk0mPWMJy
uk4aIKZHeher/uKxvDincboDjZvvyIqEV+Gt4NDnuDPubtdA/hQjwLXZaxNOWEhB
lFBJkwdhiry9LprfiUKk7GxygvRAd0qYjFM/SRB0cLyb/g7aR6E=
=TBNL
-----END PGP SIGNATURE-----

--yiup30KVCQiHUZFC--
