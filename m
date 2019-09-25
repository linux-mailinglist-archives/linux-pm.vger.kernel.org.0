Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06010BD63A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 03:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633701AbfIYB66 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Sep 2019 21:58:58 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:10956 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633689AbfIYB65 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Sep 2019 21:58:57 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190925015854epoutp047b30c32a328440464f37e39e601db106~Hi9MvBYCb1347513475epoutp04S
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2019 01:58:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190925015854epoutp047b30c32a328440464f37e39e601db106~Hi9MvBYCb1347513475epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569376734;
        bh=7rMAzdFR0krO7CVoML1y9aWfxqQMAV9tCQNRCvwo/bg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=SFNZr2w/3IfqtuNmOq87gp+KbMeIAj0hUNG9z+97THdz0VYohachxP5KVRyC+KVh5
         nmNSUjfl/XiwKX0cvh0djeXfztsnGTJ3g7lhuI0kwflr474ZKqgHEVZhz7ar7/HQV6
         8Bgwpc71FjAD8+5P87TfOYpUXJ1kYq7obOz9wkeI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190925015853epcas1p1000e86febba276628d3e320be3aaa766~Hi9Ludqox2132421324epcas1p1V;
        Wed, 25 Sep 2019 01:58:53 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46dLnj2FCwzMqYls; Wed, 25 Sep
        2019 01:58:49 +0000 (GMT)
X-AuditID: b6c32a39-f5fff70000000fe4-36-5d8ac9d61d74
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.DC.04068.6D9CA8D5; Wed, 25 Sep 2019 10:58:46 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH v8 2/6] PM / devfreq: Move more initialization before
 registration
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Artur Swigon <a.swigon@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <398895f3b4f9ca4b03b47b56dfa25fbd58fd2311.1569319738.git.leonard.crestez@nxp.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190925015845epcms1p4f788aa587e53bfa38b9b847838b02342@epcms1p4>
Date:   Wed, 25 Sep 2019 10:58:45 +0900
X-CMS-MailID: 20190925015845epcms1p4f788aa587e53bfa38b9b847838b02342
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNJsWRmVeSWpSXmKPExsWy7bCmru61k12xBs3TJCzuz2tltPh6+hSj
        xbJLRxktXh7StLj+5TmrxfS9m9gszp/fwG5xtukNu8WtBhmLFXc/slpsenyN1aLr10pmi8+9
        RxgtPm94zGix+txBNouuQ3/ZLDZ+9XAQ9Hh/o5XdY3bDRRaPBZtKPTat6mTzuHNtD5vH5iX1
        Hhvf7WDyOPhuD5NH35ZVjB6fN8kFcEVl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpa
        WpgrKeQl5qbaKrn4BOi6ZeYAPaOkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKbAs
        0CtOzC0uzUvXS87PtTI0MDAyBSpMyM74v6SJqWA6S0XnlNvMDYxbmbsYOTgkBEwklr4K7WLk
        4hAS2MEoMW3iCnaQOK+AoMTfHcJdjJwcwgIREntPTGIHsYUElCQabu5jhojrS3Q82MYIYrMJ
        6Eps3XCXBWSOiEADo8SrvnYwh1lgB4vEw+nb2UCqJAR4JWa0P2WBsKUlti/fCtbNKRAn0fB1
        HTtEXFTi5uq3cPb7Y/MZIWwRidZ7Z5khbEGJBz93M8LMmTHlP9TMaolr0xezgyyWEGhhlOhd
        PQWqSF/izNyTYEfwCvhK9Mz7ATaIRUBV4vqzp0wQNS4SC/+0gC1mFpCX2P52DjiEmAU0Jdbv
        0ocoUZTY+XsuI8wvDRt/s6OzmQX4JN597WGFie+Y9wRqvJrEod1LoOplJE5PX8g8gVFpFiKs
        ZyFZPAth8QJG5lWMYqkFxbnpqcWGBabIsbuJEZywtSx3MB4753OIUYCDUYmH14G1K1aINbGs
        uDL3EKMEB7OSCO8sGaAQb0piZVVqUX58UWlOavEhRlOg/ycyS4km5wOzSV5JvKGpkbGxsYWJ
        oZmpoaGSOK9HekOskEB6YklqdmpqQWoRTB8TB6dUA2NckFb1lNln208/4rE64Wh/2fSvv1tk
        UoyU6/bfnj9qJA9Uv2n5mNI9/b/2GpuEywqbWl8H9p4Nd83ms1s6732PoQnT6x1W/FYTamU3
        8W71Fp1aGBirlx3mHXxk/iJ70T3/XHr4ND4kZ6Z9qC64XMlbfGnu46vO4eGXTjy6KBw42Tpo
        9j0bayWW4oxEQy3mouJEAASSQhPuAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190924101139epcas1p4c6799a5de9bdb4e90abb74de1e881388
References: <398895f3b4f9ca4b03b47b56dfa25fbd58fd2311.1569319738.git.leonard.crestez@nxp.com>
        <cover.1569319738.git.leonard.crestez@nxp.com>
        <CGME20190924101139epcas1p4c6799a5de9bdb4e90abb74de1e881388@epcms1p4>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

>In general it is a better to initialize an object before making it
>accessible externally (through device_register).
>
>This makes it possible to avoid relying on locking a partially
>initialized object.
>
>Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>Reviewed-by: Matthias Kaehlcke <mka@chromium.org>

Do you object to the general idea of devm_* for device drivers?
or did you find a bug in the memory handling in the code?

The result of this commit still relies on locking anyway.


Cheers,
MyungJoo.
