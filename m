Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FBD395829
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 11:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhEaJhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhEaJhT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 05:37:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A4C061574;
        Mon, 31 May 2021 02:35:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m18so10234266wrv.2;
        Mon, 31 May 2021 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ly9AaPG/TnBSSS83zSBvw+Xqtn1byWzWgSJ6l5C6p6A=;
        b=hovhcxUoR6QIZLVIAGVXGKz8VmDUl5l3ritQTkstU0pQdInjKXsrIewv2xPLbyRG8z
         BULU9IVsDlQMGSOSkNlPbJPOMvTZ7rCstu/LeYXmgaNjVA2o0KpZ/2VnrgUQl1Z5Xaub
         tM9QeDdo4FhSLg/42ndS3OYUWfkbvF5p2ZYWh6CHVBCyW5/6IellWWekj4hzH+iFGbm1
         6CSpQeU3Rd4QcDhCiZwtCU66PKWFgmNumgSFfdHbHCEef4rH3yxlrVBexG+Ze9y2rvyk
         C4PN7ti6BeaKJjZOkR5ZkK0d/q/3kMCG+dOhIm46GwYWmddsVgiMc6vPEzl02klMgBRA
         PA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ly9AaPG/TnBSSS83zSBvw+Xqtn1byWzWgSJ6l5C6p6A=;
        b=nPwHnshli8W5OXEQOIXNsIPAlkqhNbJNQCKH1jntWnmkoPnMe7QII4J/gjcqLVF6Qd
         qc89gr5bMvfPYthfpsEQrnV+/tDvvGy+pcgQeIMj/0WlDI1Iex1/7W8ftyJ09NN4RUGd
         6vt4kQazz85khTkoQQA/iOoJ4DW3bI1oEDqMHaztTDOYxAwiEUPwgNak37KOGAf65K7g
         tw8Mvcu5Z8cAM8eVC6cLwjok+zJC2kPXT9qOpuLPdH3eKcCk0K+BicJUW04r4Sp9T9Ho
         URwdBSXK185W5sjRPSIB/aj4Utb5r/wRGPxE7/wYrO5iVTemjeOIbviClt0Qz41LHKl+
         bU6A==
X-Gm-Message-State: AOAM533DPYAotbvQa2RgvJthr05yrYlSK1gDy+eeh3b46QBE6Vrb+yQp
        eCepaM51maJKQ8K8mf6PKpQ=
X-Google-Smtp-Source: ABdhPJyubuNWTifdWAO/rrX20fMehgJwWHia9jY2FBQBJCn5XRbQsZNh63lv/UwumRwcEhfgfP4iaQ==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr1687554wrl.225.1622453737185;
        Mon, 31 May 2021 02:35:37 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id a123sm23132507wmd.2.2021.05.31.02.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 02:35:36 -0700 (PDT)
Date:   Mon, 31 May 2021 11:37:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/7] dt-bindings: devfreq: tegra30-actmon: Add
 cooling-cells
Message-ID: <YLSuRjuuRIlrkXIQ@orome.fritz.box>
References: <20210510211008.30300-1-digetx@gmail.com>
 <20210510211008.30300-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DTIhLsHFmQdoYjnN"
Content-Disposition: inline
In-Reply-To: <20210510211008.30300-5-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--DTIhLsHFmQdoYjnN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 11, 2021 at 12:10:05AM +0300, Dmitry Osipenko wrote:
> The ACTMON watches activity of memory clients. Decisions about a minimum
> required frequency are made based on the info from ACTMON. We can use
> ACTMON as a thermal cooling device by limiting the required frequency.
> Document new cooling-cells property of NVIDIA Tegra ACTMON hardware unit.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml   | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--DTIhLsHFmQdoYjnN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC0rkYACgkQ3SOs138+
s6FE0xAAvgUW7mPsf5QAiJG5JWXM/AV3Woi8uZGSz67Eoi1gyRuOzr81wVGZW7nE
3BZS9lfV7Sk/zbN7BKYpkOry/onZhmSTh0NXF8CUwHa1KwYIKxPR6YobscKEh9o9
893hMUE7/Up0fvofNRUJc4pAYq4rJ5mn3o5g1LiFPzFUVyM+HDonrmSQ3yMegTKv
F4OgsKoqqmmUtD1xG5MfFjbKdYkmtEu/YILZbKFMwzu5KgpvSh6O/hfSAB0EXESO
ZF6dB7GDvFYzLypO/7uD8KTxV6D6B2fkVoskqmPfgMXd+o1GWAZPAeQA1I6PhAl9
B9FibJ2t4ibqRwINpLxduDC7iVCQ0eKta0gLjpLq9Lq6i///7VQrkxrjWkkNbO61
eODr3dIeqEX5cnpmLf3KW4uCOE9b7PdWdWv+j9xKhw2HtKE5H0XYITJR1vvWm4tz
btuwcKIgWTU+fOnF0fY0ef4OGyVauPQDChmSu5QbW1j1voU6ONQ0VNp84m52hCGU
yuc3N+h4ZjuewY0d3TGiRSYEL+grbYfePwyNG9yiWQcDWo4/+eJ6h5JGDS1/VFAY
t8HNllK98joJPBGbaPaYGTbb2SRTWPNE9HDHSmI9uVq2pvVd+8Y+qhOR3/nCAuNW
JRKhUX3nNL0HiSfRfXZ/zhDg/AWOMK7peVzR8ukmZ1aWoESd8tw=
=FWYi
-----END PGP SIGNATURE-----

--DTIhLsHFmQdoYjnN--
