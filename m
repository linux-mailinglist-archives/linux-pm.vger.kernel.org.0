Return-Path: <linux-pm+bounces-37834-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3635FC52CDB
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 15:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CEFD34FFA1
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 14:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2C533AD83;
	Wed, 12 Nov 2025 14:42:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB8330B33;
	Wed, 12 Nov 2025 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958569; cv=none; b=RIofjAFWK8BWQud/OYIOW9sXz064BLSWbStKUXTMIZVibl8XcO5/y8ICbHD1W4Q9dAJGqkgUG8OOJ3egnotInRdxPakZ0XvzoMPNb1MgNtqVGj0sGkOrUaORtOk6nU7ALbzfrVJ3gF4hyKNM1nJiJXBk5srliUbt60M0kUP6Ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958569; c=relaxed/simple;
	bh=7kgk05jR1DYbLx7fmcPVyzDPEa4zB1Mzv7bqh2gTxSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bMGxgbG7iSCx8PF7IFksGH/GCQGsX985QtrS7RupLEoVv4h5Bwb5/1l/HHJ09syyJVaNv7Gp7iO6Ai4zx01KMszvsmq0HBdhVI8SvmCFk3BbUQBiuqbPB00mq0uzgn1g+cEL4Mb5ttQrFYUeaHLmEfcos3m/SqmCFRbrBEgEZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id A8738580E5A;
	Wed, 12 Nov 2025 14:15:08 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC41843E3B;
	Wed, 12 Nov 2025 14:15:00 +0000 (UTC)
Message-ID: <82ec5223f83eaa89278997fe95ee9ea83236a4a1.camel@hadess.net>
Subject: Re: [RFC PATCH 1/1] HID: input: Add support for multiple batteries
 per device
From: Bastien Nocera <hadess@hadess.net>
To: Lucas Zampieri <lzampier@redhat.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires <bentiss@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org
Date: Wed, 12 Nov 2025 15:15:00 +0100
In-Reply-To: <20251111105634.1684751-2-lzampier@redhat.com>
References: <20251111105634.1684751-1-lzampier@redhat.com>
	 <20251111105634.1684751-2-lzampier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepjedprhgtphhtthhopehliigrmhhpihgvrhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrn
 hgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: hadess@hadess.net

Hey Lucas,

(Follow-up to a chat we had about this patch privately)

On Tue, 2025-11-11 at 10:56 +0000, Lucas Zampieri wrote:
> Add support for multiple batteries per HID device by introducing
> struct hid_battery to encapsulate individual battery state and using
> a list to track multiple batteries identified by report ID. The
> legacy
> dev->battery field is maintained for backwards compatibility.

The cover letter mentions specific hardware, you probably want to
mention this in the commit message itself, as the cover letter will be
disconnected from this commit once this gets merged. Don't hesitate to
link to product pages directly if you want to show specific products as
potential users of that capability.

You mentioned that you tested this patchset with a custom firmware for
a split keyboard. It would be great if the firmware could be made
available to show how this was tested and mention that in the commit
message.

bentiss will also likely want a hid-recorder output for the device that
shows the batteries being instantiated. This would also likely be used
to test whether upower continues working as expected.

Talking of upower, I think we'll need an systemd/hwdb + upower changes
to differentiate batteries within a single device, as I don't think we
can have enough metadata in the HID report to differentiate them.

Last comment about the patch itself, do you think it would be feasible
to split this in 2 or 3? One to introduce the hid_battery struct,
another to use it to replace direct power_supply access, and finally
one to allow a list of hid_batteries?

Don't hesitate to CC: on future versions.

Cheers

>=20
> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> ---
> =C2=A0drivers/hid/hid-core.c=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0drivers/hid/hid-input.c | 193 +++++++++++++++++++++++++++----------=
-
> --
> =C2=A0include/linux/hid.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 42 ++++++++-
> =C2=A03 files changed, 176 insertions(+), 63 deletions(-)
>=20
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a5b3a8ca2fcb..76d628547e9a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2990,6 +2990,10 @@ struct hid_device *hid_allocate_device(void)
> =C2=A0	mutex_init(&hdev->ll_open_lock);
> =C2=A0	kref_init(&hdev->ref);
> =C2=A0
> +#ifdef CONFIG_HID_BATTERY_STRENGTH
> +	INIT_LIST_HEAD(&hdev->batteries);
> +#endif
> +
> =C2=A0	ret =3D hid_bpf_device_init(hdev);
> =C2=A0	if (ret)
> =C2=A0		goto out_err;
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index e56e7de53279..071df319775b 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -454,7 +454,8 @@ static int hidinput_get_battery_property(struct
> power_supply *psy,
> =C2=A0					 enum power_supply_property
> prop,
> =C2=A0					 union power_supply_propval
> *val)
> =C2=A0{
> -	struct hid_device *dev =3D power_supply_get_drvdata(psy);
> +	struct hid_battery *bat =3D power_supply_get_drvdata(psy);
> +	struct hid_device *dev =3D bat->dev;
> =C2=A0	int value;
> =C2=A0	int ret =3D 0;
> =C2=A0
> @@ -465,13 +466,13 @@ static int hidinput_get_battery_property(struct
> power_supply *psy,
> =C2=A0		break;
> =C2=A0
> =C2=A0	case POWER_SUPPLY_PROP_CAPACITY:
> -		if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> -		=C2=A0=C2=A0=C2=A0 !dev->battery_avoid_query) {
> +		if (bat->status !=3D HID_BATTERY_REPORTED &&
> +		=C2=A0=C2=A0=C2=A0 !bat->avoid_query) {
> =C2=A0			value =3D
> hidinput_query_battery_capacity(dev);
> =C2=A0			if (value < 0)
> =C2=A0				return value;
> =C2=A0		} else=C2=A0 {
> -			value =3D dev->battery_capacity;
> +			value =3D bat->capacity;
> =C2=A0		}
> =C2=A0
> =C2=A0		val->intval =3D value;
> @@ -482,20 +483,20 @@ static int hidinput_get_battery_property(struct
> power_supply *psy,
> =C2=A0		break;
> =C2=A0
> =C2=A0	case POWER_SUPPLY_PROP_STATUS:
> -		if (dev->battery_status !=3D HID_BATTERY_REPORTED &&
> -		=C2=A0=C2=A0=C2=A0 !dev->battery_avoid_query) {
> +		if (bat->status !=3D HID_BATTERY_REPORTED &&
> +		=C2=A0=C2=A0=C2=A0 !bat->avoid_query) {
> =C2=A0			value =3D
> hidinput_query_battery_capacity(dev);
> =C2=A0			if (value < 0)
> =C2=A0				return value;
> =C2=A0
> -			dev->battery_capacity =3D value;
> -			dev->battery_status =3D HID_BATTERY_QUERIED;
> +			bat->capacity =3D value;
> +			bat->status =3D HID_BATTERY_QUERIED;
> =C2=A0		}
> =C2=A0
> -		if (dev->battery_status =3D=3D HID_BATTERY_UNKNOWN)
> +		if (bat->status =3D=3D HID_BATTERY_UNKNOWN)
> =C2=A0			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> =C2=A0		else
> -			val->intval =3D dev->battery_charge_status;
> +			val->intval =3D bat->charge_status;
> =C2=A0		break;
> =C2=A0
> =C2=A0	case POWER_SUPPLY_PROP_SCOPE:
> @@ -513,33 +514,53 @@ static int hidinput_get_battery_property(struct
> power_supply *psy,
> =C2=A0static int hidinput_setup_battery(struct hid_device *dev, unsigned
> report_type,
> =C2=A0				=C2=A0 struct hid_field *field, bool
> is_percentage)
> =C2=A0{
> +	struct hid_battery *bat;
> =C2=A0	struct power_supply_desc *psy_desc;
> -	struct power_supply_config psy_cfg =3D { .drv_data =3D dev, };
> +	struct power_supply_config psy_cfg;
> =C2=A0	unsigned quirks;
> =C2=A0	s32 min, max;
> =C2=A0	int error;
> +	int battery_num =3D 0;
> =C2=A0
> -	if (dev->battery)
> -		return 0;	/* already initialized? */
> +	list_for_each_entry(bat, &dev->batteries, list) {
> +		if (bat->report_id =3D=3D field->report->id)
> +			return 0;	/* already initialized */
> +		battery_num++;
> +	}
> =C2=A0
> =C2=A0	quirks =3D find_battery_quirk(dev);
> =C2=A0
> -	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
> -		dev->bus, dev->vendor, dev->product, dev->version,
> quirks);
> +	hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
> +		dev->bus, dev->vendor, dev->product, dev->version,
> quirks,
> +		field->report->id);
> =C2=A0
> =C2=A0	if (quirks & HID_BATTERY_QUIRK_IGNORE)
> =C2=A0		return 0;
> =C2=A0
> -	psy_desc =3D kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> -	if (!psy_desc)
> +	bat =3D kzalloc(sizeof(*bat), GFP_KERNEL);
> +	if (!bat)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-battery",
> -				=C2=A0=C2=A0 strlen(dev->uniq) ?
> -					dev->uniq : dev_name(&dev-
> >dev));
> +	psy_desc =3D kzalloc(sizeof(*psy_desc), GFP_KERNEL);
> +	if (!psy_desc) {
> +		error =3D -ENOMEM;
> +		goto err_free_bat;
> +	}
> +
> +	/* Create unique name for each battery based on report ID */
> +	if (battery_num =3D=3D 0) {
> +		psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-
> battery",
> +					=C2=A0=C2=A0 strlen(dev->uniq) ?
> +						dev->uniq :
> dev_name(&dev->dev));
> +	} else {
> +		psy_desc->name =3D kasprintf(GFP_KERNEL, "hid-%s-
> battery-%d",
> +					=C2=A0=C2=A0 strlen(dev->uniq) ?
> +						dev->uniq :
> dev_name(&dev->dev),
> +					=C2=A0=C2=A0 battery_num);
> +	}
> =C2=A0	if (!psy_desc->name) {
> =C2=A0		error =3D -ENOMEM;
> -		goto err_free_mem;
> +		goto err_free_desc;
> =C2=A0	}
> =C2=A0
> =C2=A0	psy_desc->type =3D POWER_SUPPLY_TYPE_BATTERY;
> @@ -559,98 +580,148 @@ static int hidinput_setup_battery(struct
> hid_device *dev, unsigned report_type,
> =C2=A0	if (quirks & HID_BATTERY_QUIRK_FEATURE)
> =C2=A0		report_type =3D HID_FEATURE_REPORT;
> =C2=A0
> -	dev->battery_min =3D min;
> -	dev->battery_max =3D max;
> -	dev->battery_report_type =3D report_type;
> -	dev->battery_report_id =3D field->report->id;
> -	dev->battery_charge_status =3D
> POWER_SUPPLY_STATUS_DISCHARGING;
> +	/* Initialize battery structure */
> +	bat->dev =3D dev;
> +	bat->min =3D min;
> +	bat->max =3D max;
> +	bat->report_type =3D report_type;
> +	bat->report_id =3D field->report->id;
> +	bat->charge_status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	bat->status =3D HID_BATTERY_UNKNOWN;
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Stylus is normally not connected to the device and thus
> we
> =C2=A0	 * can't query the device and get meaningful battery
> strength.
> =C2=A0	 * We have to wait for the device to report it on its own.
> =C2=A0	 */
> -	dev->battery_avoid_query =3D report_type =3D=3D HID_INPUT_REPORT
> &&
> -				=C2=A0=C2=A0 field->physical =3D=3D HID_DG_STYLUS;
> +	bat->avoid_query =3D report_type =3D=3D HID_INPUT_REPORT &&
> +			=C2=A0=C2=A0 field->physical =3D=3D HID_DG_STYLUS;
> =C2=A0
> =C2=A0	if (quirks & HID_BATTERY_QUIRK_AVOID_QUERY)
> -		dev->battery_avoid_query =3D true;
> +		bat->avoid_query =3D true;
> =C2=A0
> -	dev->battery =3D power_supply_register(&dev->dev, psy_desc,
> &psy_cfg);
> -	if (IS_ERR(dev->battery)) {
> -		error =3D PTR_ERR(dev->battery);
> +	psy_cfg.drv_data =3D bat;
> +	bat->ps =3D power_supply_register(&dev->dev, psy_desc,
> &psy_cfg);
> +	if (IS_ERR(bat->ps)) {
> +		error =3D PTR_ERR(bat->ps);
> =C2=A0		hid_warn(dev, "can't register power supply: %d\n",
> error);
> =C2=A0		goto err_free_name;
> =C2=A0	}
> =C2=A0
> -	power_supply_powers(dev->battery, &dev->dev);
> +	power_supply_powers(bat->ps, &dev->dev);
> +
> +	list_add_tail(&bat->list, &dev->batteries);
> +
> +	/*
> +	 * The legacy single battery API is preserved by exposing
> the first
> +	 * discovered battery. Systems relying on a single battery
> view maintain
> +	 * unchanged behavior.
> +	 */
> +	if (battery_num =3D=3D 0) {
> +		dev->battery =3D bat->ps;
> +		dev->battery_min =3D bat->min;
> +		dev->battery_max =3D bat->max;
> +		dev->battery_report_type =3D bat->report_type;
> +		dev->battery_report_id =3D bat->report_id;
> +		dev->battery_charge_status =3D bat->charge_status;
> +		dev->battery_status =3D bat->status;
> +		dev->battery_avoid_query =3D bat->avoid_query;
> +	}
> +
> =C2=A0	return 0;
> =C2=A0
> =C2=A0err_free_name:
> =C2=A0	kfree(psy_desc->name);
> -err_free_mem:
> +err_free_desc:
> =C2=A0	kfree(psy_desc);
> -	dev->battery =3D NULL;
> +err_free_bat:
> +	kfree(bat);
> =C2=A0	return error;
> =C2=A0}
> =C2=A0
> =C2=A0static void hidinput_cleanup_battery(struct hid_device *dev)
> =C2=A0{
> +	struct hid_battery *bat, *next;
> =C2=A0	const struct power_supply_desc *psy_desc;
> =C2=A0
> -	if (!dev->battery)
> -		return;
> +	list_for_each_entry_safe(bat, next, &dev->batteries, list) {
> +		psy_desc =3D bat->ps->desc;
> +		power_supply_unregister(bat->ps);
> +		kfree(psy_desc->name);
> +		kfree(psy_desc);
> +		list_del(&bat->list);
> +		kfree(bat);
> +	}
> =C2=A0
> -	psy_desc =3D dev->battery->desc;
> -	power_supply_unregister(dev->battery);
> -	kfree(psy_desc->name);
> -	kfree(psy_desc);
> =C2=A0	dev->battery =3D NULL;
> =C2=A0}
> =C2=A0
> -static bool hidinput_update_battery_charge_status(struct hid_device
> *dev,
> +static struct hid_battery *hidinput_find_battery(struct hid_device
> *dev,
> +						 int report_id)
> +{
> +	struct hid_battery *bat;
> +
> +	list_for_each_entry(bat, &dev->batteries, list) {
> +		if (bat->report_id =3D=3D report_id)
> +			return bat;
> +	}
> +	return NULL;
> +}
> +
> +static bool hidinput_update_battery_charge_status(struct hid_battery
> *bat,
> =C2=A0						=C2=A0 unsigned int
> usage, int value)
> =C2=A0{
> =C2=A0	switch (usage) {
> =C2=A0	case HID_BAT_CHARGING:
> -		dev->battery_charge_status =3D value ?
> -					=C2=A0=C2=A0=C2=A0=C2=A0
> POWER_SUPPLY_STATUS_CHARGING :
> -					=C2=A0=C2=A0=C2=A0=C2=A0
> POWER_SUPPLY_STATUS_DISCHARGING;
> +		bat->charge_status =3D value ?
> +				=C2=A0=C2=A0=C2=A0=C2=A0 POWER_SUPPLY_STATUS_CHARGING :
> +				=C2=A0=C2=A0=C2=A0=C2=A0
> POWER_SUPPLY_STATUS_DISCHARGING;
> +		if (bat->dev->battery =3D=3D bat->ps)
> +			bat->dev->battery_charge_status =3D bat-
> >charge_status;
> =C2=A0		return true;
> =C2=A0	}
> =C2=A0
> =C2=A0	return false;
> =C2=A0}
> =C2=A0
> -static void hidinput_update_battery(struct hid_device *dev, unsigned
> int usage,
> -				=C2=A0=C2=A0=C2=A0 int value)
> +static void hidinput_update_battery(struct hid_device *dev, int
> report_id,
> +				=C2=A0=C2=A0=C2=A0 unsigned int usage, int value)
> =C2=A0{
> +	struct hid_battery *bat;
> =C2=A0	int capacity;
> =C2=A0
> -	if (!dev->battery)
> +	bat =3D hidinput_find_battery(dev, report_id);
> +	if (!bat)
> =C2=A0		return;
> =C2=A0
> -	if (hidinput_update_battery_charge_status(dev, usage,
> value)) {
> -		power_supply_changed(dev->battery);
> +	if (hidinput_update_battery_charge_status(bat, usage,
> value)) {
> +		power_supply_changed(bat->ps);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> =C2=A0	if ((usage & HID_USAGE_PAGE) =3D=3D HID_UP_DIGITIZER && value =3D=
=3D
> 0)
> =C2=A0		return;
> =C2=A0
> -	if (value < dev->battery_min || value > dev->battery_max)
> +	if (value < bat->min || value > bat->max)
> =C2=A0		return;
> =C2=A0
> =C2=A0	capacity =3D hidinput_scale_battery_capacity(dev, value);
> =C2=A0
> -	if (dev->battery_status !=3D HID_BATTERY_REPORTED ||
> -	=C2=A0=C2=A0=C2=A0 capacity !=3D dev->battery_capacity ||
> -	=C2=A0=C2=A0=C2=A0 ktime_after(ktime_get_coarse(), dev-
> >battery_ratelimit_time)) {
> -		dev->battery_capacity =3D capacity;
> -		dev->battery_status =3D HID_BATTERY_REPORTED;
> -		dev->battery_ratelimit_time =3D
> +	if (bat->status !=3D HID_BATTERY_REPORTED ||
> +	=C2=A0=C2=A0=C2=A0 capacity !=3D bat->capacity ||
> +	=C2=A0=C2=A0=C2=A0 ktime_after(ktime_get_coarse(), bat->ratelimit_time)=
) {
> +		bat->capacity =3D capacity;
> +		bat->status =3D HID_BATTERY_REPORTED;
> +		bat->ratelimit_time =3D
> =C2=A0			ktime_add_ms(ktime_get_coarse(), 30 * 1000);
> -		power_supply_changed(dev->battery);
> +
> +		if (dev->battery =3D=3D bat->ps) {
> +			dev->battery_capacity =3D bat->capacity;
> +			dev->battery_status =3D bat->status;
> +			dev->battery_ratelimit_time =3D bat-
> >ratelimit_time;
> +		}
> +
> +		power_supply_changed(bat->ps);
> =C2=A0	}
> =C2=A0}
> =C2=A0#else=C2=A0 /* !CONFIG_HID_BATTERY_STRENGTH */
> @@ -664,8 +735,8 @@ static void hidinput_cleanup_battery(struct
> hid_device *dev)
> =C2=A0{
> =C2=A0}
> =C2=A0
> -static void hidinput_update_battery(struct hid_device *dev, unsigned
> int usage,
> -				=C2=A0=C2=A0=C2=A0 int value)
> +static void hidinput_update_battery(struct hid_device *dev, int
> report_id,
> +				=C2=A0=C2=A0=C2=A0 unsigned int usage, int value)
> =C2=A0{
> =C2=A0}
> =C2=A0#endif	/* CONFIG_HID_BATTERY_STRENGTH */
> @@ -1533,7 +1604,7 @@ void hidinput_hid_event(struct hid_device *hid,
> struct hid_field *field, struct
> =C2=A0		return;
> =C2=A0
> =C2=A0	if (usage->type =3D=3D EV_PWR) {
> -		hidinput_update_battery(hid, usage->hid, value);
> +		hidinput_update_battery(hid, report->id, usage->hid,
> value);
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index a4ddb94e3ee5..a6e36835fb3c 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -634,6 +634,36 @@ enum hid_battery_status {
> =C2=A0	HID_BATTERY_REPORTED,		/* Device sent unsolicited
> battery strength report */
> =C2=A0};
> =C2=A0
> +/**
> + * struct hid_battery - represents a single battery power supply
> + * @list: list node for linking into hid_device's battery list
> + * @dev: pointer to the parent hid_device
> + * @ps: the power supply device
> + * @capacity: current battery capacity
> + * @min: minimum battery value
> + * @max: maximum battery value
> + * @report_type: type of report (HID_INPUT_REPORT,
> HID_FEATURE_REPORT)
> + * @report_id: report ID for this battery
> + * @charge_status: current charge status
> + * @status: battery status (unknown, queried, reported)
> + * @avoid_query: if true, don't query battery (wait for device
> reports)
> + * @ratelimit_time: time for rate limiting battery updates
> + */
> +struct hid_battery {
> +	struct list_head list;
> +	struct hid_device *dev;
> +	struct power_supply *ps;
> +	__s32 capacity;
> +	__s32 min;
> +	__s32 max;
> +	__s32 report_type;
> +	__s32 report_id;
> +	__s32 charge_status;
> +	enum hid_battery_status status;
> +	bool avoid_query;
> +	ktime_t ratelimit_time;
> +};
> +
> =C2=A0struct hid_driver;
> =C2=A0struct hid_ll_driver;
> =C2=A0
> @@ -670,8 +700,16 @@ struct hid_device {
> =C2=A0#ifdef CONFIG_HID_BATTERY_STRENGTH
> =C2=A0	/*
> =C2=A0	 * Power supply information for HID devices which report
> -	 * battery strength. power_supply was successfully
> registered if
> -	 * battery is non-NULL.
> +	 * battery strength. Each battery is tracked separately in
> the
> +	 * batteries list.
> +	 */
> +	struct list_head batteries;		/* List of
> hid_battery structures */
> +
> +	/*
> +	 * Legacy single battery support - kept for backwards
> compatibility.
> +	 * Points to the first battery in the list if any exists.
> +	 * power_supply was successfully registered if battery is
> non-NULL.
> +	 * DEPRECATED: New code should iterate through batteries
> list instead.
> =C2=A0	 */
> =C2=A0	struct power_supply *battery;
> =C2=A0	__s32 battery_capacity;

