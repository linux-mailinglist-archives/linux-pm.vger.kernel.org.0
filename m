Return-Path: <linux-pm+bounces-41775-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKJtAAmcfGn2NwIAu9opvQ
	(envelope-from <linux-pm+bounces-41775-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:54:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C334BA323
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A92EC301D31E
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17B36E479;
	Fri, 30 Jan 2026 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8hjxkTy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hRkHk0sq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DBC36F407
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769774079; cv=none; b=UUFde/IkVNhoV1JWae5z2cAaXHFHxB6QUA2JHWtNO9jBnA07+ikX0yiqBi4P3QFIlGJVgI4aE6xZugYYgJBONFb+yn4fUk6VJGQmBxuGQRpSwmVfcp+QB3jAZXU8U+UrkCBYIUxDN35p/CyjNGb3WFm1MK78kzPmJ6pnUp6VRyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769774079; c=relaxed/simple;
	bh=9nJeV5otfxhvyVk/o3mAdnETeHwPKzjbL0aq17GpJ1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tUblrANv5/ZgUEipybFWemAZCde2ktZoyArccGa8CI0MolvbgyiND2Om/SVv5suDMPCNlhN07gvmoNcji5mq9UdyecFUqYQFnLHAYzjp1/mYheWw/GFq4JoiszWvumzToVvuPxGwjmYcaYabQsIHoW88TkLppN93NOH3a6GoG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a8hjxkTy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hRkHk0sq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAHUL8995921
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6DxR+POmIz59mgQ++mArmaUuOtuww7k8jS+
	8SDgDEck=; b=a8hjxkTya+8mNNpjlQ1oxD0hJ/NrAzaZrN4Fi199xmQV8UM5LiQ
	mQv1DuH7zPTubvQLisvTwxleZJvDp2ANYvAC5ELHuM8JvimNp9wgbS1aoBdNWnAz
	TS5THZRUOaYs4EAg9SmOYS5FPcl6pYR1HpSuJZyM0Opr0eTcIcVoxbfwHy69+Vjy
	h6eM54Yx3fDOo6XF5aVaV5q3jxt5Z+TPHgagCXqZc7/PdF3QXI5U8GEu+hv34grS
	bMbhrmCa3nZbuddl17Gw6DPmhbBfoH0N37+o3pzr2wigl+l9FBdl2E1vCojuTfEn
	+zNRXPpRVvnPXltLZU5JX7sJhJUcP0EzWWA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvjyd2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:54:36 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a784b2234dso51470415ad.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 03:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769774075; x=1770378875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DxR+POmIz59mgQ++mArmaUuOtuww7k8jS+8SDgDEck=;
        b=hRkHk0sqsV0prqkY9qNfn2eM8BinGAaRlSmMrjTT2kj6eMZIrTPwR5sbMDChPRe29K
         Zjr00cHEk4pw2jLTXMKOLUYY8bgI1w5Z+SFLxxQUFIgZibkMHN/239KXBVGTP0Bn82JX
         IKTtlmLBxH+iVULKGIwjaxuEqtzqxwHV1W/d9Tks2QxACzcLGAOaVkfsg/9aW6S2Z3KZ
         ZTjOR2WWsrvsCfzFikdUxARmwK0UfaZY14GQoc8GnIfxmn83RlxU2Z30IoVk+7ckvcBT
         ixQMjGznt4t+78IXlM/oH0qXo3Zb3035MwHn/ikxrIb3VN2f+01Hb6HvPaI+hSk/+f/V
         O3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769774075; x=1770378875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DxR+POmIz59mgQ++mArmaUuOtuww7k8jS+8SDgDEck=;
        b=Y8hG6sKV8KKkb08v7hJobjxkpSZv79Zn9MTMaI1G0XmH4bluU8AFtJBm3ILogRGkeH
         Zv0Glekb55hlbe2Y/rOnuw82W4RS3ieC0oN4MsZ+YKd9xIza1kd6/O/9QqOOwCAAyUBM
         NJpCPV5ilAsryqYDaXdH+PnJ1JDFbvhnctdFNbhQu1ZSey7LMxf/oRXjUd68p9WIR828
         suI5V/GrDRWA4HjSSlZKadKTdQlCMMS2qbuPBKjE2A2lfsondjKL4EHEnnxGu8rBYk0+
         nMisQpJaK/5otJWmp+ZewE3IKqdYYVjcD6nfB7QPCERE25Y/wwKmZRLhnKQvqa8k5Myt
         j2aA==
X-Forwarded-Encrypted: i=1; AJvYcCXm3S+YFaZTQhbA4f3jAxse0S9teE0D3JKfp0st6nVwjogafHdbjt4sR6oqQFpTIxvP8dL1OyWeQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Qti34PR06MLiujXLkrgPXOEihclukxyrJXUO5JIrb7ck1qKa
	vypX8PAZ7kPEV+Eway3y04KAFQDKG5YjScaX6SO54L5+JdtrWYbc/jJqPVsL+z9ZBAeE4byknuL
	cPi4PCiio4ku/tS0YisvGFCjCnJARfOyOgSlKK+XYsgxBVjvH62xdufZj5FAXIQ==
X-Gm-Gg: AZuq6aJM8P8+/ujl6HnFDZQrYjycfp3cKoyqx3dh5uNN1/j2XtDiK1Vcg8s3bz0Fnta
	nzPWIfVP3EbOn3hKUtEPLEPg0Zdc13ZJdnlgYuSSThbSocRTqNRfvxeM8EygvICWDtduRUtrFSt
	PlT3TKh/Qy58uktby7oT6DWLVcsxNiD20t+qXkSO45BHQ+vQJir+qEb68J2iJoBUSCz4XAIUFlo
	r57zcHR+o2F9zwTfnO3TsKh1BuD20LG1SnwEpJe/NkVGD92Ar0ZcxAlM/0Wq049kjSVjsgrTyUE
	Df+w6r1YAgHd8JX4PiSWQQLZSkNNfkyox9kj2usAJYHP5nNk4osIyNM5FZDVc3/r8Vp3DhJEw7e
	n/ofGctk8igsPPlGITJgxyEuwlxAPZxTUzk9BPGXpXA24
X-Received: by 2002:a17:90b:2e47:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-3543b3e3a6amr2950604a91.37.1769774075320;
        Fri, 30 Jan 2026 03:54:35 -0800 (PST)
X-Received: by 2002:a17:90b:2e47:b0:34a:b8fc:f1d8 with SMTP id 98e67ed59e1d1-3543b3e3a6amr2950553a91.37.1769774074844;
        Fri, 30 Jan 2026 03:54:34 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2f24ccsm10431278a91.8.2026.01.30.03.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 03:54:34 -0800 (PST)
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
        stephan.gerhold@linaro.org
Subject: [PATCH V10 0/4] Add support for QCOM SPMI PMIC5 Gen3 ADC
Date: Fri, 30 Jan 2026 17:24:17 +0530
Message-Id: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697c9bfc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=XccleKrqIk_kMzO7r2MA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NbbOHPw3or1_Mefuzc7wDORJBU3R0oW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5NyBTYWx0ZWRfX1Z4rpsYt3hDn
 gNvJcyyuE4kVVy5++t5RyR77U2+11VDERzcpdeufrhFs4bZ783d7tGRZKBVZtzBEQ8ZMqnPk3j1
 GQfUSO6OkB56G2ABZUzUZAh74tpExKbGD+75OYm/kxI1TMi97IqT1mwv1POmk/ruImhiISqKMnF
 TgTDP3WHUtw6h2f21RuwLizXynsbAupKandry42itbFvs4MlXTO3wnaKEy0gaxf9dMaIDIR3x7i
 8F8bh52jlXEFYYhHkeRdjxhnNXvsd9rp4p2nSOhwmDcz1Yvq2YiQSpyrZMK6YFlX72qX9+gCH2o
 ZYoTsY5KtDZAFFUmnTXmo7rahSLNyzuffinb3WQqM8JXhYBM/zfKAElRzcfPCTCTqbTNTkNaqCn
 NGeToPeVXrwa0ULYEMeGlqN2w2yxIdU2y2ep9eoT28BfucRXRM9coegNiOZVp9df+Ecz8VxxE+/
 b3IoRH746JqDSKGIZDQ==
X-Proofpoint-ORIG-GUID: NbbOHPw3or1_Mefuzc7wDORJBU3R0oW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300097
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-41775-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jishnu.prakash@oss.qualcomm.com,linux-pm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9C334BA323
X-Rspamd-Action: no action

PMIC5 Gen3 has a similar ADC architecture to that on PMIC5 Gen2,
with all SW communication to ADC going through PMK8550 which
communicates with other PMICs through PBS. The major difference is
that the register interface used here is that of an SDAM present on
PMK8550, rather than a dedicated ADC peripheral. There may be more than one
SDAM used for ADC5 Gen3. Each ADC SDAM has eight channels, each of which may
be used for either immediate reads (same functionality as previous PMIC5 and
PMIC5 Gen2 ADC peripherals) or recurring measurements (same as PMIC5 and PMIC5
Gen2 ADC_TM functionality). In this case, we have VADC and ADC_TM functionality
combined into the same module.

Patch 1 splits out the common ADC channel properties used on older
VADC devices, which would also be reused on ADC5 Gen3, into a common 
binding file, to be referenced in Gen3 and other ADC binding files.

Patch 2 adds bindings for ADC5 Gen3 peripheral.

Patch 3 adds the main driver for ADC5 Gen3.

Patch 4 adds the auxiliary thermal driver which supports the ADC_TM
functionality of ADC5 Gen3.

Changes since v9:
- In patch 4, replaced the break statement within scoped_guard() in tm_handler_work()
  with return statement to fix the error reported by kernel test robot.

Changes since v8:
- Collected Reviewed-by tag from Krzysztof on patch 2.
- Dropped the common module (drivers/iio/adc/qcom-adc5-gen3-common.c) as suggested
  by Dmitry.
- Made changes in patches 3 and 4 to simplify auxiliary device structure to use
  module_auxiliary_driver() as requested by Dmitry.
- Updated header files included in all newly added files to follow IWYU
  (include-what-you-use) principles as requested by Jonathan.
- Addressed all remaining comments from Jonathan in patches 3 and 4, for
  refactoring some code.
- More details about all changes are present in per-patch change logs.
- Link to v8: https://lore.kernel.org/all/20251127134036.209905-1-jishnu.prakash@oss.qualcomm.com/

Changes since v7:
- Based on a discussion with Krzysztof concluded here: 
  https://lore.kernel.org/all/d10e2eea-4b86-4e1a-b7a0-54c55907a605@oss.qualcomm.com/,
  patch 1 in the previous series is updated to move ADC header files from binding to
  devicetree folders, as they contain HW constants, not exactly bindings.
  Earlier in series v7, patches 3 (Gen3 binding) and 4 (driver) were dependent on
  patch 1, as it updated the location of include/dt-bindings/iio/qcom,spmi-vadc.h,
  which was used in patches 3 and 4 for Gen3 channel macros. In v8, these macros
  will be added in other new files, so the former patch 1 will now be a standalone
  change separate from this series, as the other patches here are no longer
  dependent on it.
- Patches 2/3/4/5 of v7 are now patches 1/2/3/4 in v8. Below comments refer to
  v7 patch numbers.
- Updated description of `reg` property in patch 2 to completely drop mentions of binding
  file paths, to simplify it and avoid any dependencies with patch 1.
- Dropped all ADC channel macro definitions from patch 3, updated binding example
  correspondingly and fixed formatting inconsistancies in property names, to address
  Krzysztof's comments.
- Addressed all comments from Jonathan in driver patches 4 and 5, for fixing formatting
  and refactoring some code.
- In patch 4, added ADC5 Gen3 channel macros in qcom-adc5-gen3-common.h, for use in main
  driver file. Also added a check to fail probe in case ADC channel value obtained
  from devicetree is not among list of supported channels.
- More details about all changes are present in per-patch change logs.
- Link to v7: https://lore.kernel.org/all/20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com/

Changes since v6:
- Collected Acked-by tags from Jonathan on patches 1, 2 and 3.
- Addressed Neil's comment in patch 3.
- Updated copyright to yearless one in newly added files, following new internal guidelines.
- Addressed all comments from Jonathan on patches 4 and 5 (most importantly for updating
  auxiliary device cleanup handling to fix memory freeing issues).
- More details about all changes are present in per-patch change logs.
- Link to v6: https://lore.kernel.org/all/20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com/

Changes since v5:
- Collected Reviewed-by tag from Krzysztof on patch 2.
- Addressed all comments from Krzysztof and Jonathan on patch 3.
- Addressed all comments from Jonathan on patches 4 and 5.
- More details about all changes are present in per-patch change logs.
- Link to v5: https://lore.kernel.org/all/20250131183242.3653595-1-jishnu.prakash@oss.qualcomm.com/

Changes since v4:
- Split common ADC channel properties out into a separate file to use as 
  ref for ADC5 Gen3 and moved ADC5 Gen3 documentation into a separate
  file as suggested by reviewers.
- Addressed few reviewer comments in driver patches.
- Link to v4: https://lore.kernel.org/all/20241030185854.4015348-1-quic_jprakash@quicinc.com/

Changes since v3:
- Updated files affected by adc file path change in /arch/arm folder,
  which were missed earlier.
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and addressed reviewer comments for all bindings.
- Addressed review comments in driver patch. Split out TM functionality into
  auxiliary driver in separate patch and added required changes in main driver, as
  suggested by Dmitry.
- Link to v3: https://lore.kernel.org/all/20231231171237.3322376-1-quic_jprakash@quicinc.com/

Changes since v2:
- Reordered patches to keep cleanup change for ADC files first.
- Moved ADC5 Gen3 documentation into a separate file

Changes since v1:
- Dropped patches 1-5 for changing 'ADC7' peripheral name to 'ADC5 Gen2'.
- Addressed reviewer comments for binding and driver patches for ADC5 Gen3.
- Combined patches 8-11 into a single patch as requested by reviewers to make
  the change clearer and made all fixes required in same patch.

Jishnu Prakash (4):
  dt-bindings: iio: adc: Split out QCOM VADC channel properties
  dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  iio: adc: Add support for QCOM PMIC5 Gen3 ADC
  thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 151 +++
 .../iio/adc/qcom,spmi-vadc-common.yaml        |  84 ++
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |  78 +-
 .../bindings/mfd/qcom,spmi-pmic.yaml          |   1 +
 drivers/iio/adc/Kconfig                       |  26 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/qcom-spmi-adc5-gen3.c         | 860 ++++++++++++++++++
 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 512 +++++++++++
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 211 +++++
 11 files changed, 1860 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
 create mode 100644 drivers/iio/adc/qcom-spmi-adc5-gen3.c
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
 create mode 100644 include/linux/iio/adc/qcom-adc5-gen3-common.h


base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
-- 
2.25.1


