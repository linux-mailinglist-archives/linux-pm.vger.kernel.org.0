Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91467254926
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 17:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgH0PV0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 11:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgH0LcR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 07:32:17 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B2AC06121B;
        Thu, 27 Aug 2020 04:21:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BcgG332Xkz9sSJ;
        Thu, 27 Aug 2020 21:18:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1598527117;
        bh=JGkQUzrfaJwWetpSft/MlH9JHRba2xs5k/tJXw18Q/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XTWkbPbmepzdwPtg50R1u5xl6gt31LrjC6cTBW40HkxSpFe/bVatOl1m+rmnhyaD6
         9t0RZcTHHWzOwWG0cfVpUkPWMVHhTnJ5MoETLDY097U2qJa2hOuaDBxRInDGLV9DDg
         rssMw1LNfOVlx8HTKanqJkaH2mShc7Jweu7uxTFhFjlxbgM27sjGKXDa8YQRN6Nnl9
         dHt9sanVogx/tU63LoUm9kj2v/0LbHkTTg+55VIQBjIC9uqZA6oDg+fgYT1BMNaSPX
         tlZKuB/6Kx1HXt6Nt77cUg+2fGtTC7vujMy6IzXGXc8i87sMVIRVSBLk8o9hcv6sbA
         jFyjYCN5EUcIg==
Date:   Thu, 27 Aug 2020 21:18:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Subject: Re: WARNING: at drivers/opp/core.c:678
 dev_pm_opp_set_rate+0x4cc/0x5d4 - on arm x15
Message-ID: <20200827211832.3ebeda8a@canb.auug.org.au>
In-Reply-To: <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
        <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lc2=fBhV=r79f32N/0cZpyA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

--Sig_/lc2=fBhV=r79f32N/0cZpyA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Thu, 27 Aug 2020 15:16:51 +0530 Viresh Kumar <viresh.kumar@linaro.org> w=
rote:
>
> On 27-08-20, 15:04, Naresh Kamboju wrote:
> > While boot testing arm x15 devices the Kernel warning noticed with linu=
x next
> > tag 20200825.
> >=20
> > BAD:  next-20200825
> > GOOD:  next-20200824
> >=20
> > metadata:
> >   git branch: master
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
> >   git commit: 3a00d3dfd4b68b208ecd5405e676d06c8ad6bb63
> >   git describe: next-20200825
> >   make_kernelversion: 5.9.0-rc2
> >   kernel-config:
> > https://builds.tuxbuild.com/LDTu4GFMmvkJspza5LJIjQ/kernel.config
> >=20
> > We are working on git bisect and boot testing on x15 and get back to yo=
u. =20
>=20
> Was this working earlier ? But considering that multiple things
> related to OPP broke recently, it may be a OPP core bug as well. Not
> sure though.
>=20
> Can you give me delta between both the next branches for drivers/opp/
> path ? I didn't get these tags after fetching linux-next.

Yeah, you need to explicitly fetch the tags as only the latest tag is
part of the branches in the tree.

$ git diff next-20200824..next-20200825 drivers/opp
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 6978b9218c6e..8b3c3986f589 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -779,29 +779,39 @@ static int _set_opp_custom(const struct opp_table *op=
p_table,
 	return opp_table->set_opp(data);
 }
=20
+static int _set_required_opp(struct device *dev, struct device *pd_dev,
+			     struct dev_pm_opp *opp, int i)
+{
+	unsigned int pstate =3D likely(opp) ? opp->required_opps[i]->pstate : 0;
+	int ret;
+
+	if (!pd_dev)
+		return 0;
+
+	ret =3D dev_pm_genpd_set_performance_state(pd_dev, pstate);
+	if (ret) {
+		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
+			dev_name(pd_dev), pstate, ret);
+	}
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev,
 			      struct opp_table *opp_table,
-			      struct dev_pm_opp *opp)
+			      struct dev_pm_opp *opp, bool up)
 {
 	struct opp_table **required_opp_tables =3D opp_table->required_opp_tables;
 	struct device **genpd_virt_devs =3D opp_table->genpd_virt_devs;
-	unsigned int pstate;
 	int i, ret =3D 0;
=20
 	if (!required_opp_tables)
 		return 0;
=20
 	/* Single genpd case */
-	if (!genpd_virt_devs) {
-		pstate =3D likely(opp) ? opp->required_opps[0]->pstate : 0;
-		ret =3D dev_pm_genpd_set_performance_state(dev, pstate);
-		if (ret) {
-			dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
-				dev_name(dev), pstate, ret);
-		}
-		return ret;
-	}
+	if (!genpd_virt_devs)
+		return _set_required_opp(dev, dev, opp, 0);
=20
 	/* Multiple genpd case */
=20
@@ -811,19 +821,21 @@ static int _set_required_opps(struct device *dev,
 	 */
 	mutex_lock(&opp_table->genpd_virt_dev_lock);
=20
-	for (i =3D 0; i < opp_table->required_opp_count; i++) {
-		pstate =3D likely(opp) ? opp->required_opps[i]->pstate : 0;
-
-		if (!genpd_virt_devs[i])
-			continue;
-
-		ret =3D dev_pm_genpd_set_performance_state(genpd_virt_devs[i], pstate);
-		if (ret) {
-			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
-				dev_name(genpd_virt_devs[i]), pstate, ret);
-			break;
+	/* Scaling up? Set required OPPs in normal order, else reverse */
+	if (up) {
+		for (i =3D 0; i < opp_table->required_opp_count; i++) {
+			ret =3D _set_required_opp(dev, genpd_virt_devs[i], opp, i);
+			if (ret)
+				break;
+		}
+	} else {
+		for (i =3D opp_table->required_opp_count - 1; i >=3D 0; i--) {
+			ret =3D _set_required_opp(dev, genpd_virt_devs[i], opp, i);
+			if (ret)
+				break;
 		}
 	}
+
 	mutex_unlock(&opp_table->genpd_virt_dev_lock);
=20
 	return ret;
@@ -882,7 +894,7 @@ static int _opp_set_rate_zero(struct device *dev, struc=
t opp_table *opp_table)
 	if (opp_table->regulators)
 		regulator_disable(opp_table->regulators[0]);
=20
-	ret =3D _set_required_opps(dev, opp_table, NULL);
+	ret =3D _set_required_opps(dev, opp_table, NULL, false);
=20
 	opp_table->enabled =3D false;
 	return ret;
@@ -973,7 +985,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned lo=
ng target_freq)
=20
 	/* Scaling up? Configure required OPPs before frequency */
 	if (freq >=3D old_freq) {
-		ret =3D _set_required_opps(dev, opp_table, opp);
+		ret =3D _set_required_opps(dev, opp_table, opp, true);
 		if (ret)
 			goto put_opp;
 	}
@@ -993,7 +1005,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned l=
ong target_freq)
=20
 	/* Scaling down? Configure required OPPs after frequency */
 	if (!ret && freq < old_freq) {
-		ret =3D _set_required_opps(dev, opp_table, opp);
+		ret =3D _set_required_opps(dev, opp_table, opp, false);
 		if (ret)
 			dev_err(dev, "Failed to set required opps: %d\n", ret);
 	}
@@ -1068,7 +1080,7 @@ static struct opp_table *_allocate_opp_table(struct d=
evice *dev, int index)
 	 */
 	opp_table =3D kzalloc(sizeof(*opp_table), GFP_KERNEL);
 	if (!opp_table)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
=20
 	mutex_init(&opp_table->lock);
 	mutex_init(&opp_table->genpd_virt_dev_lock);
@@ -1079,8 +1091,8 @@ static struct opp_table *_allocate_opp_table(struct d=
evice *dev, int index)
=20
 	opp_dev =3D _add_opp_dev(dev, opp_table);
 	if (!opp_dev) {
-		kfree(opp_table);
-		return NULL;
+		ret =3D -ENOMEM;
+		goto err;
 	}
=20
 	_of_init_opp_table(opp_table, dev, index);
@@ -1089,16 +1101,21 @@ static struct opp_table *_allocate_opp_table(struct=
 device *dev, int index)
 	opp_table->clk =3D clk_get(dev, NULL);
 	if (IS_ERR(opp_table->clk)) {
 		ret =3D PTR_ERR(opp_table->clk);
-		if (ret !=3D -EPROBE_DEFER)
-			dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__,
-				ret);
+		if (ret =3D=3D -EPROBE_DEFER)
+			goto err;
+
+		dev_dbg(dev, "%s: Couldn't find clock: %d\n", __func__, ret);
 	}
=20
 	/* Find interconnect path(s) for the device */
 	ret =3D dev_pm_opp_of_find_icc_paths(dev, opp_table);
-	if (ret)
+	if (ret) {
+		if (ret =3D=3D -EPROBE_DEFER)
+			goto err;
+
 		dev_warn(dev, "%s: Error finding interconnect paths: %d\n",
 			 __func__, ret);
+	}
=20
 	BLOCKING_INIT_NOTIFIER_HEAD(&opp_table->head);
 	INIT_LIST_HEAD(&opp_table->opp_list);
@@ -1107,6 +1124,10 @@ static struct opp_table *_allocate_opp_table(struct =
device *dev, int index)
 	/* Secure the device table modification */
 	list_add(&opp_table->node, &opp_tables);
 	return opp_table;
+
+err:
+	kfree(opp_table);
+	return ERR_PTR(ret);
 }
=20
 void _get_opp_table_kref(struct opp_table *opp_table)
@@ -1129,7 +1150,7 @@ static struct opp_table *_opp_get_opp_table(struct de=
vice *dev, int index)
 	if (opp_table) {
 		if (!_add_opp_dev_unlocked(dev, opp_table)) {
 			dev_pm_opp_put_opp_table(opp_table);
-			opp_table =3D NULL;
+			opp_table =3D ERR_PTR(-ENOMEM);
 		}
 		goto unlock;
 	}
@@ -1573,8 +1594,8 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct =
device *dev,
 	struct opp_table *opp_table;
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
=20
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
@@ -1632,8 +1653,8 @@ struct opp_table *dev_pm_opp_set_prop_name(struct dev=
ice *dev, const char *name)
 	struct opp_table *opp_table;
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
=20
 	/* Make sure there are no concurrent readers while updating opp_table */
 	WARN_ON(!list_empty(&opp_table->opp_list));
@@ -1725,8 +1746,8 @@ struct opp_table *dev_pm_opp_set_regulators(struct de=
vice *dev,
 	int ret, i;
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
=20
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1833,8 +1854,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct devic=
e *dev, const char *name)
 	int ret;
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
=20
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1901,8 +1922,8 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(=
struct device *dev,
 		return ERR_PTR(-EINVAL);
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (!IS_ERR(opp_table))
+		return opp_table;
=20
 	/* This should be called before OPPs are initialized */
 	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
@@ -1982,8 +2003,8 @@ struct opp_table *dev_pm_opp_attach_genpd(struct devi=
ce *dev,
 	const char **name =3D names;
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(opp_table))
+		return opp_table;
=20
 	/*
 	 * If the genpd's OPP table isn't already initialized, parsing of the
@@ -2153,8 +2174,8 @@ int dev_pm_opp_add(struct device *dev, unsigned long =
freq, unsigned long u_volt)
 	int ret;
=20
 	opp_table =3D dev_pm_opp_get_opp_table(dev);
-	if (!opp_table)
-		return -ENOMEM;
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
=20
 	/* Fix regulator count for dynamic OPPs */
 	opp_table->regulator_count =3D 1;
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7d9d4455a59e..e39ddcc779af 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -947,8 +947,8 @@ int dev_pm_opp_of_add_table(struct device *dev)
 	int ret;
=20
 	opp_table =3D dev_pm_opp_get_opp_table_indexed(dev, 0);
-	if (!opp_table)
-		return -ENOMEM;
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
=20
 	/*
 	 * OPPs have two version of bindings now. Also try the old (v1)
@@ -1002,8 +1002,8 @@ int dev_pm_opp_of_add_table_indexed(struct device *de=
v, int index)
 	}
=20
 	opp_table =3D dev_pm_opp_get_opp_table_indexed(dev, index);
-	if (!opp_table)
-		return -ENOMEM;
+	if (IS_ERR(opp_table))
+		return PTR_ERR(opp_table);
=20
 	ret =3D _of_add_opp_table_v2(dev, opp_table);
 	if (ret)

--=20
Cheers,
Stephen Rothwell

--Sig_/lc2=fBhV=r79f32N/0cZpyA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9HlokACgkQAVBC80lX
0GwZAwf+O1kXzQQ9o40/uccDJvSP0ptBP4b0O2LOcDcXGJTuYCRWxYCiejzoGEAw
tzwyZi6YLL+IG9noHb+68fvCrVLZW7t33DtyhqF4MSxL/LUe6Hxn4eRMQEyt6f7a
+awiM5nr5YrzSqpIoX8YDPDB9k3oAQaiVXMvKi1Wi+BLqFUgBUMi34RGMAeNumjC
CICNoahPhML3wR8kdlePniInWJyLzRB/T+JHp9ovvrVlMsIEYgXilI3esf5aLRiF
KIAYnl6CbVf6BllH6I0nkAHG0YBzfhZ2Rir2V3yuAJ6RspqbDWi24JcovQ+cZfJA
hEC/x5vvVqZiqGoxa7eKNhLZG1t5Wg==
=cg31
-----END PGP SIGNATURE-----

--Sig_/lc2=fBhV=r79f32N/0cZpyA--
