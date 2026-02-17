Return-Path: <linux-pm+bounces-42747-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EWjCEpnlGlFDgIAu9opvQ
	(envelope-from <linux-pm+bounces-42747-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:04:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886014C518
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A88D43028D59
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1A23358D2;
	Tue, 17 Feb 2026 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OBIHd0AU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVSzHPp5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE73596E7
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333247; cv=none; b=C9xJNuzXrC3F3uitVCwd0WkdVVpjuk3h9QW2WD/m93A1OR+6mRF9sVkPSMADhdOGJWFp4tSDJ+KIZpKK7AZTZVddin6LqdMAKF6s4NjkjSs+YyDnuZoOy9K/+aXVzR+Lsk660Oow55YUDIKhOZFwAurabofILMtpHmAcrRZldkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333247; c=relaxed/simple;
	bh=uHfBWLqN8X1WgnAF9WwBF4Xru1wOFFbx2aCGVEi/DdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GfQrBOScjxqqESXV/BDD01cpP06+xZ59Q0tAXON9+WgtnEeKPBWxndoM9fmqM0/8ZYCEXD0VoK34OcQH2RAwq1X4TqNqdONIYNnQXvpaZ5fR6HpItNx9rraFkjHf2QKCrw/I84kXIRDc9g24ptxnw4n0hh36FPCAH0hFaykHVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OBIHd0AU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVSzHPp5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBqW5R919268
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ur5RSTe4fLLt+HWcvPskwk/5C9GivWUoPg4
	Y8NGCusY=; b=OBIHd0AUhwxPGK70atGMQiIaEA3x/9SRmtQmGPtu6hv0xkHtAec
	YQYY8u0XaJV8oIr9S6Jn6TqrQFoOy9F6eIPRIvhp8l8KKHA0qiTwy1Kov8zg327B
	RlI0hLdb/QdHqNozaSBtbmyRbyKVmpx1VRtvCU3flV5U2fMKJbq/G/S1Y2O+SA07
	jiAvoIwpDlN7Z7qRwIfW6V687Uj2ms5+/fXhuKxbXpQC6I9n6W8KJdMRZeN+yDgI
	YmmBC6xjQn65MG0b8VkLAEYTRANP5EDapmZqNVZCwFos49EN6IT11FSlplWigjuQ
	ZO94HykPBECGS2WT/DblPmsar26QM18+YVg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d82eh9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 13:00:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70e610242so2684133585a.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771333245; x=1771938045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ur5RSTe4fLLt+HWcvPskwk/5C9GivWUoPg4Y8NGCusY=;
        b=JVSzHPp5kpz1oVaEiLLvks4ytwmfEZZiITZw9McloLO93K3BuvGhetCQadc5tJUmMr
         iVuUDREpY4V8zdhC+NaAOkpuu8V/3iwr3SXa9bBhTG/boDGbjqR9ZEXqMuojPMgeE4k9
         qG5IGv+FUyP0KbZX6AMSkV6rqaN5yKZjbGDohT5uoTXLOWWTdsbrquGdulUuPJUZFFED
         964OkRy0GIXPaHmL7vxkGj9ZB4OmPm5abnDL1UwmTuX9vMqvjkox1HfQFqZtQjh4YI0D
         6FI9exNf20pm8NHl852ivIGDXQeUnseYGBywzMgdo/r7CKeGY4kVlNvFSZiebC9FNtX9
         tbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333245; x=1771938045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur5RSTe4fLLt+HWcvPskwk/5C9GivWUoPg4Y8NGCusY=;
        b=MVEE6OXZtF5VuP5D3+4klLNwBK3yyYNatr0duQWjOH1PFg6m1h+Fsf7jYrWyZQ6vzY
         vivlnrPYeUCeQOj2VWN70TOKNmexhZFKJvuCA6EKZnTryjbOXK6K/GQhpWIDUXIHeM35
         k4Mv2LxsJdou4zzAtZ0K3NGdHcMtjxqRO+saHPEVQZ+Syzrhns1bDre4UecNgkDEvpQC
         F+sh/mokEAEUq99xNr24rYW87rgu1qa1vuBxKIyfw2Iy1zaZrC2gevbi5C09xgUJ2hUd
         O/4hR/c5OF4iBtKChwvVCaelK1frR5DBnZKr39+rO9q4g/OG0+1K38B6VBFt5gN935Lz
         wLAA==
X-Forwarded-Encrypted: i=1; AJvYcCU+f8iLM5I/3oNG1Ldg1+TgvK/nVWDDHJYB7LkOljUuXxNVMqMauZm6QYh8iWs//e9B0lx6HT2cww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTo2dkAaDXqwkgc+26X8S/Wi/C9MWBpLWYqO7hM0U+j4s/UdgQ
	Sy9F8XR5tAh+p7sGiBv4/ofJ5YzNwlcid7NYKs3Y7isB0dM4lvaWtOei8EFcZz/VOCxcBm8vJb3
	khx7IM2PI/5weJ5HPrjOljTmXdPAymLZoT2thEa0wCZTgBm5XTRBfgnTmBascXA==
X-Gm-Gg: AZuq6aL3D/0a9Ch/8X84KqTDGRkk3rpCXnszc6NdVt5eUaZGCXuLgwFiqakRPvTUwm5
	aPYLIgfQMvVI87kfVkGFI74BwRyG5pEDMQINNk5ybs7qaogZTpU+2hsjHrzdzT7fahL6PvzKvKK
	TO7dt/Et9SYSXcFo++gQLeF5J8RV9PbOLIkkUZWD6NeUIR72/XuKWx7hAz1XhMnb3g5Rpnl7xGW
	zlXcPi4QK+9io6hd7JbdF2LE6bsO+PMoIkAYahaiEZn0oFmNI2OMDEd0OilX1jaCNFW+iz27PVt
	MfpjYkM2uMYUhMqJYjCnLUYGTC48qeg4aR/epTM7fTF9Ver8efP/BF7xjxPwPwmvq6lPkWZ/61P
	PVSBUGoNXTlfqeRvcDoSTjHhp5vh7C/nRN0oaKw==
X-Received: by 2002:a05:620a:254b:b0:8c7:f62:21c7 with SMTP id af79cd13be357-8cb42281159mr1621038085a.20.1771333244352;
        Tue, 17 Feb 2026 05:00:44 -0800 (PST)
X-Received: by 2002:a05:620a:254b:b0:8c7:f62:21c7 with SMTP id af79cd13be357-8cb42281159mr1621015085a.20.1771333242270;
        Tue, 17 Feb 2026 05:00:42 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a44ae0sm100240045e9.29.2026.02.17.05.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 05:00:41 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom,glymur-rpmh: De-acronymize SoC name
Date: Tue, 17 Feb 2026 14:00:36 +0100
Message-ID: <20260217130035.281752-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=uHfBWLqN8X1WgnAF9WwBF4Xru1wOFFbx2aCGVEi/DdY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBplGZzUyE1UJhO9c3rw39SaxLBP+mJ+RGNxZo79
 KulHrFapG+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZRmcwAKCRDBN2bmhouD
 1+wtD/9Kfd0Lh4iBIzMyoUfjQk9dgiBH3qMH9ShJMaYLtpFqTf82rE++FpKngmnlMhrqO2bec++
 HeHEzksNkskmop/WyKfWGT/5E6Qi4LTptJxmVTKEYJid3XVL5ZfDghQw+IZbCaiBeEgBjl/ToC6
 lPm0j8NVJhmUkfCDWF+cGg4cK13GVbZlrVW63hdewideLLi1E5ffLsi1ZNTNH7qxzdAP5xf1C1a
 41dhmsIB6Uk/HTC/KUWqlbED6/Zn/aIDT3z1/uA7QoJ6DlFVkvFDRYcg0wA2MaRjc19JIZ2oIqG
 xu4GCqaRb0MEJuFkNj0jmeuolIRReo09sGZOJ1pYKpMKB+HqGB8pBdfJYBP7J4Sqj7X5s+ehjGB
 DPHeVSnBg3wOzSygauf3YKVA/Is9o4QY6jxxqJNydpI+/l6TE1YFzca97fZwJMpnBYywX0TNH0Z
 JR7CSg+FZPk/sr9k8T338wC9Jbgjcs1uAKcNt5l+v2J0JHMmgFoOxbtVxpfotqR4fSYqKoohCJg
 l2ZFgy4Cz8K4KBgfY8tYwP+0HYwqKMYmnSYxBQ7TmWFim/bf4TUBrKHmzfpoBfDM05DQm9XGArW
 /47KNAe1rZIPOjNRL5WIgQJeV/Hej9KV5YJ1VizGGKt5mpJzzg4oP/+YufKaVj6osVAOplrknJ2 BRpkWf2B5570fig==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=6994667d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=XOZzOcVMVPqQqVsGDssA:9 a=PEH46H7Ffwr30OY-TuGO:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDEwNiBTYWx0ZWRfXy2aD6diOgeRb
 OgwxbKVA29SADEZ315Pq5xg7QJJaAvAHhUhqSd4S5oXJW+hiJtbQmU8SroWSWcCI50D0pVeik3a
 aBrsrRjCRR1dgO7DB6BXBaMO03dVs/ZcaupUgkbrtvpH8Ltrw1UGr5HJ4jgPilKVvZ8eAyg41ty
 X9/2DQZOfy44hTaIw1k6itguikPT4C5ZPqAyyXzh6uszMi4hD5aOACQ87+31nHv3+amPQAjQ3kl
 hKFusl5JCS4r6G5Sa0HLhZ6fHxMBEB17AtkDsEzmDcGLLzAmmsB3P64W5jnLX0JSiWbNIy87HwD
 iX1V+lZ0g6y7Ts/4aa3+z+e62B2C92oKNGxNg49AsOf1waq1eMC1siI3GwmS2EnnE0m+dtNGjtU
 GH6cqeWzj1SEErTPisQVI1zZaO4pX+/TpOGlCjIA7ZiPGYfyEwVHIe1LDO4twRvzDcWc6LJkS8N
 5LFiuSc0o3B7+3Nk5Vg==
X-Proofpoint-GUID: 6MnKsLPbMTd8b-ZcJamWDrwp6YzUOmhG
X-Proofpoint-ORIG-GUID: 6MnKsLPbMTd8b-ZcJamWDrwp6YzUOmhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170106
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42747-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,devicetree.org:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4886014C518
X-Rspamd-Action: no action

Glymur is a codename of Qualcomm SoC, not an acronym.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
Split from previous patchset, because I messed up commands and combined
wrong patches together.
---
 .../devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
index d55a7bcf5591..65b0ff2b2c85 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interconnect/qcom,glymur-rpmh.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm RPMh Network-On-Chip Interconnect on GLYMUR
+title: Qualcomm RPMh Network-On-Chip Interconnect on Glymur SoC
 
 maintainers:
   - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
-- 
2.51.0


