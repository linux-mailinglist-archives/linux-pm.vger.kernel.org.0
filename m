Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0057A278050
	for <lists+linux-pm@lfdr.de>; Fri, 25 Sep 2020 08:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgIYGIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Sep 2020 02:08:12 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:29261
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbgIYGIM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Sep 2020 02:08:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4pIGFjZMDqBes2uZ8EUfAXSWvT/qSKbBEX193cHboB+mRHLwn6w3EO2j7FvyAngl6wNYFrGZm2vdc4ZDFLBsmdlZMp8biSDPY7TjjwBA9nTVFBb6phcD4unZqiZzLdM+CdGYJOFim5dw6VlznbahqqxM6+bO8P5VWBBTwzLx2ikqhx43AZ8yz/38bCKqS/aGdgsSA9XE4+VUmkBa+JEokUPabNv9lsgWQ8SYB8rdkGq2VZsrvqNWdSj21KLpGyqTljJKoklxkfHu+9UFGBcoxGxm90tr6sLRSum/vXyjiz1iSfJ7JBXp4z9b5w9hqHCKY5hxC1g2qxkjXgcPKuRUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb3qoyrSwzBuv9S07o8Gs4tMzLB/sbee7BXslLi4k/s=;
 b=Msd6MyHMQsB7JJ1TCrj9LSWmUm/n35EP/IK08aYA0HC8uC4FvO3AkxTcoxxNUu5i9je0v0xZgCnnaQFugWn6Lt8DXatiPGLZm9a+zYZMNoJQD6pP4siFk2OS4NwRA5BjJGxOaVdiHt0Hsqz+d2eGpQHM/the2F2E+RbUTuwlujuR3paVhrDTN8k/LuOsYJlpvRqvsWiePMtFbspakdS0I2+dtUIGkDPmlnmPw2Ftg3S+71h04ZKp0dLE9uFBX9E6Zrbq+DFTIHDjqUlJ2QjBO6sZ1jmNI5wK1OnPLvyVWKa00CytAqja8APt5V4hWXrUL7lqPVMJY/RPek5psvBnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb3qoyrSwzBuv9S07o8Gs4tMzLB/sbee7BXslLi4k/s=;
 b=keUV0wGulDlt0C+64xDUyFMogL8yPq+/bk/0/N8Gc0LurKBStUFUDb/UfrI+nDOy94X3I/porIyAp8CNYF80KCHEAadT08zznRN92gyXTMepH68UKkzKrqa0HB7glYCYJc/AAFzei8fhmt19n8WaKGnoQYE0n8R2UIjxFVMhwV0=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0401MB2373.eurprd04.prod.outlook.com (2603:10a6:4:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 06:08:06 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.022; Fri, 25 Sep
 2020 06:08:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
Thread-Topic: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
 notifiers for genpd
Thread-Index: AQHWkmLFcQ7E31u+qkClkMyHDfUTbal43m5Q
Date:   Fri, 25 Sep 2020 06:08:06 +0000
Message-ID: <DB6PR0402MB2760BD51916BEA5DB80A268188360@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200924110449.329523-1-ulf.hansson@linaro.org>
 <20200924110449.329523-4-ulf.hansson@linaro.org>
In-Reply-To: <20200924110449.329523-4-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acbe961e-4642-481e-846a-08d861195ecb
x-ms-traffictypediagnostic: DB6PR0401MB2373:
x-microsoft-antispam-prvs: <DB6PR0401MB2373F054A94FD38AEB7491B888360@DB6PR0401MB2373.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyAYQw3PrWJtyA8qykGczYr4/shStCsFa5BPDxqwpBrLYHvSDBMjjPlKX5+GK/WTl0GI8o7G7E656ah/N4sHElSwcQFBo80y8fVwtXoZYWDPNsLm/kjFnaeFGyVr4+ttp/DsRhyKBcwNt/Opaqe4GEWjeSGJEUYYLf0NxJD0SvJm/0Hn4H+H+8sJJqUc1LWB6Bp1MiX+JhZklPsbOJqdVVJWrVjrvlblRMXnIxrswcMXZFNM0sSFDKLmXDQT3TlaM36hCQFB0dB4KHOKv6zX6fxEacW16dA3Z07aYRtxNHke8UNMNBJ3vZ5rfgDeLDPOhIdJjl2U4zzqq8hcDxsSapYiB8gvHqX1MH3YgM1wsNFZONqy2VdXqll5USqs4USo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(44832011)(6506007)(316002)(9686003)(4326008)(55016002)(86362001)(110136005)(54906003)(8676002)(8936002)(2906002)(478600001)(7696005)(26005)(71200400001)(76116006)(66556008)(5660300002)(64756008)(66476007)(52536014)(66446008)(83380400001)(66946007)(30864003)(7416002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ikmG/LLjpryOt5HvRKs2dL420Q8dXERagqTXCRWxhHr77XRMR8xk95nqLCFaYyg2bzFJzc7oBR4R4MeDdreuPAUUqXgQpggRV7LU4rzEogCgABK+uyLBvTR9k4V8f5dn4e0vLCXh000+gFXmOW/+FBMqHSzpzMr7CkgwooePnvpJHW/Ts7HTT2ezcVpbno5IJt53NMhruGHAhcPjjI1oRC2X6KxBmaQaOKRa+SdZTQ+0recgZ98a94Z4DtjPa5qMIj/qQ09fHJuRc8Ek9dkNEYYpzYTsOsG5NkuVuvpgro6oWfwIQY+ONM79u3rlqlgS0qkQ6iD/HAy1DJ1QTu0Wzx8O4sapVmQwRMBarkjQhIdTMpo7iwlv1nDFfRmg09Yza5uWhS3DUO+xBGZejq3VtJ2qqxjz7Ha6mipyRr0/xZ2bx6OU3Vx9yyQ26KBe3GcYBbGczYUwVTIKoMfknd8Zb73WzAGI/9jHUsAkscNTEbdsDOsFNBcGEtMH6KJ5YXZ0GncUHzuB37AEucxvvraQeXfzIWr13NqnjPgDwvHgoi/tO1atad2Y7G6GFFya934L/mzZRJguoqKt3hXUt3cfalyOcuTex2hX9AkgsNkEWilz2VfosFcPZudAF605TlRnBPDLsUsfEoYdZ/2nonV9qg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbe961e-4642-481e-846a-08d861195ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 06:08:06.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m68+W8qUIGoK2HB7iyXNllv1Tjg3LBIMv59I9h2sheiP+n803b4NzqF61p4zk3uAHPCz17iLz/SCu9CwOEI73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2373
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Ulf,

> Subject: [PATCH v2 3/3] PM / Domains: Add support for PM domain on/off
> notifiers for genpd
>=20
> A device may have specific HW constraints that must be obeyed to, before =
its
> corresponding PM domain (genpd) can be powered off - and vice verse at
> power on. These constraints can't be managed through the regular runtime
> PM based deployment for a device, because the access pattern for it, isn'=
t
> always request based. In other words, using the runtime PM callbacks to d=
eal
> with the constraints doesn't work for these cases.

Could the notification be added before/after power on, and before/after pow=
er
off? not just after power on and before power off?

Our SoC has a requirement that before power on/off the specific module,
the corresponding clk needs to be on to make sure the hardware async
bridge could finish handshake.

So we need clk_prepare_on/off to guard power on and power off as below:

clk_prepare_on
power on
clk_prepare_off

clk_prepare_on
power off
clk_prepare_off

Thanks,
Peng.

>=20
> For these reasons, let's instead add a PM domain power on/off notificatio=
n
> mechanism to genpd. To add/remove a notifier for a device, the device mus=
t
> already have been attached to the genpd, which also means that it needs t=
o
> be a part of the PM domain topology.
>=20
> To add/remove a notifier, let's introduce two genpd specific functions:
>  - dev_pm_genpd_add|remove_notifier()
>=20
> Note that, to further clarify when genpd power on/off notifiers may be us=
ed,
> one can compare with the existing CPU_CLUSTER_PM_ENTER|EXIT notifiers.
> In the long run, the genpd power on/off notifiers should be able to repla=
ce
> them, but that requires additional genpd based platform support for the
> current users.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>=20
> Changes in v2:
> 	- Improved error handling from fired notifications, according to
> 	suggestions by Lina Iyer.
>=20
> ---
>  drivers/base/power/domain.c | 142
> ++++++++++++++++++++++++++++++++++--
>  include/linux/pm_domain.h   |  15 ++++
>  2 files changed, 152 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 0198af358503..f001ac6326fb 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -497,7 +497,7 @@ static int genpd_power_off(struct
> generic_pm_domain *genpd, bool one_dev_on,
>  	struct pm_domain_data *pdd;
>  	struct gpd_link *link;
>  	unsigned int not_suspended =3D 0;
> -	int ret;
> +	int ret, nr_calls =3D 0;
>=20
>  	/*
>  	 * Do not try to power off the domain in the following situations:
> @@ -545,13 +545,22 @@ static int genpd_power_off(struct
> generic_pm_domain *genpd, bool one_dev_on,
>  	if (!genpd->gov)
>  		genpd->state_idx =3D 0;
>=20
> +	/* Notify consumers that we are about to power off. */
> +	ret =3D __raw_notifier_call_chain(&genpd->power_notifiers,
> +					GENPD_STATE_OFF, NULL, -1, &nr_calls);
> +	ret =3D notifier_to_errno(ret);
> +	if (ret)
> +		goto busy;
> +
>  	/* Don't power off, if a child domain is waiting to power on. */
> -	if (atomic_read(&genpd->sd_count) > 0)
> -		return -EBUSY;
> +	if (atomic_read(&genpd->sd_count) > 0) {
> +		ret =3D -EBUSY;
> +		goto busy;
> +	}
>=20
>  	ret =3D _genpd_power_off(genpd, true);
>  	if (ret)
> -		return ret;
> +		goto busy;
>=20
>  	genpd->status =3D GENPD_STATE_OFF;
>  	genpd_update_accounting(genpd);
> @@ -564,6 +573,12 @@ static int genpd_power_off(struct
> generic_pm_domain *genpd, bool one_dev_on,
>  	}
>=20
>  	return 0;
> +busy:
> +	if (nr_calls)
> +		__raw_notifier_call_chain(&genpd->power_notifiers,
> +					  GENPD_STATE_ON, NULL,
> +					  nr_calls - 1, NULL);
> +	return ret;
>  }
>=20
>  /**
> @@ -609,6 +624,9 @@ static int genpd_power_on(struct
> generic_pm_domain *genpd, unsigned int depth)
>  	genpd->status =3D GENPD_STATE_ON;
>  	genpd_update_accounting(genpd);
>=20
> +	/* Inform consumers that we have powered on. */
> +	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON,
> +NULL);
> +
>  	return 0;
>=20
>   err:
> @@ -938,6 +956,7 @@ static void genpd_sync_power_off(struct
> generic_pm_domain *genpd, bool use_lock,
>  				 unsigned int depth)
>  {
>  	struct gpd_link *link;
> +	int err, nr_calls =3D 0;
>=20
>  	if (!genpd_status_on(genpd) || genpd_is_always_on(genpd))
>  		return;
> @@ -948,8 +967,15 @@ static void genpd_sync_power_off(struct
> generic_pm_domain *genpd, bool use_lock,
>=20
>  	/* Choose the deepest state when suspending */
>  	genpd->state_idx =3D genpd->state_count - 1;
> +
> +	/* Notify consumers that we are about to power off. */
> +	err =3D __raw_notifier_call_chain(&genpd->power_notifiers,
> +					GENPD_STATE_OFF, NULL, -1, &nr_calls);
> +	if (notifier_to_errno(err))
> +		goto err;
> +
>  	if (_genpd_power_off(genpd, false))
> -		return;
> +		goto err;
>=20
>  	genpd->status =3D GENPD_STATE_OFF;
>=20
> @@ -964,6 +990,13 @@ static void genpd_sync_power_off(struct
> generic_pm_domain *genpd, bool use_lock,
>  		if (use_lock)
>  			genpd_unlock(link->parent);
>  	}
> +
> +	return;
> +err:
> +	if (nr_calls)
> +		__raw_notifier_call_chain(&genpd->power_notifiers,
> +					  GENPD_STATE_ON, NULL,
> +					  nr_calls - 1, NULL);
>  }
>=20
>  /**
> @@ -998,6 +1031,9 @@ static void genpd_sync_power_on(struct
> generic_pm_domain *genpd, bool use_lock,
>=20
>  	_genpd_power_on(genpd, false);
>  	genpd->status =3D GENPD_STATE_ON;
> +
> +	/* Inform consumers that we have powered on. */
> +	raw_notifier_call_chain(&genpd->power_notifiers, GENPD_STATE_ON,
> +NULL);
>  }
>=20
>  /**
> @@ -1592,6 +1628,101 @@ int pm_genpd_remove_device(struct device
> *dev)  }  EXPORT_SYMBOL_GPL(pm_genpd_remove_device);
>=20
> +/**
> + * dev_pm_genpd_add_notifier - Add a genpd power on/off notifier for
> +@dev
> + *
> + * @dev: Device that should be associated with the notifier
> + * @nb: The notifier block to register
> + *
> + * Users may call this function to add a genpd power on/off notifier
> +for an
> + * attached @dev. Only one notifier per device is allowed. The notifier
> +is
> + * sent when genpd is powering on/off the PM domain.
> + *
> + * It is assumed that the user guarantee that the genpd wouldn't be
> +detached
> + * while this routine is getting called.
> + *
> + * Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block
> +*nb) {
> +	struct generic_pm_domain *genpd;
> +	struct generic_pm_domain_data *gpd_data;
> +	int ret;
> +
> +	genpd =3D dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return -ENODEV;
> +
> +	if (WARN_ON(!dev->power.subsys_data ||
> +		     !dev->power.subsys_data->domain_data))
> +		return -EINVAL;
> +
> +	gpd_data =3D to_gpd_data(dev->power.subsys_data->domain_data);
> +	if (gpd_data->power_nb)
> +		return -EEXIST;
> +
> +	genpd_lock(genpd);
> +	ret =3D raw_notifier_chain_register(&genpd->power_notifiers, nb);
> +	genpd_unlock(genpd);
> +
> +	if (ret) {
> +		dev_warn(dev, "failed to add notifier for PM domain %s\n",
> +			 genpd->name);
> +		return ret;
> +	}
> +
> +	gpd_data->power_nb =3D nb;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_add_notifier);
> +
> +/**
> + * dev_pm_genpd_remove_notifier - Remove a genpd power on/off notifier
> +for @dev
> + *
> + * @dev: Device that is associated with the notifier
> + *
> + * Users may call this function to remove a genpd power on/off notifier
> +for an
> + * attached @dev.
> + *
> + * It is assumed that the user guarantee that the genpd wouldn't be
> +detached
> + * while this routine is getting called.
> + *
> + * Returns 0 on success and negative error values on failures.
> + */
> +int dev_pm_genpd_remove_notifier(struct device *dev) {
> +	struct generic_pm_domain *genpd;
> +	struct generic_pm_domain_data *gpd_data;
> +	int ret;
> +
> +	genpd =3D dev_to_genpd_safe(dev);
> +	if (!genpd)
> +		return -ENODEV;
> +
> +	if (WARN_ON(!dev->power.subsys_data ||
> +		     !dev->power.subsys_data->domain_data))
> +		return -EINVAL;
> +
> +	gpd_data =3D to_gpd_data(dev->power.subsys_data->domain_data);
> +	if (!gpd_data->power_nb)
> +		return -ENODEV;
> +
> +	genpd_lock(genpd);
> +	ret =3D raw_notifier_chain_unregister(&genpd->power_notifiers,
> +					    gpd_data->power_nb);
> +	genpd_unlock(genpd);
> +
> +	if (ret) {
> +		dev_warn(dev, "failed to remove notifier for PM domain %s\n",
> +			 genpd->name);
> +		return ret;
> +	}
> +
> +	gpd_data->power_nb =3D NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_remove_notifier);
> +
>  static int genpd_add_subdomain(struct generic_pm_domain *genpd,
>  			       struct generic_pm_domain *subdomain)  { @@
> -1762,6 +1893,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>  	INIT_LIST_HEAD(&genpd->parent_links);
>  	INIT_LIST_HEAD(&genpd->child_links);
>  	INIT_LIST_HEAD(&genpd->dev_list);
> +	RAW_INIT_NOTIFIER_HEAD(&genpd->power_notifiers);
>  	genpd_lock_init(genpd);
>  	genpd->gov =3D gov;
>  	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn); diff
> --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h index
> 66f3c5d64d81..3b2b561ce846 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -112,6 +112,7 @@ struct generic_pm_domain {
>  	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
>  	int (*power_off)(struct generic_pm_domain *domain);
>  	int (*power_on)(struct generic_pm_domain *domain);
> +	struct raw_notifier_head power_notifiers; /* Power on/off notifiers */
>  	struct opp_table *opp_table;	/* OPP table of the genpd */
>  	unsigned int (*opp_to_performance_state)(struct generic_pm_domain
> *genpd,
>  						 struct dev_pm_opp *opp);
> @@ -178,6 +179,7 @@ struct generic_pm_domain_data {
>  	struct pm_domain_data base;
>  	struct gpd_timing_data td;
>  	struct notifier_block nb;
> +	struct notifier_block *power_nb;
>  	int cpu;
>  	unsigned int performance_state;
>  	void *data;
> @@ -204,6 +206,8 @@ int pm_genpd_init(struct generic_pm_domain
> *genpd,
>  		  struct dev_power_governor *gov, bool is_off);  int
> pm_genpd_remove(struct generic_pm_domain *genpd);  int
> dev_pm_genpd_set_performance_state(struct device *dev, unsigned int
> state);
> +int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block
> +*nb); int dev_pm_genpd_remove_notifier(struct device *dev);
>=20
>  extern struct dev_power_governor simple_qos_governor;  extern struct
> dev_power_governor pm_domain_always_on_gov; @@ -251,6 +255,17 @@
> static inline int dev_pm_genpd_set_performance_state(struct device *dev,
>  	return -ENOTSUPP;
>  }
>=20
> +static inline int dev_pm_genpd_add_notifier(struct device *dev,
> +					    struct notifier_block *nb)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline int dev_pm_genpd_remove_notifier(struct device *dev) {
> +	return -ENOTSUPP;
> +}
> +
>  #define simple_qos_governor		(*(struct dev_power_governor
> *)(NULL))
>  #define pm_domain_always_on_gov		(*(struct dev_power_governor
> *)(NULL))
>  #endif
> --
> 2.25.1

