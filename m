Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA7AD79266
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 19:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfG2RnI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 13:43:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:39867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387681AbfG2RnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 Jul 2019 13:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564422141;
        bh=dzo7VpO1uUdQBSkujY0kbWJNhQ71gTV1phA9QbhtsCo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UmqJim9rhKYYI6rg1gxZHvdyPwGur0+DZZ0Al0NvImxc1/42K6ZznDtK5I+UE4FkU
         CH8Ckn7NSl+PE8DYdPpn7MBOuz0sCuLgopubbWdHfSp38AFPj3TSaKpXnzXJ1Fnqv6
         qGVQgfRn4OjBkq4blGyemMlReFXIznQ/sfs7N97Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.76.97.79]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0McDl1-1i7tEI19k7-00Ja6q; Mon, 29 Jul 2019 19:42:21 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v3 05/10] rtc: mt6397: add compatible for mt6323
Date:   Mon, 29 Jul 2019 19:41:49 +0200
Message-Id: <20190729174154.4335-6-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190729174154.4335-1-frank-w@public-files.de>
References: <20190729174154.4335-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:wxxknIib8Ozn5fRGGdL5blyAR19Ib6OBg90MqLFfw8GTFHxWpjh
 Qpy9UZvf36GuixWQCNxGEoRPdgoZMsujvnPVmdCOD317NbzrIihWrc99GLDxCHitJUkm6xA
 IyETGHnqpx3lPWjUznCNCTlZmhEeVBSt2ZoqibwTNq8DsS+YUcdk2WuwgfoyqNsK3le1Fnh
 5ZfPi2l+Qp7hdiFt4pXzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xqnkkcUrSzE=:v6qNQBXYEiH6f/XVCnuvr2
 Gesj4iyGIi6cG6nBK0kuG+DpbOpg/f8oKKBF/rFtG2+8g4id+v7+lRnL7RcjYYPFLjHJ7tWHe
 PeqAG2j27WUWDHighouBhLbZ6biSQ/Tn+ueFOmy8MFjOHTwi6UQ4w9a8n1DNSdUpatK/eoaVd
 dmVpOS95YcBate5CavOxcMC0BSsZCpOCaNUrYjc458b+Bi4ZV4GDNSGG8yioeeXGDioz0N/Eb
 dUN4haKMwS5Glj5CNgJgXEbNVmFwflqZ3waZEe2Or82L0PSLNs5jWd0wL6k7ZGpKrI6+RDUtT
 x6VM5IftuUAEiEqYV9eXbkjtaLsYtZ9RN1+0oytQBbpjc2+BH90fXx0OpCdZAdmCyLMeX4gtn
 fJw8oF4UtEyB8TbTKh/3jmYPsQ5TTrGCp/tUCdpIT1mu5ZCc62R/b9f8IlHykv61a66hXArHM
 QrnX/FEPY4JBYb5v03ORDb6negchM0Hs3jqal+p30/txIyunne+/166uvTixFDsxzkISP1TtI
 aGzzi5gXp+lnXu9OLY3iw/sFrAh25B7v3ThQHsD8ZWIHYk8ARLkRGCjXzWLhv8wf8Vegnhe9h
 d8Bi4pjMLf/tQzLt+RII8bTZEa2Fg2dK6zb0ZYdBeZrfIkCvDaDOGyH0x8aL4cWQ8ttA3G8qb
 YWrpLtI4d5em3N5WyA96hjaUe0dgpEko+gCrNraeqxKHuW25E7R4uiEZKlQDOi/ea2QGPpjyv
 UXYeZsRAav+t9wU6CYqVHbUWS+WXgAD1c4u+Jo2UjOzB0KDK4VFU2EkSihtEYGRj65eoPFq6m
 thbwC09b7Zr3jPEei+aKyls+h0/uo+K0nA43z06nPmSRZXSddliN0GR1n6pYNC6mz0ETM2FKM
 yMRfi8DR7+tezV09FPIoeQS5C3YvuvzIZHRVBw8mZl9VvJnUxjR9rXLe81zK8mgJ0uoYaApD7
 LRDSA8YfxH4PeYs38ZRck79RQMM9ufG4MLhlDD4zeP5SVYyLLmfcB78+eOQ1a0AvG5vLHmCq/
 83/Ib4+NzjIB4zSmTvledXS0P/ZzE5u+l5m1QwtYG3PwY2Y7i+c/gCleFvPmLi6ucQMgRXu6f
 bcz9JphWkQOuSQ=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

use mt6397 rtc driver also for mt6323
compatible needed because of different rtc-base/size see part 7

changes since v2: splitted this from v2.3 suggested-by Alexandre Belloni

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 drivers/rtc/rtc-mt6397.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 9370b7fc9f81..21cd9cc8b4c7 100644
=2D-- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -325,6 +325,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_sus=
pend,
 			mt6397_rtc_resume);

 static const struct of_device_id mt6397_rtc_of_match[] =3D {
+	{ .compatible =3D "mediatek,mt6323-rtc", },
 	{ .compatible =3D "mediatek,mt6397-rtc", },
 	{ }
 };
=2D-
2.17.1

