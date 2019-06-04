Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5492D34AED
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfFDOuJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 10:50:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34361 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfFDOuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 10:50:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2458349wmd.1;
        Tue, 04 Jun 2019 07:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aqvbyhYR5wvUaJWXPFI5ZIm4QTbMxDj2huXJqkiW5JA=;
        b=lLyXJnOcNWhCSPCAoD+O2x1pZQPITevIb8N/3NaQ2cPyNpKs2SHg5Ux5qqzBIWO3im
         qkTp+xYJLEqTyD+juZ3EFotQZCEff6fOcAOM+916cNUtnnTzKM2bRQ7k1C9KME6myXaO
         NTFxf1LZ9vEQwtxtSYScKkOUSLVk94btslDr8B/qHAVdOOM4zgdZytS2VcD4vlR843OJ
         iE+7b+t7G6Q4BmFT/yr4F7AsFfWPgyXW6oT5ojGRe9XDv8EEKegvMcEYVF+j6SAOiL1E
         zeFXS4jwT5kqweJywyNhDwq8B3oSo4BeXO+AUHs6v7qOfqQi2W+SrNMOSZZW9TQ8bmZX
         h1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aqvbyhYR5wvUaJWXPFI5ZIm4QTbMxDj2huXJqkiW5JA=;
        b=dTOh/V7gZAKgo6XTCZpX4yvViflTdmCwCx68YmL5o7TLbkQD/9tjQZ7zYQtPs8Fl/O
         QrPVcsSXsEn638cQkDULcLRnYQHK+dkdX4JJxzemXBvrwKxMUpSD2G2WB7g/b/52Q6OG
         kLDcpZ8dZO0I33MNHu1Z4mGxPVW2Hc/1s1Fjhl8MX5/K7gKKWFsVeJsTD5vUH/5nRHaN
         g4ERNWXFdLlBJ2+0D+OMPonRqPhIr9mH3G7PzH9U2ax/pdUa5lQYT0aqcwtQnoIHLW+R
         Mj5RJUAosodWAHUHqgaevJ0UcgiD7sEVVgfuKLDQIevu8/nFM3Onm6fMwZ8XzdCjO3C7
         LMgw==
X-Gm-Message-State: APjAAAUAcMNbXKcPtACUxeMsqK7zBJPxumrSZeQALGfp2TcHUUr0C2kk
        Ld61OkLqmk1oYsbdlF4vGKXM3org
X-Google-Smtp-Source: APXvYqyKwq7tGPXbRS7+jexXhWRP59PGiWGdykJawR/ipvhg83Lu103Ypr2KrGaGVMPyZU4SyWEwVw==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr19579005wmh.143.1559659806185;
        Tue, 04 Jun 2019 07:50:06 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id k184sm36377412wmk.0.2019.06.04.07.50.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 07:50:05 -0700 (PDT)
Date:   Tue, 4 Jun 2019 16:50:04 +0200
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
Message-ID: <20190604145004.GA3208@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-15-digetx@gmail.com>
 <20190604112026.GN16519@ulmo>
 <ed2c502f-8f49-d89b-32c6-4b5415e1fa47@gmail.com>
 <20190604141031.GB397@ulmo>
 <20190604141824.GC397@ulmo>
 <02a6651f-17f3-2e79-7780-57657596ba23@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <02a6651f-17f3-2e79-7780-57657596ba23@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 05:41:53PM +0300, Dmitry Osipenko wrote:
> 04.06.2019 17:18, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Jun 04, 2019 at 04:10:31PM +0200, Thierry Reding wrote:
> >> On Tue, Jun 04, 2019 at 04:53:17PM +0300, Dmitry Osipenko wrote:
> >>> 04.06.2019 14:20, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> On Thu, May 02, 2019 at 02:38:13AM +0300, Dmitry Osipenko wrote:
> >>>>> The driver's compilation doesn't have any specific dependencies, he=
nce
> >>>>> the COMPILE_TEST option can be supported in Kconfig.
> >>>>>
> >>>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>>> ---
> >>>>>  drivers/devfreq/Kconfig | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> >>>>> index 56db9dc05edb..a6bba6e1e7d9 100644
> >>>>> --- a/drivers/devfreq/Kconfig
> >>>>> +++ b/drivers/devfreq/Kconfig
> >>>>> @@ -93,7 +93,7 @@ config ARM_EXYNOS_BUS_DEVFREQ
> >>>>> =20
> >>>>>  config ARM_TEGRA_DEVFREQ
> >>>>>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
> >>>>> -	depends on ARCH_TEGRA
> >>>>> +	depends on ARCH_TEGRA || COMPILE_TEST
> >>>>>  	select PM_OPP
> >>>>>  	help
> >>>>>  	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> >>>>
> >>>> You need to be careful with these. You're using I/O register accesso=
rs,
> >>>> which are not supported on the UM architecture, for example.
> >>>>
> >>>> This may end up getting flagged during build testing.
> >>>
> >>> We have similar cases in other drivers and it doesn't cause any known
> >>> problems because (I think) build-bots are aware of this detail. Hence
> >>
> >> I don't understand how the build-bots would be aware of this detail.
> >> Unless you explicitly state what the dependencies are, how would the
> >> build-bots know? Perhaps there's some logic built-in somewhere that I
> >> don't know about?
> >=20
> > So looks like COMPILE_TEST has a !UML dependency, so this might just
> > work.
> >=20
> > Acked-by: Thierry Reding <treding@nvidia.com>
> >=20
>=20
> Thank you very much for the clarification! Certainly that would caused
> problems already since there are such cases all over the kernel,
> including Tegra drivers.

In the cases that I'm aware of we used to explicitly list all the
dependencies that would've otherwise been pulled in by the ARCH_TEGRA
dependency to make sure there were no issues.

Now that we've been discussing this I vaguely recall a discussion about
the only real issue nowadays being HAS_IOMEM and since that's only
missing on UML, that may have been the reason for why the !UML
dependency was added.

Yes, looks like that was it:

	commit bc083a64b6c035135c0f80718f9e9192cc0867c6
	Author: Richard Weinberger <richard@nod.at>
	Date:   Tue Aug 2 14:03:27 2016 -0700

	    init/Kconfig: make COMPILE_TEST depend on !UML

	    UML is a bit special since it does not have iomem nor dma.  That means=
 a
	    lot of drivers will not build if they miss a dependency on HAS_IOMEM.
	    s390 used to have the same issues but since it gained PCI support UML =
is
	    the only stranger.

	    We are tired of patching dozens of new drivers after every merge window
	    just to un-break allmod/yesconfig UML builds.  One could argue that a
	    decent driver has to know on what it depends and therefore a missing
	    HAS_IOMEM dependency is a clear driver bug.  But the dependency not
	    obvious and not everyone does UML builds with COMPILE_TEST enabled when
	    developing a device driver.

	    A possible solution to make these builds succeed on UML would be
	    providing stub functions for ioremap() and friends which fail upon
	    runtime.  Another one is simply disabling COMPILE_TEST for UML.  Since
	    it is the least hassle and does not force use to fake iomem support
	    let's do the latter.

	    Link: http://lkml.kernel.org/r/1466152995-28367-1-git-send-email-richa=
rd@nod.at
	    Signed-off-by: Richard Weinberger <richard@nod.at>
	    Acked-by: Arnd Bergmann <arnd@arndb.de>
	    Cc: Al Viro <viro@zeniv.linux.org.uk>
	    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
	    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Oh wow... almost three years now.

Thierry

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2hRgACgkQ3SOs138+
s6Ge3w//TpTw2alVI55O/u5vd2xiR8t594YrMwEWMsFu0qbPPt3wDvsYROJUdHFg
cNdAJCJbcZeOCP/ZKtfoVZtV6zO2+hgjS27cgahMPGsAJNgO+GmGFAy0kpzSN7Kz
3lP3tM0h2xKc+3dYZjD4rcoaufet+gE8Lcwy/ngIEiZGZW2HxXd/+InA7nSnN3qv
Ko+XCousnBZbUr9KuGjFHVVFH/nZf9n1SthvF/vBZMmcM4xQIFiuuX2v75WOvogy
RtkSf+vxHjA/+GbUTrzE/RDPiLgpTELo8dNxECtY4VhNyhfnvTqI2JfyImDFdiU9
T7mV74WgKlPAobTznhXULzDQ6oXuXfeytIEJh+XwGX7jiSys+4jI5rOGPSWcH+CK
WI7Tnu0XwtpkLH7LsggH9WFqAPByIAC0jTI5T/Q9M9r2Asga7gHc9x+Zm/bpHJJW
xEwROfuhct5qe/aLkJAodZZZf0BWaJj2zwLsRgpsIW8ubXT2Sh6leliZwZGVUOWx
D6G4L7Qeczg8A9VzaATqtXL3+ES0VyJ7o2ITT48JQbbAMZH+DyyRuv/171ZrGFJ1
+lq9UGEny0gsfxjfiEAWkHh1Z5JN+9xYliwBrmowPL5bUYngWw/0FhjAOs5BfvQf
0oTxYv3MsaO93+z22PJCbnubYC9iwaGfrFcbduajtd0Z/31zvKM=
=jp8D
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
