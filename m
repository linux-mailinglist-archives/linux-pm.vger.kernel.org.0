Return-Path: <linux-pm+bounces-41606-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGLXEQbyeWnT1AEAu9opvQ
	(envelope-from <linux-pm+bounces-41606-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:24:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 459BDA047D
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 933D63006093
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C22C08C8;
	Wed, 28 Jan 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXlzDfPq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/bv2MSX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EE434D385
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599489; cv=none; b=DDOM9ZLkKJsOLIDn51Mdrdw3YqDMQIFrosUVaRqYGQsHaDZUeIVWqcrLDUMtgObEfvf6TOyo4iEZ5V3NM2SO3BPTdzKPjyZbF1zJdHxrHRfb83VCSUyNiajdu4lKzFlwuNMXdnD5/C8d2k+Ay/a1/meSbNVU5OCAiniaad4oRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599489; c=relaxed/simple;
	bh=DbLPeovYiwjXpn5dbWMK4U8Irz//NWlC2tACaOAzwNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTF13FVm1hJraQXveKEqAilTC8tO/GkonvA+EthUjjXTtCf3p4XVDikj25LXPGu4YMN6/Ak3TNoUt3sVU5WxMpAkZLZr3AnGoXCLXt2fZ5KivXmdfvidGE9t/i2k7ISLWaJZdVNa1RqWiU4qVVOKot7fNzzWIUFR2uwi4jcQeYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pXlzDfPq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/bv2MSX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92eII042112
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 11:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+Sy9zUDZs56
	f6JnqKzFkwx6XwPXTc9MqxOFBhYwgs2A=; b=pXlzDfPqPTKlaz46J7jRQdlXg7Z
	WxENcRFC433nlc8E4DoqJlywKtUw9E++MFHibHEt5xi/qm5ltMsVnn456T9hx75X
	AwUcy6HD1u8+7FJZToCO747Ihj1xPkCjK+g6IvIOb5GWwzFCD5wO2iwnwyahKFH6
	mPPgVxVK88tjR/u6I/BEzr94maGzro+ySIKIq1PW/Ee5qVyoVosM5ZhPwwMMf6Di
	NTNd2lKXU20wIU8SfSAUgodddX/OtW4SaA/a0fNW4q1/MwiiTLOUg/uej9MiYBAk
	gWMAZ0pZ4gF9qswb0qmyGZB2imKx2G0n7FrCjKsB8pCDLptmimKgLgEcf7A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by355ttpj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 11:24:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0a8c465c1so5621985ad.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 03:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769599483; x=1770204283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Sy9zUDZs56f6JnqKzFkwx6XwPXTc9MqxOFBhYwgs2A=;
        b=g/bv2MSXVpSH0nEaj6PmIMvc5nKwKoDxWUydqYZOVP76Zcv0N3y3VpbzGGrVqn7GQZ
         Iq2sxMJ52fXxkzthO1jTu7aGf67y013QUhuDdWzrpH+PvFfYOqjGimfbtkbQ8VKPcpII
         v2VHH3SPlefe43DbQEn9WIglPSIxYBzoSrUfbzR8KJJPRNZOL602rnhhxbHyqrjqnhUv
         vmEH4uhXqNrljEIiiuEseJPZocoAaBF57e46xNEQkZm99w4NVPXeowyTjHJyhegDAgQJ
         tUK2MPLZVpG6307urE0llSwZtiMvydSAg2gJnr2G8Z9PDyUVaE8rrHwRF2odBd1fFc68
         S+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599483; x=1770204283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Sy9zUDZs56f6JnqKzFkwx6XwPXTc9MqxOFBhYwgs2A=;
        b=iRXHoucmrs5F9iaVIXdG0wLY69bNUNDRpUMBg13QQrf20k5ODdCnMeatRTJSKcy+UI
         ph3N2ubQvst+YbDRM0VYyz0FNHLpcsjxDWNYZFZqaN5+Qg1xZSeaXp9UxDhdCDq1pSa/
         yTBI9X6QiiBxGB7IhPNJTpSWb0Hd+JA7Oy6Jj2N0ezEMtgYlAzqcRlbGOSz2PJiPh7mc
         m4PwBZSHzPx69aWNYlZsNfO7K07DJgcRfIJcSgo8eKwboeunfl9LUCzWIRBYxz1le1/I
         R0HDuh1iimoTnC3+7ehyzmmaMxEtAsxxXTBA2fuS8+boGEOecDKxwHeCFw0DLrIkx/KS
         bkDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW86qazQfCM2FBfloc0/Le6LaMQ781O2BSm+kVV6yKeX57hsBPVLR4nkwwLMiff4cP5laJ6eIeD8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqfdoi6a4xOkHrqV9yokDjwGijF0lLFCT66wIZ2wEbufEbCCgC
	AeI1JfmQgec/KyIJ6Icsvg6NyGBNcuq97NOTELS5dDsToEIJL0aZv2yyXguvZruMTwP1WR15hJE
	pVwUcuNZHctD8mU/OapF2zkxcKPOGzHRxn+7GMxq11DsIDJQ29VYoI9h9jauNDQ==
X-Gm-Gg: AZuq6aJnCYhm2lSpXRZVvzzISBbLZPdG1t9+ckJmUyDA/dzMz9NDOuOfF6YkrPXmvip
	JUNeT91P7Vb1QbwWeF8Q0PXKrEm2A0ZnP49CVCTmuM7x1Qs8EwQFjXN43l/z9OYIOD5bsDbu61D
	IYMATnj0w/ZPN/w8nQulHrM6OoZ/My0pJ9irR2IVQTAKLUfCxSD1XIqPVqDODN07EEoJvPFKBbI
	GawfAtuDI2PKdxia5kQMS6ryErOfRWUaJld365Mb8eLpKZCaUfslwGA8jaobqLGwvjZEQt3dEUU
	rr/MYc0aZjOVnGkmAY1HiQSJlVYf/D2P7BhYVuyqazpU+EgWdx4TkJXDRob7EidfKOrXeX/fi18
	gC7pufJBx+SbApm8wDop7GdWLbTGQUA2F08fpQo/btx8t
X-Received: by 2002:a17:902:d2cc:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a87120f624mr46348095ad.2.1769599482725;
        Wed, 28 Jan 2026 03:24:42 -0800 (PST)
X-Received: by 2002:a17:902:d2cc:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2a87120f624mr46347955ad.2.1769599482206;
        Wed, 28 Jan 2026 03:24:42 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c40a8sm21984605ad.51.2026.01.28.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:24:41 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V9 1/4] dt-bindings: iio: adc: Split out QCOM VADC channel properties
Date: Wed, 28 Jan 2026 16:54:17 +0530
Message-Id: <20260128112420.695518-2-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260128112420.695518-1-jishnu.prakash@oss.qualcomm.com>
References: <20260128112420.695518-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YNWSCBGx c=1 sm=1 tr=0 ts=6979f1fb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8 a=i0EeH86SAAAA:8 a=EUspDBNiAAAA:8
 a=4vDKtjJwf6yegxfEYBcA:9 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: pKqNAQ6ZXYCyAXRFXWUlGCss9CqCw7GH
X-Proofpoint-GUID: pKqNAQ6ZXYCyAXRFXWUlGCss9CqCw7GH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5MyBTYWx0ZWRfX/1cZLs/Bk76F
 JsRpjIZzvFUgvmVswcoEeHxj6RJLyxTrNo6HnH8N36rm83DjMWddu9zq5Cjb9fD2FNxwMi8uSDo
 7rqxaoWZyDSe3FoTlLKHKQweryIUVkkeDSXGvk0j9VbqQAdb7nlz4S8pJJIzQ4siGJNxgRPzzSd
 6f9w3CBmYdn92SknyH4gJktI4V4mECq8WFvs4f5yQN3tdb3RZxr+9CbWTFt7SR9I4jnbn2OgAbW
 oaKF78Hh/RQgy0wRuYxgdiQIoCJFTAyQOQhQ3LQG8bT2560x+ixvqqCxlsK+5ltMGIJcUr8mWMN
 Eysnrr2fdlp2uMfqpWpi7+MwIsDpjfwPPLw49Aq7eygXmN4taSZkjcA9f4uzJlRvT1aZmLjz8ws
 rcVIj062YuPZFQZFUBZuZPA3FUO2Ct31GqtRfnjBFH0iPzvm+ScMDuf5VpxdCuNgREf4PP+kvN7
 KeplsbcK1iO4BYbmRFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41606-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jishnu.prakash@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,devicetree.org:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 459BDA047D
X-Rspamd-Action: no action

Split out the common channel properties for QCOM VADC devices into a
separate file so that it can be included as a reference for devices
using them. This will be needed for the upcoming ADC5 Gen3 binding
support patch, as ADC5 Gen3 also uses all of these common properties.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v7:
- Removed binding file paths mentioned under `reg` property description in
  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml, and
  updated the description slightly, to simplify it and avoid any dependencies
  on patch 1 from the earlier series.
- Removed an extra blank line present in
  Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
  in previous versions.

Changes since v6:
- Collected Acked-by tag from Jonathan.

Changes since v5:
- Collected Reviewed-by tag from Krzysztof.

 .../iio/adc/qcom,spmi-vadc-common.yaml        | 84 +++++++++++++++++++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      | 76 +----------------
 2 files changed, 86 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
new file mode 100644
index 000000000000..3ae252c17b91
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-vadc-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SPMI PMIC ADC channels
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+
+description:
+  This defines the common properties used to define Qualcomm VADC channels.
+
+properties:
+  reg:
+    description:
+      ADC channel number (PMIC-specific for versions after PMIC5 ADC).
+    maxItems: 1
+
+  label:
+    description:
+      ADC input of the platform as seen in the schematics.
+      For thermistor inputs connected to generic AMUX or GPIO inputs
+      these can vary across platform for the same pins. Hence select
+      the platform schematics name for this channel.
+
+  qcom,decimation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This parameter is used to decrease ADC sampling rate.
+      Quicker measurements can be made by reducing decimation ratio.
+
+  qcom,pre-scaling:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Used for scaling the channel input signal before the signal is
+      fed to VADC. The configuration for this node is to know the
+      pre-determined ratio and use it for post scaling. It is a pair of
+      integers, denoting the numerator and denominator of the fraction by which
+      input signal is multiplied. For example, <1 3> indicates the signal is scaled
+      down to 1/3 of its value before ADC measurement.
+      If property is not found default value depending on chip will be used.
+    oneOf:
+      - items:
+          - const: 1
+          - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
+      - items:
+          - const: 10
+          - const: 81
+
+  qcom,ratiometric:
+    type: boolean
+    description: |
+      Channel calibration type.
+      - For compatible property "qcom,spmi-vadc", if this property is
+        specified VADC will use the VDD reference (1.8V) and GND for
+        channel calibration. If property is not found, channel will be
+        calibrated with 0.625V and 1.25V reference channels, also
+        known as absolute calibration.
+      - For other compatible properties, if this property is specified
+        VADC will use the VDD reference (1.875V) and GND for channel
+        calibration. If property is not found, channel will be calibrated
+        with 0V and 1.25V reference channels, also known as absolute calibration.
+
+  qcom,hw-settle-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Time between AMUX getting configured and the ADC starting
+      conversion. The 'hw_settle_time' is an index used from valid values
+      and programmed in hardware to achieve the hardware settling delay.
+
+  qcom,avg-samples:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Number of samples to be used for measurement.
+      Averaging provides the option to obtain a single measurement
+      from the ADC that is an average of multiple samples. The value
+      selected is 2^(value).
+
+required:
+  - reg
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index b9dc04b0d307..16c80709a3ee 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -56,7 +56,7 @@ required:
 patternProperties:
   "^channel@[0-9a-f]+$":
     type: object
-    additionalProperties: false
+    unevaluatedProperties: false
     description: |
       Represents the external channels which are connected to the ADC.
       For compatible property "qcom,spmi-vadc" following channels, also known as
@@ -64,79 +64,7 @@ patternProperties:
       configuration nodes should be defined:
       VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
       VADC_GND_REF and VADC_VDD_VADC.
-
-    properties:
-      reg:
-        maxItems: 1
-        description: |
-          ADC channel number.
-          See include/dt-bindings/iio/qcom,spmi-vadc.h
-          For PMIC7 ADC, the channel numbers are specified separately per PMIC
-          in the PMIC-specific files in include/dt-bindings/iio/.
-
-      label:
-        description: |
-            ADC input of the platform as seen in the schematics.
-            For thermistor inputs connected to generic AMUX or GPIO inputs
-            these can vary across platform for the same pins. Hence select
-            the platform schematics name for this channel.
-
-      qcom,decimation:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            This parameter is used to decrease ADC sampling rate.
-            Quicker measurements can be made by reducing decimation ratio.
-
-      qcom,pre-scaling:
-        description: |
-            Used for scaling the channel input signal before the signal is
-            fed to VADC. The configuration for this node is to know the
-            pre-determined ratio and use it for post scaling. It is a pair of
-            integers, denoting the numerator and denominator of the fraction by which
-            input signal is multiplied. For example, <1 3> indicates the signal is scaled
-            down to 1/3 of its value before ADC measurement.
-            If property is not found default value depending on chip will be used.
-        $ref: /schemas/types.yaml#/definitions/uint32-array
-        oneOf:
-          - items:
-              - const: 1
-              - enum: [ 1, 3, 4, 6, 20, 8, 10, 16 ]
-          - items:
-              - const: 10
-              - const: 81
-
-      qcom,ratiometric:
-        description: |
-            Channel calibration type.
-            - For compatible property "qcom,spmi-vadc", if this property is
-              specified VADC will use the VDD reference (1.8V) and GND for
-              channel calibration. If property is not found, channel will be
-              calibrated with 0.625V and 1.25V reference channels, also
-              known as absolute calibration.
-            - For compatible property "qcom,spmi-adc5", "qcom,spmi-adc7" and
-              "qcom,spmi-adc-rev2", if this property is specified VADC will use
-              the VDD reference (1.875V) and GND for channel calibration. If
-              property is not found, channel will be calibrated with 0V and 1.25V
-              reference channels, also known as absolute calibration.
-        type: boolean
-
-      qcom,hw-settle-time:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            Time between AMUX getting configured and the ADC starting
-            conversion. The 'hw_settle_time' is an index used from valid values
-            and programmed in hardware to achieve the hardware settling delay.
-
-      qcom,avg-samples:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        description: |
-            Number of samples to be used for measurement.
-            Averaging provides the option to obtain a single measurement
-            from the ADC that is an average of multiple samples. The value
-            selected is 2^(value).
-
-    required:
-      - reg
+    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
 
 allOf:
   - if:
-- 
2.25.1


