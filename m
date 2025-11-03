Return-Path: <linux-pm+bounces-37286-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C25C2AA3A
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24CB04ED963
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1072E336E;
	Mon,  3 Nov 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G07ZWxKE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBSWID1D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990572C08C5
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159921; cv=none; b=RNKnB3ED8TbCYr10E8x6lKu9EWbnWxuGC3b67e1pMh2bd5AnluMpx8gSaPelxJYjymDPDtu1GBkFrTYIqIhzZohdcwvRiZ38i2mG/lfLYzMlGFyCUN+EcTUwIgD61Ye8lJZZaGxshF+bb0jlokH+vh7KxS5CeGVWdxN1KYtavaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159921; c=relaxed/simple;
	bh=HZekR+X1QQ8T+n7KBLJNAnNWovL2r7FAK8kQNXZzh34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gs1LMCaBjgUHJRSA6AhWpvQ5PD/ik3Z9P5Yv/jorqvsiXXjJlw7DKKp46O9qkK4jUAoZIWRWMjLOt9o8/MaQl7oj7rdRs5pN7gOy3s4wiM5w95sFV/ROHVprYXhXplugAfYW6quFKCbTHPbIw9xiLFfRevB6jPggm5+rvWUYxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G07ZWxKE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBSWID1D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2Mg80V1396074
	for <linux-pm@vger.kernel.org>; Mon, 3 Nov 2025 08:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c0vqi6jj/b8CbGVumVnkzg
	xG3KjKbgL/ynWKTJBgytI=; b=G07ZWxKEJdR6yvZAoy96zzRTt1U2QH7asRKYYw
	lfl/7uruRMFLgT6INo0nTZhp5ZDJLqyE9SHtC9IOMZbhlNCH392Vjanp0Rhj0oYy
	BYtaGQoeVky2ToDZ8TNrHugUi6RIzo9JMzvBk7FhfKn57sT0v/OzmSP1hnB6b3W8
	2ba/TgZwLnk8thbKer7gtc1lW1AKPxRNpKojDi+3XmA5Myx8vGlVZDfCKh+Comdm
	mRzfb3eW0t2w+/MwMJv9W3Y2TbUhtByt2KBGMQLCgPpQsM74jf8ufDOEnMdEJcgP
	tmANYXG6wGiAZ6uO9XmMxhtlXiwHraG0Et7l4DyS1GdlIsVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5a9vkyyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 08:51:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2956510d04cso16263605ad.3
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 00:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762159917; x=1762764717; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0vqi6jj/b8CbGVumVnkzgxG3KjKbgL/ynWKTJBgytI=;
        b=HBSWID1D8Wxq081UP/8ANSXHVTM7xRYjaattsjjsAyFEYIdMeHH6VA6PH9DPJBjqFc
         oHKeY7c8EiGYiRzLHsOPkWK3enIS6bo3bTi46Fg6aCEMwlPdcdH6z8nmnf/Ye5JYpuCf
         tF+4AiDrwQI8TkW5U2CqmCAl/TxG0hl3y0/3IzlCCBtYECOZvesmLSeyxbSTa993EsY+
         h3aPezkxo4c8MmxM1B330AaQQr6Sc8ZwyHg4+45vARrVNQi7mRisHdD5gFA6mJQjUjD9
         R1eo81XMkAycYJJTEFFnR/LEKO9PWwJQmh5mVrmiIMd7fP4zwtNkrjxW0Ui9MrsYwdEy
         bLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159917; x=1762764717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0vqi6jj/b8CbGVumVnkzgxG3KjKbgL/ynWKTJBgytI=;
        b=kDQr7oGgOc6aA+Rz0pTj0V1d5hU5hlVcf9qW4gyw7yUc0WGrT0wVbc6SgjE27NOv5A
         NQQjj+4pPql+ZKRkYXrI8cM65WeXLdwKpGgiplflL687Gj33Ky5kW7VZ7m/z1n50egxI
         gS5SZD4COq5ke3S3Dg3G74iixc7BZtbvGGXdcf33q+VIMsdNnl4hlPiCBzY6JnpjsaDk
         XWUf1UR+fFsHBgo5qosXp8kh8E13rwFEITYoiv3dojvzD7sMLbs3PKvwzc8vpm9L7+L0
         3rG0dgDn9u3DeR/DETv1PmtL8W4bkjA8f3uriBHWEKPuC0WMbuoxkc3S6Zk6TWTYojwl
         66iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMPPrZBZmaYw0IN1Nx439blUt6k5gYNUDBn55qHf5a9ete6pPmLnxfv6z64w4ZmuOvf2Kd5/MnQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzluZhm/cyFxc7sQcjMhKOwO26/sgDp00GQw17zquH/1shQxMxW
	f5oFg12Yf+PDP74r/GmgTA7oQjmQSCjTUrxbFbwD/5J4FOQAGDMHFbfJLC/+M+JDoizkZI5dmMJ
	m19xsSDpuEejstBUhjGwehyUpF7kw4oxSEO5GFjCtrUCFhHE5bOdo+ctsOyhy9w==
X-Gm-Gg: ASbGncsFhzQW4B00FAMGft9urjx6gZU7/k8FMId6lwi+DHNebiHk0YbBMbe0mNCZquo
	qiZsXBucuwqDz+g9olPHOO32ZQFbqPkxyWdRsZqGwedGj7TdS1PqF++AGMCmyF8UioS6Tx9VdsI
	jP/9lnD/uFzLL5+pVIJ640BOyrlNQ9JrriKrGB+DLdvuWLu9qquMQm6cp0b8OqZfzDt9pHSANX9
	inIouYJN9R3ggqxLSDX2mEPKEh56dk6HPHw1jURzjMYxPWd742b2GqQ91va4nVfNFMXQ97Fq8YI
	7Kz9/8wd0W7X8AZO5H+aPj1MKNV2P4D7C4v7eVbEvp3AfyekpgszWEWlTaG3FUcDjXxxxfNLbKi
	dOE2x36TbSIXVboxsjSLcWQ==
X-Received: by 2002:a17:903:24f:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29524abfc57mr117895265ad.22.1762159917397;
        Mon, 03 Nov 2025 00:51:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdFWZ5eL263AhpbzBjcsP/SoG/gFdyoVlX/8S0qnFen85cVcRcaeE00KTs+4TsynF2ykEGmg==
X-Received: by 2002:a17:903:24f:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29524abfc57mr117895035ad.22.1762159916789;
        Mon, 03 Nov 2025 00:51:56 -0800 (PST)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599676d6sm255142a91.9.2025.11.03.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:51:55 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add interconnect support for Kaanapali SoC
Date: Mon, 03 Nov 2025 08:51:17 +0000
Message-Id: <20251103-knp-interconnect-v5-0-f9929faddb66@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVtCGkC/22O0Q6CIBiFX8VxHQ4QkrrqPVoXQL/JSlBQV3O+e
 +jaasubfzv/zvnOmVCEYCGiYzahAKON1rskxC5DplbuBthek0aMMEEOtMR312LregjGOwemx1w
 aZg5UV5WQKMXaAJV9rsjzJWmtImAdlDP1AmpUTOGPMUA3pMr+665t7H14rXvGYvmu1ZQU5L96L
 DDBikiuOJOspOLkY8y7QT2Mb5o8HbQwR/7LoRscnjhiL7VWzOgCtjjzPL8BQZPlni0BAAA=
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4MCBTYWx0ZWRfX58MQ2VpNJKRL
 PFyyv5C9ILd5pmr0fAIR9LsMFVndPR6v2ZoHQKfHpOfJbj86NUXpjm1JjzgxD+vnuF+QFTCZLiX
 yEB+vMsSKq0rRFfBXux7uUcoyY0KTVfixTQLH1t4V6/NDijIK5XRUzM/mq3I+pRWsaArGMl0c6/
 ja0lUFWYn0bY6mfwrjCoDHvN0EhOKiDyn1s69P1ebrwV/UI6/O4v3jcG7OfXwfnLWUuz3MiAusz
 02ifwwlJwR/4O+qxaft0zOZycazdACBXmd559LOAbwVPNTr5SnZpcVo6SwRwpZaUw2mjRNo0Dat
 6WVIsGpnykWJPrdNUgpKud93NOdUCJuVZuAroE6zCJ1TfNtPzkRxOw88hNI/ylIe0qSTBLX7g14
 eecbShUfXNFFa6ulVp8czNwa31dN9g==
X-Authority-Analysis: v=2.4 cv=c6CmgB9l c=1 sm=1 tr=0 ts=69086d2e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NeJqaqV_MRuGqkmvWOwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: JypkXAxv2DohZyOdOcDbJksuvK2FpqZr
X-Proofpoint-GUID: JypkXAxv2DohZyOdOcDbJksuvK2FpqZr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030080

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

Changes since V4:
  - Updated the SoC name in bindings [Krzysztof]
  - Link to v4: https://lore.kernel.org/r/20251031-knp-interconnect-v4-0-568bba2cb3e5@oss.qualcomm.com

Change since V3:
  - Removed unused header dependencies from bindings [Bjorn]
  - Link to v3: https://lore.kernel.org/r/20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com

Changes since V2:
  - Removed the dependency on clock header in "qcom,kaanapali-rpmh.yaml"
    bindings file [Krzysztof]
  - Corrected the patch revision number.

Changes since V1:
  - Added b4 dependency on the clock patch [Rob]
  - Updated the Module Description to "Qualcomm Kaanapali NoC driver"
    [Dmitry]

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  124 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2152 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


