Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF29C344D4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfFDKyv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 06:54:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37751 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfFDKyv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 06:54:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so5989052wmg.2;
        Tue, 04 Jun 2019 03:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j6hUjIqRG1YkL75o/DPFfpMfo/IVNVfXJC4sNpNd0tg=;
        b=APWwtvePIWTDcmPk7AtpRlDbr1f2wInftq4QFEJXHzXrs/AXrq6ZbwtQ6YVl7LxQSc
         OCrQKXigLLaA0wNdtGjyDGmGgZpSRWsnhoNLR+hiD5Cn4c81m48Xovo/n6axPPo0K86t
         k8ZV0YwsVLhYgj5Ocx6ujK13fNgxIY3QROEmaetKSyh4SQ1/axt/exIWF8thZkdo6AYo
         jwmcOCjvNiDZ9MdIzwb9s4QhLF9mSh8ZogUMm6xNW+FIgkdJXVGfH4UUzvBBpYjoKQ7x
         BeAXdkKv+r1swHZ2ySRHqSQstSfq+0Pps0Ce0tRJ12MRhC7k050di+ydIzofqtbej1xN
         HMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j6hUjIqRG1YkL75o/DPFfpMfo/IVNVfXJC4sNpNd0tg=;
        b=gwRQ/2HqaeqnRfLOrMFKaqDhz/Eqm8mzloQ/4nV1P2grSVvVPnHlg6uGBD8gRKr4sE
         +2hDMX6HN83sBYfp3HTJH5MDFzBhBi0N8q13cp2VkQo9OvdTKPyh/A3BqN9qHk9JDEtE
         sn0MmnG5ElPDPusbBvSXxCBHjgjYju18N5egyo1ZHup2pAJET3fW1oT3LuUr95D/VJPq
         Gncd7I5xQRqdAqZMiI1RDMEbZf5wnT9xeQp/0BCM3RVG66btyVQf0zdwjJz76rTTNYRM
         v0/Rzdx0aM7abySEWXa9R1jVCFS0L41f//FoNnTNqPjRxxHyQRdKCoL+X7vHP/c8P+sw
         AG/A==
X-Gm-Message-State: APjAAAU2+Wqpa2mMApN/75MWm0dmrooCiq6rNFJBfQW4PUVJBMPTJFw6
        eHORhN2L8Ri6rcFatqMfn04=
X-Google-Smtp-Source: APXvYqxutJ6NBBR2g6rHF5LKUIMrFLHnOtdFcq1XJfM/uFiLfMehOpzohOS+/agVOJNsl49BvO9GHA==
X-Received: by 2002:a1c:be03:: with SMTP id o3mr17643273wmf.139.1559645688942;
        Tue, 04 Jun 2019 03:54:48 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id b5sm13175277wrx.22.2019.06.04.03.54.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 03:54:47 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:54:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/16] PM / devfreq: tegra: Fix kHz to Hz conversion
Message-ID: <20190604105446.GA16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-2-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:00AM +0300, Dmitry Osipenko wrote:
> The kHz to Hz is incorrectly converted in a few places in the code,
> this results in a wrong frequency being calculated because devfreq core
> uses OPP frequencies that are given in Hz to clamp the rate, while
> tegra-devfreq gives to the core value in kHz and then it also expects to
> receive value in kHz from the core. In a result memory freq is always set
> to a value which is close to ULONG_MAX because of the bug. Hence the EMC
> frequency is always capped to the maximum and the driver doesn't do
> anything useful. This patch was tested on Tegra30 and Tegra124 SoC's, EMC
> frequency scaling works properly now.
>=20
> Cc: <stable@vger.kernel.org> # 4.14+
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2TfQACgkQ3SOs138+
s6GExg/9HsPjT2SjCQvZabaE2o3s+/XY1gquN4JnV0phciJyXkDiCEYstAtLTcwR
K464Jww0SwHI9j28NVkTwfCI5ZCV8PJgjY+5R/NRSW0JidhZS8AaMKkFfCMa8Ubz
8KBWHvn+iRlGR4Lpssr/nWPqk0NLga+exxpzQVQmY7iPZ02yxoC3sNiJmbXHT54F
o7QgAd1qwFST5DQ/yMHzZK27iUhFdupDGkyb2BVh2X0y6q2iseuvoW5at81ZuoVI
TB8Knl5dWItuG/ERGfnfoU8hV5i7RJDzTcnlLh//GSdD4cpRLGFVDbDE7lgnd4vq
DSCu/I4befv91FmHVIgEgI5qmccCzm9sFUrRT3Ga8hGtclm/namJyL8std4Jxh+b
9s7O9EeBAo/ZisfXhlzZnY5mg2Z8dfCxwxbxXhPZE/Mz6/ndmGfVFKsXRIvVBd5f
lDn71dlug/uXWQ5Tudkz/23JQyGW6dbQK14BZPt/2EEygyJnsmJckQuyOYUhy3Ak
xBkemlaQNzBS/ILhs7TVKA/+EFkdS/8Fcow5Kl4RdORdx9aXpbNxPIOMNWqyJYVH
v7Y0DsHPN98oshCFNQ7K0z9XIV6auZrlZ7RCnyfXhCz4NLQcxlrGYGQX6NIafFN8
ZXJgm+e4fuFBdNGBWUeh5STwqInQ4zLEdp9RwywxzH+SUoA6ePg=
=8Afm
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
