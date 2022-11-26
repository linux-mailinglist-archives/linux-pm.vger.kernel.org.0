Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E5363985C
	for <lists+linux-pm@lfdr.de>; Sat, 26 Nov 2022 22:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiKZV6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 26 Nov 2022 16:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKZV6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 26 Nov 2022 16:58:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C021F186CC
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2022 13:58:10 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 632EF6602A2E;
        Sat, 26 Nov 2022 21:58:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669499888;
        bh=O5chjqqkCKGREJgHLOrhFq+bsy9Ku4ygZmtlpuoKIGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThTGQwyXg3FddWotxH8mmenVlFh/ErurdKGrRqfFTjV4mn2dbUDEGHYrWdezICV4c
         zV03e3oG9yhEfmUtstuBo26hfLUc4D+nAsCev3ZtXmCCiVNWA5Jb4yUqcRYeeyz8I+
         4QNaifWKVOMAZkU4svRPGUWIk5QGLRb2TZYeaScWClqwLd2VUyjhz4CcDjsYfMl4bj
         29Pr2rXI9u3/vqWfiLeaEgIfbjZ02vDyLYstNOG9fCsmX9BPTYJyzl9S/ldE7M2UVt
         6nhAQ0NHC44pZNDgoDdSq32SPqGaWXEdebqnHxaMKvcAKJpsZEpjvJzMW+DMTlnUta
         PN0GhpOAcetdA==
Received: by mercury (Postfix, from userid 1000)
        id 6230010610EE; Sat, 26 Nov 2022 22:58:06 +0100 (CET)
Date:   Sat, 26 Nov 2022 22:58:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Shang XiaoJing <shangxiaojing@huawei.com>
Cc:     t.schramm@manjaro.org, andriy.shevchenko@linux.intel.com,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: cw2015: Fix potential null-ptr-deref in
 cw_bat_probe()
Message-ID: <20221126215806.haysq4kll5a2w5bw@mercury.elektranox.org>
References: <20221117024558.4014-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2aixwatijgs55u5g"
Content-Disposition: inline
In-Reply-To: <20221117024558.4014-1-shangxiaojing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--2aixwatijgs55u5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 17, 2022 at 10:45:58AM +0800, Shang XiaoJing wrote:
> cw_bat_probe() calls create_singlethread_workqueue() and not checked the
> ret value, which may return NULL. And a null-ptr-deref may happen:
>=20
> cw_bat_probe()
>     create_singlethread_workqueue() # failed, cw_bat->wq is NULL
>     queue_delayed_work()
>         queue_delayed_work_on()
>             __queue_delayed_work()  # warning here, but continue
>                 __queue_work()      # access wq->flags, null-ptr-deref
>=20
> Check the ret value and return -ENOMEM if it is NULL.
>=20
> Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge drive=
r")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cw2015_battery.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply=
/cw2015_battery.c
> index 6d52641151d9..473522b4326a 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -699,6 +699,9 @@ static int cw_bat_probe(struct i2c_client *client)
>  	}
> =20
>  	cw_bat->battery_workqueue =3D create_singlethread_workqueue("rk_battery=
");
> +	if (!cw_bat->battery_workqueue)
> +		return -ENOMEM;
> +
>  	devm_delayed_work_autocancel(&client->dev,
>  							  &cw_bat->battery_delay_work, cw_bat_work);
>  	queue_delayed_work(cw_bat->battery_workqueue,
> --=20
> 2.17.1
>=20

--2aixwatijgs55u5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOCi+cACgkQ2O7X88g7
+potXQ//dNN7UXUFwFDxUKR6J2qYRx7AXpbIASYFbq3HTHHij+YmfWtD6p+mOIWJ
bDkUHeznqS2ivrMXTcyrXh9ido5QhCycN0YusrmRczExNuW6oasCCK0X28nTerck
2SP4IHhcB8tJ0CRjLzvUhIA+dZi65yW+AlCjNNVPo9H0+JBVoiPhv/8nPoi8gpq6
Egvy9QoMlFq21jNRCY3JZKPR+PFt3UwDaxGmDWN1Pf9D3iAbfvZn1ihpdH4e0Q9e
TTr/XMoKJJCuvCufDlrtNF4UFDCrssvPY8TZCOQjhWpAVKLQi8KH6gnNQgnq18sZ
AN0ahrKYp0YHb3Bi8kRAv6PYDI6rQyWRuKonuY2HJ0XsQNBW5dPe/N9N46Kg0yb0
BkQH6RJClqLNknTgy15oyPZA8WmX9perageeox1dhHxLDJSreBN4Mp2LLuODgS2S
AWyi6e27pu+kA4sM5WwQ6GE2ihlFk96FIwM7RnpgXC+evxVJnwWPF04aSt3f9RfL
tj/z0Kr/oSnCLtcdnZuG6oafWuNpmw0rRB1afS+n+Q3XAerPkNQLtl4Lxmui1OBi
mKc3DXuEItnSrxeuSx7mQI/aAFIhJYO2OedxElWQh0k45ClorDvKyZjtI2W0ExmV
jDxCG3Dp4Dne69moMEjxTP8cbl0nOaExlkZPqgP8H0T1pXB4CqY=
=AOND
-----END PGP SIGNATURE-----

--2aixwatijgs55u5g--
