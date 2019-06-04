Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD572349F9
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfFDOSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 10:18:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43627 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfFDOS3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 10:18:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id r18so7023059wrm.10;
        Tue, 04 Jun 2019 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S9zrJFzxYRxLUT1/SPOIghnXyFo4ytUocRQg75AR/FY=;
        b=GiIZlVs/g3OqBZuf8vlc+PXsYsX2qmirDelFMIwstZHcmj4Ta0bFr6cd4Kul6yFaWe
         EVetSxs/POrl7BqeQmkUo5ZCIEFI4iGQ4btfLvt1h6dz1PK3frTzVKh6eSzL0htStzyC
         ejc747KyzMngLs2/+GUDb6k9JdZkeu72sYhY37GR68tMSxN9l8KiZAudh1PHo2YqNked
         YydlgfiHQpzW1ouBh6U44bnabPiuCt63RstasBMQSdp46DjGnRtE3bduLf5MmUKEnsH0
         qsU6SX0hC1ioRH2MF0E1KPcAg0lamlFgR0jowMS/lkddS8W4bYQkcEefE3LyiKj97IwZ
         8Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S9zrJFzxYRxLUT1/SPOIghnXyFo4ytUocRQg75AR/FY=;
        b=rlF8UO3QD59lOLmhmbMTOC9ojTmXstqTJj019HYMdByFkpbLSb4uhi9P4jgC6++47I
         8OZuIZw43r+iq0gpUFxZ1Wy98Lybk0PsBKeyCeoDiEVCt3+XnydEiJrb0yrHB4eZ2952
         0vAKA8hv1uGQ5M0ucKJnoiyAS1cHVRbH6QUHyfbsH6LOTbtYC+z7cUkxQvXLmQVB2rDf
         EzcMq3coGvwWXxdULHaeMMllWmkKEPRh3TCTeSPpE3GGTm5kdWlXvsUpWzp69uLz8C/S
         KYSpmSaYGcoMaPvasEn6HFRFyK46UQHLUUEjE42LaHMhA56xJ1F7hsk7AU150dpyAYRB
         ocGw==
X-Gm-Message-State: APjAAAXsSEcJ3TqolbjHBZ9mWYQoTT1f6UMoP5A/iBeQI+UdUxt4kp/y
        NTTW/2Uag5mXsl2XFzpok54=
X-Google-Smtp-Source: APXvYqyy40vQeDJnOUIDdSIDyX8txeyfnom7aq9SImuvxInYffU6wk6N2e+HlkhQv+dj1dffbV4dJA==
X-Received: by 2002:adf:9d41:: with SMTP id o1mr3176842wre.97.1559657907540;
        Tue, 04 Jun 2019 07:18:27 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z14sm14632388wrh.86.2019.06.04.07.18.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 07:18:25 -0700 (PDT)
Date:   Tue, 4 Jun 2019 16:18:24 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/16] PM / devfreq: tegra: Enable COMPILE_TEST for
 the driver
Message-ID: <20190604141824.GC397@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com>
 <20190604112026.GN16519@ulmo>
 <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com>
 <20190604141031.GB397@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20190604141031.GB397@ulmo>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 04:10:31PM +0200, Thierry Reding wrote:
> On Tue, Jun 04, 2019 at 04:53:17PM +0300, Dmitry Osipenko wrote:
> > 04.06.2019 14:20, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
> > >> The driver's compilation doesn't have any specific dependencies, hen=
ce
> > >> the COMPILE_TEST option can be supported in Kconfig.
> > >>
> > >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >> ---
> > >>  drivers/devfreq/Kconfig | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > >> index 56db9dc05edb..a6bba6e1e7d9 100644
> > >> --- a/drivers/devfreq/Kconfig
> > >> +++ b/drivers/devfreq/Kconfig
> > >> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
> > >> =20
> > >>  config ARM_TEGRA_DEVFREQ
> > >>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> > >> -	depends on ARCH_TEGRA
> > >> +	depends on ARCH_TEGRA || COMPILE_TEST
> > >>  	select PM_OPP
> > >>  	help
> > >>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> > >=20
> > > You need to be careful with these. You're using I/O register accessor=
s,
> > > which are not supported on the UM architecture, for example.
> > >=20
> > > This may end up getting flagged during build testing.
> >=20
> > We have similar cases in other drivers and it doesn't cause any known
> > problems because (I think) build-bots are aware of this detail. Hence
>=20
> I don't understand how the build-bots would be aware of this detail.
> Unless you explicitly state what the dependencies are, how would the
> build-bots know? Perhaps there's some logic built-in somewhere that I
> don't know about?

So looks like COMPILE_TEST has a !UML dependency, so this might just
work.

Acked-by: Thierry Reding <treding@nvidia.com>

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2fbAACgkQ3SOs138+
s6EVPQ//RJTh/O16G49hE/V1NKwMIvrjN0VRbtevQgW8YFY2rMhB4qNY26FNmeMs
SDIjDd/BzLZcAoNp6+sHi6REcEzsxu3bVPflg1wVLsxq7s3hUN5QhJgj+1WEfFSi
b2mnDba5eSQF+GMK02OzCBUYkeevFuRiG7T3r4gee3eklEVthAgdaKC/B4pPC6R5
SvPx6HY1NAPO4K/6I6dVD6V0M9y8+6wl5DnlmmpbILv8IvKuCFvDYrherRRfTi/1
GhmI/3HxABYmUJ2/0hqG29jYZzVkhQKhQBsWgGw99ChoBZBecNcrGgEqUkOrC3Yv
1KuPMsgo95Q53jf5wv4coYcurNigJbzbYaaQ0hisaccJ8+kWJvTPyN0cpDiLywo3
rGfdJ+WvIMHInOlc/QhqsPaXg/2KiJ01sbZqqChY7XFwJ34fJPXBVilOoIOHXuIT
KgLorQAXRfd1bf1Ldxwjo4aBs5X1Tl82c+XXcDgpMXF1x3A5UYDBbAFkryOx5eJs
3bLHldict3egH0v1/e9JWYViw6zA+HXWj1q7KRsilPA05gJsXfjYdvvv5JTljjKN
DLr95nZekLcTRCpGFLM9S/K269RYgWib92WdSBqItLQtWShLaT5lU4SS31PqpVs3
uLdwMmxwP04/ftK49Dr+3TCKJ/35XeEVE1SM2nviTu5Dk0ZRDpA=
=kAOC
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
