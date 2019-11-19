Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 288CE101955
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKSGZl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 01:25:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51307 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSGZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 01:25:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id q70so1827505wme.1;
        Mon, 18 Nov 2019 22:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZm4sOxMyoOoYclUyl/vfhH6u2IOXUm4suTk6nszyok=;
        b=Yiqd6pjG6ktM3XxyjCUZa/7AMM+8ozQQGaJKCGS8o9raWOxhMoDyKXtkElV2yXWa5M
         N9zltULthX97i9mdo2fUgNgJkfw23e4zCd4o5+HF2bk81P+1YwwSwmeHu2SZRtwoFfnx
         pncCoueE9uzydnvstQELW3XKJCDPL0i8veErV6a05MHNws5zgPTpbjqqho9Kqi6srQ86
         YewbCOP2VIiSN5HDc+n1ftJTmpT7UXowjyXfbF7zjPIFJUORMRQEiE+YsYwPtBJIl4W3
         osKo5pou63ks4M0vq6DQZ8fpLCUr79ye5i3qiX99o7JrnQFFMGTa0cOOUfa7BlLVb4FN
         Vu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZm4sOxMyoOoYclUyl/vfhH6u2IOXUm4suTk6nszyok=;
        b=iG/QeGP4WkLEFHeE9MZkFS3V679LdivGeXk+R7ZpoRZ+carm6/r4czvXz5EXpi9ogp
         FmyWZyvGcAe0lXyLQkJRbN06uLcAUQro/csPouekWq0GSoH2scU3oRAp10wyF2WfM3lE
         B0oe+CHwMGj1W4ZEHmbx4Kt4UY4zC8iGNa8pVtgJaKvIeZNEOXWba15hJmmWqTigdDF2
         Y3rxERvYimHLkwoaNu0/6Wyuyf6TDL5bDddOLvM3FoipG6ZR56NoE8woA9yWKkX4x8tD
         pCGjrdYxqPPnw+fSYOh+tozNdnwgwcouH2jj+8nxP1sQKQWnAtEAXoBeA79rF3HEIZWN
         9s+w==
X-Gm-Message-State: APjAAAWu8OZOFPkrTh3OwpCVfn4FOQjqUqho5slQXZX7kNfcuXJJu4mb
        3UqBf5OcacN8DeCS1brLnZxa+EpgXLo=
X-Google-Smtp-Source: APXvYqyAis4bl7PWhIuYsHN+2KSsTzBWr9seQcMALKCWwQE4VgSk3xAvaxjRWMB71V2pZdmbj1x2DQ==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr3168359wmb.87.1574144737937;
        Mon, 18 Nov 2019 22:25:37 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id h16sm25071871wrs.48.2019.11.18.22.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 22:25:36 -0800 (PST)
Date:   Tue, 19 Nov 2019 07:25:35 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 08/29] dt-bindings: interconnect: tegra: Add initial
 IDs
Message-ID: <20191119062535.GC2462695@ulmo>
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <20191118200247.3567-9-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:02:26PM +0300, Dmitry Osipenko wrote:
> Define interconnect IDs for memory controller (MC), external memory
> controller (EMC), external memory (EMEM) and memory clients of display
> controllers (DC).
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/interconnect/tegra-icc.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/tegra-icc.h

There was a bit of discussion regarding this for a recent patch that I
was working on, see:

	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D140318

I'd rather not use an additional set of definitions for this. The memory
controller already has a set of native IDs for memory clients that I
think we can reuse for this.

I've only added these client IDs for Tegra194 because that's where we
need it to actually describe a specific hardware quirk, but I can come
up with the equivalent for older chips as well.

Thierry

> diff --git a/include/dt-bindings/interconnect/tegra-icc.h b/include/dt-bi=
ndings/interconnect/tegra-icc.h
> new file mode 100644
> index 000000000000..e6b6a819434a
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/tegra-icc.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef DT_BINDINGS_ICC_TEGRA_H
> +#define DT_BINDINGS_ICC_TEGRA_H
> +
> +#define TEGRA_ICC_EMC			0
> +#define TEGRA_ICC_EMEM			1
> +#define TEGRA_ICC_MC			2
> +#define TEGRA_ICC_MC_DC			3
> +#define TEGRA_ICC_MC_DCB		4
> +
> +#endif
> --=20
> 2.23.0
>=20

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3Tit8ACgkQ3SOs138+
s6FbJQ//VVTt70KCgYKF7BpZnoqtwCSp/64y3GlIbyP1biK5lLzBZzmmtlm6ivKf
pqxNy8JoBbunV+2+mNyT5YWfKXEcpFW/eLPcklnZwFjVVx9j5suAzdHeybkt4G3h
g2ChCvkLAD/oDmmUvKDje+Mo51CdDlmk5FgKiZQoBr5r3wMCW2hg7aCiv54VgQJt
uPv+7kFsNRiaku0ZoW9iiDKPAhdMT7PDAoHwGX4z+ugBha/iFr1q24olO0Glub75
j35vMrNPXZUEP74vlGyfqhMrOqZoIEuI8vTbEe9pBqbgAYTJEclUIrwt9oX3u6sR
58My8zbNHmFD1P0xNFqLTDyKeOhHAMkTofF70v88IiL0YH7hTsxPFIIN1T9Z4l2F
lPpAScOhh/8pNOJsoC7TJgssD+VFJMTwU6CZTEgcR4rarjN1JZIU1b/+NqyU+3n9
bbIZ1g7hXLKuldou1GENsFUFUomaQg+0+nXNd8McDufr6wNp9qwEaI4aGdFvWaxK
CM7FotJCcqq4OejmSnAFypwWoPEjkAKbmWm7C8aINkoA3W7Bnq7kNvCm900WXX0r
/Al1ZCihymQE7Z03xBGlZqHmHB936PInmasQ+QhQeoAhJ6cWXY28XYIwsUnhy/IN
MVm9blRz9OFwT1y3iHz7ow7XxFLljf//K1VKFcXhM4orcsqQd2I=
=lq7Q
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
