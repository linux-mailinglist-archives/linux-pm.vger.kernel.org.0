Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC32276C84
	for <lists+linux-pm@lfdr.de>; Thu, 24 Sep 2020 10:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgIXI4y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Sep 2020 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIXI4y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Sep 2020 04:56:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC1C0613CE;
        Thu, 24 Sep 2020 01:56:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d4so2676756wmd.5;
        Thu, 24 Sep 2020 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b+vCyePcASyFGhspPBbceHGqzeae6YWgXdySMvXHJPQ=;
        b=M0ft3ILmZ6fWlkUE08VmJstvfltv7aoLNTsVq3TDIhuOED2BGWNOi4PFhautDzpugW
         WrnSiPYq/RW2t836MVWYZieDqv3gVtftTknkgSzL712ZLdSiNiRj/aM/esnkhd5zyLqj
         NotuICH1vw/3yWKdVE9j5+Xrcrv1FhsPhFG7XKHUOpXy8a57DjBbcJAxuOd9jiq8IQ1O
         1tLbw2p3JG+lIIhhhTmIKN5Yk66f9rKJM67cf4Cf9Q2z0dwtunKRN8oZSNIdLERd+xpu
         AwMQfg4WXjgGu8U4wsOA97YUtBQhSG7xE4+G0VHkOp4Ken/PfcF1K6e4cr3JKXJCiGwx
         YPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b+vCyePcASyFGhspPBbceHGqzeae6YWgXdySMvXHJPQ=;
        b=fb53QsavK4rYUx9jPRlkawRdXhWn436ptaJvwyt1K3uJYJFMZENRoq1ghVD5bFvXOk
         dxTco7sKThWiBOprpryWKAICeJIgeYRk6KoNITMTE01x/u68e34b+H6p015v7gSNHC4p
         D58iDtRJWd++Aq6bpoq0ukZIbxHoUOFzpglbFu1gOIQ1lTPVCNkmz1A+Z8Awv1vKihyM
         bRu4evcHUhtzKxJCot+iYuGi+yWmiVk4Uk+xlUSQZgBY0udq3R+nH3HKFZeaUXkoz3tN
         c2e4Xbhv2kWqwKf7Zv+TXHGIfrVlfJ6dBYg+poo/nwbauf7ZTdWuycK2oS4U1KxvZ+FM
         qTiw==
X-Gm-Message-State: AOAM5309u1g3JPFEffjOWtKV6w/guDWjrA03sCCZJRvtdtUfSQL79OBm
        ioAft76PNFXZgxxN2waeNPA=
X-Google-Smtp-Source: ABdhPJza5ifso1pd+QfPKv1OfhuYFjTSetwREIoOFwIti6KXUTRxqB14SGMoTvpCQGJwsp6t+IQ1WQ==
X-Received: by 2002:a1c:1f08:: with SMTP id f8mr3612783wmf.168.1600937812650;
        Thu, 24 Sep 2020 01:56:52 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id n66sm2597837wmb.35.2020.09.24.01.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:56:51 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:56:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ksitaraman@nvidia.com, bbasu@nvidia.com
Subject: Re: [Patch 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Message-ID: <20200924085650.GB2483160@ulmo>
References: <1600276277-7290-1-git-send-email-sumitg@nvidia.com>
 <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <1600276277-7290-3-git-send-email-sumitg@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:41:17PM +0530, Sumit Gupta wrote:
> Warning coming during boot because the boot freq set by bootloader
> gets filtered out due to big freq steps while creating freq_table.
> Fixing this by setting closest ndiv value from freq_table.
> Warning:
>   cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>   cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
>=20
> Also, added change in init to wait till current frequency becomes
> equal or near to the previously requested frequency. This is done
> because it takes some time to restore the previous frequency while
> turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 118 +++++++++++++++++++++++++++++++=
+++---
>  1 file changed, 111 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sX1EACgkQ3SOs138+
s6GGiA/9E37Nq3uNMS/H/CmiUxJqDpYP44ubhyJPYN17A05WDIAnslc0u8H6F5f+
2OVEVyibvEyXI56oLIZO4k8wQ0ffEw61Fmv7lKriDp1UEv3ZvuIu39X9znliuyVM
1+bSiXkhU4oyabmeN3iDHXa8lC66DPMF2hgLZqWvbYUZNIXIK0iNdw1KeNLTyOgB
UlBrOrTEPB81Wa/Yv8UuVvJO8oIYgKuya7hAgSjhOSLkO9q01lTLnf1EDj+1epLF
5XlmYsg04vdxDIboIlzDUsq01Rwm2mfxeDMcHD7zhDgo5euoh4SEVEjWQmf80zhK
PWP2A+xnODEzl9l5nGdUYx4cMca4ABmTvWKLeQtMbLwgSBxDV0eSpjEd+SlxuZYU
BcHJ6S8Oof3VuHN8zoA3T1S6jjqGayj+zVgJYtfOsJOUMsPQ2YEvXDuBVmPaKmy4
B8JTgOehMnfQ8XB6V6Gu1d/KxJqvnr0rLmR1YNnovOuEImPyiWcKnlEJv9xJI0s6
yXK2VNFmeBXnbNkqeixYxIaN7pUnCdIYIoFrQakOCzqL3V3Ud2N75mykjDDjMvcM
YbrP9TkdSyXP5aKY/E1QfHpT11avIFNO+2wa5uQKDAb4HAqNleVfm5LdyvbnR95K
lAPZHW6ffHuYXub+TzX5YXf8VS+bVH2lZyYZHAQXTqMb083yoZY=
=Hd6C
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
