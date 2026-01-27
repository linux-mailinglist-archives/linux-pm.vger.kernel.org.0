Return-Path: <linux-pm+bounces-41507-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFQnFX8veGn5ogEAu9opvQ
	(envelope-from <linux-pm+bounces-41507-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 04:22:39 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D08F81D
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 04:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9AFD302E7D8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 03:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FE530AAC9;
	Tue, 27 Jan 2026 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fRtpLNGd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6bdcl8K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA62E6CD8
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484155; cv=none; b=VXTOeP2jTHMLZHMEP91Ya/KmprTBz0O2dQpL4guds0QROiIQe8WJ3HGo9za/K6tqQY0dzgzAYZ//Tif/5UoHhDjgaKHjU/1oMvYHQdHyo/7+WzvVjcHM6ciD2UXN2me1+6ijZkXXkbVcHmIF+MfEq+GT2fyd6ZgOx3TRtfJ4PU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484155; c=relaxed/simple;
	bh=XZQ0O1EPnSL7r9FFEsZoC2s4+Kablk8hkQt0H01Xwn8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jwHZvq0TKB3zHuLCx1CRuJZ+Zf10O99Hg+COSU5ZYlYYQPVVobUzG/3GxyyXBrysWOe7fY+GwFapa3ziSY9KGI2zrgg+wdsrqE4TZr8/jbhWiEDc7epX/Yfv5iJM5kav49o9vG/qVifK8s0TG6rXm7UHq1r83TxlCdYeHQFPl9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fRtpLNGd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6bdcl8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgclZ286903
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Wfmi4d4Qh22Ezl3SyesCXU
	AHzPvoIkVgPWXr2K/lMtY=; b=fRtpLNGdPu7rOVRKZl4qqU1dkPde5t1IFi9fUS
	tIW4oFnLpyJQhpcElUT6QTgscvkxePer/ILl4E/QlqA9V3tNoeJHSTG8yKRiWJ/E
	6FcWKQPDUWvs/CmT0vhjfmMpE80wPfe78swlOd8dbw9kEP2/fOOTa/caXaKLVJay
	PjcLx5jsZSJ84vL70zFdn5idzsQfrydmkYW13AYVaSPqSjyP6rHrOsMsv0Rqw6Kh
	tp9Ny0mgzCu9pZaq3CrTnnCc76TX1z2Iw5a+y6NsVRnHX8pyqO8VxvsjaZd0IJxb
	8TS+Y0cijoTfsYg9N0h6sSxlw7LmDyhGNHP2ECYe2eJAb2iw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxdva18ac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 03:22:32 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f25e494c2so57483555ad.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 19:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769484151; x=1770088951; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfmi4d4Qh22Ezl3SyesCXUAHzPvoIkVgPWXr2K/lMtY=;
        b=W6bdcl8K0AzFhp+KcTkSSrcGDmaFVXMCGLmoIEw9m7HiGaeT/+nfzDNllLOlSMVT5R
         CPRDVzFEQo8ZSt9tBjmEE2OTpsmV+a/XkAi8EWtGrm7Q1rHJnBAxYBJ16JP29+o7KT6z
         0olt/51ojiWBISOlkDBIcEOxsdc3gYNnZpJOvm01k50UDY2XzRYwvE4r7nXK4MhalYaD
         QShMpIxFCauMZdcsh5CArsFNvgpJdREalOdX1BE0odv+fycmdKX3sYCQ/cbsdOASnEVv
         8yI9LZCIp5w5DibXuUD/iaEPdGbMn/UHHX7tgHTgCAPUlQnSWA55itwzcrJW9zz21wsO
         /lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484151; x=1770088951;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfmi4d4Qh22Ezl3SyesCXUAHzPvoIkVgPWXr2K/lMtY=;
        b=alMWiqOp2pC0EBhD90ZH4sbdXLpChNdlPeT08YQfWLSVIgPmIDOUM16n42KXhMZfsj
         rrORIGHoVx175MmR6XIrh89XzEwqPuzeLhnZh7cPsqmxj3xc/EgNpPWQBrwOOwEObLtr
         jkKrCJ3RMhVN4AfjU7KdUxLKBe9GrrZS6ZnVmAx724rAQMjrFiSvCv334/A+spK/JmcI
         oqO8qK/DDVEgCBHe/xziATQqUdT8X33TBaJsjJ/FDmcqDeRTUZ8qIM3+jv9M9SJQppQ8
         1BH2ODuq17Z/6dq/4Motbg5XlNeTcyeqIgKUW8QZQPoA1BQrGs2B0b/vOAVogDNujaKg
         vgEA==
X-Forwarded-Encrypted: i=1; AJvYcCXMp3+yaK5xQttEX+0WX8Ex6+rgUuoCTnDqTZ3kVE+oL0mmw5x6236ru3v1nXtSSzbFv2tJn/7EWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhq8kGUCYxJRJIjB0L9M+CHcToO0TQgUuIRX/8uQ/ZQs9w0dmA
	5AgbUrrRhSbHTrv3MkZg5P6os99lw3S6Npziy8SA6+LuNtxPnP98BSA15ec75uN4KyCC29JAODR
	ELwO2LO6m8mQsqIQGcyCpmH1Xn/X3ZtybOwF7kgFEZDxH2enPnXP4dLwX9DqnDg==
X-Gm-Gg: AZuq6aK19+VbdRnU1cWSon2qHLar53wdbGNWm3IaQ7HPFsOJL9BV3ZypakN2/GYq5D1
	OggG1wFdEKj5Byu0V5bKr2RDbj7D1D23hB2Y0026ImgVe4kYJz0FMs3ui0Lrb5v8s89SVfy6UPY
	3m6djsfuxVlj0d5hteZkMyeds1v7/16WTpB04jnCdr1OcKM/AG/xe9M7+NJSF56gdH66rvhiUcg
	W1nBnDzrqr9xR4oC67suwuQDG6AY9bknEx+QEM0jR0U1dGMzyACBm6sFuTFPf1ElrhrrkPgM02J
	X1epv2B8FSqf46tOp+35xDPI1kUlc6bj/B/rls2pBj9W32eRmWR+4Uk6ku0fAWc/JA8AJFQGPip
	sexotRbBk63tzknZ2BLv2NaHvfUEea9SO
X-Received: by 2002:a17:903:190:b0:2a0:7f8b:c0cb with SMTP id d9443c01a7336-2a87120f415mr3332895ad.4.1769484151210;
        Mon, 26 Jan 2026 19:22:31 -0800 (PST)
X-Received: by 2002:a17:903:190:b0:2a0:7f8b:c0cb with SMTP id d9443c01a7336-2a87120f415mr3332685ad.4.1769484150665;
        Mon, 26 Jan 2026 19:22:30 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802daa874sm101341625ad.13.2026.01.26.19.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:22:30 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add interconnect support for Qualcomm Mahua SoC
Date: Tue, 27 Jan 2026 03:22:05 +0000
Message-Id: <20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF0veGkC/23M0QrCIBTG8VcZXudQS+e66j0iwp25dqDN0ibF8
 N1zg2AX3Rz4Hz5+MwnWow3kWMzE24gB3ZhD7AoCvRlvlmKbmwgmFOOC0cH0k7kiAK0Uk4daKa1
 ZQ/L+4W2H79U6X3L3GF7Of1Y6iuX7U/hGiYIyapRswUgjodYnF0L5nMwd3DCU+ZAFi3wL7LcAz
 0ADWkDDdNVx+wdIKX0Bar1q4+oAAAA=
X-Change-ID: 20260120-mahua_icc-76054966880b
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: CdCaqUWqjmTx-rA-1kqhCq3_sFhir1BX
X-Proofpoint-GUID: CdCaqUWqjmTx-rA-1kqhCq3_sFhir1BX
X-Authority-Analysis: v=2.4 cv=I+5ohdgg c=1 sm=1 tr=0 ts=69782f78 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Arc9D6tUohrwRZOLOYkA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyNSBTYWx0ZWRfXzGe6MHVvjrQO
 t4AJHBq9DqVD3QJhJUdQEuY5YJwVa34qP0cLlKf34nqQOUKuTS9rEevy/N3xXy0//8tWsTdKQJO
 CDrJ87H7uTULgkki5aCKsbc/KgrbdM76KucQ+IB3EaOdVWQVdOhAf1hj1KZ5pRPbIgehTazWgft
 xhzmkm6k4X/XFlQUPRPiyu/GxrzQ4YHdsMg4FTLIONcI7p7+7cQ+XLab9sErj2Bpi4Rd4qaEf/Q
 3akVk4AXHJTPX498/75MSiN0IrAeQyaV3wEzn3LFtqnuIZQd64vr+0YJAl6INgtVasF9Sh+NnD7
 lII/6JTOONm7M05pYY835wugJ7SBu7wO6nv+m61e8kCky+KPB3n3dtm0ILmt6Bgh5WQYHplNAvr
 WS7VCkwMKiycnxKmDJBT+m9RytsUiXHxCxOtgh+1Vc2/8k/B5B2LnzDq5LKqdg/QdVD2n7eU9iM
 HVdvhpAOc05PlRrEvDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270025
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41507-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C88D08F81D
X-Rspamd-Action: no action

Mahua is a derivative of the Glymur SoC and shares a significant 
portion of its interconnect topology with Glymur. As such, this 
series extends the existing Glymur interconnect driver to support 
Mahua, reusing common definitions where possible and adding 
SoC-specific configurations where necessary.

Device tree changes aren't part of this series and will be posted
separately.

---
Changes in v2:
- Reuse the Glymur device data for Mahua and override with Mahua
  specific values [Dmitry]
- Update the commit text to be imperative [Dmitry]
- Link to v1: https://lore.kernel.org/r/20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Mahua SoC
      interconnect: qcom: glymur: Add Mahua SoC support

 .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 132 +++++++++++++++++----
 drivers/interconnect/qcom/glymur.c                 |  38 +++++-
 2 files changed, 142 insertions(+), 28 deletions(-)
---
base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
change-id: 20260120-mahua_icc-76054966880b

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


