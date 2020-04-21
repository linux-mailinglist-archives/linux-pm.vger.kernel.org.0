Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654F31B21EE
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgDUIou (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Apr 2020 04:44:50 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.5]:53023 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUIos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2020 04:44:48 -0400
Received: from [100.112.195.143] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-a.eu-west-1.aws.symcld.net id 6A/2A-46089-972BE9E5; Tue, 21 Apr 2020 08:44:41 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSbUxTVxjm9N72XhjdLq2Ed91gpkS3KK1Upru
  SbDHZnyaLAxZHDFNGgQtt1q/0lhRYNnDQJUNABnFESgEROhzyLUwmw+BAviY4TERMBkyaTGBE
  HMTp5GP39la3/TjJ877P8z7nOScvicnuShQkk21nbGadUSkJwvX7ZGZVdmdNcnRX8W660nsLp
  wvOt0noouZenL71Q7WEXisZRHS9x4nRlffWicOE1pX/C66tGU3QXnVfJLRrnRHxeJLYYE61ZK
  eI9bfHlwjrQ0v2+OLveD7ynChCQSSiGjGY6e8SFaFArriOQ3/+awLRheBpyRMJX+DUCAYtY7c
  RX8ioWhGU9v6KC8Ucgo62TZyfl1A0VIzMS3i8g8qAuuot3wRGbSJodfUinpBTB8D5YAYrQiQn
  Ogizl9IE/X5oHm7yzeLULuhbaxXzWEqdgNPlJ31YRunhqwttvqyBVCwMPq7HhNzhsH6y2YcxK
  gzuemt9GqAoaOibxAQcCosLW2JBz8DoF3eQ0I+CG9NexMcBKhIqthOFdjhM1Z7yS47A/KMNv8
  0eqPt6yI9paDjlxAVshDNDXf5rd0Pfo0F//1XYGPoL478BqAocvqzZ8r8lDVbdN4gyFF31n9g
  CjoK6K39KBLwXPOeWsSrfV4TA6FkvXofw7xCdajNk6u0mncGo0kRHqzSa/SrNoRjuHFLrclU6
  NZOlcjCsXaVR6xysms0xpRnT1WbG3om41Uq3DgxfRp6WB+pr6GVSpAyVUk01ybIXUy3pOXodq
  //YlmVk2GvoDZKkulqabyIFbraYGSVI+zs4XYiNyWSyMwxGblmfSYEMVu6QOts5WspadSbWkC
  lQY0hFli266zGZz0MRJp3nPShepM8yP7d4tvJTKFwhl6KAgABZsJWxmQz2//NLKIxESrn0nRb
  OJdhgtj+/aYkLIeJCWA64+BB23b+UIl+kOXxwWxYTN3nxrYH1morLKRPxiZr7ca/ve//oMWe7
  tWlK21ua2/rKas/3Y40zs8rHKS91n07baXgSKXMV35so3L4+uJDc61aEx57pXhxZjn9zM+l45
  EJoTGNZYfWlI+1z3s8/Ws0jyvOSzv39x3TkJ2w5Zt787XwcsdJeNbl8//i2yfNhZULBqsey2h
  0iHZeXFsyJ36vUln9wxfo0diJxyf1j4MZPhIL59k4WmRuzQkTYm4wx0VPV7RJDzl5bT1MB7ox
  Iu5niaFhxrdV9+kIQ21PS1pBeXEpXvT2bYUvH134+5nAOn82iH8ozm8eORjkKC7bezQv7rGM6
  IS9zIJG4+k2yEmf1Os0ezMbq/gEcrJUSbQQAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-24.tower-272.messagelabs.com!1587458680!2224335!1
X-Originating-IP: [104.47.18.110]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6195 invoked from network); 21 Apr 2020 08:44:40 -0000
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO EUR05-AM6-obe.outbound.protection.outlook.com) (104.47.18.110)
  by server-24.tower-272.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 21 Apr 2020 08:44:40 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POl0ISQWJxsx+CjaLcmzMH8mGe+O1JlQ/1KkUM5xQmMf6+Nv6UCXD7LlVnz4oRUK62octG6VDLm8vIxzlOesOFMQt1hjMPWHAw4eki9xT8Nv+kSxIWnvOXppLjUIkZW5lU/Kyp2fzn3tyo3zX10boj9+pPrHcV47GuUrBOsKRp0mBYLl/Ec29g6HN251SLdGenAgbI2EU4R3ortCgMSRlVI7xsTbBD9SRoY+QAkmO8ESiogmP2SHFd3ywDIOzK4dkjbdT21aH3GiTYDfEx7SENw6/w3i1BaSVWHEgQmqVIuIxCvYUQTHOzbWjKngQHWO0GRPp17EX6B12JS3CUDtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ0fRNGsEm1D2XM/MDa1Aexe7+EJ1ZUzG7xO4g/ZQXA=;
 b=KxK+g4xf8vcEQvWZWi5p8xcdLxJpIB2lyf6+7jQ0QucPCn+zzoaJTKI0BB3Ump/vbFpaP0e0di8ZNblKOCVuyjAWgqQNwAMNpcuaBG57PVXUf3ZQ/goMS8eGCfez2yTAOkZdJFHMV5zZlWI6/bxwsuB+XJp+4BNyCyZj6RFW3cVj9WqUpDRpYBaPWLC1V6OnWHwL8SNEArf40RzyE2nXzoU12fVvdQorzLux90yKyPj59bIw24wCB+kO4+x7wnrc7vFsbeLhfguDx5ADuTzVG8+loscK1npa7+lYcQmYXRD+oJHyKMUJZMARVtlZqPMuMackKSh2GbtZxitNio7hZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ0fRNGsEm1D2XM/MDa1Aexe7+EJ1ZUzG7xO4g/ZQXA=;
 b=vmeo7fs6I0ED037yqnLam7VpuYwiifv1bAhz7RmiHUTFWWAmvnbYJx6b1zbSyzsNbStVtNu4zXNVqZtQaPVVEZdiHa/mj613gPzZmnHLyPmxB/ifskrKrrb43PR1CcTNIVypysG+efKhM5fkFfN98OXIQeMkSG3x+LgZnBxlRig=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52::13)
 by AM6PR10MB2536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 08:44:38 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2539:e4b7:445f:13b6]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2539:e4b7:445f:13b6%5]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 08:44:38 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mathew King <mathewk@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v0 2/2] typec: Add Type-C charger
Thread-Topic: [PATCH v0 2/2] typec: Add Type-C charger
Thread-Index: AQHWFzIA8tnYoqPII0+yygriEfGPK6iDQGzw
Date:   Tue, 21 Apr 2020 08:44:38 +0000
Message-ID: <AM6PR10MB2263B60191A7240E3F6E0C7A80D50@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200420163657.60650-1-mathewk@chromium.org>
 <20200420163657.60650-3-mathewk@chromium.org>
In-Reply-To: <20200420163657.60650-3-mathewk@chromium.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.196.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90afa2a-c23c-4340-48fc-08d7e5d03a2c
x-ms-traffictypediagnostic: AM6PR10MB2536:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM6PR10MB253606C04A1FE99205B4F96EA7D50@AM6PR10MB2536.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(39850400004)(366004)(376002)(76116006)(66446008)(186003)(8676002)(66556008)(66946007)(4326008)(30864003)(9686003)(86362001)(52536014)(6506007)(53546011)(71200400001)(26005)(55236004)(316002)(110136005)(7696005)(33656002)(478600001)(66476007)(81156014)(64756008)(54906003)(2906002)(8936002)(55016002)(5660300002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CqJ0cyeFdi/z4JVhuqpUjnJNshn3vR0OJowBExvu/earj9f7TNnPia4FaFhxmO0ruOK1eFwLje9dfHo8nFBFoaBUmzNYQ6Rrct0MYNylLVqYk5lG4F3hHAJVSt9zE9eu0YNw/JbxeuNYIju9j7Oco4mP5W1f9LdVTErdQa3GvgtAHZhw4XRentH9HM5C53CKIdqQ5fIZCDhXOM16rRqUIKG8eKPPF0Wd7fWX4FgATw/wVDW7Ol8fgq9VfQG/heRDOgtxsCc/go7SqS6vkHuSZoTfXqsvXWoQwYVHw0BCJmW+cDu++IulnaSYTM8FEJVl0yNclY95euyyPWWBgPyYb/nDGV2rxngHvAJiu/NAkjsqOg9yEkoPk2hvN7JONT68vMuA2QFudBauBZL7e0j7cD0ix6y+DuZjRXY/s2On5X2JD8dFg/u8U8wPf8qhsr+C
x-ms-exchange-antispam-messagedata: NGqB56XOrvMHvUu3UuT8uIke+ygWmONN3eagH16ConUXGVZF7cZU4SKHPFXhVFZ6esQuvjxwqz5jd+AHV81HofRKJIA9dQrR4hnDZc5yQyrA6i+D4JKs+bmam1XjL9NmH1i6lA/jM94QsT6A58BJRA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90afa2a-c23c-4340-48fc-08d7e5d03a2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 08:44:38.6794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZX1YetU1F4YUlesSkvkgZ2HNDFY1GK8QHfv/3+WTRFUMv19vmFF7LKbJiSTjT0wvkjqV3jVqlaxF2X8Ogcr9TjUrFt2ysOSZwrO2Xg5G2II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2536
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20 April 2020 17:37, Mathew King wrote:

> Add an option to expose USB Type-C ports that can charge system
> batteries as a power_supply class. This implementation only exposes
> three properties of the power supply.
>=20
> POWER_SUPPLY_PROP_ONLINE - Set to true if the Type-C port is configured
>                            as a sink and is connected to a partner
> POWER_SUPPLY_PROP_STATUS - Set to CHARGING if a partner is connected and
>                            the port is a sink and set to NOT_CHARGING
>                            otherwise
> POWER_SUPPLY_PROP_USB_TYPE - When a partner is conneced set to TYPE_C,
>                              TYPE_PD, or TYPE_PD_DRP depending on the
>                              partner capibilities and set to
>                              TYPE_UNKNOWN otherwise
>=20
> This implementation can be expanded as the typec class is expaneded. In
> particular the STATUS property should show more than CHARGING and
> NOT_CHARGING. Also properties like VOLTAGE and CURRENT can be added
> when
> the typec class supports getting PDOs.

Hmm, this functionally looks almost exactly like code already available in =
TCPM,
except a much smaller subset. This looks like it would duplicate that work =
so as
it stands doesn't feel sensible to me. It may be that the work in TCPM need=
s
refactoring, but I don't believe the two should coexist.

>=20
> Signed-off-by: Mathew King <mathewk@chromium.org>
> ---
>  drivers/usb/typec/Kconfig   |  11 ++
>  drivers/usb/typec/Makefile  |   1 +
>  drivers/usb/typec/charger.c | 204
> ++++++++++++++++++++++++++++++++++++
>  drivers/usb/typec/charger.h |  33 ++++++
>  drivers/usb/typec/class.c   |  48 +++++++--
>  drivers/usb/typec/class.h   |   2 +
>  6 files changed, 290 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/usb/typec/charger.c
>  create mode 100644 drivers/usb/typec/charger.h
>=20
> diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
> index b4f2aac7ae8a..1040c990cb7e 100644
> --- a/drivers/usb/typec/Kconfig
> +++ b/drivers/usb/typec/Kconfig
> @@ -46,6 +46,17 @@ menuconfig TYPEC
>=20
>  if TYPEC
>=20
> +config TYPEC_CHARGER
> +	bool "Type-C Power Supply support"
> +	depends on POWER_SUPPLY
> +	help
> +	  Say Y here to enable Type-C charging ports to be exposed as a power
> +	  supply class.
> +
> +	  If you choose this option Type-C charger support will be built into
> +	  the typec driver. This will expose all Type-C ports as a power_supply
> +	  class.
> +
>  source "drivers/usb/typec/tcpm/Kconfig"
>=20
>  source "drivers/usb/typec/ucsi/Kconfig"
> diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
> index 7753a5c3cd46..6fc5424761a1 100644
> --- a/drivers/usb/typec/Makefile
> +++ b/drivers/usb/typec/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TYPEC)		+=3D typec.o
>  typec-y				:=3D class.o mux.o bus.o
> +typec-$(CONFIG_TYPEC_CHARGER)	+=3D charger.o
>  obj-$(CONFIG_TYPEC)		+=3D altmodes/
>  obj-$(CONFIG_TYPEC_TCPM)	+=3D tcpm/
>  obj-$(CONFIG_TYPEC_UCSI)	+=3D ucsi/
> diff --git a/drivers/usb/typec/charger.c b/drivers/usb/typec/charger.c
> new file mode 100644
> index 000000000000..07c3cd065be8
> --- /dev/null
> +++ b/drivers/usb/typec/charger.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB Type-C Charger Class
> + *
> + * Copyright (C) 2020, Google LLC
> + * Author: Mathew King <mathewk@google.com>
> + */
> +
> +#include <linux/slab.h>
> +
> +#include "charger.h"
> +#include "class.h"
> +
> +static enum power_supply_property typec_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_USB_TYPE
> +};
> +
> +static enum power_supply_usb_type typec_charger_usb_types[] =3D {
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +	POWER_SUPPLY_USB_TYPE_C,
> +	POWER_SUPPLY_USB_TYPE_PD,
> +	POWER_SUPPLY_USB_TYPE_PD_DRP,
> +};
> +
> +static int typec_charger_get_prop(struct power_supply *psy,
> +				  enum power_supply_property psp,
> +				  union power_supply_propval *val)
> +{
> +	struct typec_charger *charger =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D charger->psy_online;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D charger->psy_status;
> +		break;
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		val->intval =3D charger->psy_usb_type;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int typec_charger_set_prop(struct power_supply *psy,
> +				  enum power_supply_property psp,
> +				  const union power_supply_propval *val)
> +{
> +	return -EINVAL;
> +}
> +
> +static int typec_charger_is_writeable(struct power_supply *psy,
> +				      enum power_supply_property psp)
> +{
> +	return 0;
> +}
> +
> +/**
> + * typec_charger_changed - Notify of a Type-C charger change
> + * @charger: Type-C charger that changed
> + *
> + * Notifies the Type-C charger that one or more of its attributes may ha=
ve
> + * changed.
> + */
> +void typec_charger_changed(struct typec_charger *charger)
> +{
> +	int last_psy_status, last_psy_usb_type, last_psy_online;
> +
> +	last_psy_online =3D charger->psy_online;
> +	last_psy_status =3D charger->psy_status;
> +	last_psy_usb_type =3D charger->psy_usb_type;
> +
> +	if (!charger->partner) {
> +		charger->psy_usb_type =3D
> POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		charger->psy_online =3D 0;
> +		charger->psy_status =3D
> POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		goto out_notify;
> +	}
> +
> +	if (charger->port->pwr_role =3D=3D TYPEC_SOURCE) {
> +		charger->psy_online =3D 0;
> +		charger->psy_status =3D
> POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		if (charger->partner->usb_pd)
> +			charger->psy_usb_type =3D
> POWER_SUPPLY_USB_TYPE_PD_DRP;
> +		else
> +			charger->psy_usb_type =3D
> POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +
> +		goto out_notify;
> +	}
> +
> +	charger->psy_online =3D 1;
> +	charger->psy_status =3D POWER_SUPPLY_STATUS_CHARGING;
> +
> +	if (charger->partner->usb_pd)
> +		charger->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_PD;
> +	else
> +		charger->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_C;
> +
> +out_notify:
> +	if (last_psy_usb_type !=3D charger->psy_usb_type ||
> +	    last_psy_status !=3D charger->psy_status ||
> +	    last_psy_online !=3D charger->psy_online)
> +		power_supply_changed(charger->psy);
> +}
> +EXPORT_SYMBOL_GPL(typec_charger_changed);
> +
> +/**
> + * typec_register_charger - Register a USB Type-C Charger
> + * @port: Type-C port to register as a charger
> + *
> + * Registers a Type-C port as a charger.
> + *
> + * Returns handle to the charger on success or ERR_PTR on failure.
> + */
> +struct typec_charger *typec_register_charger(struct typec_port *port)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct typec_charger *charger;
> +	struct power_supply *psy;
> +
> +	charger =3D kzalloc(sizeof(struct typec_charger), GFP_KERNEL);
> +	if (!port)
> +		return ERR_PTR(-ENOMEM);
> +
> +	charger->port =3D port;
> +	sprintf(charger->name, TYPEC_CHARGER_DIR_NAME, port->id);
> +	charger->psy_usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +	charger->psy_online =3D 0;
> +	charger->psy_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	charger->psy_desc.name =3D charger->name;
> +	charger->psy_desc.type =3D POWER_SUPPLY_TYPE_USB;
> +	charger->psy_desc.get_property =3D typec_charger_get_prop;
> +	charger->psy_desc.set_property =3D typec_charger_set_prop;
> +	charger->psy_desc.property_is_writeable =3D
> +		typec_charger_is_writeable;
> +	charger->psy_desc.properties =3D typec_charger_props;
> +	charger->psy_desc.num_properties =3D
> +				ARRAY_SIZE(typec_charger_props);
> +	charger->psy_desc.usb_types =3D typec_charger_usb_types;
> +	charger->psy_desc.num_usb_types =3D
> +			ARRAY_SIZE(typec_charger_usb_types);
> +	psy_cfg.drv_data =3D charger;
> +
> +	psy =3D devm_power_supply_register_no_ws(&port->dev, &charger-
> >psy_desc,
> +					       &psy_cfg);
> +	if (IS_ERR(psy)) {
> +		dev_err(&port->dev, "Failed to register Type-C power
> supply\n");
> +		return ERR_CAST(psy);
> +	}
> +	charger->psy =3D psy;
> +
> +	return charger;
> +}
> +EXPORT_SYMBOL_GPL(typec_register_charger);
> +
> +/**
> + * typec_unregister_charger - Unregister a USB Type-C Charger
> + * @charger: The charger to unregister
> + *
> + * Unregisters a charger created with typec_register_charger().
> + */
> +void typec_unregister_charger(struct typec_charger *charger)
> +{
> +	if (!IS_ERR_OR_NULL(charger))
> +		kfree(charger);
> +}
> +EXPORT_SYMBOL_GPL(typec_unregister_charger);
> +
> +/**
> + * typec_charger_register_partner - Register a partner with a USB Type-C
> Charger
> + * @charger: The charger to add the partner too
> + * @partner: The partner to add
> + *
> + * Add a partner to a Type-C charger to indicate that the partner is con=
nected
> + * and may be charging.
> + */
> +void typec_charger_register_partner(struct typec_charger *charger,
> +				    struct typec_partner *partner)
> +{
> +	charger->partner =3D partner;
> +	typec_charger_changed(charger);
> +}
> +EXPORT_SYMBOL_GPL(typec_charger_register_partner);
> +
> +/**
> + * typec_charger_unregister_partner - Unregister a USB Type-C Charger pa=
rtner
> + * @charger: The charger to remove the partner from
> + *
> + * Remove partner added with typec_charger_register_partner().
> + */
> +void typec_charger_unregister_partner(struct typec_charger *charger)
> +{
> +	if (!IS_ERR_OR_NULL(charger))
> +		charger->partner =3D NULL;
> +
> +	typec_charger_changed(charger);
> +}
> +EXPORT_SYMBOL_GPL(typec_charger_unregister_partner);
> diff --git a/drivers/usb/typec/charger.h b/drivers/usb/typec/charger.h
> new file mode 100644
> index 000000000000..32cdaa7c1a83
> --- /dev/null
> +++ b/drivers/usb/typec/charger.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __USB_TYPEC_CHARGER_H__
> +#define __USB_TYPEC_CHARGER_H__
> +
> +#include <linux/power_supply.h>
> +#include <linux/usb/typec.h>
> +
> +#include "class.h"
> +
> +#define TYPEC_CHARGER_DIR_NAME
> 	"TYPEC_CHARGER%d"
> +#define TYPEC_CHARGER_DIR_NAME_LENGTH
> 	sizeof(TYPEC_CHARGER_DIR_NAME)
> +
> +struct typec_charger {
> +	struct typec_port *port;
> +	struct typec_partner *partner;
> +	char name[TYPEC_CHARGER_DIR_NAME_LENGTH];
> +	struct power_supply *psy;
> +	struct power_supply_desc psy_desc;
> +	int psy_usb_type;
> +	int psy_online;
> +	int psy_status;
> +};
> +
> +struct typec_charger *typec_register_charger(struct typec_port *port);
> +void typec_unregister_charger(struct typec_charger *charger);
> +
> +void typec_charger_register_partner(struct typec_charger *charger,
> +				    struct typec_partner *partner);
> +void typec_charger_unregister_partner(struct typec_charger *charger);
> +void typec_charger_changed(struct typec_charger *charger);
> +
> +#endif /* __USB_TYPEC_CHARGER_H__ */
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 9a1fdce137b9..1542d3af342c 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -13,6 +13,7 @@
>  #include <linux/slab.h>
>=20
>  #include "bus.h"
> +#include "charger.h"
>  #include "class.h"
>=20
>  static DEFINE_IDA(typec_index_ida);
> @@ -489,6 +490,12 @@ static void typec_partner_release(struct device *dev=
)
>  {
>  	struct typec_partner *partner =3D to_typec_partner(dev);
>=20
> +	if (IS_ENABLED(CONFIG_TYPEC_CHARGER)) {
> +		struct typec_port *port =3D to_typec_port(dev->parent);
> +
> +		typec_charger_unregister_partner(port->charger);
> +	}
> +
>  	ida_destroy(&partner->mode_ids);
>  	kfree(partner);
>  }
> @@ -580,6 +587,10 @@ struct typec_partner *typec_register_partner(struct
> typec_port *port,
>  		return ERR_PTR(ret);
>  	}
>=20
> +	if (IS_ENABLED(CONFIG_TYPEC_CHARGER) && port->charger) {
> +		typec_charger_register_partner(port->charger, partner);
> +	}
> +
>  	return partner;
>  }
>  EXPORT_SYMBOL_GPL(typec_register_partner);
> @@ -1283,6 +1294,9 @@ static void typec_release(struct device *dev)
>  {
>  	struct typec_port *port =3D to_typec_port(dev);
>=20
> +	if (IS_ENABLED(CONFIG_TYPEC_CHARGER))
> +		typec_unregister_charger(port->charger);
> +
>  	ida_simple_remove(&typec_index_ida, port->id);
>  	ida_destroy(&port->mode_ids);
>  	typec_switch_put(port->sw);
> @@ -1564,7 +1578,8 @@ struct typec_port *typec_register_port(struct devic=
e
> *parent,
>  	id =3D ida_simple_get(&typec_index_ida, 0, 0, GFP_KERNEL);
>  	if (id < 0) {
>  		kfree(port);
> -		return ERR_PTR(id);
> +		ret =3D id;
> +		goto err_return;
>  	}
>=20
>  	switch (cap->type) {
> @@ -1617,32 +1632,47 @@ struct typec_port *typec_register_port(struct dev=
ice
> *parent,
>=20
>  	port->cap =3D kmemdup(cap, sizeof(*cap), GFP_KERNEL);
>  	if (!port->cap) {
> -		put_device(&port->dev);
> -		return ERR_PTR(-ENOMEM);
> +		ret =3D -ENOMEM;
> +		goto err_put_device;
>  	}
>=20
>  	port->sw =3D typec_switch_get(&port->dev);
>  	if (IS_ERR(port->sw)) {
>  		ret =3D PTR_ERR(port->sw);
> -		put_device(&port->dev);
> -		return ERR_PTR(ret);
> +		goto err_put_device;
>  	}
>=20
>  	port->mux =3D typec_mux_get(&port->dev, NULL);
>  	if (IS_ERR(port->mux)) {
>  		ret =3D PTR_ERR(port->mux);
> -		put_device(&port->dev);
> -		return ERR_PTR(ret);
> +		goto err_put_device;
>  	}
>=20
>  	ret =3D device_add(&port->dev);
>  	if (ret) {
>  		dev_err(parent, "failed to register port (%d)\n", ret);
> -		put_device(&port->dev);
> -		return ERR_PTR(ret);
> +		goto err_put_device;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_TYPEC_CHARGER)) {
> +		port->charger =3D typec_register_charger(port);
> +
> +		if (IS_ERR(port->charger)) {
> +			ret =3D PTR_ERR(port->charger);
> +			goto err_device_del;
> +		}
>  	}
>=20
>  	return port;
> +
> +err_device_del:
> +	device_del(&port->dev);
> +
> +err_put_device:
> +	put_device(&port->dev);
> +
> +err_return:
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(typec_register_port);
>=20
> diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
> index ec933dfe1323..0ff0a590d316 100644
> --- a/drivers/usb/typec/class.h
> +++ b/drivers/usb/typec/class.h
> @@ -41,6 +41,8 @@ struct typec_port {
>  	struct typec_switch		*sw;
>  	struct typec_mux		*mux;
>=20
> +	struct typec_charger		*charger;
> +
>  	const struct typec_capability	*cap;
>  	const struct typec_operations   *ops;
>  };
> --
> 2.26.1.301.g55bc3eb7cb9-goog

