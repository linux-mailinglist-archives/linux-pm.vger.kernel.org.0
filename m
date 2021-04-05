Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5932835482C
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 23:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDEVcw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 17:32:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhDEVcv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 17:32:51 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 61D101F44684
Received: by earth.universe (Postfix, from userid 1000)
        id 153853C0C96; Mon,  5 Apr 2021 23:32:41 +0200 (CEST)
Date:   Mon, 5 Apr 2021 23:32:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: Add battery driver for Surface
 Aggregator Module
Message-ID: <20210405213241.r6xhtbaf4qkzylz2@earth.universe>
References: <20210309000530.2165752-1-luzmaximilian@gmail.com>
 <20210309000530.2165752-2-luzmaximilian@gmail.com>
 <20210405153752.2r4ii5lguogchgl4@earth.universe>
 <046f6149-55fd-431e-d582-cc5915d10e20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2kgvvnmznjx3piv"
Content-Disposition: inline
In-Reply-To: <046f6149-55fd-431e-d582-cc5915d10e20@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--s2kgvvnmznjx3piv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 05, 2021 at 09:07:55PM +0200, Maximilian Luz wrote:
> [...]
> > > +static int spwr_battery_recheck_adapter(struct spwr_battery_device *=
bat)
> > > +{
> > > +	/*
> > > +	 * Handle battery update quirk: When the battery is fully charged (=
or
> > > +	 * charged up to the limit imposed by the UEFI battery limit) and t=
he
> > > +	 * adapter is plugged in or removed, the EC does not send a separate
> > > +	 * event for the state (charging/discharging) change. Furthermore it
> > > +	 * may take some time until the state is updated on the battery.
> > > +	 * Schedule an update to solve this.
> > > +	 */
> >=20
> > As long as the adapter plug event is being sent you can just add
> > .external_power_changed() hook in this driver and update the battery
> > status there instead of using this hack :)
> >=20
> > This requires populating .supplied_to in the charger driver, so that
> > it will notify the battery device when power_supply_changed() is called
> > for the charger. I will point this out when reviewing PATCH 2.
>=20
> I'll switch this to the .external_power_changed() callback, thanks for
> pointing that out.
>=20
> I still need the delay though. The event for the charger is the same
> event that we rely on here, so the charging/not-charging flag in the BST
> data may still not be updated yet. So unfortunately still a bit of a
> hack required.

Ah, too bad.

> > > +	schedule_delayed_work(&bat->update_work, SPWR_AC_BAT_UPDATE_DELAY);
> > > +	return 0;
> > > +}
> [...]
> > > +static void spwr_battery_update_bst_workfn(struct work_struct *work)
> > > +{
> > > +	struct delayed_work *dwork =3D to_delayed_work(work);
> > > +	struct spwr_battery_device *bat;
> > > +	int status;
> > > +
> > > +	bat =3D container_of(dwork, struct spwr_battery_device, update_work=
);
> > > +
> > > +	status =3D spwr_battery_update_bst(bat, false);
> > > +	if (!status)
> > > +		power_supply_changed(bat->psy);
> >=20
> > power_supply_changed should only be changed for 'important' changes
> > (e.g. charging status changes, temperature or capacity threshold reache=
d),
> > not every 5 seconds.
>=20
> This work struct will only be scheduled when we receive an adapter event
> and is required to handle the quirk above, so this should be an
> important change (state changing from charging to not-charging or back)
> and shouldn't repeat too often, or rather only when the user
> plugs/unplugs the charger.

Ack.

> [...]
> > > +/* -- Alarm attribute. ---------------------------------------------=
--------- */
> > > +
> > > +static ssize_t spwr_battery_alarm_show(struct device *dev, struct de=
vice_attribute *attr, char *buf)
> > > +{
> > > +	struct power_supply *psy =3D dev_get_drvdata(dev);
> > > +	struct spwr_battery_device *bat =3D power_supply_get_drvdata(psy);
> > > +	int status;
> > > +
> > > +	mutex_lock(&bat->lock);
> > > +	status =3D sysfs_emit(buf, "%d\n", bat->alarm * 1000);
> > > +	mutex_unlock(&bat->lock);
> > > +
> > > +	return status;
> > > +}
> > > +
> > > +static ssize_t spwr_battery_alarm_store(struct device *dev, struct d=
evice_attribute *attr,
> > > +					const char *buf, size_t count)
> > > +{
> > > +	struct power_supply *psy =3D dev_get_drvdata(dev);
> > > +	struct spwr_battery_device *bat =3D power_supply_get_drvdata(psy);
> > > +	unsigned long value;
> > > +	int status;
> > > +
> > > +	status =3D kstrtoul(buf, 0, &value);
> > > +	if (status)
> > > +		return status;
> > > +
> > > +	mutex_lock(&bat->lock);
> > > +
> > > +	if (!spwr_battery_present(bat)) {
> > > +		mutex_unlock(&bat->lock);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > > +	status =3D spwr_battery_set_alarm_unlocked(bat, value / 1000);
> > > +	if (status) {
> > > +		mutex_unlock(&bat->lock);
> > > +		return status;
> > > +	}
> > > +
> > > +	mutex_unlock(&bat->lock);
> > > +	return count;
> > > +}
> > > +
> > > +static const struct device_attribute alarm_attr =3D {
> > > +	.attr =3D {.name =3D "alarm", .mode =3D 0644},
> > > +	.show =3D spwr_battery_alarm_show,
> > > +	.store =3D spwr_battery_alarm_store,
> > > +};
> >=20
> > DEVICE_ATTR_RW()
> >=20
> > custom property needs to be documented in
> >=20
> > Documentation/ABI/testing/sysfs-class-power-surface
> >=20
> > Also I'm not sure what is being stored here, but it looks like you
> > can just use POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN?
>=20
> This (and other handling of the alarm value) has essentially been copied
> from drivers/acpi/battery.c and corresponds to ACPI _BTP/battery trip
> point (the whole interface of this EC is essentially modeled after the
> ACPI spec).
>=20
> The alarm value isn't strictly required to be a lower threshold, but is
> (according to ACPI spec) a trip point that causes an event to be sent
> when it is crossed in either direction. So I don't think we can directly
> map this to POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN as that seems to imply
> a lower threshold only.
>=20
> I'll add documentation for this if that's allright.

Ack.

> [...]
> > > +static void spwr_battery_unregister(struct spwr_battery_device *bat)
> > > +{
> > > +	ssam_notifier_unregister(bat->sdev->ctrl, &bat->notif);
> > > +	cancel_delayed_work_sync(&bat->update_work);
> > > +	device_remove_file(&bat->psy->dev, &alarm_attr);
> > > +	power_supply_unregister(bat->psy);
> >=20
> > power_supply_unregister being the last function call is a clear
> > sign, that devm_power_supply_register can be used instead.
>=20
> Right, that works here. I normally try to not mix devm code with
> non-devm code (apart from maybe allocations).

well allocations are usually done first and free'd last making
them the first targets in the conversion and pretty much a no
brainer.

Next merge window it's possible to easily go to full devm by
using devm_delayed_work_autocancel(), which has been merged
by Greg two weeks ago. Then last but not least do the ssam
notifier unregister via devm_add_action_or_reset and its fully
converted :)

-- Sebastian

--s2kgvvnmznjx3piv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBrgfIACgkQ2O7X88g7
+poIgw//eiNHJHzoFU774Y+VeSHxK+HM6QjOyuqGJ+kQDOF3Crzp3L/sAPr/Q2pt
4vmYamGfYq7G7oFT65G30+AZpZ6xu8XmWWJzbErEm8OP9CglBJUfNptSE+DqaJkc
h2Gn4Q2DUM16L+3V70BCMzBZJLHaaiKkcSb8nNYtB1S0+CFS4lecZRRn2tfeyt1R
vOXhUsm3DCKUF69qxjl7OoXMhVu5mJwZCcLrBn57MW/8Ou87vblYvwSCJPKMXGmo
osxfftbDXNVKMgQusJ3wPmUxqpEfYjLp/l6wdX9g1/e2zFLMyjuuT0A1sUInzShY
/kTJqrJ//BPf0JjXtlhPsV+ijD8+jJXMhJb1AKyh6/D331VrblIKlQipmlwpxvD5
695uKzejgzG3tMFug5tfCt73uXhMJjX7HEvT5brqO3bUoVPS2AdYZ4TZQEH3N2Qc
91YJjUFX9M/Cv7AehCRPo+AuKilty8NroEk7VcO7wHidufh6jgLezj7ndSoUfO+G
2rQt9tZgCHD6veyw0P3L+Zs5rGf0PcPeqmA179zxLFdmjdJZ0ri08KJvHJWb6cJ0
ezAdmsyCTBBnUDxoYCAQx3QjphWu4XuerhjOhAQu7kIgzE3PBeY+lCoej/uG+oEb
gBudGk+2JwZyuJxb/uW4mHwKkLDlgxNCCCtHHo1+2tfAM5Hwn/0=
=8fEC
-----END PGP SIGNATURE-----

--s2kgvvnmznjx3piv--
