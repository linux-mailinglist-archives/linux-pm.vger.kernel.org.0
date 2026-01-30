Return-Path: <linux-pm+bounces-41757-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEXOG6BbfGkYMAIAu9opvQ
	(envelope-from <linux-pm+bounces-41757-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:20:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD97CB7D7E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 08:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61658301224E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A4309F08;
	Fri, 30 Jan 2026 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkkK08jf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XTOZFvrb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4E2FC024
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757592; cv=none; b=pq9xs3LaQkAIZx6XBfui2iM+zYVl0cPlNOOEZA2fv7MvMu8umwCk9lhoM1TaYFELl2jkGKwBtszPYMWx5gZDhWI8tOjzl8ApTSPAQbvnmi8alwRuGnFg+r12091OBHD6TvG/Jm2W9QfQpDFJwOjDCL+OV6nFaakA8fSHcbgSPxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757592; c=relaxed/simple;
	bh=XbqXCUGickOIvAHuTScPhFbiiOhmUvouEQJa9UTNZbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aAnWDLUl27goRsUVf2MSTcKtTXKi4MhG5v7RnqtrgCQ2brXxG1ot+gxinXsde5A/u0iP8IG9JL14WSbVKqzAI+jMZnEB3CQOLyaox2HUSQtZut8uVMgZJE8YRrZG5KNLclppcq4zOS/jw9joIRFSLonxhF0WIZxWw+uo2WP9G1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkkK08jf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XTOZFvrb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U7GQur2413622
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=efUT9YVinjOUDB9FWngFq5/PMyszXgXdXEr
	rMvlcZCs=; b=RkkK08jfUFzmo/UaHmZy0S/mALQWROnwi4sfPRmoMA+d1Jxafpg
	+ZsWaJGdtHoSHCr+2VHVpw8D1t7Hck0PLuH5Hmo746V+ekZzrEgYlJ38eQtzyPWk
	q9JDwrwSp1T1iXHRLtTR9OAfsPkfBh4+y/G1wsl8yVSuiWYsMRzeVWE6CuN2p0pW
	FCQvhJpGRVFUpbx8vVQa8j1qVVYJYlqyys65x87YuFLcHAQb7qBYUPcxjqyIqfF0
	rnTavZVa4DHc36LFdR4aEIGgnhUbKpMXubfufyjUVGXi0Od2rmr92x1S/takiUKb
	ke72ywqvYUH55Z6HHOsVGkzx4dYoxzTerQQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41g0a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 07:19:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c5269fcecdeso1177376a12.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 23:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769757589; x=1770362389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efUT9YVinjOUDB9FWngFq5/PMyszXgXdXErrMvlcZCs=;
        b=XTOZFvrbwwa6+MSluoqINW8HNS8gE1krAmc8N3GmPYwa1NOIvXCgsYi9b3gV8EOXng
         lMoHJgEe0Q0LNbZzemanC39vlh7SRvlrrJN6cLast+furiBwRBz6wazh6eNabMT//2Pw
         8hA6vbnPjo7SVYOUAuUHW6XoeMLe6IF2VqhuQLaQljxX8So7xj7QB4YtAt95J4fc9O8h
         iFI1ShDmBVwvi4OclfeJWO2JJKJptuR4PqDkjbrR0sdYh7yRqdusyHzlEEySPbfJ+cFL
         vk0bn93ZJMvYgPXXgA3gg3DaEk9JOfyQwKgQ2SnjoxEdk+8W/6bQlH2Rvl5r0hc2BW8N
         iBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769757589; x=1770362389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efUT9YVinjOUDB9FWngFq5/PMyszXgXdXErrMvlcZCs=;
        b=YsE/Ks6AgGvnlLzJga+xBfU0ohihVbwBFNURrUayKQYZGO3etBmSBvnTkAkiNJJpgH
         muZOIX1RnAnwbUolCfNjn7UqmlLdq9bLMPAA1uf3s8YQ9wLlqAkuNQGtLNhpK7I8oNZS
         XAWnptYf61+GoMERn/3Y0L7RgbmfR2VHYNuZvewCe6z74SKQM9EhH+QdYwUly581U6Co
         XnMTT1t8MBEg3yRY92RHxjUCy+CtPylM8a6lUuL6xuAmEtkCbUZKCbh22dg/TkNozzb/
         luXD50vRj0i0bBG7F96kGUc2UI0NaTEtavC7juirn7zYOH/XOGwABUW4+rVZ702Y0SFx
         Vfww==
X-Gm-Message-State: AOJu0YxyC+1d4EoCkl540j3N0JmY3OHNpHMQEi92J7qZthWSXE7kH08X
	ROWOgSKc04piqQqzCkN66hpUiJrlzw22qsw3VwdTgeehTj3tydJAR45Q2R0P+rHdd7aB1Pp7vkW
	KIpCQMVPVoTe/SMw+GYB5ap+X01FqaBIgya6HA5BMzHnxF5KECqJNfV48j05DEw==
X-Gm-Gg: AZuq6aKu63TAf6Lf/PhQS/Nm6nYxa/72fr8Oddw9cW3U2b/XVEbfUgUYcfCXe4wl08X
	xX827yOTuF22PSn9MG9j1fiLU1ymZ6zDJ+L8EDZJwiNIMabaD/fnIZMzDtQqC4MXuvk3DpzqB59
	zj0Cb3WmOjZzGrpWnXESRoQDvagvr18BlritGwuuVCFE4QUco2lYcEtzmYcLJQHBlYr/BkPQ10S
	MAYNzY9/gLPf4eUMqLJ1SlCeDXZN7Db1mW6Ee0lXZW2hvwWUmrQ7L5mIdrDoGpi8r1pJEaOlPVv
	j/ktCijFUGJ+BDDOYfq41GYjcj5UHewfdZACSEWjQbZtORc1Kf1A8Tlllcgwqx2nobsR58BxV3L
	Q9XqJXuu56AhWa0AIC21YzOZ9Iw==
X-Received: by 2002:a05:6a20:7491:b0:35e:86d3:88ca with SMTP id adf61e73a8af0-392e015d37amr1825914637.59.1769757588516;
        Thu, 29 Jan 2026 23:19:48 -0800 (PST)
X-Received: by 2002:a05:6a20:7491:b0:35e:86d3:88ca with SMTP id adf61e73a8af0-392e015d37amr1825891637.59.1769757587969;
        Thu, 29 Jan 2026 23:19:47 -0800 (PST)
Received: from work ([120.60.134.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6432e27aa5sm6627128a12.6.2026.01.29.23.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 23:19:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2] OPP: debugfs: Use performance level if available to distinguish between rates
Date: Fri, 30 Jan 2026 12:49:40 +0530
Message-ID: <20260130071940.6949-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HwbUaJK24PHQmSVlWzcMGX72GY3Q_kH7
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697c5b95 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=2V1Ify4SBoSVV1xbfEOURw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UdqTqlS5sJmFKW4WO-8A:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: HwbUaJK24PHQmSVlWzcMGX72GY3Q_kH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA1NSBTYWx0ZWRfX7Ju46JRFqwZV
 2s6aayVQAUkUj0CSLgn53ecRzGCodgWBNy5Tbmmb0xUoFFtcNJcWfm5Izs4GI4WuKu6+NWm6qVt
 LXgRlsN0j9nvo/qNrdxMx85TbsUhG2vf4/uUDjJbBeX8je77NWQMVtEmvMu5gr8jGqye8i4MdA0
 St9+Lo0Kg8r0o40tdUZ2zjGtJWVt0KUSuS5UNF+BO5SkG4QiIfgLRdHpdd0sclYHVV3HzRtz8T5
 6K0GAEKOWAGZ5zU1MBMcVGjscVSAQLGGC/+HiuWivR8Z5TP6xpAHaki1Q4vZcTrxN2vDjSHdRdI
 MskzHxCWKkcJo8cCFiMP+6N3K6ue7MJFuk79DUIu9TXzS5bAfU7qbGdMxD8itYMeUY2grW5PsMi
 kibiBO3SiTb9+L6rK3W5BOyYVZJvgAvJsfB0f6TiwnwuEpCOICxZOwTfhj9A1S8GAW9UB7EaRx5
 4I9AMG+xgJ8RIUR1vIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300055
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
	TAGGED_FROM(0.00)[bounces-41757-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD97CB7D7E
X-Rspamd-Action: no action

Some OPP tables have entries with same rate and different performance
level. For these entries, using only the rate as the debugfs directory name
causes below error:

debugfs: 'opp:5000000' already exists in 'soc@0-1c00000.pci'

Fix it by appending the performance level to the dir name if available.

Reported-by: Bjorn Andersson <andersson@kernel.org>
Closes: https://lore.kernel.org/linux-arm-msm/75lzykd37zdvrks5i2bb4zb2yzjtm25kv3hegmikndkbr772mz@w2ykff3ny45u/
Fixes: 05db35963eef ("OPP: Add support to find OPP for a set of keys")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Changes in v2:

- Used OPP_LEVEL_UNSET check

 drivers/opp/debugfs.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 8fc6238b1728..61506d30d5ff 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -130,22 +130,24 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 {
 	struct dentry *pdentry = opp_table->dentry;
 	struct dentry *d;
-	unsigned long id;
-	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
+	char name[36];	/* "opp:"(4) + u64(20) + "-" (1) + u32(10) + NULL(1) */
 
 	/*
 	 * Get directory name for OPP.
 	 *
-	 * - Normally rate is unique to each OPP, use it to get unique opp-name.
+	 * - Normally rate is unique to each OPP, use it to get unique opp-name,
+	 *   together with performance level if available.
 	 * - For some devices rate isn't available or there are multiple, use
 	 *   index instead for them.
 	 */
-	if (likely(opp_table->clk_count == 1 && opp->rates[0]))
-		id = opp->rates[0];
-	else
-		id = _get_opp_count(opp_table);
-
-	snprintf(name, sizeof(name), "opp:%lu", id);
+	if (likely(opp_table->clk_count == 1 && opp->rates[0])) {
+		if (opp->level == OPP_LEVEL_UNSET)
+			snprintf(name, sizeof(name), "opp:%lu", opp->rates[0]);
+		else
+			snprintf(name, sizeof(name), "opp:%lu-%u", opp->rates[0], opp->level);
+	} else {
+		snprintf(name, sizeof(name), "opp:%u", _get_opp_count(opp_table));
+	}
 
 	/* Create per-opp directory */
 	d = debugfs_create_dir(name, pdentry);
-- 
2.51.0


