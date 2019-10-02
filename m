Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3B15C4766
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJBGFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 02:05:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45455 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfJBGFG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 02:05:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20191002060505euoutp012e81eacb783ce5b4a1467567402d1dae~Jv1I_669T1736217362euoutp01B
        for <linux-pm@vger.kernel.org>; Wed,  2 Oct 2019 06:05:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20191002060505euoutp012e81eacb783ce5b4a1467567402d1dae~Jv1I_669T1736217362euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1569996305;
        bh=NytllPukyq1tG+apy35ps0plOj1W2VpVP3xn6Vx8gik=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ldgkn4gpNdt5ySeqR5ExZJ7UrQsA0QYKmnv9gwtW42UBE+MW/LWLjkaWyjKePdRW5
         mmkVE3mz6NQywpJ942CooxgIPwhBxC0NXAnnPdeqH6DBdz6IDPzTLn6q6PNw/n68++
         pkRw1FLOEAOiwYSsQvkzzP9GXLwqclCZLgQ8GAb0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20191002060504eucas1p11367b58f420449a3bdf213e3f5836661~Jv1IJSCTB1488114881eucas1p1H;
        Wed,  2 Oct 2019 06:05:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1F.83.04469.01E349D5; Wed,  2
        Oct 2019 07:05:04 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060503eucas1p25fb14ebbf05a5599f8faeacbd3a15887~Jv1HxvYwO1256612566eucas1p2P;
        Wed,  2 Oct 2019 06:05:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191002060503eusmtrp11c8829126af2ec5c4aa698c30f229c97~Jv1Hw6rtf2145721457eusmtrp1G;
        Wed,  2 Oct 2019 06:05:03 +0000 (GMT)
X-AuditID: cbfec7f2-54fff70000001175-3f-5d943e108bf9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.EB.04117.F0E349D5; Wed,  2
        Oct 2019 07:05:03 +0100 (BST)
Received: from AMDC3778.digital.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191002060502eusmtip21b4ae8910443ee2f13c9788bef9054df~Jv1G3FiKS3183531835eusmtip2p;
        Wed,  2 Oct 2019 06:05:02 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/4] Exynos5 DMC interrupt mode
Date:   Wed,  2 Oct 2019 08:04:51 +0200
Message-Id: <20191002060455.3834-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSf0yMcRzHfZ/nnnuejrOvp8aH0HbTVjalZL6b1grj/PjDH+aPEo6epXVX
        uacfOjYnFDfUQmQpv3K5Urlut6IadZUtukrU2GFOqylNLo0x4/GE/97f9/v1/r7/+XA0X8ks
        4lLSMgVjmk6vUaoUzs5vPStwzIXElaVujty7XMeQwakRhlS4ehhS6B2jidtdz5KneeMseWle
        TOzeFwx5dr9MSXxnXYhcdrdS5K7Lw5LKwT6KvDpWpSQnW1wsaR8vYMj043codp62prwGaZuu
        eFit3XZaqW24dVT7aKKZ0p5z2JDWZ1+6nY1XRScJ+pRswRges1d1YKr5K5XhVB/6ZC5RmNFn
        lQX5cYCj4KtjnLEgFcfjKgTHC78r5McUAvODh5RE8diHwG6L/tsoryidgawInCeKlP8a73uH
        kAVxnBKHQaPtoFQIwDcRTLfHSwyNnRS8tU0zUuCPI6HsdQOStAIHw8VXw6zUVeMYOFerlseC
        oLr+IS11AdtZyO+fRHKwAXryWxlZ+8OHLgcr68XQff6MQtYimM9en+GPgLfw6gyzFtq7+hhp
        i8ahUHc/XLbjoONW7R8b8FwY+jhPsunfsth5iZZtNZzK52U6BBxneilZzwdrTcnM51qo7pj8
        g/M4EZ73rypCS6/8n7qGkA0tELJEQ7IgRqQJOWGiziBmpSWH7U832NHv4+n+2fW5EX3p39eG
        MIc0c9RDO84n8owuW8w1tCHgaE2AOvpHcSKvTtLlmgRj+h5jll4Q21Agp9AsUB+e9TaBx8m6
        TCFVEDIE49+U4vwWmZHlDTaI/A1Pal6ZdefG+pGikEt3moOGBzT+6Rl1scsuMAN5C0c1wpqS
        yF0mC7t5tWl5yFj5pq02yjGk8DxZwrZUG6N8y0yRCeHrc+y+wJZ3o52henTMz1QePMJug/qI
        21XFW7p7jaGbCipydmdZZnuzJ5zrmuL64w0Z+5usoFGIB3QRy2mjqPsFhJGOdjgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xe7r8dlNiDbbt1LLYOGM9q8X1L89Z
        LeYfOcdq0f/4NbPF+fMb2C3ONr1ht7jVIGOx6fE1VovLu+awWXzuPcJoMeP8PiaLtUfuslss
        vX6RyeJ24wo2i9a9R9gtDr9pZ7X4duIRo4Ogx5p5axg9ds66y+6xaVUnm8fmJfUeB9/tYfLo
        27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy
        1CJ9uwS9jC97fjAVbOOt+NAwjaWB8RNXFyMnh4SAicS8+TNZuhi5OIQEljJKfPp9hQUiISYx
        ad92dghbWOLPtS42iKJPjBLrOncxdzFycLAJ6EnsWFUIEhcRWM4ocWzVW2YQh1ngCJPE0dXX
        GEG6hQWMJObc2wxmswioSky9/ZQdpJlXwE6ibx0vxAJ5idUbDjBPYORZwMiwilEktbQ4Nz23
        2EivODG3uDQvXS85P3cTIzDwtx37uWUHY9e74EOMAhyMSjy8DUGTY4VYE8uKK3MPMUpwMCuJ
        8Nr8mRQrxJuSWFmVWpQfX1Sak1p8iNEUaPdEZinR5HxgVOaVxBuaGppbWBqaG5sbm1koifN2
        CByMERJITyxJzU5NLUgtgulj4uCUamDU1t1cxWsYb7Wla12t74ekXcrByWHBrRG5d38nnas+
        efvmou1zhFO9l1TutXj9ccovnom/8hr/95abVbxy+sW26RzD8T0CxsbevL63vppO+3X/fph6
        w6E5O6tE436cy4mccuBs0fm5rI+5hG1erPl9M97WQnTyIqcq6/0ehd9+fv7qdGxL7BYLJZbi
        jERDLeai4kQAjv/6a5ICAAA=
X-CMS-MailID: 20191002060503eucas1p25fb14ebbf05a5599f8faeacbd3a15887
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20191002060503eucas1p25fb14ebbf05a5599f8faeacbd3a15887
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20191002060503eucas1p25fb14ebbf05a5599f8faeacbd3a15887
References: <CGME20191002060503eucas1p25fb14ebbf05a5599f8faeacbd3a15887@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is a v3 patch set for the Exynos5 Dynamic Memory Controller
driver which could be found in Krzysztof's for-next branch [1].

It adds interrupt mode which does not relay on devfreq polling.
Instead of checking the device state by the framework, driver uses local
performance event counters which could trigger interrupt when overflow.
Thanks to this approach the driver avoids issues present in devfreq framework,
when default polling check does not occur.
The algorithm calculates 'busy_time' and 'total_time' needed for devfreq
governors (simple_ondemand) based on requests transactions traffic.

Changes:
v3:
- added information in bindings about interrupt names, since the code is
  sensitive for it as pointed out by Krzysztof
v2:
  changes suggested by Krzysztof
- added interrupt line for the channel 1
- added description for bindings with interrupt lines
- fixed fallback path in probe function
- added comments, blank lines, removed unneeded dev_dbg() in irq handler

Regards,
Lukasz Luba

[1] https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git/log/?h=for-next

Lukasz Luba (4):
  dt-bindings: memory-controllers: Add Exynos5422 DMC interrupts
    description
  ARM: dts: exynos: Add interrupt to DMC controller in Exynos5422
  ARM: dts: exynos: map 0x10000 SFR instead of 0x100 in DMC Exynos5422
  memory: samsung: exynos5422-dmc: Add support for interrupt from
    performance counters

 .../memory-controllers/exynos5422-dmc.txt     |  11 +
 arch/arm/boot/dts/exynos5420.dtsi             |   5 +-
 drivers/memory/samsung/exynos5422-dmc.c       | 345 ++++++++++++++++--
 3 files changed, 335 insertions(+), 26 deletions(-)

-- 
2.17.1

