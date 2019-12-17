Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D112243A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Dec 2019 06:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfLQFvi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Dec 2019 00:51:38 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31583 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfLQFvN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Dec 2019 00:51:13 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191217055109epoutp03acbd57bc3ef3f67d98853f610b05f6d6~hEqrOnzRr0699406994epoutp03v
        for <linux-pm@vger.kernel.org>; Tue, 17 Dec 2019 05:51:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191217055109epoutp03acbd57bc3ef3f67d98853f610b05f6d6~hEqrOnzRr0699406994epoutp03v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576561869;
        bh=8KCqrRiUEVLa3021FF4CS5+nZP/tWBbnEr5rHbveB7c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=feSl2LeYSKIJz2vnNOgg+fCucOp2aP4P9huSrsEQBoXjlmGy8lVVJ0fjTsIPThBZE
         4Z1pfbn++btNOwlPpRhEb1xsc2Or/LRBGJIs5JCpNkUK4hF5STm5+l3nTd2n1sMePF
         ab8uoaF7HHQJC11merFhlx/naXuIsLwdwP1tgbTo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191217055108epcas1p1218b944d39a70168aff3d834376885e4~hEqqmUrkv2681226812epcas1p1q;
        Tue, 17 Dec 2019 05:51:08 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47cS1P6jsDzMqYks; Tue, 17 Dec
        2019 05:51:05 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.C7.48498.9CC68FD5; Tue, 17 Dec 2019 14:51:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20191217055105epcas1p365e306f27fd53852b793155c929ee634~hEqnhLQga1365213652epcas1p3m;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191217055105epsmtrp27b2b1099645bc64a87516a9a1d1703dc~hEqngVJu31905819058epsmtrp27;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-50-5df86cc990b4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.7E.06569.9CC68FD5; Tue, 17 Dec 2019 14:51:05 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191217055105epsmtip1b7ee68403bfad60ee2748cfe982f1131~hEqnUMcXt3103131031epsmtip1Z;
        Tue, 17 Dec 2019 05:51:05 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, leonard.crestez@nxp.com, lukasz.luba@arm.com
Cc:     a.swigon@samsung.com, m.szyprowski@samsung.com, kgene@kernel.org,
        cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/9] PM / devfreq: Remove deprecated 'devfreq' and
 'devfreq-events' properties
Date:   Tue, 17 Dec 2019 14:57:29 +0900
Message-Id: <20191217055738.28445-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjuO2fn7BSuDrPLl1GtI0UK6o46/ZSUKI2V/hBCAmnZYTs4cbd2
        5rpSanZRspsFpWmZiZfKdI1ckS10IUVpppUZpmVROBNNraCgNk9R/57nfZ7nffne76VweQUZ
        RGWbbLzVxBkYco7kVnuIMuyh4btG6e2IRYOVhwB6OfWRQBc9nQT69c5LoBPDXhx1dTVJ0ZOC
        USmqG5ggkGP4BYF67lwg0WSJB6AvQ79wdK7rHoaqCgql6LpnQIpqXnZj6HV+HYkOtXqka+Xq
        a5XXgNrRUESqb145oG4ec2Hq484GoG55UYmrJx3L0qQZOWv0PKfjrQrepDXrsk1ZCUzK5sz1
        maoYJRvGxqFYRmHijHwCk5SaFrYh2+B7BqOwc4ZcXymNEwQmInGN1Zxr4xV6s2BLYHiLzmCJ
        s4QLnFHINWWFa83GeFapjFT5jNtz9IPlVZjlBNw18mCSzAO98mIwm4J0NHzsrQTFYA4lp10A
        dleMEiL5AmDZwUZSJF8B7B1xYn8jl8reSEShFcDPZz9hIpkCsK30sMTvIulQ6P7UR/rxfHo/
        vNjumjHh9CsM3n3WT/iFQHo7/NlxeiYgoVfCluZx4McyOh4+GmwE4rjl8GrTfdwfhvRHErYP
        tfgEykeS4NR4uugJhCMdTqmIg+DkWCsp4r2w/qGHFLNHAXS6nxKiEAXdNaWYvw9Oh8AbdyLE
        8gp4+0fFzFycngvHpo8R4igZPHr4z8KCYc/QwJ9NLIbVR4pI0aKG/cM5/rKc1sD3E4+wk2Bp
        2b/+lwBoAAt5i2DM4gXWEvn/LznAzGmGxrjA5c7UNkBTgAmQWezfNHKCswu7jW0AUjgzX+ZS
        +EoyHbd7D281Z1pzDbzQBlS+3Z3CgxZozb5DN9kyWVVkVFQUimZjVCzLLJJR37s1cjqLs/E5
        PG/hrX9zGDU7KA9E8/YMY9/Wqr6A6jOO1GfHUgpLpatbX5cnJ2ZHBmt76ULdpqTYVM1Eb+ee
        6RL3krnF294KG3d0ro119yRjtSUcmWwPnDiftqy51qtch0ZTirbM+1Afh83aX/r8p3ajJl3S
        LDn57sN1/ai+ydkfIDy15zN3962aDh9ZELFzfF3iFCMR9BwbilsF7jdnY8IWsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSnO7JnB+xBkfeiVjcn9fKaHH9y3NW
        i/lHzrFa/H/0mtWi//FrZovz5zewW5xtesNuseLuR1aLTY+vsVpc3jWHzeJz7xFGi08P/jNb
        zDi/j8liYVMLu8XaI3fZLZZev8hkcbtxBZtF694j7A5CHmvmrWH02LSqk81j85J6j43vdjB5
        9G1Zxeix/do8Zo/Pm+QC2KO4bFJSczLLUov07RK4Mu7PXshU0C9R8eroZ7YGxitCXYycHBIC
        JhILZt1j6WLk4hAS2M0ocfTUFFaIhKTEtItHmbsYOYBsYYnDh4shaj4xSrxbOA2shk1AS2L/
        ixtsILaIQBujxJLvciA2s8BzJol9XWYgtrBAnETrqtOMIDaLgKrE9o0fwGxeASuJU/fXMULs
        kpdYveEA8wRGngWMDKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYKDWEtrB+OJE/GH
        GAU4GJV4eCVKvscKsSaWFVfmHmKU4GBWEuHdoQAU4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuf
        fyxSSCA9sSQ1OzW1ILUIJsvEwSnVwGgZ+XOS5/TFibt2n2neM2N2oOZPpr+py+5+eGw7+93S
        zryYHyavv0zbMpdpb5DRueCCVmddq8L7lzw4SwVtsjJvcBhq73w5vXdR126W2b8yDjq0XH74
        ov7CrJ+TtW96V9redl3BbPu+9/N7p/PxsnXC6h4S7/+oet+oCQyb+kZYsWpZQWT57WAlluKM
        REMt5qLiRAABxhNSXgIAAA==
X-CMS-MailID: 20191217055105epcas1p365e306f27fd53852b793155c929ee634
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191217055105epcas1p365e306f27fd53852b793155c929ee634
References: <CGME20191217055105epcas1p365e306f27fd53852b793155c929ee634@epcas1p3.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The devfreq and devfreq-event subsystem provided the following two properties:
- Provide 'devfreq' property in order to get the parent devfreq device
  by devfreq_get_devfreq_by_phandle() if devfreq device use passive governor.
- Provide 'devfreq-events' property in order to get the devfreq-event device
  by devfreq_event_get_edev_by_phandle().

But, two properties name is not proper expressing the h/w
and 'devfreq' word is name of linux subsystem intead of any h/w name.

Hand over the rights for deciding the property name for getting
the devfreq/devfreq-event device on devicetree, to each devfreq driver.

So, replace 'devfreq' and 'devfreq-events' property with following property
name according to each devfreq driver:
--------------------------------------------------------------------
Old property  | New propert        | Device driver name            |
--------------------------------------------------------------------
devfreq       | exynos,parent-bus  | exynos-bus.c                  |
              |                    |                               |
devfreq-events| exynos,ppmu-device | exynos-bus.c, exynos5422-dmc.c|
              | rockchip,dfi-device| rk3399_dmc.c                  |
--------------------------------------------------------------------

Chanwoo Choi (8):
  PM / devfreq: Remove devfreq_get_devfreq_by_phandle function
  PM / devfreq: event: Add devfreq_event_get_edev_by_node function
  PM / devfreq: exynos-bus: Replace deprecated 'devfreq' property
  PM / devfreq: exynos-bus: Replace deprecated 'devfreq-events' property
  PM / devfreq: rk3399_dmc: Replace deprecated 'devfreq-events' property
  memory: samsung: exynos5422-dmc: Replace deprecated 'devfreq-events' property
  ARM: dts: exynos: Replace deprecated property for Exynos bus and DMC
  arm64: dts: exynos: Replace deprecated property for Exynos bus

Leonard Crestez (1):
  PM / devfreq: Add devfreq_get_devfreq_by_node function

 .../bindings/devfreq/exynos-bus.txt           | 22 +++----
 .../bindings/devfreq/rk3399_dmc.txt           |  4 +-
 .../memory-controllers/exynos5422-dmc.txt     |  6 +-
 arch/arm/boot/dts/exynos3250-monk.dts         |  2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       | 18 +++---
 .../boot/dts/exynos4412-itop-scp-core.dtsi    | 16 ++---
 arch/arm/boot/dts/exynos4412-midas.dtsi       | 18 +++---
 .../boot/dts/exynos4412-odroid-common.dtsi    | 18 +++---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 34 +++++------
 .../dts/exynos/exynos5433-tm2-common.dtsi     | 20 +++----
 drivers/devfreq/devfreq-event.c               | 53 +++--------------
 drivers/devfreq/devfreq.c                     | 25 +++-----
 drivers/devfreq/exynos-bus.c                  | 58 ++++++++++++++++---
 drivers/devfreq/rk3399_dmc.c                  | 16 ++++-
 drivers/memory/samsung/exynos5422-dmc.c       | 37 ++++++++++--
 include/linux/devfreq-event.h                 | 14 ++---
 include/linux/devfreq.h                       |  6 +-
 17 files changed, 197 insertions(+), 170 deletions(-)

-- 
2.17.1

