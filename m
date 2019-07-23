Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C107717FA
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 14:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389750AbfGWMUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 08:20:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38680 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389742AbfGWMUb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 08:20:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190723122030euoutp012a40f116d0534b5929f703187caa05ef~0CJqLZt5b2865228652euoutp01h
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 12:20:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190723122030euoutp012a40f116d0534b5929f703187caa05ef~0CJqLZt5b2865228652euoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1563884430;
        bh=RUl5wJeFoskqQ1lDVm8gqntXrYOyS23MWPseu8SSF2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6HlEwEvhOIZ0/qXBkr91CsMlxwf3AeC/VOQUCSsII6gY76QG6xzJvxXolgeArVKU
         n3YnaDSCxKMTih1A9WIgAwBBMmM/33DuIvKtbA/bI1S4oDTWT7dgfkO1VypMkd4p8T
         p/Cy+CIF5KF06Iyvlg5PGJKgZTe7Hz+3aYuLh9a4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190723122029eucas1p229ebf0e7f961ec1ea52fdd2e8068089a~0CJpnFwhH2751627516eucas1p2g;
        Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DF.0C.04377.D8BF63D5; Tue, 23
        Jul 2019 13:20:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122029eucas1p21e1a51e759f9b605d2c89daf659af7bb~0CJo-Ssns1893418934eucas1p2G;
        Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190723122029eusmtrp1014a6d434e4a0d7a52cc6c3dda4f522e~0CJo0lgUD2543625436eusmtrp1K;
        Tue, 23 Jul 2019 12:20:29 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-bb-5d36fb8dd1e6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 11.51.04146.C8BF63D5; Tue, 23
        Jul 2019 13:20:28 +0100 (BST)
Received: from AMDC3555.DIGITAL.local (unknown [106.120.51.67]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190723122028eusmtip2f4761e8c1aeee8935e1e6249aa5034b5~0CJoJwBlI1731117311eusmtip2r;
        Tue, 23 Jul 2019 12:20:28 +0000 (GMT)
From:   =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        georgi.djakov@linaro.org, m.szyprowski@samsung.com
Subject: [RFC PATCH 10/11] arm: dts: exynos: Add interconnects to Exynos4412
 mixer
Date:   Tue, 23 Jul 2019 14:20:15 +0200
Message-Id: <20190723122016.30279-11-a.swigon@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723122016.30279-1-a.swigon@partner.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87q9v81iDZqXalgcOraV3WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sym793EZjHp/gQWi/PnN7BbbHp8jdXi8q45bBafe48wWsw4v4/J
        Yu2Ru+wWtxtXsFnMmPySzYHfY9OqTjaPO9f2sHnc7z7O5LF5Sb3HwXd7mDz6tqxi9Pi8SS6A
        PYrLJiU1J7MstUjfLoErY+emF6wFc9gr3re/YmtgbGPrYuTkkBAwkWhfeoOli5GLQ0hgBaPE
        xMNbmCGcL4wSe27dYYVwPjNKbLq9gQmm5cKVc1AtyxklnjW+YYVr+Xq9H6yKTcBTomfiDrCE
        iMARRonJC96DtTALrAJyvm9jBKkSFgiROHngFFgHi4CqxM5p18FsXgEniU//TrNC7JOXWL3h
        ADOIzQkU7zrazgZRIyhxcuYTFhCbGaimeetsZoj6j+wSbx4mQdguEn+X9kPFhSVeHd/CDmHL
        SJye3MMCYRdLPN15H+xSCYEGoEeXHYFqsJY4fPwiUIIDaIGmxPpd+hBhR4lfv48yg4QlBPgk
        brwVhDiBT2LStulQYV6JjjYhCFNLYsHvaIhGCYmm1degZntIfOlpYpzAqDgLyS+zkPwyC2Ht
        AkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp7PS/4192MO76k3SIUYCDUYmHd8Me
        01gh1sSy4srcQ4wSHMxKIryBDWaxQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5ak
        ZqemFqQWwWSZODilGhi314rrNjZciumd8+pMTlPTz5hX7R6h5xd7fLYtX9qU7nUz0Oscz+Ln
        RrkW25ofc+VfDDU5u/NysNDFOgbBm2YTN9xQfp7U0CY8kUPD2LaX/0yD8FnV0NPNKc31V6Jf
        p626y9t2YnXtRq4wLo719jfuH36TcXWtX4VbZtXdeClzmU9bJRVnpyixFGckGmoxFxUnAgC6
        lrohYwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7o9v81iDb5ssbI4dGwru8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPg+/2MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexs5N
        L1gL5rBXvG9/xdbA2MbWxcjJISFgInHhyjmWLkYuDiGBpYwSG963MUEkJCQ+rr/BCmELS/y5
        1sUGUfSJUeLGsmOMIAk2AU+Jnok7WEESIgKnGCW2Lj8HVsUssIlR4u7xiewgVcICQRJvLzeA
        7WMRUJXYOe062ApeASeJT/9OQ62Ql1i94QAziM0JFO862g5WLyTgKLFt+2tGiHpBiZMznwDd
        ygG0QF1i/TwhkDAzUGvz1tnMExgFZyGpmoVQNQtJ1QJG5lWMIqmlxbnpucWGesWJucWleel6
        yfm5mxiBcbrt2M/NOxgvbQw+xCjAwajEw7thj2msEGtiWXFl7iFGCQ5mJRHewAazWCHelMTK
        qtSi/Pii0pzU4kOMpkCvTWSWEk3OB6aQvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZ
        qakFqUUwfUwcnFINjLNtxYRMHlvM03jBNnXutikdJkw/+c8lr3j+9Esma/yi5WnS70Rezjr9
        QDh1c2fJuy3mtd7VJ3g9pdzN11y+XW1w5EPFjpu/mpdvecX1tlup6YO3++afuTv/crjXXJQp
        mXXNtk1EgWPp6j8lEnnuG862yysJNE7cIKT+5/zDn4LJvTFcG1t+uyixFGckGmoxFxUnAgDh
        0cb16QIAAA==
X-CMS-MailID: 20190723122029eucas1p21e1a51e759f9b605d2c89daf659af7bb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122029eucas1p21e1a51e759f9b605d2c89daf659af7bb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122029eucas1p21e1a51e759f9b605d2c89daf659af7bb
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122029eucas1p21e1a51e759f9b605d2c89daf659af7bb@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds an 'interconnects' property to Exynos4412 DTS in order to
declare the interconnect path used by the mixer. Please note that the
'interconnect-names' property is not needed when there is only one path in
'interconnects', in which case calling of_icc_get() with a NULL name simply
returns the right path.

Signed-off-by: Artur Świgoń <a.swigon@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index a70a671acacd..faaec6c40412 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -789,6 +789,7 @@
 	clock-names = "mixer", "hdmi", "sclk_hdmi", "vp";
 	clocks = <&clock CLK_MIXER>, <&clock CLK_HDMI>,
 		 <&clock CLK_SCLK_HDMI>, <&clock CLK_VP>;
+	interconnects = <&bus_display &bus_dmc>;
 };
 
 &pmu {
-- 
2.17.1

