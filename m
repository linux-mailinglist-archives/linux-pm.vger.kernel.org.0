Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29131481BF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 12:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391204AbgAXLW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 06:22:26 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52815 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391199AbgAXLWZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 06:22:25 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200124112223euoutp028cdb1c062d63f5974796d6f96c1a2a8b~szsvMC0Mf1664016640euoutp02k
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 11:22:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200124112223euoutp028cdb1c062d63f5974796d6f96c1a2a8b~szsvMC0Mf1664016640euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579864944;
        bh=7gGcPJwJd/puSj7LZi16us9UvxlBRcOghdJ+QKXKrdE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j2HbyfiEpJlWfcLa4htJuVkGu00LorD0r61DzhxI2ALm/0uJEhh7+smjerjEDBAxn
         k27cOlmJmzjMOHdH8h5tb8lGVu/9qRDS4fgulO8+Aob2q3JM4SdmTyT1puTCpmQH5x
         4qn3ZdRNvhXmaxM8kfg113XMgbjcN/uKioXGKYWc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200124112223eucas1p12ce3c0b8be44a47331317961f80efc9f~szsu5wh0u3241032410eucas1p1C;
        Fri, 24 Jan 2020 11:22:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C9.A8.60698.F63DA2E5; Fri, 24
        Jan 2020 11:22:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200124112223eucas1p1ff581c051a056b7517655a3eb9ec68de~szsuZclkv2709327093eucas1p1w;
        Fri, 24 Jan 2020 11:22:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200124112223eusmtrp1e4b8f1c165f594e10570ca50f4a6e1a1~szsuYtXfM0086800868eusmtrp1f;
        Fri, 24 Jan 2020 11:22:23 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-9c-5e2ad36f1c56
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.FC.08375.F63DA2E5; Fri, 24
        Jan 2020 11:22:23 +0000 (GMT)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200124112222eusmtip2758daabb6f8219629e4888f27bc2e161~szstqcurH1453014530eusmtip2O;
        Fri, 24 Jan 2020 11:22:22 +0000 (GMT)
Message-ID: <669f89cddb185db7412a4012427fb5ccbaae2652.camel@samsung.com>
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@samsung.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
Date:   Fri, 24 Jan 2020 12:22:22 +0100
In-Reply-To: <747a1c94-8eee-f46a-fcc7-d111cd9df70d@linaro.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm27nsuNz6mlFvFl1WEUlpocGBLrMLcggiRQzp6sqDRm7WTkvn
        j9IsSy01JTIVL2Flq1BXhlmayVDRdMhEK7VR64LW7OK16LZ5FvbveZ73ed7ne+FjCGUn5csc
        1h3n9TpNnIqWkQ+av1tXx9v89q/58mIZW51fSbG9ox8otsTSSbHdY59p9kq9mWZz7Tkka7VW
        SdmKga8Ua3b0UKytrohmRy5aEJtvbZCwdy0DUrYvpYJm8/MG6eCZnNmUTnP9PY9pzp7ZIuHu
        lZ/iqodrJVzWfRPiRswLQ6W7ZRui+bjDJ3h9wKYoWazNMkkeLcOJbxwrktEZeQbyYgAHQX3K
        ZSIDyRglrkBg7y2WiGQUwdhLGxLJCIKSohH6X2SiK9szuIkg91OpVCTvXa6fZ5HbJcccWNNt
        UwkfvBcKJu1SN6axGjr6xqc6ZuNvCDrKC6dWEdiC4OP4W9LtIvFyaM6rIdzYC2+CoeI+qdi9
        CpxtWS4P42qYBb9qfdwygRdBak3h1BWAnVLIyXYSon8btBWlSkTsA0Mt9z17FkB73gVSxAK8
        e2inxHAyAvMNiye8Hvo7f9DuMgKvhMq6AFHeDDUTmRK3DFgBz52zxDcoIPfBFUKU5XA+TSlC
        FdRdVYhBgNO3ezy7OegqT6dy0JKC6VsK/rulYLq1FBEmNJc3CNoYXgjU8Qn+gkYrGHQx/ofi
        tWbk+mXtv1vGalHDz4NNCDNI5S1vzFi5X0lpTghGbRMChlDNlqNdLkkerTEm8fr4A3pDHC80
        ofkMqZorD7w2uE+JYzTH+SM8f5TX/5tKGC/fZBR5qdGKXiqeRnyY0R8WscfvTag1cfuh891R
        T0Kc2leBrVWjscHzfw0b6qJ3SBM3PvKtjnz2J7P9k3XRrVJSgXTPjoU6Ux2OrcFo7bjJGWZ8
        nW3D19PWBekTTMacO8sg5BLhrZ53uTVhTtnJgInwxfXrz4XvUS/daZSpJxu3JDnfqkghVrPW
        j9ALmr9Pu97MYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7r5l7XiDOZcZLXYOGM9q8X1L89Z
        LeYfOcdqceXrezaL6Xs3sVlMuj+BxeL8+Q3sFivufmS12PT4GqvF5V1z2Cw+9x5htJhxfh+T
        xdojd9ktbjeuYLOYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPje92MHn0bVnF6PF5k1wA
        e5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexuUj
        P1gKFgpUPHqs3sDYwtvFyMkhIWAi8f1iP2MXIxeHkMBSRomfU9ayQiQkJD6uvwFlC0v8udbF
        BlH0hFHi26apjCAJXgEPifOdl9lAbGGBGIlZP+6zg9hsAvYSZ29/YwJpEBH4zChxeNEnFhCH
        WeAoo8SzExBVLAKqEscmb2UGsTkF7CRezbvNDrHiE6PE3/l3mUASzAKaEq3bf7ND3KEj8fZU
        H9AkDqDVghJ/dwhDlMhLNG+dzTyBUXAWko5ZCFWzkFQtYGRexSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERin24793LyD8dLG4EOMAhyMSjy8Er2acUKsiWXFlbmHGCU4mJVEeBnDgEK8KYmV
        ValF+fFFpTmpxYcYTYH+mcgsJZqcD0wheSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGCVWL7+stiLm/LNlh0KSAir8bIv8L/8yfBJisa5Uz6Nx+nUtyfvuGjsa
        LmZnyk24Iv+7a2Gsw8bVnIveXV7AnDT9Y1incJmMoGTKXLkLsR+MF8VvfzD90lTPNt9k2ZlW
        xc+dtvav3xGuxGbraO56PfK7q17IPAGpux0/UrNseA//vz69suZZlRJLcUaioRZzUXEiAMAO
        xRfpAgAA
X-CMS-MailID: 20200124112223eucas1p1ff581c051a056b7517655a3eb9ec68de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9
References: <20191220115653.6487-1-a.swigon@samsung.com>
        <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
        <20191220115653.6487-5-a.swigon@samsung.com>
        <747a1c94-8eee-f46a-fcc7-d111cd9df70d@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 2020-01-22 at 18:54 +0200, Georgi Djakov wrote:
> Hi Artur,
> 
> Thank you for your continuous work on this.
> 
> On 12/20/19 13:56, Artur Świgoń wrote:
> > This patch adds the following properties to the Exynos4412 DT:
> >   - exynos,interconnect-parent-node: to declare connections between
> >     nodes in order to guarantee PM QoS requirements between nodes;
> 
> Is this DT property documented somewhere? I believe that there should be a patch
> to document it somewhere in Documentation/devicetree/bindings/ before using it.

It will be documented in Documentation/devicetree/bindings/devfreq/exynos-bus.txt
in the next version.

> >   - #interconnect-cells: required by the interconnect framework.
> > 
> > Note that #interconnect-cells is always zero and node IDs are not
> > hardcoded anywhere.
> > 
> > Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > index 4ce3d77a6704..d9d70eacfcaf 100644
> > --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> > @@ -90,6 +90,7 @@
> >  &bus_dmc {
> >  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
> >  	vdd-supply = <&buck1_reg>;
> > +	#interconnect-cells = <0>;
> >  	status = "okay";
> >  };
> >  
> > @@ -106,6 +107,8 @@
> >  &bus_leftbus {
> >  	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
> >  	vdd-supply = <&buck3_reg>;
> > +	exynos,interconnect-parent-node = <&bus_dmc>;
> > +	#interconnect-cells = <0>;
> >  	status = "okay";
> >  };
> >  
> > @@ -116,6 +119,8 @@
> >  
> >  &bus_display {
> >  	exynos,parent-bus = <&bus_leftbus>;
> > +	exynos,interconnect-parent-node = <&bus_leftbus>;
> > +	#interconnect-cells = <0>;
> >  	status = "okay";
> >  };

-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


