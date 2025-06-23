Return-Path: <linux-pm+bounces-29408-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63CAAE5340
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 23:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D5E4A77B5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 21:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBA2222B7;
	Mon, 23 Jun 2025 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="RBuZ8fn3"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196519049B;
	Mon, 23 Jun 2025 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715493; cv=pass; b=XLNHxmy2edxpPTjrEV3QIB/XJa/k5wbl9uZMor+YCByvEXAEgm7X6KTvOnjUPWHoJF7Wv72B6NqOtmteYudy97GE5/ttBdUc7pBrV+g6trC0JvXRWDkAWJhZK9Z2CR2oY5iErIZRH7rKujmcLVnAM849DIhwz1PjIMTpAlVt4HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715493; c=relaxed/simple;
	bh=kUZ55aDwauHOi8YtXsztylF8oB2dhM0+AijzN5t7kiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXULbz3wVK2wMUdthaEJ2Krx7Aw+kJo2vjA/LQiHba/DEc1PLD2utYZ+4VpYDjwg4Bb3e0rmelJp9gXzXgF6M4QHMPyFH8MUN5hgyO/EkRmYZkPGdjCBfm8k6HwLEQsbn91HexbG3PuxrpEh9ELJQ8ubta+ZJj8leEzydtg9UMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=RBuZ8fn3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750715481; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XhA1f5X3vvs0h91NAHltQwTYl98YE2dKJwtll4jLSdW1LQdlNQsflFGiooMNCfYXYc/9SkCv9awxPOztsULBDnTS9Xfs1z07TidtDykdBgsAxQY8BEAHvmAH2kdATLEE5kRtCPejDxF+Mp6/0FUXOLd8FzZa0TIPWi8K6CiT3UU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750715481; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GFXliCzQION6XnWXAAKpg1SFLETXLk2/Ys00udwEZjY=; 
	b=XDE3mjnhDXHO+kZ8iECMHhkO1l3kgb1FsTq0pvfVk4TpdZBl6CHyx6tw4E9fcBK4pXprzgnnCxw/aSoKqlcblrzGCdyGYlO9Pdp2Oc/Q1SpU+OR9ykiQXai0P5HLFDjKai80iwGIxeu6efnSbARhuFNYMVrny7Gn+hROa+v0Jdo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750715481;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=GFXliCzQION6XnWXAAKpg1SFLETXLk2/Ys00udwEZjY=;
	b=RBuZ8fn3jwpchuu3RcWAH+Fh5g/fAYD6KnLpCsXzrprX2sLjPxvqWyAp9gV9NTb0
	aDz8q8NV+0tDf1cNG8kTyjucs+JFn4RJyUpFpsapxj6kf7tkKC4sOkqLCDGk+mzPDjv
	42kyBiDN1jM7ehAl2y8VvHHnYVrmyuulTvUNbsw4=
Received: by mx.zohomail.com with SMTPS id 1750715478062347.17253157085406;
	Mon, 23 Jun 2025 14:51:18 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 5E5E2180AAB; Mon, 23 Jun 2025 23:51:13 +0200 (CEST)
Date: Mon, 23 Jun 2025 23:51:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, Kyle Tso <kyletso@google.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] usb: typec: tcpm: Add support for Battery Cap
 response message
Message-ID: <g5w3ydcvtxwvcu5armmnt4v6y6wsymt7rothnvaesdql6kdscz@rhkxzx3y47iv>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-5-8d06130bffe6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ffhg6s33jsl77op"
Content-Disposition: inline
In-Reply-To: <20250507-batt_ops-v2-5-8d06130bffe6@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/250.696.82
X-ZohoMailClient: External


--4ffhg6s33jsl77op
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/5] usb: typec: tcpm: Add support for Battery Cap
 response message
MIME-Version: 1.0

Hi,

On Wed, May 07, 2025 at 06:00:26PM -0700, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add support for responding to Get_Battery_Cap (extended) request with a
> a Battery_Capabilities (extended) msg. The requester will request
> Battery Cap for a specific battery using an index in Get_Battery_Cap. In
> case of failure to identify battery, TCPM shall reply with an
> appropriate message indicating so.
>=20
> Support has been added only for fixed batteries and not hot swappable
> ones.
>=20
> As the Battery Cap Data Block size is 9 Bytes (lesser than
> MaxExtendedMsgChunkLen of 26B), only a single chunk is required to
> complete the AMS.
>=20
> Support for Battery_Capabilities message is required for sinks that
> contain battery as specified in USB PD Rev3.1 v1.8
> ("Applicability of Data Messages" section).
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Kyle Tso <kyletso@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 96 +++++++++++++++++++++++++++++++++++++=
++++--
>  include/linux/usb/pd.h        | 31 ++++++++++++++
>  2 files changed, 123 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 98df0c7ce00e43f6c95ab49237a414e1b4413369..4731126fbf19a50178be0cf88=
67b3fe08595724c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -228,7 +228,8 @@ enum pd_msg_request {
>  	PD_MSG_DATA_SINK_CAP,
>  	PD_MSG_DATA_SOURCE_CAP,
>  	PD_MSG_DATA_REV,
> -	PD_MSG_DATA_BATT_STATUS
> +	PD_MSG_DATA_BATT_STATUS,
> +	PD_MSG_EXT_BATT_CAP,
>  };
> =20
>  enum adev_actions {
> @@ -597,8 +598,8 @@ struct tcpm_port {
>  	u8 fixed_batt_cnt;
> =20
>  	/*
> -	 * Variable used to store battery_ref from the Get_Battery_Status
> -	 * request to process Battery_Status messages.
> +	 * Variable used to store battery_ref from the Get_Battery_Status &
> +	 * Get_Battery_Caps request to process Battery_Status messages.
>  	 */
>  	u8 batt_request;
>  #ifdef CONFIG_DEBUG_FS
> @@ -1414,6 +1415,81 @@ static int tcpm_pd_send_batt_status(struct tcpm_po=
rt *port)
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
> =20
> +static int tcpm_pd_send_batt_cap(struct tcpm_port *port)
> +{
> +	struct pd_message msg;
> +	struct power_supply *batt;
> +	struct batt_cap_ext_msg bcdb;
> +	u32 batt_id =3D port->batt_request;
> +	int ret;
> +	union power_supply_propval val;
> +	bool batt_present =3D false;
> +	u16 batt_design_cap =3D BATTERY_PROPERTY_UNKNOWN;
> +	u16 batt_charge_cap =3D BATTERY_PROPERTY_UNKNOWN;
> +	u8 data_obj_cnt;
> +	/*
> +	 * As per USB PD Rev3.1 v1.8, if battery reference is incorrect,
> +	 * then set the VID field to 0xffff.
> +	 * If VID field is set to 0xffff, always set the PID field to
> +	 * 0x0000.
> +	 */
> +	u16 vid =3D BATTERY_PROPERTY_UNKNOWN;
> +	u16 pid =3D 0x0;
> +
> +	memset(&msg, 0, sizeof(msg));
> +
> +	if (batt_id < MAX_NUM_FIXED_BATT && port->fixed_batt[batt_id]) {
> +		batt_present =3D true;

This should also handle POWER_SUPPLY_PROP_PRESENT.

Greetings,

-- Sebastian

> +		batt =3D port->fixed_batt[batt_id];
> +		ret =3D power_supply_get_property(batt,
> +						POWER_SUPPLY_PROP_USBIF_VENDOR_ID,
> +						&val);
> +		if (!ret)
> +			vid =3D val.intval;
> +
> +		if (vid !=3D BATTERY_PROPERTY_UNKNOWN) {
> +			ret =3D power_supply_get_property(batt,
> +							POWER_SUPPLY_PROP_USBIF_PRODUCT_ID,
> +							&val);
> +			if (!ret)
> +				pid =3D val.intval;
> +		}
> +
> +		ret =3D power_supply_get_property(batt,
> +						POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
> +						&val);
> +		if (!ret)
> +			batt_design_cap =3D (u16)UWH_TO_WH(val.intval * 10);
> +
> +		ret =3D power_supply_get_property(batt,
> +						POWER_SUPPLY_PROP_ENERGY_FULL,
> +						&val);
> +		if (!ret)
> +			batt_charge_cap =3D (u16)UWH_TO_WH(val.intval * 10);
> +	}
> +
> +	bcdb.vid =3D cpu_to_le16(vid);
> +	bcdb.pid =3D cpu_to_le16(pid);
> +	bcdb.batt_design_cap =3D cpu_to_le16(batt_design_cap);
> +	bcdb.batt_last_chg_cap =3D cpu_to_le16(batt_charge_cap);
> +	bcdb.batt_type =3D !batt_present ? BATT_CAP_BATT_TYPE_INVALID_REF : 0;
> +	memcpy(msg.ext_msg.data, &bcdb, sizeof(bcdb));
> +	msg.ext_msg.header =3D PD_EXT_HDR_LE(sizeof(bcdb),
> +					   0, /* Denotes if request chunk */
> +					   0, /* Chunk number */
> +					   1  /* Chunked */);
> +
> +	data_obj_cnt =3D count_chunked_data_objs(sizeof(bcdb));
> +	msg.header =3D cpu_to_le16(PD_HEADER(PD_EXT_BATT_CAP,
> +					   port->pwr_role,
> +					   port->data_role,
> +					   port->negotiated_rev,
> +					   port->message_id,
> +					   data_obj_cnt,
> +					   1 /* Denotes if ext header */));
> +	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> +}
> +
>  static void mod_tcpm_delayed_work(struct tcpm_port *port, unsigned int d=
elay_ms)
>  {
>  	if (delay_ms) {
> @@ -3711,8 +3787,12 @@ static void tcpm_pd_ext_msg_request(struct tcpm_po=
rt *port,
>  		tcpm_pd_handle_msg(port, PD_MSG_DATA_BATT_STATUS,
>  				   GETTING_BATTERY_STATUS);
>  		break;
> -	case PD_EXT_SOURCE_CAP_EXT:
>  	case PD_EXT_GET_BATT_CAP:
> +		port->batt_request =3D ext_msg->data[0];
> +		tcpm_pd_handle_msg(port, PD_MSG_EXT_BATT_CAP,
> +				   GETTING_BATTERY_CAPABILITIES);
> +		break;
> +	case PD_EXT_SOURCE_CAP_EXT:
>  	case PD_EXT_BATT_CAP:
>  	case PD_EXT_GET_MANUFACTURER_INFO:
>  	case PD_EXT_MANUFACTURER_INFO:
> @@ -3921,6 +4001,14 @@ static bool tcpm_send_queued_message(struct tcpm_p=
ort *port)
>  					 ret);
>  			tcpm_ams_finish(port);
>  			break;
> +		case PD_MSG_EXT_BATT_CAP:
> +			ret =3D tcpm_pd_send_batt_cap(port);
> +			if (ret)
> +				tcpm_log(port,
> +					 "Failed to send battery cap ret=3D%d",
> +					 ret);
> +			tcpm_ams_finish(port);
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 4efa7bfd9863915dfc8048da264116d9b05a447b..c89594177da57f4398b75c89c=
1991b4937614a70 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -204,6 +204,37 @@ struct pd_message {
>  	};
>  } __packed;
> =20
> +/*
> + * count_chunked_data_objs: Helper to calculate number of Data Objects o=
n a 4
> + *   byte boundary.
> + * @size: Size of data block for extended message. Should *not* include =
extended
> + *   header size.
> + */
> +static inline u8 count_chunked_data_objs(u32 size)
> +{
> +	size +=3D offsetof(struct pd_chunked_ext_message_data, data);
> +	return ((size / 4) + (size % 4 ? 1 : 0));
> +}
> +
> +/**
> + * batt_cap_ext_msg - Battery capability extended PD message
> + * @vid: Battery Vendor ID (assigned by USB-IF)
> + * @pid: Battery Product ID (assigned by battery or device vendor)
> + * @batt_design_cap: Battery design capacity in 0.1Wh
> + * @batt_last_chg_cap: Battery last full charge capacity in 0.1Wh
> + * @batt_type: Battery Type. bit0 when set indicates invalid battery ref=
erence.
> + *             Rest of the bits are reserved.
> + */
> +struct batt_cap_ext_msg {
> +	__le16 vid;
> +	__le16 pid;
> +	__le16 batt_design_cap;
> +	__le16 batt_last_chg_cap;
> +	u8 batt_type;
> +} __packed;
> +
> +#define BATT_CAP_BATT_TYPE_INVALID_REF			BIT(0)
> +
>  /* PDO: Power Data Object */
>  #define PDO_MAX_OBJECTS		7
> =20
>=20
> --=20
> 2.49.0.987.g0cc8ee98dc-goog
>=20
>=20

--4ffhg6s33jsl77op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhZzFAACgkQ2O7X88g7
+pp/ohAAmhwozxPOZbt+0M9zZ6EZHKbxIA4dyREIo4bxCyozSGJq/qVY6p+kUK9K
c8HtERDjM0VixLFk/eNC4oMj2AeczzCSR3Y5BCoqJstXqLqznquXnKjER6U1i8uY
iaFHQEPVjZCtD96B/NTkeJ0Z7A6+A5EXLNpRjUc+sOw02sXVp7z1TWPDPkB6gZri
MVHzZlKJwmua5cvBFBPYVd/UevbZleQ2HY3XzyPjRlhUurhCkZt7ZyLaWJqDS7ek
tsbg8WNiai1QZ/b7oDI8k7ICJsxjaPWPCBrmYrr+97ibHJ8WMWN/Mo6aAb/U8MWs
Agfrd1k6tEQAPeftdNpwQp5qktcrbcVrOwEgToHIdLVc+qC8iezju9S0ui41L8gy
Bl3ljdW/p4YrEnxQkHnyU5e02v0+zZohWA/fnLx6w33au6o0l4m9YgjCYlGSdSy0
/XaPyfL0lVsCeiscUITSXETSzupCalzaJX3WbNsTLAnVfnC1ZatDIdXPFy4Nm5I8
QFJl0D2p/0Jedzd74SBRZY2DnzfN+npRBCIgh2t0NFWhEUXtx04Yc52SRfE4pMC9
2SqZQpWNN20AgWtW+bd/AMvUaNf0EkkssdyVJkdxbENqtpW7dy8vEIEUeUpGloOb
PLBXHO4enu/j9tQadA8mr946DnYF3PZTSwqPgcpALXvOU6WSyYc=
=27wT
-----END PGP SIGNATURE-----

--4ffhg6s33jsl77op--

