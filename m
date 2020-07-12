Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5FE21CA99
	for <lists+linux-pm@lfdr.de>; Sun, 12 Jul 2020 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgGLRRM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Jul 2020 13:17:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:36651 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgGLRRL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Jul 2020 13:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594574211;
        bh=M2koFojxYZHpRAK0x2WQcPQc3sv3CjqDJzdHS3xYj14=;
        h=X-UI-Sender-Class:Date:In-Reply-To:References:Subject:Reply-to:To:
         CC:From;
        b=DogPUd0g/Xo4tFUVHW7YB3R8cyR4qGaHP+vv+gWzcJVG24kMcr14Vww6tQ8o4cUZI
         VR0UhMSQbzvCWs+mqF0S4nGIp3XwfFdnT0qEsfmfHiDjl+6dYUUwUhMtcm2+tl+S0q
         DgRKlk93b/nhXgoacjvBXhrG6fN8rNjepPt0X2ao=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from frank-s9 ([185.75.74.1]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1jufas3Myu-0004bk; Sun, 12
 Jul 2020 19:16:50 +0200
Date:   Sun, 12 Jul 2020 19:16:43 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <f9c3cb16-ef6c-b7ff-6832-a858cb2c9b3d@gmail.com>
References: <20200707103412.1010823-1-enric.balletbo@collabora.com> <98369dbc-2e2a-a1bd-f3cd-68f33f66b882@gmail.com> <f9c3cb16-ef6c-b7ff-6832-a858cb2c9b3d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Revert "thermal: mediatek: fix register index error"
Reply-to: frank-w@public-files.de
To:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
CC:     drinkcat@chromium.org, linux-pm@vger.kernel.org,
        Michael Kao <michael.kao@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        linux-arm-kernel@lists.infradead.org
From:   Frank Wunderlich <frank-w@public-files.de>
Message-ID: <F97EEB5B-958A-4CA3-A3F2-7668B8E778FA@public-files.de>
X-Provags-ID: V03:K1:mS6EkSIZOrghNWC5/SoCGSYcpQLUuJGPL1lv6FDvjKZ3vSgAhWI
 BoxxaAmyLLri3QA4FRCwXpRFwYdxWw/SkIEdEMQCjFri9SEA0fKL/fuT+pQ14zircKQ7iSX
 QaRZ/Uu9sy/7rwLrzWVsf6hnWK0LFJa5kHtC0KMdSLN5u2iPY/Dc7LPzDmIPy+kphwrdAgS
 6csCl11UWB5pslnyK1sjA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HJNgiWvLWzA=:nnam4Ncd9BQH2A8XBPDYYC
 yXDY4h7e5EexShz33mvZYI1NriBhQL30tV3iuhqmGNiPeN7j3si4gQ3K33R7NXqFVthOqsYCG
 QmaEMCqwak3H2aDJiN30XzyYVhI6chRob4Hr9Nhitig66S5+rm8BUtl+4FIXUZ7F6QQ3fv+eZ
 RekOFNSH/69OXYk2Ijls3E2ntSGEAB7m90dolCJAtesp7hvqgSxQZ9LGPyAHRSkUoScuCmLxX
 oZnUfxsAG/ajXJM6UUIurzxqHcVypPeyP90PD3x4imauCbLm8SXraG2KFvfa8boHbuTizas9X
 zhuf3FU1CHugF96moHlsOm6yLtLIbftRNpYS3IssxwfFVy/gnYoUtSmIzA4HwZ1+Fb3DxHF4a
 o4pf/3UQTwU5o/B87q7mcRf72fzTeyIZgFT6uhYgXEVcfnhsey1ESVFKyLkWh0rCT91UMIbPf
 iTK2cp03I2/fYkIUJeh2PP9OSGqd4Xj62KoGJpYGcc6mYKcXenN6dbwNNMq1C6O/xKtLSlhNB
 jjV8Bzd1p3bRPYl88Dho3wkZOcS+IgUhpDUMTpsjOJH8ZelrFeyjjMacry8D+RD7mFCGqt7+c
 EXKJxVXBneQ9zXm0E5ZyAb3cyeTtsSIkg4gfDy57jWmqKHLJIVXMV1nUG4i/jptveVb2mO54/
 W7Q06769OBF2mhPre8BZmnQCeXcxtFiyr9MLK9ZXRIxSxKuOcT+6LbXajd66QU463D4DT6Yne
 +0n7TaB9rjwqQWFn/17lOxc4bA/Jks+Qyo5kO2VS6P5gYOXDUAD4jCTaiTxZeedMaDPovIQqu
 VOXc6LAL0PYUt2sbo+/q7p0TAY6tb9YZn8ElEl/UmEdthoWYK29mK5I3yP5fCH/wnTZehrO6h
 SJJQPEdQUNhw9GrF7LyLLRjPtVE+IAeJ7P2Y/9CicWZb1UJ1W/mUvj1wsk6cgvqbHywP4MEEg
 xOjftfGRSF9LlyxSNpKm9NRgnsqMzNU2R92Ze7wxzPSGLcYDQPCj9xPB8pQypSqkqK0CEV40p
 OmOCcBpewpnPTh4GKEhvXxBc2Mj5qryva5ZclDxwmst3Jcu6v6ncjELEmCqBbdqK1CYoZ5rlx
 0spiylqnX09IeMKt5TlPVwFYvBjuZ9k3BURy1uEr1FhvedpLH8z/pMgLRJODVlgCCaAx+nW3Q
 aQPv5ByH/S6979+iq83GfENY6R6oHvU7uWgKLUAlp9pfTOb3zFYh59uTzOV1hkj+aZPjs2jkF
 cu8P+i0uTPsTv285buK01icUGJUZ4Ao8DiyR2jQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



Am 12=2E Juli 2020 18:55:41 MESZ schrieb Matthias Brugger <matthias=2Ebgg@=
gmail=2Ecom>:
>On 10/07/2020 15:58, Matthias Brugger wrote:
>Even more interesting, with and without the revert the
>thermal=20
>sensor returns always zero, so it seems it never actually worked=2E

The thermal driver works on bananapi-r2 till 5=2E6=2E Something in 5=2E7=
=2E0 breaks it, but it's not caused by the reverted commit or the revert=2E=
=2E=2Eneither the commit nor the revert has any effect on r2 (no crash/erro=
r/functionality change)=2E

Additionally there is no difference in mtk-thermal=2Ec between working 5=
=2E6 and non-working 5=2E7=2E Thermal-merge in 5=2E7-rc1 shows also nothing=
 suspicious and dts(i) is also same in relevant parts=2E

Maybe anyone of the recipients have an idea about the broken mt7623/mt2701=
 functionality=2E
regards Frank
