Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F371E5E98E
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfGCQtn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jul 2019 12:49:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:55005 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbfGCQtl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Jul 2019 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562172518;
        bh=mlVtn+Ho9nIUbfGR8C2oGgrsdZ7rqHETi2ijdwOPmY8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=D9XJFLABs755rRVSJSHjeQOPFBEi/QylsfND1jDl+D71/FShQ8GmFYCDto0sDl5KM
         Q/03aI//Mz1BUAdEakHPxyu/3DI36ek3Fi8gYz7YdSzSZEdazh9Kud8CfzYneTQ1FY
         tnl5hH75JarH/URPtt50e9KcXTk+d1teJroTlLJA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.158.204]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmULr-1iQt0O3f4T-00iTAm; Wed, 03 Jul 2019 18:48:37 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Eddie Huang <eddie.huang@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Cc:     Josef Friedl <josef.friedl@speed.at>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v2 6/7] MAINTAINERS: add Mediatek shutdown drivers
Date:   Wed,  3 Jul 2019 18:48:21 +0200
Message-Id: <20190703164822.17924-7-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703164822.17924-1-frank-w@public-files.de>
References: <20190703164822.17924-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:euDHaiPM7bK1qAj7PUZGcpgw9FdWaWQgXoeWf9VCM+aHITNZE9y
 qvR6MGo2hg7bVjQxM2ISS4YDcnUXx4hDaW8Pd4EuEKg+7Be3mp6iYwJLySN8M7IcMlkjiXm
 iq+CAjuuPSTcxjx7+T0ELbu43Syt1BWFzQ7sKBFeLD1GNywJpGvzYiRQI4Tv+3v5MJUY4Ax
 hG4a2F3abn3DTaj2h0bkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oLhiCmVflpg=:55PrqKYumlca4tcJG/sF/k
 iUkVI+SxVn96HR5bzBwgcA5SG/ecC9yKsCn1z0aOVIg7vCjd2FldXZzSVzue+oW97ZKc7mzOY
 AJMwnog8dXsxXBQOEJD73vMHM4CWAPYKb+bF3Z8mYhsIevq9FSvfA6Iuw6LLN1lEwquTru+Rt
 Fr7o9M37j5bAWHqhjrM10IwTJabfuAqi1T3L0BWligfx3O5eu2Mu1rjQPm3VOfjXsfLY//dxA
 75L0gdBDyp53E3qbWM8WicgOabyd0YtyEmKgVV+UD+GuqycYHsR5hqoMVhQ2T5uzXGaPaPKnt
 5OME6X8Q9hvLZHb6FOjgxmSi8n1K5OUzV5cuZauNjrgBsExQ1jX8joHXTP6puSATN1zevu2cK
 U7/XSQH0kGZdzPAu6rglM8ABFvdCznPBG7H9n/QjzPdcsG6d5pCXGCFmbny4BiQSO3NIEFCfK
 7a6+lUNKk+DkhvfDhaSDkrMmQ/xJZd9LUBLmBCwDePob6gfjCbifVQ6vfjXvM8khqdAM53hQs
 tztryWKuj1w8mo9hhjya/jS/8BDCAyd8yc9aR4puA3d9cEZkzcwonWXj8YZbti9bq6SPkrXuy
 7HIICdbGSIEBBypzVBEgTMA5qij5VIHhhuX98lxcu0mbzlcLcZ5jCiDBLVoyJu2nVlOfm1k2s
 o9HKiOfbCvtV3dRwerYCc8dCjUfOeknVVZ1wjK3kmfOyeZt5hZ/SUlqMBDYOrfAtpj6eqxUEk
 jsdnv/jXqD9+2P51eIaIoQtmclhM2QHHJ3cksqXXaLiHIKza4DyQc9d6c8PKcCTFZ1gwEFgCa
 iqEmPezB8vqP0anNlzFoBv/2+ocb5sDrpp/wZXPDucO742895fkSXk0swGlCqocYhIKSDFWe+
 /0uHog17t1XWB7RuVn+oryAPAXMR2eZy9h2pGwG9wDpFEdLAWuOfSUYp7Ml7qMm4qFBtN0DQv
 Fwa/aBNwp91+zuqBWzNu7FC6iEQFrMBQJYVbYz+5fU7nZUHTnr3r1u2fSxmwo7v378fIj4hCN
 wxC/UZg4+hEWH1llQsG8gGwZvjJh/IJW2YePtFK6pGVllkwKo8NX69ydxdyXxyAsIBcryQm87
 gZmuT6VWEm9tGw=
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
=2D--
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 01a52fc964da..31c1e882b7d2 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9920,6 +9920,13 @@ S:	Maintained
 F:	drivers/net/dsa/mt7530.*
 F:	net/dsa/tag_mtk.c

+MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
+M:	Sean Wang <sean.wang@mediatek.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
+F:	drivers/power/reset/mt6323-poweroff.c
+
 MEDIATEK JPEG DRIVER
 M:	Rick Chang <rick.chang@mediatek.com>
 M:	Bin Liu <bin.liu@mediatek.com>
=2D-
2.17.1

