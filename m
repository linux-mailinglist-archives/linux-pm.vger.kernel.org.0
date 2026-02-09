Return-Path: <linux-pm+bounces-42331-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDe2FL+siWndAgUAu9opvQ
	(envelope-from <linux-pm+bounces-42331-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 10:45:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C210DB2A
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 10:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BCB730138B3
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 09:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB63365A08;
	Mon,  9 Feb 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHrbrj97";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f7Hb7Faa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682723659F1
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 09:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770630332; cv=none; b=twDIF1aq9cuC0J0FKYyS++QPdmvzzO5Z7usyO1NUwjBijIS4j1dguid/AFK2tFq5FDPNsqxqlNUoV4sNS9EfqOiehyTIqPGevOGHYGZf0F93oPQhTQhnlO0xtoRX1vA+Pghu4IXh+3xuhYOYUtFAqfbOGPNulVAbuH6RzHMm1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770630332; c=relaxed/simple;
	bh=o8/PIwBkeR9gGZN9AzJuVfl1qjlAeL97uXZ3IGiXXWw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BIaJ5MNMDWLneizs1mizlDXFKmi1IVeGzuf8wHjhWx97IsPH0Ajc03i6+3DjpVruzPEbubsH9C2HRxNW5cIwRlGeaAmvD4BI0VbiWnXY41pinD8qzC9/QgTAuvQwjSnGC6tB/mMNXwR/me9HUd9dPrvW97zZyMRflQBN99fH/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHrbrj97; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f7Hb7Faa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6194TPfc2600440
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 09:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qYzEtKoNBuZqtmsV3pmFFT
	0RXM9nU8ROe0dGkQ4Koww=; b=HHrbrj97JdzKc3XoqD4dhVOmanN2YlEqfauHZI
	RoXsHxIOutF3BCpX1zU58nKg9EcT5F3LSYdobLCT76quML4LHCgtVqL/88KbIDRZ
	UKvF7K4lBUWSrOSs8S+diKLpl+WoKXgpidkUi0dfQ3sGbSy4Bd+zk2PuvSC9xHIx
	6F2AVSuejSANx0i/BPTdCuA5jK8L1pGVfxlVGiz7bQohe35iUFRJolqZNVOJtAG5
	WfK84kGct4QmzRmCrPH2my0ppOb78UCgLdbwuMAiL3jeB5P5yXw+LJMErSEAJ+oM
	dETX5B1HSF+IDREB67Swm2Kp4q3ablFnoLrroUfsM4r2nweg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c78kh115h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 09:45:31 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so4228448b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 01:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770630330; x=1771235130; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qYzEtKoNBuZqtmsV3pmFFT0RXM9nU8ROe0dGkQ4Koww=;
        b=f7Hb7Faa8RjjQKPTzey/9izP6l4APDA7IQYryvMBckGdVELE6rIon6jpelqQUJNcje
         RWh5qMQZgaEZWPiA5JXGylPBS6OQKLuvFfFB5LFxLr5gktead7Esp4nAM63hZPt/snH7
         fEhl4Af0TRCXnTOgQVMSM2dZFQbRday4KYrsR7nw5ZEFVyiEgJvMZ6LC0oHJV90DB7OU
         qPYOFH4h3kfY3wctiRCGIjuur/6RxSeK3YOVxhvVNpqSOH6wLNqo1bdD+hAd6B9X9HpW
         8nH/3qQbq0zRYJqUwCPXoXJtYYb/mnDpaZ/j3qkwUYPS0T4Jw6jAPzb/AMQFYkr9bs00
         /I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770630330; x=1771235130;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYzEtKoNBuZqtmsV3pmFFT0RXM9nU8ROe0dGkQ4Koww=;
        b=jwdG/5zr+SPJvxvNOBqYZtbYynVx/gQIWWATewOhXGOFXuU3YU7K/p2SWECVniRkeE
         GdpT07ShC/U0yijUZkgVND4qOShSixiHcfDyTVMXIuNMetkhdjPos6P5VQXi4c/dyxjE
         0aK1gyDST1J/Npn1te22Z0OruA71Hne6k9Lp+bTOQ3vvWqP2SEzId8D78b8+30Dn8R/S
         KoWYhC4HJNawsLLdisRobAF/7Z+5+H8wi5Rc5dJio0xXGgJX2MVjIUo028FpOdNhOgdy
         dLawUVBPNaYr/259ix55SqNAomMrJ6s6fmVaZOAvGZPXZsI19HtYdoxorCmHFxeNXMCL
         ibAg==
X-Forwarded-Encrypted: i=1; AJvYcCUddD65bkDhSGlgqSLsiFUM2ddIVp8E7MIZchhek+leqtia5zdobzQs7mVdtFaxql14Y1Gz43ZXuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8/9QjSbsH3NrDS/ha6bgryuaiDuZxIjej7gC0hB5stvD4kJC
	9avSKupmlJhyaw2sSOMbM/MPS7dm5jgfXLykL2sN5mljM1QK+CleQzC24DFqdJHTUX6kyNeMxUv
	APp+9Ac6OpXus5717GXJngP0y5PBaSHJDjfCv3o3AEyoT3Mga5Kn69bQNUkFpsA==
X-Gm-Gg: AZuq6aJbBDJXS3XQtcS3KeAdVxTURli3fGyKXx0JxEWQfXbzODHHskaPAe/KjWhxBNn
	qquM0+htvMv4nUpYT5DLl2uHUT6Uny7FZX/2LV/rebe1R898B5LsmAEAPvHUWxkmbWnGqmQaVya
	3mZugZOngQhqmkAX+lH9LUhmurDb7u8cOO7MXaE/jw6DK8egH/GU2CudKFdMBF3Ab7RxTattYol
	vpyRSAu74MqEK82PvZYENYhxapu6zqROU7ujKL10V5vyqLEt33O0v4I76rtg/CdC+3V/uPX5b4e
	7sJ1XcbE9a7joRK/0zgFmbdAwUB/i8SRQ8M/3MRp3z7CKG71ysbPym8kGJ6GBlLSBaTsaHUOCUE
	hcEmFszveBOGaJxe6ThFzLN4I7AcdBBnc
X-Received: by 2002:a05:6a00:3e10:b0:7f7:6229:fbb5 with SMTP id d2e1a72fcca58-8244163d0dcmr10777024b3a.25.1770630330283;
        Mon, 09 Feb 2026 01:45:30 -0800 (PST)
X-Received: by 2002:a05:6a00:3e10:b0:7f7:6229:fbb5 with SMTP id d2e1a72fcca58-8244163d0dcmr10777005b3a.25.1770630329807;
        Mon, 09 Feb 2026 01:45:29 -0800 (PST)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441884b75sm10748666b3a.39.2026.02.09.01.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 01:45:29 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add interconnect support for Qualcomm Mahua SoC
Date: Mon, 09 Feb 2026 09:44:27 +0000
Message-Id: <20260209-mahua_icc-v3-0-c65f3dfd72c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHusiWkC/23M0QqCMBTG8VeRXTfZZpvTq94jIuZx5oF0teUox
 HdvCoEX3Rz4Hz5+MwnWow2kzmbibcSAbkxRHDICvRlvlmKbmggmFOOC0cH0k7kiAC0Vk8dKKa1
 ZQ9L+4W2H7806X1L3GF7OfzY6ivX7U/hOiYIyapRswUgjodInF0L+nMwd3DDk6ZAVi3wPFHuAJ
 6ABLaBhuuy4/QMsy/IF4ijpbOoAAAA=
X-Change-ID: 20260120-mahua_icc-76054966880b
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Nt7cssdJ c=1 sm=1 tr=0 ts=6989acbb cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Arc9D6tUohrwRZOLOYkA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4MCBTYWx0ZWRfX7j6YKRMNaLti
 Zw1uGu9xiNTlrjai7R6qR+PynMSb2NgbDJmofdMpPEp01sIWsJH/L7K2Z2Xh5Pv4lf7mfT5GWFG
 wphuhfNG/zqtBKen4tqOmC0ONLuHzV1QEF+2wpwxQh97iqokyFmA2NRzZ90SxIjF1kvCFwKBRQZ
 y67chzCeJ0h8AEse+tl98H9LO/EBsno6SCXCEG+1FiwKSv1P3YOB2uMas54x6rZ35d8BSw7eDzL
 avcy+W2cSZNKCMrs3Qvz3CXuyQwAwcg6uXVQOmN15nYfb0PxrxcrORSvqSWVhDx8pH1ka0jYoGU
 fQvTD9TZ3O2rIfBMz6V49z7Hi8EGD3I8+Y5lWr21y43yqLl/I/Hd/LaCSfp+UjzOQ5crb/6o+Ci
 emy4MQ9Nug7oimIyN638KPmITi3X19ACE2f73l2TjWHjB/KlGxn1UctEceWmuZ8VX2rTunvPRHO
 42QruM0R2Uhn7btNmlg==
X-Proofpoint-GUID: -xGvsEWsMDTaqTdLZ3CRT2RgGK21EWSy
X-Proofpoint-ORIG-GUID: -xGvsEWsMDTaqTdLZ3CRT2RgGK21EWSy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-42331-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raviteja.laggyshetty@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E43C210DB2A
X-Rspamd-Action: no action

Mahua is a derivative of the Glymur SoC and shares a significant
portion of its interconnect topology with Glymur. As such, this
series extends the existing Glymur interconnect driver to support
Mahua, reusing common definitions where possible and adding
SoC-specific configurations where necessary.

Device tree changes aren't part of this series and will be posted
separately.

---
Changes in v3: 
- Sorted oneOf/items blocks by the fallback compatible values
  in the binding schema [Krzysztof]
- Link to v2: https://lore.kernel.org/r/20260127-mahua_icc-v2-0-f0d8ddf7afca@oss.qualcomm.com

Changes in v2:
- Reuse the Glymur device data for Mahua and override with Mahua
  specific values [Dmitry]
- Update the commit text to be imperative [Dmitry]
- Link to v1: https://lore.kernel.org/r/20260123-mahua_icc-v1-0-bc82cb087f1e@oss.qualcomm.com

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Mahua SoC
      interconnect: qcom: glymur: Add Mahua SoC support

 .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 136 +++++++++++++++++----
 drivers/interconnect/qcom/glymur.c                 |  38 +++++-
 2 files changed, 144 insertions(+), 30 deletions(-)
---
base-commit: 6cd6c12031130a349a098dbeb19d8c3070d2dfbe
change-id: 20260120-mahua_icc-76054966880b

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


