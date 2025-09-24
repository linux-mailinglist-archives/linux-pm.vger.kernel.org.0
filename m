Return-Path: <linux-pm+bounces-35315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C00B9C7F5
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 01:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663E9175AA1
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 23:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E683A2C0262;
	Wed, 24 Sep 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xeu+lEEX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D528B3E7
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755838; cv=none; b=NWSww0Aiy8Dv5mdM9SXpSad4HGN87aolXDP0c7mIlNTLT6k74wWF9ZQ0LVCHmEZcoflpHW9z1nbr/QrFzKOkSxGHpYr1+UvQdgSN58KpxqstxYxzq8fArf0D2V5mV1WJwrKS2pFVojbq77njwDP7jOYKq7H7OYWZobVUTQWq85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755838; c=relaxed/simple;
	bh=NDqSa0uXUcMg8nDk+VWW/r81O87p/6EtZwi1Ub6qOys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7WBhd1qwtJuytl+s1SdN3wIGQtUMGy4RR/6N48brxE2uyYSf/iN772HlYe8K8YhDFmRNU6iuZTQT4LN1ptjP1HUUNm+tSbiKmu9QtYgtkXz5FrR+6ZufUoJrFtF8DDhL0rqPRtJTD6dLTYJlIg2HczITGZ2ZLNiWvspNBBqbT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xeu+lEEX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD4q7X002127
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jFE1K+StjtZuaU3kr0iFGCxDv2nXJ/zhJydE+MCjc/Q=; b=Xeu+lEEX+YSBb5yb
	RAXRU+x2o/HM4BPg4yFpZaZYqgA0/1mw56aLxJYijfXcyLZyeREwcoKAe+G5tftH
	+WNPcd9NGWM6W4FCOGEcxe4LkhhPHC4IXUeS7CWC/njLy2tDZsOOfPmkGXs/ktsr
	1064ZIg57k0Xt1NSkAJZHh1LX8fN+uGulfGizw+/lTGXhxHk/1unUjLfJcsEql8Z
	kzGu9VUKTjPBMPbHmFAzPnCFuRrRscpAjWQm3f0zKjPjbiFgWLVWtn/APQq+noXO
	wgSQtQU5G4R2+CAVIu9AD1lK7QJw+9QQDnMdAmydIWIcd86SdbX0i61XV76jCqml
	WAWd7Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p0y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 23:17:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24456ebed7bso3261285ad.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 16:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755835; x=1759360635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFE1K+StjtZuaU3kr0iFGCxDv2nXJ/zhJydE+MCjc/Q=;
        b=seRYl8cG9Si5ubSMmlPh1sZYVWK4Bl8gSgZpmU6F/0+2P+idL1h3RDoC6GhbKpmiAf
         hKmGbGLMBWMAouTFAT1kILwJeW3eoOrjAca8uu0l0qVa5zsxyipptiFAZYx+nNq75GK1
         vhINKfL8u99Xyb0L0Ehp45Oxt8xDgHcLfr5E5gzlFiJkmE3ZTzKvEu20IM95YwjC1nOH
         KKClPpbz04FIEG4bDBRqoOWpR52lsAU0xlHGCW2y/KKOekyKKIBos/C8WMPlkV4HPPbp
         9LaXTexXrr3GwgpP0mnidZOY9W0Zu8nBtDwohQWs71pIJ7tk1jkZqj1BzIqGzCVpAGGz
         IMRw==
X-Forwarded-Encrypted: i=1; AJvYcCXtyn7pPYoK1NxnRi2ibyIDPPZ4d0LYy8VLKhY/UWns8A1pRHibhMG8Mqvp/Ena8yf8QR85R2/X3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzenAbwaPJQNIEHLOiX+rcSAIPMgnTMH8nv9tbdfarNxiHNhU+8
	K9HeHHZ7gzEM61fWIN2kK/VdTjNzTDtFfVKy8PsfT9Oin4sjUphRQLlb2uv/nm4/P+tpRjVLM4i
	TFefJdBvpfE4WuPTEzqN4Z+YY4hW9QOc99LOZo8x6xlLgHBK1r7/qILcHx+HDLw==
X-Gm-Gg: ASbGncuSm4aI5t1syso6JBJ4jy81upUvEdqBnSc6V5FE9B67ogse7DhddmqKB19u50s
	5SEWH9zdAgKV4rdjN60+23ary5a2dlViTB/bl8uabybbvNsCKJ6kqWClRjZk+UP2F40jopgfWoy
	DQTzwap8oWp3m/UhX4gmoVVpp96D4YpPso8oCx1dt/UiP8yrnFQHXlPvIqVsNK8DPXjMgM8puBw
	PJOImIRg0OBvwMTW1e7h4Z2v5Wc+rxX+HFDxXci8Gk+XlCjsGr5LjwqWZTiMIElYlmP8KODAE02
	x7CoowofRJ8/qMJF4DA19xIy9Glh/2y0HAONZvWIF8mxVWI1io4KchI9Z8uHrnUFJCGNw0yRvxU
	zdKBMnhmWdA2e2xs=
X-Received: by 2002:a17:902:f60d:b0:267:fa8d:29a6 with SMTP id d9443c01a7336-27ed710a48dmr5412305ad.25.1758755834713;
        Wed, 24 Sep 2025 16:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMlgdGUr/ZjZzWyrhYuIgs/J1eNkrBFx3tTLh5d32nm0isAajEsQqljF2fCZZEsbjYF9SNTA==
X-Received: by 2002:a17:902:f60d:b0:267:fa8d:29a6 with SMTP id d9443c01a7336-27ed710a48dmr5412065ad.25.1758755834290;
        Wed, 24 Sep 2025 16:17:14 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed699cbfesm3892125ad.108.2025.09.24.16.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:17:13 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:17:06 -0700
Subject: [PATCH 1/3] dt-bindings: power: qcom,rpmpd: document the Kaanapali
 RPMh Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-pd-v1-1-b78444125c91@oss.qualcomm.com>
References: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
In-Reply-To: <20250924-knp-pd-v1-0-b78444125c91@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755831; l=827;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=4qbu+a2M6+r0wYZDajhJwhrLqY8WqPugFl0GB06oldo=;
 b=+/FwS27n6/duMm1JCxEclW5CXGkYV+JJxwphU71pknluHoVMix3RRe9CulBDqK2xIxQWOPTn0
 mWccJk1Cky4ALCw//Qd3l6vT93BsmOLMXflwP+xwCs9CgsAAT6/Jhqy
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: DEGml4KEQoQG-_jhCHnItZ2GcJt--x57
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX6TMWRc0Ed6NN
 oiC5vEf5YcbqjBGg5yYTA8z4jXPcyHy/+ymUoKqdL7VCCtBuIfWhdTapXB6YGeiJSuemztRzpOh
 6Qf7zEmF7EZRRPyGJGVlJJnJZz1f1LLhZ1xS0Al5LNcqxTikTf5XXJJRG0F6dDFMVNeCKeIcnwS
 L5neUfzGqNy5gLkDreS8qJ/xo3A7axHXIRckOtYjlqsI0xHsjA8qV/odBkaRqp1RChFBqu7ac4+
 VT2HkHCqtdG78IrStaB0rJmp5sSUFPI9UinNHPor1lEZ5VDujuHudYSMt3Nd3TI2C7Ydw28fr4E
 Lg1W5yz+TCs09NHlfHTlh2AlscvWiKmHCHWulWqCRGuqO2cUqqXDYoKroa8X7ShjvcFy0CH2RUv
 X+Lz0eTb
X-Proofpoint-ORIG-GUID: DEGml4KEQoQG-_jhCHnItZ2GcJt--x57
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d47bfc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0Z_xqJqdlRmHXTOusawA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>

Document the RPMh Power Domains on the Kaanapali Platform.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index af5fef872529..27af5b8aa134 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -18,6 +18,7 @@ properties:
     oneOf:
       - enum:
           - qcom,glymur-rpmhpd
+          - qcom,kaanapali-rpmhpd
           - qcom,mdm9607-rpmpd
           - qcom,milos-rpmhpd
           - qcom,msm8226-rpmpd

-- 
2.25.1


