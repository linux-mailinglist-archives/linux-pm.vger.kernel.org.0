Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B031D5F777
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2019 13:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfGDLuT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Jul 2019 07:50:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:44393 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727548AbfGDLuT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Jul 2019 07:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562240946;
        bh=3XgfK29g7vLa/3fkH4yqnV5cnFE1yxc49nWYpw/CAjE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=knmHJll2oZI2vMmwAv/1ME4hVpqS0PWrF9Ii8PkJp7W5/sqfcY/qrsUAkKjVViwQn
         3CxBSzc/FCwAmnBG2/JJ/9Qcs9UnGrsKgur1158+rpQ4xA/L8ZOOZucSZQ+H3zoH/H
         r8/kl+3pUg6RVhZL4FTDAvNzcrsZD9G5hCVre2hI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.145.121] ([217.61.145.121]) by web-mail.gmx.net
 (3c-app-gmx-bs27.server.lan [172.19.170.79]) (via HTTP); Thu, 4 Jul 2019
 13:49:06 +0200
MIME-Version: 1.0
Message-ID: <trinity-cc209a43-af34-4788-8b7a-8495052c8ca6-1562240946454@3c-app-gmx-bs27>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "Matthias Brugger" <matthias.bgg@gmail.com>
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
Subject: Aw: Re: [PATCH v2 2/7] rtc: mt6397: move some common definitions
 into rtc.h
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 4 Jul 2019 13:49:06 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <62a4c4ce-7ab3-2f9d-a85e-be92340724a9@gmail.com>
References: <20190703164822.17924-1-frank-w@public-files.de>
 <20190703164822.17924-3-frank-w@public-files.de>
 <62a4c4ce-7ab3-2f9d-a85e-be92340724a9@gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:7WCJDoI4ExT7kJKMPI6fq7FNUW7pRNwLc1tUO/5cmP72zZnoBU2v1Y8uix/fw2i48d5FF
 Wd8wvTQJl1I2afIhS99OdBd4Iyh67OTcrpdbEQzhKKf6oNe+8evBVlNA3mdt3sLZ9EfauHTySxHm
 DPZWCXm6h5c0Phecn2JIbp8F6eSFLCyZzdI2+ijkEM1IUpZ0cT5dqCmnk8hPwd9Sd1EJDKwLDMdM
 fnT5RJ/tuLvBBpxa3bA56T8T1C/9SuiwHF1TDpcf69rvk2/9SvDHsBp3GT6hMIlCS4ZRbzcYD2dP
 58=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mW1rCx44iLA=:/Gajeu7to3A6Ht4fEOGmOM
 VrVkYrIOaOWFbVz0dUB19QotgPqpUaNZ9s5JK+j8PjaEBomafj/raSFiwvRW1i7F+V8c1yXi3
 7UJr7dAlUe5CK5xzgHEMiBNl7adKcmNKYRE/o0poTjKZAwuMVnHV9J+fkUdRrQDVrVkNZQDtY
 LHvQnas9brIhuezksYFzH9Pol+hd3YXpTP1J/k9Tep1e6ppE6zX3awixfJVVyPXj09b9iFFPP
 nPpETdXzqQspp2OaySgm9TbPNosj+TI6fbPcuIA9018AH3QcfASNas9uoobDSzUAKc7u2CYCl
 SmsdGV0F41hBk0LaPWMD5JmQE14GDfYBjsG1BP29GHify4oGtvVCBqrZwZKRCtbUz3G7i9KQG
 IknEjSp92+qsc71cN9DiVh3WD72v2MeCIqH32Vt5HLNfOb2hbBvkYRepx+55v6D+PY0s0xKDY
 ld9U5E2roDTiHXZ+GymN4caVOKAi3lsJT8kr9E3JCAEFOuqkGsPN8VrnmnDmvFOlxOumyBJki
 NqU8IwX2kaZfTf99CDBU5Ortk+6ZMl98egmxvVuWkpX9nml7w1lACPqpLuB1FFc0rFvC1MzXB
 wDNcELXrKOYz9pdcvEr6jUKFQoA9gQsQbd6KNaUd8V3CtnvF7ZGL1GdRH8I4RJ7AKDsyEeUsy
 Ekr8=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> Still missing commit message. Describe here why you need to do that.

ok, added note that headers are reused in power-off-driver

https://github.com/frank-w/BPI-R2-4.14/commits/5.2-poweroff-mainline

> Please check your email setting as discussed offline. Otherwise your pat=
ches
> won't get accepted.

tested with webmailer where it looks good :(

seems the problem is only shown when imported to patchwork

using only git sendemail in ubuntu 18.4 without any mta (have sendmail not=
 installed) and no changes made to git sendemail except authentication.

i see that (except cover-letter which is quoted-printable) all is send wit=
h
Content-Type: text/plain; charset=3D"us-ascii"
Content-Transfer-Encoding: 7bit

so i have forced git sendemail now to
sendemail.composeencoding UTF-8

if this does not work i can try instead
sendemail.transferEncoding 8bit

regards Frank
