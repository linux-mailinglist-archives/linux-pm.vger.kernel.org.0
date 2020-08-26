Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5534125343E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgHZQCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 12:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgHZQB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 12:01:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77DC061574;
        Wed, 26 Aug 2020 09:01:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C60E5293E56
Received: by earth.universe (Postfix, from userid 1000)
        id EAECB3C0C82; Wed, 26 Aug 2020 18:01:52 +0200 (CEST)
Date:   Wed, 26 Aug 2020 18:01:52 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     David Lechner <david@lechnology.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] power: supply: lego_ev3: Simplify with
 dev_err_probe()
Message-ID: <20200826160152.dajcqjzqiermrqpy@earth.universe>
References: <20200826144858.9584-1-krzk@kernel.org>
 <20200826144858.9584-5-krzk@kernel.org>
 <bf10bb56-a8fc-02b4-809c-2592c2618f19@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="26vs4tsljcbqz6ps"
Content-Disposition: inline
In-Reply-To: <bf10bb56-a8fc-02b4-809c-2592c2618f19@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--26vs4tsljcbqz6ps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 26, 2020 at 10:11:02AM -0500, David Lechner wrote:
> On 8/26/20 9:48 AM, Krzysztof Kozlowski wrote:
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe().  Less code and also it prints the error value.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
>=20
> Reviewed-by: David Lechner <david@lechnology.com>

Thanks Krzysztof, I queued all 5 patches.

-- Sebastian

--26vs4tsljcbqz6ps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9Gh2gACgkQ2O7X88g7
+poxxhAAih8IoKMzB0uCFp8lFJTST0rnAP+jA2ULTln8Gi/0qqNEQi+4MzPKbdgk
obT4GIZYcV629jueTYjeUKVAoGip71PxIAA1YbpMHYGX/DS+rTxs4a08aYPyhf1n
g5426J3jLXyzZw6JYR8Yx+FAu81hfOVEjjDDuU6NLLhltkyNvCj4dL3OEOYDrsw6
AwPWUMIZi8/BkjXwbswbny2y0ipTtLQdExaChkE0+WM/unsvMKvxGcovxpN3e2E1
OJXvlmxRY6Ow7SLkNiFivj4KYJl0hMOMSlXj9GHzGvPufBHT8ZLoEKjvnccqfPDU
JdfOTIWhklVfOnqs4dvguyaVUafCDU3ZGFRCaMohcIcIG/bYFQq0hx0F23A3cSUK
VgHhQV/JvIVQYJ9U2Pu8ySrbYV0t9ZPUg+OYRg7NM53stzZLvKKEOS7aouVzpYUs
Cmj/fotjnGHJLNzxUUr6BNoICYbPdFfLKTAwrwbXySe5u4tUH2ewruP1DBiGIExP
wN1GDeoO4uSqMeBQhhOwjP+Asur7Rv+0SqlOxg8bqaS7tfo6yfltRNF9u4zYJGF/
V1yUxL3LDOqyi2rMaITMVUsYEONlBEcfZYQ8wUSXYVe48zNdQ9hTDYSSmWwaAA9z
ZerLcsE6IUsAJ7WfZqo4uOjCVMzqFJkBxwuaTbF6u+4cY432ErE=
=zwnZ
-----END PGP SIGNATURE-----

--26vs4tsljcbqz6ps--
