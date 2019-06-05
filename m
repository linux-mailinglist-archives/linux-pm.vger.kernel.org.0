Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6947935956
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfFEJNF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:13:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41749 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEJNF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jun 2019 05:13:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190605091303euoutp015f183f0ac005b1ac337e8539721bec6b~lQoSzSfGd2438824388euoutp01Q
        for <linux-pm@vger.kernel.org>; Wed,  5 Jun 2019 09:13:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190605091303euoutp015f183f0ac005b1ac337e8539721bec6b~lQoSzSfGd2438824388euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1559725983;
        bh=uAr4HlRlPResSve9g+HXLCFQtcYQwj1VJKWl5pq+Cco=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gg8f8aNs+inw2/guDtBReh2tLWxl2DEsyLULr5xW9c+M3wK4hSH4PEK6AeU9ImYfO
         v9ebxOYvg5ps/2ijNoWF3ujMS/c6AaO2lekv20WRs0iSl1nSmLTiUEeiO0F7g/B+dC
         2i0uxDsxfW1skmg8fm62I8HLE0INRGSQg3Umy0d0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190605091302eucas1p2458420373ee5d965e7235ebcbdf8ea44~lQoR3K-Ts2968129681eucas1p20;
        Wed,  5 Jun 2019 09:13:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 06.3A.04377.E9787FC5; Wed,  5
        Jun 2019 10:13:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190605091301eucas1p278a554a15879a1b6fbc3d2bb5168f8cb~lQoQk7IOD2760327603eucas1p2L;
        Wed,  5 Jun 2019 09:13:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190605091301eusmtrp1da26b7753e03460a8ba14d82df7aa2b0~lQoQVKPcW0947509475eusmtrp1W;
        Wed,  5 Jun 2019 09:13:01 +0000 (GMT)
X-AuditID: cbfec7f4-12dff70000001119-2f-5cf7879ea7e6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B0.8A.04140.C9787FC5; Wed,  5
        Jun 2019 10:13:00 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190605091300eusmtip12263c93197a2d80db8a4d40bd5e67eab~lQoPnHS7L2955629556eusmtip1g;
        Wed,  5 Jun 2019 09:13:00 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org,
        l.luba@partner.samsung.com, willy.mh.wolff.ml@gmail.com
Subject: [PATCH v4 0/5] Exynos Performance Monitoring Counters enhancements
Date:   Wed,  5 Jun 2019 11:12:31 +0200
Message-Id: <20190605091236.24263-1-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djPc7rz2r/HGJx6KGaxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FFcNimpOZllqUX6dglcGbfX7mUu2Cxcca3ZroFxOX8XIyeHhICJxJeOq0wg
        tpDACkaJ1nMOXYxcQPYXIHvdViYI5zOjxL97cxhhOk7O3QCVWM4o8f3oJTa4lgXTvjF3MXJw
        sAnoSexYVQjSICKwmFHi2+EokBpmgWVMEvuaPzGB1AgLeEv83xsEUsMioCrx7uR0sAW8AvYS
        fTd2MUMsk5dYveEAM0ivhMAmdon+T7/ZIRIuEq+a7rFB2MISr45vgYrLSJye3MMCYRdLNPQu
        hLq6RuJx/1yoGmuJw8cvsoLcwCygKbF+lz5E2FHi4+VdYKdJCPBJ3HgrCBJmBjInbZvODBHm
        lehoE4Ko1pDY0nOBCcIWk1i+ZhrUcA+JB4c6mCEBGiuxfe5a9gmMcrMQdi1gZFzFKJ5aWpyb
        nlpslJdarlecmFtcmpeul5yfu4kRmHhO/zv+ZQfjrj9JhxgFOBiVeHhnxH+LEWJNLCuuzD3E
        KMHBrCTCm3j7S4wQb0piZVVqUX58UWlOavEhRmkOFiVx3mqGB9FCAumJJanZqakFqUUwWSYO
        TqkGxpIF/7om/pDYY3rr+O/gq7ckC59EiHS9dhY/3Lk+vW5VRfCJvt3VJl9s539orH9mJTWd
        94QYV03hPJP2QwZsTzb+U7npc2etmHuL3KOTnqahx6M9SnI8z807p10hulZYnqeLh52tdK1N
        GSg27/p7yFg/OL7a2X1B41uZSX9qJzw4N2fGnO1KLMUZiYZazEXFiQDMJCDJOAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsVy+t/xu7pz2r/HGCz9Z2mxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFucbXrDbnGrQcZi0+NrrBaXd81hs/jce4TRYsb5fUwWa4/cZbdY
        ev0ik8XtxhVsFq17j7BbHH7Tzmrx7cQjRgdBjzXz1jB67Jx1l91j06pONo/NS+o9Dr7bw+TR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GbfX7mUu2Cxcca3ZroFxOX8XIyeHhICJxMm5G5hAbCGBpYwSx++rQcTFJCbt284O
        YQtL/LnWxdbFyAVU84lR4sLpfUANHBxsAnoSO1YVgsRFBJYzShxb9ZYZxGEW2MYksefKbkaQ
        ImEBb4n/e4NABrEIqEq8OzmdEcTmFbCX6LuxixligbzE6g0HmCcw8ixgZFjFKJJaWpybnlts
        pFecmFtcmpeul5yfu4kRGPTbjv3csoOx613wIUYBDkYlHt4Pid9ihFgTy4orcw8xSnAwK4nw
        Jt7+EiPEm5JYWZValB9fVJqTWnyI0RRo+URmKdHkfGBE5pXEG5oamltYGpobmxubWSiJ83YI
        HIwREkhPLEnNTk0tSC2C6WPi4JRqYIw8srJA/PnlG3svbzB679/pWrEz798f0+ntXs931/gu
        ln4X8+HTQ+fJonptwk+9Js2aybdhOVfHlkX7lidNW2/WrH7KJvFbvLLp40nm6vXOnhN8GjZd
        0eqczKv5wX2dbL656HKhY7GH0n9KrV/h0GIzpbSoOOlhX0zd2U0rsq8qcUpqZNh6WiqxFGck
        GmoxFxUnAgBOb5B4kAIAAA==
X-CMS-MailID: 20190605091301eucas1p278a554a15879a1b6fbc3d2bb5168f8cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190605091301eucas1p278a554a15879a1b6fbc3d2bb5168f8cb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190605091301eucas1p278a554a15879a1b6fbc3d2bb5168f8cb
References: <CGME20190605091301eucas1p278a554a15879a1b6fbc3d2bb5168f8cb@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set extends PPMU on Samsung Exynos by choosing type of data
which shell be counter in the PPMU registers.
It is possible to count e.g. read or write requests, read or write data
or latency.
A new field has been added in the DT 'event' node called 'event-data-type'.
It is them used during the setup of the counter. In the prevoius
implementation there was always one option used: count read+write data.
Sometimes we need more precised information and this patch set tries to
address it.

Changes:
v4:
- changed the way how 'ops' are matched according to Chanwoo's sugestions
  in his example code (added his Signed-off-by to patch 2)
- changed documentation description accoriding to Chanwoo's sugestions
  (added his Signed-off-by to patch 4)
- collected ACKs for patch 1 from Rob and from Chanwoo for patch 2 and
  'Reviewed-by' for patch 1
- patch set is now based on v5.2-rc3 and tested on Odroid u3 
v3 [1]:
- fixed wrong interpretation of ret value during DT parsing, which caused
  alwasy taking default value.
v2 [2]:
 - removed new entry in MAINTAINERS file as suggested by Bartek Zolnierkiewicz
   and added new file to existing list for devfreq events
 - added in the dt-bindings/pmu/exynos_ppmu.h 2 new entries for RO and WO for
   counters in Exynos5433
 - changed initialization with default values when data_type is not provided
   in DT (as sugessted by Chanwoo)
 - added 4th patch which adds 'event-data-type' to 'event' node for Exynos4412
   PPMU events (asked by Chanwoo)

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/4/19/158
[2] https://lkml.org/lkml/2019/4/18/453

Lukasz Luba (5):
  include: dt-bindings: add Performance Monitoring Unit for Exynos
  drivers: devfreq: events: change matching code during probe
  drivers: devfreq: events: extend events by type of counted data
  Documentation: devicetree: add PPMU events description
  DT: arm: exynos4412: add event data type which is monitored

 .../bindings/devfreq/event/exynos-ppmu.txt    | 26 ++++-
 MAINTAINERS                                   |  1 +
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi | 10 ++
 drivers/devfreq/event/exynos-ppmu.c           | 98 +++++++++++++------
 include/dt-bindings/pmu/exynos_ppmu.h         | 25 +++++
 include/linux/devfreq-event.h                 |  6 ++
 6 files changed, 132 insertions(+), 34 deletions(-)
 create mode 100644 include/dt-bindings/pmu/exynos_ppmu.h

-- 
2.17.1

