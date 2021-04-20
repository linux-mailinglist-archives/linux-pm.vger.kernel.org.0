Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC66365BA3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 17:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhDTPAV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 11:00:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:60619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232861AbhDTPAV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Apr 2021 11:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1618930770;
        bh=xoiOmaCVEtpySRd04IegAG0BxgeoJmW2GOsRSiidCZI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dK7Kl+Y/Er9+jMoCpe/4bJETi5ggUrFtuMujRHCt26QWgdKJkMrefZfFZ2P+bWQoT
         B1W4lTQaoHr8TE5JJguvnodz6rAs+PD3boH1DotHu9w2sCW7DCepdKPQX/FPPRn7KR
         ZF+e4ftL6dShxTSCXohtrQayLiHKfPjaIoj+cavo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.245.77.151] ([80.245.77.151]) by web-mail.gmx.net
 (3c-app-gmx-bs72.server.lan [172.19.170.208]) (via HTTP); Tue, 20 Apr 2021
 16:59:30 +0200
MIME-Version: 1.0
Message-ID: <trinity-4a3f024e-c01d-44e4-a884-530135853d33-1618930770250@3c-app-gmx-bs72>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Aw: Re: [PATCH] thermal: mediatek: add sensors-support
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 20 Apr 2021 16:59:30 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <f4329b1a-02e0-aad5-55bd-82d30a38fc55@linaro.org>
References: <20210320080646.49615-1-linux@fw-web.de>
 <f4329b1a-02e0-aad5-55bd-82d30a38fc55@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Y9ij6feTokwdz5MXRa5sZkEb2F+ct43zXd+nTvnF05xVHLjbDkTKBK5rPvKncRn/st4KX
 uMKyPcmYPW/TNB0Ml0XFq5YN8HPKRKCNC7li1V09gwh9Mhg1OIY+Dc5MPxhmbormWNQbO2/CZw+T
 v6G41ozqEjBwMRzTdscvZXlNZ7DohpQ2Ix2/aG+sP8wMPja2eZZyfmVm4ARhP44lUXU3/ioOburd
 TgmeiGPrOzFugSUQhTXCXxAndcBzVMEyw9ZWFkIbtgbFJn1e4w8rtVIOiYkL1JniXtl55eNJQNHT
 mA=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZbkFrIIWRqI=:KBVzZ2PKpAubc0ZbdBDcgY
 DL/6Djl5qZ3UUTI3Q4fvCWuUdgkuK3cJT1ooGXUAOMh4jdvxj+wvUfsgcyvUwjBIVqyrRRByc
 rGDinyWraLq4jhtF8jI8+iIxahtqjlro6X24jsnHRNIRqoJDCVn+cP/QrrtWcJ3k2DtcXUMbI
 erJDUZ3bI/HK+PgmuSFOhwWiNbcWXFI3/O0mFZmdsyC0KmWpw+5qbYnqNFI7pjuCbPIdYU5HB
 bBilC+IOGpxN051rY4GzaheC/dGyLbmuaIQHUsxm1O5oFBxcecfDDgmAeYfATTdS5C2xIiVO5
 ogqynYIBG2RZNtmUowCZERL7fpwLxqpDfqgDziPwTC5od2cvZPGSBc7qxIh725Mqf6clKnizj
 owyMNLXQ87GCgz0wMHPIHBJa/VLaLFa8yMoHHkZwpEo7vDCwqYws5K5KQ6moN5pwWDpS+iBax
 +aKRJ8PXxra0KhowiWsxksnyOeuWWJErq0+3A9SGCu9P3PUXVAUhyJ5u3I2/D2iGLsXrA0wTQ
 dffr8+WHUyRHv9KbU5BaNBiVEqqs2SNsWuG8K9AaQBmZ5icFqxl/3NdDNCKBX9t1JZ2gmsO++
 EB1FqMOrlq5LhP3u0C9yrgyn3BaICLtdpqyPJ8f78jABpGgUP0+RFpWBdGjH1s6/C+ccBhI6S
 822mVlCU8CJgZnC30xL2D3cvcya3oWbLmiDKPl6/fNDoPVWbKmrWsWeuAhZYgqg3g6z7qOWlM
 q3QZpX3KPpUa281d77g3NjvTFyacQWrXrm4k22FLOViCfXim0gEjIsnY918Os8i/40zeNh8aA
 TsO6YXtk07Yxo3wgc1u5G0GFMsShr0yQBz8bqRKtHqvHN0lv/+J1vtWVwgmGgh4so/IERQa5l
 G9ZrrXXHAyj1edbORVpo6fUq5IaR7HNKlE3noaZPmeVgmBCoQjlt8aPDlWCnUUDG00PHTbBdP
 pcak/jXyFsg==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

> Gesendet: Dienstag, 20. April 2021 um 14:07 Uhr
> Von: "Daniel Lezcano" <daniel.lezcano@linaro.org>

> No #ifdef in C file.
...

> devm_thermal_add_hwmon_sysfs() ?

based on your comments this should be enough/right?

#if IS_ENABLED(CONFIG_THERMAL_HWMON)
    tzdev->tzp->no_hwmon = false;
    ret = devm_thermal_add_hwmon_sysfs(tzdev);
    if (ret)
        dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");
#endif

if yes i send out v2, at least it works on my device

regards Frank


