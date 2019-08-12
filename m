Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3034589C69
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHLLLd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 07:11:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:45515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfHLLLd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 07:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565608221;
        bh=+ophfXLwLk+afBtB/rZc1lujr07rFNbL1cd41/w8NW8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f4roB1GSu0EC7x8wBJIJJzCRhVE+r7l9qEGONpTMKMQkSTEJndIJ2DkyaySRdMbE4
         uC9PJmvvvDVY44rAP4mhUEhbd6yS6DULQFCqTgWMHk1WzoptJjKWINn9+4FYbWeiPB
         4Lk5EAVgpctClPLFIg82nvB9GZGBFnIiJrswpCk4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.152.193] ([217.61.152.193]) by web-mail.gmx.net
 (3c-app-gmx-bs80.server.lan [172.19.170.228]) (via HTTP); Mon, 12 Aug 2019
 13:10:21 +0200
MIME-Version: 1.0
Message-ID: <trinity-a6c06411-16d3-40ab-a4fb-3494131c8ed6-1565608221532@3c-app-gmx-bs80>
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
Subject: Aw: Re: [PATCH v3 01/10] dt-bindings: add powercontroller
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Aug 2019 13:10:21 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190812102035.GH26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-2-frank-w@public-files.de>
 <20190812102035.GH26727@dell>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:nmdxPcpv1uAOSEOZCdIb1nl5oNguyNi/HmeC9XNP24VaugxXHLpA6tNoOAQIMo5Ml3UaJ
 rcZhVH+eXTXdQH6ssIrYGfZcT3d4yzf/5JkQk6WCFLvKMu8gB+B1ODR+edpsCxnfqhEEm9NEFI0F
 g4Ckmv50XbLP3/CD6UmQJoTzSbwzW708cDXF9GxXCF4wEprhYo1oGq92t+QFDy1dK0KvCT2W0Eoe
 uRg5lyq5dID/788y8Bk+kjVYTaJEes1YnZ7JiQtlL6YXF1YnqVrVk6JWvYbB7DIuRcQVK9/wyFTk
 Zc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DKMdH5KOymc=:wFlnzZoxQYlkTeKilc2o8z
 ZKPFO1aEtPBUtCYeEYH0JYWfXRncpmZa90VgSB/0Li6bsMB1bDCDnJzLX+s316Dyj19o4Yx5t
 WhXIsEglja9h8cl7hzoXfT9j1XlWHiHrlIWfUXb0IaEIz6nYgH6dgnHw+F8drX+7jTPYK6AS2
 +LgANMVZ+WAwDmggyHu+sLC4AwwKtxIvpcDptf0pu5h+0iaJp5RqOeY+OJY0WvoZKE4n8qG5y
 KYHYI8oB6pgJ9rMcJkp41EehcbnLa5zZGJgsTyu3huxkrokQ4EMHLuVvbb04jF4k5t/cRieNM
 TKWPjlcELVzCP7Xoemr8cPXR9TO4I4E32UovuH3qKOJ0BEZyLbQTSWmy7QAhmvwKpvIIi99sF
 iI9ykpe883a/ZB0UilkL9cTQSMD9KpZ6EAYbcbzdpeI21KWj2XOxtilSotJ/Lt+oclI8YqFPo
 bM6EsFZEPrIlLtOa7ssV+RcYLfOwncnOE5CjuiNANd/OeaCU0wncbxjt8oeBVmgux3+vV73zk
 Qtmx3BWz/unEnrNuv6wv0/QP4eWwRX9nxIBTI5MKJ8BxL3vx7/UUoYOVma4qHEnMoegaQWKyX
 OR8vXp74oIz89XgGc7OcKdx1UdmWcWFtaJ2EigBRrMJhxRkdkqiIfQEoBqjPYSx6RfD9PpIrU
 lgvCg8Xv5d/Az0oQHW0WnG/9tzpIjUhDNgsKPs54wtUAP6Q==
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Gesendet: Montag, 12. August 2019 um 12:20 Uhr
> Von: "Lee Jones" <lee.jones@linaro.org>

> > --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
...
> > +	For details, see Documentation/devicetree/bindings/rtc/rtc-mt6397.tx=
t
>
> Please use relative paths.
>
> E.g: ../bindings/rtc/rtc-mt6397.txt

Hi,

as we are in Documentation/devicetree/bindings/mfd/ it should be ../../bin=
dings/..., right? or ../rtc/rtc-mt6397.txt ?

regards Frank
