Return-Path: <linux-pm+bounces-41146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CA6D3BEF3
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 07:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDB2C35F145
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 06:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C02EDD41;
	Tue, 20 Jan 2026 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQ7hs9bg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GFau3M2P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70C32BF26
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768889093; cv=none; b=T12Rt79NjlD9ZyWwtRxOPEHtXfgLEDHL5RucRk7GR2GnUe84aq7haXY3miECp6uDYdxxGupT8At1SF2Ppuz17kX5fZpjPh2dhoGF/7OJj7YGvP9A5MX8jnBl5MqdAiEOM7hWp/vc5LmHfYOtCiJxHIgBw7fNsDxjOPsMC0tLFns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768889093; c=relaxed/simple;
	bh=ydOT8nsbNHiz3uEElCJ7hPLLPlGgtHdgdYTTBHgm0kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XKMCmbnkL5ZWycOJnGrqnZR+ZryiXl5O6XsiwTlmHqTavk/QlA89Ntgxzzdm9Nw8IdPv+obZuE8tG+254sqPFLBGPQgYI2RaP9VHeIDHEo+rLD0SkdXoXwSiuMjtzWl8idpMeYgdqeUDpLuO9XWU6qKeT77HmtoU56ch5uDm+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQ7hs9bg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GFau3M2P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JMCYnN2411126
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 06:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=smf/1bAuapJu3kiBqNjAPA
	XjmFGpvuQVZ9fidHGqGqo=; b=kQ7hs9bglQ/6gc1vXU0KwXDn8FLa3nBNY8kXEP
	5beQONQqhA6AXU3mFcBj3MzuATn1DK5GdtnnnYh3yEiuV44mHQmTLKTtm8m7VTzE
	6cCOT8pZ1bRqPz/apYWZdWqcfsbzhi2IRe66cxRKFPpjxIRxyeMeB3dwT//GDGsk
	D/JnEyZrQt3vbXaXr3Mb70ypjQPbpA70hK30CTYquHuPM02KsxtMySCQdS5W03o/
	uDv816SwQkZ+Lfy77PpEQSBdoKacFDAJL+8o5FkAU+Ir5+dmtgv8Eaa50B3SdO2n
	uyGd9yVe1Gaapfwz+TlDabXIPTY2Yz4+L4hRKKbWERA+3CYQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsnpdj2xm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 06:04:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81f2481ab87so3371444b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Jan 2026 22:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768889087; x=1769493887; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smf/1bAuapJu3kiBqNjAPAXjmFGpvuQVZ9fidHGqGqo=;
        b=GFau3M2PGKPCo5Oiw7BZlr9fc1MaMc0ulJwrfj9iKCeayLvYJsDvMTq3kN2RyhZDdQ
         9LmFIKOIFy1klPUvpWgR69OCqAuwQ8wR3s6w10CgGog0IgdfmkU36BlmvWZ/3jSFppcE
         j1+vIGGxISeBZUFmDezL66m6zMqkoQNtw0XjNwB2TuTDyzB862+zC99evtBWzpmcPBcd
         Lih0zsQ5QJnQKZF80vrapdPJ8bozutstu7pytGZxDpdIduePoeL58U2M12Q+MEwQV4d6
         w3LUqfLFcrVmguZkjEojr+87WqCjgneTmkp16cY4h8kxFh33+JJ216NPzuSYTqo+Jv+u
         FmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768889087; x=1769493887;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smf/1bAuapJu3kiBqNjAPAXjmFGpvuQVZ9fidHGqGqo=;
        b=KU6moHDRU2dBabwqyJihR+S6NF04s+dM3EY4Ow67hzlp5AP3rEtRW5DT5dEznyq9p+
         tza4hP4exvYK+7xNe9Ymd5x7SBdT0uXyG2sqoHsmeEPJQa82xcStBnJ2FOhBpadrGpfI
         vS1wEI9PhrT1URTt7aflzOQyOoegu3ZEhqgt62TjC0C+kxIwRKdvwYX16i626LZA43uS
         S3p9IvxH49sOYweqV1cd2W3LIeHwTgw6ZI/NDXh34IkhjstRSNGgvNVNX/F9/wSEylsM
         w4KbCWXiREjcoZK7Pv0TucrAfFDt5uXxFz4335gWDa3cvMbm2kOhrIpmES4j30iMIWZP
         ug1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyFkX2GJbhWYuTDG1jMxEPRehNhIbwswh3ViT1y06h626LUJABTQ1nfx2i8t987Lw5H9P9AZ+apg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydNP4T8GSikty2IsgUz+eJ7iD+YdLyYMNtQMGtzOHtPS/gW/NW
	eoCAgJdKUluHFomlIWNsTn9/J5ohsWkWG1vLWIeXT0/06oehhjObOWqKizpHLsd/kLrA7hyaThR
	gXzQZQVL4aKd9M/NfK/AyMliIeMiuJHdJWDxJ1CAB6D6dm9NdNbp+ckDmx/cx3E/JMEA49A==
X-Gm-Gg: AZuq6aLYdD8Ov9NeOICcrct40zwpqcjoG2rQ3vGirlC+C+ohxAA3roI8fmfU1F4HJXb
	R56jbk3hp2KTOsL9c2PSbK2T5U/oRWqhavMkd8zuNWigChMVfT9J1cIyUd94pXjJfZLqSZ4AH/d
	FnjPQpewNpWP38/CyrkV29+WPo9VfDZN0/YLQ5H7xSR8I2JcYbFHO0yE4fTIsuiArF0nltFjEP3
	Kh78bQfW6BzvIFft8qEeOZH+KKJK0UJCliR471KJtSyml4GZbDorg9hsDsBNwMT9ncFLBmIplZH
	ngwqDmv4p7G9Fp2AFi8VV7RDfaDuextUxokNzlLGu16p9kTQbrBWjhEuAW6pxHWZm+LK8fpYoVe
	CCnIeVU+U6NncXJyPLhAimiWsAt3Isw+K
X-Received: by 2002:a05:6a00:7585:b0:81f:4c37:7647 with SMTP id d2e1a72fcca58-81fe8a0430bmr791397b3a.68.1768889087273;
        Mon, 19 Jan 2026 22:04:47 -0800 (PST)
X-Received: by 2002:a05:6a00:7585:b0:81f:4c37:7647 with SMTP id d2e1a72fcca58-81fe8a0430bmr791365b3a.68.1768889086768;
        Mon, 19 Jan 2026 22:04:46 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bcf66sm10835533b3a.18.2026.01.19.22.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:04:46 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 06:04:38 +0000
Subject: [PATCH] interconnect: qcom: qcs8300: fix the num_links for nsp icc
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-monaco_num_links_fix_nsp_ebi_path-v1-1-4aa2662637a3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPYab2kC/x2N0QqDMAwAf0XybKEVJm6/MiR0NZ1hMy2NykD89
 xUfD467A5QKk8KjOaDQzspJKri2gTB7eZPhqTJ0tuutc3ezJPEhoWwLflk+ipF/KJqRXozZr7P
 x/W2IQwzO2gi1kwtV53o8x/P8A6yT3XdzAAAA
X-Change-ID: 20260119-monaco_num_links_fix_nsp_ebi_path-a658f8fc100f
To: Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=NtncssdJ c=1 sm=1 tr=0 ts=696f1b00 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vJIYhiubQ-viN7DvkSAA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: KQc7VexoQxq4VJ8WxgxCqtwbbQJ-CkM9
X-Proofpoint-ORIG-GUID: KQc7VexoQxq4VJ8WxgxCqtwbbQJ-CkM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA0OCBTYWx0ZWRfX7FqRHkU4Dd2Z
 TyrjoECABoXoRsYCmXFUqaNADqxZxoj/iEesf32tQbn6xeynWJCSVyjjTuCgj9nqowm7AiI/iWS
 UH+B8DMjn9md8dtSBUOWv6yyN9vo+EJ7Eq++JwFh9j9IYtuvS9aXp0ZKkNTK0ER6xKooAUmYoim
 YlJWAx44WS7OPu7LTrPhdAud2JC23cEzE+xcsUtvPmiNVkw4N8oQJ1qu9ReVmFJf8K2NCQp+rWx
 uWslQkZKAKZJYXVmlorNWsrnCaqs3F4K1UkaQdjqmUQO5OXOuMJWTxLz1AOJk/tNV1pnBBXkJkq
 7Jr1sNKp5MPyMQxTt6gE/tGzDApks2ti1VYwoPhMVp8FlXoiFNOvQP0D2+8TA6k9X0GgCWzjww9
 CQiQ+Vfsy9FfuaR3h1TI99GGCetwzlXlzQRWi9DaC8aCIFSU7GNKjJ3I8yTd0xzRHHwZ1bmV5l0
 xVvPsdlILWUvcLXt70Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200048

Update the num_links to 2 for qxm_nsp node, this will help the clients
to get the required path handle to vote on qxm_nsp->ebi path.

Fixes: ed7a3886957a ("interconnect: qcom: icc-rpmh: drop support for non-dynamic IDS")
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 drivers/interconnect/qcom/qcs8300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/qcs8300.c b/drivers/interconnect/qcom/qcs8300.c
index 70a377bbcf2930a4bdddcf6c3d98e95e4ad92561..bc403a9bf68c65c5e5b312505933f58c5bbeaaf7 100644
--- a/drivers/interconnect/qcom/qcs8300.c
+++ b/drivers/interconnect/qcom/qcs8300.c
@@ -629,7 +629,7 @@ static struct qcom_icc_node qxm_nsp = {
 	.name = "qxm_nsp",
 	.channels = 2,
 	.buswidth = 32,
-	.num_links = 1,
+	.num_links = 2,
 	.link_nodes = { &qns_hcp, &qns_nsp_gemnoc },
 };
 

---
base-commit: f417b7ffcbef7d76b0d8860518f50dae0e7e5eda
change-id: 20260119-monaco_num_links_fix_nsp_ebi_path-a658f8fc100f

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


