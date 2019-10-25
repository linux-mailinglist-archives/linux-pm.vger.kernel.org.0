Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFFDDE5502
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2019 22:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfJYUTt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Oct 2019 16:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfJYUTt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Oct 2019 16:19:49 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CE3821E6F;
        Fri, 25 Oct 2019 20:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572034787;
        bh=0zDH0Fbrijq1CDlKb/eS9UolHwf/vrJ4mzyY2QBJsBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqeviibTuNZv2SaUyRGiB0nQifeY/W01PGm9s6G/Tvxny0L1/LfoH23izCCNYZcPU
         N82wKD6IFXMHPN6icjNVj+/HPv5IvXnZjRkL3mPFMBg5rHzQXVlCi3b+e7zr8iW165
         vpp9AXWeviqIGQAfeFQvRZ278d69OpkhbTEl6dWg=
Received: by mail-qt1-f182.google.com with SMTP id c21so5112295qtj.12;
        Fri, 25 Oct 2019 13:19:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUMHNP+4F0vMMQKYK+CBVCz7wIWoPhTwNvp4YBih4N0z5/9LaHR
        e7MflwU6HuxzYtGWS1blDElI/9EGEyumbHIHfA==
X-Google-Smtp-Source: APXvYqzLV0DNiSIgrqSeSFTkfH8awvr/ASCKRP7JD+/ltAUIM+wC1d0zfF+U7OiEUa1J3NlXBL4cFdbcYR0OTsXOWoQ=
X-Received: by 2002:ad4:518d:: with SMTP id b13mr356862qvp.79.1572034786614;
 Fri, 25 Oct 2019 13:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <1570695678-42623-1-git-send-email-jianxin.pan@amlogic.com>
 <1570695678-42623-2-git-send-email-jianxin.pan@amlogic.com>
 <20191014173900.GA6886@bogus> <622c7785-8254-5473-6b35-7287830f3c60@amlogic.com>
In-Reply-To: <622c7785-8254-5473-6b35-7287830f3c60@amlogic.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Oct 2019 15:19:35 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+F9EGv2jEWw2BrmH0NDKMRt6=pG6LSHL8UYH9G+-OeMw@mail.gmail.com>
Message-ID: <CAL_Jsq+F9EGv2jEWw2BrmH0NDKMRt6=pG6LSHL8UYH9G+-OeMw@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/4] dt-bindings: power: add Amlogic secure
 power domains bindings
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 6:26 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote=
:
>
> Hi Rob,
>
> On 2019/10/15 1:39, Rob Herring wrote:
> > On Thu, Oct 10, 2019 at 04:21:15AM -0400, Jianxin Pan wrote:
> >> Add the bindings for the Amlogic Secure power domains, controlling the
> >> secure power domains.
> >>
> >> The bindings targets the Amlogic A1 and C1 compatible SoCs, in which t=
he
> >> power domain registers are in secure world.
> >>
> >> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> >> ---
> >>  .../bindings/power/amlogic,meson-sec-pwrc.yaml     | 42 +++++++++++++=
+++++++++
> >>  include/dt-bindings/power/meson-a1-power.h         | 32 +++++++++++++=
++++
> >>  2 files changed, 74 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/amlogic,me=
son-sec-pwrc.yaml
> >> +
> >> +  secure-monitor:
> >> +    description: phandle to the secure-monitor node
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >
> > Why not just a child node of this node?
> >
> Thanks for the review.
>
> I followed the style of the previous series of meson=EF=BC=9A
>
>   46         efuse: efuse {
>   47                 compatible =3D "amlogic,meson-gxbb-efuse";
>   48                 clocks =3D <&clkc CLKID_EFUSE>;
>   49                 #address-cells =3D <1>;
>   50                 #size-cells =3D <1>;
>   51                 read-only;
>   52                 secure-monitor =3D <&sm>;
>   53         };

Looks like that was not reviewed by me and is only in linux-next.
Please make functions exposed by secure world a child of the secure
firmware node.

Really for power domains, you only need to add a '#power-domain-cells'
property to the secure monitor node.

Rob
