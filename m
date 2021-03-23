Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8EB34678A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 19:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhCWS0C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCWSZi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 14:25:38 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B4C061574;
        Tue, 23 Mar 2021 11:25:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o19so24572271edc.3;
        Tue, 23 Mar 2021 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RL/yMvfsbK2kLwVMu3qOXkXrjIz29yMvsOfbsVlvXuk=;
        b=casirC+q54L+/GDTIVWTQ9+s7i7XGQut4WdeZOSWnaZ/V+F00SrARas3jdyvojt8pR
         i5DnYJxgvAuTnK9NNC4LpznZSuFwUndPX6qv2FrrETWyHTpYr3N+LEgsMbYJyuo6KrfP
         v5dHagLwpJ6m1/QruTy4G5cMc0APTvpI6wVElE+nNo5897Pb9s9w78dVEyC1GH91FPD0
         It9k94nIfdcIcqwYMaH2t9m6kloxlCMN50V7X9yOYQ9Vjf6wQYZ4Jm8kp3JSp7m/zwFk
         cjmZh7Nq2LgbqrM0OnWVDjyjBXvqPcf2cX1I0k9rby4bLDMr+NtBtXvMvJfRD0N4irMR
         t8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RL/yMvfsbK2kLwVMu3qOXkXrjIz29yMvsOfbsVlvXuk=;
        b=W6I1bBrLUnjyToo8ZUAV2iDJBla545ecUtnEXxmE/Gqo4le+nS4AGFqnlws52OoWDg
         SBSNJCXuzCLxMF6nFjoW5ogfPYXPSEkQFcjco+6xXGBAOXkLfHZFvxLLEQPJaXRagT3g
         sSE9gqD8Chf4iDmiCqZ37H0RcM2sanQQO06y6o+Bt7ftTWxnlc3wurvCrA7X4qh0UqDO
         v0im9FYF1z6/5UHSOOu4dAIgJ1QCGVx+O+XaWXIBUcs1Hs+mcdhnQ4aV9kojQ1YAXAof
         vkSr3SicsfRG07VDnEhL8GkkOwoHodD/FX0al3tsaIkAOE1K2Ozkd1neNiLCAjYobgLE
         FkMw==
X-Gm-Message-State: AOAM530C4tyILyL1fRtbFoZwvZxeBXoHkjyKKs9BzS7qKW1rbjSx2ZSd
        ucHapH6XGTYWA0RKlBdOLkw=
X-Google-Smtp-Source: ABdhPJydKbSF4UEFWOTRuav/CiK1rgiPR9YcVluCGcIPzynZGxrHESDRplRTFIlyyMnn51IVzU623w==
X-Received: by 2002:a05:6402:5113:: with SMTP id m19mr6062668edd.78.1616523936651;
        Tue, 23 Mar 2021 11:25:36 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id si7sm11667903ejb.84.2021.03.23.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 11:25:30 -0700 (PDT)
Date:   Tue, 23 Mar 2021 19:25:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] thermal: Fix a typo in the file soctherm.c
Message-ID: <YFoyrxkZWrHmu8Ll@orome.fritz.box>
References: <20210305015320.7614-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t3F6Uw8G/Uh7que2"
Content-Disposition: inline
In-Reply-To: <20210305015320.7614-1-unixbhaskar@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--t3F6Uw8G/Uh7que2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 05, 2021 at 07:23:20AM +0530, Bhaskar Chowdhury wrote:
>=20
> s/calibaration/calibration/
>=20
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--t3F6Uw8G/Uh7que2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBaMq8ACgkQ3SOs138+
s6HgrRAAmGguCBaPzSxRoiAWGnB8WW8dtR9aHF6aoz6npvlyb+vXvF2ZdWgM0pAN
L2jwQSbqkWSDRGurJ2LZzIifOXrKPYc+bcb9geSN56vBFtLfJyY6q6OD1w7y/2VI
WyCJ/LTWeFigDynt81GEFkZUNcgIxESuddCHHiWKVLN5VKCniNWqDASDdOUXg/pn
eyNfK9NXygF1VxjFsyyLKbrN1NEdtc/XM85lUVnBao+8WMSOjsk84R2ea/jGCSs/
q2ZhV0jwYHpp1Vfuh9nWMZzje1HhX4r1QIwTbsqLznagAX6bqBCu4cBEh2DoDG5Z
/Yxf07kcnXdmqZBPRXnRiHg/d0djQl+KzR/ftGWPfNOP8qlmuPB/WmIbLZuul86z
rtEm2NQHc6rx6CGMTPjnE8rvGeZACz2ITaxezR1AabbOsj+9Wb+tOSbnKjPEiICo
KWwY0Yy3WpQn7C2W2Zg1FHhrRV2mAu9sgldIxbg3NnJaHwEoWGkKMF3biOEwZMp8
JCtRKC8WPoKLkEFzzULoCkPAoikpCH0bcL7XVpdiatSMh5hmrOLXSqVLlyB8MrPC
MNQUR2xIX5REqIOo37q+eYeLsLgtm79dWkTYzMd0YpSCe64bHkPkSga9FK3GUA4y
x2+6tz19Gs28io3FkwgveGZBlmTGj/O9lltdeyA61q5epQ3hfTE=
=s+sR
-----END PGP SIGNATURE-----

--t3F6Uw8G/Uh7que2--
