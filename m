Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4966589D3E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbfHLLjB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 07:39:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:37675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbfHLLjA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 07:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565609876;
        bh=cqTzwEWo2DoYlZe7Z0sB1ny2nOtt1yNZ8bt6W3A1KII=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SHtmwssOFA7m8ncbj+fKxg4+NldWg44nOIZudJyEmYYfzmraAQiiAFMqUmEF7SkOC
         CvPMkkHknAz2so4e/Oiz89+hZBW9KpLinFdMz5l/3KmrGXybOP9325tSyPjxhH7Ij8
         NuW2hD0H2kzD9LTusmNuSoZdqRlnCFBDKqOIhXXg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.193] ([217.61.152.193]) by web-mail.gmx.net
 (3c-app-gmx-bs80.server.lan [172.19.170.228]) (via HTTP); Mon, 12 Aug 2019
 13:37:55 +0200
MIME-Version: 1.0
Message-ID: <trinity-738d59ed-ecac-4025-a729-0888eaea1f95-1565609875829@3c-app-gmx-bs80>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Lee Jones" <lee.jones@linaro.org>
Cc:     "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Allison Randal" <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        "Eddie Huang" <eddie.huang@mediatek.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>,
        "Richard Fontana" <rfontana@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sean Wang" <sean.wang@mediatek.com>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        "Josef Friedl" <josef.friedl@speed.at>
Subject: Aw: Re: Re: [PATCH v3 01/10] dt-bindings: add powercontroller
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Aug 2019 13:37:55 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190812112507.GR26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-2-frank-w@public-files.de>
 <20190812102035.GH26727@dell>
 <trinity-a6c06411-16d3-40ab-a4fb-3494131c8ed6-1565608221532@3c-app-gmx-bs80>
 <20190812112507.GR26727@dell>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:rorlieaqUDCjznq/tycElIF6v/GTKDuIZAUVviT+MmLqGw0eg4RkqZ7ycwz8b8lDdV4+O
 2TVUoeCUbv0y6rLGfW46rV272fwlqbSJCMfmM9T11BdNY7qytID/LYU/aj5V3HEiQIOXDdtejNmh
 D4lAYBCcbSo4fblFEtXcioNffyMD/cw2g3ibWb5CicM8DdVgulUL56qIlILE5iCgLt7ht++uYcQi
 gILb8XvcFlMgYLYkslMB142bpJ7X5lpUJuIc0+wP/tbrjSep5Knsj2Ml0HZgpjqkqCrn7MzQ4N7/
 Mk=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KAhLhdHEyW4=:JfL6yTj4iO6NngvcIzYiG7
 QjaNkg7fFf+twakK9TwhwslxomlUmSaVBcvwfsFDit/4YwtFxcy+X9tE4bphavqoHK2AaUMRX
 Gpq2T4Dy2MsSyjsif//ggHEkBvPHW9ZQsOQmfSEgJ9rF3c3+Svu34dq6rg3cd2dRQC6KAG8fz
 YNalJ9iYQQoUxOFE0/+mwHUtIgujSjnVr5dXmfDXLJPLyQhgj93uaBzHtm3EigYYowGXCV+bn
 xmkl2DCjW0PrleBNebXYckjIbb7/MuifXCU9WxBCA02ooV3ZNctGcca9pH629Zy4+WFEj2CpK
 o/swOjGaY96QYPT+bRm8DsCLCgjqQVG1NlYEzUoMcn43TgH0K2CLeXsiiFzSE1XEj+aqkbbsp
 hGlB+hj+i1uQ1IRY67enjsiuQB6FmXiEHV6kRAfRQtH7vggot4Vw3f+XbfzCGr9tha8+C/7c7
 JgKH2a9727wcq01Q96EuCaUR8SAFb7hcH0ry17HgykirMGKv7kgASPp8DvKjOahAQwqlriXlb
 k6z26pdIWqwqNFPgwMV/3/dJkC4Rey3pr4slWt5s/opixXZDyJrAkDSvcd2jn76UeUOQsd3az
 0p+gPDD93Oy4F1I/8MoQXHFdSd9K6l/9ZRS6KpRJnrz0ehn99uKqhDIVE1fCE9qrDq8spRGqU
 Lno9HoEwStbEYpRgXyPFDZvJ79YoecY5veO+A9EZyZZ/cEQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Montag, 12. August 2019 um 13:25 Uhr
> Von: "Lee Jones" <lee.jones@linaro.org>
> It was an example (hence the "E.g.").
>
> You will need to adapt it depending on where the file ends up.

i saw the e.g., but i wanted to know relative to which directory ;) your e=
xample mentions that it should contain the dt-bindings-folder and i think =
it should be relative to current file...

have applied your suggestions to my tree

https://github.com/frank-w/BPI-R2-4.14/commits/5.3-poweroff

please take a short look if i don't miss anything

regards Frank
