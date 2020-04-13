Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AEA1A6F3C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Apr 2020 00:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbgDMW3w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 18:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389607AbgDMW3t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 18:29:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07FC0A3BDC;
        Mon, 13 Apr 2020 15:29:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id C774B2A1205
Received: by earth.universe (Postfix, from userid 1000)
        id AFBD63C08C7; Tue, 14 Apr 2020 00:29:45 +0200 (CEST)
Date:   Tue, 14 Apr 2020 00:29:45 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] power_supply: Add a helper function to retrieve psy
 array from phandle
Message-ID: <20200413222945.6eynl77ckpss35eo@earth.universe>
References: <20200407211243.247362-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a6u4x77jcpwdjdw4"
Content-Disposition: inline
In-Reply-To: <20200407211243.247362-1-badhri@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--a6u4x77jcpwdjdw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 07, 2020 at 02:12:43PM -0700, Badhri Jagan Sridharan wrote:
> power_supply_get_by_phandle retrieves power_supply object based on
> phandle. However, when multiple power_supply objects are registered
> by the same parent device the first power_supply object's reference
> is returned. This varies according to probe order. Add a helper to
> return all the power_supply object's reference.
>=20
> The caller has to provide the power_supply pointer array.
> -EOVERFLOW is returned when the size of the array is not enough to
> pass back all the power_supply objects.
>=20
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---

This patchset is incomplete, it is missing a mainline user.

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 78 ++++++++++++++++++++++++
>  include/linux/power_supply.h             |  9 +++
>  2 files changed, 87 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 1a9a9fae73d32..e7bab4661ba13 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -32,6 +32,13 @@ EXPORT_SYMBOL_GPL(power_supply_notifier);
> =20
>  static struct device_type power_supply_dev_type;
> =20
> +struct match_device_node_array_param {
> +	struct device_node *parent_of_node;
> +	struct power_supply **psy;
> +	ssize_t psy_size;
> +	ssize_t psy_count;
> +};
> +
>  #define POWER_SUPPLY_DEFERRED_REGISTER_TIME	msecs_to_jiffies(10)
> =20
>  static bool __power_supply_is_supplied_by(struct power_supply *supplier,
> @@ -522,6 +529,77 @@ struct power_supply *power_supply_get_by_phandle(str=
uct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(power_supply_get_by_phandle);
> =20
> +static int power_supply_match_device_node_array(struct device *dev,
> +						void *data)
> +{
> +	struct match_device_node_array_param *param =3D
> +		(struct match_device_node_array_param *)data;
> +	struct power_supply **psy =3D param->psy;
> +	ssize_t size =3D param->psy_size;
> +	ssize_t *count =3D &param->psy_count;
> +
> +	if (!dev->parent || dev->parent->of_node !=3D param->parent_of_node)
> +		return 0;
> +
> +	if (*count >=3D size)
> +		return -EOVERFLOW;
> +
> +	psy[*count] =3D dev_get_drvdata(dev);
> +	atomic_inc(&psy[*count]->use_cnt);
> +	(*count)++;
> +
> +	return 0;
> +}
> +
> +/**
> + * power_supply_get_by_phandle_array() - Similar to
> + * power_supply_get_by_phandle but returns an array of power supply
> + * objects which are associated with the phandle.
> + * @np: Pointer to device node holding phandle property.
> + * @property: Name of property holding a power supply name.
> + * @psy: Array of power_supply pointers provided by the client which is
> + * filled by power_supply_get_by_phandle_array.
> + * @size: size of power_supply pointer array.
> + *
> + * If power supply was found, it increases reference count for the
> + * internal power supply's device. The user should power_supply_put()
> + * after usage.
> + *
> + * Return: On success returns the number of power supply objects filled
> + * in the @psy array.
> + * -EOVERFLOW when size of @psy array is not suffice.
> + * -EINVAL when @psy is NULL or @size is 0.
> + * -ENODEV when matching device_node is not found.
> + */
> +int power_supply_get_by_phandle_array(struct device_node *np,
> +				      const char *property,
> +				      struct power_supply **psy,
> +				      ssize_t size)
> +{
> +	struct device_node *power_supply_np;
> +	int ret;
> +	struct match_device_node_array_param param;
> +
> +	if (psy =3D=3D NULL || size =3D=3D 0)
> +		return -EINVAL;
> +
> +	power_supply_np =3D of_parse_phandle(np, property, 0);
> +	if (!power_supply_np)
> +		return -ENODEV;
> +
> +	param.parent_of_node =3D power_supply_np;
> +	param.psy =3D psy;
> +	param.psy_size =3D size;
> +	param.psy_count =3D 0;
> +	ret =3D class_for_each_device(power_supply_class, NULL, &param,
> +				    power_supply_match_device_node_array);
> +
> +	of_node_put(power_supply_np);
> +
> +	return param.psy_count;
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_by_phandle_array);
> +
>  static void devm_power_supply_put(struct device *dev, void *res)
>  {
>  	struct power_supply **psy =3D res;
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index dcd5a71e6c677..8c1478a480674 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -366,12 +366,21 @@ extern void power_supply_put(struct power_supply *p=
sy);
>  #ifdef CONFIG_OF
>  extern struct power_supply *power_supply_get_by_phandle(struct device_no=
de *np,
>  							const char *property);
> +extern int power_supply_get_by_phandle_array(struct device_node *np,
> +					     const char *property,
> +					     struct power_supply **psy,
> +					     ssize_t size);
>  extern struct power_supply *devm_power_supply_get_by_phandle(
>  				    struct device *dev, const char *property);
>  #else /* !CONFIG_OF */
>  static inline struct power_supply *
>  power_supply_get_by_phandle(struct device_node *np, const char *property)
>  { return NULL; }
> +static int power_supply_get_by_phandle_array(struct device_node *np,
> +					     const char *property,
> +					     struct power_supply **psy,
> +					     int size)
> +{ return 0; }
>  static inline struct power_supply *
>  devm_power_supply_get_by_phandle(struct device *dev, const char *propert=
y)
>  { return NULL; }
> --=20
> 2.26.0.292.g33ef6b2f38-goog
>=20

--a6u4x77jcpwdjdw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6U584ACgkQ2O7X88g7
+pq8cg/9GoRk7rhaCkFPcKCAZt3eEH5SzNs/p5qIqjbm/eskWrtMACcccOqD5lsz
+kIiGho2F5I7YSBpWJQJfKV+Jy/5Eu3PCy+ZcsznLyTupQ3waA3jhggrRzunJhQc
RIeS63rk76D0cg35w9L2Vrcpja7r8JcBXLU7o1A9lIi/r2nt3CeOJFwI89jPzRiQ
QpRMKc/Uxk66a9auDMcc4v9AlxC6x5GUvXX03a3RFtPqZ6EzkoPlQIFEHBjk7qfE
/NKiklpa2ixKILgseanvU1Ikcwf0wl7eAHBrpDw0iDTKMVn7xRcDXWG3cvMsahC8
th3wW3MbG0xCVdDab2ctNri17NMnWvLGLaM51GUEeHPSEhRnO/jF3i5p/eNyfmwc
jX/l+x36gjcIOculpYDafz2kGviHGqbmD4jCtb6TBPWoQCJbEifyGcD63LGFbMvm
/vbbJgtAzqMZJgH68EfQYQP6GzGmN+ti34cMng+Vqv3sSg0r9I78z6q1vGQNmU8C
Wlbm4iPKATNULr8q9yLf9cAOKqZp9V87cNZbY6/kcteL3uN33CNVZVEjzHPbenHU
tu2ECcNlQfJzhEg12SrZs7gAxNsXmzEX2EbQIIsn5RnF9YzXRqch2tkPWhGIGIZZ
DQcn32sjiPIKOYyv9agPgqvES+RZ2cbl7JPUKPkaAuII5uE1Y1g=
=tDHL
-----END PGP SIGNATURE-----

--a6u4x77jcpwdjdw4--
