Return-Path: <linux-pm+bounces-41777-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJhgECmcfGn2NwIAu9opvQ
	(envelope-from <linux-pm+bounces-41777-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:55:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 677D8BA362
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AFAE300981A
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D65372B34;
	Fri, 30 Jan 2026 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkdPfs8d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z81s+T9o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC71E4AF
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774101; cv=none; b=Y1Uz5n3nVWyW0okxAqNLvOTAEOSr+/MyucXBS8PYYUzdbg0+utkQvp/OcHNIkWWXJHpdsRht060rYYMXH6WB5ToQQX69HOFFDl7EkV30ZcQuiVVtKnVGgpwNmnGCkuiU0TPZd8pKF32Vlf5xZRjW5K7nSH76kDytXYVPn87PnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774101; c=relaxed/simple;
	bh=CbgzOaYDkc3bXhiSUZkzlP8DjhXVBP0eRFGEsmWlQbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bv3bCmb67h9mVD0VLZwYNPBHJKwuca6AU52/GwLEqEVtKwKy/yM6QcnKkSOuk9+mxUVIr7n1zK2Se0Uf3KpoRnU1cjmXLgnMEK4k1OFXK5LWV/6NM/0Vwv+I9dLMH9F0OZOfDWnGu4RqA9inGKu00ZZ0+9oaw7LHGjKCR+a5Q7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkdPfs8d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z81s+T9o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAltfh891353
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yRCNcS5A6Eu
	GBIPJ6FqXwxvOo4jjK2JrobpZz5iBr1c=; b=nkdPfs8dgdIKJth9mytG0eIkkSk
	FcgGiTyfFD40VDfFsZhxfH6iwVUhX1UGP0XQ8Ga202JncUwrIn80TYBMQitfIn/m
	J1W9nQ7ELfBBHk+y1k9DvyT6qGG1deJtd1OdcroHMqeci2DTatuokoDdOWgtZzN4
	FboeIxPKpKQdbicNm1IyZLHnG9CZAanBju1KTZQSiSZQhJLQDHcvotFszQKF8OVs
	0r+zMRh78R8pr4/5RZfy7D34P8nGisU2gRKs3fmmgXgUOgbHGNCSJp6pfgUfPAIE
	L2BUJDgKmwjVeGNwOG2gOuVnXncKQOc5W8q7BJ4lTsJQzxMHtZHm/g0GhoA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0gs7t1dj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:54:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab459c051so3858622a91.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 03:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769774094; x=1770378894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRCNcS5A6EuGBIPJ6FqXwxvOo4jjK2JrobpZz5iBr1c=;
        b=Z81s+T9omi3gs2rt/0vDiz6ibL07FzpavokSqc/DNJ74CcpIw6uUQPs+AmsNQ5GPAM
         YelSUeavgQjb2dmOTPW8uwd5JefeHHv4BYJ6IOht2I65EoCjqwXr5KquwaWm4zpgvuIw
         /sHZX5hPMDolETLLAEt4r48Fi4Ygq1AKdwVFEZOEi9M1tA/MmBBQyNYYUGP4d0DZjCvG
         6B/0rGE2x5qzAdFOHVAqwQ/Jz+offn/VEnA5Jr33SbyLxHuZWPp4T9RANjWYsRKoaakg
         PX4no7IDETYs6c3lz9TWymgZtQdqk+JWSFpD+Otb+KcR7LGGH39skOm/zA6hZ922FI5a
         CLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774094; x=1770378894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRCNcS5A6EuGBIPJ6FqXwxvOo4jjK2JrobpZz5iBr1c=;
        b=ctNTcdM609qdiRjh92/QE9uZIWd9E9COPnTX0tCvOXbu+0DTZR5kbUSy1x8SrsWKJ4
         OL2U+TQxeZ/i6fAMLLtrFfp2Vsj3Hhz1cgogG7OUGYoKvx9blm15z0zLdUEznzzGi6hA
         uGfRUEFjsqHavUpHGby0vDWoglV36+0H0RTQmC3xJdq+gCBOz6WUOdc7ehVOaHbRiKIc
         xDozcNYPY9oU9ThRsX4dE///TNJQpaXyi0K5zzBCNhCedcvYyrPE821yCJKhI6o4THEs
         ik1ndYreOsAMY/HCTRRHB+HwIUEHk3A44FERgZBSV/vbuI1afXXpT2JA3GPFl9wTbTNX
         7SWA==
X-Forwarded-Encrypted: i=1; AJvYcCVc7RAspGi+drsEwtxkittvG3b2OZrdYiGzP5s51bf/Kac9e0P6HQvQlbNqNkvoZvef65I2ouLsAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpEY0GM7GGlmBjJxMBUJhFPFnOxk4n70T3ps3a9GyimV7U6Wp
	EGLdRX/3FSnh8QmhEJFztaWmxaP+A12H54KFatTN55AHTgh95bnel5qmi1P7d1DVlrWiJjIQc8g
	GaH1LYsR2uh315Pqjo7gd1MW4+NdrtkyShtZTTvkVRFxlVBm0MFTDbJKQn2K7ig==
X-Gm-Gg: AZuq6aIMUGyHbwSnrpeVgaj9jmkBY7drkiQDhfCGO/qaGE8UYxiVBsz9v/mY0k0kN7l
	ZHcZSEt211NG4Rg80HuLr8a5Ed1s5f5ce5zzmMViJY/lMCWmDP9ljpR4dmjRdEaQzJewRacE6bZ
	VBvvJoCpD5oAmzyKzbEJJz6rkSfcd9CLfcGQcyhml60lvfPOvpdgNKHxm1edWirqI1tJ/KSEpFw
	lf1QYesBS/3Fic0KeuvGh3GczoaMOJdvCiiR790zXCAne/He9NkRpOJL/N0nqlns64lJdSJzskO
	vvkiUL2KninjgXGPsKkqo8DmObsIWfrq+gEV8COvy15SnonO6fhEXL83Wj3eZJa+XqDa006nZD8
	VKlw752aZ1WsD38dwzIhMiqa4HKYd7qVvZG+hKPYw3Xre
X-Received: by 2002:a17:90b:2fc5:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-3543b185498mr2599997a91.0.1769774094077;
        Fri, 30 Jan 2026 03:54:54 -0800 (PST)
X-Received: by 2002:a17:90b:2fc5:b0:33b:b020:597a with SMTP id 98e67ed59e1d1-3543b185498mr2599969a91.0.1769774093547;
        Fri, 30 Jan 2026 03:54:53 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24ccsm10431278a91.8.2026.01.30.03.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:54:53 -0800 (PST)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V10 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Date: Fri, 30 Jan 2026 17:24:19 +0530
Message-Id: <20260130115421.2197892-3-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5NyBTYWx0ZWRfX/yBkjzGJk3EC
 w9slGdJOh/yJVClGpL52iC3xGUKwcaSe3ZkWjyveGUsXGVeseduOLzUTj+jq1LIkSUSMqjSFHyG
 H+ZQxlk5xMMCZ9/9nUP8BcS3SjBQgG7gg/Od2P5gcGKtTyjAWf3Pfc39tqzjDnFogyTmcLz/TD4
 ir0y4LdT64OxlCT+z4IhneUi3uzMckRHt7toqB1zw5hkneVe6aiDwnyLalkYkIG6UkmebbzlN/1
 ps+Ls9pZYleFEI0FVP2+KUiq8VPYOCklwmPfbvevD+z4mDf7qkSjt0XlUGWxQCrAGxxWNtFUH8R
 JnVmkV3oSrlBKwQcZeTTtq3hByiqN8WZRc8vhXA1W63Xr/zNIiFDhQHX0Wpn0jXjrY0yW7B0z5Q
 hFovdjKK2BQ6DzFylsgetXaD7clIMsVffifSXUzLJZ3M6iIGQ+mprNOZ5aAwvccUUCzxoLXrG0H
 KMif3MZTq32+MLpR4oA==
X-Proofpoint-ORIG-GUID: U7-5H1J6Lxo2Aak7qJVg-YeLxzasY8JA
X-Proofpoint-GUID: U7-5H1J6Lxo2Aak7qJVg-YeLxzasY8JA
X-Authority-Analysis: v=2.4 cv=UPLQ3Sfy c=1 sm=1 tr=0 ts=697c9c0e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gEfo2CItAAAA:8 a=i0EeH86SAAAA:8
 a=YrMGt2jeDSw4g2R_97MA:9 a=iS9zxrgQBfv6-_F4QbHw:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41777-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jishnu.prakash@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,0.0.0.203:email,huawei.com:email,devicetree.org:url,0.0.0.3:email,0.0.0.103:email,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,78f:email];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.35.40:email,0.0.0.44:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 677D8BA362
X-Rspamd-Action: no action

For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.

It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
going through PBS(Programmable Boot Sequence) firmware through a single
register interface. This interface is implemented on SDAM (Shared
Direct Access Memory) peripherals on the master PMIC PMK8550 rather
than a dedicated ADC peripheral.

Add documentation for PMIC5 Gen3 ADC and update SPMI PMIC bindings to
allow ADC5 Gen3 as adc@ subnode.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v7:
- Dropped ADC5 GEN3 channel macro definitions from bindings, based
  on discussion with Krzysztof concluded here: 
  https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
  to be added separately in other patches.
- Fixed quotes to use only double quotes for "#address-cells",
  "#size-cells" and "#io-channel-cells" properties, to address Krzysztof's
  comment.
- Removed inclusion of ADC channel macro header files from ADC5 Gen3 example
  and replaced the macros used in the "reg" properties in channel nodes
  with the actual hex values.
- Removed update made under `reg` property in
  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
  which referenced ADC macro binding files, to align with change made
  in patch 1 of this series.

Changes since v6:
- Updated SPMI PMIC bindings to allow ADC5 Gen3 as adc@ subnode, to address
  Neil's comment.
- Replaced 2025 copyright in newly added files with yearless copyright,
  following new internal guidelines.
- Collected Acked-by tag from Jonathan.

Changes since v5:
- Addressed following comments from Krzysztof:
  - Increased line wrap length for top-level device description.
  - Added more details in binding description explaining how number
    of SDAM peripherals used for ADC is allocated per SoC.
  - Dropped "interrupt-names" property.
  - Moved `required` block to after the list of all properties.
  - Dropped | from patternProperties description.
  - Renamed per-PMIC binding files listing ADC channel macro names.
- Addressed following comments from Jonathan:
  - Moved ref before description, under patternProperties.
  - Arranged enum under qcom,hw-settle-time as groups of 8.

Changes since v4:
- Added ADC5 Gen3 documentation in a separate new file to avoid complicating
  existing VADC documentation file further to accomodate this device, as
  suggested by reviewers.

Changes since v3:
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and updated top-level constraints in documentation
  file based on discussion with reviewers.
- Dropped default SID definitions.
- Addressed other reviewer comments.

Changes since v2:
- Moved ADC5 Gen3 documentation into a separate new file.

Changes since v1:
- Updated properties separately for all compatibles to clarify usage
  of new properties and updates in usage of old properties for ADC5 Gen3.
- Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
  mentioning this convention.
- Used predefined channel IDs in individual PMIC channel definitions
  instead of numeric IDs.
- Addressed other comments from reviewers.

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 151 ++++++++++++++++++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 3 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
new file mode 100644
index 000000000000..149f4af8f4b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC5 Gen3
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+
+description: |
+  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to clients to read
+  voltage. It is a 16-bit sigma-delta ADC. It also performs the same thermal
+  monitoring function as the existing ADC_TM devices.
+
+  The interface is implemented on SDAM (Shared Direct Access Memory) peripherals
+  on the master PMIC rather than a dedicated ADC peripheral. The number of PMIC
+  SDAM peripherals allocated for ADC is not correlated with the PMIC used, it is
+  programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.
+  All boards using a particular (SOC + master PMIC) combination will have the
+  same number of ADC SDAMs supported on that PMIC.
+
+properties:
+  compatible:
+    const: qcom,spmi-adc5-gen3
+
+  reg:
+    items:
+      - description: SDAM0 base address in the SPMI PMIC register map
+      - description: SDAM1 base address
+    minItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  interrupts:
+    items:
+      - description: SDAM0 end of conversion (EOC) interrupt
+      - description: SDAM1 EOC interrupt
+    minItems: 1
+
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      qcom,decimation:
+        enum: [ 85, 340, 1360 ]
+        default: 1360
+
+      qcom,hw-settle-time:
+        enum: [ 15, 100, 200, 300, 400, 500, 600, 700,
+                1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000 ]
+        default: 15
+
+      qcom,avg-samples:
+        enum: [ 1, 2, 4, 8, 16 ]
+        default: 1
+
+      qcom,adc-tm:
+        description:
+          ADC_TM is a threshold monitoring feature in HW which can be enabled
+          on any ADC channel, to trigger an IRQ for threshold violation. In
+          earlier ADC generations, it was implemented in a separate device
+          (documented in Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.)
+          In Gen3, this feature can be enabled in the same ADC device for any
+          channel and threshold monitoring and IRQ triggering are handled in FW
+          (PBS) instead of another dedicated HW block.
+          This property indicates ADC_TM monitoring is done on this channel.
+        type: boolean
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - "#io-channel-cells"
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@9000 {
+        compatible = "qcom,spmi-adc5-gen3";
+        reg = <0x9000>, <0x9100>;
+        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
+                      <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+        #thermal-sensor-cells = <1>;
+
+        /* PMK8550 Channel nodes */
+        channel@3 {
+          reg = <0x3>;
+          label = "pmk8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@44 {
+          reg = <0x44>;
+          label = "pmk8550_xo_therm";
+          qcom,pre-scaling = <1 1>;
+          qcom,ratiometric;
+          qcom,hw-settle-time = <200>;
+          qcom,adc-tm;
+        };
+
+        /* PM8550 Channel nodes */
+        channel@103 {
+          reg = <0x103>;
+          label = "pm8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        /* PM8550B Channel nodes */
+        channel@78f {
+          reg = <0x78f>;
+          label = "pm8550b_vbat_sns_qbg";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        /* PM8550VS_C Channel nodes */
+        channel@203 {
+          reg = <0x203>;
+          label = "pm8550vs_c_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index 16c80709a3ee..72188041e8b5 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -15,6 +15,8 @@ description: |
   voltage. The VADC is a 15-bit sigma-delta ADC.
   SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
   voltage. The VADC is a 16-bit sigma-delta ADC.
+  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
+  it can be considered like PMIC5 Gen2.
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 65c80e3b4500..cc5de26bbf57 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -129,6 +129,7 @@ patternProperties:
   "^adc@[0-9a-f]+$":
     type: object
     oneOf:
+      - $ref: /schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-iadc.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-rradc.yaml#
       - $ref: /schemas/iio/adc/qcom,spmi-vadc.yaml#
-- 
2.25.1


