Return-Path: <linux-pm+bounces-36686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A6BFF24C
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 06:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3E2B4F02A2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 04:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3154242D67;
	Thu, 23 Oct 2025 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yl144q6a"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FF742056
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194392; cv=none; b=k03/YqX5XCyph9WcHJJrq09Rl25qJoKpke7+YdR4VOgC3IOyfs5H9fBBQ3twAUtsYcc83XK3pbw8ySoXQ8Fext+2l7FkF6bi5ZRF7b3ksjYcDnDTAqGKhLP2EfZERw57x+amxRijIHIdnrFZvsEbhm2D3VS4lwcS/zrStYPL7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194392; c=relaxed/simple;
	bh=nyYBG+C521Gf1LNyIwasfoR5n1BHZIoeUKviWVU75tQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UxDv5oNl+7RkBtKv6ZBuKltaj4SoCAIeSVbqF3PULPvmhy6SuVhtaUVSKLkofJEa5Je95QAZUagknsYFwgEbgS0U6es4Ap4/TLRLXO4dVayI/0tgMl9f5TnsCuIA+vBoUDAPUkiqTqZIMHvrYD43zbLpXa2nQMWWnNsXeDLL+C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yl144q6a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MJ1b4B011813
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 04:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=d6kkudxWu0dxDCjlg0gydr
	n4lcJ8I6aqJcWerzC/ZQI=; b=Yl144q6atOBXe3SPe84OsNOtbYO2j0vP8LHqx/
	dv8X/SGYsUa/sw+SlWHZQetcOz0MnWCf/x/y+fXyj1UmGd/YHlt6qLd/AhJ6+a3l
	202OvjoVYvkqG9z6WNRZJOlTOrcroJwuAuLQQU7kqOzT2ZmNKOb4oNgzlMrad/Ee
	ba5sJKTKT0oJmQXWcvbP5rrNH82qphUWDeIKLTvMXJZzobdvj8F1heFscwhE5ByL
	ae8N2hWDUItRq0Mz0yYVb+2V3yLxC7rSEsCxtdfVhoEqUnSJX+l6I9Ha+3hCGI6L
	0/vA3OFOgH5PQGNOVLgisPWIZFD6Sxb4dp0XLUmBL/hODNYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y52496vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Oct 2025 04:39:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290bcced220so3907685ad.1
        for <linux-pm@vger.kernel.org>; Wed, 22 Oct 2025 21:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761194389; x=1761799189;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6kkudxWu0dxDCjlg0gydrn4lcJ8I6aqJcWerzC/ZQI=;
        b=I75WesH7vlIiIuq7zf7c07+lri5yK5ZO8m5ld70SyfYWMX/xLV0rSFiZ8AvYi8VV85
         HUWIIbKWgxhlBtJONHDkIzE6QKsJm4+vqyBR5NOxN5OvVnutW5RiqYGc8pwfJUnFDEYA
         tdzYqVpiRPQLYZCX6wrYkNrIypuT2QTlCSg2uhNAbWl3hcQeCafR6zzgIEXJI9In95Vp
         IpBecCWvALAsrlV79RvlCZrWmvsvZcO7hzHPqkaE/KMhvFRk10HK+1IAYwwiOgA3DDEy
         fiJKIVryr4mi2ge1q50zTTAjuEALSDq2eQMjM44ggEL/fz2PC+ghq6hFxyYkZmYqskJv
         AXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2Pbd9/pQObs3CxGmT4fxS8SifkJN2HwVV2sDOc5XxCNqF8UJiXG77Vay+qybaaDNHzNl5IJchig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsuiIiVbnwZpdf1ZdLkBfKqWblBVURQVqKo1BoPLHt2o/oZGEi
	ToTVYBWtEkBbm2a5dpbqNDNfgIYd6qUXV+OTfuXSoxm6kF4I/XEmEll4rSZCwqIGhSeCgiSK2ud
	FNoxYfMtAVctfY2x+k5G21/Pj4SN2KgzofWQDweBmCRQkC7vhGydzIxYQyzm1ew==
X-Gm-Gg: ASbGnctDLl7Z0/f4gEtxIQEKEkwzFTBi3p4DDfBbaYYvr2Uc0ryMeeMRTtQIuPgwW56
	G2zEsown6IAFGlOuZK+gO6cWM7y4otvxUWWS7PtDTtavwdnVStl3XnsRimEZnBhFav9nS1xWGBw
	gCGkoZsUh/2QrB58AYSAJ+G9ggmdjM8JaU/vm7y0MRd6HmskvX7rtVdv2aerX+pzuqitIrR3gN6
	obZT5hVY9i+mT1/un3AVbouBYV9CULRSdNOAg6udhpU41908x9vHpicih8WpwZbiydMpWqV4k3V
	xYmjwm4SfFuIhPJsp/eD2nx/cqlIkWz8xnSkRmHwNLTtHXPhXSAw3TqI0WOLLROf/LMSZyb+2G2
	0NYoiCtxNT2WjaKO6KOXYAQ==
X-Received: by 2002:a17:902:ce0e:b0:273:c463:7b2c with SMTP id d9443c01a7336-290c9c89680mr264622255ad.3.1761194388633;
        Wed, 22 Oct 2025 21:39:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe14IfMJmE3gpP70RjdmEvG7bvtjETCimcF/KuJ3HjZi1sWXgTDwZnoAK6qBWI375OY6jIcw==
X-Received: by 2002:a17:902:ce0e:b0:273:c463:7b2c with SMTP id d9443c01a7336-290c9c89680mr264621965ad.3.1761194388187;
        Wed, 22 Oct 2025 21:39:48 -0700 (PDT)
Received: from [169.254.0.6] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e0a3f0sm754187a12.20.2025.10.22.21.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:39:47 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] Add interconnect support for Kaanapali SoC
Date: Thu, 23 Oct 2025 04:39:31 +0000
Message-Id: <20251023-knp-interconnect-v1-0-df13182aceac@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOx+WgC/1WNywrDIBQFfyW4rqDmaX6lZKHXayNtTKo2FEL+v
 fZF6XLgzJyNRAwOI+mLjQRcXXSzz8APBYFR+RNSZzITwUTNJG/p2S/U+YQBZu8REq06ECC5trb
 uSNaWgNbdX8njkFmriFQH5WF8hiYVs/wZBrze8mV6r3+PffH3B5czhYYZWVVSdE3Zr5x8yzBPk
 0t9oVAYwVjW2saITpYIylpRG12aFq3kkilguiHDvj8AU//12vYAAAA=
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE1NSBTYWx0ZWRfXwGgDMxctr2zh
 +xzFo79BUMYIGWunYJx7J68XkJxTyJSCyM/a1o1Ll0dkX0gHRJ7NoPe/YWs3qm9oIKWJuaZqp0h
 SYrxpl8Czzntqy77nqScoaxv0Shd1d3qI6VKnAGgLW2P0182CWrpet/Ulz/P+ZGqdS+SrJAYlCI
 oAtWR/kN6zCnGph3d2g6kOpElCckMBYo7PhAUTi2L3NjjWnVcUKvJipY/RwsncOX8rDBLsu6q+l
 RS4s7cN78ZdUjrs2QNm7pyFRPR0OnZl8wRaj7r3/Ye1RDNQfYJj0fqH+hPUykdV2ovcwALuG5uK
 tsrKYdvJJblI3ZmsO7b7xsJ/iiHNYW9Zb3v95ic+FMo5EdQsr4ftuMUech5ADAi7y9DZiXsTkOK
 dE2y/Q6HN4J27v5xEYmuaR5cXPZjBw==
X-Authority-Analysis: v=2.4 cv=Uotu9uwB c=1 sm=1 tr=0 ts=68f9b196 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_cDidGYXCDOhaqYtY5wA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: D0kCgRT7eONgfjXunKhLfjn5lKBtfU6L
X-Proofpoint-ORIG-GUID: D0kCgRT7eONgfjXunKhLfjn5lKBtfU6L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220155

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

bindings file depends on Kaanapali gcc patch header file:
https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/

Changes since V1:
  - Added b4 dependency on the clock patch [Rob]
  - Updated the Module Description to "Qualcomm Kaanapali NoC driver"
    [Dmitry]

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  126 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2154 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58
prerequisite-change-id: 20250917-knp-clk-c60d94492863:v1
prerequisite-patch-id: 74589b64dc18360c773f802e493e02d52ce48ce8
prerequisite-patch-id: 0838e4968ea7bf2c6fcf1831c18e043b081b986e
prerequisite-patch-id: bad55c083296ece4f87573e6abfac5bd8623d52a
prerequisite-patch-id: 4b369fae9593dd9daa252dbf5e289979fef92079
prerequisite-patch-id: a5098157b969d17b6c7d6fa26b9fe034119599f4
prerequisite-patch-id: 649808efe6118765b742a53c5439515e7466bc0c
prerequisite-patch-id: 8e17e701a84a458666012e6ac5d00e280e8b5dab
prerequisite-patch-id: 7e58c87a2d504fc1eb4285e8dcd6d031f229fe08
prerequisite-patch-id: 7ce134f219cc6d8589337762b92bdcb9210dd05d

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


