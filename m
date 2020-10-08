Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1078B286FB3
	for <lists+linux-pm@lfdr.de>; Thu,  8 Oct 2020 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgJHHkz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Oct 2020 03:40:55 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46079 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgJHHku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2020 03:40:50 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201008074048epoutp01914b0f70202b8d6f80c92d597cfb61b6~79G6jfaF61010910109epoutp01g
        for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2020 07:40:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201008074048epoutp01914b0f70202b8d6f80c92d597cfb61b6~79G6jfaF61010910109epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602142848;
        bh=tnVpPq5RduDpY/hro1ifqwIj0aBN5FZ2kF5JbnaqwLE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qbxZ4bkLr6DV4tiUUKscoaFmLTQZVHUH+qozo2oOQB3mUkl+56zCBqDUcXlj3iUb/
         y6w8C1BrkFc2QfLvaWbFom7g3twEn+nHsWpNagcx1L4tggEYKQAt0B+yLWueWjQZJM
         RzH0aJKzuWgHq393v0jGnuXPnCD9iWsWCoY0LX74=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201008074047epcas1p27f32825fc2ab3d151a9e5897349a77ef~79G6Cja2b0879108791epcas1p26;
        Thu,  8 Oct 2020 07:40:47 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.154]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4C6NRH5ZkMzMqYkb; Thu,  8 Oct
        2020 07:40:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.2C.09543.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201008074041epcas1p14111dc3070c66fce8d775e2fbae39f15~79GzypXgW1333513335epcas1p16;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201008074041epsmtrp1134546067f4fa22f6debf47f9d99a476~79GzyAxK72784527845epsmtrp10;
        Thu,  8 Oct 2020 07:40:41 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-cd-5f7ec2790be4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.5D.08745.972CE7F5; Thu,  8 Oct 2020 16:40:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201008074040epsmtip1579bd5b0901662e0c16af30e051e17c6~79GzgNg8y3068830688epsmtip1Q;
        Thu,  8 Oct 2020 07:40:40 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com,
        cw00.choi@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH 0/3] PM / devfreq: Add devfreq_frequency tracepoint to track
 frequency change
Date:   Thu,  8 Oct 2020 16:54:00 +0900
Message-Id: <20201008075403.26181-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmgW7lobp4g45rehYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eLSgQVMFp83PGa0uN24gs1iX8cDJgdOj9kNF1k8WvbdYvfYtKqT
        zeP9vqtsHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQ
        l5ibaqvk4hOg65aZA3SVkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAskCvODG3
        uDQvXS85P9fK0MDAyBSoMCE74+/6n8wFDzkrfqw/wN7AOIGji5GTQ0LAROLthWbmLkYuDiGB
        HYwSRxb/ZodwPjFKdLy6wgLhfGaUWLR2FytMy5f7zVCJXYwSOzbsYIVwvjBKHNtxnxmkik1A
        S2L/ixtsILaIgJXE6f8dYEuYBeYzSvy9+5MRJCEsEC9xrfkAWAOLgKrEz2cH2UFsXqCGpw3L
        2SDWyUus3nAArFlC4BS7xKQtn5ghEi4S/2e8Z4SwhSVeHd/CDmFLSbzsb4OyqyVWnjzCBtHc
        wSixZf8FqCeMJfYvnczUxcgBdJKmxPpd+hBhRYmdv+eCzWQW4JN497WHFaREQoBXoqNNCKJE
        WeLyg7tMELakxOL2Tqg7PSS2td0EO01IIFZi0uVdjBMYZWchLFjAyLiKUSy1oDg3PbXYsMAQ
        OZ42MYLTmpbpDsaJbz/oHWJk4mA8xCjBwawkwpvuXRMvxJuSWFmVWpQfX1Sak1p8iNEUGGAT
        maVEk/OBiTWvJN7Q1MjY2NjCxNDM1NBQSZz34S2FeCGB9MSS1OzU1ILUIpg+Jg5OqQambGv7
        zdwHn91d/a5OzrOhOOaK1MymQF9B5ocnolcoJ1gJT13sNyG8YeIk0yqT89I76o/oL78oPTd6
        /iEFKQuh2Wm3Ww5FlJnqeJ239CvWuDiPb1NW8M78dr5bU+5tvSVcau9ywIyFTXrTb+njAuUR
        q45tWqJ3zTrlZOnbD0+XxJ6ZIceZ/4Ote9aKaYb3m85w+Cv+tOJj9p4t1qN77csnh6RFQu9n
        Xg1PE1WqM//EUen99e6/TVvuSfhaP1Zx4Et4veF866Ku8BlXCl7tF/d5Mql9/fZIAQ/ezOtx
        +40YTwc47bL91Tnprj1jxM5dL58GFCxzS+10ylKv0p0p06k0d/vyzcEJnb6VffMSduxWYinO
        SDTUYi4qTgQATNuNgvQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplluLIzCtJLcpLzFFi42LZdlhJTrfyUF28waJtbBYTb1xhsbj+5Tmr
        xdmmN+wWl3fNYbP43HuE0eLSgQVMFp83PGa0uN24gs1iX8cDJgdOj9kNF1k8WvbdYvfYtKqT
        zeP9vqtsHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXxd/1P5oKHnBU/1h9gb2CcwNHFyMkh
        IWAi8eV+M0sXIxeHkMAORol70/czQiQkJaZdPMrcxcgBZAtLHD5cDFHziVFi4fMGsBo2AS2J
        /S9usIHYIgI2EncXX2MBsZkFljNKzG0VBLGFBWIlTk1dzgxiswioSvx8dpAdxOYVsJJ42rCc
        DWKXvMTqDQeYJzDyLGBkWMUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERxiWlo7GPes
        +qB3iJGJg/EQowQHs5IIb7p3TbwQb0piZVVqUX58UWlOavEhRmkOFiVx3q+zFsYJCaQnlqRm
        p6YWpBbBZJk4OKUamE5PvCprkfdQ6PeGhdOvdAlz5e5rX75ZIMbZ/5rLitRY/5mzux8kKoWL
        P+GYsDleNnrHkivzV+tPjc5IqPWfqX3x4p51RYWP2yfMdmO6vLOi+MeJDffTGLfeufiZdbHH
        5eO6xq80S556PDWsDW7dfOUU55m3TL82aOfd5JWNuCeqeIzT8eTqWUZvr8fZJXc63QiYOnPL
        2t7knctaBV7Ez2JjOvj/wlt3E3km9V+hIhu3PGBpO7W/h0FMo/17y69i6TsTbOprPC+q5HKU
        bzm7dzHT3rnunsbskx22cj2JcWD37r+/bvaEgz93Oh522yX67N2ZgPcHp6ptM1mZ0VFs98r1
        UP4JH2tXXTmH+hmZr1KVWIozEg21mIuKEwER+n0MoAIAAA==
X-CMS-MailID: 20201008074041epcas1p14111dc3070c66fce8d775e2fbae39f15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008074041epcas1p14111dc3070c66fce8d775e2fbae39f15
References: <CGME20201008074041epcas1p14111dc3070c66fce8d775e2fbae39f15@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devfreq_tracepoint to track the correct timing of frequency change
with following information:
- device name
- current frequency
- previous frequency
- load when change frequency
- tracepoint path : /sys/kernel/debug/tracing/events/devfreq_frequency

And add devfreq_update_target() function to unify the frequency change code
on both devfreq core and devfreq passive governor because there are redundant
duplicate code. Lastly, Use fixed indentation size to improve readability
for 'devfreq_monitor' tracepoint.

Matthias already sent the patch[1]. Make patch3 by editing patch[1].
[1]https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2108015.html

Chanwoo Choi (2):
  trace: events: devfreq: Use fixed indentation size to improve readability
  PM / devfreq: Unify frequency change to devfreq_update_target func

Matthias Kaehlcke (1):
  PM / devfreq: Add tracepoint for frequency changes

 drivers/devfreq/devfreq.c          | 37 +++++++++++++++++++++-----
 drivers/devfreq/governor.h         |  1 +
 drivers/devfreq/governor_passive.c | 42 +++++++-----------------------
 include/trace/events/devfreq.h     | 30 ++++++++++++++++++++-
 4 files changed, 70 insertions(+), 40 deletions(-)

-- 
2.17.1

