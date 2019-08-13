Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7D8ACA8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 04:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHMC0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 22:26:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41408 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfHMC0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 22:26:11 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190813022607epoutp016861d990a4c25811aec69ebc4bbd0ec8~6Wlsf-cNz2405024050epoutp01B
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 02:26:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190813022607epoutp016861d990a4c25811aec69ebc4bbd0ec8~6Wlsf-cNz2405024050epoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565663167;
        bh=ppPTNC5i9XSnjP019ukaojXgtyupGvee8x/M+XpvUUg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=fSZvvXQav7pq15KlbZi1uvRunImqPPrf5FQCcsyQC3BETt4bBS/67RrFlQjWIS5dF
         2QWLXmP2xn3D5/eJjbVyZJfO2jqCLSibRBJWLmMHLOpAqLWtQV47Kz0jPA1Vxoc154
         l0yJQgrRzoh4k0TrN1OxfmhLTO6S2i6nHAt5/p4o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190813022606epcas1p2057ad5e87e79e89b26eb4ec5f24e95d8~6WlrRB2nh0390303903epcas1p2J;
        Tue, 13 Aug 2019 02:26:06 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 466xQy09whzMqYkW; Tue, 13 Aug
        2019 02:26:02 +0000 (GMT)
X-AuditID: b6c32a37-e3fff70000000fe2-cc-5d521fb7b8ea
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        27.F3.04066.7BF125D5; Tue, 13 Aug 2019 11:25:59 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 2/7] dt-bindings: devfreq: Add bindings for generic imx
 buses
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Artur Swigon <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <97b0bff95ddb85b06ef3d2f8079faa36562a956d.1565633880.git.leonard.crestez@nxp.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190813022559epcms1p22c4bf62a5ac36826c515e1f89887e071@epcms1p2>
Date:   Tue, 13 Aug 2019 11:25:59 +0900
X-CMS-MailID: 20190813022559epcms1p22c4bf62a5ac36826c515e1f89887e071
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkl+LIzCtJLcpLzFFi42LZdljTQHe7fFCsQd99Y4tDx7ayW3w9fYrR
        Ytmlo4wWX6buYrbYPjPZ4uUhTYvrX56zWsw/co7VYuPm2ywW0/duYrNYNXUni8X58xvYLc42
        vWG3WHH3I6vFpsfXWC26fq1ktvjce4TRYun1i0wWF0+5Wqw+d5DNonXvEXaLrkN/2Sz+XdvI
        YvFii7jFxq8eFi13TB2kPNbMW8Po8f5GK7vHgk2lHptWdbJ53Lm2h81j85J6j43vdjB5HHy3
        h8mj/6+BR9+WVYwenzfJBXBHZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynk
        Jeam2iq5+AToumXmAL2upFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySmwLNArTswt
        Ls1L10vOz7UyNDAwMgUqTMjOWPzzKUvBZZaKPfdvsjYw/mDuYuTkkBAwkXj87TljFyMXh5DA
        DkaJz+ffASU4OHgFBCX+7hAGqREWCJZo33iUBcQWElCSaLi5jxkiri/R8WAbI4jNJqArsXXD
        XRaQOSIC8xklZl8/zQbiMAtMYpdYvWsx1DZeiRntT1kgbGmJ7cu3gnVzCsRJTNl5khUiLipx
        c/Vbdhj7/bH5jBC2iETrvbNQcwQlHvzczQgzZ8aU/1AzqyWuTV/MDrJYQqCFUaJ39RSoIn2J
        M3NPsoHYvAK+ErNOPWIC+ZJFQFXiyDN5iBIXiY+PDoDtZRaQl9j+dg44IJgFNCXW79KHKFGU
        2Pl7LiPMKw0bf7Ojs5kF+CTefe1hhYnvmPeECcJWkzi0ewlUvYzE6ekLmScwKs1CBPUsJItn
        ISxewMi8ilEstaA4Nz212LDAGDl2NzGCs4GW+Q7GDed8DjEKcDAq8fBWJATGCrEmlhVX5h5i
        lOBgVhLhLfkbECvEm5JYWZValB9fVJqTWnyI0RTo/YnMUqLJ+cBMlVcSb2hqZGxsbGFiaGZq
        aKgkzrvwh0WskEB6YklqdmpqQWoRTB8TB6dUA6NY8S6NppY7azU+T847O2/mj5wdD3kTGe4X
        HC2UKWBY5M/7b15fTu873wfxbA4BzRrqixcnPT+kMjNEob7g382pf2xfH7LVyGLzSF/q6eDl
        ruhU1l7grDspZVOEwYwZDyc8v5v9X+56TqzEO9uO/xyse000rqxSnVbNIn6qUyCgzUR/ulNK
        qhJLcUaioRZzUXEiAIS71W0cBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190812185002epcas1p1c528b12d20771cf4887907fdfd716e22
References: <97b0bff95ddb85b06ef3d2f8079faa36562a956d.1565633880.git.leonard.crestez@nxp.com>
        <cover.1565633880.git.leonard.crestez@nxp.com>
        <CGME20190812185002epcas1p1c528b12d20771cf4887907fdfd716e22@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>Add initial dt bindings for the interconnects inside i.MX chips.
>Multiple external IPs are involved but SOC integration means the
>software controllable interfaces are very similar.
>
>This is initially only for imx8mm but add an "fsl,imx8m-nic" fallback
>similar to exynos-bus.
>
>Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>---
> .../devicetree/bindings/devfreq/imx.yaml      | 50 +++++++++++++++++++
> 1 file changed, 50 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


