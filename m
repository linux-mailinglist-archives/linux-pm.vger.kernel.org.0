Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 870268631B
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfHHN2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 09:28:15 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42311 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733046AbfHHN2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 09:28:15 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190808132813euoutp01375ec8c7236a6cbf219a4d8b478d181d~49ZWldGwA2365823658euoutp01Q
        for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2019 13:28:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190808132813euoutp01375ec8c7236a6cbf219a4d8b478d181d~49ZWldGwA2365823658euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565270893;
        bh=U/A5rR+8l7g7jNeJ/egSxGUzeCSUas+qKZNNq+UCjaw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VTbSLaIgAIp+kcbfAoRpr4fnn6DnRdGWZ7tqA/ZipuEBLDEdIbh6U5rdfZyZD9ynx
         mfJNhvdphgF0MPGQ36skQsW6dxYcaTggGGtIZecKFsF+o6UpIA0bu9bexc0IlAB5dQ
         ZGdecqIO7mQtX4COqu8MYT4klm1kC31tResrmigc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190808132812eucas1p1b1d6e7152506902d4da48cad06abc3ce~49ZV0utpK0308103081eucas1p1G;
        Thu,  8 Aug 2019 13:28:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 17.F1.04374.C632C4D5; Thu,  8
        Aug 2019 14:28:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190808132811eucas1p21e22e644189dfdc6f821960ad485c3be~49ZVAcg2T1167911679eucas1p2L;
        Thu,  8 Aug 2019 13:28:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190808132811eusmtrp2a586366cc8b38427ae13b8180f560272~49ZUx5axJ1364413644eusmtrp2A;
        Thu,  8 Aug 2019 13:28:11 +0000 (GMT)
X-AuditID: cbfec7f5-4f7ff70000001116-87-5d4c236c60c0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 91.C1.04166.B632C4D5; Thu,  8
        Aug 2019 14:28:11 +0100 (BST)
Received: from AMDC3555 (unknown [106.120.51.67]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190808132810eusmtip1a0eeb0ddd69beb3e0c8498231f71d69a~49ZUKGQ0Z1201812018eusmtip1R;
        Thu,  8 Aug 2019 13:28:10 +0000 (GMT)
Message-ID: <b4d52e266a904aca3ecf8e5a4a6dced91dddf539.camel@partner.samsung.com>
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
Date:   Thu, 08 Aug 2019 15:28:09 +0200
In-Reply-To: <4155482f-8f8f-a659-63ba-25701540b2c5@linaro.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRT253bvruLs5xQ8mGku/UNJTQu8ZIyioBUSQkKQWc68qOSLXbU0
        qJmvNJqPLG0mDhJTw0fTxFkKTm2YL0wzaT5CUSuYpVOiLMt5J/bf951zvvN9Bw7FE/UQLlRc
        YgojT5TFi0lbftubn8O+8QdCIg615LnTL8qbCPrD2hJBV/UOE/T4+jeSLuvUkHTJbBGfHhlp
        FtCa+QmCHut4QtKm+72ILh/psqYbeqcFtCGzlqTLH3whj9tLNfX5pHRq4jUpnb2nt5a2VN+W
        KlvrkdSkcQslL9oei2bi49IYub8k0jbW2F2Pkqe8bjxVvhcoUPW+AmRDAT4CraNzvAJkS4lw
        LYJ247KFrCGoMeRYiAmBqrKftyOZHCwjucYzBEUKLcGRRQQba43IPCXEofBYV0OasSOOAvXc
        KGHGJD4Nm0vj2wInvIpgqLoCmQkPryBQ/Mrb8qAoPvaCRUOGWWCDJWDonic564NgfKvkm0eE
        2AH+tDuayzzsDlkvKyzpPgpgoC+Kw6cgO7OZz2FH+KpvFXDYFf5qq6w5zMKCdnY7D2AFAk1N
        r2VRMPTozaGpLQNvaOrw58onwKjs204J2B4mjQ5cBHsoaSuzlIVwN1fEQR9Qb4RzQoA7zycs
        u6WQPbckKEIeqt1TVP+dotp1VSNePXJmUtmEGIY9nMhc92NlCWxqYozf1aQEDdp6rYFN/Xo7
        6vodpUOYQmI7ocIjJEJEyNLY9AQdAoondhLOpJ2JEAmjZekZjDzpijw1nmF1aC/FFzsLb1p9
        ChfhGFkKc41hkhn5TteasnFRIJxfcC5wcYEskVRKwrwzgx08I0XJpYWREaUd502FJqLDM8QX
        2z2SZAUNLAQWF/folZ2BrmfbrEyKiZmSBf/VoDDDyVXc3xkayPxImRvbfKXNuTSz5/KKx0Ni
        zU2SXS5qOvr5+3LSel2jwwViuuHdrYBctaozw2l9/2BfcB09JOazsbIAH56clf0DdkTVaFYD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsVy+t/xu7rZyj6xBo1TlC02zljPanH9y3NW
        i/lHzrFaXPn6ns1i+t5NbBaT7k9gsTh/fgO7xabH11gtLu+aw2bxufcIo8WM8/uYLNYeuctu
        cbtxBZvFjMkv2Rz4PDat6mTzuHNtD5vH/e7jTB6bl9R79G1ZxejxeZNcAFuUnk1RfmlJqkJG
        fnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbbg6sYC+6oVizuu8re
        wLhEtouRk0NCwETixpnpbCC2kMBSRokfFyIh4hISH9ffYIWwhSX+XOuCqnnCKHHhuQOIzSsQ
        IDHz0DKwuLBAksSCRxfB6tkE3CX+Pb8CZHNxiAh8ZpQ4vOgTC0iCGcS5sSyni5GDg0VAVeLZ
        7SqQMKeAncTtg4/ZQOqFBJqYJZbvXsgEUa8p0br9NzvEEToSb0/1sYD08goISvzdIQxRIi/R
        vHU28wRGwVlIOmYhVM1CUrWAkXkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYDRuO/Zz8w7G
        SxuDDzEKcDAq8fA2KPrECrEmlhVX5h5ilOBgVhLhvVfmGSvEm5JYWZValB9fVJqTWnyI0RTo
        nYnMUqLJ+cBEkVcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1OzW1ILUIpo+Jg1OqgdF7
        UdyD2rMfd/2ay7vb2KBRYavgk+nXbefw/Aqxf3o2qKja+tPMrOItpzjtp7NPu8CnEfdEVdbz
        yNlHrgIN9zgiji3//WPvasGrrv0me250Bh3y3hfpZtFjFdBks//oHNPpfazXmtXFt+XWzVGV
        f/BO5793bmfV4oY+3WD/c0UT9zMr6u2UkVNiKc5INNRiLipOBABwbEbE3AIAAA==
X-CMS-MailID: 20190808132811eucas1p21e22e644189dfdc6f821960ad485c3be
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
        <62557522be4924a01d3822d4734c30f2965c608b.camel@partner.samsung.com>
        <4155482f-8f8f-a659-63ba-25701540b2c5@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Wed, 2019-08-07 at 17:21 +0300, Georgi Djakov wrote:
> Hi Artur,
> 
> On 8/1/19 10:59, Artur Świgoń wrote:
> > Hi Georgi,
> > 
> > On Fri, 2019-07-26 at 11:05 +0300, Georgi Djakov wrote:
> > > Hi Artur,
> > > 
> > > On 7/23/19 15:20, Artur Świgoń wrote:
> > > > This patch adds interconnect functionality to the exynos-bus devfreq
> > > > driver.
> > > > 
> > > > The SoC topology is a graph (or, more specifically, a tree) and most of
> > > > its
> > > > edges are taken from the devfreq parent-child hierarchy (cf.
> > > > Documentation/devicetree/bindings/devfreq/exynos-bus.txt). The previous
> > > > patch adds missing edges to the DT (under the name 'parent'). Due to
> > > > unspecified relative probing order, -EPROBE_DEFER may be propagated to
> > > > guarantee that a child is probed before its parent.
> > > > 
> > > > Each bus is now an interconnect provider and an interconnect node as
> > > > well
> > > > (cf. Documentation/interconnect/interconnect.rst), i.e. every bus
> > > > registers
> > > > itself as a node. Node IDs are not hardcoded but rather assigned at
> > > > runtime, in probing order (subject to the above-mentioned exception
> > > > regarding relative order). This approach allows for using this driver
> > > > with
> > > > various Exynos SoCs.
> > > 
> > > I am not familiar with the Exynos bus topology, but it seems to me that
> > > it's not
> > > represented correctly. An interconnect provider with just a single node
> > > (port)
> > > is odd. I would expect that each provider consists of multiple master and
> > > slave
> > > nodes. This data would be used by a framework to understand what are the
> > > links
> > > and how the traffic flows between the IP blocks and through which buses.
> > 
> > To summarize the exynos-bus topology[1] used by the devfreq driver: There
> > are
> > many data buses for data transfer in Samsung Exynos SoC. Every bus has its
> > own
> > clock. Buses often share power lines, in which case one of the buses on the
> > power line is referred to as 'parent' (or as 'devfreq' in the DT). In the
> > particular case of Exynos4412[1][2], the topology can be expressed as
> > follows:
> > 
> > bus_dmc
> > -- bus_acp
> > -- bus_c2c
> > 
> > bus_leftbus
> > -- bus_rightbus
> > -- bus_display
> > -- bus_fsys
> > -- bus_peri
> > -- bus_mfc
> > 
> > Where bus_dmc and bus_leftbus probably could be referred to as masters, and
> > the
> > following indented nodes as slaves. Patch 08/11 of this RFC additionally
> > adds
> > the following to the DT:
> > 
> > bus_dmc
> > -- bus_leftbus
> > 
> > Which makes the topology a valid tree.
> > 
> > The exynos-bus concept in devfreq[3] is designed in such a way that every
> > bus is
> > probed separately as a platform device, and is a largely independent entity.
> > 
> > This RFC proposes an extension to the existing devfreq driver that basically
> > provides a simple QoS to ensure minimum clock frequency for selected buses
> > (possibly overriding devfreq governor calculations) using the interconnect
> > framework.
> > 
> > The hierarchy is modelled in such a way that every bus is an interconnect
> > node.
> > On the other hand, what is considered an interconnect provider here is quite
> > arbitrary, but for the reasons mentioned in the above paragraph, this RFC
> > assumes that every bus is a provider of itself as a node. Using an
> > alternative
> 
> IIUC, in case we want to transfer data between the display and the memory
> controller, the path would look like this:
> 
> display --> bus_display --> bus_leftbus --> bus_dmc --> memory
> 
> But the bus_display for example would have not one, but two nodes (ports),
> right?  One representing the link to the display controller and another one
> representing the link to bus_leftbus? So i think that all the buses should
> have at least two nodes, to represent each end of the wire.

I do not think we really need that for our simple tree hierarchy. Of course, I
can split every tree node into two nodes/ports (e.g., 'in' for children and
'out' for parent), but neither 'display' nor 'memory' from your diagram above
are registered with the interconnect framework (only buses are). The devfreq
devices used in the driver are virtual anyway.

> > singleton provider approach was deemed more complicated since the 'dev'
> > field in
> > 'struct icc_provider' has to be set to something meaningful and we are tied
> > to
> > the 'samsung,exynos-bus' compatible string in the driver (and multiple
> > instances
> > of exynos-bus probed in indeterminate relative order).
> > 
> 
> Sure, the rest makes sense to me.
> 
> Thanks,
> Georgi

Regards,
-- 
Artur Świgoń
Samsung R&D Institute Poland
Samsung Electronics


