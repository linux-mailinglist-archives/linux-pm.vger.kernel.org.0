Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D2AAB52
	for <lists+linux-pm@lfdr.de>; Thu,  5 Sep 2019 20:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfIESl7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Sep 2019 14:41:59 -0400
Received: from mout.gmx.net ([212.227.15.18]:33667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732033AbfIESl7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Sep 2019 14:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567708872;
        bh=M1UGnPJJ+2VuEq33S0TdraaobxmDCqcrUAEKeQ8qQUs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZUbcaI0T/PtTrufTRwK68S574RNG0IIdnpXj1FAIZ5Hk2GJ9INr7/CPWoXQf98mlD
         xqb1bKKYrkuiba88qXFMUIdcc0HdiT3JpXBB3hoJKof64v9bk714UXkxmhiRfaSz0T
         7fTJq/e15prco2OCp2oJY6DJpfk8h7K9eVpIydPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.90]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9Jss-1i125G274g-00CkFc; Thu, 05
 Sep 2019 20:41:12 +0200
Subject: Re: [PATCH -next 02/15] thermal: bcm2835: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, miquel.raynal@bootlin.com,
        rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        eric@anholt.net, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, mmayer@broadcom.com,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        matthias.bgg@gmail.com, agross@kernel.org, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, talel@amazon.com,
        jun.nie@linaro.org, shawnguo@kernel.org, phil@raspberrypi.org,
        gregkh@linuxfoundation.org, david.hernandezsanchez@st.com,
        horms+renesas@verge.net.au, wsa+renesas@sang-engineering.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20190904122939.23780-1-yuehaibing@huawei.com>
 <20190904122939.23780-3-yuehaibing@huawei.com>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <ba19c083-3c86-eaeb-c071-ea96c2e0dd6e@gmx.net>
Date:   Thu, 5 Sep 2019 20:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904122939.23780-3-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:WOmrGoYt2aZLE0c0r9K+/VJMXUNzvW/kX7vmvJXlWPXzYW5NR9J
 luyrP+5HUxX+Ik46iIlejCplMa2am5XS0NfLLQ7ZhlXmasy18+i/OA5VoR5aEu1/yVdmVn8
 AN3N1d8lbnA4HPsgXXRyGpNFweFZlAReZpmXxwXL0XGXKC31gFW9I6jO2SraUQgZg8eu25p
 foqc0kdcwKEMp61BV4kvQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nkW495xtuv4=:tTHYYykyc8MeFH8VYXAtPV
 1oz89eAs6J4EKmXGB8jywzeB9Rr+HNFXREs3+bl+7MUrhT6Tb5vvEZikpkfN7YcTYBM8A3ZVH
 n4yQa0u0tAnwQxNBcgEVMVosn+/mze41K8we0bObWZxZnDx2pz3YHKwLh/kXBAuFm7+0Rk0Vz
 yZS/73BjtleldpUL66iGqoS9Kj+dBB99d7VSTXyev99g2bS5AtTKgTzYAA9qHIzpXlHp1Snis
 PEOX6R6c/BcoM0LLyefpTFEzY1NY3QGc+6StuImf16b+OmrPPtW8D//puDVdc/ayO1z9cDfeJ
 2PL2gEH1o2MNxNBYTWlBwD8J1tB2j4dcJRftBAnkaqQ85Gnn8YFcAPxPDuXAvIsqLzV5G839e
 t3N7LgD6zsHeAv9bVTecZjXBHpH+dyf2hYb76M23xIsMwiP5LM3kDJiED61MjNEaWcX8zsGfm
 RP9/VZQ1volYqm1DX5jdkWLrIHvMus+bGRoZLYL2Q9xS0OD/7faZ7Od2MonlHbOd/NL+MJ3aS
 5RkRJ+DxwonIs2MCGlaOei4aS36r81FmO4qEESDkxqF7tpHww+f3zGTyKOB3NihhKihqYzL13
 pQeW9GaJIbB8jiwxFakYjSp6Ti/3DZcmc/zXgV5bm4FDgyFgUYqnvUq3AK21ur7WXKI5fAqot
 Xp+FknRGP5lTeyZZ8CsTu46mC2ZzJe50IK5pF1sJhsgLnol8Y4rFGBC1lImxkwgaRFmMvOeRg
 6p+CY4LmFMoUcXfgsv0n8F2h8jtRus6M6jswi9Gt6eu6xOMsMZF1AaYL1Pa6igzbvRrJfwzU3
 yvScYds6ExX42p5vtUeswaXEf/dgE7K2xM8NN1px/JV4fBBYzPPjOzmp/BbOs9ZB0h6Kavpz2
 XAzYn0SJ3Kktzm96QDIc1dqXs9MM/Zh8VYzo8Lc1dT2USxJ6AR+QdDrz6sYDuqhA5BvZrwKSy
 1Hki0CKIATnfugQVT9araYuKn4Cva/enmNtmVQepcuvmixrpK5w/zayiST5ToOI9RpIl/vvB1
 S2oeaSoQM7cpO2Yea2NVgSizipQACekJixPec4JSuy+Yu0VZ9pg7o8EHw76mY2MG+r4CsH0qs
 B+wYJGsCbNNnemavOVy5pwJLAavhQyNzEzkaNeSVbJ8Radnx6JSvwpUHT0j6Z9CbiyqktJXjm
 WAkFtcjYEqCIzTorRGlhm1s0kDMdvWQ48irGv4jdgqqjV0BOUzFd1PFWfxdVIEj2oCItAhZRO
 +wNSe5aKqpNdFgJlAHm64qfczlAf/2dRkGgFKifPkw02mAE78ADOPFEIwwUDxgy7aWF9pxBsk
 BkFDWVHIRO1pQHw1LJYrmWliprIUaSrvL2WGAhCqiZ5p3ie7wRrL1uTXOP5q1jDcd60a/ptQS
 HvdmAdVPs6xsOBeK0uTBLtNTJ7JT6bTKcckdOw/FyjzI0O9H1+fEAqb8MkMB1wRxp5QtVQcZe
 nWoFCFDA87OryLqTPF6kHOtM6PdhH/EI8=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am 04.09.19 um 14:29 schrieb YueHaibing:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Stefan Wahren <wahrenst@gmx.net>
