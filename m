Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2F2865F9
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgJGRbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 13:31:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:40575 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgJGRbJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Oct 2020 13:31:09 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Oct 2020 13:31:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602091867;
        bh=gStd7CSr+9t8/90lKMyO+IPWH1Dnp3UnGNJgZmWHkzM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QCDZ714hsvbnGuh7Ey/C6xxPNnrlVRxMPZDarIW+uJfcob//j9m2MYBqVkadyODrP
         /iMX+KBzJW2HLVxpSfXkAqUytbosRNqH69ljrqc3r0wjp3to2N6ivZtO7EkHANoJrS
         NQjXwo7yvZUG8xM7ntn2axfcrptOgJ+7tCrxVZ3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.210.121] ([80.208.210.121]) by web-mail.gmx.net
 (3c-app-gmx-bap48.server.lan [172.19.172.118]) (via HTTP); Wed, 7 Oct 2020
 19:16:34 +0200
MIME-Version: 1.0
Message-ID: <trinity-45b0efdf-27a6-4b91-943f-c3782c637c0e-1602090994397@3c-app-gmx-bap48>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kao <michael.kao@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: [v5 0/2] Add Mediatek thermal dirver and dtsi
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 7 Oct 2020 19:16:34 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20201007075437.6002-2-michael.kao@mediatek.com>
References: <20201007075437.6002-1-michael.kao@mediatek.com>
 <20201007075437.6002-2-michael.kao@mediatek.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Csqd41G7AKxDFuH1C9SuyrD5jWqGjY8u5x7tZCZfuaePzhCmFah/9bWtJBjB+9cchHYoy
 HvGlmXK7xp4TcX0XMJ7Th/1qaq+UVDkk6iVl+5Hep6tJSCTuxX+fQpTzRddjK245Qx8AsWhSoGgd
 dN+cv0TMip0SRNyvEjmCoYAvYjelIYolj6sePUq4FUbMYKLnbiWDHq0XIcC9hle1K2QLKAmOT+zU
 BniDlgIPOqfeLis8fVZ+yMaLuqqy2q6i9MiWVsPTr++2qpqS8mlRNAauD75xKsDP2jEyaw+Gb/fN
 xU=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FOhYxd3LrBA=:AAmKeHNualD8W2ZgdqeDJf
 paIZM1VccBIHD+Jh8HZMK8iuX8hCJ5L5vrBRFTjRfrtZ21do0V6l4JGSSAYkIKDRfKrUv2NkD
 UohwpxWrh4DTp0XyRvTDZNwlij1XKOuWNF/jPT1JJnf6wSIy3AdIp4xmsrC0vCR8ERfl+5V33
 BL5P1UCo4isP4GejH1145qQ7tanj6oXjn4RI9ru84NLdwrS2SAD0HAJkgEntGCnyQeZJq6O54
 u5jURoftHEOQnMNpM3qApWFywhMZqgeDjoUDxtMxCtlIAHRl2xjDeoiDnysC6VeGLZ7mP4NDi
 y4MzxCNEeAkLcwMFDl6kROidVZuIol5+/WzpTrJ4hjvCdq6kS7hDUyZYy5ThTkdjSlafrc9/w
 +EOCzmbp0hbvp5gvUGK0qHhTDLwzXObd9f5c336shBeIeiJmlSA5OLAtpe91/Slhj232fr5iy
 qGyEzcG2/3I1di4mlp20sbFaoXaaGf9Ls7l+zPQzO0zZMkmN22bqO2ofbOQ/j9Phx5CMMz0QN
 QzvG/5vcFUeo6QF32HRdnRICyJYdSBjCVXxioBCtJJixZc/WSvReeD9SlBJJa+HHu4+luWXqN
 qKNPe42vZHf4k/Z6K77wgNSRfqlXR3GSnyUbgXw2H3skG9SUCWF/J10+LHPaqNmYJVFFBD4OY
 wm11Cdupl2YgNvBsCocwzKl38+oN67x9xrenG7U6hnTpbc6ufCVhMusEbu+7I1QpADZc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Mittwoch, 07. Oktober 2020 um 09:54 Uhr
> Von: "Michael Kao" <michael.kao@mediatek.com>
> Betreff: [v5 0/2] Add Mediatek thermal dirver and dtsi

Hi,

just a small typo "dirver" =3D> driver and coverletter (v5) does not match=
 series (v1/without version),
so it is not linked correctly in patchwork. I guess V1 is the right here..=
.
imho coverletter should also include platform (mt8183). There is already a=
 mtk
thermal driver which you want to extend for a new Chip.

regards Frank
