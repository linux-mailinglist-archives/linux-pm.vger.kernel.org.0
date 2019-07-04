Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 681C85F703
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 13:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbfGDLH4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 07:07:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:34095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLH4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 07:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562238391;
        bh=3Q3Rn9eFMwtoWE9WbsG5M7mh69YDe97bVxTE0e3XikI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hF7KV0b0k9MO0eCa11hhB84VgY38o1UgfP9XoXh9W0FL20Pofm4zFCT+ZBNzePkav
         14Wt3RXb6wCMRiuMJ24xQlcrCZVQDz+mjRj8Ls1W25xaUORUNpEHb2tJE65L+DPPpf
         gCK+VbLSQCBQKt73QByyxit3P0OMtOjDVZfn1nW0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.121] ([217.61.145.121]) by web-mail.gmx.net
 (3c-app-gmx-bs27.server.lan [172.19.170.79]) (via HTTP); Thu, 4 Jul 2019
 13:06:31 +0200
MIME-Version: 1.0
Message-ID: <trinity-03acdbbe-a94a-439c-a65c-88c9e23a0ae7-1562238391586@3c-app-gmx-bs27>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Ran Bi" <ran.bi@mediatek.com>
Cc:     "Lee Jones" <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "Eddie Huang" <eddie.huang@mediatek.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Richard Fontana" <rfontana@redhat.com>,
        "Allison Randal" <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rob Herring" <robh@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        "Josef Friedl" <josef.friedl@speed.at>,
        "Yingjoe Chen" <yingjoe.chen@mediatek.com>,
        "Ran Bi" <ran.bi@mediatek.com>
Subject: Aw: Re: [PATCH v2 5/7] power: reset: add driver for mt6323 poweroff
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 4 Jul 2019 13:06:31 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <1562234589.19751.16.camel@mhfsdcap03>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-6-frank-w@public-files.de>
 <1562234589.19751.16.camel@mhfsdcap03>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:vPbFhCphLzdAJgG78YBNH1wPbJh7oFoo8LA+oV36bAGkph3x/3EaLOXvOGXWjLu6ZuoCY
 1t9EybQy+LCu4aSmT+yUJo5gl8Ju4T8aDhD1DRZWAGO5rrBCojV17nj8QNVUS3FgBZoOB/x6EwMk
 drLnkkrdyxKyi0C5iFsbPEHAByrho90e2xWkGlSORq0gv/lot3Er0z+JFebfzw+jvTVy58qZ59vU
 OFGS3kjwGbj7yDISAqTouFNs/1tWYdh6AP0tfHE4RmZGo+FyPEmVTEt2HM39l5xlJ28M1vX2l6/i
 L8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gra07zN8xw8=:anb8VcMZFxuoE4PI1k2EsZ
 6A2Z2hjgSFeZ7jGOE6KrcZK9v+yo52ZoN0tlYxZOOKbHINVzp3poRWA+Y0klQCe/MtWS5Sz2t
 FFrWeA4bTFLT8Zh6YLDzz5McFFj06uC+BEhCk6+POvVdM+A1ivnLXs/zM9fEMzSu2Z1lOZFfP
 1g62Mmp+NcWh0pvZ3D1UHVuzeuIv2xmoaa6L5ycCXevI0/qtt9O4xdnayCMKVBGAV8XG/1/AP
 BSlGo6q9rPqvrLx9k8amtNjnzy+pULHb1guitUl/L36xWlRE6Mp/ONToGDNeLdisQoBlaPZhf
 EuJYuDwHhvZLwTEM17u5zqCuS4QUsUNyMHpjUqvel0YjuIKOA0iig4JPhQtaaxQdWn9gmTYWH
 zA5ssDqM8LoXMhR+PNKPCJshNNESr4i8h/kiMhApmBrrHRXKWAUwGcQ/A45734/Xq+dgU4RNP
 x3nB/e/z0rFDHVtQ9sfqqjpdC7aJ5VM6bGwJorkB+GmVpDHUuVpYot3U/ea9UBjQ6Y6WDb2dX
 doR+ISW3W5uQOZAvSnp4+1LbLmot8XyCaz8SSZj6/DgUIbT4Uhnu+i08F7zytFRlChd3TnWX1
 I3xq2GFqJbKREe56K8fPrPB2wqLCee/USnbdDcbyd6yAiWSR/DF3DlCZOKebkqIICZ4wF8Tv6
 YxN8=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Donnerstag, 04. Juli 2019 um 12:03 Uhr
> Von: "Ran Bi" <ran.bi@mediatek.com>

> We had implement MT8173 poweroff function in arm-trusted-firmware's PSCI
> plat_system_off() function. MT8173 SoC is using PMIC MT6397. (Ref:
> https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8173/plat_pm.c and https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8173/drivers/rtc) Do you think it's better to implement poweroff function into arm-trusted-firmware compared to hijack pm_poweroff() function in Kernel? Right now, we are doing the upstream of other PMIC chip like MT6358's poweroff function in arm-trusted-firmware too.

ATF imho only used for arm64, my board is 32bit armv7 and i (currently) do not boot up with ATF

regards Frank
