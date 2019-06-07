Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2D387DE
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfFGKZW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 06:25:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:50920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727402AbfFGKZW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Jun 2019 06:25:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DEFAEAE0C;
        Fri,  7 Jun 2019 10:25:20 +0000 (UTC)
Message-ID: <86849329e38cc30e6ea6c51bcd77da56012a0d26.camel@suse.de>
Subject: Re: [PATCH v2 7/7] arm64: defconfig: enable cpufreq support for RPi3
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, sboyd@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        rjw@rjwysocki.net, Will Deacon <will.deacon@arm.com>,
        mbrugger@suse.de, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ssuloev@orpaltech.com
Date:   Fri, 07 Jun 2019 12:25:18 +0200
In-Reply-To: <431a1f0c-8bc8-5c9b-7fa2-f293a2846ce3@i2se.com>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
         <20190606142255.29454-8-nsaenzjulienne@suse.de>
         <431a1f0c-8bc8-5c9b-7fa2-f293a2846ce3@i2se.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-TkNebld2DAQffR2+uUDI"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-TkNebld2DAQffR2+uUDI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-07 at 12:19 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 06.06.19 um 16:23 schrieb Nicolas Saenz Julienne:
> > This enables both the new firmware clock driver and cpufreq driver
> > available for the RPi3 family of boards.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> >  arch/arm64/configs/defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index 4d583514258c..3b7baffb3087 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -82,6 +82,7 @@ CONFIG_CPUFREQ_DT=3Dy
> >  CONFIG_ACPI_CPPC_CPUFREQ=3Dm
> >  CONFIG_ARM_ARMADA_37XX_CPUFREQ=3Dy
> >  CONFIG_ARM_SCPI_CPUFREQ=3Dy
> > +CONFIG_ARM_RASPBERRYPI_CPUFREQ=3Dy
>=20
> the arm64 kernel tends to get very big, so i suggested to build it as a
> kernel module.
>=20
> Any reason why you choose to make it builtin?

Not really, I missed your suggestion. I'll fix in v3.


--=-TkNebld2DAQffR2+uUDI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz6O44ACgkQlfZmHno8
x/5xQAf/X/nfz6c1KdJtThHJ9SE8+XZyStaD20tWInaqg3MbPIpDHnG6/+6xiWYZ
RG1Y5qAjwu8VpzgqJOEFUA4++ynaOP9fsteiRpCHjMjoHOdaUJl8reqpXXksqUEL
n9Ej57VmhMvg1vlCO0gY59Lq9k6WIkbKHME/tBXozid0M3BYxDig+T8OBna+KHFV
gXQxkAEagdd05kQbMzSrfQ5hhjtSEStzRWY7jl/qIP5f0fMkF0IoyHEPijLCSFNv
qgwTGiYJiX/pFMFNP9nPfVt6JeeydWUK/H7Y0/Fh+CRTa1F7lNS8DvFV2lOrF1Ka
LAnXECYSAwfeRJB8kIJHFw0urT42LQ==
=teQM
-----END PGP SIGNATURE-----

--=-TkNebld2DAQffR2+uUDI--

