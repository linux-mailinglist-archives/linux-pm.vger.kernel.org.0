Return-Path: <linux-pm+bounces-41700-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEvAKaSae2nOGAIAu9opvQ
	(envelope-from <linux-pm+bounces-41700-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:36:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0AB2FBA
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D5333060541
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 17:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195C350D42;
	Thu, 29 Jan 2026 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TduDiyPb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FGu+ocsO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97034FF57
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708008; cv=none; b=EvVU1OMaKteV7IeJiuvPQjrr8F6HFksTK/XktnDw3rAcYTRL3vtl6hyOxQIgGY2NSbdTmbXohJFv6iBZP/DNadDTBmEzdzxBJXf+jSwwyVOapapWuaAYtlOCLypLubVssB7/ZIIUVfPfoF456Da8vwcOj9UioGKBq14ukY+cZ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708008; c=relaxed/simple;
	bh=cP9ImyPYruN0FeNx01mj+tkT0nwjlqhKHIucgPinDcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFOoB6jRTe8o8d9MIXYvwN0p22FyVI7KA9SYGm2nv29UD7SuFYBMD2qIUnCqXMskPAfkAsgYhGH99BedXhbz++MlsCdXshdT6bdCIkZ7foDCUMYzhnTrqwBo0pO16KqfL9/5vqCDhxVqKgZWs7tC/Cm3eH6zG87XqeVYJadNbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TduDiyPb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FGu+ocsO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAmGAA2953995
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 17:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SXcG6vSc5h00yKZCJrXX/UCp4GEdgmAKFHM
	IjIBgThY=; b=TduDiyPbBDdzPTAjhKcZ36GpeFPAQBYOp+QnDQ3OhmIhhfk6Rx1
	2M/JNzo0HlXND/lX5KgIpx7YKgknykYGyzLWmUhSm2w1cyfRTPwwU/LsOFemDwjm
	WpTHCzq9WXERQ8Qxz0ugraWmITz3EHSka21kOjWYKNJtbZqNU5DsCYfgWAkPDSxE
	gsSPgt1TqQf0gA45oTnHzIFKwH7HiHm4AqJAa1Y+IVqj3Ac2g31txsD9FCMch+1f
	mceTBeU5/At39Pm5bqRuusX/4HdKnGSdnSve6Ffaivm9hVEtIrA30J5qZj50kFqg
	gxG+cHQiY1M0o3/GaFPvrvBNQIgXW9EzNmQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c06421cms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 17:33:26 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82184c384aeso1599622b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 09:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769708005; x=1770312805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SXcG6vSc5h00yKZCJrXX/UCp4GEdgmAKFHMIjIBgThY=;
        b=FGu+ocsOlm4zpBsuoTDoVqBKPmi0p49g0Kkz110U6okk8NjNI4dP0Nns2WwHv18bMA
         4Px5pzAVGoRZCTJo00I/vtpCP1wkt5zbfZlduy9Jc8J2hcxAJT0/AfcPIwGRDw0faGuU
         wPGRL7dzSvtXmUGsAYo37UEH4XHfSkDxxPzqRZpDM4Z+GNZW7nt6+eEXg3BoXUuqf9RU
         P8RoyAbIjm7Qki85rfIF9Aag04DK+1+4JP3ZSioAEEdHOao5khY7SCgoCwwHtLq8JilG
         gzqHIhu7STAw6wFW2/HWoEQ9cPjUvAsV3pIdw/JtsJdSvxqTaGOLbLwe/fnOg4+neXMM
         vKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769708005; x=1770312805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXcG6vSc5h00yKZCJrXX/UCp4GEdgmAKFHMIjIBgThY=;
        b=qzxN8uxaK+gpeix0kq14hrsyEBd1TghrKItQpTHm5XZ9bFg+hPcfhWwxYvotjBgUqy
         EdCHwgieScMlspkUqb8jtd6B/2NhkJrL054Sy0OG2Dg2zhNczA0VTMs9M4Me8edwlfk0
         +U5a+OI0xQ2yp8qWeWzOhOoJEfsTJoqcBXsXwNcnZQ+t5652e2Hv1D3AVQrdmuLUMNgh
         5ed89eRouDGVwB0X55Z8X7umQpV3wiHn4mdczwkTK2iYbzcQ0RbnJnwKDj/GHuotGxMm
         zB6nNzrSOQn2KJ3eBiGp6oXJmR43pdqdHjNYLJ2rysiCjZLjRL0n+c+iMOAEg/5bWNH6
         ST5A==
X-Gm-Message-State: AOJu0YxPLkWAJ+gehndC3HyO8qekD43fwYBqc8QgIQjE6K578uyl0WSn
	+1OXWRrizTiBX8KI7PVkvTZEGI6EtkMHW6FZnYlaE9O9t6g1PPHDJfS9HQY26YYoW2xHavFKWUG
	UalsgfdcN2cMuQENGCXbGTU932X36hnHkV+/oeKRJOzZV5z9JwS2JuEW36/+GkQ==
X-Gm-Gg: AZuq6aLRKMMmGnAvkhJZz5vXYXFdmlG6IHS36F4bBqJbrziJ0tGZakJuqP2/Xr27McW
	XT2K4VGFwVTB6sYHLazWWCW2Rt+fgaldE2ueUUB0aXL7ullensvxKF8hElbVlMHz/EMUCgb6pZg
	tx2HqtEpcBlBNvC4HoMHm9Cv8sBLZhpEBBhnU6xrUU0IDQk844NVQnbZ1Aef46QELwWJuSZU4Ta
	jM6x2nkRpKmTaT5jsubusR9a5lfI8YHrdUruXRhyF2l77l8dkJv/kVB1bV9337Qz/vSDC5zIloN
	+E+uXUS0XcNDVVPkTNYbnS944H6jNIY9sNMIlS3vZfqeXN8WzpeSl3e9aeqc91/b4a42zhbbB3f
	3xZcKSHVSI5Q8CkcUr5Yj0Y3eCQ==
X-Received: by 2002:a05:6a00:1893:b0:81f:b1d4:b486 with SMTP id d2e1a72fcca58-8236917312amr8954557b3a.8.1769708005335;
        Thu, 29 Jan 2026 09:33:25 -0800 (PST)
X-Received: by 2002:a05:6a00:1893:b0:81f:b1d4:b486 with SMTP id d2e1a72fcca58-8236917312amr8954525b3a.8.1769708004687;
        Thu, 29 Jan 2026 09:33:24 -0800 (PST)
Received: from work ([120.56.206.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b19a9esm7140604b3a.11.2026.01.29.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 09:33:24 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] OPP: debugfs: Use performance level to distinguish between rates
Date: Thu, 29 Jan 2026 23:03:10 +0530
Message-ID: <20260129173310.7241-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyNCBTYWx0ZWRfX6Chhk7KJ2YDZ
 6BAcvlfLxQWqyqtzWWSLgqiJWKa7TF3caE9t/K4PhmIkt1boaTCf/a5Qy1TiIiQgp7Bp1SoZSSg
 el1Z79iCdxjQsYSKX4EM3pDKdIIiAsCHZz5miNx6W5urOqdMx8X6leO7HlKuoPm956uVI2Y2JeN
 5qHsWCD8+1PU548wGzfGmgven3dQA3n2us+8KolwKPh52+43LYyxmG/uNlUPeQXo5HS4+h7zj5Q
 8rwF70ktb3AfxKR/fki+9RzoFKquATyCrDheDmU2z8WNDpJQ0rPKIlDSxOZmrHIIDCIiG0EHX2P
 ZQsslAm0aeDAt6DLHIRgrij20SFUGW8SgwSblWs3Xu/5GsK6zb7OhfcHNRbDsH+CGdpAKU2RSrf
 IjCU2R9O5sK0zuKtLrmgyse9rsoPsJp5rmBcrIjeNguFdUwf7Ucxz+DDdsEulw46AubtZaNSKHy
 XUogrj60pxa2U4DN0vg==
X-Proofpoint-GUID: JMwiqkazUI1B8r9ZFeOvWQjwDoiILFfe
X-Proofpoint-ORIG-GUID: JMwiqkazUI1B8r9ZFeOvWQjwDoiILFfe
X-Authority-Analysis: v=2.4 cv=dpTWylg4 c=1 sm=1 tr=0 ts=697b99e6 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=P6uRILVbsMQsecLiYV1+kQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LWgc-Xqq43gjV1u_ZOYA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290124
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41700-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 16D0AB2FBA
X-Rspamd-Action: no action

Some OPP tables have entries with same rate and different performance
level. For these entries, using only the rate as the debugfs directory name
causes below error:

debugfs: 'opp:5000000' already exists in 'soc@0-1c00000.pci'

Fix it by appending the performance level to the dir name.

Reported-by: Bjorn Andersson <andersson@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/75lzykd37zdvrks5i2bb4zb2yzjtm25kv3hegmikndkbr772mz@w2ykff3ny45u/
Fixes: 05db35963eef ("OPP: Add support to find OPP for a set of keys")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/opp/debugfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 8fc6238b1728..7c912bae2a5a 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -131,21 +131,24 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	struct dentry *pdentry = opp_table->dentry;
 	struct dentry *d;
 	unsigned long id;
-	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
+	char name[36];	/* "opp:"(4) + u64(20) + "-" (1) + u32(10) + NULL(1) */
 
 	/*
 	 * Get directory name for OPP.
 	 *
-	 * - Normally rate is unique to each OPP, use it to get unique opp-name.
+	 * - Normally rate is unique to each OPP, use it to get unique opp-name,
+	 *   together with performance level.
 	 * - For some devices rate isn't available or there are multiple, use
 	 *   index instead for them.
 	 */
-	if (likely(opp_table->clk_count == 1 && opp->rates[0]))
+	if (likely(opp_table->clk_count == 1 && opp->rates[0])) {
 		id = opp->rates[0];
-	else
+		snprintf(name, sizeof(name), "opp:%lu-%u", id, opp->level);
+	} else {
 		id = _get_opp_count(opp_table);
+		snprintf(name, sizeof(name), "opp:%lu", id);
+	}
 
-	snprintf(name, sizeof(name), "opp:%lu", id);
 
 	/* Create per-opp directory */
 	d = debugfs_create_dir(name, pdentry);
-- 
2.51.0


