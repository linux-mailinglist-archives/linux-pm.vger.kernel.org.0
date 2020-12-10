Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0F2D62DA
	for <lists+linux-pm@lfdr.de>; Thu, 10 Dec 2020 18:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbgLJOfi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Dec 2020 09:35:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390905AbgLJOfh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 09:35:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB46BAC6A;
        Thu, 10 Dec 2020 14:34:55 +0000 (UTC)
Message-ID: <ffeda0e13e9469414a9861a9f873a9c424aadd2a.camel@suse.de>
Subject: Re: [PATCH -next] thermal: broadcom: simplify the return expression
 of bcm2711_thermal_probe()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, linux-pm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 10 Dec 2020 15:34:54 +0100
In-Reply-To: <20201210135432.1249-1-zhengyongjun3@huawei.com>
References: <20201210135432.1249-1-zhengyongjun3@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gtoCt9I00z2tBY4meywD"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-gtoCt9I00z2tBY4meywD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-12-10 at 21:54 +0800, Zheng Yongjun wrote:
> Simplify the return expression.
>=20
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-gtoCt9I00z2tBY4meywD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/SMg4ACgkQlfZmHno8
x/7cGAf9EoBpHapjbF9x/REMgp6jja82UzHDSxBQA7PfMaptdlHj90Bf9WO/719u
V63jbZt3+kGcLZ3CzJvObmxIcE8P25V+s31wXij9p/RbrcxL0oHrYKtIKJHIQ9T/
nkJ+C001Kh0Hljjo4uSBa2YXUobRQJLvChuS448I32elgvgTf2gLZ5nnOdvakeiL
PP8D/CjvY580gg972Ty8bi1HgbdsKpfFhtP+p/STZfYEsaEpj35ovBjDksJlA+wZ
CnVRQLyaI4uwLDiZImUjGUNp7HEua66jli8H9yaPBJNXeWDHiGgFtfe21N3QbGzG
8x0/88gVf8FviCYQt4Ky78krkjit3Q==
=9/IH
-----END PGP SIGNATURE-----

--=-gtoCt9I00z2tBY4meywD--

