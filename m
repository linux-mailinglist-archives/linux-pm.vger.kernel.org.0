Return-Path: <linux-pm+bounces-37313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 119A8C2DA50
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 19:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E64DC4E41E5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241CF28A1D5;
	Mon,  3 Nov 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3kmv1b/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dU8az5vZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2428A1E6
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194023; cv=none; b=jlSY51w8t/tdh3CLAoVh+aFV2Te4Z64lJxwetsrWS7sxkS+KGO58+jyiV+Q9N/PgKHafVDVtpxDVqX5qj9xP12MuzVnXijNjM8xs+p+30J+7CvlmHJ+XV3ON6waiBqYmRnD7oTu3+xHjKswT2Suy71Q3CCGz99JxSD2VylWABAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194023; c=relaxed/simple;
	bh=oo2xnbG8WfJs7Ko5NlyD7ow8RcCc85G0ZwCs7i2rSnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TL9J+omGrCzrJ+6JEicGpfMR5FtW3EXW3oaVjb1c0WSZdFVRreygiUHehDwW1WDvGK27KilQ0KnQV+D8SzLsORSv9BtuLBkdQfmNFVz5z/LVE2oxx7PZZX3f7SxiWKs1wxn0StHy5iakl3W4hnL7cuXc/NgScqOEax1WVOl2p+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3kmv1b/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dU8az5vZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H45mA3667744
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 18:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9+fmEwX3ZGj
	Jy7IkWaAmJIlp4fYLouSuD+9Zy1mJlxc=; b=Q3kmv1b/Uo4espoie30HgfH3dRn
	5kDYBLT31qhA9LjFLAxSgipXg1OAL4gc/yfS9nkqC0oYdS5big1fx40R+hkLBYRz
	mFkbPvMH0OqjPnCLPl5RMGzu3zt2TPn6TnyT0nUk4TU8Y47fDK9yNSQ52Z/vuDTt
	VODTEQqV78od1NjvNss0eTzY0D+OAXCzI3IeQcKJIeveuuG0P6JiYrgJ/DunXT0Y
	Ugv5FYUuRE/uW6YgEHgOpv5PLLmgeKnbeqKV2kRkiav0oABW6LMMlng3Wrn2Sg/o
	vrnS/FN279dkbx3bY4lB96NFuk8drMe1LZ2SgB0auHiJe7gQJSASJM0EQ2Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70ffg7ub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 18:20:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ecfa212e61so201587621cf.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762194020; x=1762798820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+fmEwX3ZGjJy7IkWaAmJIlp4fYLouSuD+9Zy1mJlxc=;
        b=dU8az5vZRdlfp8dXUT5oZ0Eavk+AXRbt/gB/nydyCZPrDNe1RVINs3ciSOA4zShuaR
         SPWTapyYjjAtIMcUFBndWmRs7+Z7MBFbVcOB4gQBjhSlZ+bkzFKWb60qNHqp0hlYPluK
         K92qWaYbA/vQIdd4KXY+kLTA49TQYnDgtxpShLVT0WZvZj4bFsMMQOt3O2MEdkogOxJn
         tNTp+m/7dfveNJnnroFP2QwPSs0SJb1bJ+K4hRnDK7peIiCYBTjrVOt6vz4wflovEPu/
         +7buBui7zGEABgiQHc8LZpcm9dG2tGhCmKdjDaVAVar12DPaC3A8YyvN2V+Pmle7iYDJ
         B87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762194020; x=1762798820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+fmEwX3ZGjJy7IkWaAmJIlp4fYLouSuD+9Zy1mJlxc=;
        b=fPPjLa+X1oKgWGuTYSZEPqkjMalw5fl++u5rfhwmXaN+Na7GSdsPLFtvQJuweRBPzK
         PQaDLPx7o2HJBeIJt62MFQHVKar2iR3Ke1PxIxuqwXzwOOzYSMcv8EfQ9rx0We22qn2L
         SpwV/aO6RQ7cUsooDB77pyd0P1XipBb5A5KKORz+v6XNe62WpxA2nVV2/gPEd3LbbMuM
         lOK77vUMElLA/uREc6Qm4d/cIUF2rZMSsyFkcXhg/FdAMAEIongBj8pUnL753D/5G3PK
         FWi3tFXe8Ix7OKzc5hcEf4nl4fXVmisAIGC3qnut7u09z/HmqAjEoMoS32myC4hSdJ2+
         55aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNKraJy/ofgXU+3IWLsAP4WjZf8rfnpMSrkrkKIcuuV9n+mfkAJ7JiGHaMCOF8Y7NcykLs3audzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUYeiHf/GbD3IIFQSH1Vo4YjYup4yJfG+K8LUxsFiuIaPWnIo
	z4KcctTDuW4/p2zjTJ5/maY65QP3X1Xq8FTWqPhghobiAssxGiaoIcHIwIfhURfhiruw3lbeegf
	zW43YTAPowPPQfo/CdzA2GKdagwkWuhKwNDo4Ek3t2HwyP4+JpCLwQ7Le0wdswQ==
X-Gm-Gg: ASbGncv8cLUqeLpjAmLTZ3Gj8kgdNGr3biAn49htRPNIhHa5EaRBqbh4Fn0a23i6nbz
	n9bkco++AlP8/Iu7jb4+fQcjsNzoVWBKyVWgrr7KvVhhGvNv8kssSJn/ZSTDyxjegoLPJW1ONN+
	Hx8F+CLJs865O+2/mMOdf6EoF2OfJxXEEMC2In1oUhYmwSHT6LwONupVnyGfZhRIPrE+zRzFaPx
	aAk7lXVfC7dNBhRP8KQ+S0uKPR14AJeKKw9v/je7jmmc2DUsgssOcbmAqL4yiFhuKdFEV1JzsCm
	KdHIZtsDY0IpgKsdCORqoXk91JfwKuP8HDx1ks3xeIde1HqKs4E/GZ2lTYXRwJmx7iR1o0P/ebV
	Nm636tKePMJfGA7gOvqPlXlQJfdXwveah1pjJSckQx2f2UVaZJygkcsaSq/aiLHlpQw==
X-Received: by 2002:ac8:58cb:0:b0:4ed:3d24:9570 with SMTP id d75a77b69052e-4ed60dd8fecmr4619891cf.37.1762194019723;
        Mon, 03 Nov 2025 10:20:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmwwb1yLDp+Pw90OM1b2QDBTcxme5r5EnDtGwh5UXFiSszHYIcqIchMcYySW6qF60B0Ci3Sw==
X-Received: by 2002:ac8:58cb:0:b0:4ed:3d24:9570 with SMTP id d75a77b69052e-4ed60dd8fecmr4619381cf.37.1762194019103;
        Mon, 03 Nov 2025 10:20:19 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:8842:5746:daeb:a8f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53ec2csm169096545e9.11.2025.11.03.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:20:18 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
Date: Mon,  3 Nov 2025 19:20:04 +0100
Message-Id: <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=esbSD4pX c=1 sm=1 tr=0 ts=6908f264 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=QcpCrrypq3z5zaV8IXQA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: jFL9r-fFMVArtLGvuwpY5abMoLjrjMeJ
X-Proofpoint-ORIG-GUID: jFL9r-fFMVArtLGvuwpY5abMoLjrjMeJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE2NCBTYWx0ZWRfX+dgLrzWvCJif
 Bu/XIxV3nYH3n7Y1JXSmAXGWDHD7u+MSRRuwLGA0DwXMi35+1eWiEcsXBEJ73z4FlnLdwKAvNLU
 xV+8fIYW+yevhKYG9CrEoJczj/hm2iSmI3Hzec0gQSxQq0CuQ6zAnN/sj5jC+DJ3L69AJQ1ZcSm
 4degMP3xJtatFyHqvmxcNjJl8GEiPF0zQWZ8J7W3t0L1pLqOdfFAkEB6uTdBt6gtBSK2x3zaMt/
 Cgq6HAqXLKaFq2KoKLu/9NR6Ysd8nmAC7GkOzfaSqNAgefUVhUBZh/ErOUkHznNqnn2cmWoOz4R
 C51z6giFWGT5ZHBLaTYFBSpvs7cP1MK2t3NvAW3JCwc5HuM0Dfsyyk5BFfkg+XBpy3VDmDLdj7y
 2hhtI1+zEyme8feg9Gskf284aiEAcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030164

SCM can be used to support reboot mode such as Emergency Recovery Mode.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index b913192219e4..c8bb7dacd900 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -121,6 +121,10 @@ properties:
           - description: offset of the download mode control register
     description: TCSR hardware block
 
+patternProperties:
+  "^mode-.*$":
+    maxItems: 1
+
 allOf:
   # Clocks
   - if:
-- 
2.34.1


