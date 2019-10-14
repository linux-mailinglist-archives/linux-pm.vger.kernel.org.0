Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3869ED59D3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 05:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfJNDMm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 23:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729621AbfJNDMm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 13 Oct 2019 23:12:42 -0400
Received: from earth.universe (unknown [88.128.80.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52C22083B;
        Mon, 14 Oct 2019 03:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571022761;
        bh=f9++ssYlU32C3mD6GxFSvOSRuGIHHWu9gwvD+GnS4TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rkjq2d1XYhtZhEdpmX1Y8ImJrHnRKTnavJ3+5KQY4tHI0MdCEijUtJq3ojVaKrPBL
         JAdiHa4eBhfgfRw6/q1JhtYEOBjzI0cc4nQpp4+zJR+j5a3jGg980G0OWeEgav9+11
         0yQ6/fiVqHC+UQ0cvYSjr94I9+jq00xDHYUP/yUo=
Received: by earth.universe (Postfix, from userid 1000)
        id AC81D3C0CA1; Mon, 14 Oct 2019 05:12:38 +0200 (CEST)
Date:   Mon, 14 Oct 2019 05:12:38 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Yizhuo Zhai <yzhai003@ucr.edu>, Beomho Seo <beomho.seo@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Subject: Re: Potential uninitialized variables in power: supply:
 rt5033_battery:
Message-ID: <20191014031238.fqiytckizbrwntci@earth.universe>
References: <CABvMjLTicqk-ncY18j=UCZhCCugTVkPWKjkWZj9yEccUp3m8XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oguz6rorx46w3zrv"
Content-Disposition: inline
In-Reply-To: <CABvMjLTicqk-ncY18j=UCZhCCugTVkPWKjkWZj9yEccUp3m8XQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--oguz6rorx46w3zrv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 03, 2019 at 09:21:44PM -0700, Yizhuo Zhai wrote:
> drivers/power/supply/rt5033_battery.c:
>=20
> In function rt5033_battery_get_present(), variable "val" could be
> uninitialized if regmap_read() returns -EINVAL. However, "val" is
> used to decide the return value, which is potentially unsafe.
>=20
> Also, we cannot simply return -EINVAL in rt5033_battery_get_present()
> because it's not an acceptable return value.
>=20
> Thanks for your time to check this case.

Should be fine to just return false when regmap_read() fails.
Will you prepare a patch for that?

Thanks,

-- Sebastian

--oguz6rorx46w3zrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl2j56MACgkQ2O7X88g7
+pqEHg/9EW8LYtH5bHaYEn8WLUM+DKorgimr8m5w9WQp4yw4fjl+WzteTp6MdUdm
0a00kYbFxFVwffJBoy28MS2tFG/4T8+NqdE7JQeFnatAERlA4FJhzpxB/etA/9IE
pbtETgg/r0qVLaLUKwlrqfWN0Dlo0g1t/QrKK7BaNWR2eZu0cGUI4O6k6s6C00u1
lyxXgUCkOgNEJSD4k664jcKIf3XboFZLanTghQ/uFerU9kH1gqCdSd51gxQ8eodu
KlS3Eb4qcSWgLwrZLMtg/ewPa6KK9r+MRyQEipyK2ZyLEohlVhf+ZQ72R6+YM08M
gmkr52vyzIVq673hPNGOVL9eUUQUKFLtJPDesQcdgPDlsEP2Vxs+EA7QEWIPTrSC
AORM4pFjzpLiG+0aXbeX9TSA9xG2h+vpJ0rBTqbtl8syz2447rbzrgXirhhVI/06
4H0xmQXq9w8ctSW/qk/gJci1djcogYGes9lM8iN0mH2B++sC44vwgiHTe1b5h6IZ
HeFDCzs8ZzIQR8Mk0aGYUMi/vCyhpBmVBO1JnZfecYmNAQ2XSlLu2yZeEsPh+jiW
kld/CRSenBhE6oMb0f95UI5TG6Q4oVpUYtyyTRKoIMXf3PJwY84VI004M3+YhcAb
e3EgTf2v8PSHF/s9pPBPurQ4bv/fkCNOFws++JsWDUTv23ekDE0=
=GwVf
-----END PGP SIGNATURE-----

--oguz6rorx46w3zrv--
