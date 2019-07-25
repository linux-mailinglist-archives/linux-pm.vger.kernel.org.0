Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D62750F1
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbfGYOYs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:24:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37697 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbfGYOYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 10:24:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so22847535pfa.4;
        Thu, 25 Jul 2019 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1VKuC1KiCNNy3fXegCj/9eEYpb5J1BMDpw/S3NGoOX4=;
        b=n54k40O/4V9IXaWdt1c/O/X1SNbI13qgKZuP/3Pc40n1eWQBHyPiu/ieVitQ/bWzWJ
         t0dPBt5MHm97pPuJzw6Pmqn1PiFHXIrzbQGcEEXizTWEiMZwth0i0V1qB8xs1l4lcXb5
         5kk5y7xrhmShk6p7AGID6g74Xw+x7Yxb8lIb2NpH9SZeyxaDb0xqOkOiEtG+fqGKWfyn
         qx0BZJpPplXJH2dOJBkUiWNqRgJpeHGIXl1/TLuMO1QSL8d/Vcx40CrUsaOisx5wJ/b6
         1/TpYz/HYfaHr4W0gFy0ysELjwMC92jnNL0PZH5Pwus4sxaXTaklbq5VQ8oLrxRtHlv0
         auNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1VKuC1KiCNNy3fXegCj/9eEYpb5J1BMDpw/S3NGoOX4=;
        b=bC/lWAvpG1ud8HYQMkxvyYsB2x+1rHuh7z/Rvfl7tMAe1aWcgrycr46H0QMzToJK+d
         /rt2lJQu9Fphjai1yvP5BvP81Ql/vQg49F33qD5LtthHlMBuQcgfug8tVfjyzCjmwdE3
         a+AD7yzI/k5LkvkLBiYNsKmOnnc6Fj4hFYb0eYHjdQokUWTftyhveGOjxGOeHm+h6eG0
         PgsQ0cgsJUitzxEvKdsUKw6NbM68DkJ0EOpkNB+sCdRfGOuPNIxbvMu6N0i68UnZilHO
         XG8+zYQkiIdbyaLQkWSasRGZsJVwAXsyqcQN+oq9l5YN0PQe3l6n/PO2sGp6wNSaaVVj
         VaIw==
X-Gm-Message-State: APjAAAWc5NR+KcFH/CB5AgImU5kkyG8WBDpPWZCpMvhoeYiFJUkhOmiK
        Y3bq+m9PgP3ayul9oH8L9aaOdOLragcxKaFgNDI=
X-Google-Smtp-Source: APXvYqzPCe+/gaiuTPknRfAisyHmKvhdgM0c+iqn70Y3nn+xULbKyQCLk6le1kROzCUC/Mt4Yevnd44vRHi2NxWSm2Y=
X-Received: by 2002:a63:7455:: with SMTP id e21mr81501053pgn.439.1564064687329;
 Thu, 25 Jul 2019 07:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <1561990354-4084-1-git-send-email-akinobu.mita@gmail.com>
 <1561990354-4084-3-git-send-email-akinobu.mita@gmail.com> <20190722221645.GA32515@bogus>
In-Reply-To: <20190722221645.GA32515@bogus>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Thu, 25 Jul 2019 23:24:36 +0900
Message-ID: <CAC5umyh5d7Ya-Ou8BZmPfpXKT+WkMCWnRKkCw8xhe9upNKqVbg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: thermal: nvme: Add binding documentation
To:     Rob Herring <robh@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Kenneth Heitke <kenneth.heitke@intel.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B47=E6=9C=8823=E6=97=A5(=E7=81=AB) 7:16 Rob Herring <robh@kernel=
.org>:
>
> On Mon, Jul 01, 2019 at 11:12:32PM +0900, Akinobu Mita wrote:
> > Add thermal binding documentation for NVMe temperature sensor.
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Jens Axboe <axboe@fb.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev@gmail.com>
> > Cc: Kenneth Heitke <kenneth.heitke@intel.com>
> > Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > ---
> > * v5
> > - New patch
> >
> >  Documentation/devicetree/bindings/thermal/nvme.txt | 56 ++++++++++++++=
++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/nvme.txt
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/nvme.txt b/Docum=
entation/devicetree/bindings/thermal/nvme.txt
> > new file mode 100644
> > index 0000000..60b90de
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/nvme.txt
> > @@ -0,0 +1,56 @@
> > +Binding for NVMe temperature sensor
> > +
> > +An NVMe controller reports up to nine temperature values in the SMART =
/ Health
> > +log.
> > +
> > +Required properties:
> > +- reg: A five-cell address encoded as (phys.hi phys.mid phys.lo size.h=
i
> > +  size.lo). phys.hi should contain the device's BDF (Bus/Device/Functi=
on)
> > +  as 0b00000000 bbbbbbbb dddddfff 00000000. The other cells should be =
zero.
> > +  See also Documentation/devicetree/bindings/pci/pci.txt
> > +
> > +- #thermal-sensor-cells: Must be 1. See ./thermal.txt for a descriptio=
n.
> > +  In the thermal-sensors property, the sensor ID 0 for composite tempe=
rature,
> > +  1 through 8 for NVMe temperature sensor N.
> > +
> > +Example:
> > +
> > +&pcie0 {
> > +     ...
> > +     nvme: nvme@0,0 {
> > +             reg =3D <0x0000 0 0 0 0>;
> > +             #address-cells =3D <3>;
> > +             #size-cells =3D <2>;
> > +
> > +             nvmetemp: nvmetemp {
> > +                     reg =3D <0x0000 0 0 0 0>; /* DEVFN =3D 0x00 (0:0)=
 */
>
> I'm not sure this is really valid PCI addressing as the parent has the
> same address.
>
> > +                     #thermal-sensor-cells =3D <1>;
>
> Can't you just put this in the parent? Is this really a separate
> addressable device from the parent?

How about this?

&pcie0 {
...
        pci-bridge@0 {
                reg =3D <0x00000 0 0 0 0>;
                #address-cells =3D <3>;
                #size-cells =3D <2>;

                nvme: nvme@0,0 {
                        reg =3D <0x10000 0 0 0 0>;
                        #thermal-sensor-cells =3D <1>;
                };
        };
};

and

&thermal_zones {
...
thermal-sensors =3D <&nvme 0>;
};

I tested this with the RockPro64 and edited
arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts.

$ lspci
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 0100
01:00.0 Non-Volatile memory controller: Micron/Crucial Technology
Device 2263 (rev 03)

$ lspci -tv
-[0000:00]---00.0-[01]----00.0  Micron/Crucial Technology Device 2263
