Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD08D6121E
	for <lists+linux-pm@lfdr.de>; Sat,  6 Jul 2019 18:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGFQQz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 6 Jul 2019 12:16:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:38535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfGFQQz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 6 Jul 2019 12:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562429720;
        bh=v/j4XiFKCPBK6S3apqY0k2vzFHqTLRdaz8I12SI1NC0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CJHkPYNHKpYJZeE8b5exv7hkag9LhEEk+oMaVu7xO2FhAqyFGWXwh1VMzFLMBIQAt
         SUzlzlLPzNa+VycQIqxK3jP7pFWAWr+3NfSKAIasrPtmMrq1Jf0xTkOFJyAUjG4ip+
         eZ/Fmx5yUrwrEjw564ZtBuE2gG9/dHoIoBaWeMSc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.53.41.182] ([185.53.41.182]) by web-mail.gmx.net
 (3c-app-gmx-bs42.server.lan [172.19.170.94]) (via HTTP); Sat, 6 Jul 2019
 18:15:20 +0200
MIME-Version: 1.0
Message-ID: <trinity-a4e5f99f-00bc-4e90-9a48-64dbc6ba9c08-1562429720701@3c-app-gmx-bs42>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     "Lee Jones" <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
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
Subject: Aw: Re: Re: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 6 Jul 2019 18:15:20 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190705212448.GB12409@piout.net>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-4-frank-w@public-files.de>
 <20190704204336.GJ3692@piout.net>
 <trinity-7b1977bd-252b-4482-b708-cf704a9d3da1-1562340946396@3c-app-gmx-bs68>
 <20190705212448.GB12409@piout.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:HL+BGyIiUKA788YDI9SjshqIgoMva0CxAoF0FNbmiWgikilC3yiUX3XktaeBDjK0IKEwF
 M5OzAzR5nw+t+4CRs1I9g+sSK9MWMfSk/mKhmsVI5WIq/vtS3pVX1YuGkdLkf/v3EPW6LKS0H0fH
 MEGQbEULdeuovwyZr1yP9Tpo/P2sY+g5b5YLZja/sE2f9jGjj/jjGqHWsp1kdhzEMjXYJMc5vSNc
 dfl7xrTKVwXPYNGVBc9EZLwMTCrtuqST4Fgc+OvmRPpC724OLngAkRDCyKKMuFK307+DLk1V/cdV
 FQ=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dyLM7KxLlUY=:rEe9h1ie4NZfHvWUktHHgZ
 wGYyOhfZILpnEZ9Mc5xv/j/t5C7oJ/KSAvlrJYU5WMOFIXloz16TCcbtXrc+MXq5y+9Pp0yWn
 /fcu5HNIpjz8tXE9yfRZ6E7xrDRaCCxo66a0w6VTfpZypL+UJSarOf2DvVSf2GqRaFmXlPB69
 WNCtysh7zssF8h3itBz5jY/CtpUPdiL7ycY4Pgh37j0fDS0fn7nM8v2TR6osYKCBYrdTeFjHU
 HleenrgDa8iGGTiYyHUWzXCdNO2ppoUKiHnTSpBEFVXFxP7JIwvekGpFALoE3aRZeLT+fze9T
 4T+8fwwqzV5OHA+UJgFaHnCzgJr/NqZEvJb6bDNoeGi1kgrD+QBn7Vwm7dZQwKMsoZ9agtiA1
 +tPco/SEoeaAUgsQnmaIlPA6tUzYFTxuRbQqMYzOYDJWXtyxplXDcLueUlMvtLPYZcGQZWBME
 JASBkNFwFm4MjMeu5nzlgUuw6KDoyJm3cINY+DPewJc51PjyO5puYKREvSFnzKMKIfSsThaxN
 L1nE9hTZGtGw9cq4Npn6TC4mZFzVBU/P6rQ72e683HS4W0hRjzlmKxB7DeKv41qFQPhugeZFQ
 wlQRAG8d1atCBJ+ncStUtIuL8Ft/x3w/oFsEkK7VO6aTN5lyXftWeNXEqGPd0FWxquNe6FOq7
 UoSo=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Freitag, 05. Juli 2019 um 23:24 Uhr
> Von: "Alexandre Belloni" <alexandre.belloni@bootlin.com>

> Let's say the RTC has been used to start your platform, then the irq
> handler will be called as soon as the irq is requested, leading to a
> null pointer dereference.

i cannot test this with my platform, but i have changed it in my repo

https://github.com/frank-w/BPI-R2-4.14/commits/5.2-poweroff-mainline

> Yes and IIRC, I did comment that the rtc change also had to be separated
> from 1/7.

also this is put in separate commit, can you take a look before i post v3?

> Also, I really doubt this new compatible is necessary at all as you
> could simply directly use mediatek,mt6397-rtc.

imho this can confuse because the wrong chip-name is used in dts

regards Frank
