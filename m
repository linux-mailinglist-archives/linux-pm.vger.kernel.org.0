Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2461C1321C0
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 09:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgAGI6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 03:58:20 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:47741 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGI6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 03:58:19 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200107085817epoutp0374ea58388f400304e1e747e026f44593~njxD1ih6j2237722377epoutp03E
        for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2020 08:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200107085817epoutp0374ea58388f400304e1e747e026f44593~njxD1ih6j2237722377epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1578387497;
        bh=xduV6rhh5+o1JdOJHE6ZCgY3RHSwpf2Qms8mHriv/Yc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kjx5jHwTgIUH+WTGZulkz0g11t+8wQMJNM10zLpdfxph6qQ+yhDlFDuOkxVRhjYb7
         ScOm1QJ/4+TBMicyTLbtX9o9Pdlcrj9dH3UMqbmsciXmkn9moSKb18Vm9XzlTgjkat
         R5ZazLI6HDtHQ84AxIcG0Ls0Em3AkBCr3QM2xVAY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200107085816epcas1p2418d6d3378233d53d17583eb049b4c6b~njxDcXkrw2752827528epcas1p2H;
        Tue,  7 Jan 2020 08:58:16 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.152]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47sR9d1n7LzMqYm2; Tue,  7 Jan
        2020 08:58:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.E9.48019.528441E5; Tue,  7 Jan 2020 17:58:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb~njw-ZL_dK1481014810epcas1p4Z;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200107085812epsmtrp2d05c48a00ac4752a34948d92a0366884~njw-YNosO1554315543epsmtrp24;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
X-AuditID: b6c32a38-257ff7000001bb93-47-5e144825f0c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.42.06569.428441E5; Tue,  7 Jan 2020 17:58:12 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200107085812epsmtip2bbd6f2a0188cd5f39950a9fd63a68e23~njw-Ln0fa2433524335epsmtip2m;
        Tue,  7 Jan 2020 08:58:12 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com, a.swigon@samsung.com,
        m.szyprowski@samsung.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, digetx@gmail.com, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 0/2] PM / devfreq: Add debugfs support
Date:   Tue,  7 Jan 2020 18:05:17 +0900
Message-Id: <20200107090519.3231-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvTaUGrY1v1SlxwDImgQAcoXggYjcaMkUSiDxpjgREmQOiW
        TuueiCCCCwgqPgCiDYqyKRBEXIuIIOAKRgjaiEvUoBQRFxS3KYPRt+/c8//57z33yDFlMeEl
        TzZaOYuR1VOEJ15/0zfQ34dRx2iq7RPQs+IMgDocLhzl9TzCUfenN1JUMfQSoMonTQCNVLdj
        qOZkCrqb9l6GzjqHpKjrchGBhrObAbKn7ZGhqmanDD3ZfZZYMpmpLK4ETFdOtoRpcJ4CzKUC
        p4ypLd9HME8fXyWYGleDhPlZ4MCZnLpywAzXzo723JASkcSxCZzFmzPGmxKSjYmR1Kq1scti
        taEa2p8OQ4sobyNr4CKp5VHR/iuS9cIzKO/NrN4mHEWzPE8FLo6wmGxWzjvJxFsjKc6coDeH
        mQN41sDbjIkB8SZDOK3RBGkFYVxKUnrbDWDOCdh68EwakQpqZu0HHnJIhsCLpSW4m5VkA4CZ
        FdP2A0+BPwJY/zoDF4svAPZ2juB/Hf32WzKxcQ3AO4UvJGLxSSjeD8rcKoL0g463PYSb1WQ4
        7PidhblFGOmQwNxvA5i7oSJD4YG+ljEDTvrA1sF3UjcryDB4u9MlFePmwIrqxjEzJN8QsPPF
        q/HGcthXsVsisgr2t9bJRPaCw65rhMg7YFlbMyGaswCsczwYNwdDx+kjglkuXMkXnr8cKB7P
        hZdGjwM3Y+Qk6Pp8UOqWQFIBs/YqRck82NXnHI+dAUsy941HMfBE9yEgDlIHy4vuE7lgVsG/
        gJMAlINpnJk3JHI8bQ75/5tqwdhu+qEGcPVeVBMg5YCaqMidqYpRStnN/DZDE4ByjFIr/Baq
        Y5SKBHbbds5iirXY9BzfBLTC9PIwr6nxJmHTjdZYWhsUHByMQuhQLU1T0xXykYc6JZnIWrkU
        jjNzlr8+idzDKxVcqK2yFs4OmNDfvvFb3qbWyZXrDreMzs/AFmwY/XFe41/Wteb+Bx+qJOTM
        EbagzLR+Z82U5991+cdT73V/BUPT83XVQXTodfs6evhXftSp0imOY0d3DXy3X1ncGOehbsNB
        6SLdOWJ1+palcWTPCpV0ZJ4q2ybpXRlZlJ/T+9n2tYqhcD6Jpf0wC8/+Ab/haZqxAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvK6Kh0icweN7yhb357UyWpze/47F
        YuKNKywW1788Z7VY/fExo8Wa24cYLX5sOMVssXFBtsXZpjfsFivufmS1uLxrDpvF594jjBYL
        m1rYLdYeuctucbtxBZsDv8eaeWsYPS739TJ57Li7hNFj56y77B6bVnWyedy5tofNY+O7HUwe
        f2ftZ/Ho27KK0ePzJrkArigum5TUnMyy1CJ9uwSujOaTBxkL+vQqepY3sTUwbpTtYuTkkBAw
        kXi18Ch7FyMXh5DAbkaJ221vWCESkhLTLh5l7mLkALKFJQ4fLoao+cQoseXlHrAaNgEtif0v
        brCB2CICNhJ3F19jASliFjjPJNG+fCojSEJYwEyi+8ExdhCbRUBV4vj712DNvAKWEicuvYNa
        Ji+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgSHsZbWDsYTJ+IP
        MQpwMCrx8FpICccJsSaWFVfmHmKU4GBWEuHV0hGJE+JNSaysSi3Kjy8qzUktPsQozcGiJM4r
        n38sUkggPbEkNTs1tSC1CCbLxMEp1cCYsKivTODy1E1PPbYbzloZxbb6n+MZiSV/j0pK5N1M
        El/4+vkbjpmMF/ZnHl/NVbk9X1vvArN7iOFay4nvfAJX236WNt05M3uh7K+j5c5LLh4sKPD2
        CHmyxlNv2hl1/RP73vAtSv2wlaPgQ+jTFWZGO1w+ae/tvlaWsdWpnk9Tc+pamYB5q2o/KLEU
        ZyQaajEXFScCAOiHbypfAgAA
X-CMS-MailID: 20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb
References: <CGME20200107085812epcas1p4eb4f51c2ade10db700fbfd62ab4779fb@epcas1p4.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add debugfs interface to provide debugging information of devfreq device.
It contains 'devfreq_summary' and 'debug_transitions' debugfs file
in order to provide the simple profiling to user via debugfs
without any specific profiling tool.

[Added debugfs file]
- "/sys/kernel/debug/devfreq/devfreq_summary"
  : Show the summary of the registered devfreq devices.
- "/sys/kernel/debug/devfreq/devfreq_transitions"
  : Show the frequency transition of the registered devfreq devices.

Recommend the each patch to check the detailed description
of each fields of both devfreq_summary and devfreq_transitions.

This series contains the patch[1] and add the patch2 for 'devfreq_transitions'
[1] https://patchwork.kernel.org/patch/11320265/
- [v3] PM / devfreq: Add debugfs support with devfreq_summary file


For example on Exynos5422-based Odroid-XU3 board,
- In order to show the multiple governors on devfreq_summay result,
change the governor of devfreq0 from simple_ondemand to userspace.

$ cat /sys/kernel/debug/devfreq/devfreq_summary
dev_name                       dev        parent_dev governor        polling_ms cur_freq_hz  min_freq_hz  max_freq_hz
------------------------------ ---------- ---------- --------------- ---------- ------------ ------------ ------------
10c20000.memory-controller     devfreq0              userspace       0          206000000    165000000    825000000
soc:bus_wcore                  devfreq1              simple_ondemand 50         532000000    88700000     532000000
soc:bus_noc                    devfreq2   devfreq1   passive         0          111000000    66600000     111000000
soc:bus_fsys_apb               devfreq3   devfreq1   passive         0          222000000    111000000    222000000
soc:bus_fsys                   devfreq4   devfreq1   passive         0          200000000    75000000     200000000
soc:bus_fsys2                  devfreq5   devfreq1   passive         0          200000000    75000000     200000000
soc:bus_mfc                    devfreq6   devfreq1   passive         0          333000000    83250000     333000000
soc:bus_gen                    devfreq7   devfreq1   passive         0          266000000    88700000     266000000
soc:bus_peri                   devfreq8   devfreq1   passive         0          66600000     66600000     66600000
soc:bus_g2d                    devfreq9   devfreq1   passive         0          0            83250000     333000000
soc:bus_g2d_acp                devfreq10  devfreq1   passive         0          0            66500000     266000000
soc:bus_jpeg                   devfreq11  devfreq1   passive         0          0            75000000     300000000
soc:bus_jpeg_apb               devfreq12  devfreq1   passive         0          0            83250000     166500000
soc:bus_disp1_fimd             devfreq13  devfreq1   passive         0          0            120000000    200000000
soc:bus_disp1                  devfreq14  devfreq1   passive         0          0            120000000    300000000
soc:bus_gscl_scaler            devfreq15  devfreq1   passive         0          0            150000000    300000000
soc:bus_mscl                   devfreq16  devfreq1   passive         0          0            84000000     666000000

$ cat /sys/kernel/debug/devfreq/devfreq_transitions
time_ms    dev_name                       dev        parent_dev load_% old_freq_hz  new_freq_hz
---------- ------------------------------ ---------- ---------- ---------- ------------ ------------
14600      soc:bus_noc                    devfreq2   devfreq1   0      100000000    67000000
14600      soc:bus_fsys_apb               devfreq3   devfreq1   0      200000000    100000000
14600      soc:bus_fsys                   devfreq4   devfreq1   0      200000000    100000000
14600      soc:bus_fsys2                  devfreq5   devfreq1   0      150000000    75000000
14602      soc:bus_mfc                    devfreq6   devfreq1   0      222000000    96000000
14602      soc:bus_gen                    devfreq7   devfreq1   0      267000000    89000000
14602      soc:bus_g2d                    devfreq9   devfreq1   0      300000000    84000000
14602      soc:bus_g2d_acp                devfreq10  devfreq1   0      267000000    67000000
14602      soc:bus_jpeg                   devfreq11  devfreq1   0      300000000    75000000
14602      soc:bus_jpeg_apb               devfreq12  devfreq1   0      167000000    84000000
14603      soc:bus_disp1_fimd             devfreq13  devfreq1   0      200000000    120000000
14603      soc:bus_disp1                  devfreq14  devfreq1   0      300000000    120000000
14606      soc:bus_gscl_scaler            devfreq15  devfreq1   0      300000000    150000000
14606      soc:bus_mscl                   devfreq16  devfreq1   0      333000000    84000000
14608      soc:bus_wcore                  devfreq1              9      333000000    84000000
14783      10c20000.memory-controller     devfreq0              35     825000000    633000000
15873      soc:bus_wcore                  devfreq1              41     84000000     400000000
15873      soc:bus_noc                    devfreq2   devfreq1   0      67000000     100000000
[snip]


Depends on:
It depends on patch[2] for preventing the merge conflic.
[2] https://patchwork.kernel.org/patch/11320257/
- PM / devfreq: Add missing function description and rename static functions

Chanwoo Choi (2):
  PM / devfreq: Add debugfs support with devfreq_summary file
  PM / devfreq: Add devfreq_transitions debugfs file

 drivers/devfreq/Kconfig            |  13 ++
 drivers/devfreq/devfreq.c          | 206 +++++++++++++++++++++++++++++
 drivers/devfreq/governor.h         |   3 +
 drivers/devfreq/governor_passive.c |   2 +
 include/linux/devfreq.h            |   1 +
 5 files changed, 225 insertions(+)

-- 
2.17.1

