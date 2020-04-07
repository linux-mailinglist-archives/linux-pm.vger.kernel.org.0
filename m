Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B001A029F
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 02:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgDGAFU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Apr 2020 20:05:20 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:24312 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgDGAFT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2020 20:05:19 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200407000517epoutp0118d61ed0e4143b68022c056d4e6c28ab~DYMqtr0B10599005990epoutp01K
        for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2020 00:05:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200407000517epoutp0118d61ed0e4143b68022c056d4e6c28ab~DYMqtr0B10599005990epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586217917;
        bh=tzpVAjvJlF8U3nA9D3i9y31F8b3lBonoiViArwP4bx4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=px8ei+FoCPnU65Ti1oxup/jdjpes6gtaNBmgoKqMeE6EDKKJZqopQCZLQ74yAiQzb
         Qw01Qi3QCcMWz6hATMCpoEQJmj/f9J4Wr8274vWQtizMEka3JJshSGSSe4XV4Afji2
         kXAoA0aTE880LIvVqb5twdRnGwPGO9mBEJInHMME=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200407000516epcas1p13492e8bfe704a21592fce4ec848aa09f~DYMpcECR11546015460epcas1p1M;
        Tue,  7 Apr 2020 00:05:16 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48x72b3fy1zMqYlr; Tue,  7 Apr
        2020 00:05:11 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.0E.04402.7B3CB8E5; Tue,  7 Apr 2020 09:05:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20200407000511epcas1p361a8982b0da2bc80b1b6e8cf9870093c~DYMkxoNIT1542515425epcas1p3e;
        Tue,  7 Apr 2020 00:05:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200407000510epsmtrp2862d3043e81792698814e1636a048611~DYMkwdmjI0035300353epsmtrp2H;
        Tue,  7 Apr 2020 00:05:10 +0000 (GMT)
X-AuditID: b6c32a35-753ff70000001132-8f-5e8bc3b7ce85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.11.04024.6B3CB8E5; Tue,  7 Apr 2020 09:05:10 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200407000510epsmtip1001cc24d264d29a611749eef3a386d57~DYMkLEa1f0424704247epsmtip1c;
        Tue,  7 Apr 2020 00:05:10 +0000 (GMT)
Subject: Re: [PATCH v3 2/8] PM / devfreq: Add generic imx bus scaling driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f091bc7a-c59b-ae05-2be8-2f654e03b61a@samsung.com>
Date:   Tue, 7 Apr 2020 09:14:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <af1fd3a339a37123ee36179efcb90600c1e0f746.1586174566.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wbZRj2612vV7LqWUA+mw3ZzX9gsrUrnR8G0ERmLg5jAwkhGouX9gIN
        /ZVeuzgXA25DoYiubM1CdUBkbAWJ0lKg4BhZ6VRYYKKzI8JkERIXIiXYgQbF2HKo/Pe8z/s8
        ed/n/fKRmNwvUZBGi4OzW1gTTaTgg+PZytyh8SadsvnOXrTQVg/Q+q1JgK58dxOgh54RDC0u
        zAE01KpH7ZFpMfL3z+Ho4miAQD2eYRzdvt0nQVOnf5Ug3701MQosRsXItdmNoXhzBKCuuzMi
        FPW5xSjetwjQzOQxNPeuj0CfTd8g0KWHHgzVj0YkyBXeItDfUT+OHgQzUFdnFEP+deaFfYzH
        5QNMb1svYFZn6yXMx3UzONMRcDKBnkaCmY9eI5j+y7WMPxYSMR9tKZnN8XTmw2APYOKBTK3s
        tZqCao41cPYszqK3GoyWqkL6eFnli5Wao0pVriofPUtnWVgzV0gXl2hzXzKaEkehs06wJmeC
        0rI8Tx8uKrBbnQ4uq9rKOwppzmYw2fJth3jWzDstVYf0VvNzKqXyiCYhfLOmum2z3LYkfivY
        HifqQBR3ASkJqTzYsf65yAVSSDkVAnD1wtpO8RuAN1eu40KxAeCZ8Px/ltBPGzuqUQAHB74B
        QrEKYOjOX1hSlUqVwJXQZZDEadQpeG7q9LYDo2YkcME9K0o2CCoHjj2YJZL4MWo//OGPxW2D
        jCqCQ+7kViSJU0/DQMveJJ1OlcOJwbM7ksfhROsSnpRIKR2c/LQ0SWNUBvxxqV0k4Kfg0Mon
        WHIspEIk9G/0E0k9pIrhypflQphUuPx1UCJgBYzHRgkBn4LdExFC8DYAGBz7Viw01HCs6/z2
        ahiVDb8YOSzQ++Hwn5eAMPdRGFv/QCyMksGG9+SC5AD8/v49kYCfhJ3vNxLnAO3dFca7K4F3
        VwLv/8M6AN4DnuBsvLmK41U21e63DoDt75KjCYEL0yVhQJGA3iOrkDbp5GL2BH/SHAaQxOg0
        maK5USeXGdiTb3N2a6XdaeL4MNAkTu3GFOl6a+LzWRyVKs0RtVqN8lRHNSoVnSHz3DXp5FQV
        6+BqOM7G2f/1iUipog5oL5ZFX860th7LCU3nl57J3Lz6sx/vHjBUpBXdP/jLV8ZHzL/XLr9e
        3ITKtPGBhsLUWHfKM7eupl3zRzL84tTOiha1Xo6kpXtibG6fEXOev7HWO5vpXm5RvHNWrrBZ
        jyte1QVtr3ALzxfsk+V5wfAI6atdZefHr2e/McUfbN6icb6aVeVgdp79B1Zt3xFEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURiAO7t3d1dzeZ2aR0vLJUVS6qLgQCVFGJcKsgLREHXMm1pujl0/
        sn40q6VOrQw0/Ghqqcwl4ab4kYnk/EBlyhSnZKk5M384I9QMUaupgf8e3vd5zvnzkpiglOtF
        JsiSGYVMnCgkHPFGo9DneKMxJyqoOvMUmtSoAFru7wOoeqgLoKWC9xiyTo4D1FQkQWWdA1yk
        rx/H0cs2A4F0BS04Ghys4yHTw3ke0n75yUUGq4WL1Ks1GFrM6wSoatTMQRZtPhct1lkBMveF
        oPEMLYHeDnwk0KulAgyp2jp5SN2xTqANix5Hcw0eqOqNBUP6ZfqcN12g1gK6VlML6B9jKh5d
        ojTjdLkhhTbosgn6s+UDQddXPqD1C80c+tl6EL1qdKefNugAvWjwCeXfdDwTyyQmpDKKwOAY
        x3jNaph8hnu3oWyRUAILrgYOJKROwuaJXxw1cCQFVCuA5szW7YUnLDR3YWpA/mNXaDSyW44N
        wLwnw4TdcaWuQFtzJbCzG3Ufrs32YHYJo0Z4cP57+far0wBWzCo3C4Lyh+1zY5vsTPnCkd/W
        zZpPBcOm/Hcc+2845QcNL/bbx+5UGGyptHK2FBfYWzSD2xUHKgr2vb5uH2PUEbimGcK22AN+
        minjbPEB2GQrxZ4D1+IddfGOpHhHUrwjKQe4DngyclYaJ2VFcpGMSQtgxVI2RRYXIEmSGsDm
        zfgfbQbDldEdgCKB0Im/i5cTJeCKU9l0aQeAJCZ043vlZUcJ+LHi9HuMIilakZLIsB1gH4kL
        PfjfZN0RAipOnMzcYRg5o/i/5ZAOXkpwOcAbL03Ll0dMFxKHz1abZo2HHt8oGwjPClsiHjWJ
        YpRZEZE1fqFFB3NNU199e6/Z0p30lzIsFEflF5K0cmwqm7cn1yaJXIt3PtFjWrg6cZvbvvIn
        kBgNk6zWSFwCllW7M/tLQrUmYDo/H45fqOiO1oSu7L11WuCxwFx03hgT4my8WOSPKVjxX5Cv
        xMEvAwAA
X-CMS-MailID: 20200407000511epcas1p361a8982b0da2bc80b1b6e8cf9870093c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200406120515epcas1p2331d9e8917c308ad7e2d005df4dd7420
References: <cover.1586174566.git.leonard.crestez@nxp.com>
        <CGME20200406120515epcas1p2331d9e8917c308ad7e2d005df4dd7420@epcas1p2.samsung.com>
        <af1fd3a339a37123ee36179efcb90600c1e0f746.1586174566.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/6/20 9:03 PM, Leonard Crestez wrote:
> Add initial support for dynamic frequency switching on pieces of the imx
> interconnect fabric.
> 
> All this driver does is set a clk rate based on an opp table, it does
> not map register areas.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> Tested-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/devfreq/Kconfig   |   8 +++
>  drivers/devfreq/Makefile  |   1 +
>  drivers/devfreq/imx-bus.c | 138 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
>  create mode 100644 drivers/devfreq/imx-bus.c
> 

(snip)

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
