Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C702133F4
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCGPR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jul 2020 02:15:17 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38595 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgGCGPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2020 02:15:15 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200703061512epoutp02976a48b66fb8203b8062806c6ec5d6b6~eKXepokMv1768817688epoutp02X
        for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2020 06:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200703061512epoutp02976a48b66fb8203b8062806c6ec5d6b6~eKXepokMv1768817688epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593756912;
        bh=DM8ze/syobNBlPoBYT5dJ5a8bmSOBUJ542zBvrQRJAc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=okFQtKMDPFeflDcMx0Ihl1wZ3rA5LH1xfp87m9QFt/HNUjg/gtE1ZQ40FubPNtmit
         CItV7eMXuv85Z5VyRvCyZKluC/kNJ0qbEtK6QrY49CtFZ5KeHR70QYHZOekDhtTrxb
         UXzAIz+1Dx5y3Va/mPDr+rESLnTMKGWQvKK4Tu8Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200703061511epcas1p2ec67104f13edc4c01fcb2497e5f7621e~eKXd6l_Sf0835008350epcas1p2k;
        Fri,  3 Jul 2020 06:15:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 49yl7K3PmhzMqYm8; Fri,  3 Jul
        2020 06:15:09 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.85.28578.DECCEFE5; Fri,  3 Jul 2020 15:15:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742~eKXbvAZiu3028930289epcas1p1t;
        Fri,  3 Jul 2020 06:15:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200703061508epsmtrp2a99fa86decbad47f6d37da035eb6f9d8~eKXbt_VxJ2442524425epsmtrp2S;
        Fri,  3 Jul 2020 06:15:08 +0000 (GMT)
X-AuditID: b6c32a39-8c9ff70000006fa2-93-5efecced3929
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.2E.08382.CECCEFE5; Fri,  3 Jul 2020 15:15:08 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200703061508epsmtip1a72f338337ec7a16f456fc35cb838528~eKXbcUqwp1305313053epsmtip1i;
        Fri,  3 Jul 2020 06:15:08 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     lukasz.luba@arm.com, k.konieczny@samsung.com, krzk@kernel.org,
        kgene@kernel.org
Cc:     s.nawrocki@samsung.com, willy.mh.wolff.ml@gmail.com,
        b.zolnierkie@samsung.com, cw00.choi@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/2] PM / devfreq: Add delayed timer for polling
Date:   Fri,  3 Jul 2020 15:26:20 +0900
Message-Id: <20200703062622.11773-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnu7bM//iDE7skbTYOGM9q8XEG1dY
        LK5/ec5qseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLBY2tbBb
        3G5cwWZx+E07q8W3E48YHfg91sxbw+ixc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtqhsm4zU
        xJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygk5UUyhJzSoFC
        AYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BZYFesWJucWleel6yfm5VoYGBkamQIUJ2RkzJj9i
        LnjLVjFr7WumBsblrF2MnBwSAiYSG9buYOpi5OIQEtjBKDH12DpGCOcTo8Sc7ZugnG+MEu3f
        u+Fa2p+cZQSxhQT2Mkos2e4AUfSFUeLhtsfMIAk2AS2J/S9usIHYIgKhErPvTWUGKWIW2MUk
        8WXaTLAiYQEXib/XT4EVsQioSmz73Aa0gYODV8BK4suSJIhl8hKrNxwA65UQ+Mguce9xKxNE
        wkWibf53ZghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0dzBKbNl/AeoFY4n9SyczgSxjFtCU
        WL9LHyKsKLHz91ywz5gF+CTefe0Bu0dCgFeio00IokRZ4vKDu1AnSEosbu+EWuUhsefUVBZI
        oMRKrP72iX0Co+wshAULGBlXMYqlFhTnpqcWGxaYIsfSJkZwMtSy3ME4/e0HvUOMTByMhxgl
        OJiVRHgTVP/FCfGmJFZWpRblxxeV5qQWH2I0BYbXRGYp0eR8YDrOK4k3NDUyNja2MDE0MzU0
        VBLndbK+ECckkJ5YkpqdmlqQWgTTx8TBKdXAtOqZ3mYR3mmTbdU+KJ++H3UknUE6KizQw4j5
        96ITc39OVnmYELxUs49BIdrp6Ke8Cs+5725NSfTtOdheeOLOVQbNG3ZbXTbV2x90XasVdqP4
        Lcep18lzDk8SEK+9L7HV6IG96ALTq0Vc4bNCpW5Wb5A7XlSpp6O/PcO0210iJ79u5gnGIIur
        B0Qarp1JduBYUiPPsHrS3qhNMRN2L5t7vjd4+sbYN7VL1998rRXvG/2Qa8Vx7omnj+ic/hK1
        UuCxdkCp6sOHtfpzV65bU7mDXTmJp1Zk9e1NnuKXVS5eLpE+8VEteMda56M3v78/P+FYRaLx
        K3MW7wM/XJdVG038c6As/GAmr/3xx7eVJezviyixFGckGmoxFxUnAgD0Zvv+DwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJLMWRmVeSWpSXmKPExsWy7bCSnO6bM//iDLasNbbYOGM9q8XEG1dY
        LK5/ec5qseDTDFaL/sevmS3On9/AbnG26Q27xabH11gtLu+aw2bxufcIo8WM8/uYLBY2tbBb
        3G5cwWZx+E07q8W3E48YHfg91sxbw+ixc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtigum5TU
        nMyy1CJ9uwSujBmTHzEXvGWrmLX2NVMD43LWLkZODgkBE4n2J2cZuxi5OIQEdjNKdG28wQSR
        kJSYdvEocxcjB5AtLHH4cDFIWEjgE6PEwSawEjYBLYn9L26wgdgiApES5xuOsoHMYRY4xiSx
        /G07C0hCWMBF4u/1U2BFLAKqEts+t7GCzOQVsJL4siQJYpW8xOoNB5gnMPIsYGRYxSiZWlCc
        m55bbFhgmJdarlecmFtcmpeul5yfu4kRHJpamjsYt6/6oHeIkYmD8RCjBAezkghvguq/OCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8NwoXxgkJpCeWpGanphakFsFkmTg4pRqYToadMW5kLfEM
        +Re97oKZA4/VDV1Xmf7cIFaZ2pkPtVd0f7lpYO/IfzNcoHjJzreMFvoKfT710w4oPq+2itgm
        rvXzX8hbl63+TtutH0U8dxV1V6t0br93Inm1qLRO3TJDrdAjgl6tb86vXf3woPYT8Y15C9Mc
        FFo2ms5NcUw1XRT5vTZVRiujXfZm8pmORa1Xtng923JBpyw/iGNy0sZTCqW/5+6Iypdb3W9o
        IeQQ7rhbuMz9+2YW34XruGMLt6k23dX7JB/UMcPulETit0UBHnkqKlvVrZUqd0ld49xY/Dnj
        QdmMdJcrjxj8pou+Ol5+aVGB0aUwzxtic/P7E3ZtTfl1Rm/ivISd2XeV9JVYijMSDbWYi4oT
        AcxCqyq8AgAA
X-CMS-MailID: 20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742
References: <CGME20200703061508epcas1p171aa3c0ab832b77e5837d8bd1e563742@epcas1p1.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the delayed timer to devfreq framework in order to support
the periodical polling mode without stop caused by CPU idle state.
Some Non-CPU device must need to monitor the device status like
utilization regardless of CPU state.

- patch1 explains the detailed reason why the delayed timer is required.
- patch2 initializes that exynos5422-dmc device use delayed timer as default
instead of deferrable timer.

Chanwoo Choi (2):
  PM / devfreq: Add support delayed timer for polling mode
  memory: samsung: exynos5422-dmc: Use delayed timer as default

 Documentation/ABI/testing/sysfs-class-devfreq | 12 +++
 drivers/devfreq/devfreq.c                     | 83 ++++++++++++++++++-
 drivers/memory/samsung/exynos5422-dmc.c       |  1 +
 include/linux/devfreq.h                       |  9 ++
 4 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.17.1

