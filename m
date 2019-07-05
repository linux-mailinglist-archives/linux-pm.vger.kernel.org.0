Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990416096B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 17:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGEPhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 11:37:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:56819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfGEPhP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jul 2019 11:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562340946;
        bh=+xG973BWcEz2x94VZcUAPePu5GwCe5fwDn2xc5iFqo0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N0/iBvJc6HtX2nJ4b7IPEhJQHze0yGnFVfDsrmD7ZCrkY1o/NEmt/GfIh0sEBoPZk
         pUwgP+xFM6zSWbqJykxww7GN6eLJ2skqyA7owjZiCfEOBg042cwWIgn7mjUyrBCEpv
         jE/dN7C0LP0estl9Ivtpd/Id2IV8oTVe4Tp9sxUo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [185.53.41.182] ([185.53.41.182]) by web-mail.gmx.net
 (3c-app-gmx-bs68.server.lan [172.19.170.213]) (via HTTP); Fri, 5 Jul 2019
 17:35:46 +0200
MIME-Version: 1.0
Message-ID: <trinity-7b1977bd-252b-4482-b708-cf704a9d3da1-1562340946396@3c-app-gmx-bs68>
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
Subject: Aw: Re: [PATCH v2 3/7] rtc: mt6397: improvements of rtc driver
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 5 Jul 2019 17:35:46 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190704204336.GJ3692@piout.net>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-4-frank-w@public-files.de>
 <20190704204336.GJ3692@piout.net>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:3DQjnrcP0qQkneq0N2KGXDypFxKC70Y6B/6Wz6gG83c+zzU8tPfyJ7R1HE1HqAXh3hB2I
 tgJSbOVBlcwfm2+5WrNhSjWxrIe4AmFQkfXZmEFAprfzxqChBFn9HnyAR9YWrNvCPuG17yU7Op4d
 ugpFGrIo4Tf+JcmINzOK23uQEhN2f8orMVc5A246lEDzSCXmCflOxlZ6PHU1xgJelMk9hVPkR8fZ
 DhVDomXvArd2HR4UT+Ec00/BFdO1KKd8+sxf1crLqLghjGrqQGEuEjQemQPPAcQJzokFsPSPjEgJ
 Ok=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:U5UYnBEkf+0=:lL1CL6XEoZrqJz8T2zwkL5
 4VYvmDYvZ5WzNABcDNBejMTkwRG1c67XpMAnjTSAn1VKRZ87YyW8Fes8PHzncewehLQUqaLue
 LVS2SFGPFzRxC0khTzvlus1KUr5oZY7QijfOK9hocquUSx+iHzpI9TDlAnmWe4UaoMF/42CDH
 WGqzSesYNDhJ7QrAjfxtUFBYbMU6YGR/80HNhJeKizPb9hMhw1PNX2FTuEKhB9AhTNWDwj9jf
 iz2TYEYzFWXqIjVYcbNyIpCk5fhnRvSvMFgGnv8nXdIrk/aesBOoI1tMC5dY47eKVhwcxbF3G
 D+sXhAC/j9gEmrB19oC5cSMkvSvUHyXuG49+ftF/sz8bwRecT//qfKlBN/CWfLF+KTKQ0W48R
 xrcCxWA4aVF7JhOIHm0iuSzma7jniESyMdd9UufoYSt+hBWPgp+BB9+EF6Ufu4+PeO1WxdTxr
 CO5FuMMppqZq0zy35n31R7Y7AqTSK4X0aeIIY0rtWO4BOnrtCnxD4Kxjj93N0FpJ/y3CWdPFE
 r2AHMveJE7FwuKD4IPTmai0ubwLDHQJximoqtKtj7ibjV+W5K1jLBN8QCGyFm+7WaavnB4il9
 jtB6YIWXJrrwvYpdopClbcSNQtobLh8iTwP4OAZnwlQXtwCqyeKBff4O3dDbmq/Ihzy05qfUB
 Zrmc=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Alexander,

thank you for the Review

> Gesendet: Donnerstag, 04. Juli 2019 um 22:43 Uhr
> Von: "Alexandre Belloni" <alexandre.belloni@bootlin.com>
> > -	rtc->rtc_dev =3D devm_rtc_allocate_device(rtc->dev);
> > -	if (IS_ERR(rtc->rtc_dev))
> > -		return PTR_ERR(rtc->rtc_dev);
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
> > +					mtk_rtc_irq_handler_thread,
> > +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > +					"mt6397-rtc", rtc);
> >
>
> This change may lead to a crash and the allocation was intentionally
> placed before the irq request.

i got no crash till now, but i will try to move the allocation before irq-=
request

> > -	ret =3D request_threaded_irq(rtc->irq, NULL,
> > -				   mtk_rtc_irq_handler_thread,
> > -				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > -				   "mt6397-rtc", rtc);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
> >  			rtc->irq, ret);
> > @@ -287,6 +281,10 @@ static int mtk_rtc_probe(struct platform_device *=
pdev)
> >
> >  	device_init_wakeup(&pdev->dev, 1);
> >
> > +	rtc->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
> > +	if (IS_ERR(rtc->rtc_dev))
> > +		return PTR_ERR(rtc->rtc_dev);
> > +
> >  	rtc->rtc_dev->ops =3D &mtk_rtc_ops;


> >  static const struct of_device_id mt6397_rtc_of_match[] =3D {
> > +	{ .compatible =3D "mediatek,mt6323-rtc", },
>
> Unrelated change, this is not an improvement and must be accompanied by
> a documentation change.

documentation is changed in 1/7 defining this compatible. i called it impr=
ovement because existing driver now supports another chip

regards Frank
