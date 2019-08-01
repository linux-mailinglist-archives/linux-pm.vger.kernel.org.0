Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3E17D6D1
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2019 10:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfHAH7s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 03:59:48 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55917 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfHAH7s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 03:59:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190801075946euoutp01edfc1d2a6f619968a5ee4fa8f1515cc4~2vZlJjI591809418094euoutp01L
        for <linux-pm@vger.kernel.org>; Thu,  1 Aug 2019 07:59:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190801075946euoutp01edfc1d2a6f619968a5ee4fa8f1515cc4~2vZlJjI591809418094euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1564646386;
        bh=uCq2MLxSrtJv6mtG5c2BOzfNDZhr5+amxgb65dHy6RI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ds1V6aYMuCCKMDH/NjpiXFm8lRbBr1Bu1QfnNfxwT3VHpuf0dQFP0ufzFAYxj/BC+
         YB0yBchnYdgT3sCT8yZLu5OD0eZYRcAlKm2VH33MiPpyuRVqFtkc9ipMedlitc7UXD
         hhYvqQHSHAvgB6MB63YFPifkdMIRXm44W8NDW+Cc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190801075945eucas1p148c54c5c41f014ec4238e03d73209f3d~2vZkNXfay1104411044eucas1p1V;
        Thu,  1 Aug 2019 07:59:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 88.6E.04377.1FB924D5; Thu,  1
        Aug 2019 08:59:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190801075944eucas1p10f92b2f34172c4c8f85656983d335f64~2vZjRx4fk2237322373eucas1p15;
        Thu,  1 Aug 2019 07:59:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190801075944eusmtrp24b52198052c3e8764b8e81666c050d5b~2vZjDhtfg0694206942eusmtrp2o;
        Thu,  1 Aug 2019 07:59:44 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-b6-5d429bf12fd3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.83.04140.0FB924D5; Thu,  1
        Aug 2019 08:59:44 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190801075943eusmtip1f5f38bb917a2d719f295ac3ea68eae5d~2vZidr86Z1476114761eusmtip1I;
        Thu,  1 Aug 2019 07:59:43 +0000 (GMT)
Message-ID: <62557522be4924a01d3822d4734c30f2965c608b.camel@partner.samsung.com>
Subject: Re: [RFC PATCH 09/11] devfreq: exynos-bus: Add interconnect
 functionality to exynos-bus
From:   Artur =?UTF-8?Q?=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     krzk@kernel.org, cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        m.szyprowski@samsung.com,
        =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
Date:   Thu, 01 Aug 2019 09:59:42 +0200
In-Reply-To: <6e8b2081-2fb3-9ab8-37d1-8b5fe5fd8e11@linaro.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87ofZzvFGhz+KGqxccZ6VovrX56z
        Wsw/co7V4srX92wW0/duYrOYdH8Ci8X58xvYLTY9vsZqcXnXHDaLz71HGC1mnN/HZLH2yF12
        i9uNK9gsZkx+yebA57FpVSebx51re9g87ncfZ/LYvKTeo2/LKkaPz5vkAtiiuGxSUnMyy1KL
        9O0SuDJ+H3rJWLBBpuLKcs8Gxh7xLkZODgkBE4mX23cwdTFycQgJrGCU2LvnNwuE84VRYsq3
        VewQzmdGifam92xdjBxgLXdb+CHiyxklTv6fDlX0jFHiyp5TzCBzeQUCJC5dfcgKYgsLJEks
        eHQRzGYTcJf49/wKK0iDiMAnRomzS2YzgjjMAh8ZJRp+tYN1swioSizt280EYnMK2En8vrWU
        DeJaHYm3p/pYQM7gFRCU+LtDGCTMLCAv0bx1NjPIHAmBe+wSK6d0QNW7SPRtXMEOYQtLvDq+
        BcqWkfi/cz4ThF0s8XTnfVaI5gZGiU3LjjBDJKwlDh8HOZsDaIOmxPpd+hBhR4m3fUeZIUHB
        J3HjrSDEDXwSk7ZNhwrzSnS0CUGYWhILfkdDNEpINK2+BjXbQ6Ll0XP2CYyKsxB+mYXkl1kI
        WxcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITFqn/x3/soNx15+kQ4wCHIxKPLwK
        PY6xQqyJZcWVuYcYJTiYlUR4F4vbxwrxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5Y
        kpqdmlqQWgSTZeLglGpgnLni6xnpLQGJwfNuRr/glW86JHIzhrupyPahbfujSf1e9SdyHi/q
        eln+MmHF7w+ykyX/tOTYGFquef277K+5/9Q6/+DLhg7t7sq6X3r+JSos7TXcfKRfbq+zj9nD
        m2V7Zn1MiHzuLdvymOvQidfta6fpCNRq8TblWbDf+eN4m6Pt0G9+3iwtJZbijERDLeai4kQA
        C54i6lYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7ofZjvFGvT1iVpsnLGe1eL6l+es
        FvOPnGO1uPL1PZvF9L2b2Cwm3Z/AYnH+/AZ2i02Pr7FaXN41h83ic+8RRosZ5/cxWaw9cpfd
        4nbjCjaLGZNfsjnweWxa1cnmcefaHjaP+93HmTw2L6n36NuyitHj8ya5ALYoPZui/NKSVIWM
        /OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzfh14yFmyQqbiy3LOB
        sUe8i5GDQ0LAROJuC38XIxeHkMBSRonvB9cydzFyAsUlJD6uv8EKYQtL/LnWxQZiCwk8YZTY
        c50HxOYVCJC4dPUhWI2wQJLEgkcXwWw2AXeJf8+vsIIMFRH4zChxeNEnFpAEM4hzY1kOiM0i
        oCqxtG83E4jNKWAn8fvWUjaIK1qZJK5N2ssK0aAp0br9NzvEFToSb0/1sYBczSsgKPF3hzBE
        ibxE89bZzBMYBWch6ZiFUDULSdUCRuZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgdG47djP
        LTsYu94FH2IU4GBU4uE90ekYK8SaWFZcmXuIUYKDWUmEd7G4fawQb0piZVVqUX58UWlOavEh
        RlOgfyYyS4km5wMTRV5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6p
        Bsb1q25rmmglLj/orXzOP+9HfIvQPAbDC5Vb7t53ZZXVUI1ecvfDntMdte1PzX9+8IlLKvud
        sfBB5pYVUd8eq69unzHLuUn4/b1jbGcE//8O2yWb7rn54uRbdWaZvhNE3h60UPN/vsYs7ubD
        2Defz29q8Fx288Sp2W/Yty4zWXwxbp+V6RqdA18TlViKMxINtZiLihMBIkRDMdwCAAA=
X-CMS-MailID: 20190801075944eucas1p10f92b2f34172c4c8f85656983d335f64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b
References: <20190723122016.30279-1-a.swigon@partner.samsung.com>
        <CGME20190723122028eucas1p2eb75f35b810e71d6c590370aaff0997b@eucas1p2.samsung.com>
        <20190723122016.30279-10-a.swigon@partner.samsung.com>
        <6e8b2081-2fb3-9ab8-37d1-8b5fe5fd8e11@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Georgi,

On Fri, 2019-07-26 at 11:05 +0300, Georgi Djakov wrote:
> Hi Artur,
> 
> On 7/23/19 15:20, Artur Świgoń wrote:
> > This patch adds interconnect functionality to the exynos-bus devfreq
> > driver.
> > 
> > The SoC topology is a graph (or, more specifically, a tree) and most of its
> > edges are taken from the devfreq parent-child hierarchy (cf.
> > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
> > patch adds missing edges to the DT (under the name 'parent'). Due to
> > unspecified relative probing order, -EPROBE_DEFER may be propagated to
> > guarantee that a child is probed before its parent.
> > 
> > Each bus is now an interconnect provider and an interconnect node as well
> > (cf. Documentation/interconnect/interconnect.rst), i.e. every bus registers
> > itself as a node. Node IDs are not hardcoded but rather assigned at
> > runtime, in probing order (subject to the above-mentioned exception
> > regarding relative order). This approach allows for using this driver with
> > various Exynos SoCs.
> 
> I am not familiar with the Exynos bus topology, but it seems to me that it's not
> represented correctly. An interconnect provider with just a single node (port)
> is odd. I would expect that each provider consists of multiple master and slave
> nodes. This data would be used by a framework to understand what are the links
> and how the traffic flows between the IP blocks and through which buses.

To summarize the exynos-bus topology[1] used by the devfreq driver: There are
many data buses for data transfer in Samsung Exynos SoC. Every bus has its own
clock. Buses often share power lines, in which case one of the buses on the
power line is referred to as 'parent' (or as 'devfreq' in the DT). In the
particular case of Exynos4412[1][2], the topology can be expressed as follows:

bus_dmc
-- bus_acp
-- bus_c2c

bus_leftbus
-- bus_rightbus
-- bus_display
-- bus_fsys
-- bus_peri
-- bus_mfc

Where bus_dmc and bus_leftbus probably could be referred to as masters, and the
following indented nodes as slaves. Patch 08/11 of this RFC additionally adds
the following to the DT:

bus_dmc
-- bus_leftbus

Which makes the topology a valid tree.

The exynos-bus concept in devfreq[3] is designed in such a way that every bus is
probed separately as a platform device, and is a largely independent entity.
This RFC proposes an extension to the existing devfreq driver that basically
provides a simple QoS to ensure minimum clock frequency for selected buses
(possibly overriding devfreq governor calculations) using the interconnect
framework.

The hierarchy is modelled in such a way that every bus is an interconnect node.
On the other hand, what is considered an interconnect provider here is quite
arbitrary, but for the reasons mentioned in the above paragraph, this RFC
assumes that every bus is a provider of itself as a node. Using an alternative
singleton provider approach was deemed more complicated since the 'dev' field in
'struct icc_provider' has to be set to something meaningful and we are tied to
the 'samsung,exynos-bus' compatible string in the driver (and multiple instances
of exynos-bus probed in indeterminate relative order).

I'm looking forward to hearing any additional thoughts you may have on this
topic.

Best regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics

[1] Documentation/devicetree/bindings/devfreq/exynos-bus.txt
[2]
arch/arm/boot/dts/exynos4412-odroid-common.dtsi
[3] drivers/devfreq/exynos-bus.c
(subject of this patch)


