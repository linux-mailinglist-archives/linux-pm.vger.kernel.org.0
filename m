Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD8211D9FC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 00:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfLLX35 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 18:29:57 -0500
Received: from mout.gmx.net ([212.227.15.19]:42837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfLLX35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Dec 2019 18:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576193386;
        bh=gtNiGOMaG+hrEDMSnjfH4TheHPrFaKjLS4DfvxSWQJ4=;
        h=X-UI-Sender-Class:From:To:CC:In-reply-to:Subject:Reply-to:
         References:Date;
        b=SYROU9ETIvP5wm/aUkZXv30zCbFjChykztWSkke0CbCHwhC53OxPu1rkVmkikl+qi
         hih6PfRlB4qoDBhJmywBm2O1F51TtXsvyN7cvTJ5Bc3jbeq7sOf50M+8W9Wi4KdlYU
         hKqhurSuymWjvsSn1nwL7CMw0cyd/IpLAjX7HFbY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.20]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N3se2-1hfmIb1iwi-00zjUB; Fri, 13 Dec 2019 00:29:46 +0100
Received: by corona.crabdance.com (Postfix, from userid 1001)
        id E09FC6E85603; Thu, 12 Dec 2019 15:28:59 -0800 (PST)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     amit.kucheria@verdurent.com
CC:     heiko@sntech.de, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        edubezval@gmail.com, linux-rockchip@lists.infradead.org,
        rui.zhang@intel.com, linux-arm-kernel@lists.infradead.org
In-reply-to: <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com>
        (message from Amit Kucheria on Thu, 12 Dec 2019 13:58:52 +0530)
Subject: Re: [RESEND PATCH] thermal: rockchip: enable hwmon
Reply-to: schaecsn@gmx.net
Content-Type: text/plain
References: <20191212061702.BFE2D6E85603@corona.crabdance.com> <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com>
Message-Id: <20191212232859.E09FC6E85603@corona.crabdance.com>
Date:   Thu, 12 Dec 2019 15:28:59 -0800 (PST)
X-Provags-ID: V03:K1:DwsCsXOuYOhJw8V89QklRZ9osgYgHSIQVBXq4pgiRwhkFFmltBi
 3kcHnOCi6FRrCnoXmJm90yFyU6q+EVM3zS/paOZUwCbEjkicKJDTl5vaAIgAP+dE0J7/f13
 TI34F5ggu2CqpTP5XDijGLe2GuipTAa5rtvO4v9gt5QK1hGJHu3pZlAzlPrN6TKfVizJ/Qk
 vSBkzo1D2fH+o/uW3R1dw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:B/jaoG6pxyc=:m7iFg/yWoVMNeBlPMGdFNd
 PY6SNewXxM1s6K5Arb8uvuHEQdAP18gNudbqORo5F23TWR/WJUxzA1UtNu3AII2JRXnco1yP9
 34E6Cnm1PP53ryOE+uq9HjbrpfehMMscaG3MZBNMcc3Zgn4Rc18fRsL0hsO+u9XL3fe23yKPJ
 OZZYBvMynzgA3u5ysEcRwA1vn+2hG0dszBEIt4cpfY7+4hDY+90iNpVbakRPsbyZzRpTGNWoU
 6p0WD3BrfWNXLocPrjW9RhCzWYIQPprmNYmQVuVkygvF6If4z7EREYIvVgZ/CJoCxpqAp4WZ7
 Ox6lH2ZuCxJJMLctljuOsNdsYy3sG6hw61KDw95Qr6Ls45uoo67LD0WGXX0oC+5shUeWS4TYu
 9xmPTJG4koOIMz/3EZb7W8D9tdqmtwS6ciXJ2vPyLEUTA7TvPqITm4XBGHFsQRnKnvZP3MX4J
 JCXVRtf0xCZcSjtiYScV271xpHQSB4vXpresTWxFQz5KcfDt0CxsMPnNzKw5F0WKkg5C7Oikp
 CZtwRerVP3yiYk3Gg6LasW4esN+RGOSMbA4m+UE2Ywr3fghXsw+oSq8KlRk964qrl+1FnESta
 HajOPrIF+/KNsyIXh+PCM5v2DczQcrQ6zQ1uciBHmqO5oZjPT6er2HCYpiOoMxGXoJxaOdt/C
 sdLuC5tK6PSfZgVTdZDu0WJrshGUnGlUpRYdqdIG76bKFFd0kHFVJYfoP5TW3IF6h2DXwBTrv
 qKZf74Qv0jYdYI52FcCW1fqhcRs77Dp6c7+vmK1yrbRfPkzFWmajQ+4/7qY5geIMgf1lAg/11
 3nVXSxdV0CBKiFTHI2fexaxrM7FFym7dcx/4yYFRbq4AIzmuBn9x0a5EHn5Gob5N08nhJRY+2
 nU4ZvtXJ9bS0wD7w6dEzdUMoIQrYBraeg3quxdz0Uy1kVR+uznUXu9X4hpjKd5QOvNCrX1l2t
 TxKRoc8STqNtg53tX5ZbckBNykUlx3ys7hB4MFwBhJymQ6tRuvq14HTve65dhAjozMZ/EVX3F
 DPww8RJdp91u9nJGV68FU10GcQlq4uFG5lqYTkFCPonxAVMu5MD0RYvHb/bj9AU8vwadn2h9h
 pL87dBWLNCJOeeJz50kSTPAD9zvDj2J0lei3KhX4GLeLCzjcPQGmonkOMrfGAZw6nLpDzfvPC
 GFQwe7yvcIdSSF3XammtNlbqWI7GBvu9JKcHXHpCMw33JgV0IuYVhs0DlEFx2slndXIJ3VoDr
 4Xxp4DHhycRuYKL89sd0EIbC6e8RzRIE1VqN8Ct1D7sTpr83r5BivjKLwxBI=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Amit,

> On Thu, Dec 12, 2019 at 11:47 AM Stefan Schaeckeler <schaecsn@gmx.net> w=
rote:
> >
> > By default, of-based thermal drivers do not enable hwmon.
> > Explicitly enable hwmon for both, the soc and gpu temperature
> > sensor.
>
> Is there any reason you need to expose this in hwmon?

Why hwmon:

The soc embedds temperature sensors and hwmon is the standard way to expos=
e
sensors.

Sensors exposed by hwmon are automagically found by userland clients. User=
s
want to run sensors(1) and expect them to show up.


Why in rockchip_thermal.c:

drivers/thermal/ provides a high-level hwmon api in thermal_hwmon.[hc] whi=
ch is
used by at least these thermal drivers: rcar_gen3_thermal.c, rcar_thermal.=
c,
st/stm_thermal.c, and broadcom/bcm2835_thermal.c. I want to hook up
rockchip_thermal.c exactly the same way.

Apparently, other architectures hook up the cpu temperature sensors to hwm=
on
elsewhere. Most seem to do this in hwmon/, e.g. hwmon/coretemp.c. These dr=
ivers
are written from scratch. Utilizing thermal_hwmon.[ch] for chips which hav=
e
already drivers in drivers/thermal/ seems to be more elegant.

 Stefan
