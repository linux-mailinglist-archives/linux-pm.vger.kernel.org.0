Return-Path: <linux-pm+bounces-41156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49232D3C403
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 10:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E83145255C9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Jan 2026 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7B3ED13C;
	Tue, 20 Jan 2026 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iMT36CsX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="if8N8QN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE03D4112
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901443; cv=none; b=DarEIc9RJZfH4Tc7CZPF0bnEOSexxABhHtnVmUe6qStYEZXtwbUx0lt4tv+WlYmkEEWuTyefzAyngP3/2mozodj9jTKFb9d81tz/4dk0k/jcSjuAFJVTyfzvSxOE/BV/8aNXTU+cnXJqHMSJ3JDRvz2xOtnT2NZwvW6XvUm85iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901443; c=relaxed/simple;
	bh=1o93MYzXyEQoidNQDO9X+MefHL0bI14+/1XzaX/j7/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lFj2pPWa44/MGvVeIngpvMrBUpnd7BoGodzu9XsVGPAf24c8gh2eXpt3b1N8ByWhO3R2XkdrH3WXg63VSi7nfeN7T0j/s9sX7B++yAd8wH1kU1lKC3ZzyV2Nx6JyvBvrOt19zt64eO/b26AWquB6KWrfSXjWk38vsQJxwymxLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iMT36CsX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=if8N8QN3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K8mKK33367154
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 09:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wze6O6YqszNAhq5FOUUhRG
	6hL8YVULFliiUs2EAD3O8=; b=iMT36CsXCq3G00whDMzyHfasA/SJ5eoRfW45FV
	ORamBu4yaFt4eupubUFGRe4+lRKBSGY0jtae3ljIGhKLXSqi2r5zYwbrofI5cZMJ
	Ahlw53D+DV7IHQBwUTjkgkVa8MlJWMQrlYiv8dijORGDbRe0Y2zdKfZxdCt7W60z
	rg9lzDDBnmuC12w5aXcJMn2HIvuU6PJj9KgHYLG96TlZs5JGivqA8bF1uU/enhdw
	o62WjsGvL/Tk/Sf+HHTTQTUA7ErJ2w5EQswHHs7nnDJmPjLzrjhlCK2FUdAHDbo2
	l+9eiCVwVhJR8B0/aNyDgZBlwtufXk/JTurxA6ZuJBY2AaGg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsysb1avt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 09:30:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a77040ede0so3490465ad.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Jan 2026 01:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768901440; x=1769506240; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wze6O6YqszNAhq5FOUUhRG6hL8YVULFliiUs2EAD3O8=;
        b=if8N8QN3T7ijW71yIQhOrjsdj6cwd7q5E/TeBPMADsnEfc7IAxteBR/eFq69yShiNR
         KOhRZARn1bpwiayCMgaLxOBVCTmnuJ1DKgJ2GRipXbGSs0a/Vd+CLsX6Rrvf5jZZicTC
         jbs2DnnWMq0NKzAZDdonMyK3MeLD/QpJ4gZg+DPyFyOc9C9Gd4jgSLFEAa3U1EMJqnGz
         l2JXlmNbpGNmuoIjEgY4EKvsu60zV0TBHNrpUs+Lq7IiFO2O2V/rBhYZBzk3VvwdIR9U
         GsQCn3p8JXFwTpY277XQDA/flp5cr9uHrq3OpODn8L8HHIx5PYVv9gEg/HteWaLbuFcx
         cx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901440; x=1769506240;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wze6O6YqszNAhq5FOUUhRG6hL8YVULFliiUs2EAD3O8=;
        b=gIjJWS+JehZPvoR8prlUwbwz04SvuywjF6+2XunNkLONBNarDvj+V4ftBEf9tqgPCt
         vH5HBpLprtlrZyX11hXw05MEK+5gxDNdaGcsOUJz0JEzYwHZVKZxn9gyirn6zEfCIwVs
         DldJIbA4i4fSDgNcDu3aGxWDxWXifUDHsVe1DKpokZi9HMBAFyey3rl+lSnMhuV8Ulk+
         B1F/MQkhBt4/DwTrxOGusVzzSA/3gzdUuA+8TvvfA5PztJG1qQ7z5OvYTR4nuZTl8oOb
         JpUUe/feTE1cRlCfsAflw+LOz3PwZgG+DFdp3yJMMGBAaAVqDXs3KlC5O4r4gd9sWZWw
         Nueg==
X-Forwarded-Encrypted: i=1; AJvYcCWCJZ6huZ+erw1R1/7lLY+nrPhLWmNFPnDsxAUdW+6yyHkzAxeZzAdHKwu9vkx71ma0ucURsbD4GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2F517Dvn45G6ho/rNlUmOFFR9F2ZoN3XxWP4SHbymJLOfdlW
	nvZjNtPvBiZ1wAx2zL9j5F51OyGRt0sNaAafjQC/LsojvK6hG0NoGJmOqWR/aH8v+9CtzRa6pTE
	sKrL4HNSS3bEFjvV1Z1XYQDmI/jqplxrWLEkZdsf/usyyVSoPbpGWtyApYgOfncklt/V8rg==
X-Gm-Gg: AZuq6aImKZiDieVxkk2wjnkri1k5WODMdJ3bSaD8v17WpA9bZh0PChp5IfwgcxsT7B5
	BcuiWMT6BO2HbhIsTnlW4JdlJtHdTOfiwv+n/F+TIOzuJTzB2DwKoehqHKemYXU3SVkdrCk1rf7
	Oxw2nYFVplLDZZcBkE/yeuMqTBTQ6pySEy1T1MaUNRRFMckOCoN0T3oyYJ8fengVXIcDuSJbh0u
	oJTSHJPOnL+4FB1XHZUNUVuMOhUc3RFafLY4F9ovneeAk9rhIk3LOy2zjN3o9CDv0lyJvQIPjdZ
	au6Sg0ASUUbhgv6pnU9cL3ToC9RBE4YwAsrEkOkpUKpDVU3volANSfmfCyyLfwcvNMexMIlUmB3
	CmglmT21TcflHbPkml4VEVSAQNjBibEo+
X-Received: by 2002:a17:903:11d1:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2a769052331mr11978465ad.4.1768901440026;
        Tue, 20 Jan 2026 01:30:40 -0800 (PST)
X-Received: by 2002:a17:903:11d1:b0:2a0:a33f:3049 with SMTP id d9443c01a7336-2a769052331mr11978145ad.4.1768901439498;
        Tue, 20 Jan 2026 01:30:39 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm120132025ad.32.2026.01.20.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:30:38 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 09:30:10 +0000
Subject: [PATCH v3] interconnect: qcom: qcs8300: fix the num_links for nsp
 icc node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-monaco_num_links_fix_nsp_ebi_path-v3-1-536be21ce3ff@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACFLb2kC/5WN3w6CIBhHX8VxHY4/itpV79EaQ8JkCRgoqznfP
 XRddlE333a+/XbOAoLyWgVwzBbgVdRBO5uAHjIge2FvCuprYkAQYQjjBhpnhXTczoYP2t4D7/S
 T2zBy1Wo+iqmHgpV1V3cSI9SB5Bm9Spu9cb4k7nWYnH/tyYi378dO0A/2iCGGhRCEMcJoJejJh
 ZA/ZjFIZ0yeDtgikfwtJklMGkolbmmJi+qLeF3XN83eVd8yAQAA
X-Change-ID: 20260119-monaco_num_links_fix_nsp_ebi_path-a658f8fc100f
To: Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: n2PQCYLKC1N6CzQ9NnXwj22r_IOF7e0i
X-Authority-Analysis: v=2.4 cv=XJ89iAhE c=1 sm=1 tr=0 ts=696f4b41 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=TXf7mWOvGVIf8n0P4FEA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: n2PQCYLKC1N6CzQ9NnXwj22r_IOF7e0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA3OSBTYWx0ZWRfX/NzInhDjMqx+
 TAQ+UH/OCNB1m4TkZIbf0AcFho/ZEtHKwZ1eu23jBUXfwqrBtlN7KX/NiPKcPuqLnjZ3MaHv7oH
 gZqldTdc7ivxu1kSVUGbtQxqJRbHsfV2qruYLgfmh2g48D30PkcVkgyQ7M0xKmejL7NYhC4JcgZ
 Ik7143iRZAWEJE2Ny8JUgK/OCWRsI7/irYDioLTetOPVQQ2dOH4LpFwIvmNjIBp7cJF7NzmkFt8
 h29/8lwPjcjSlsOejDQDQOWhH5I+dxL7iWvwt3TsWl/wpYt91wti7w/iaD1U6/0+ff26hAi+tj8
 L5a++FKp8xeG1lNPWEKwgx7Qs1VVZrEC7wdaEHWxZFCsPHBATMHJP5snYoXAVdjN7Ic5Ugfx/zl
 Gf98yJNb6Y0+Jj7dZIIRXY+x1QWPvFii5YZ/ROBhaFXA2Uia+9gTaPYX5rzytwLDZxN56Noy0Yc
 DkvFeFWt8nyXprzuW2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200079

The qxm_nsp node is configured with an incorrect num_links value,
causing remoteproc driver to fail probing because it cannot acquire the
interconnect path for qxm_nsp -> ebi. This results in the following
error in dmesg:

  platform 26300000.remoteproc: deferred probe pending:
  qcom_q6v5_pas: failed to acquire interconnect path

Set num_links to 2 to match the two link_nodes, allowing remoteproc
clients to obtain the correct path handle and vote on qxm_nsp -> ebi.

Fixes: 874be3339c85 ("interconnect: qcom: qcs8300: convert to dynamic IDs")
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Changes in v3:
- Updated the commit text to relfect the actual error and fix [Dmitry]
- Link to v2: https://lore.kernel.org/r/20260120-monaco_num_links_fix_nsp_ebi_path-v2-1-2933c1b35147@oss.qualcomm.com

Changes in v2:
- Corrected the commit ID mentioned in Fixes tag.
- Link to v1: https://lore.kernel.org/r/20260120-monaco_num_links_fix_nsp_ebi_path-v1-1-4aa2662637a3@oss.qualcomm.com
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


