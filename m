Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE211486A2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2020 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390216AbgAXOPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Jan 2020 09:15:08 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54071 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388688AbgAXOPH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jan 2020 09:15:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200124141506euoutp024647d8ee8e63f73c6df463d0f21ba166~s2DiEKvj32958929589euoutp02V
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200124141506euoutp024647d8ee8e63f73c6df463d0f21ba166~s2DiEKvj32958929589euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1579875306;
        bh=gUt0xdJYsjZMQC8Hykq0BgkZD7XebHRDKl7WMh5ImJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZO49T1yL06/mM2n5FsBo810KcxfRGw8xy28NTxLBfn/w4rw8nAiqes9lOIaXBjWSR
         oCDFyvpZKq793vZqIp4a1o9BehyeFBH50ScK5jCULTHAOfPU2AHkKgiYFZnnkK9yEF
         Z7H5I4DAyseRsgxtuKWURo3aK0xAQfZHw21crvik=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200124141506eucas1p21db2b7c7be7c579acfc5fae3595436cc~s2Dh5JXm41251612516eucas1p2q;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CB.AE.60698.AEBFA2E5; Fri, 24
        Jan 2020 14:15:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200124141506eucas1p2da00cf4424a6b5e5e6d3e245eda586a5~s2DhoVgFe1252312523eucas1p2f;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200124141506eusmtrp2e052e19e4278ccea00a85bb157bf775c~s2Dhnpy7W1590315903eusmtrp2u;
        Fri, 24 Jan 2020 14:15:06 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-0c-5e2afbeae9b0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7D.E1.08375.9EBFA2E5; Fri, 24
        Jan 2020 14:15:06 +0000 (GMT)
Received: from AMDC3218.digital.local (unknown [106.120.51.18]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200124141505eusmtip16ceddbc58b4567e65dfa3a0e0decfdd6~s2Dg_cmfc3274532745eusmtip1e;
        Fri, 24 Jan 2020 14:15:05 +0000 (GMT)
From:   Kamil Konieczny <k.konieczny@samsung.com>
To:     k.konieczny@samsung.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH RESEND 1/3] PM / devfreq: exynos-nocp: fix debug print type
Date:   Fri, 24 Jan 2020 15:14:47 +0100
Message-Id: <20200124141449.19844-2-k.konieczny@samsung.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124141449.19844-1-k.konieczny@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTcRTvv3t373U4u87B/rgwXPhBIzXsw4W0EhIW9kEIhISsW15U2qbs
        Tpcm+cp3qWXpfOET1Fk+lprug+GaiU6dFZr20EDF8kU6C9LKdFfLb+ec3+scOAQiMvBdiWiV
        hlGraIUME6Bdr35aTyxueYX7Fo6KqXZdK596t7HAp6rXdXyqYHYJoazWNpwaSVvGKcPsBJ96
        a6zAKNt9M6B01l4e9dT8Cac+pDZi5xzlBn0OJn9WnyzP79ADuc3gFoKGCfwjGEV0PKP2OXNN
        EFWd8hKPzcdvWYva0RSQg+UCBwKSp2BNzWs0FwgIEdkIYGfeOMY1GwBOz78AXGMDcCWvir8v
        WW+e4nFAA4BptgzwT2Kc/wZ2WRjpA/tGBtHdWkxKYU7tA7sCIQ0InFlatQMuZDDc7Bm1C1DS
        A45V1tq3EpL+MMtYvxd3FJanWuxzBzIA6of1OMdxhoOlc3YfZIeT3lmO7AZAUo9D83LmThqx
        05yH7WlqzscFLg504Fx9BG73VPG4Wgvna/JxTnsXwM9ZaygHnIYfRzexXR+E9IStRh9uHAgH
        KiZRzt4JTq44cys4wYddJQg3FsLsTBHH9oALQ/f2kqQwd7tl7yo5fDLdjxUC97IDx5QdOKbs
        f241QPRAwsSxykiG9VMxWm+WVrJxqkjvGzFKA9j5JMufge/doPfXdRMgCSBzFOqmvcJFfDqe
        TVCaACQQmVgIQj3DRcIIOiGRUcdcVccpGNYEpAQqkwj9ar9eEZGRtIa5yTCxjHof5REOrikg
        dIScqRQ8Ygd1U4e7ZvuDve7oLpzNlkjMTotfimtaGtwrmsKOhdC/tRcbVeK6pLGJtIbZ0kN1
        C/Vbl5Mx94DmYguCNagSm7ShZEHQ8/zVIKy/WxOJHB9aG3e7ZJkL/+Eb2Ja+9r5o+PbjSX0G
        bUIKpCUmUvxGwUvyqOxr1MhQNoo+6YWoWfovHS5wd0UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xu7qvfmvFGazdymSxccZ6VovrX56z
        Wiz4NIPVov/xa2aL8+c3sFucbXrDbrHp8TVWi8u75rBZfO49wmgx4/w+Jou1R+6yW9xuXMHm
        wOOxaVUnm8fmJfUefVtWMXp83iQXwBKlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7Gg4TB7QR97xfnJG1kaGDvZuhg5OSQETCQ+rb7J1MXIxSEk
        sJRRoql7PxNEQlqi8fRqKFtY4s+1LrAGIYFPjBJb7wWC2GwC+hIHz55kAbFFgOo7F00EG8Qs
        sItZYsW02cwgCWEBb4lfO88xgtgsAqoSF+YuAhvEK2Aj0b5rCSvEAnmJ2Y2nweKcArYSq86s
        YodYZiMxZesqRoh6QYmTM5+ALWMGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgTGzrZjPzfvYLy0MfgQowAHoxIP74x7WnFCrIllxZW5hxglOJiVRHgZwzTj
        hHhTEiurUovy44tKc1KLDzGaAj0xkVlKNDkfGNd5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoYZTJFuBVvr5A4rVkyz2vv8ul52ZMkVn7NY3ql1aOixL5kppbn
        vQqLV3VMzbsvW3TFBXLOtGRpdtaadaYn/ohTzGX+7any3MEc2t9lLYJ+PO9ibDSaKZolJX1N
        Qm5vueXKaR9+xvG0LDjY6v6fx3wV68m0oNPz9vHf5JpjYKBy6+z7KytLa7mVWIozEg21mIuK
        EwHshtpWswIAAA==
X-CMS-MailID: 20200124141506eucas1p2da00cf4424a6b5e5e6d3e245eda586a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200124141506eucas1p2da00cf4424a6b5e5e6d3e245eda586a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200124141506eucas1p2da00cf4424a6b5e5e6d3e245eda586a5
References: <20200124141449.19844-1-k.konieczny@samsung.com>
        <CGME20200124141506eucas1p2da00cf4424a6b5e5e6d3e245eda586a5@eucas1p2.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Values printed in dev_dbg are both unsigned long, but were
printed as signed decimals. Change this to unsigned long.

Signed-off-by: Kamil Konieczny <k.konieczny@samsung.com>
---
 drivers/devfreq/event/exynos-nocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-nocp.c b/drivers/devfreq/event/exynos-nocp.c
index ccc531ee6938..ebe9cdf94f54 100644
--- a/drivers/devfreq/event/exynos-nocp.c
+++ b/drivers/devfreq/event/exynos-nocp.c
@@ -167,7 +167,7 @@ static int exynos_nocp_get_event(struct devfreq_event_dev *edev,
 	edata->load_count = ((counter[1] << 16) | counter[0]);
 	edata->total_count = ((counter[3] << 16) | counter[2]);
 
-	dev_dbg(&edev->dev, "%s (event: %ld/%ld)\n", edev->desc->name,
+	dev_dbg(&edev->dev, "%s (event: %lu/%lu)\n", edev->desc->name,
 					edata->load_count, edata->total_count);
 
 	return 0;
-- 
2.25.0

