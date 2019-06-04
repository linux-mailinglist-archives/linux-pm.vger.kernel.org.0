Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B1349CE
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfFDOKg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 10:10:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37946 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfFDOKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 10:10:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so220412wmh.3;
        Tue, 04 Jun 2019 07:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MQWqnTPlMzq7RFdsPJKNaftIwxm2Lc34V6bRTX+Tfwo=;
        b=atzLld6h4CKQyI/4lFPboJMv2pm8uRk7p6FD7sjdir1Th3+kWeM3IPGivKigl19Ev6
         Yg1bdCDK3UMamefNtAfjc2oxK6BpDw4URX5BPhaGGTyqXsfOeliOLn4QIGGfoRpUed7+
         9H+Ia0aaX52Cm8d3/1eZctHnuqV+zK3DdQQDG3cw0gPaVzas763IK0a+2Q4O04bwvWhh
         AdeopgfwAwFltVeSNDtdqZ9p6fh3uLNW+EBQrqxwNf3mgOv43FvVZhjKQRQXdVDJOMUT
         ljATMS9tS+nrLWjCvngi2o32M8qh4nuSt0/zrkJ5UsUt32qLAola+5Hvhhi0kSAsPpRC
         LUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MQWqnTPlMzq7RFdsPJKNaftIwxm2Lc34V6bRTX+Tfwo=;
        b=cMLeXw7+HDYhMplrSeTCwSKDcSXTu9SEjK6y/rTXXkWWkvY4x8uf9W+yS2vc5nBeEf
         9u+lPWIgkf+wxkATfKZrnmLCAykgdUChRcoinThGuwhnzKoORcrXmjJFqW3xrwnfWyLp
         CI4wlQDE7H4b6neJPf7JrK3LPEU5L5rKykw4lPgnD1PB/+fLocH61GSy+0CYNAmyQpBT
         HhzQV2KjYt3Z8zk33TLw7vjYj6n+osv1stzs08KD65Ai+ChCyD1LFH5GpeIfP4NG3ihS
         124xh5cFKIJ4k0wLnNQKnlgyfKKtkCWuXMYSuzZwBNTunh3hj/fn5eXJN3z4owA8X+Gv
         TmqA==
X-Gm-Message-State: APjAAAU/pQZAKRbycdMBGKzxLymntYXHa5sMMzTGTY7+6cvftnHw8Lx1
        HqJYZqEnIwXBLLeAxKWnSJ8=
X-Google-Smtp-Source: APXvYqwSjpawjPwIm+UKAqYA7R7GBTeTSB6g2Oebf3dshW7QAiQVDwb9DUK+sLE7TJ9uv/c7BLw2bg==
X-Received: by 2002:a1c:9c02:: with SMTP id f2mr18695262wme.8.1559657433513;
        Tue, 04 Jun 2019 07:10:33 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id f197sm18574336wme.39.2019.06.04.07.10.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 07:10:32 -0700 (PDT)
Date:   Tue, 4 Jun 2019 16:10:31 +0200
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
Message-ID: <20190604141031.GB397@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com>
 <20190604112026.GN16519@ulmo>
 <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 04:53:17PM +0300, Dmitry Osipenko wrote:
> 04.06.2019 14:20, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
> >> The driver's compilation doesn't have any specific dependencies, hence
> >> the COMPILE_TEST option can be supported in Kconfig.
> >>
> >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  drivers/devfreq/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> >> index 56db9dc05edb..a6bba6e1e7d9 100644
> >> --- a/drivers/devfreq/Kconfig
> >> +++ b/drivers/devfreq/Kconfig
> >> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
> >> =20
> >>  config ARM_TEGRA_DEVFREQ
> >>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> >> -	depends on ARCH_TEGRA
> >> +	depends on ARCH_TEGRA || COMPILE_TEST
> >>  	select PM_OPP
> >>  	help
> >>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> >=20
> > You need to be careful with these. You're using I/O register accessors,
> > which are not supported on the UM architecture, for example.
> >=20
> > This may end up getting flagged during build testing.
>=20
> We have similar cases in other drivers and it doesn't cause any known
> problems because (I think) build-bots are aware of this detail. Hence

I don't understand how the build-bots would be aware of this detail.
Unless you explicitly state what the dependencies are, how would the
build-bots know? Perhaps there's some logic built-in somewhere that I
don't know about?

> there is no real need to be overreactive here and in this particular
> case it's better to react to real problems once they show up (we already
> did that by fixing build breakage caused by a CLK API problem found by
> bot in v3). Does it sound like a good argument to you? ACK?

No. This strikes me as a strange argument. I'm pointing out a potential
source of problems and you just brush it aside claiming that it's not
true, or even if it was true that we'll see eventually and we can fix it
up when there's an actual problem.

Why would you want to have to fix things up if you can avoid breakage in
the first place by being a little proactive?

Thierry

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2e9cACgkQ3SOs138+
s6E4kw/+I6WkfUA6GnWVtk4560uJsTWMw63natQl7Vz+UpCHky4vw7eUN+Pt7Erc
eiN0fPVTsblMKeZ6LuweWk8ZtZ5iqNAaeBYu43DbiqJ60x+WxShfucYjgnLM+4F+
G/fuIInBSMDbe3TzIMS1C/C7pIgWbkdrsadU+j0Z/PFp/WJ4JElXWgxG+aeOW3wo
lIIgU7Wzz9aCVktOkVkz738FCzv84dE79zoeMpMPTSpjCha3d5NkXmFhzvcNTJ3z
vOFt0MWiFwzLjzR2oxfWNUgleB4oGNeRslL7uEakleZEPcDquDS31fNyzlZ/1iPU
ZC7EH5aWc9GCGXhUFLkQrMt30PJa+huwCIFL20fWwpLhoHdSzdBMOmEg2z4xIpoY
1DsWC52KpF1soSoYN3EHhqd/9GKGMW9ZSGicsXuI+i0ZY5lW02O11pvC9ZgVUwKY
xHIY6+9oDmnVAHNIxRN3VwrfaeEgu+snV4cngeBtv/Lmh0XHPVKelUSjgAlVJ3nB
8x/r+tjq18K6XGOWSxHFggtxFMwdGRmJnfCBrNItemdOZsQ8vTRUvjM29bgLD7EU
kVj1JQIDKDqnVIyYDBwo2OquIPyznVMXXNMhoP3M/QGp70OWnj9Y2sWod0vr1zSh
2Pj6WiWBwhBcZXQQKv9McEbxgQBnE0Gca8u1BBKlin5Jc/V1Dl8=
=uV5V
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
