Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6620C6304D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2019 08:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbfGIGIM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jul 2019 02:08:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:13455 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfGIGIK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2019 02:08:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190709060807epoutp0213b132d3d4eb07b75ffc59806ab52063~vqCh_XiaT2678326783epoutp02V
        for <linux-pm@vger.kernel.org>; Tue,  9 Jul 2019 06:08:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190709060807epoutp0213b132d3d4eb07b75ffc59806ab52063~vqCh_XiaT2678326783epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562652487;
        bh=fBiaLjVRBBfHwy5oM6/n3Hq8ZdYU5NBcVwh0x+P9gVQ=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=tnh6bm5rx3FCteCOGptr7bLoEJ4RKnrhai3XHI3BYBVlQPZQevJBKGf6ieO3xEXLi
         oXpI8eXl8/dY7P8H5L1Lwc0s098ykYYe7mRC38MKuT/KWMfio4LlyJjFw0F6mwhcUo
         H9O+O97ZBkJ35fveiq0SkNd5kWwSQEjk2oSxcMNI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190709060805epcas1p44363f2a3a0bbb79d69ae94bf99c3adf1~vqCfq-XrI2940329403epcas1p4f;
        Tue,  9 Jul 2019 06:08:05 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-5c-5d242f447680
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.30.04139.44F242D5; Tue,  9 Jul 2019 15:08:04 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] devfreq: tegra20: add COMMON_CLK dependency
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kyungmin Park <kyungmin.park@samsung.com>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <87564032-015a-323f-6d15-0abc67f6cc60@samsung.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190709060804epcms1p6222bcb63ae886de2f94246ed92dbdc4b@epcms1p6>
Date:   Tue, 09 Jul 2019 15:08:04 +0900
X-CMS-MailID: 20190709060804epcms1p6222bcb63ae886de2f94246ed92dbdc4b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdlhTT9dFXyXWYMtkDYu/k46xW1z/8pzV
        YvXHx4wWZ5vesFtc3jWHzeJz7xFGBzaP378mMXrsnHWX3aNvyypGj8+b5AJYorJtMlITU1KL
        FFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4CWKymUJeaUAoUCEouL
        lfTtbIryS0tSFTLyi0tslVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM479XcBacICn
        4vCDyawNjJN4uhg5OSQETCRmfbzG2MXIxSEksINR4sTx40AOBwevgKDE3x3CIDXCAi4SD9sO
        MILYQgJKEg039zFDxPUlOh5sA4uzCehKbN1wlwXEFhEokXg/az8byExmgQVAM098YYNYxisx
        o/0pC4QtLbF9+VawZk4Be4lb6xYwQ8RFJW6ufssOY78/Np8RwhaRaL13FqpGUOLBz92MMHNm
        TPkPNbNa4tr0xewgiyUEWhgleldPgSrSlzgz9yTYEbwCvhKN5+4ygdgsAqoS5/beh2p2kdh2
        5Q8riM0soC2xbOFrZlBAMAtoSqzfpQ9Roiix8/dcRogSPol3X3tYYf7aMe8JE4StJnFo9xKo
        +2UkTk9fCHWzh8TS5f3MkIDeyChx/k034wRGhVmIsJ6FZPMshM0LGJlXMYqlFhTnpqcWGxYY
        IkfvJkZwStQy3cE45ZzPIUYBDkYlHl6BQOVYIdbEsuLK3EOMEhzMSiK8+9yBQrwpiZVVqUX5
        8UWlOanFhxhNgQEwkVlKNDkfmK7zSuINTY2MjY0tTAzNTA0NlcR5Mx7KxgoJpCeWpGanphak
        FsH0MXFwSjUwLvZfXqReOj/p4+qyzS+s7ii9Vb8x48/fv+xR0ht/dnLc2rk5sShlOzPvk+KS
        1zXlPzT/xO+/6OF5U8q4Lst9o3RzY6HXX7n13c4mf0KEHl6UC/td92BRpUYso2HF6Sop6/nm
        fvu9Zm5gj7tm9mixyapND2YXq+zjX/NVW4LDLfuZ2VGVr5NeK7EUZyQaajEXFScCAKaGvamf
        AwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190628103243epcas4p133102dfa6709970b1dd49296f82425b2
References: <87564032-015a-323f-6d15-0abc67f6cc60@samsung.com>
        <20190628103232.2467959-1-arnd@arndb.de>
        <CGME20190628103243epcas4p133102dfa6709970b1dd49296f82425b2@epcms1p6>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19. 6. 28. =EC=98=A4=ED=9B=84=207:32,=20Arnd=20Bergmann=20wrote:=0D=0A>=
=20Compile-testing=20the=20new=20driver=20on=20platforms=20without=20CONFIG=
_COMMON_CLK=0D=0A>=20leads=20to=20a=20link=20error:=0D=0A>=20=0D=0A>=20driv=
ers/devfreq/tegra20-devfreq.o:=20In=20function=20=60tegra_devfreq_target':=
=0D=0A>=20tegra20-devfreq.c:(.text+0x288):=20undefined=20reference=20to=20=
=60clk_set_min_rate'=0D=0A>=20=0D=0A>=20Add=20a=20dependency=20on=20COMMON_=
CLK=20to=20avoid=20this.=0D=0A>=20=0D=0A>=20Fixes:=201d39ee8dad6d=20(=22PM=
=20/=20devfreq:=20Introduce=20driver=20for=20NVIDIA=20Tegra20=22)=0D=0A>=20=
Signed-off-by:=20Arnd=20Bergmann=20<arnd=40arndb.de>=0D=0A>=20---=0D=0A>=20=
=20drivers/devfreq/Kconfig=20=7C=201=20+=0D=0A>=20=201=20file=20changed,=20=
1=20insertion(+)=0D=0A>=20=0D=0A>=20diff=20--git=20a/drivers/devfreq/Kconfi=
g=20b/drivers/devfreq/Kconfig=0D=0A>=20index=20f3b242987fd9..defe1d438710=
=20100644=0D=0A>=20---=20a/drivers/devfreq/Kconfig=0D=0A>=20+++=20b/drivers=
/devfreq/Kconfig=0D=0A>=20=40=40=20-107,6=20+107,7=20=40=40=20config=20ARM_=
TEGRA_DEVFREQ=0D=0A>=20=20config=20ARM_TEGRA20_DEVFREQ=0D=0A>=20=20=09trist=
ate=20=22NVIDIA=20Tegra20=20DEVFREQ=20Driver=22=0D=0A>=20=20=09depends=20on=
=20(TEGRA_MC=20&&=20TEGRA20_EMC)=20=7C=7C=20COMPILE_TEST=0D=0A>=20+=09depen=
ds=20on=20COMMON_CLK=0D=0A>=20=20=09select=20DEVFREQ_GOV_SIMPLE_ONDEMAND=0D=
=0A>=20=20=09select=20PM_OPP=0D=0A>=20=20=09help=0D=0A>=20=0D=0A=0D=0AAcked=
-by:=20MyungJoo=20Ham=20<myungjoo.ham=40samsung.com>=0D=0A=0D=0AThanks=21=
=0D=0A=0D=0A=0D=0ACheers,=0D=0AMyungJoo.=0D=0A
