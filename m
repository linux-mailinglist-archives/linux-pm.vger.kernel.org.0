Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7C5F710
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 13:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfGDLJr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 07:09:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:51253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLJr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 07:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562238524;
        bh=xewwvH1K14MpwmyPyoSVm3soCqhRG4coEguzC5XFyRU=;
        h=X-UI-Sender-Class:From:Cc:Subject:Date:In-Reply-To:References;
        b=F5ztQ6oLQDxWBeKJRudGw4uO/Od6NHcZR42iKjQZwFNvXMU1LDkJcz++vnGjhGhkT
         rhKPJAk0CjVGVx6E4KYrz4r/6zYDVOF8Z62oh4MlWCmTeJdmMyWg6nyBRNPHdnNkk6
         4qALyoONjlAPb/+iANBotiT6pDWpFqR33aTqbqDk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.121] ([217.61.145.121]) by web-mail.gmx.net
 (3c-app-gmx-bs27.server.lan [172.19.170.79]) (via HTTP); Thu, 4 Jul 2019
 13:08:44 +0200
MIME-Version: 1.0
Message-ID: <trinity-bad65b37-f133-4f92-9513-965ecc0e0a0b-1562238524435@3c-app-gmx-bs27>
From:   "Frank Wunderlich" <frank-w@public-files.de>
Cc:     "Lee Jones" <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
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
        "Josef Friedl" <josef.friedl@speed.at>
Subject: Aw: Re: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 4 Jul 2019 13:08:44 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <24975910-cb06-7faf-998f-def23ca0891f@gmail.com>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-4-frank-w@public-files.de>
 <24975910-cb06-7faf-998f-def23ca0891f@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:jnRruknwXBDel+OIwmAlBlpZCo1GUcWSFiGCMCvsYCxnT6gNPN47MfQ8d+npte2+5ba3C
 pK6nsUiE1pbreDN5g7uwxCqoVPtzGFjzwnicn7H2HiakjJVH++0nWUZcvMTNbDw41XYyfHz1rvP5
 tyG636rnPhcTQmqemF8FuioIckboC/V+PRYo5xPNkhqnJzTMPGV8c9mOlJm7mL9gNnKhsJ51sgaA
 F2utj5iZ0sWUH8hx4axdegf1shPw2ITfHHB8OiUIm42I/vflDVjo4pyNj0d7P0Z8P9Qmr9ogiFQj
 I8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5dO1uuC4GHI=:HuT9N7g5VLRtNrhu9OZLWM
 s4oHLi+F4JnZ1iuiGNv5fWp6Cawu+ZAFh+3ySZ/XyVDWcO/IoLj6PmevaQtIHibcXyMfldhFr
 H774L3+0s3jPi4KGidGirvKsHonDduG2z+L3Hn5rHCEArBIdknXuOxWNhrmImQjNPngJJeLcN
 AJAbSiX3wEcJQeshB2wsEWtNRopMrBOxtJZbIFBfnOPeRwwo8DEuVkaCYlpp4hz+0/zfIXXQi
 C97yBiCjPLdCIHjsXZ5FIKvjW49IX0pBxKczAEpkfnS2I9CRZNj/n/cISuJ58TiX3s4IcsraE
 +cxkjIKRljQ8Hva6SIjS3R6dPeEXAgsIsIxHYoGiSLg7IjKggeCViPlkbocioMjnsimIFQC1V
 DuNLmHO4HtIuuMWPuDlM7liEmbM9toxtmxxrq02GY+5zxJjdg/CN0JjoKEMogwcNSvPSUJSQ8
 FAKuYh05I68HWtL6BpvPtIfRieUKWEh7fVgNqET3U5VGelkjd5RuHrVWi6gF+quRLHFZdKXzx
 dRRAViLmvut6WTLCuFMLnYaIMCg7WkcaJkU0Ca+zAJNai39ND4MXdE2mvPGhy5qugJUijobm8
 0iieYHmAd1P9kqyoWbTqNZhVd2cK0Kh6doCKz0cYxypBjEwSttY0c7BBcptAgDVtFMz7wJlco
 CaQE=
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Donnerstag, 04. Juli 2019 um 11:13 Uhr
> Von: "Matthias Brugger" <matthias.bgg@gmail.com>

> It's up to the maintainer but I don't like patches doing clean-ups together with
> adding support for new HW, although it's a trivial one here.

i can split again to have clean-up and new functions separated
