Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F2010CA9F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1OsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 09:48:15 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:56671 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfK1OsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 09:48:14 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Nicolas.Ferre@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="Nicolas.Ferre@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Nicolas.Ferre@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Nicolas.Ferre@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: CEJJy3g1ABzUI4/pZSk2hVZAh2UV9Gxl/M65jf27AOhfbkvDwKm0CTK0KPYEMwUxEo2rO8SutO
 CVUjZLFrQBvly80tszjY6LhAXmjTsDkKbKzVqLxGcZSl9/KnJzVU3ol32VKaU3rNT9PVYx0Dbn
 6DvrRaDY+eb3dbulRqcLNJTXGKTucehTS5Pc0SC5wTXsY65EURgvhrIj387H1620woLDMT7cX/
 ZRyVwr5T9OmoF2oxeQiwRWonnJjEXAQydvvfF57TOMjf498G6frqiEzmP5fxck/6IGF9cPitXu
 0T4=
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="60042778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2019 07:48:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 28 Nov 2019 07:48:13 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 28 Nov 2019 07:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XntT2Dm2KtwAfwudNggFz79Od+7OFEgBypg9JhdWT1kh0o4om2gVvealzfar+14XCzNx38JqZTPapJzIGm2dZccvgOflezkIgcNNce4FLgAKfsrxf6ijI73QaYrMTeVDuYwB3FRZWYTbCzAbKc2aLQ0HI6STt14NDu6otaibywBTFixL7C1uGqSGYu+N8Zp1Nt/wbk0rO3UcOX5SWoqeHT4VU6/lvW+Q582TS968b9ajFKvnVyY3O+lSMwdrsHFohMxiTppCIUOSGTroTd+mrPRAKoPLUxD14J6dYggwUKFBodvniITYHf7w+ChWfOVCWDCtWXd6+2CeGxw7BuUSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N3upTzDG+/yZzsPIpRP9+W9EtyHAjyZgDzcF61ALZM=;
 b=ItQLerJ3Rk3JKE5SoAQIAv/PrpoDBcBlzhvpCDpHgItN2HNjlwVEY1AXuUP0zm5hJs5AfqGSYDDjBVMPBNHdATk2ddT5KwCAAqUWmhfZlc51X/bmqDohdZI77ZJU41Mm2HrOQyi4vqDFi8DqXozEvPzbdPd1G/rMdj+VtNSrMuQuXt5JHomRQM9e5SgLIQLaHi692c1y0QKdOa/2PfKx8CQi2ow2WQNnyP5YpH1dIS91S4lbg2J+rdvxA5nJuIjMBJCWsWM/72sOp4OJXu910lgchMu05QX9qZWxejR2LLwtqpethQzZa8cTJafguExwb3aGPcnOonmgB077kc2sWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N3upTzDG+/yZzsPIpRP9+W9EtyHAjyZgDzcF61ALZM=;
 b=ZEf8gbivdekUeyh7bv/9uHnOwLbzLY2eN7bzi51m+eCsOxm4BzDdFuAuNh2mif+bSrStAbEdgXfRfd+gntFc1NpRBZ6x+UbgXGewpj0ICdPU3Qv5o2RkWE3B9EhsoVKTqn7pcqSBmuHfJ17xE0CJ4zc6sSH9pSXYyklgGunI3J8=
Received: from SN6PR11MB2830.namprd11.prod.outlook.com (52.135.93.21) by
 SN6PR11MB2736.namprd11.prod.outlook.com (52.135.92.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Thu, 28 Nov 2019 14:48:10 +0000
Received: from SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::74c7:7e0e:5565:a0e5]) by SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::74c7:7e0e:5565:a0e5%7]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 14:48:10 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <kamel.bouhara@bootlin.com>, <sre@kernel.org>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Thread-Topic: [PATCH] power: reset: at91-reset: add sysfs interface to the
 power on reason
Thread-Index: AQHVpfraa7jHkmKRFU6ARhaCvd32Mw==
Date:   Thu, 28 Nov 2019 14:48:10 +0000
Message-ID: <5ef83b2d-99f2-4953-4cd0-83af528b9a61@microchip.com>
References: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
In-Reply-To: <20191017124058.19300-1-kamel.bouhara@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::20) To SN6PR11MB2830.namprd11.prod.outlook.com
 (2603:10b6:805:5b::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [213.41.198.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c85fcf6-4fb4-4f79-68b2-08d77411fcc1
x-ms-traffictypediagnostic: SN6PR11MB2736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2736FDC0E9B544627A4C5E99E0470@SN6PR11MB2736.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(52314003)(199004)(189003)(229853002)(31696002)(2501003)(86362001)(8676002)(81156014)(66066001)(6486002)(6436002)(36756003)(6246003)(81166006)(66946007)(25786009)(6512007)(8936002)(478600001)(110136005)(64756008)(66556008)(66476007)(66446008)(14454004)(54906003)(99286004)(102836004)(52116002)(2616005)(6116002)(3846002)(446003)(11346002)(305945005)(31686004)(316002)(7736002)(186003)(53546011)(26005)(386003)(6506007)(5660300002)(71200400001)(71190400001)(256004)(14444005)(4326008)(2906002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2736;H:SN6PR11MB2830.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r15j1EBm16KQqBP8T3KaCBxkQg0cR7UscbM57PxaAjutgG9y0PV2uXna+CEOP09vsBmgYrooXXMspvIH1z7PhXKBmTIKlzM7CsTO6mUQHmqF7bIm3oeesuW1dlgvOMKds95cqY3SXWQcRQPB12g4h5KMgqx3CHGjGfwBPCHJhZZ7jQAoDR9cIqnQ+u3QPb41rlXd8Oe+jryrZ82r46Aah6GAKwJlDCUSiKrXuWbhKN3GmYShywIgnTnJKCL4zva1MrNY49w8cNR6dAX8nF3aI29S0DoD1KHMyMB5jfSjnCBWD47MMNKmv25DlJmjaCN/qAsCYDDSaAfiJcwRbVnPfC43S+BUakfRruN30g03LoPQaNkTxF4VTMzEMOBekK6UXB30XnprJ9CUAXef/5iJo6og+a1wmQTubZr8FvXOUHZlpXHZ1emeFvmZQr82/xjz
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <E7400572D2F1604B903704146D5D0631@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c85fcf6-4fb4-4f79-68b2-08d77411fcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 14:48:10.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qD0e0FRQDUJMYm232/UQPCCmYFTjgwSqMuIfpQAFaymH3LDIO1Kk6WVsDZDmK0rlC/CCkGNWSww9dYS/DFeTLFpYJgc4/gdxalXIpnfNU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2736
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/10/2019 at 14:40, Kamel Bouhara wrote:
> This patch export the power on reason through the sysfs interface and
> introduce some generic reset sources.
> Update the ABI documentation to list current power on sources.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>

I don't know the status of this.
Anyway, here is my:

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Kamel. Best regards,
   Nicolas

> ---
>   .../sysfs-devices-platform-power-on-reason    | 14 ++++++
>   drivers/power/reset/at91-reset.c              | 44 +++++++++++++------
>   include/linux/power/power_on_reason.h         | 19 ++++++++
>   3 files changed, 64 insertions(+), 13 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-pow=
er-on-reason
>   create mode 100644 include/linux/power/power_on_reason.h
>=20
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-power-on-re=
ason b/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
> new file mode 100644
> index 000000000000..83daeb9b1aa2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-power-on-reason
> @@ -0,0 +1,14 @@
> +What:		/sys/devices/platform/.../power_on_reason
> +
> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	Kamel Bouhara <kamel.bouhara@bootlin.com>
> +Description:	This file shows system power on reason.
> +		The possible sources are:
> +		General System Power-ON, RTC wakeup, Watchdog timeout,
> +		Software Reset, User pressed reset button,
> +		CPU Clock failure, 32.768kHz Oscillator Failure,
> +		Low power mode exit, Unknown.
> +
> +		The file is read only.
> +
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 44ca983a49a1..3cb2df40af37 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -17,7 +17,7 @@
>   #include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/reboot.h>
> -
> +#include <linux/power/power_on_reason.h>
>   #include <soc/at91/at91sam9_ddrsdr.h>
>   #include <soc/at91/at91sam9_sdramc.h>
>=20
> @@ -146,42 +146,42 @@ static int samx7_restart(struct notifier_block *thi=
s, unsigned long mode,
>   	return NOTIFY_DONE;
>   }
>=20
> -static void __init at91_reset_status(struct platform_device *pdev)
> +static const char *at91_reset_reason(struct platform_device *pdev)
>   {
>   	const char *reason;
>   	u32 reg =3D readl(at91_rstc_base + AT91_RSTC_SR);
>=20
>   	switch ((reg & AT91_RSTC_RSTTYP) >> 8) {
>   	case RESET_TYPE_GENERAL:
> -		reason =3D "general reset";
> +		reason =3D POWER_ON_REASON_GENERAL;
>   		break;
>   	case RESET_TYPE_WAKEUP:
> -		reason =3D "wakeup";
> +		reason =3D POWER_ON_REASON_RTC;
>   		break;
>   	case RESET_TYPE_WATCHDOG:
> -		reason =3D "watchdog reset";
> +		reason =3D POWER_ON_REASON_WATCHDOG;
>   		break;
>   	case RESET_TYPE_SOFTWARE:
> -		reason =3D "software reset";
> +		reason =3D POWER_ON_REASON_SOFTWARE;
>   		break;
>   	case RESET_TYPE_USER:
> -		reason =3D "user reset";
> +		reason =3D POWER_ON_REASON_USER;
>   		break;
>   	case RESET_TYPE_CPU_FAIL:
> -		reason =3D "CPU clock failure detection";
> +		reason =3D POWER_ON_REASON_CPU_FAIL;
>   		break;
>   	case RESET_TYPE_XTAL_FAIL:
> -		reason =3D "32.768 kHz crystal failure detection";
> +		reason =3D POWER_ON_REASON_XTAL_FAIL;
>   		break;
>   	case RESET_TYPE_ULP2:
> -		reason =3D "ULP2 reset";
> +		reason =3D POWER_ON_REASON_LOW_POWER;
>   		break;
>   	default:
> -		reason =3D "unknown reset";
> +		reason =3D POWER_ON_REASON_UNKNOWN;
>   		break;
>   	}
>=20
> -	dev_info(&pdev->dev, "Starting after %s\n", reason);
> +	return reason;
>   }
>=20
>   static const struct of_device_id at91_ramc_of_match[] =3D {
> @@ -204,6 +204,17 @@ static struct notifier_block at91_restart_nb =3D {
>   	.priority =3D 192,
>   };
>=20
> +static ssize_t power_on_reason_show(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +
> +	return sprintf(buf, "%s\n", at91_reset_reason(pdev));
> +}
> +
> +static DEVICE_ATTR_RO(power_on_reason);
> +
>   static int __init at91_reset_probe(struct platform_device *pdev)
>   {
>   	const struct of_device_id *match;
> @@ -248,7 +259,14 @@ static int __init at91_reset_probe(struct platform_d=
evice *pdev)
>   		return ret;
>   	}
>=20
> -	at91_reset_status(pdev);
> +	ret =3D device_create_file(&pdev->dev, &dev_attr_power_on_reason);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not create sysfs entry\n");
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "Starting after %s reset\n",
> +		 at91_reset_reason(pdev));
>=20
>   	return 0;
>   }
> diff --git a/include/linux/power/power_on_reason.h b/include/linux/power/=
power_on_reason.h
> new file mode 100644
> index 000000000000..9978cc757427
> --- /dev/null
> +++ b/include/linux/power/power_on_reason.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Author: Kamel Bouhra <kamel.bouhara@bootlin.com>
> + */
> +
> +#ifndef POWER_ON_REASON_H
> +#define POWER_ON_REASON_H
> +
> +#define POWER_ON_REASON_GENERAL "General"
> +#define POWER_ON_REASON_RTC "RTC wakeup"
> +#define POWER_ON_REASON_WATCHDOG "Watchdog timeout"
> +#define POWER_ON_REASON_SOFTWARE "Software"
> +#define POWER_ON_REASON_USER "User"
> +#define POWER_ON_REASON_CPU_FAIL "CPU Clock Failure"
> +#define POWER_ON_REASON_XTAL_FAIL "32.768k Crystal oscillator Failure"
> +#define POWER_ON_REASON_LOW_POWER "Low power exit"
> +#define POWER_ON_REASON_UNKNOWN "Unknown"
> +
> +#endif /* POWER_ON_REASON_H */
> --
> 2.23.0
>=20
>=20
>=20


--=20
Nicolas Ferre
