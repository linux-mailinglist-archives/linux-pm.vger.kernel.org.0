Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E42EFEF1
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 14:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbfKENsg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 08:48:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388860AbfKENsg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 5 Nov 2019 08:48:36 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A896B21D7D;
        Tue,  5 Nov 2019 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572961714;
        bh=jcvmqK0w1Iqo7UHWSqlXcYUsc1MVhw6hDCOK8MEqwCg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AhinqTDuo41At9YuFlREsi13iiVAadcH+Y0UvuUBQRL4IZ1LjDYUcm1AZwvWH0Kj7
         YyHpkmgKTs7ja8ujol11v++RNWXZaZIdNyUDB4y4e808lH7zHSFVKDyKIzuI4uUEG+
         BQM8PvO/uiDvEGUK6rC4iZlCfs+sIAGQ2ZzGvvFg=
Received: by mail-qk1-f182.google.com with SMTP id a18so3487544qkk.7;
        Tue, 05 Nov 2019 05:48:34 -0800 (PST)
X-Gm-Message-State: APjAAAV2dvzIz7Pd/Pq7kgtqv2fHoX114DLATt8KBHgXcFoe4PEJk7yZ
        trkEctje0o3pZDAEue7gavoD+Xv92QD2wllM8A==
X-Google-Smtp-Source: APXvYqzaZcSGoONsXuXI03XKrd01Y+KIO7axdLFPshVUra0eJ0zk30JGENPxby1o+H2VvHyAMjsceN4vqKFeusCInUk=
X-Received: by 2002:a37:4904:: with SMTP id w4mr21044984qka.119.1572961713720;
 Tue, 05 Nov 2019 05:48:33 -0800 (PST)
MIME-Version: 1.0
References: <20191103220801.10666-1-paul@crapouillou.net> <CAL_Jsq+aSXPT-vmHbDLygO0G3RmM3svTeS+S5FKKjj_Auf3gPw@mail.gmail.com>
 <1572945391.3.1@crapouillou.net>
In-Reply-To: <1572945391.3.1@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 5 Nov 2019 07:48:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJDT71eThy43kaN3RsU03Ew7aZ_abJg0zhaFxyDH9RhhA@mail.gmail.com>
Message-ID: <CAL_JsqJDT71eThy43kaN3RsU03Ew7aZ_abJg0zhaFxyDH9RhhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power/supply: Document generic USB charger
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 5, 2019 at 3:16 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Rob,
>
>
> Le lun., nov. 4, 2019 at 07:52, Rob Herring <robh+dt@kernel.org> a
> =C3=A9crit :
> > On Sun, Nov 3, 2019 at 4:08 PM Paul Cercueil <paul@crapouillou.net>
> > wrote:
> >>
> >>  Add documentation about the devicetree bindings for the generic USB
> >>  charger.
> >
> > What makes it generic?
>
> It only uses the USB PHY subsystem, which already has some half-baked
> support for chargers but not bound to the power-supply subsystem.
>
>
> >>
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> >>  ---
> >>   .../bindings/power/supply/usb-charger.txt     | 24
> >> +++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >>   create mode 100644
> >> Documentation/devicetree/bindings/power/supply/usb-charger.txt
> >>
> >>  diff --git
> >> a/Documentation/devicetree/bindings/power/supply/usb-charger.txt
> >> b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
> >>  new file mode 100644
> >>  index 000000000000..fd46734cb0e5
> >>  --- /dev/null
> >>  +++ b/Documentation/devicetree/bindings/power/supply/usb-charger.txt
> >>  @@ -0,0 +1,24 @@
> >>  +Generic USB charger bindings
> >>  +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>  +
> >>  +Required properties :
> >>  + - compatible : should be "usb-charger"
> >>  + - phys: phandle to the USB PHY
> >>  +
> >>  +Example:
> >>  +
> >>  +usb_con: extcon {
> >>  +       compatible =3D "linux,extcon-usb-gpio";
> >>  +       vbus-gpios =3D <&gpb 5 GPIO_ACTIVE_HIGH>;
> >>  +};
> >>  +
> >>  +usb_phy: usb-phy@0 {
> >>  +       compatible =3D "usb-nop-xceiv";
> >>  +       #phy-cells =3D <0>;
> >>  +       extcon =3D <&usb_con>;
> >
> > extcon is deprecated in favor of usb-connector binding. See
> > .../bindings/connector/usb-connector.txt. There's also some pending
> > patches for adding GPIO based connector controls including Vbus sense
> > (GPIO input) and control (regulator via a GPIO).
> >
> > Rob
>
> I understand that the usb-connector binding is better, but the current
> code doesn't integrate at all with the USB PHY subsystem, which has its
> own code to handle ID and VBUS GPIOs and supports notifiers. Is that
> deprecated then?
>
> What's the big picture here?

Does this series work for you?:

https://patchwork.kernel.org/cover/11120707/
