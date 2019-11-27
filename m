Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8410AE56
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2019 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfK0K70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Nov 2019 05:59:26 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:45397 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfK0K7Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Nov 2019 05:59:25 -0500
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
IronPort-SDR: +i+4K0RORoR4XEzeFiWDg+dHA4Yx3Gs0nVyr0Onz4rOkwS0KMbxXnlhMbERi+z1o8eLgottKvA
 604aAkVM88OWmfdvCpv34mKQlhFlk/eZK7UinxDDRkTtGtU7r4WP4UBmkRdPsCPeK9L5oxYmAx
 ng+8VblewbDBeWCdC868GYIK2W24k9Na9Is4k7WVOlcWyh0FHHgKIJoJxKPJd8PB0nk6unQoN1
 ugV33Rsf5Yxrl+r6SxnBYKvMCZufyRtGcZRJbJI1DbI8Z5ngHz1ir7fNAE3t6zcECdZeseR9mB
 bQ4=
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="59919370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2019 03:59:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 27 Nov 2019 03:59:24 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 27 Nov 2019 03:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsP8ryTK10p6WTjOta4wJQnbP/ZPc7HfT1vpgNLG1yprehxeDCJZc9/kXmqumQ8lsbl5QxQqQ7wu7OU+Pl1dmzHVkdHbkGhf3SUBTSYlJbQtjoyQZFwGDyPgBYfsjcGLLdQO5PfVaVzaYFTw835qG9EJpSqif1s9n+nEGs0gCzFNb5g7nFr2k6CieZMz0JozuMGPzSUmZwSykBFSZCZhCxmLtKBLfQu6XtCGtiOEmdDV6puedcv3FRmzOVOikURXLcvFh91BuAGVm2UV+fC1IN3goLKZJwUPV8sRHb1sPajJhC6czvkuaJ2w3CO/ojq27M+nC8ykKLbbM2oV6aXRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMGZ6gHqXo3o89bszpP/4qQ+3csgFF81B8MgVh/JOoM=;
 b=DkOha67bY8dOMZPpOkYMJ/em9cM4frl8a6wBiYkHXNBXdGYPDhAnW9DlmMfzxsLBR3k/9ROAPZdZEug4Xb+8JEYBHW5YDSnFY8dn9nGpXufOkba7R1IOF8o8THLqfT51IhqWjwUTMAZSg66CoJr1M7qqovi+4qvdP9EvVYjiokCaOeUXqz97SM44wv5awknoTVJTjc38fzACh7JtQLcfdsGIpTxujYbQjr726OaLdNeLvB8vRBrCjM+cZvmv1SeDJtgIGC+CuzCvThtJxuAy/Eq/kt7u0JteZNNDj6Zb1+NNG27sKw7+6exvQEGtZGHeTC16brTmUSHT8dtsCei9uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMGZ6gHqXo3o89bszpP/4qQ+3csgFF81B8MgVh/JOoM=;
 b=PIHvmMkHs+uF6aRc/2+ThJtlZb567epHFeDlv0Q5jvw20s7DeOqzEgirqGelxiJne1SRkidyw/02EwJQsUedc9bnQeDpD0uTOwxAtuSdQqgo1WTFVdMPpOjc0q5DJXl5TLyCB08oe2sswEQ+fUoI14IkviS3jR5TNCmjiUyftAs=
Received: from SN6PR11MB2830.namprd11.prod.outlook.com (52.135.93.21) by
 SN6PR11MB3007.namprd11.prod.outlook.com (52.135.125.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 10:59:20 +0000
Received: from SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::74c7:7e0e:5565:a0e5]) by SN6PR11MB2830.namprd11.prod.outlook.com
 ([fe80::74c7:7e0e:5565:a0e5%7]) with mapi id 15.20.2474.022; Wed, 27 Nov 2019
 10:59:20 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux@armlinux.org.uk>, <Ludovic.Desroches@microchip.com>,
        <sre@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 02/17] ARM: at91: pm: move SAM9X60's PM under its own
 SoC config flag
Thread-Topic: [PATCH v2 02/17] ARM: at91: pm: move SAM9X60's PM under its own
 SoC config flag
Thread-Index: AQHVpKCR5gUDGDWLVkmRZzfKMYr546eeqfmAgAAhsQCAAA57AA==
Date:   Wed, 27 Nov 2019 10:59:20 +0000
Message-ID: <ed32a4fd-973a-ec59-c695-11411dd47dd1@microchip.com>
References: <1574773941-20649-1-git-send-email-claudiu.beznea@microchip.com>
 <1574773941-20649-3-git-send-email-claudiu.beznea@microchip.com>
 <20191126212841.GR299836@piout.net>
 <10705ea9-7a0f-5af4-e383-293fabed6b89@microchip.com>
 <20191127100722.GI299836@piout.net>
In-Reply-To: <20191127100722.GI299836@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR2PR09CA0007.eurprd09.prod.outlook.com
 (2603:10a6:101:16::19) To SN6PR11MB2830.namprd11.prod.outlook.com
 (2603:10b6:805:5b::21)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2a01:cb1c:a97:7600:4101:ade1:25ee:c9ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 645395c3-a8fa-4d5f-d369-08d77328daaf
x-ms-traffictypediagnostic: SN6PR11MB3007:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB3007FF48745015187F6E170BE0440@SN6PR11MB3007.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(346002)(136003)(199004)(189003)(966005)(14454004)(8936002)(52116002)(36756003)(2906002)(478600001)(4326008)(31686004)(71200400001)(71190400001)(110136005)(14444005)(54906003)(99286004)(5024004)(256004)(66946007)(53546011)(386003)(31696002)(64756008)(66476007)(66446008)(66556008)(5660300002)(6436002)(229853002)(8676002)(6306002)(6512007)(316002)(76176011)(102836004)(6246003)(25786009)(6116002)(305945005)(46003)(6636002)(81166006)(7736002)(446003)(11346002)(81156014)(6506007)(186003)(86362001)(6486002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3007;H:SN6PR11MB2830.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sFn5TD7uIe6sEVwkurBtuReESzwLTJqhzk6j4mYAsOeGQ97QV+Jya+Fsujrxeom+8vrj89Nw2Mh5eAAfn3dQryQIP8mECeVe+ySPNI8aDTItbJh4MbbWX6gvX1wxB2EXq+XRmd+vu/N68x87ELIbWimtTxGNIHRjWmO5BWZLzk2seOSCvM2rbaH0e0nzDtNsFHEK6iheYY/IR1bFHIbAw8vW+vqiZJ+isBkA7ESI7LnYb6AKF8ZomXjV2jKRdLExVRSROTkIJpl0Wd+RZXjT6+fv+7Fb7JrFwp+46tVrZI3Yj6107uRx5lC1jqBviue0nwiGri4l4WHvefuXj55wgurVuk5akfLdP26/jhxXN7uFnmMg00uhMLBMQqj1BYKlKeoPnLlpTugk2t3kRNAysSRKsYY8WVhgIRmZvuVHRM+8R4PI+Ec2UTQxormMptd70kb8kXwMhhu3TO8XQ1FbwPfeL4vnfZT4yZzh+hT0CQ=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D94D4C6F3553F04FA8F3A03DE88723EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 645395c3-a8fa-4d5f-d369-08d77328daaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 10:59:20.3255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnCxr2uGdRyEUqwmyNB+LturV7msme+OVWf9q4Eus9OmHRBn7Z/r+wJmLU6gsYWffQ+XskHgMUqCgeTJIyja0DQsgS/q6LcQQ3V42diRt4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3007
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/11/2019 at 11:07, Alexandre Belloni wrote:
> On 27/11/2019 08:06:47+0000, Claudiu.Beznea@microchip.com wrote:
>>
>>
>> On 26.11.2019 23:28, Alexandre Belloni wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
>>>
>>> On 26/11/2019 15:12:06+0200, Claudiu Beznea wrote:
>>>> Move SAM9X60's PM part under SoC config flag. This allows the building
>>>> of SAM9X60 platform withouth depending on CONFIG_SOC_AT91SAM9 flag,
>>>> allowing us to select only necessary config flags for SAM9X60.
>>>>
>>>
>>> I'm really wondering, how much space does that really save?
>>>
>>> The net benefit seems to be very small...
>>
>> Not that much, indeed. We want to be independent of SOC_AT91SAM9.
>>
>=20
> The question is why? I don't see the technical benefit but I
> definitively see the maintenance burden of having two separate configs
> doing almost the same thing.

The AT91SAM9 config embeds a bunch of earlier drivers/clock definitions=20
that are not needed anymore in the new SAM9X60. Likewise, some sam9x60=20
new things are not needed at all for the older sam9 series.
There is somehow a generation gap between them...

I would like that we preserve the possibility to only embed the sam9x60=20
alone in a tailored kernel configuration, basically how it is done for=20
our SAMA5s. I know that we're talking about ~100s of KB here, but=20
however, it's easy to do now and it could make a difference when=20
targeting low spec systems.
Maintaining the SAMA5 as separate config options never proved us to be=20
difficult to do.

Best regards,
   Nicolas

>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> ---
>>>>   arch/arm/mach-at91/Makefile   |  1 +
>>>>   arch/arm/mach-at91/at91sam9.c | 18 ------------------
>>>>   arch/arm/mach-at91/pm.c       |  2 +-
>>>>   arch/arm/mach-at91/sam9x60.c  | 34 +++++++++++++++++++++++++++++++++=
+
>>>>   4 files changed, 36 insertions(+), 19 deletions(-)
>>>>   create mode 100644 arch/arm/mach-at91/sam9x60.c
>>>>
>>>> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
>>>> index de64301dcff2..f565490f1b70 100644
>>>> --- a/arch/arm/mach-at91/Makefile
>>>> +++ b/arch/arm/mach-at91/Makefile
>>>> @@ -6,6 +6,7 @@
>>>>   # CPU-specific support
>>>>   obj-$(CONFIG_SOC_AT91RM9200) +=3D at91rm9200.o
>>>>   obj-$(CONFIG_SOC_AT91SAM9)   +=3D at91sam9.o
>>>> +obj-$(CONFIG_SOC_SAM9X60)    +=3D sam9x60.o
>>>>   obj-$(CONFIG_SOC_SAMA5)              +=3D sama5.o
>>>>   obj-$(CONFIG_SOC_SAMV7)              +=3D samv7.o
>>>>
>>>> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sa=
m9.c
>>>> index bf629c90c758..7e572189a5eb 100644
>>>> --- a/arch/arm/mach-at91/at91sam9.c
>>>> +++ b/arch/arm/mach-at91/at91sam9.c
>>>> @@ -31,21 +31,3 @@ DT_MACHINE_START(at91sam_dt, "Atmel AT91SAM9")
>>>>        .init_machine   =3D at91sam9_init,
>>>>        .dt_compat      =3D at91_dt_board_compat,
>>>>   MACHINE_END
>>>> -
>>>> -static void __init sam9x60_init(void)
>>>> -{
>>>> -     of_platform_default_populate(NULL, NULL, NULL);
>>>> -
>>>> -     sam9x60_pm_init();
>>>> -}
>>>> -
>>>> -static const char *const sam9x60_dt_board_compat[] __initconst =3D {
>>>> -     "microchip,sam9x60",
>>>> -     NULL
>>>> -};
>>>> -
>>>> -DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
>>>> -     /* Maintainer: Microchip */
>>>> -     .init_machine   =3D sam9x60_init,
>>>> -     .dt_compat      =3D sam9x60_dt_board_compat,
>>>> -MACHINE_END
>>>> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
>>>> index d5af6aedc02c..56a6a49b19e2 100644
>>>> --- a/arch/arm/mach-at91/pm.c
>>>> +++ b/arch/arm/mach-at91/pm.c
>>>> @@ -805,7 +805,7 @@ void __init at91rm9200_pm_init(void)
>>>>
>>>>   void __init sam9x60_pm_init(void)
>>>>   {
>>>> -     if (!IS_ENABLED(CONFIG_SOC_AT91SAM9))
>>>> +     if (!IS_ENABLED(CONFIG_SOC_SAM9X60))
>>>>                return;
>>>>
>>>>        at91_pm_modes_init();
>>>> diff --git a/arch/arm/mach-at91/sam9x60.c b/arch/arm/mach-at91/sam9x60=
.c
>>>> new file mode 100644
>>>> index 000000000000..d8c739d25458
>>>> --- /dev/null
>>>> +++ b/arch/arm/mach-at91/sam9x60.c
>>>> @@ -0,0 +1,34 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Setup code for SAM9X60.
>>>> + *
>>>> + * Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries
>>>> + *
>>>> + * Author: Claudiu Beznea <claudiu.beznea@microchip.com>
>>>> + */
>>>> +
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_platform.h>
>>>> +
>>>> +#include <asm/mach/arch.h>
>>>> +#include <asm/system_misc.h>
>>>> +
>>>> +#include "generic.h"
>>>> +
>>>> +static void __init sam9x60_init(void)
>>>> +{
>>>> +     of_platform_default_populate(NULL, NULL, NULL);
>>>> +
>>>> +     sam9x60_pm_init();
>>>> +}
>>>> +
>>>> +static const char *const sam9x60_dt_board_compat[] __initconst =3D {
>>>> +     "microchip,sam9x60",
>>>> +     NULL
>>>> +};
>>>> +
>>>> +DT_MACHINE_START(sam9x60_dt, "Microchip SAM9X60")
>>>> +     /* Maintainer: Microchip */
>>>> +     .init_machine   =3D sam9x60_init,
>>>> +     .dt_compat      =3D sam9x60_dt_board_compat,
>>>> +MACHINE_END
>>>> --
>>>> 2.7.4
>>>>
>>>
>>> --
>>> Alexandre Belloni, Bootlin
>>> Embedded Linux and Kernel engineering
>>> https://bootlin.com
>>>
>=20
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>=20


--=20
Nicolas Ferre
