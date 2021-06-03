Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159A939A630
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFCQtj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 12:49:39 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51292 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFCQti (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 12:49:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 08FB01F434B5
Received: by earth.universe (Postfix, from userid 1000)
        id 7FD733C0C95; Thu,  3 Jun 2021 18:47:51 +0200 (CEST)
Date:   Thu, 3 Jun 2021 18:47:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5 v2] power: supply: ab8500: Move to componentized
 binding
Message-ID: <20210603164751.ihi52v26zbd2ys5o@earth.universe>
References: <20210522225043.1004103-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrnsgswxfcnxqsem"
Content-Disposition: inline
In-Reply-To: <20210522225043.1004103-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vrnsgswxfcnxqsem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, May 23, 2021 at 12:50:39AM +0200, Linus Walleij wrote:
> The driver has problems with the different components of
> the charging code racing with each other to probe().
>=20
> This results in all four subdrivers populating battery
> information to ascertain that it is populated for their
> own needs for example.
>=20
> Fix this by using component probing and thus expressing
> to the kernel that these are dependent components.
> The probes can happen in any order and will only acquire
> resources such as state container, regulators and
> interrupts and initialize the data structures, but no
> execution happens until the .bind() callback is called.
>=20
> The charging driver is the main component and binds
> first, then bind in order the three subcomponents:
> ab8500-fg, ab8500-btemp and ab8500-chargalg.
>=20
> Do some housekeeping while we are moving the code around.
> Like use devm_* for IRQs so as to cut down on some
> boilerplate.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebase on v5.13-rc1
> - Drop pointless lock/unlock of di->charger_attached_mutex
> - Whitespace fix
> ---

Thanks, I queued the complete series.

-- Sebastian

>  drivers/power/supply/ab8500-bm.h       |   4 +
>  drivers/power/supply/ab8500_btemp.c    | 118 ++++-----
>  drivers/power/supply/ab8500_charger.c  | 339 ++++++++++++++-----------
>  drivers/power/supply/ab8500_fg.c       | 136 +++++-----
>  drivers/power/supply/abx500_chargalg.c | 116 +++++----
>  5 files changed, 379 insertions(+), 334 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab85=
00-bm.h
> index 41c69a4f2a1f..012595a9d269 100644
> --- a/drivers/power/supply/ab8500-bm.h
> +++ b/drivers/power/supply/ab8500-bm.h
> @@ -730,4 +730,8 @@ int ab8500_bm_of_probe(struct device *dev,
>  		       struct device_node *np,
>  		       struct abx500_bm_data *bm);
> =20
> +extern struct platform_driver ab8500_fg_driver;
> +extern struct platform_driver ab8500_btemp_driver;
> +extern struct platform_driver abx500_chargalg_driver;
> +
>  #endif /* _AB8500_CHARGER_H_ */
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index 33fb6f65749c..b7b3653a204e 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/component.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
> @@ -932,26 +933,6 @@ static int __maybe_unused ab8500_btemp_suspend(struc=
t device *dev)
>  	return 0;
>  }
> =20
> -static int ab8500_btemp_remove(struct platform_device *pdev)
> -{
> -	struct ab8500_btemp *di =3D platform_get_drvdata(pdev);
> -	int i, irq;
> -
> -	/* Disable interrupts */
> -	for (i =3D 0; i < ARRAY_SIZE(ab8500_btemp_irq); i++) {
> -		irq =3D platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
> -		free_irq(irq, di);
> -	}
> -
> -	/* Delete the work queue */
> -	destroy_workqueue(di->btemp_wq);
> -
> -	flush_scheduled_work();
> -	power_supply_unregister(di->btemp_psy);
> -
> -	return 0;
> -}
> -
>  static char *supply_interface[] =3D {
>  	"ab8500_chargalg",
>  	"ab8500_fg",
> @@ -966,6 +947,40 @@ static const struct power_supply_desc ab8500_btemp_d=
esc =3D {
>  	.external_power_changed	=3D ab8500_btemp_external_power_changed,
>  };
> =20
> +static int ab8500_btemp_bind(struct device *dev, struct device *master,
> +			     void *data)
> +{
> +	struct ab8500_btemp *di =3D dev_get_drvdata(dev);
> +
> +	/* Create a work queue for the btemp */
> +	di->btemp_wq =3D
> +		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM, 0);
> +	if (di->btemp_wq =3D=3D NULL) {
> +		dev_err(dev, "failed to create work queue\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Kick off periodic temperature measurements */
> +	ab8500_btemp_periodic(di, true);
> +
> +	return 0;
> +}
> +
> +static void ab8500_btemp_unbind(struct device *dev, struct device *maste=
r,
> +				void *data)
> +{
> +	struct ab8500_btemp *di =3D dev_get_drvdata(dev);
> +
> +	/* Delete the work queue */
> +	destroy_workqueue(di->btemp_wq);
> +	flush_scheduled_work();
> +}
> +
> +static const struct component_ops ab8500_btemp_component_ops =3D {
> +	.bind =3D ab8500_btemp_bind,
> +	.unbind =3D ab8500_btemp_unbind,
> +};
> +
>  static int ab8500_btemp_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
> @@ -1011,14 +1026,6 @@ static int ab8500_btemp_probe(struct platform_devi=
ce *pdev)
>  	psy_cfg.num_supplicants =3D ARRAY_SIZE(supply_interface);
>  	psy_cfg.drv_data =3D di;
> =20
> -	/* Create a work queue for the btemp */
> -	di->btemp_wq =3D
> -		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM, 0);
> -	if (di->btemp_wq =3D=3D NULL) {
> -		dev_err(dev, "failed to create work queue\n");
> -		return -ENOMEM;
> -	}
> -
>  	/* Init work for measuring temperature periodically */
>  	INIT_DEFERRABLE_WORK(&di->btemp_periodic_work,
>  		ab8500_btemp_periodic_work);
> @@ -1031,7 +1038,7 @@ static int ab8500_btemp_probe(struct platform_devic=
e *pdev)
>  		AB8500_BTEMP_HIGH_TH, &val);
>  	if (ret < 0) {
>  		dev_err(dev, "%s ab8500 read failed\n", __func__);
> -		goto free_btemp_wq;
> +		return ret;
>  	}
>  	switch (val) {
>  	case BTEMP_HIGH_TH_57_0:
> @@ -1050,30 +1057,28 @@ static int ab8500_btemp_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	/* Register BTEMP power supply class */
> -	di->btemp_psy =3D power_supply_register(dev, &ab8500_btemp_desc,
> -					      &psy_cfg);
> +	di->btemp_psy =3D devm_power_supply_register(dev, &ab8500_btemp_desc,
> +						   &psy_cfg);
>  	if (IS_ERR(di->btemp_psy)) {
>  		dev_err(dev, "failed to register BTEMP psy\n");
> -		ret =3D PTR_ERR(di->btemp_psy);
> -		goto free_btemp_wq;
> +		return PTR_ERR(di->btemp_psy);
>  	}
> =20
>  	/* Register interrupts */
>  	for (i =3D 0; i < ARRAY_SIZE(ab8500_btemp_irq); i++) {
>  		irq =3D platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
> -		if (irq < 0) {
> -			ret =3D irq;
> -			goto free_irq;
> -		}
> +		if (irq < 0)
> +			return irq;
> =20
> -		ret =3D request_threaded_irq(irq, NULL, ab8500_btemp_irq[i].isr,
> +		ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +			ab8500_btemp_irq[i].isr,
>  			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
>  			ab8500_btemp_irq[i].name, di);
> =20
>  		if (ret) {
>  			dev_err(dev, "failed to request %s IRQ %d: %d\n"
>  				, ab8500_btemp_irq[i].name, irq, ret);
> -			goto free_irq;
> +			return ret;
>  		}
>  		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
>  			ab8500_btemp_irq[i].name, irq, ret);
> @@ -1081,23 +1086,16 @@ static int ab8500_btemp_probe(struct platform_dev=
ice *pdev)
> =20
>  	platform_set_drvdata(pdev, di);
> =20
> -	/* Kick off periodic temperature measurements */
> -	ab8500_btemp_periodic(di, true);
>  	list_add_tail(&di->node, &ab8500_btemp_list);
> =20
> -	return ret;
> +	return component_add(dev, &ab8500_btemp_component_ops);
> +}
> =20
> -free_irq:
> -	/* We also have to free all successfully registered irqs */
> -	for (i =3D i - 1; i >=3D 0; i--) {
> -		irq =3D platform_get_irq_byname(pdev, ab8500_btemp_irq[i].name);
> -		free_irq(irq, di);
> -	}
> +static int ab8500_btemp_remove(struct platform_device *pdev)
> +{
> +	component_del(&pdev->dev, &ab8500_btemp_component_ops);
> =20
> -	power_supply_unregister(di->btemp_psy);
> -free_btemp_wq:
> -	destroy_workqueue(di->btemp_wq);
> -	return ret;
> +	return 0;
>  }
> =20
>  static SIMPLE_DEV_PM_OPS(ab8500_btemp_pm_ops, ab8500_btemp_suspend, ab85=
00_btemp_resume);
> @@ -1107,7 +1105,7 @@ static const struct of_device_id ab8500_btemp_match=
[] =3D {
>  	{ },
>  };
> =20
> -static struct platform_driver ab8500_btemp_driver =3D {
> +struct platform_driver ab8500_btemp_driver =3D {
>  	.probe =3D ab8500_btemp_probe,
>  	.remove =3D ab8500_btemp_remove,
>  	.driver =3D {
> @@ -1116,20 +1114,6 @@ static struct platform_driver ab8500_btemp_driver =
=3D {
>  		.pm =3D &ab8500_btemp_pm_ops,
>  	},
>  };
> -
> -static int __init ab8500_btemp_init(void)
> -{
> -	return platform_driver_register(&ab8500_btemp_driver);
> -}
> -
> -static void __exit ab8500_btemp_exit(void)
> -{
> -	platform_driver_unregister(&ab8500_btemp_driver);
> -}
> -
> -device_initcall(ab8500_btemp_init);
> -module_exit(ab8500_btemp_exit);
> -
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Johan Palsson, Karl Komierowski, Arun R Murthy");
>  MODULE_ALIAS("platform:ab8500-btemp");
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index a9be10eb2c22..af32cfae9f19 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/component.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/notifier.h>
> @@ -3276,10 +3277,74 @@ static struct notifier_block charger_nb =3D {
>  	.notifier_call =3D ab8500_external_charger_prepare,
>  };
> =20
> -static int ab8500_charger_remove(struct platform_device *pdev)
> +static char *supply_interface[] =3D {
> +	"ab8500_chargalg",
> +	"ab8500_fg",
> +	"ab8500_btemp",
> +};
> +
> +static const struct power_supply_desc ab8500_ac_chg_desc =3D {
> +	.name		=3D "ab8500_ac",
> +	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties	=3D ab8500_charger_ac_props,
> +	.num_properties	=3D ARRAY_SIZE(ab8500_charger_ac_props),
> +	.get_property	=3D ab8500_charger_ac_get_property,
> +};
> +
> +static const struct power_supply_desc ab8500_usb_chg_desc =3D {
> +	.name		=3D "ab8500_usb",
> +	.type		=3D POWER_SUPPLY_TYPE_USB,
> +	.properties	=3D ab8500_charger_usb_props,
> +	.num_properties	=3D ARRAY_SIZE(ab8500_charger_usb_props),
> +	.get_property	=3D ab8500_charger_usb_get_property,
> +};
> +
> +static int ab8500_charger_bind(struct device *dev)
>  {
> -	struct ab8500_charger *di =3D platform_get_drvdata(pdev);
> -	int i, irq, ret;
> +	struct ab8500_charger *di =3D dev_get_drvdata(dev);
> +	int ch_stat;
> +	int ret;
> +
> +	/* Create a work queue for the charger */
> +	di->charger_wq =3D alloc_ordered_workqueue("ab8500_charger_wq",
> +						 WQ_MEM_RECLAIM);
> +	if (di->charger_wq =3D=3D NULL) {
> +		dev_err(dev, "failed to create work queue\n");
> +		return -ENOMEM;
> +	}
> +
> +	ch_stat =3D ab8500_charger_detect_chargers(di, false);
> +
> +	if (ch_stat & AC_PW_CONN) {
> +		if (is_ab8500(di->parent))
> +			queue_delayed_work(di->charger_wq,
> +					   &di->ac_charger_attached_work,
> +					   HZ);
> +	}
> +	if (ch_stat & USB_PW_CONN) {
> +		if (is_ab8500(di->parent))
> +			queue_delayed_work(di->charger_wq,
> +					   &di->usb_charger_attached_work,
> +					   HZ);
> +		di->vbus_detected =3D true;
> +		di->vbus_detected_start =3D true;
> +		queue_work(di->charger_wq,
> +			   &di->detect_usb_type_work);
> +	}
> +
> +	ret =3D component_bind_all(dev, di);
> +	if (ret) {
> +		dev_err(dev, "can't bind component devices\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ab8500_charger_unbind(struct device *dev)
> +{
> +	struct ab8500_charger *di =3D dev_get_drvdata(dev);
> +	int ret;
> =20
>  	/* Disable AC charging */
>  	ab8500_charger_ac_en(&di->ac_chg, false, 0, 0);
> @@ -3287,68 +3352,47 @@ static int ab8500_charger_remove(struct platform_=
device *pdev)
>  	/* Disable USB charging */
>  	ab8500_charger_usb_en(&di->usb_chg, false, 0, 0);
> =20
> -	/* Disable interrupts */
> -	for (i =3D 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
> -		irq =3D platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
> -		free_irq(irq, di);
> -	}
> -
>  	/* Backup battery voltage and current disable */
>  	ret =3D abx500_mask_and_set_register_interruptible(di->dev,
>  		AB8500_RTC, AB8500_RTC_CTRL_REG, RTC_BUP_CH_ENA, 0);
>  	if (ret < 0)
>  		dev_err(di->dev, "%s mask and set failed\n", __func__);
> =20
> -	usb_unregister_notifier(di->usb_phy, &di->nb);
> -	usb_put_phy(di->usb_phy);
> -
>  	/* Delete the work queue */
>  	destroy_workqueue(di->charger_wq);
> =20
> -	/* Unregister external charger enable notifier */
> -	if (!di->ac_chg.enabled)
> -		blocking_notifier_chain_unregister(
> -			&charger_notifier_list, &charger_nb);
> -
>  	flush_scheduled_work();
> -	if (di->usb_chg.enabled)
> -		power_supply_unregister(di->usb_chg.psy);
> -
> -	if (di->ac_chg.enabled && !di->ac_chg.external)
> -		power_supply_unregister(di->ac_chg.psy);
> =20
> -	return 0;
> +	/* Unbind fg, btemp, algorithm */
> +	component_unbind_all(dev, di);
>  }
> =20
> -static char *supply_interface[] =3D {
> -	"ab8500_chargalg",
> -	"ab8500_fg",
> -	"ab8500_btemp",
> +static const struct component_master_ops ab8500_charger_comp_ops =3D {
> +	.bind =3D ab8500_charger_bind,
> +	.unbind =3D ab8500_charger_unbind,
>  };
> =20
> -static const struct power_supply_desc ab8500_ac_chg_desc =3D {
> -	.name		=3D "ab8500_ac",
> -	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> -	.properties	=3D ab8500_charger_ac_props,
> -	.num_properties	=3D ARRAY_SIZE(ab8500_charger_ac_props),
> -	.get_property	=3D ab8500_charger_ac_get_property,
> +static struct platform_driver *const ab8500_charger_component_drivers[] =
=3D {
> +	&ab8500_fg_driver,
> +	&ab8500_btemp_driver,
> +	&abx500_chargalg_driver,
>  };
> =20
> -static const struct power_supply_desc ab8500_usb_chg_desc =3D {
> -	.name		=3D "ab8500_usb",
> -	.type		=3D POWER_SUPPLY_TYPE_USB,
> -	.properties	=3D ab8500_charger_usb_props,
> -	.num_properties	=3D ARRAY_SIZE(ab8500_charger_usb_props),
> -	.get_property	=3D ab8500_charger_usb_get_property,
> -};
> +static int ab8500_charger_compare_dev(struct device *dev, void *data)
> +{
> +	return dev =3D=3D data;
> +}
> =20
>  static int ab8500_charger_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct component_match *match =3D NULL;
>  	struct power_supply_config ac_psy_cfg =3D {}, usb_psy_cfg =3D {};
>  	struct ab8500_charger *di;
> -	int irq, i, charger_status, ret =3D 0, ch_stat;
> -	struct device *dev =3D &pdev->dev;
> +	int charger_status;
> +	int i, irq;
> +	int ret;
> =20
>  	di =3D devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
>  	if (!di)
> @@ -3393,6 +3437,38 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  		return ret;
>  	}
> =20
> +	/*
> +	 * VDD ADC supply needs to be enabled from this driver when there
> +	 * is a charger connected to avoid erroneous BTEMP_HIGH/LOW
> +	 * interrupts during charging
> +	 */
> +	di->regu =3D devm_regulator_get(dev, "vddadc");
> +	if (IS_ERR(di->regu)) {
> +		ret =3D PTR_ERR(di->regu);
> +		dev_err(dev, "failed to get vddadc regulator\n");
> +		return ret;
> +	}
> +
> +	/* Request interrupts */
> +	for (i =3D 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
> +		irq =3D platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
> +		if (irq < 0)
> +			return irq;
> +
> +		ret =3D devm_request_threaded_irq(dev,
> +			irq, NULL, ab8500_charger_irq[i].isr,
> +			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
> +			ab8500_charger_irq[i].name, di);
> +
> +		if (ret !=3D 0) {
> +			dev_err(dev, "failed to request %s IRQ %d: %d\n"
> +				, ab8500_charger_irq[i].name, irq, ret);
> +			return ret;
> +		}
> +		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
> +			ab8500_charger_irq[i].name, irq, ret);
> +	}
> +
>  	/* initialize lock */
>  	spin_lock_init(&di->usb_state.usb_lock);
>  	mutex_init(&di->usb_ipt_crnt_lock);
> @@ -3422,11 +3498,6 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  	di->ac_chg.enabled =3D di->bm->ac_enabled;
>  	di->ac_chg.external =3D false;
> =20
> -	/*notifier for external charger enabling*/
> -	if (!di->ac_chg.enabled)
> -		blocking_notifier_chain_register(
> -			&charger_notifier_list, &charger_nb);
> -
>  	/* USB supply */
>  	/* ux500_charger sub-class */
>  	di->usb_chg.ops.enable =3D &ab8500_charger_usb_en;
> @@ -3442,14 +3513,6 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  	di->usb_chg.external =3D false;
>  	di->usb_state.usb_current =3D -1;
> =20
> -	/* Create a work queue for the charger */
> -	di->charger_wq =3D alloc_ordered_workqueue("ab8500_charger_wq",
> -						 WQ_MEM_RECLAIM);
> -	if (di->charger_wq =3D=3D NULL) {
> -		dev_err(dev, "failed to create work queue\n");
> -		return -ENOMEM;
> -	}
> -
>  	mutex_init(&di->charger_attached_mutex);
> =20
>  	/* Init work for HW failure check */
> @@ -3500,63 +3563,36 @@ static int ab8500_charger_probe(struct platform_d=
evice *pdev)
>  	INIT_WORK(&di->check_usb_thermal_prot_work,
>  		ab8500_charger_check_usb_thermal_prot_work);
> =20
> -	/*
> -	 * VDD ADC supply needs to be enabled from this driver when there
> -	 * is a charger connected to avoid erroneous BTEMP_HIGH/LOW
> -	 * interrupts during charging
> -	 */
> -	di->regu =3D devm_regulator_get(dev, "vddadc");
> -	if (IS_ERR(di->regu)) {
> -		ret =3D PTR_ERR(di->regu);
> -		dev_err(dev, "failed to get vddadc regulator\n");
> -		goto free_charger_wq;
> -	}
> -
> =20
>  	/* Initialize OVV, and other registers */
>  	ret =3D ab8500_charger_init_hw_registers(di);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize ABB registers\n");
> -		goto free_charger_wq;
> +		return ret;
>  	}
> =20
>  	/* Register AC charger class */
>  	if (di->ac_chg.enabled) {
> -		di->ac_chg.psy =3D power_supply_register(dev,
> +		di->ac_chg.psy =3D devm_power_supply_register(dev,
>  						       &ab8500_ac_chg_desc,
>  						       &ac_psy_cfg);
>  		if (IS_ERR(di->ac_chg.psy)) {
>  			dev_err(dev, "failed to register AC charger\n");
> -			ret =3D PTR_ERR(di->ac_chg.psy);
> -			goto free_charger_wq;
> +			return PTR_ERR(di->ac_chg.psy);
>  		}
>  	}
> =20
>  	/* Register USB charger class */
>  	if (di->usb_chg.enabled) {
> -		di->usb_chg.psy =3D power_supply_register(dev,
> +		di->usb_chg.psy =3D devm_power_supply_register(dev,
>  							&ab8500_usb_chg_desc,
>  							&usb_psy_cfg);
>  		if (IS_ERR(di->usb_chg.psy)) {
>  			dev_err(dev, "failed to register USB charger\n");
> -			ret =3D PTR_ERR(di->usb_chg.psy);
> -			goto free_ac;
> +			return PTR_ERR(di->usb_chg.psy);
>  		}
>  	}
> =20
> -	di->usb_phy =3D usb_get_phy(USB_PHY_TYPE_USB2);
> -	if (IS_ERR_OR_NULL(di->usb_phy)) {
> -		dev_err(dev, "failed to get usb transceiver\n");
> -		ret =3D -EINVAL;
> -		goto free_usb;
> -	}
> -	di->nb.notifier_call =3D ab8500_charger_usb_notifier_call;
> -	ret =3D usb_register_notifier(di->usb_phy, &di->nb);
> -	if (ret) {
> -		dev_err(dev, "failed to register usb notifier\n");
> -		goto put_usb_phy;
> -	}
> -
>  	/* Identify the connected charger types during startup */
>  	charger_status =3D ab8500_charger_detect_chargers(di, true);
>  	if (charger_status & AC_PW_CONN) {
> @@ -3566,78 +3602,86 @@ static int ab8500_charger_probe(struct platform_d=
evice *pdev)
>  		sysfs_notify(&di->ac_chg.psy->dev.kobj, NULL, "present");
>  	}
> =20
> -	if (charger_status & USB_PW_CONN) {
> -		di->vbus_detected =3D true;
> -		di->vbus_detected_start =3D true;
> -		queue_work(di->charger_wq,
> -			&di->detect_usb_type_work);
> -	}
> -
> -	/* Register interrupts */
> -	for (i =3D 0; i < ARRAY_SIZE(ab8500_charger_irq); i++) {
> -		irq =3D platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
> -		if (irq < 0) {
> -			ret =3D irq;
> -			goto free_irq;
> -		}
> +	platform_set_drvdata(pdev, di);
> =20
> -		ret =3D request_threaded_irq(irq, NULL, ab8500_charger_irq[i].isr,
> -			IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
> -			ab8500_charger_irq[i].name, di);
> +	/* Create something that will match the subdrivers when we bind */
> +	for (i =3D 0; i < ARRAY_SIZE(ab8500_charger_component_drivers); i++) {
> +		struct device_driver *drv =3D &ab8500_charger_component_drivers[i]->dr=
iver;
> +		struct device *p =3D NULL, *d;
> =20
> -		if (ret !=3D 0) {
> -			dev_err(dev, "failed to request %s IRQ %d: %d\n"
> -				, ab8500_charger_irq[i].name, irq, ret);
> -			goto free_irq;
> +		while ((d =3D platform_find_device_by_driver(p, drv))) {
> +			put_device(p);
> +			component_match_add(dev, &match,
> +					    ab8500_charger_compare_dev, d);
> +			p =3D d;
>  		}
> -		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
> -			ab8500_charger_irq[i].name, irq, ret);
> +		put_device(p);
> +	}
> +	if (!match) {
> +		dev_err(dev, "no matching components\n");
> +		return -ENODEV;
> +	}
> +	if (IS_ERR(match)) {
> +		dev_err(dev, "could not create component match\n");
> +		return PTR_ERR(match);
>  	}
> =20
> -	platform_set_drvdata(pdev, di);
> +	/* Notifier for external charger enabling */
> +	if (!di->ac_chg.enabled)
> +		blocking_notifier_chain_register(
> +			&charger_notifier_list, &charger_nb);
> =20
> -	mutex_lock(&di->charger_attached_mutex);
> =20
> -	ch_stat =3D ab8500_charger_detect_chargers(di, false);
> -
> -	if ((ch_stat & AC_PW_CONN) =3D=3D AC_PW_CONN) {
> -		if (is_ab8500(di->parent))
> -			queue_delayed_work(di->charger_wq,
> -					   &di->ac_charger_attached_work,
> -					   HZ);
> +	di->usb_phy =3D usb_get_phy(USB_PHY_TYPE_USB2);
> +	if (IS_ERR_OR_NULL(di->usb_phy)) {
> +		dev_err(dev, "failed to get usb transceiver\n");
> +		ret =3D -EINVAL;
> +		goto out_charger_notifier;
>  	}
> -	if ((ch_stat & USB_PW_CONN) =3D=3D USB_PW_CONN) {
> -		if (is_ab8500(di->parent))
> -			queue_delayed_work(di->charger_wq,
> -					   &di->usb_charger_attached_work,
> -					   HZ);
> +	di->nb.notifier_call =3D ab8500_charger_usb_notifier_call;
> +	ret =3D usb_register_notifier(di->usb_phy, &di->nb);
> +	if (ret) {
> +		dev_err(dev, "failed to register usb notifier\n");
> +		goto put_usb_phy;
>  	}
> =20
> -	mutex_unlock(&di->charger_attached_mutex);
> =20
> -	return ret;
> +	ret =3D component_master_add_with_match(&pdev->dev,
> +					      &ab8500_charger_comp_ops,
> +					      match);
> +	if (ret) {
> +		dev_err(dev, "failed to add component master\n");
> +		goto free_notifier;
> +	}
> =20
> -free_irq:
> -	usb_unregister_notifier(di->usb_phy, &di->nb);
> +	return 0;
> =20
> -	/* We also have to free all successfully registered irqs */
> -	for (i =3D i - 1; i >=3D 0; i--) {
> -		irq =3D platform_get_irq_byname(pdev, ab8500_charger_irq[i].name);
> -		free_irq(irq, di);
> -	}
> +free_notifier:
> +	usb_unregister_notifier(di->usb_phy, &di->nb);
>  put_usb_phy:
>  	usb_put_phy(di->usb_phy);
> -free_usb:
> -	if (di->usb_chg.enabled)
> -		power_supply_unregister(di->usb_chg.psy);
> -free_ac:
> -	if (di->ac_chg.enabled)
> -		power_supply_unregister(di->ac_chg.psy);
> -free_charger_wq:
> -	destroy_workqueue(di->charger_wq);
> +out_charger_notifier:
> +	if (!di->ac_chg.enabled)
> +		blocking_notifier_chain_unregister(
> +			&charger_notifier_list, &charger_nb);
>  	return ret;
>  }
> =20
> +static int ab8500_charger_remove(struct platform_device *pdev)
> +{
> +	struct ab8500_charger *di =3D platform_get_drvdata(pdev);
> +
> +	component_master_del(&pdev->dev, &ab8500_charger_comp_ops);
> +
> +	usb_unregister_notifier(di->usb_phy, &di->nb);
> +	usb_put_phy(di->usb_phy);
> +	if (!di->ac_chg.enabled)
> +		blocking_notifier_chain_unregister(
> +			&charger_notifier_list, &charger_nb);
> +
> +	return 0;
> +}
> +
>  static SIMPLE_DEV_PM_OPS(ab8500_charger_pm_ops, ab8500_charger_suspend, =
ab8500_charger_resume);
> =20
>  static const struct of_device_id ab8500_charger_match[] =3D {
> @@ -3657,15 +3701,24 @@ static struct platform_driver ab8500_charger_driv=
er =3D {
> =20
>  static int __init ab8500_charger_init(void)
>  {
> +	int ret;
> +
> +	ret =3D platform_register_drivers(ab8500_charger_component_drivers,
> +			ARRAY_SIZE(ab8500_charger_component_drivers));
> +	if (ret)
> +		return ret;
> +
>  	return platform_driver_register(&ab8500_charger_driver);
>  }
> =20
>  static void __exit ab8500_charger_exit(void)
>  {
> +	platform_unregister_drivers(ab8500_charger_component_drivers,
> +			ARRAY_SIZE(ab8500_charger_component_drivers));
>  	platform_driver_unregister(&ab8500_charger_driver);
>  }
> =20
> -subsys_initcall_sync(ab8500_charger_init);
> +module_init(ab8500_charger_init);
>  module_exit(ab8500_charger_exit);
> =20
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 0c7c01a0d979..acf0f2471c0b 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -17,6 +17,7 @@
> =20
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/component.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> @@ -2980,27 +2981,6 @@ static int __maybe_unused ab8500_fg_suspend(struct=
 device *dev)
>  	return 0;
>  }
> =20
> -static int ab8500_fg_remove(struct platform_device *pdev)
> -{
> -	int ret =3D 0;
> -	struct ab8500_fg *di =3D platform_get_drvdata(pdev);
> -
> -	list_del(&di->node);
> -
> -	/* Disable coulomb counter */
> -	ret =3D ab8500_fg_coulomb_counter(di, false);
> -	if (ret)
> -		dev_err(di->dev, "failed to disable coulomb counter\n");
> -
> -	destroy_workqueue(di->fg_wq);
> -	ab8500_fg_sysfs_exit(di);
> -
> -	flush_scheduled_work();
> -	ab8500_fg_sysfs_psy_remove_attrs(di);
> -	power_supply_unregister(di->fg_psy);
> -	return ret;
> -}
> -
>  /* ab8500 fg driver interrupts and their respective isr */
>  static struct ab8500_fg_interrupts ab8500_fg_irq[] =3D {
>  	{"NCONV_ACCU", ab8500_fg_cc_convend_handler},
> @@ -3024,11 +3004,50 @@ static const struct power_supply_desc ab8500_fg_d=
esc =3D {
>  	.external_power_changed	=3D ab8500_fg_external_power_changed,
>  };
> =20
> +static int ab8500_fg_bind(struct device *dev, struct device *master,
> +			  void *data)
> +{
> +	struct ab8500_fg *di =3D dev_get_drvdata(dev);
> +
> +	/* Create a work queue for running the FG algorithm */
> +	di->fg_wq =3D alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
> +	if (di->fg_wq =3D=3D NULL) {
> +		dev_err(dev, "failed to create work queue\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Start the coulomb counter */
> +	ab8500_fg_coulomb_counter(di, true);
> +	/* Run the FG algorithm */
> +	queue_delayed_work(di->fg_wq, &di->fg_periodic_work, 0);
> +
> +	return 0;
> +}
> +
> +static void ab8500_fg_unbind(struct device *dev, struct device *master,
> +			     void *data)
> +{
> +	struct ab8500_fg *di =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* Disable coulomb counter */
> +	ret =3D ab8500_fg_coulomb_counter(di, false);
> +	if (ret)
> +		dev_err(dev, "failed to disable coulomb counter\n");
> +
> +	destroy_workqueue(di->fg_wq);
> +	flush_scheduled_work();
> +}
> +
> +static const struct component_ops ab8500_fg_component_ops =3D {
> +	.bind =3D ab8500_fg_bind,
> +	.unbind =3D ab8500_fg_unbind,
> +};
> +
>  static int ab8500_fg_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np =3D pdev->dev.of_node;
> -	struct power_supply_config psy_cfg =3D {};
>  	struct device *dev =3D &pdev->dev;
> +	struct power_supply_config psy_cfg =3D {};
>  	struct ab8500_fg *di;
>  	int i, irq;
>  	int ret =3D 0;
> @@ -3074,13 +3093,6 @@ static int ab8500_fg_probe(struct platform_device =
*pdev)
>  	ab8500_fg_charge_state_to(di, AB8500_FG_CHARGE_INIT);
>  	ab8500_fg_discharge_state_to(di, AB8500_FG_DISCHARGE_INIT);
> =20
> -	/* Create a work queue for running the FG algorithm */
> -	di->fg_wq =3D alloc_ordered_workqueue("ab8500_fg_wq", WQ_MEM_RECLAIM);
> -	if (di->fg_wq =3D=3D NULL) {
> -		dev_err(dev, "failed to create work queue\n");
> -		return -ENOMEM;
> -	}
> -
>  	/* Init work for running the fg algorithm instantly */
>  	INIT_WORK(&di->fg_work, ab8500_fg_instant_work);
> =20
> @@ -3113,7 +3125,7 @@ static int ab8500_fg_probe(struct platform_device *=
pdev)
>  	ret =3D ab8500_fg_init_hw_registers(di);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize registers\n");
> -		goto free_inst_curr_wq;
> +		return ret;
>  	}
> =20
>  	/* Consider battery unknown until we're informed otherwise */
> @@ -3121,15 +3133,13 @@ static int ab8500_fg_probe(struct platform_device=
 *pdev)
>  	di->flags.batt_id_received =3D false;
> =20
>  	/* Register FG power supply class */
> -	di->fg_psy =3D power_supply_register(dev, &ab8500_fg_desc, &psy_cfg);
> +	di->fg_psy =3D devm_power_supply_register(dev, &ab8500_fg_desc, &psy_cf=
g);
>  	if (IS_ERR(di->fg_psy)) {
>  		dev_err(dev, "failed to register FG psy\n");
> -		ret =3D PTR_ERR(di->fg_psy);
> -		goto free_inst_curr_wq;
> +		return PTR_ERR(di->fg_psy);
>  	}
> =20
>  	di->fg_samples =3D SEC_TO_SAMPLE(di->bm->fg_params->init_timer);
> -	ab8500_fg_coulomb_counter(di, true);
> =20
>  	/*
>  	 * Initialize completion used to notify completion and start
> @@ -3141,19 +3151,18 @@ static int ab8500_fg_probe(struct platform_device=
 *pdev)
>  	/* Register primary interrupt handlers */
>  	for (i =3D 0; i < ARRAY_SIZE(ab8500_fg_irq); i++) {
>  		irq =3D platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
> -		if (irq < 0) {
> -			ret =3D irq;
> -			goto free_irq;
> -		}
> +		if (irq < 0)
> +			return irq;
> =20
> -		ret =3D request_threaded_irq(irq, NULL, ab8500_fg_irq[i].isr,
> +		ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +				  ab8500_fg_irq[i].isr,
>  				  IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
>  				  ab8500_fg_irq[i].name, di);
> =20
>  		if (ret !=3D 0) {
>  			dev_err(dev, "failed to request %s IRQ %d: %d\n",
>  				ab8500_fg_irq[i].name, irq, ret);
> -			goto free_irq;
> +			return ret;
>  		}
>  		dev_dbg(dev, "Requested %s IRQ %d: %d\n",
>  			ab8500_fg_irq[i].name, irq, ret);
> @@ -3168,14 +3177,14 @@ static int ab8500_fg_probe(struct platform_device=
 *pdev)
>  	ret =3D ab8500_fg_sysfs_init(di);
>  	if (ret) {
>  		dev_err(dev, "failed to create sysfs entry\n");
> -		goto free_irq;
> +		return ret;
>  	}
> =20
>  	ret =3D ab8500_fg_sysfs_psy_create_attrs(di);
>  	if (ret) {
>  		dev_err(dev, "failed to create FG psy\n");
>  		ab8500_fg_sysfs_exit(di);
> -		goto free_irq;
> +		return ret;
>  	}
> =20
>  	/* Calibrate the fg first time */
> @@ -3185,24 +3194,21 @@ static int ab8500_fg_probe(struct platform_device=
 *pdev)
>  	/* Use room temp as default value until we get an update from driver. */
>  	di->bat_temp =3D 210;
> =20
> -	/* Run the FG algorithm */
> -	queue_delayed_work(di->fg_wq, &di->fg_periodic_work, 0);
> -
>  	list_add_tail(&di->node, &ab8500_fg_list);
> =20
> -	return ret;
> +	return component_add(dev, &ab8500_fg_component_ops);
> +}
> =20
> -free_irq:
> -	/* We also have to free all registered irqs */
> -	while (--i >=3D 0) {
> -		/* Last assignment of i from primary interrupt handlers */
> -		irq =3D platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
> -		free_irq(irq, di);
> -	}
> +static int ab8500_fg_remove(struct platform_device *pdev)
> +{
> +	int ret =3D 0;
> +	struct ab8500_fg *di =3D platform_get_drvdata(pdev);
> +
> +	component_del(&pdev->dev, &ab8500_fg_component_ops);
> +	list_del(&di->node);
> +	ab8500_fg_sysfs_exit(di);
> +	ab8500_fg_sysfs_psy_remove_attrs(di);
> =20
> -	power_supply_unregister(di->fg_psy);
> -free_inst_curr_wq:
> -	destroy_workqueue(di->fg_wq);
>  	return ret;
>  }
> =20
> @@ -3213,7 +3219,7 @@ static const struct of_device_id ab8500_fg_match[] =
=3D {
>  	{ },
>  };
> =20
> -static struct platform_driver ab8500_fg_driver =3D {
> +struct platform_driver ab8500_fg_driver =3D {
>  	.probe =3D ab8500_fg_probe,
>  	.remove =3D ab8500_fg_remove,
>  	.driver =3D {
> @@ -3222,20 +3228,6 @@ static struct platform_driver ab8500_fg_driver =3D=
 {
>  		.pm =3D &ab8500_fg_pm_ops,
>  	},
>  };
> -
> -static int __init ab8500_fg_init(void)
> -{
> -	return platform_driver_register(&ab8500_fg_driver);
> -}
> -
> -static void __exit ab8500_fg_exit(void)
> -{
> -	platform_driver_unregister(&ab8500_fg_driver);
> -}
> -
> -subsys_initcall_sync(ab8500_fg_init);
> -module_exit(ab8500_fg_exit);
> -
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Johan Palsson, Karl Komierowski");
>  MODULE_ALIAS("platform:ab8500-fg");
> diff --git a/drivers/power/supply/abx500_chargalg.c b/drivers/power/suppl=
y/abx500_chargalg.c
> index f5b792243727..599684ce0e4b 100644
> --- a/drivers/power/supply/abx500_chargalg.c
> +++ b/drivers/power/supply/abx500_chargalg.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> +#include <linux/component.h>
>  #include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -1943,13 +1944,44 @@ static int __maybe_unused abx500_chargalg_suspend=
(struct device *dev)
>  	return 0;
>  }
> =20
> -static int abx500_chargalg_remove(struct platform_device *pdev)
> +static char *supply_interface[] =3D {
> +	"ab8500_fg",
> +};
> +
> +static const struct power_supply_desc abx500_chargalg_desc =3D {
> +	.name			=3D "abx500_chargalg",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties		=3D abx500_chargalg_props,
> +	.num_properties		=3D ARRAY_SIZE(abx500_chargalg_props),
> +	.get_property		=3D abx500_chargalg_get_property,
> +	.external_power_changed	=3D abx500_chargalg_external_power_changed,
> +};
> +
> +static int abx500_chargalg_bind(struct device *dev, struct device *maste=
r,
> +				void *data)
>  {
> -	struct abx500_chargalg *di =3D platform_get_drvdata(pdev);
> +	struct abx500_chargalg *di =3D dev_get_drvdata(dev);
> =20
> -	/* sysfs interface to enable/disbale charging from user space */
> -	abx500_chargalg_sysfs_exit(di);
> +	/* Create a work queue for the chargalg */
> +	di->chargalg_wq =3D alloc_ordered_workqueue("abx500_chargalg_wq",
> +						  WQ_MEM_RECLAIM);
> +	if (di->chargalg_wq =3D=3D NULL) {
> +		dev_err(di->dev, "failed to create work queue\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Run the charging algorithm */
> +	queue_delayed_work(di->chargalg_wq, &di->chargalg_periodic_work, 0);
> +
> +	return 0;
> +}
> =20
> +static void abx500_chargalg_unbind(struct device *dev, struct device *ma=
ster,
> +				   void *data)
> +{
> +	struct abx500_chargalg *di =3D dev_get_drvdata(dev);
> +
> +	/* Stop all timers and work */
>  	hrtimer_cancel(&di->safety_timer);
>  	hrtimer_cancel(&di->maintenance_timer);
> =20
> @@ -1959,48 +1991,36 @@ static int abx500_chargalg_remove(struct platform=
_device *pdev)
> =20
>  	/* Delete the work queue */
>  	destroy_workqueue(di->chargalg_wq);
> -
> -	power_supply_unregister(di->chargalg_psy);
> -
> -	return 0;
> +	flush_scheduled_work();
>  }
> =20
> -static char *supply_interface[] =3D {
> -	"ab8500_fg",
> -};
> -
> -static const struct power_supply_desc abx500_chargalg_desc =3D {
> -	.name			=3D "abx500_chargalg",
> -	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> -	.properties		=3D abx500_chargalg_props,
> -	.num_properties		=3D ARRAY_SIZE(abx500_chargalg_props),
> -	.get_property		=3D abx500_chargalg_get_property,
> -	.external_power_changed	=3D abx500_chargalg_external_power_changed,
> +static const struct component_ops abx500_chargalg_component_ops =3D {
> +	.bind =3D abx500_chargalg_bind,
> +	.unbind =3D abx500_chargalg_unbind,
>  };
> =20
>  static int abx500_chargalg_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
>  	struct power_supply_config psy_cfg =3D {};
>  	struct abx500_chargalg *di;
>  	int ret =3D 0;
> =20
> -	di =3D devm_kzalloc(&pdev->dev, sizeof(*di), GFP_KERNEL);
> -	if (!di) {
> -		dev_err(&pdev->dev, "%s no mem for ab8500_chargalg\n", __func__);
> +	di =3D devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
> +	if (!di)
>  		return -ENOMEM;
> -	}
> =20
>  	di->bm =3D &ab8500_bm_data;
> =20
> -	ret =3D ab8500_bm_of_probe(&pdev->dev, np, di->bm);
> +	ret =3D ab8500_bm_of_probe(dev, np, di->bm);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to get battery information\n");
> +		dev_err(dev, "failed to get battery information\n");
>  		return ret;
>  	}
> =20
>  	/* get device struct and parent */
> -	di->dev =3D &pdev->dev;
> +	di->dev =3D dev;
>  	di->parent =3D dev_get_drvdata(pdev->dev.parent);
> =20
>  	psy_cfg.supplied_to =3D supply_interface;
> @@ -2016,14 +2036,6 @@ static int abx500_chargalg_probe(struct platform_d=
evice *pdev)
>  	di->maintenance_timer.function =3D
>  		abx500_chargalg_maintenance_timer_expired;
> =20
> -	/* Create a work queue for the chargalg */
> -	di->chargalg_wq =3D alloc_ordered_workqueue("abx500_chargalg_wq",
> -						   WQ_MEM_RECLAIM);
> -	if (di->chargalg_wq =3D=3D NULL) {
> -		dev_err(di->dev, "failed to create work queue\n");
> -		return -ENOMEM;
> -	}
> -
>  	/* Init work for chargalg */
>  	INIT_DEFERRABLE_WORK(&di->chargalg_periodic_work,
>  		abx500_chargalg_periodic_work);
> @@ -2037,12 +2049,12 @@ static int abx500_chargalg_probe(struct platform_=
device *pdev)
>  	di->chg_info.prev_conn_chg =3D -1;
> =20
>  	/* Register chargalg power supply class */
> -	di->chargalg_psy =3D power_supply_register(di->dev, &abx500_chargalg_de=
sc,
> +	di->chargalg_psy =3D devm_power_supply_register(di->dev,
> +						 &abx500_chargalg_desc,
>  						 &psy_cfg);
>  	if (IS_ERR(di->chargalg_psy)) {
>  		dev_err(di->dev, "failed to register chargalg psy\n");
> -		ret =3D PTR_ERR(di->chargalg_psy);
> -		goto free_chargalg_wq;
> +		return PTR_ERR(di->chargalg_psy);
>  	}
> =20
>  	platform_set_drvdata(pdev, di);
> @@ -2051,21 +2063,24 @@ static int abx500_chargalg_probe(struct platform_=
device *pdev)
>  	ret =3D abx500_chargalg_sysfs_init(di);
>  	if (ret) {
>  		dev_err(di->dev, "failed to create sysfs entry\n");
> -		goto free_psy;
> +		return ret;
>  	}
>  	di->curr_status.curr_step =3D CHARGALG_CURR_STEP_HIGH;
> =20
> -	/* Run the charging algorithm */
> -	queue_delayed_work(di->chargalg_wq, &di->chargalg_periodic_work, 0);
> -
>  	dev_info(di->dev, "probe success\n");
> -	return ret;
> +	return component_add(dev, &abx500_chargalg_component_ops);
> +}
> =20
> -free_psy:
> -	power_supply_unregister(di->chargalg_psy);
> -free_chargalg_wq:
> -	destroy_workqueue(di->chargalg_wq);
> -	return ret;
> +static int abx500_chargalg_remove(struct platform_device *pdev)
> +{
> +	struct abx500_chargalg *di =3D platform_get_drvdata(pdev);
> +
> +	component_del(&pdev->dev, &abx500_chargalg_component_ops);
> +
> +	/* sysfs interface to enable/disable charging from user space */
> +	abx500_chargalg_sysfs_exit(di);
> +
> +	return 0;
>  }
> =20
>  static SIMPLE_DEV_PM_OPS(abx500_chargalg_pm_ops, abx500_chargalg_suspend=
, abx500_chargalg_resume);
> @@ -2075,7 +2090,7 @@ static const struct of_device_id ab8500_chargalg_ma=
tch[] =3D {
>  	{ },
>  };
> =20
> -static struct platform_driver abx500_chargalg_driver =3D {
> +struct platform_driver abx500_chargalg_driver =3D {
>  	.probe =3D abx500_chargalg_probe,
>  	.remove =3D abx500_chargalg_remove,
>  	.driver =3D {
> @@ -2084,9 +2099,6 @@ static struct platform_driver abx500_chargalg_drive=
r =3D {
>  		.pm =3D &abx500_chargalg_pm_ops,
>  	},
>  };
> -
> -module_platform_driver(abx500_chargalg_driver);
> -
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Johan Palsson, Karl Komierowski");
>  MODULE_ALIAS("platform:abx500-chargalg");
> --=20
> 2.31.1
>=20

--vrnsgswxfcnxqsem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5B7cACgkQ2O7X88g7
+pqCBQ//aFVIqIiV4sRjLlOVoKDzj58AblESnQFflbF+VLvNFh/7wySp3yMAR80l
YwZ+gNK9qz9isyivgJkj4RoCKSIF6aXw/eymmNbiOxk6DPnGuB5jf8waaG4EgMyP
xx1yPVN6Xy1I84x9a3+v1ofIH+lH/Dm9arD9DKvdW2Eu8GQnaNVK2LLPTXFNucFk
dBN8XJPG/4qIljLuxLJK07lHJlx7MwUEI6eL672i50Z7FwIOZdXyKjS6zrAAic4B
mBORRLlFDYWjJZz+pV15ubdaxVPyxsQ0Xhw2NTtTN35eK0pmhWEbnFMiHjhUaqxe
eEbxIrsg1ANEtfTShuiMke5crcKOl/x3bJVj3oi4vqDSLbd//ksKbOMuFg8Q0XUP
elzfEkSMhv4Vuw9+0g/bEQvR6TP1aCA+ZxcaYBEICb29FTDpkyvtGpAnz/Yv0dh0
pWER69/6zVNGOLR5YTBr23cN6lRUk+xfwru6uLL72lOmaOFZCG9R2S3WnOAtuk6B
gso7uAk8WsRfHAW5Nz0LAxqANMBQDMzJGWvKZvtoJ+HTvL3R6UFG9xQCUWsmv6cX
vwo+yPo9Htk5MQ6xu8v04orZ2rMF6QTPdUuUjGbqUvwmZsdTK7JuDWLhWhKnVM8h
N91mGG9jhpr3fFLmRDqV5vEfKAuV8jFf3EWDnYIWIIrP5zU45Ho=
=WHSp
-----END PGP SIGNATURE-----

--vrnsgswxfcnxqsem--
