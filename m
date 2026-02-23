Return-Path: <linux-pm+bounces-43006-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH/+OdcUnGkq/gMAu9opvQ
	(envelope-from <linux-pm+bounces-43006-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:50:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27A1734D0
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 09:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE588301BA91
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 08:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECE534D919;
	Mon, 23 Feb 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZPyfuybh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WENwx3Vw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66817BB21
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836629; cv=none; b=Mm1z8lfDzHyRal6SnoxVbdGRF+W+LjdHhD4tQ+LK9GJx3iqowxSmlS/ErH9vOO7kVcOqCJKqGH9f6l8RonsHQtvUSf2nntl6PXYdJtYD48Qv6TWFUNURHajn/VDOCHAQrGYiPUeSj3jrB6V+aH1IrpJ4sUhOBp/I+Y2GlU9gWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836629; c=relaxed/simple;
	bh=tfoHEdbEKPE7yYQOAY34kskre1XjGsK1y7UxEWJpo4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Forc1Apm3dPH9pp/rWJ2L/S+uKd61VawAA4Lvj4PLa16WkEQqFUXt2XEx+y3XWY5X7t54sFUDfjfNrD7eUC14qrFbdzNibSpFfCpM3MnM7tedENq/sfPZVuXiliit3y9k05uqLaMVN2bYFhgKLQhi54vkD/b0PEWrVKGCeuCCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZPyfuybh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WENwx3Vw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MMsBYf2238684
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 08:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Dj4rh2TYxJMELxyTse76w1
	9Oo+NkX67VQWfizBOFyc8=; b=ZPyfuybhAU7tQV31l8z+3dSX6kNDvlDeliZAK2
	SsTPGJeyr5LmmwwmtCEF0gDe7V/1vZfLDLMm/Q7DcvTo9acKjBbHe5Xvgln+L049
	W1J5hDL9Rg2rMclfu0G/zzBD5ZPB+ssx8ZJMphW14b+s3l3FHhRJwcI0lfJ9G8eF
	Hz6zdTKqEkS6Ctw7lCCLg3Q36c/AQ7esK266n5PX1qPZivNqtuV8S38AJcg3k5yd
	1VEC/E8iGrrU6MHh0SIfJptIVT8hbXnxPaRTDtNCce4BK3AHnwgvvcWa0jk/A0Lf
	0KKlh3yRsDuxcBMeKls73di46gTdaYc2tyEwZdkxKiLVuqeg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vukxtb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 08:50:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70cff1da5so3430732185a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 00:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771836627; x=1772441427; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj4rh2TYxJMELxyTse76w19Oo+NkX67VQWfizBOFyc8=;
        b=WENwx3Vwg8feN+Q58Lpz6BpknjVxM6jW/oZMzusJY5RtEazXsIb1bifw/f1b+SPDMQ
         2eMe2LivgyBWZsQLPyf7mZRcMcK1tjSRiQrOkbaLjME2ud3TsqIs5+NgfANCgldlwN+I
         h8lKS1DwOMcyXE04BaGJiHSTtaZFXwYuC7A71w3XeZX2hbp0/SZXYae0KfYY28KULqkI
         svKkLfmniP6ihzARBwTZiP0rAYzrHMyNF01+DXeqG+dQwMOEjSRWF9ROYBonurpKTXez
         sekTjb7aPDhVEZvZ6bLJTodkIhZaucN25FDleR/gA4Tizo9Set9Zc0UOf4A1ylNVlWcx
         DaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771836627; x=1772441427;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj4rh2TYxJMELxyTse76w19Oo+NkX67VQWfizBOFyc8=;
        b=ESUktZ9o5cE5ZRR/dlPRTE/U63/yXYFNVr14qjrNFxx6WdNL6mJH/22MGc/CgD9dCP
         P0O/XFwiD5kN7cmg5RC2ruh/M9eNzHhSaJts+mXKk1M/LN8nolLIkjGZ9n9ZlC9qUNWm
         SrCFRW42ugj8MLk87VqZbLKc/hE8cOpr+cRKKxQRbHGL6jAcamJDgvvIyV9BEUBF+wgD
         gc1AyAwbOQ7IPXOBOBDvQ0TKwqVxzQcUh6hNKxglt8hg2bTXkP0ga2RjndT06XXLyZ2u
         aqIa52tBC0bJp2J7CXwTPD27c6PRXUrKYK3IYdxNFOooJktOxFLmWZAedetxrP1SfEBK
         HIEA==
X-Gm-Message-State: AOJu0Yz+7ed5qvAmmhDDK1hidA81hvSiBLri/AKSRUOm9LZuxPaf1rCc
	28b0lFYvKtSDq/XWIotdNHXTIpmO5tuN5tP9lS7Jajxye89aHbkzpa5AYuywD+7iMhiBfmmtIyL
	N9Y/z+Ytk0Op9WbdyReNq3Cer9u/5s3iTj37BoCe2JGlyrl3f4ZZVxQVL8cQJ8Q==
X-Gm-Gg: AZuq6aKKH9y/Qo0xBKXe/yYJ5/UKnHkFx5TEN6N5mk/BGaCYfJlxaMLM8pMAXtzHCqJ
	Z86O/ihD2zIOJ1aVMsVH2hvlQmvvU2D5URIDt1pYZCKF+2q9rBgY1r9BliIYG4NmxZKNH0yLhDn
	Lfv7QdJpVX2T3XwsizFFW8kQOMfLWezdxyKeQNZkTAK334K2p3pPGCNBBGCIYffuZbcYXfFIMaV
	diPkqcQ5l0eY5xShmqiwOI5uIqCI37HkCbLUHnfqMDG9W0nVlP+kDheDiPViEBmza3xqjx1mP/7
	g01QIInBUhREhvOwm+OapNbZGXDVk+3VNrc/LMsSzyTO/pMB7YgvM0Y+xFYNbf49gqmqSB/ZFvo
	lh2zRO7YJAZRtGy90a4va2PAgCpgHXA==
X-Received: by 2002:a05:620a:460c:b0:8cb:5130:cfe0 with SMTP id af79cd13be357-8cb8ca63f87mr962478585a.51.1771836626876;
        Mon, 23 Feb 2026 00:50:26 -0800 (PST)
X-Received: by 2002:a05:620a:460c:b0:8cb:5130:cfe0 with SMTP id af79cd13be357-8cb8ca63f87mr962476985a.51.1771836626403;
        Mon, 23 Feb 2026 00:50:26 -0800 (PST)
Received: from hackbox.lan ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00c18sm17373169f8f.14.2026.02.23.00.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 00:50:25 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 23 Feb 2026 10:50:18 +0200
Subject: [PATCH] dt-bindings: cpufreq: qcom-hw: document Eliza cpufreq
 hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-eliza-bindings-cpufreq-v1-1-421f8e1e2805@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMkUnGkC/yXMTQqDQAxA4atI1g3YoLb0KtLF/ERNKaNOahHFu
 zvq8lu8t4JyFFZ4ZStE/otKHxLutwxcZ0LLKD4ZKKcqJyLkrywGrQQvoVV0w9REHpH8s3T0KG1
 BBlI8RG5kPsf1+7JO9sPud9xg23YBrS3degAAAA==
X-Change-ID: 20260222-eliza-bindings-cpufreq-2d85c275b42a
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=tfoHEdbEKPE7yYQOAY34kskre1XjGsK1y7UxEWJpo4Q=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpnBTQtk02I7gp/oP4CEIO5tlgYT4KGzVWOaxSi
 ySh4E4qBpaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaZwU0AAKCRAbX0TJAJUV
 VsO2D/93Sb+3KeVgYQiheJK53AaSV8P7Si2e+qOKi1ZrQtgnaCk0B5UBVhi6t9ZI7L9hx9lm2k7
 c/qxS2tQxAUEa20C9TeQUvlWn3WgIdwdDrUmk1EwO4Y0p6b4kby2Ve6tnl6mM4yzqN3UUYDFkYq
 oN3qLCdcbaOYv3AkZv62Nnh3YdEEGEaYB2KuXkKm0/8PC/25py5pHaD8y7Ls0udkRKjT7BRgLUv
 XqnxcvToRnH6BAjwAgFGPfC9/OeOXjSghK+nSBMsvNrKsfQ7xPPNMaaowC+hTcspXNH8xFYDhEt
 Ndrt/wa2j4AUpTH9V9gWrOzKeKlKQDEWjtKZ1UVsh3zg9OoPGfkMIXGGp/wYgTq59AfCtdC+D8J
 humhm4es36hzYMzcg960hRbpAzW+H/08/6KO2uGlajjeB8maFqswmXmbzzOJmC/sIu5mQOvLeqB
 /Pr3JjotlehhEvJmx7uvbCh7935i42HTY6F4XyRsjeTdnw2YLHVERFCftRythKiI7OKF+Bc3fgi
 phU2W559B3ztn3G3JtKY1PxK9x4DPs+JR47nHo1F+W9nGgSOMZBczaf/S3Ldw7iQZRI/EDFZ0Hf
 VRDgtaIArBxWpAtqRI6NB4briRP1aQwX4gUVDRJ3xLcHGXya3P8NudMNB+ULgNUMdtBAQx5w6oX
 XWcDFSoxR1gB+PA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=AL4GpdX7 c=1 sm=1 tr=0 ts=699c14d3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=I3TRSNoFFf1xjXuMxW8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 79E6VhW-AK56lMIOEQKWAQaCXZ96yxwT
X-Proofpoint-ORIG-GUID: 79E6VhW-AK56lMIOEQKWAQaCXZ96yxwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3OCBTYWx0ZWRfX/UFDJqrDrMF9
 aBz0tinN/lE4f05DYkgbuhTYF2ZzbM6ulMFfqwVKh9bm+dr+NFiQZnSmGeEudpsB4CtYCxf7acA
 nXxypAj9zGNejfIiG1rgFPVVcZlvA1O9tlHg62/c+BP01FKpxj7Gqfhkk1qK+MOcXoVkyprgAY/
 JIG6VXuE5iffieusdzsqePZl4xQYLonoKyesz9meX/mBL8DGokGWop8sOPgjfQzXRJSkquQXC0s
 b0jVLhVu8WZL5sPNJRA1CNiip3D3wxfCteS8Fj289FExcWeXC0TMH8757Di92cusJnCoQMTkuzE
 ylB4HtToEH9ILDWkj2WMupvobVY4aEcf22sUU9Wwb/svYR8ld5QaObfDyCv3YXtgUVQLERbQD7y
 zyMzf5VjNrq9lo2GOY9HQ2uOl3QJq913JK41btQ2oIb8TSvtXEfgDlR974WhJ7I6d6QxvF+WyQ3
 nN+fTUuxYhxT6lIU2oA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43006-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A27A1734D0
X-Rspamd-Action: no action

Document the cpufreq hardware on the Eliza SoC.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 22eeaef14f55..98eb36bff172 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -35,6 +35,7 @@ properties:
       - description: v2 of CPUFREQ HW (EPSS)
         items:
           - enum:
+              - qcom,eliza-cpufreq-epss
               - qcom,milos-cpufreq-epss
               - qcom,qcs8300-cpufreq-epss
               - qcom,qdu1000-cpufreq-epss

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260222-eliza-bindings-cpufreq-2d85c275b42a

Best regards,
--  
Abel Vesa <abel.vesa@oss.qualcomm.com>


