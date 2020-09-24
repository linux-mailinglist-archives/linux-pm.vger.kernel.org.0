Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07249276C80
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 10:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgIXI4k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgIXI4k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 04:56:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138B6C0613CE;
        Thu, 24 Sep 2020 01:56:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s13so2672595wmh.4;
        Thu, 24 Sep 2020 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pqs+J1Sv9kpntIdJgNiekZ8UffP3uDpup4UB75PEnZg=;
        b=usC52yTIu/+IzTCQwow4dnMk0ZeeNZE6aXxsWcalL1rc6NhV5yJMyJKz7DJOY4jP+j
         ch2wv3Yp59dFFfd9VuQe4sfkmzD1XC+WF48zldfJ2UnbxKkj+ZP7U1ISuYAWPQeccLOH
         OGZk3yb4PeETUy6cAANa6yoa26Bj9dEYLFQxfyhNBCLJ8VHJDlktc/dmumek+6YdKQpW
         2fUPlby/L9vOX3zmyeX2cs5d/JXmMo9+e7AbHDJegvRk1Vc6D8LBf9PEPuge3NkTPzvZ
         hj4kfk79QNBKi+KTS9EGCKGzDsyICy8CLtpGsirPxVJkKC4INaZjNYSdWLxmBZ67xCZE
         HhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pqs+J1Sv9kpntIdJgNiekZ8UffP3uDpup4UB75PEnZg=;
        b=eScdZLdlOyFlHPOjB3H3mMI+8WtUAJFJx61uJY0bm6wtULJt99OuRZ/nWt7FU5zelo
         KB68n2lDr9eX+saTBi+HlS/Z1yzm1XFjPDJBXJQaZw2y5PwOSXs0sbaGoCrnRTO2PlQ8
         /UR+9uw4byAFb8tH7jQBrGrJYJnshAgPuNnUsxXYvJDus/kdUcQE5Wvz3dWD9R9wz/gi
         T3FGYJiDds9hxcdmC9T+xNQgp8B4XlcQnGSPxsejuYqKD1mc9Vn8Vj18FePrOn2ea8P7
         Rh0jg023c6Ww1uVUJuH3ZKSRx0kHks7M9Gxv2Hj6hh9LUa7+OGsLYYDopUXiQNnlCTp4
         X9/w==
X-Gm-Message-State: AOAM5331qgp1fzBUvur/SvbfJxWvNmnnC5WaHusIkznN0DP9KoAAI7sc
        ip/IZoYOqIeFQUR/a0VDvyc=
X-Google-Smtp-Source: ABdhPJz7WrcGkH0KDksdqGWogi0X+u8A2rDNT3xOXHn+qcQERzdOeMAV7kPtEte91ONrpKs5IRYGTg==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr3728062wmb.171.1600937798747;
        Thu, 24 Sep 2020 01:56:38 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 18sm2548971wmj.28.2020.09.24.01.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:56:37 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:56:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ksitaraman@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Message-ID: <20200924085635.GA2483160@ulmo>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1600276277-7290-2-git-send-email-sumitg@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:41:16PM +0530, Sumit Gupta wrote:
> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
> and keeps changing slightly. This change returns a consistent value
> from freq_table. If the reconstructed frequency has acceptable delta
> from the last written value, then return the frequency corresponding
> to the last written ndiv value from freq_table. Otherwise, print a
> warning and return the reconstructed freq.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 66 ++++++++++++++++++++++++++++++++=
------
>  1 file changed, 57 insertions(+), 9 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sX0EACgkQ3SOs138+
s6FMuA/+Ih0Gjq9RqF+uARwFya4Fbl4De2//YHKptpN6ciYtBJ+7ZAYWC4ghoPi9
BaUXOIc7Fl/tkaRqEF8xaiEf5bk4hL7SiF9Wv8Z5oH8rssXDOD880JaFYMZwkzB1
cx3etG2Ba1hrBypYf4gw2rOYqb1y/vuq+JfQMNVmk/cJ9dMZXRUZV32BFcT9pxf1
RXSDE1QUsRsAmcZC3izMwdwuroVud6hvecYhhG1YFTfkrt6B07sw2J91wHlN7VTD
uhU7Dq5KPCcmFcWjboMrlfDyFEjO7/GblWUb56TW5za7MJAJ44R2+sTOAxIfU2Tc
2of/32xLb7k0GbSHNBd+M0eRBGmboh61SaPP0N1RuIuSAqBqIdDBaT+ng8wJ2T7G
OwnJotuBTAXHvU0Gr7rWiZfDssYmtsbh1BZfmfaWEme55yHD5BUi6enfn1r/AdRH
dMV7jjehFKcWLA8O0RB0R3Q7UJVAAfzuAcNkX2IkEMiauf36cf4O/JoIkE51/fLH
kDqZtAm8NEYL51wmF+B2Kl34WG3SLTiRpKS5YNAJ1OmlXdDEBm3+YuOsD8vS/Vv2
oam1yluD8MqUBNH0YYxUUA6pM+XSJDQCXe7pm+0Tz/oMfA9n48Fvta66V1tA8Gvn
wbOs2lscpafHoUwSqb2A388VusWTEv1/wgLsARP1togZVMpDsXY=
=zup6
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
