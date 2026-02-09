Return-Path: <linux-pm+bounces-42355-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cq5N3rgiWnGCwAAu9opvQ
	(envelope-from <linux-pm+bounces-42355-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 14:26:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F12C10FA7F
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5FB300D466
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 13:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE74378825;
	Mon,  9 Feb 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dyv2jjbg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D/zQZSDR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7E537880A
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643425; cv=none; b=bC5ZjwQU34Guorn9Un9RmeXlGD39jWlCE9ra9jljdOSBiMqDjYWCENJ1eRgZ58jPH1zmkvf9fZkWM+cUsJViW4coK/IaWW/ef3Fy4DWcOgLNgAOkLQjWFRmuqyOd6IzC/D8ig/UTAa0Pz8ETBPSFNLWgskSJ9/uZXEtEgwpRV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643425; c=relaxed/simple;
	bh=g/ZR74vhaTbG/KuTPVgsmyg7YXtgpFIDhkub2LjUZZQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=G/unsR8jA0lTal+uzVeDaNDBYxKyoH9NgcN+3HMVu7CwwIU59FGI/skbC1h9kO/NRKqcUkMB+4SSsi0kqzkWTaDrSQjq8PQABAfvlk97EGnxu7bPy+IFS0OACHUK0f7L60vl1ttuF91RoJrt35PA5FzcjB0+l0RpYcIlr+Oj634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dyv2jjbg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D/zQZSDR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619AkjGt3699944
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 13:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hypUfFCv2fOn8byPy1CQII
	P7AQPAc65urxcoNegxwvg=; b=dyv2jjbgDBeqbkWwdcSRKcsaZfSy9OsORjXfQA
	H3MOogPu/BuV/e8bcQ/gChSy1rtwxGg4+rq58gVIFvW+JZyvAd3xMMXrZaQXfrcD
	vndKojM2t5JeeS9eSbF9K377w8LLArpye1U9iexs1lj6mWKr95jtrcWPV+BNBLqA
	qIVm5RAs/kKDLSmWtwNOZmJGQ1ZxV0+kVKrYm2Lr6vZ8yIeCcpIkEGICySW0Imy9
	xHLqU1YFkzyU5XN0hZ140E2gguZcXOG8pQmQ9HHE2U4Ffz4kPhvF0GF1aTPiy4dq
	jXTWMz31mxVzTWAvmtFR06HvH00WInksn0k2b62ahQ+hDopA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4m8faq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 13:23:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a7b7f04a11so134691375ad.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 05:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770643424; x=1771248224; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hypUfFCv2fOn8byPy1CQIIP7AQPAc65urxcoNegxwvg=;
        b=D/zQZSDR93M+j0IkqQrI2yK9yO5hsuESYcYOs891Wiwg7lvtH/6wm+JFTHJFhHJgyY
         m3isdtnaQLKXwwy2inwNQWS2NgQ4gD7P5RadYlL4q3gC/sY16nhxuLxwGWls4SxK9bUJ
         505pWO0ckKgHLDhmKY/iRmyPWR1X7GEw+bwU8UCwIvT9tyjKrPRZvIHFARXArmF/uBu4
         A53+OTWJJb0QWKNomurF54wke6HsZCmCF1i6MCkN4zbN9RQ4T7SEY2HF8H396C72VQdm
         pD3okXK97vtfWnIOEFwRNmdXeoJzrC3QKQcA0sYFhj3unRSDsl/ZkZq+QIyKz9iCFA9i
         9CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643424; x=1771248224;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hypUfFCv2fOn8byPy1CQIIP7AQPAc65urxcoNegxwvg=;
        b=ZasWlBtJcwWRzcCUf4Ct+G2GQYHE1h/6cbn9IhIRPdi4911YwxZRtnrvfZ8TRZ1zhK
         5FNBf7isind0MFSLZyKuw/glQoIWDojW7A/1hnQeZYB6SckG2OosQf+n7mwTur9WAoB/
         xP+2pUKbmlHyVZhQNWaaBZL35y8izwargbpIudjJh5Ec8KjQf4HVm4V2PHvZHCVqLq/V
         VEgx+Km9L8QYpMCitZx6ktL+kmPjkFWG54mvxQcdrvZnSZ8GQBnXy8mYcgpoTurVPhZc
         naMpzCpA85ayebzWBmzO1sUvwjOrugFApqFa9ATvOu5xLzuSOEPzaLM+PVCgAzAbYwFS
         86Gw==
X-Gm-Message-State: AOJu0YwsdJ2AjWjlfUAthJ2NmDOixKzdfNtsya/ibZT7oKzORnHjs9U+
	MMS8F2FpF5RgpA6wSXLchZMmqeeWl4mOc5Ny6ZMlUg2yCeFysFp4MpOp+NV9HWqMxlWmVA6D5GG
	ctgtf6H6nBHxgcbhcrozWbIhz71A26Hl1V92zZukCZVFLo43zcETqkSP1FRey
X-Gm-Gg: AZuq6aKSlHdUqKclR+4Uri7vIFPEYonboF9QxzX71mjR3ebwt67aK7+hWeoNtmkowGA
	uMSgMbdr6Bp/1RXzAEezxaSglVW+6p+SoBKtO9sJcxfcWOTLTh1ZpDZXH99j3oMwDfAPZCOoNO6
	EVtrv/p4Oo0C05FK5GRLeNP6vbp+LIpITcm60+3O0W1Co2uxdTmOUyMc8Gho3zlCutprgbijgJd
	Z1sXt0tMAZEULfrY4x94OqXGoHLHWSy1Mr68Ch8lGIszJwHiMIZ0Qsd3Wz9EUtIbOxqXaF11xfr
	KxE4E3ROW/CljFko8P3b1K59BcIaiT2WpDMzcLMmNq0iJ726jyuqml/JqBU2zKaQkrI7kGt0F/Y
	vcAyaQEQCtQEQR5/RbvKPX+U1cnw+puIBOBa3Kh4=
X-Received: by 2002:a17:902:da91:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a9516cd2fbmr122478965ad.21.1770643423992;
        Mon, 09 Feb 2026 05:23:43 -0800 (PST)
X-Received: by 2002:a17:902:da91:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a9516cd2fbmr122478585ad.21.1770643423509;
        Mon, 09 Feb 2026 05:23:43 -0800 (PST)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ba245sm107895765ad.47.2026.02.09.05.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:23:43 -0800 (PST)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH v2 0/3] monaco: Add PMM8654AU PON support
Date: Mon, 09 Feb 2026 18:53:35 +0530
Message-Id: <20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANffiWkC/23MQQ7CIBCF4as0s5YGqKXVlfcwhhAYLNFCHbRqm
 t5d4saNm5d8i/cvkJECZthXCxDOIYcUC+SmAjuYeEYWXDFILhWXXDHjnJ6edMG3NtFpwhwis62
 zfouNb5SDcp0IfXh9s8dTsac0svtAaH4xIeX/2CyYYGbnse/apuuFOqSc69vDXG0ax7oMrOsH0
 zbGILkAAAA=
X-Change-ID: 20260206-add_pwrkey_and_resin-c5dcf4e3f36d
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770643418; l=1016;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=g/ZR74vhaTbG/KuTPVgsmyg7YXtgpFIDhkub2LjUZZQ=;
 b=N8i5t7LvRfWFPv655ifUkpJaCw+u/jpmU7uQYC+N0W91NkAY7LRwCkMcH6sa1m95/ntXI8mwm
 iSz50LwuyLIDeJbH1lWE/9FZLuKWxHHA0sWkXDu2gj+MLkXC2/t5as9
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-GUID: adZHvYYISfQa-2AYYuKSAjAkT-DXqbkn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDExMiBTYWx0ZWRfX5DWasswibCkE
 pba+qyZP5HdBV038HI1vVNic324W/eJhakXInpsg1qmR7uat/5Ck5OUWo8ArTG85SOalaJ/XbNZ
 wkhnvMJBmhH+j6Iemfr/nqwccgWx/RhWFV4tOUEgOq3i4wujhUdt9l/VhNBUFFwFmUJ+/qRErjU
 A2+ZJoKGmvNxKO7bx/BmIt8oaM6Ikg5LxC7gn/RJXcjCb7/S2kLalcOqfW8g5QeHD/edynGGLRa
 lDliP4MbS9JFDAdykbPynRMNs8fz2sgzxoYrvxe5c/LOwnmyF9y3ydZOP+8jK0sadQqtHEYFZrN
 rZn2vzGTPxB9hnqNq2zHL3UQB9tKyN3Btu5oG5VIbZg36kFLS0MyMCRcb/0KgfUyezx9xv7ChRa
 hbCUbytqyOyRj3eQ4V7Q4WPdNJKK/NHsrTc8tsg6cNpYDalseax7WYah9FAD/LTA4zvYo0zSi5B
 1kGuINkW0V3Iqrf18VA==
X-Proofpoint-ORIG-GUID: adZHvYYISfQa-2AYYuKSAjAkT-DXqbkn
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=6989dfe0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=x58ZVvKx_e4wcmJFeN0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090112
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42355-lists,linux-pm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,sonymobile.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rakesh.kota@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F12C10FA7F
X-Rspamd-Action: no action

This patch series updates the PON power and reset dt-bindings and
device tree to add support for PON power and reset keys on the 
Monaco platform.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v2:
- Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.

---
Rakesh Kota (3):
      dt-bindings: power: reset: qcom-pon: Add new compatible PMM8654AU
      dt-bindings: input: qcom,pm8941-pwrkey: Document PMM8654AU
      arm64: dts: qcom: monaco-pmics: Add PON power key and reset inputs

 .../bindings/input/qcom,pm8941-pwrkey.yaml           | 17 ++++++++++++-----
 .../devicetree/bindings/power/reset/qcom,pon.yaml    | 16 ++++++++++------
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi           | 20 ++++++++++++++++++++
 3 files changed, 42 insertions(+), 11 deletions(-)
---
base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
change-id: 20260206-add_pwrkey_and_resin-c5dcf4e3f36d

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


