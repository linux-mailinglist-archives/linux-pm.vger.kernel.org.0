Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D1D40DC80
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 16:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhIPONw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 10:13:52 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:6266
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235546AbhIPONv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Sep 2021 10:13:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NC7WJaE8oHJK+7OAv5p+hQPWBl9c46XZNRgyw3E3yCw071KbUp51xDgfGNGE41Gzf5+8vgm4VrYgXzI95xcxd6hcQ28FzYnf6Rvg8zGF0yUj4UZGnadCpOab6hHEIyo+r2OVi+mt3xKQLt9IXMVWCOFTabRk+M3oUhptyJ2roCEsigZsrArCIST4qaaOAzl4awoiom3DKG6viGFqveiGi7ZkqNNKKDTYInEr6DgvnSItmimhAp7jXonHzZDT81EH4wlJ2EXW7SmSQ7UMdE+CnIpPyIJ3btms17lE48R/hBtiT+b2U2bFstMfBMk5ju4aTD7lOl/B1Kpt5BqUb6hSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UkcZcke6wJgmzVzOmfMCgYWsEQyG0lPkVju6t4gx+Wo=;
 b=WbzGIwK3pX98ut8612VOqzIuyVFa4AaZDUnNLY9SqFRw4aLqHrIzi5yvIAJyw/tQlq7oINLuDglQ9j1CmVuS6DjTPS+I6TvfKS/JkdSPfrwUfDpt/Sdq7IHVHatNKWFrigxYfZm9Ifq5EJJNLctlhuv0FQ+jBlyrSwWCKZN4gXVFYXbitR682ni0mrCLk5y9WCBqv3pde1ZsKbQgyxRdYLXAYqE73UkSllZyT/UlEbF4qNZRd8pFLEiHDiFbuiaz4HPVvHy6cgq9hGloHGEZ5b2fp+1tjwa748E6FuYJ+27xpzqgiZed4Gz5+x/fEf4UGdm3K7SRbrFNv3i7K/r2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkcZcke6wJgmzVzOmfMCgYWsEQyG0lPkVju6t4gx+Wo=;
 b=pf5ISLqA2T0YVsMW52HKrnrASi2E9PsLg3eqxCQH12bC0zmMMGo9PzykuUxkEhKw6mwZolVwOsniK8H5mTTtY0+CzgploTgCYYWLlo6pGlrpjL9nhVRHHgLrrDiTskXnOaWLls3/5AFitG4ul9zToOVKoZfJLqStsbZppRq459c=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 16 Sep
 2021 14:12:24 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%5]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 14:12:23 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@google.com>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "badhri@google.com" <badhri@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Topic: [RFC PATCH 2/3] power: supply: Add support for PDOs props
Thread-Index: AQHXoEKRtU4w32eDxEeY6U4KQGzJs6uiBmsAgAAaumCAAUDQAIAC9NuAgAAyawCAAD1scA==
Date:   Thu, 16 Sep 2021 14:12:23 +0000
Message-ID: <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org>
 <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com> <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
In-Reply-To: <YUMbGp0aemx1HCHv@kuha.fi.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93cc2c15-6544-4499-3e46-08d9791c0173
x-ms-traffictypediagnostic: DB9PR10MB4554:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB9PR10MB4554F2DA8EFF91D43DB2FAE7A7DC9@DB9PR10MB4554.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yD9C4GNgSEjmCZJGYZ4iHqmnd50B9HFCIxGSzJygH43sQ+/MFe0FTq49Pj1qgcj271Bx1BYYfxrIYN7FLqQdyKuqv2ktJ0Ck6ntinrVyKzz3Jw17iT893H/LBSniP2ih/J2T86a8HI8g/InAkPsB/VoJlRUJCpVO6YbRR2zthKXaRExivxLVFLgVfNvf+MKj2VBwNuPIwqsLn+h9c9moasgE3kyngnHuo/IT6uJxu534GHF7zuwF1gDl8is12jtwzBbUzgo2oLLo5nFEfd1Y7Y/n7lirxmkQWn3BJpQpsMUQXMGDdDp+nYN7yB13qVuuxyk8l56falKnfvOp7IpoH8H7dXg3tfe9AaBFs6xADYQKI0yePAP7wp6gMSlciapjUnjdkEjGAz98BBt5GTSOL98LEZ47sAJLTpKwXOh+xJn8T0lJLb9x/b5zUTSXcCJHZyzhNI4NYQDXR7g8DEkMzfM18ELmn4CmcOTJJ85Q1O8hvHjUQHnqOQ/D1WpHk6WoyT0bi0cOU06ROGIW8ld4VXsLTou92P7eH6L+5L4nrruxhECcpDTQTOS4hJ2ByDPEg/hSgLpTKdnKHcZjxkDTbA+yLMfLJlnmsexPd3k0wSiSn/4A4bYIaTuJ+nk5MOl7JJZFIIcEwdUQ8yB/NcQufijaUPI+BlcHs2M3NzG+Xy3yzzSW1EGdB1FkcIQj7y5sq/ecpOb1/uUXqfwIp5iZTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(6506007)(53546011)(26005)(186003)(76116006)(8676002)(83380400001)(38100700002)(54906003)(122000001)(66476007)(66446008)(38070700005)(66556008)(316002)(2906002)(64756008)(66946007)(33656002)(7696005)(110136005)(71200400001)(478600001)(52536014)(7416002)(8936002)(86362001)(9686003)(5660300002)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vEgrFo31IMk3zDOcsFMqBpYbPPumwl+V3+MgEV2827U4Lsze+hlmpvN0Qpm3?=
 =?us-ascii?Q?WaEDkh5BHR9ts/EoircIUu9RhSC3S7SGbQ7eMSh2CQIUrWTgElP776bE1jaM?=
 =?us-ascii?Q?rhETJ2f89mTJeds6CeNvcP7L7rjrafOfBtyCYbNwSwi28U90n31gg3wOoJ5s?=
 =?us-ascii?Q?mgr8VhVrVIfO5f9raS6UE+j/4A0q3jLlDpVcZpVEkLpTsx0FL5MaBZTlw6oe?=
 =?us-ascii?Q?M/SZtL2cFD3bqy1UVKLIhlQlZH/yAbJLw4SzNnEhgJfjU+N/cfUnrLng4OKT?=
 =?us-ascii?Q?U0XnpGklwMgXI/i/W57gJLUZ/uWfDoA/V+nLJzW+3br3tHdotDVvSXsR7ChL?=
 =?us-ascii?Q?hGqaLBUTv4ijcsIO85xR/TJ0wKBTsGFIf+vDDZLsGkdd1f8iVSONXN7+6Fkk?=
 =?us-ascii?Q?RVNUVquWyHBL5JT6yfVKvnfSeHs0NqsU3X/deHpC8++h+3kUZ0uTCOU1PEA0?=
 =?us-ascii?Q?lfLgYlKO1rGNXQzuRq/LFDunZqBCMGThlWjX6bTxp6TSiNqRXlyt+dODzqnX?=
 =?us-ascii?Q?HnVwGOBnvCrg8wsgNwCoE8dP2U15AUH26MXPmq/CIUepdEOlP8oCA5cEwaeD?=
 =?us-ascii?Q?Pxdzd11zmYw3SNwSqsqM4y/8NUe+nCMkWNYNkXYBv5/GwSBgNaDIZu2aOMvb?=
 =?us-ascii?Q?GJ3T2BwebQjEotrgJ++J3srHhseMmKFseHipy11l7QgGKm5YuNTeF9mUOx6V?=
 =?us-ascii?Q?jP1xjwaH7nvyGt03Ofn80nQh9/yJbvXUhaOyu1cBEqc8PVRLGOnZ3kh0arhL?=
 =?us-ascii?Q?TkqcGvyxkNOD5VS1nf9UPPhWj3yyQccLGgwkqY8YRH3O+2Sy2sf9pup5MQP/?=
 =?us-ascii?Q?rIs+eTheD1/44xNCPJ1orUstVKrYBJQMMESAof//gJLXem2hJ0XNSYeEbNND?=
 =?us-ascii?Q?N7ZLXu/jzkFWb2z9p78WvbpKmIpUjxBkDayo1U803H8g55bg4mMa9ZAMF5eI?=
 =?us-ascii?Q?TFkKmcSNb2nOLTuYt/nY6jE3cy5R5G4BruTu6wwj+zXKDBzd0/+4QqRwwjn6?=
 =?us-ascii?Q?qvZPFrgLGqkuots8Da8903nTlei0gwrAxfWBqQGBT6lN3biOcO3IkcSk1rar?=
 =?us-ascii?Q?coevfMubSNr+gTabHT7T8vd2J1k5Wd7RwP/L7M8sKhD+dFeX5vw8B7nXQISl?=
 =?us-ascii?Q?ZCSzP14Qw7wZTGBhw1xnR38euCIRQJwD8kg6VEFcQcG50Le6dW/XzWeFtSF5?=
 =?us-ascii?Q?HYsaZ9xt9dh36wlVOx7QioHnvttLk6clrg9zGBq8YNdJKfxLNkAMpON5k+02?=
 =?us-ascii?Q?S/BlEGiL5TORDPgseHHwGz0ZuKC1uBHMdZHFKs0xiTVK7DMbqIa/uWQa0yTq?=
 =?us-ascii?Q?PJ1Z9Nb8pZ8rJZsnlmFM1Fxh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cc2c15-6544-4499-3e46-08d9791c0173
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 14:12:23.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HfkKzZuqdugwk/6OYuLbWNozflziLmHeTE7q+/stm0KxBZrvZs6mTJmr9XLmXbaQ/47QEkjjFBhH0yPg6ih2qYrruWazSZ4ICARhfD6dv8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4554
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16 September 2021 11:23, Heikki Krogerus wrote:

> > Thanks for providing the clarification. So you're proposing a port-psy =
and a
> > port-partner-psy that are connected to each other (one supplying the ot=
her).
> > If PD is not present, those two will exist per port and partner, and th=
ere
> > will be information about Type-C current (and possibly BC 1.2 and other
> > methods?)
>=20
> Yes, exactly.
>=20
> > Do you have an example hierarchy you could share that explains what it =
would
> > look like in /sys/class/power_supply with PD with Source Caps and Sink =
Caps on
> > both sides?
>=20
> I don't yet, but I'll prepare something. I did notice already that the
> power supply class does not seem to display the suppliers nor
> supplicants in sysfs. But we can always improve the class.
>=20
> I probable should not talk about "hierarchy". Maybe taking about
> simply "chain" of power supplies is more correct?
>=20
> > I think this all makes sense if the connector class is a read interface
> > for this info. Have you considered how the type-c connector class and t=
his pd
> > psy support will handle dynamic PDO changes for advertisement FROM the
> ports?
> >
> > For example, let's say you wanted the kernel and user to manage two USB=
-C
> ports
> > with higher power support (meaning, 5V, 9V, 15V, 20V capable), but then=
 your
> > kernel and user needs to edit the Source Caps on the fly based on load
> > balancing.
> >
> > If caps are represented as a group of psys together, how do you as a ke=
rnel
> > and user create an modify the set of Source_Caps you put out on a port?
>=20
> My idea is to utilise the "present" property with the ports. You would
> always display all the possible supplies, but only the ones that you
> expose in your current capabilities will be present.
>=20
> The idea is also that the ports are always supplied by normal power
> supplies of type "battery", "AC" and what have you. Those you can use
> to see the maximum power your port can get, and to determine the
> currently available power by checking the other ports that consume the
> same supply.
>=20
> So if you need more power for one port, you most likely will need to
> attempt to adjust the power levels of the source PDO power supplies of
> the other ports that share the base supply (like battery), or possibly
> disable them, and that way enable (make present) more source supplies
> for your port. That is the idea, but I admit I have not thought of
> everything, so I'm not completely sure would it work exactly like
> that, but the power balancing should in any case be possible with the
> chain of power supplies one way or the other.
>=20
> I hope I understood your question correctly, and I hope I was able to
> give you an answer :-)

Thanks for the additional updates. So is the intention here to move control=
 of
PDO selection away from TCPM, or add more flexibility to it? As I understan=
d it
from previous efforts around all of this, the intention was that TCPM makes=
 the
decision as to which PDO to select (and which APDO for PPS) based on the of=
fered
capabilities of the source and the sink capabilities which are described in=
 FW.
Am just trying to envisage the use-cases here and how the kernel/user is
involved in selecting PDOs/voltages/currents.

IIRC there used to be functions for updating source/sink capabilities but t=
hese
never had users and were subsequently removed. I guess this would be essent=
ially
the functional replacement for those APIs?

Personally, I think the idea of source/sink PSY instances supplying each ot=
her
seems reasonable. Right now we represent the external PD/Type-C supply (par=
tner)
through TCPM as a PSY instance which is always present for the associated p=
ort,
although obviously when no source partner exists we're marked as offline. F=
or
the partner side I'm guessing the PSY instance will be dynamically
created/destroyed? From previous experience PSY classes have tended to be
statically included so would be interested in seeing what this looks like i=
n
reality.

Am still unsure on using PSY to expose individual PDOs though and this stil=
l
feels quite heavyweight. I assume we're not wanting to expose everything in=
 PDOs
really, just the voltage/current info? Feels like we should be able to do t=
his
with individual properties which a user can be notified of changes to throu=
gh
the normal prop notifier, rather than a collection of PSY class instances.
However, I'm happy to be convinced the other way so will await further
details. :)
