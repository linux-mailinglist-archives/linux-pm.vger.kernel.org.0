Return-Path: <linux-pm+bounces-37153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C878C23311
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6049A4EC7DE
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFD727A12C;
	Fri, 31 Oct 2025 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iF3Waumu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOiXJEe+"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC026CE2B
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881955; cv=none; b=dHTeEA6A8Mg3qh6wgouej5sI25uUKnnSDW4Jnix6SnqGAJaP+CBzyODGw38dy4afBnZmyI5fxg4xfAZulceEaoS3LwSuqafGJe6KUFRpGEZbsd9p474OtmbYhhEeapD0t7HmPpjybAlHRP68c+5zN2PlUjC8WXJLpfM74/Db1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881955; c=relaxed/simple;
	bh=b/c0TtRbUx8JtnHR4dV4m75OEsqkoKzuORRPKWB222M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FW2DxSWnaQ4VOdMvEoU8LuiupMV9+TM9CGWyKHXGaK7BCahcx17hUdY2HuYfBbxgrbN95fDtnUIlVYNWvUze/HIZlOX3Sc1x6xbpEdZZuAOkWPdqPGg6PPEQkNme3SYvr6gJd7g3KgFA6CZE1sKTNf0nWyQ477truCnBgmTiXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iF3Waumu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cOiXJEe+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59ULrNnR898094
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i4IorI58Uj68IO5CjjCNPB
	BlGw6Gmk20pgNjO40wFiI=; b=iF3Waumu7YmzPqbhZFaigxE2atA0dgJS7+Ag5K
	cjdyrTZhJethbkNtaKLPtNQYBbzgV/wRgJuYKlhqNkinz6lRsq4cLsmqXkjEch0N
	x1O7JI7GwqA937Vakt5JrtvZ398AaE36bB+TVqO3sjrueSD7UveFXPrH0uBgjh0D
	M0EUTKHZg+02JQQCRasy4g8/aBWsI6lq0UORJmPzhrNHJ7xD8FxtwN7pcUDJwSHx
	qJwhJo4EQt61Z+wA+/1FPo6sAki9ZqHiBfss+qG81HaW95+jP3C0KRu/b9oWHuul
	vaS2by/UJKtTBPFjbGbi5rRlUrK6CEYnIu/Cg/dVYua67NEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb20pe6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 03:39:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33d75897745so4556905a91.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Oct 2025 20:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761881952; x=1762486752; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4IorI58Uj68IO5CjjCNPBBlGw6Gmk20pgNjO40wFiI=;
        b=cOiXJEe+aO/A2h+2o1+JeIVaXajXDlx+Bq/pzhnoXtHX9FHr8OQCF5Bp3q6V6Z2FOA
         awlBjKhBnI0qszdxvq5+T9qGcvXQw+9fUeuB6mqVRRm2aHZEn+aULbvCOTv242jx565L
         8hbqkCoGG99xUK+tLC0vscrdDCiUa7HSUs0o7Iep5s9tlMK9T7e95c3JYjwjUY7ilnr2
         Kq+wmXNe5DTGOdrdXhdwgjkuzQ7AtqB5gYbJOCOL9DXkCvP1I9Kvj3ZmHQlxSS0mH99M
         9aiuo0VhBTOn/MhijyHICscy7JoR8C/rYxCclgOeTVlaoi3I5ZhQmxfDHPO3O6bkbG3G
         uQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881952; x=1762486752;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4IorI58Uj68IO5CjjCNPBBlGw6Gmk20pgNjO40wFiI=;
        b=ujemBchfWTJgdvxR8s83mP3Ty0DReImJvDGYMWixxGOLlp6Im6r4CDDqFwWGXq+E6q
         2ViO3VYr9HhTz9OhBZ0DOXKqeTBYMEP8OwSI6gWBHmycJQklf0rafRj9vi+iVuGjePUW
         2fc3EDYp34x65/A7EJ+vAR4aFLdU0bE5aSVoWqpDqHJmFFEJLjieO0H4dvBbft8KhE1A
         wSsX8/JiyNWv+TPNIkMXxxUH6ybUwPmpAYJu4UuG8sjgFwsRZjhBcR1iSLcq7g80LZOh
         XrN4JU3CUP/3WoCd9WKXM+acz4GWoxC9E+nesfrxPUJSO/zfEPd5Tv0LojuFiNToLmZD
         Kycg==
X-Forwarded-Encrypted: i=1; AJvYcCWT+ltSSRhxtiGX1xW7Xz7CLjLu75R1IbxsaZ++Y92r52syKfV3ZlCkkZw7opcXlR3H4ARqidPKyw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx4lug6l1Jwi5MNnb/L9hXzOQ8KKeHmmbGogUvkAwBGVnEl5yR
	CM0N7ab4lTOJ6mA6bqXL0uT6iFFbsPjJ/vxNnGkzFv3Ug9uLOaYUZqCeXaujAkBBpZRZgU3/06t
	dcQI5YCOc9YO6zoZ+pATql7D8qIDF0FAKieRq7Jq5Uh5EOmst2BCgK6uyAYc/Yg==
X-Gm-Gg: ASbGncsoltnkKxSAe8b8s+W1iiYMJQl3vKfnih+bvD5XwmrH80vL4LFCA+0yxrbiwW7
	D7TuA9sSUDXWHvRwPfIv1jYRfVOXsa1rq+nmM2bylKoeIlyGO+B8kM5z57o9jO4BP1ePIn6zA63
	xJ+6/eCEnW1EgTHG8xVzZ0gsCAG2PFz+gfKNninpXAqlWOXNKTn66sR9aXq5DSh+WFwoP1UaSrx
	ajrNLXCTI9Pc/booTLXNyqRV0W9081c5JFold67w6zUEEOy1g4fnMMog5kotPlFAquHhXsSs6cL
	3HTECfzS8qgiuK97sBL4u+EM64A6xizXjuEPH2Z1c+UnK1WWcvF41hFU5roO4jK/0E4OYFKMqTE
	fVgZ5UtONEWcQ9iN3AgMFLw==
X-Received: by 2002:a17:90b:1f82:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-34082fc7b43mr2536967a91.13.1761881951750;
        Thu, 30 Oct 2025 20:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjnJe4PvNt1debsSjTxLEoIU/F68bM+PqIGJDGv+FMr2j17u2RS7apMk5Va8eik46A4OJF4Q==
X-Received: by 2002:a17:90b:1f82:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-34082fc7b43mr2536934a91.13.1761881951267;
        Thu, 30 Oct 2025 20:39:11 -0700 (PDT)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f0845d1sm646419a91.4.2025.10.30.20.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:39:10 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add interconnect support for Kaanapali SoC
Date: Fri, 31 Oct 2025 03:38:46 +0000
Message-Id: <20251031-knp-interconnect-v4-0-568bba2cb3e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYvBGkC/2WOSw6DIBCGr2JYFwOIEbvqPRoXSMdKWkEZNG2Md
 y+aJl10M8k3+V8rQQgWkJyzlQRYLFrvEshTRkyv3R2ovSUmgomS1byiDzdS6yIE450DE6lURpi
 at11XKpJsY4DOvo7Ia5O41Qi0DdqZfg8aNCbzVxhgmlNl/Kl7i9GH97FnKfbvUc1Zwf6rl4Iyq
 pmSWgolKl5ePGI+zfpp/DDk6ZBm27YPmPMqGeUAAAA=
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=69042f60 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=06_svp_evkBEmB2vVC0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAzMCBTYWx0ZWRfX2DYOWiQG0tgN
 i3UM3k4pV7/hIObrfrDPKsDZa5pz1I37wUgU+QSTV/HA+g+A3PiZeFxSKSVpbWT/8DKSRjJwjrB
 f1uglK6USRkd3lOES3q0t2a0zxBsWLJLX8E4bZQNkUgsmEaE82YmbcZzkJWONRWcQy7FUTKnxK2
 27C+fABciwl0PHEZlEyNluDiDok8GHNd8ZneEo66dWlO9SDo66M5yqhffJUX7JmCI5Yu9s1YGrx
 h68ta6bOfV2oSTXkXbsHIJgvz4kwBWbS3dpgS914gn0953RlYqzVoVwAw8CIUjPlcQSWH3sRbAB
 h4p4GgixVqbAofr7u0JJH9lK0B34oDcJTBacflrOPI3sc4PuOeqsVKASHno+mP7nJBUkDXBJQ0P
 s1n7pM+kSvITLn53lJGkq+6Qrg1WBw==
X-Proofpoint-GUID: Tc6Cg_lRtIYaXLIPmIaIQsmQ4v-Oh-Ew
X-Proofpoint-ORIG-GUID: Tc6Cg_lRtIYaXLIPmIaIQsmQ4v-Oh-Ew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310030

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

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


