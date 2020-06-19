Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D7C200D68
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbgFSO5V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 10:57:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390224AbgFSO5U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 10:57:20 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0836C2158C;
        Fri, 19 Jun 2020 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578640;
        bh=CT9r71MK/Ydp6dwbrEa6O5/PjRwxLbVniRQATszwRQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiOsvkir4Os/TLSff6ns8HfTYTo0f/91c/A/OMpAc86PfpoZeZCUwDxBP0bLnO8rS
         DBzOKGLvrTsWDiaWSnNTOSY7PDGCuNbIwJCr9lEG4Ljvha6FEZrWZP6I6aeZ3LxNsW
         0nlV8/2Jm+cCcDHQPUI7/wOUnenYIe/kVduz3Ipo=
Received: by earth.universe (Postfix, from userid 1000)
        id 69E193C08CD; Fri, 19 Jun 2020 16:57:18 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:57:18 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers\power\supply: use kobj_to_dev
Message-ID: <20200619145718.72ginjzx2inkzelv@earth.universe>
References: <1591944954-14411-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pmji5uxywuwhyrf6"
Content-Disposition: inline
In-Reply-To: <1591944954-14411-1-git-send-email-wangqing@vivo.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pmji5uxywuwhyrf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 12, 2020 at 02:55:54PM +0800, Wang Qing wrote:
> Use kobj_to_dev() API instead of container_of().
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 drivers/power/supply/power_supply_sysfs.c
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index bc79560..af0cad2
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -343,7 +343,7 @@ static umode_t power_supply_attr_is_visible(struct ko=
bject *kobj,
>  					   struct attribute *attr,
>  					   int attrno)
>  {
> -	struct device *dev =3D container_of(kobj, struct device, kobj);
> +	struct device *dev =3D kobj_to_dev(kobj);
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	umode_t mode =3D S_IRUSR | S_IRGRP | S_IROTH;
>  	int i;
> --=20
> 2.7.4
>=20

--pmji5uxywuwhyrf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s0k4ACgkQ2O7X88g7
+pouAxAAol0mBNNBXhOkXgK+gNZN2w/ZvBouoVzRqOXniMeAjKhDYUVNCxjN2RRf
+5qYt0cYGrSVR/FMmY40IGzGPKnO/0cAasVP5CVy8Rkf+Ji0Sy2P40LfFlJe/ZZO
n/o1dD/m76uremaWPnFJ7St9v1HspoPBQxHC7QEvjvb5zNdvg/OuT9v1XmcwHn+F
4ab4U9NnAAzDRZz+IzU+xBO6jRm3eVrjPv6f+YUGi4idKNqKZ03g/2u8MRGy5LUg
fRaO3v/UCW+IQBbPOKbgta2ak9ZqeHTOlYCFivbgvQu/aYEuco4fA6o0cQynLZVV
06mPloIA5xtPuvJlDBogWzkWjJ3lsXk7femaRnZ1Ra6+I13eMSPCS44diDiEjIUF
obU9vJmcQmwtTHvHOdaiYjKUXq1pQyLJtEmKoLDvilR+XTw+L4EfnyjGdnMveQsM
CsgxEFG5mBNh6Xra91D8tzT6lqJW4cL1Ae66DqNTmPUYRY4ex2A6OyLi/c5ivvED
akGfVU3o2MHE9ZSKlE+b3TapTre1FoFw2M+ZpOIauv9WniVcVsKPmoLASYgL9Y9e
NT05Zy1OVDZlUKI+6reMvsxzFu4UF9cTzB8vmGOrYfs2y51v70zKdNrBduP9obBt
fWoCydVn9P3aK4LsUIVMd/DKHT06h5RXdkOQKZNMzavAn08Mkfg=
=YjtU
-----END PGP SIGNATURE-----

--pmji5uxywuwhyrf6--
