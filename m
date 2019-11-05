Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27BCF0A1F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Nov 2019 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfKEXQ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 18:16:26 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33224 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfKEXQZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 18:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1572995783; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eDsiJOXarrFhke1fkCycy1O3NiGTme3bfHAiHJkXB/8=;
        b=tKXqfuTr2nlPjgFFl0fNG+qcFIc/NLt830kfPzztWEd44nARkG01pVjsPw1FGfhHOg1D9y
        AQBEjji+3O7H2S9vFSCBXnAnpz7G6kCNxKGYzDRIH0nNoTfSLL+6P6bYRH3blL6xzG3Y5f
        30XL3GuyitI6hQmD6SJ2+Wu3zgX7QZM=
Date:   Wed, 06 Nov 2019 00:16:17 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings: power/supply: Document generic USB
 charger
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Message-Id: <1572995777.3.4@crapouillou.net>
In-Reply-To: <CAL_JsqJDT71eThy43kaN3RsU03Ew7aZ_abJg0zhaFxyDH9RhhA@mail.gmail.com>
References: <20191103220801.10666-1-paul@crapouillou.net>
        <CAL_Jsq+aSXPT-vmHbDLygO0G3RmM3svTeS+S5FKKjj_Auf3gPw@mail.gmail.com>
        <1572945391.3.1@crapouillou.net>
        <CAL_JsqJDT71eThy43kaN3RsU03Ew7aZ_abJg0zhaFxyDH9RhhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Le mar., nov. 5, 2019 at 07:48, Rob Herring <robh+dt@kernel.org> a=20
=E9crit :
> On Tue, Nov 5, 2019 at 3:16 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Hi Rob,
>>=20
>>=20
>>  Le lun., nov. 4, 2019 at 07:52, Rob Herring <robh+dt@kernel.org> a
>>  =E9crit :
>>  > On Sun, Nov 3, 2019 at 4:08 PM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>
>>  >>  Add documentation about the devicetree bindings for the generic=20
>> USB
>>  >>  charger.
>>  >
>>  > What makes it generic?
>>=20
>>  It only uses the USB PHY subsystem, which already has some=20
>> half-baked
>>  support for chargers but not bound to the power-supply subsystem.
>>=20
>>=20
>>  >>
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >>   .../bindings/power/supply/usb-charger.txt     | 24
>>  >> +++++++++++++++++++
>>  >>   1 file changed, 24 insertions(+)
>>  >>   create mode 100644
>>  >> Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>  >>
>>  >>  diff --git
>>  >> a/Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>  >> b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>  >>  new file mode 100644
>>  >>  index 000000000000..fd46734cb0e5
>>  >>  --- /dev/null
>>  >>  +++=20
>> b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
>>  >>  @@ -0,0 +1,24 @@
>>  >>  +Generic USB charger bindings
>>  >>  +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>  >>  +
>>  >>  +Required properties :
>>  >>  + - compatible : should be "usb-charger"
>>  >>  + - phys: phandle to the USB PHY
>>  >>  +
>>  >>  +Example:
>>  >>  +
>>  >>  +usb_con: extcon {
>>  >>  +       compatible =3D "linux,extcon-usb-gpio";
>>  >>  +       vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
>>  >>  +};
>>  >>  +
>>  >>  +usb_phy: usb-phy@0 {
>>  >>  +       compatible =3D "usb-nop-xceiv";
>>  >>  +       #phy-cells =3D <0>;
>>  >>  +       extcon =3D <&usb_con>;
>>  >
>>  > extcon is deprecated in favor of usb-connector binding. See
>>  > .../bindings/connector/usb-connector.txt. There's also some=20
>> pending
>>  > patches for adding GPIO based connector controls including Vbus=20
>> sense
>>  > (GPIO input) and control (regulator via a GPIO).
>>  >
>>  > Rob
>>=20
>>  I understand that the usb-connector binding is better, but the=20
>> current
>>  code doesn't integrate at all with the USB PHY subsystem, which has=20
>> its
>>  own code to handle ID and VBUS GPIOs and supports notifiers. Is that
>>  deprecated then?
>>=20
>>  What's the big picture here?
>=20
> Does this series work for you?:
>=20
> https://patchwork.kernel.org/cover/11120707/

I had to do some changes to my musb and PHY drivers but it works, yes.

The good thing is that I didn't have to change this driver, so I'll=20
wait for feedback on patch 2/2 then post a v2 with a fixed devicetree=20
example.

Thanks,
-Paul

=

