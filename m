Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6834506
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfFDLCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:02:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfFDLCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:02:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so15343748wro.4;
        Tue, 04 Jun 2019 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X+Qt9syBo+khoR1+eqd8VXHCxwK9HB5deywwnkENYtA=;
        b=RDUPLamKnVS6AAxmJ7c5Ce8yXMuSbWHNeS7A/J/HaJn+NKmXjWvatB0z2NNbgEEfEL
         iStMsQsmi8lSgiXZPuPwG2KP6MMBOdOoH3+f/nqtke96BKARRBUsinsoLwoqC2t9eYyS
         0GrCGZ7cNxRvkLszpJRiK3O8NKvQ4DNEtVKjXN/HEjTUS3IO6M1e5/768H1DLs4hprsz
         a3hfftUvAV/kyjH5fv3ORfvZdYiUUVh3fP6AGHKmF0STEXNQM0KWozPyWot2k/2C8WDm
         SOjKlnIEIz6Eat/8z8PULUEJmv533ldLC/Bavz2T0/Oe8efr0i4S/EZe7DPHOUPdbBSR
         /6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X+Qt9syBo+khoR1+eqd8VXHCxwK9HB5deywwnkENYtA=;
        b=oGnBjgqyu8LEcpKKHvKG+nBdRIlHl0R1D/eOZL4ClnN/tt3Vi5V/72UnRZdd5V3+nt
         jhPR2Ds+pKmGAAl04f3o4OyMWA54/CI5F/uCCHIbOkK65ALwzYN5ILdGjxLkOEn+1cSm
         A2exhgugx0qXgeemKXVe00fiCWiJ+MMXeL6fIC7IDU1/YsR55q8hsRsRxxOzQefK8vbQ
         4n85CtViDitqZL4gp7gadQGw/v1QOT0QgU4OED54l7c4AZEP8DQ1vznAb5VKXYHTufch
         z3qxgpf87ZzM/tqRYOgkRx3nFIqyzgBMne3Gob2Fb/AhCO/BHxvY6a6zFN+gTg50FoD2
         ipYg==
X-Gm-Message-State: APjAAAVTH4l1su+wPhm/F+j6eeFjQ4v6VxJrSlsHFkO7na+K9K+URDLa
        Ehrm3KCo0IHpTs3TcC7UyN4=
X-Google-Smtp-Source: APXvYqycs+QpsRNlIeGDUvtW4H/vuKIr/oYYPw3HHggaOAeZd5FYnnb5xquiqvSpjH2QZQMuLD2YuA==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr6340569wrv.164.1559646148748;
        Tue, 04 Jun 2019 04:02:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id p11sm12221216wrs.5.2019.06.04.04.02.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:02:27 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:02:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] PM / devfreq: tegra: Drop primary interrupt
 handler
Message-ID: <20190604110227.GF16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-7-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:05AM +0300, Dmitry Osipenko wrote:
> There is no real need in the primary interrupt handler, hence move
> everything to the secondary (threaded) handler. In a result locking
> is consistent now and there are no potential races with the interrupt
> handler because it is protected with the devfreq's mutex.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 55 +++++++++++----------------------
>  1 file changed, 18 insertions(+), 37 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2T8IACgkQ3SOs138+
s6HFSw/+PSPTGfTFdmBQev7SxVPURWATpky1fpNGU7AlQZU5IOYQj5VqUBTGklgu
PU0Z1Ym3UYX4iIoyxdUpaD0rjl73+HV5Zwng41FN/sDNSxQC8jbMJvoCD+fLmh2F
i/pEySvqoqY/hlkIWuJGHTxnNOEeOYqJVdVQ4sM3xonRaJuK+XEcIN/k31wj48fI
kZoVtkvGB2pDSV5HQw0FhT4u1vmmW1BsM1S9hHm5sx+yTD3GVS02KuxyERqItjir
IyYLDh7cxxaVjADMs79g6e/hWpQYIbqChhnT40kKLLJbnDePYONOHnJLUVP3RZ8O
ST7ItVYficG2gW5MO6rHyj7vG7oLatFg/QWbvhUFOmEAXOTmtKfz61WiuzIKVmrP
v5ZJ3sauUpiKbQX++Nk5RUMofjJx6mQkob9/AeUddERjOqiCqPx9ybc3BKaO0ocO
hGYLDCtG9vRpDZRcOycCaYcjMcVfss5e/wBRcGmcPqvnLEzj6M2dfWgFLJGiHexn
09basoJWtNU9a8hPhMd77ucS4+dUgH63JHsbizFNuB76va6lZjia7lfGx5GRw5O6
8QeiBr1WHqPYIXRdm3czTltXS8u8C/0bATgd9P8+TLTmfTC4V3AHcuwgVvCWrNUA
NgbRx7HUHpSh3Fy4KyyhadzlALW8hwQGZcaaN5K81v48WKdyrBQ=
=FeZ3
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
