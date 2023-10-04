Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BB17B774D
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 07:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjJDFCE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 01:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjJDFCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 01:02:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B5FA6;
        Tue,  3 Oct 2023 22:02:00 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3942Xudf016524;
        Wed, 4 Oct 2023 05:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : to : cc; s=qcppdkim1;
 bh=7stBalUr+luy/UVW3dA3HNgXxTFtd6v/gQFYhH6UzTM=;
 b=aJq/6IsT4QbXMfewgk2HmjDroHeKnYI0LccAL4jtqIiEOgF9p3c8SPmT2Fg3GY64BAvE
 /HHsuUsriDIOHnhEcr8XA5fFJJJ/66mwcDe01UGg8cMqs68TEXBeewPbTOeWObFqXpX/
 gr4cWqA1iH5hBMW7OVKqxwIvtd536/4NHWcuVdEGA/dP0zXJWUItDwMtY8iEGxVsF9dN
 xvoKOCvLq1mFqXP+ct7r0VUI08DC0OmvT4cSL9LR5AJFxmBaixHhJV5K4OjK3PHbzHY4
 1p3ZKTRXEiFQ7PMVyjxZd55mhi4d+4SdWQij0GtwH4JwYQGLmBVr94Vt6VZSpLqSavRw IA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgr9mgxv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Oct 2023 05:01:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39451iLO031316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 4 Oct 2023 05:01:44 GMT
Received: from [10.213.108.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 22:01:36 -0700
From:   Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Date:   Wed, 4 Oct 2023 10:31:15 +0530
Subject: [PATCH v2] PM: hibernate: Fix a bug in copying the zero bitmap to
 safe pages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231004-hib_zero_bitmap_fix-v2-1-6a530b7b6e98@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJrxHGUC/32NQQ6CMBBFr0JmbU2pVsGV9zCkaYdBZgHFFolKe
 ncrB3D5XvLfXyFSYIpwKVYItHBkP2ZQuwKwt+OdBLeZQUl1kLWqRc/OfCh443ge7GQ6fgmHuqq
 O5Ky0BHk5Bcp6q96azD3H2Yf3drKUP/u/t5SiFCfsWnTnSistr48nI4+4Rz9Ak1L6AgK5zrK4A
 AAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>
CC:     Brian Geffon <bgeffon@google.com>, <kernel@quicinc.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        stable <stable@kernel.org>,
        "Pavankumar Kondeti" <quic_pkondeti@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v_NUGgMmBYWdvWNjA-0DH6Q22lNtwJ0Y
X-Proofpoint-ORIG-GUID: v_NUGgMmBYWdvWNjA-0DH6Q22lNtwJ0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1011
 mlxlogscore=689 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040035
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following crash is observed 100% of the time during resume from
the hibernation on a x86 QEMU system.

[   12.931887]  ? __die_body+0x1a/0x60
[   12.932324]  ? page_fault_oops+0x156/0x420
[   12.932824]  ? search_exception_tables+0x37/0x50
[   12.933389]  ? fixup_exception+0x21/0x300
[   12.933889]  ? exc_page_fault+0x69/0x150
[   12.934371]  ? asm_exc_page_fault+0x26/0x30
[   12.934869]  ? get_buffer.constprop.0+0xac/0x100
[   12.935428]  snapshot_write_next+0x7c/0x9f0
[   12.935929]  ? submit_bio_noacct_nocheck+0x2c2/0x370
[   12.936530]  ? submit_bio_noacct+0x44/0x2c0
[   12.937035]  ? hib_submit_io+0xa5/0x110
[   12.937501]  load_image+0x83/0x1a0
[   12.937919]  swsusp_read+0x17f/0x1d0
[   12.938355]  ? create_basic_memory_bitmaps+0x1b7/0x240
[   12.938967]  load_image_and_restore+0x45/0xc0
[   12.939494]  software_resume+0x13c/0x180
[   12.939994]  resume_store+0xa3/0x1d0

The commit being fixed introduced a bug in copying the zero bitmap
to safe pages. A temporary bitmap is allocated with PG_ANY flag in
prepare_image() to make a copy of zero bitmap after the unsafe pages
are marked. Freeing this temporary bitmap with PG_UNSAFE_KEEP later
results in an inconsistent state of unsafe pages. Since free bit is
left as is for this temporary bitmap after free, these pages are
treated as unsafe pages when they are allocated again. This results
in incorrect calculation of the number of pages pre-allocated for the
image.

nr_pages = (nr_zero_pages + nr_copy_pages) - nr_highmem - allocated_unsafe_pages;

The allocate_unsafe_pages is estimated to be higher than the actual
which results in running short of pages in safe_pages_list. Hence the
crash is observed in get_buffer() due to NULL pointer access of
safe_pages_list.

Fix this issue by creating the temporary zero bitmap from safe pages
(free bit not set) so that the corresponding free bits can be cleared while
freeing this bitmap.

Cc: stable <stable@kernel.org>
Fixes: 005e8dddd497 ("PM: hibernate: don't store zero pages in the image file")
Suggested-by:: Brian Geffon <bgeffon@google.com>
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
Changes in v2:
- Allocate zero bit map from safe pages as suggested by Brian
- Link to v1: https://lore.kernel.org/r/20230929-hib_zero_bitmap_fix-v1-1-6cfdcb785250@quicinc.com
---
 kernel/power/snapshot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 87e9f7e2bdc0..0f12e0a97e43 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2647,7 +2647,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 	memory_bm_free(bm, PG_UNSAFE_KEEP);
 
 	/* Make a copy of zero_bm so it can be created in safe pages */
-	error = memory_bm_create(&tmp, GFP_ATOMIC, PG_ANY);
+	error = memory_bm_create(&tmp, GFP_ATOMIC, PG_SAFE);
 	if (error)
 		goto Free;
 
@@ -2660,7 +2660,7 @@ static int prepare_image(struct memory_bitmap *new_bm, struct memory_bitmap *bm,
 		goto Free;
 
 	duplicate_memory_bitmap(zero_bm, &tmp);
-	memory_bm_free(&tmp, PG_UNSAFE_KEEP);
+	memory_bm_free(&tmp, PG_UNSAFE_CLEAR);
 	/* At this point zero_bm is in safe pages and it can be used for restoring. */
 
 	if (nr_highmem > 0) {

---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20230929-hib_zero_bitmap_fix-bc5884eba0ae

Best regards,
-- 
Pavankumar Kondeti <quic_pkondeti@quicinc.com>

