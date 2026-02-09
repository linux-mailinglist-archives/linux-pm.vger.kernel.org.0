Return-Path: <linux-pm+bounces-42351-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFiNLU29iWmkBQUAu9opvQ
	(envelope-from <linux-pm+bounces-42351-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:56:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB210E6A6
	for <lists+linux-pm@lfdr.de>; Mon, 09 Feb 2026 11:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDB283002D1E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Feb 2026 10:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15836997D;
	Mon,  9 Feb 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niMTIiZm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdW7NM7L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC6369232
	for <linux-pm@vger.kernel.org>; Mon,  9 Feb 2026 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770634570; cv=none; b=symTHvxoaPqosNawfkIz5ox6fxiVz8N1LN3FyjG+IqjYVBIkqiuwmcjd0mJL2uILmb0wqsuPamLuh7JqrFmK95UoIKKpo+BmWsMkYAs7n9oEnj0/3ELs1xKu4638nhi2F7lZEfXfo/uzcpLJ91BS+3/UteDtl+Y/+pvXLrv3Cmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770634570; c=relaxed/simple;
	bh=P2BPamJHPtcuuWhm18+eCvTBbxttVG4dBcXZlqn5RUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbPH4Twh1O2A6a4WVF94lZ9qhBZPwPoQGaLaFPIQ4/0N8CIaStYSPmaD9QDycRVYUgyIkpTzVz1uaoNI4aMJPELhjAi+ojTZhmDFN966jUVHwlHG3ocwDQiTD1aOCSHIyvkVWJXnqS8vrpbPA5EC7SCMU3foXCV/gSg2Qpd18LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niMTIiZm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KdW7NM7L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619Aqs3D3454175
	for <linux-pm@vger.kernel.org>; Mon, 9 Feb 2026 10:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=CTaeFh7u1N5
	giG75aIskIklhdwHdZk+keGXehWBrs4w=; b=niMTIiZmP8yW3ivkvelNapt9pnu
	E5Pees/kmLX5filperJwWZYKHKFXrTUvA0f4aP1XWZ3oFy7KgDR6vbc5uEQ7TTNE
	cnpc8eyRjviITJ9fUBTyJkpTrc5mKTcEw65CdnbSWnEI5GZy/zc/DhJnZer5yn/s
	Ku4qqUuJ4UbNsUFY0//DXjuGNfQos5w+uQXHAUvpVvmLvf1gArI7fEspHwE8KzRP
	JoqN8bg94x0p8gkExMrggssh6e1jEy7fPOzZHMCFWhZRpapl/+jn0ZtFtezK/TiH
	xKaM+mbRZ2IBAGzAVWFDDZMLpp6q/ii+c63wvivdni8UKRWWVmAUDIJPeOw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e7g80a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 10:56:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35620e2faf0so1419784a91.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Feb 2026 02:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770634568; x=1771239368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTaeFh7u1N5giG75aIskIklhdwHdZk+keGXehWBrs4w=;
        b=KdW7NM7LLX5bAY4Uk/daxVGC/CWZRZXXDOfl/R7DZtXwDDBycWGdo9ZMqfQSvpBj+z
         ed1Bl3PtTBBLIwoeUioOwW2eAOwe5n0NnVzPgUesM/yTUE1Hhw1Y+0nQRkmmJZERVqYC
         gUW2TVLNW6WVgR4nAWvVWYdzE/dH8U1+3Z8V0PccACKZeYZphJmy+Zn1VI/IMnEj3K5o
         Vl1+9UPNlsRwn7N6gEYBoOQxVSfgHzrwRXfJFe8+6NFWnInOhNt0SXZHOiWDjttr9IFB
         z3juYsAK8S7YM0Phpc7nd6AtuAU0rz1Ty+eg5NCZJ9kP9kME1L9DoMupQiRCrguFA68o
         JStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770634568; x=1771239368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTaeFh7u1N5giG75aIskIklhdwHdZk+keGXehWBrs4w=;
        b=ukJQgH8hvv3p5icR76Si75BLz1lQJed7PeXnYtGausvAvvCi8Vtl/7HagDm1H5Ostu
         n0bAi+Lxshtisdjthb2q5osxUuBOxcMyP5QutiCX0/MDPEw5mO3/AB417h3B36M0v9n8
         wIeK0UnLICLCwSrBi/FJ5wdIegV6lacXJpZdDE4ZkC6YA6pPBA/djSLIwWnphddL9z0w
         lSdzmDhV5ifH8e/gaATl9W3btcjq4Wlg/fNSyX5IdwiZwixR5ImVKgoc3hCBUNOdW34B
         etDB66G3OEzi0Kofc94wQitNjydDWfVvkEWWnboY1LewZtXZ4vPtE4810ol+IV0CyRSx
         L/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv2JNtn4SaN8KJu6Sv7CXMYhf3afFVTtot/dD4ln+a0VV5o5iTX3TDzN0NXs2qwH/Yc/V+2ECLYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxPOvfOlJBNpbolMklN1AfUOxnfjbUvss88dnPkBMfdEXo40kN
	r053WBnTtxd5R6ltzQ5stFiweXHCKcNvyRhZtc9qdqg4sE/6yJRLU/dkE9axgG0wljEb3qYijLJ
	Rr/kCk+XtWb741sznFA+HBZYoCs7H2PcFdO0K/NLp4u+exe4NuTgXZeThHLglIg==
X-Gm-Gg: AZuq6aLt6Z6wd0hLhyyWLMpU4C0Q6Zo/qbww9IdarJXoSRTz9La3ddB+ZqxJBpbqmKw
	kHeMTrlzKiSB2mmt1CSjY3EOcc0pRiFkq5lQq3I8FWex0TIUyjovIjigNUKfgVtbY22RHnVOnRO
	aN2qViqzmX8z3F0Dr68m0VbufzEk5TDADxo4kChTEo1mbFcLDvDgp4plrXTAyRwGzgM7uhaK4mF
	p7bZL8Fd/x+PWVbPkF1I2gzA1++6FX2m5RJrPkHTsbP6YgMXueb7wmSurVwQDU48rLMts8e+dV1
	IgN1k1TPUkPURaAzlRs50zLsjPpzexBsIajiXzM8cTF7rrT9B5/eCAHhxJwQb/jl8Zi4/5+Tk3Q
	UO1d1JeaLTT+fkrZTsjUMBtJZ2Ltf4eCvskMKMdtX0g49
X-Received: by 2002:a05:6a20:e20d:b0:38b:d93f:b45a with SMTP id adf61e73a8af0-393ad376b08mr9888686637.58.1770634567830;
        Mon, 09 Feb 2026 02:56:07 -0800 (PST)
X-Received: by 2002:a05:6a20:e20d:b0:38b:d93f:b45a with SMTP id adf61e73a8af0-393ad376b08mr9888640637.58.1770634567110;
        Mon, 09 Feb 2026 02:56:07 -0800 (PST)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb5e5f6bsm8358837a12.20.2026.02.09.02.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 02:56:06 -0800 (PST)
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
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH V11 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC thermal monitoring
Date: Mon,  9 Feb 2026 16:24:38 +0530
Message-Id: <20260209105438.596339-5-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com>
References: <20260209105438.596339-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2xoUMSa4Axgd8jVn8K7gOGWPHDEravbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDA4OSBTYWx0ZWRfX9KohgCEuzNFT
 gG1c9w2EisZIAe1uQcdDSkQ8dDh1FvPDD4gzoFQ/3kwJlox7Nn11KqXDgAb/iyK0DJ6qHiWfLLz
 l/+y4Y7EDJTSHqZIwg6vebhkFMYeKndsgl9VZrADEK5Kg2/eB8NyNij8tHX8/5vXBf6nYNtI7+A
 TWO3nWsGRDk9rJ/l70uh2Qx1NbgJsK4gYCC+6otVcEp530QJasPq1HUQ9KGqqkR4qTuQkTJw599
 wcdEDM9mQinWORa4VburwNJ7d5H17RL3wUhhXc87jYJU/q4SXhLFnUtV7CmVKwbw9oLGv/iGMXU
 XHTC/DHb3xBTBYp6rKHQgkkFmKUUMqMtkGbfqhuxApU42mwrc2ZGbWp8ocxSDsrWyo3KKoYA6Ds
 xdyqBr6oJHaAfpeP8Jme/iNwJXIDVTqQf1ngLSIP314ZpndTbW3pMPgMyoScnYnb7KSGehdcKAV
 EVGrJJZGc2D8OAV3snw==
X-Authority-Analysis: v=2.4 cv=GMMF0+NK c=1 sm=1 tr=0 ts=6989bd49 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=hpoCfrBzasziBmgo1UAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 2xoUMSa4Axgd8jVn8K7gOGWPHDEravbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090089
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
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42351-lists,linux-pm=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jishnu.prakash@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-0.990];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 30DB210E6A6
X-Rspamd-Action: no action

Add support for ADC_TM part of PMIC5 Gen3.

This is an auxiliary driver under the Gen3 ADC driver, which implements the
threshold setting and interrupt generating functionalities of QCOM ADC_TM
drivers, used to support thermal trip points.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v10:
- Made following changes to address Jonathan's comments:
  - Replaced inclusion of device.h header file in 
    drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c with forwards declaration
    of struct device.
  - Updated all for() loops to declare and initialize the loop iterator
    inside the for() loop statement.
  - Removed two blank lines and updated dev_warn() call in adc_tm5_register_tzd()
    to dev_info().
- Collected Reviewed-by tag from Jonathan.

Changes since v9:
- Replaced the break statement within scoped_guard() in tm_handler_work() with
  return statement to fix the error reported by kernel test robot.

Changes since v8:
- Made following changes to address Dmitry's comment to use module_auxiliary_driver():
  - Dropped the wrapper struct containing the auxiliary driver (struct adc_tm5_auxiliary_drv)
    which was originally meant to expose the TM interrupt callback to be called by
    main driver and replaced it with standalone definition of the auxiliary_driver struct.
  - Added call to adc5_gen3_register_tm_event_notifier() in probe to initialize the
    TM callback for main driver.
  - Replaced the module_init() and module_exit() calls with module_auxiliary_driver().
- Made following changes to address Jonathan's comments:
  - Updated header files included in drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
    to follow IWYU (include-what-you-use) principles.
  - Added a DEFINE_GUARD() definition for mutex lock/unlock functions and replaced
    their existing calls with guard() and scoped_guard() statements using this definition.
  - Moved some variable declarations in tm_handler_work() to inside the for() loop.
  - Fixed if() check condition for low_temp in adc_tm5_gen3_set_trip_temp().
- Dropped the wrapper function adc_tm5_gen3_disable_channel() around
  _adc_tm5_gen3_disable_channel() as it only calls the inner function with no other actions.
- Replaced a pr_debug() call with dev_dbg() in tm_handler_work().

Changes since v7:
- Addressed following comments from Jonathan:
  - Replaced {0} with { } in tm_handler_work()
  - Simplified logic for setting upper_set and lower_set into
    a single line each, in tm_handler_work()
  - Cleaned up local variable declarations and high/low threshold
    check in adc_tm5_gen3_configure()
  - Moved cleanup action to disable all ADC_TM channels to probe
    end and added comment to describe it.
  - Fixed { } formatting in adctm5_auxiliary_id_table[].

Changes since v6:
- Addressed following comments from Jonathan:
  - Added error check for devm_thermal_add_hwmon_sysfs() call.
  - Used local variable `dev` in multiple places in adc_tm5_probe().
    in place of `&aux_dev->dev` and `adc_tm5->dev`.
  - Added a comment to explain cleanup action calling adc5_gen3_clear_work()
    near probe end.
  - Fixed return statement at probe end to return last called API's
    return value directly.

Changes since v5:
- Addressed following comments from Jonathan:
  - Corrected all files to follow kernel-doc formatting fully.
  - Cleaned up formatting in struct definitions.
  - Used sizeof() to specify length in register read/write calls
    instead of using integers directly.
  - Added comments in adc_tm5_probe() for skipping first SDAM for
    IRQ request and for usage of auxiliary_set_drvdata().
  - Corrected line wrap length driver file.
  - Moved INIT_WORK() and auxiliary_set_drvdata() to earlier
    locations to ensure they are ready when needed.

Changes since v4:
- Fixed a compilation error and updated dependencies in config as suggested
  by Krzysztof.

 drivers/thermal/qcom/Kconfig                  |   9 +
 drivers/thermal/qcom/Makefile                 |   1 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 507 ++++++++++++++++++
 3 files changed, 517 insertions(+)
 create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index a6bb01082ec6..1acb11e4ac80 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -21,6 +21,15 @@ config QCOM_SPMI_ADC_TM5
 	  Thermal client sets threshold temperature for both warm and cool and
 	  gets updated when a threshold is reached.
 
+config QCOM_SPMI_ADC_TM5_GEN3
+	tristate "Qualcomm SPMI PMIC Thermal Monitor ADC5 Gen3"
+	depends on QCOM_SPMI_ADC5_GEN3
+	help
+	  This enables the auxiliary thermal driver for the ADC5 Gen3 thermal
+	  monitoring device. It shows up as a thermal zone with multiple trip points.
+	  Thermal client sets threshold temperature for both warm and cool and
+	  gets updated when a threshold is reached.
+
 config QCOM_SPMI_TEMP_ALARM
 	tristate "Qualcomm SPMI PMIC Temperature Alarm"
 	depends on OF && SPMI && IIO
diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
index 0fa2512042e7..828d9e7bc797 100644
--- a/drivers/thermal/qcom/Makefile
+++ b/drivers/thermal/qcom/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
 qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
 				   tsens-8960.o
 obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
+obj-$(CONFIG_QCOM_SPMI_ADC_TM5_GEN3)	+= qcom-spmi-adc-tm5-gen3.o
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_QCOM_LMH)		+= lmh.o
diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
new file mode 100644
index 000000000000..fde9b073f482
--- /dev/null
+++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/iio/adc/qcom-adc5-gen3-common.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/thermal.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <linux/unaligned.h>
+
+#include "../thermal_hwmon.h"
+
+struct device;
+struct adc_tm5_gen3_chip;
+
+/**
+ * struct adc_tm5_gen3_channel_props - ADC_TM channel structure
+ * @timer: time period of recurring TM measurement.
+ * @tm_chan_index: TM channel number used (ranging from 1-7).
+ * @sdam_index: SDAM on which this TM channel lies.
+ * @common_props: structure with common  ADC channel properties.
+ * @high_thr_en: TM high threshold crossing detection enabled.
+ * @low_thr_en: TM low threshold crossing detection enabled.
+ * @chip: ADC TM device.
+ * @tzd: pointer to thermal device corresponding to TM channel.
+ * @last_temp: last temperature that caused threshold violation,
+ *	or a thermal TM channel.
+ * @last_temp_set: indicates if last_temp is stored.
+ */
+struct adc_tm5_gen3_channel_props {
+	unsigned int timer;
+	unsigned int tm_chan_index;
+	unsigned int sdam_index;
+	struct adc5_channel_common_prop common_props;
+	bool high_thr_en;
+	bool low_thr_en;
+	struct adc_tm5_gen3_chip *chip;
+	struct thermal_zone_device *tzd;
+	int last_temp;
+	bool last_temp_set;
+};
+
+/**
+ * struct adc_tm5_gen3_chip - ADC Thermal Monitoring device structure
+ * @dev_data: Top-level ADC device data.
+ * @chan_props: Array of ADC_TM channel structures.
+ * @nchannels: number of TM channels allocated
+ * @dev: SPMI ADC5 Gen3 device.
+ * @tm_handler_work: handler for TM interrupt for threshold violation.
+ */
+struct adc_tm5_gen3_chip {
+	struct adc5_device_data *dev_data;
+	struct adc_tm5_gen3_channel_props *chan_props;
+	unsigned int nchannels;
+	struct device *dev;
+	struct work_struct tm_handler_work;
+};
+
+DEFINE_GUARD(adc5_gen3, struct adc_tm5_gen3_chip *, adc5_gen3_mutex_lock(_T->dev),
+	     adc5_gen3_mutex_unlock(_T->dev))
+
+static int get_sdam_from_irq(struct adc_tm5_gen3_chip *adc_tm5, int irq)
+{
+	for (int i = 0; i < adc_tm5->dev_data->num_sdams; i++) {
+		if (adc_tm5->dev_data->base[i].irq == irq)
+			return i;
+	}
+	return -ENOENT;
+}
+
+static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
+	int ret, sdam_num;
+	u8 tm_status[2];
+	u8 status, val;
+
+	sdam_num = get_sdam_from_irq(adc_tm5, irq);
+	if (sdam_num < 0) {
+		dev_err(adc_tm5->dev, "adc irq %d not associated with an sdam\n",
+			irq);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
+			     &status, sizeof(status));
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc read status1 failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
+		dev_err_ratelimited(adc_tm5->dev,
+				    "Unexpected conversion fault, status:%#x\n",
+				    status);
+		val = ADC5_GEN3_CONV_ERR_CLR_REQ;
+		adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
+				       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
+		return IRQ_HANDLED;
+	}
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
+			     tm_status, sizeof(tm_status));
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	if (tm_status[0] || tm_status[1])
+		schedule_work(&adc_tm5->tm_handler_work);
+
+	dev_dbg(adc_tm5->dev, "Interrupt status:%#x, high:%#x, low:%#x\n",
+		status, tm_status[0], tm_status[1]);
+
+	return IRQ_HANDLED;
+}
+
+static int adc5_gen3_tm_status_check(struct adc_tm5_gen3_chip *adc_tm5,
+				     int sdam_index, u8 *tm_status, u8 *buf)
+{
+	int ret;
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS,
+			     tm_status, 2);
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
+		return ret;
+	}
+
+	ret = adc5_gen3_status_clear(adc_tm5->dev_data, sdam_index, ADC5_GEN3_TM_HIGH_STS_CLR,
+				     tm_status, 2);
+	if (ret) {
+		dev_err(adc_tm5->dev, "adc status clear conv_req failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, sdam_index, ADC5_GEN3_CH_DATA0(0),
+			     buf, 16);
+	if (ret)
+		dev_err(adc_tm5->dev, "adc read data failed with %d\n", ret);
+
+	return ret;
+}
+
+static void tm_handler_work(struct work_struct *work)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = container_of(work, struct adc_tm5_gen3_chip,
+							 tm_handler_work);
+	int sdam_index = -1;
+	u8 tm_status[2] = { };
+	u8 buf[16] = { };
+
+	for (int i = 0; i < adc_tm5->nchannels; i++) {
+		struct adc_tm5_gen3_channel_props *chan_prop = &adc_tm5->chan_props[i];
+		int offset = chan_prop->tm_chan_index;
+		bool upper_set, lower_set;
+		int ret, temp;
+		u16 code;
+
+		scoped_guard(adc5_gen3, adc_tm5) {
+			if (chan_prop->sdam_index != sdam_index) {
+				sdam_index = chan_prop->sdam_index;
+				ret = adc5_gen3_tm_status_check(adc_tm5, sdam_index,
+								tm_status, buf);
+				if (ret)
+					return;
+			}
+
+			upper_set = ((tm_status[0] & BIT(offset)) && chan_prop->high_thr_en);
+			lower_set = ((tm_status[1] & BIT(offset)) && chan_prop->low_thr_en);
+		}
+
+		if (!(upper_set || lower_set))
+			continue;
+
+		code = get_unaligned_le16(&buf[2 * offset]);
+		dev_dbg(adc_tm5->dev, "ADC_TM threshold code:%#x\n", code);
+
+		ret = adc5_gen3_therm_code_to_temp(adc_tm5->dev,
+						   &chan_prop->common_props,
+						   code, &temp);
+		if (ret) {
+			dev_err(adc_tm5->dev,
+				"Invalid temperature reading, ret = %d, code=%#x\n",
+				ret, code);
+			continue;
+		}
+
+		chan_prop->last_temp = temp;
+		chan_prop->last_temp_set = true;
+		thermal_zone_device_update(chan_prop->tzd, THERMAL_TRIP_VIOLATED);
+	}
+}
+
+static int adc_tm5_gen3_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
+	struct adc_tm5_gen3_chip *adc_tm5;
+
+	if (!prop || !prop->chip)
+		return -EINVAL;
+
+	adc_tm5 = prop->chip;
+
+	if (prop->last_temp_set) {
+		pr_debug("last_temp: %d\n", prop->last_temp);
+		prop->last_temp_set = false;
+		*temp = prop->last_temp;
+		return 0;
+	}
+
+	return adc5_gen3_get_scaled_reading(adc_tm5->dev, &prop->common_props,
+					    temp);
+}
+
+static int adc_tm5_gen3_disable_channel(struct adc_tm5_gen3_channel_props *prop)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
+	int ret;
+	u8 val;
+
+	prop->high_thr_en = false;
+	prop->low_thr_en = false;
+
+	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
+	if (ret)
+		return ret;
+
+	val = BIT(prop->tm_chan_index);
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			      ADC5_GEN3_TM_HIGH_STS_CLR, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	val = MEAS_INT_DISABLE;
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			      ADC5_GEN3_TIMER_SEL, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	/* To indicate there is an actual conversion request */
+	val = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			      ADC5_GEN3_PERPH_CH, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	val = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			       ADC5_GEN3_CONV_REQ, &val, sizeof(val));
+}
+
+#define ADC_TM5_GEN3_CONFIG_REGS 12
+
+static int adc_tm5_gen3_configure(struct adc_tm5_gen3_channel_props *prop,
+				  int low_temp, int high_temp)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = prop->chip;
+	u8 buf[ADC_TM5_GEN3_CONFIG_REGS];
+	u8 conv_req;
+	u16 adc_code;
+	int ret;
+
+	ret = adc5_gen3_poll_wait_hs(adc_tm5->dev_data, prop->sdam_index);
+	if (ret < 0)
+		return ret;
+
+	ret = adc5_gen3_read(adc_tm5->dev_data, prop->sdam_index,
+			     ADC5_GEN3_SID, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	/* Write SID */
+	buf[0] = FIELD_PREP(ADC5_GEN3_SID_MASK, prop->common_props.sid);
+
+	/* Select TM channel and indicate there is an actual conversion request */
+	buf[1] = ADC5_GEN3_CHAN_CONV_REQ | prop->tm_chan_index;
+
+	buf[2] = prop->timer;
+
+	/* Digital param selection */
+	adc5_gen3_update_dig_param(&prop->common_props, &buf[3]);
+
+	/* Update fast average sample value */
+	buf[4] &= ~ADC5_GEN3_FAST_AVG_CTL_SAMPLES_MASK;
+	buf[4] |= prop->common_props.avg_samples | ADC5_GEN3_FAST_AVG_CTL_EN;
+
+	/* Select ADC channel */
+	buf[5] = prop->common_props.channel;
+
+	/* Select HW settle delay for channel */
+	buf[6] = FIELD_PREP(ADC5_GEN3_HW_SETTLE_DELAY_MASK,
+			    prop->common_props.hw_settle_time_us);
+
+	/* High temperature corresponds to low voltage threshold */
+	prop->low_thr_en = (high_temp != INT_MAX);
+	if (prop->low_thr_en) {
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(high_temp);
+		put_unaligned_le16(adc_code, &buf[8]);
+	}
+
+	/* Low temperature corresponds to high voltage threshold */
+	prop->high_thr_en = (low_temp != -INT_MAX);
+	if (prop->high_thr_en) {
+		adc_code = qcom_adc_tm5_gen2_temp_res_scale(low_temp);
+		put_unaligned_le16(adc_code, &buf[10]);
+	}
+
+	buf[7] = 0;
+	if (prop->high_thr_en)
+		buf[7] |= ADC5_GEN3_HIGH_THR_INT_EN;
+	if (prop->low_thr_en)
+		buf[7] |= ADC5_GEN3_LOW_THR_INT_EN;
+
+	ret = adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index, ADC5_GEN3_SID,
+			      buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	conv_req = ADC5_GEN3_CONV_REQ_REQ;
+	return adc5_gen3_write(adc_tm5->dev_data, prop->sdam_index,
+			       ADC5_GEN3_CONV_REQ, &conv_req, sizeof(conv_req));
+}
+
+static int adc_tm5_gen3_set_trip_temp(struct thermal_zone_device *tz,
+				      int low_temp, int high_temp)
+{
+	struct adc_tm5_gen3_channel_props *prop = thermal_zone_device_priv(tz);
+	struct adc_tm5_gen3_chip *adc_tm5;
+
+	if (!prop || !prop->chip)
+		return -EINVAL;
+
+	adc_tm5 = prop->chip;
+
+	dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
+		prop->common_props.label, low_temp, high_temp);
+
+	guard(adc5_gen3)(adc_tm5);
+	if (high_temp == INT_MAX && low_temp == -INT_MAX)
+		return adc_tm5_gen3_disable_channel(prop);
+
+	return adc_tm5_gen3_configure(prop, low_temp, high_temp);
+}
+
+static const struct thermal_zone_device_ops adc_tm_ops = {
+	.get_temp = adc_tm5_gen3_get_temp,
+	.set_trips = adc_tm5_gen3_set_trip_temp,
+};
+
+static int adc_tm5_register_tzd(struct adc_tm5_gen3_chip *adc_tm5)
+{
+	struct thermal_zone_device *tzd;
+	unsigned int channel;
+	int ret;
+
+	for (int i = 0; i < adc_tm5->nchannels; i++) {
+		channel = ADC5_GEN3_V_CHAN(adc_tm5->chan_props[i].common_props);
+		tzd = devm_thermal_of_zone_register(adc_tm5->dev, channel,
+						    &adc_tm5->chan_props[i],
+						    &adc_tm_ops);
+		if (IS_ERR(tzd)) {
+			if (PTR_ERR(tzd) == -ENODEV) {
+				dev_info(adc_tm5->dev,
+					 "thermal sensor on channel %d is not used\n",
+					 channel);
+				continue;
+			}
+			return dev_err_probe(adc_tm5->dev, PTR_ERR(tzd),
+					     "Error registering TZ zone:%ld for channel:%d\n",
+					     PTR_ERR(tzd), channel);
+		}
+		adc_tm5->chan_props[i].tzd = tzd;
+		ret = devm_thermal_add_hwmon_sysfs(adc_tm5->dev, tzd);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static void adc5_gen3_clear_work(void *data)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = data;
+
+	cancel_work_sync(&adc_tm5->tm_handler_work);
+}
+
+static void adc5_gen3_disable(void *data)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = data;
+
+	guard(adc5_gen3)(adc_tm5);
+	/* Disable all available TM channels */
+	for (int i = 0; i < adc_tm5->nchannels; i++)
+		adc_tm5_gen3_disable_channel(&adc_tm5->chan_props[i]);
+}
+
+static void adctm_event_handler(struct auxiliary_device *adev)
+{
+	struct adc_tm5_gen3_chip *adc_tm5 = auxiliary_get_drvdata(adev);
+
+	schedule_work(&adc_tm5->tm_handler_work);
+}
+
+static int adc_tm5_probe(struct auxiliary_device *aux_dev,
+			 const struct auxiliary_device_id *id)
+{
+	struct adc_tm5_gen3_chip *adc_tm5;
+	struct tm5_aux_dev_wrapper *aux_dev_wrapper;
+	struct device *dev = &aux_dev->dev;
+	int ret;
+
+	adc_tm5 = devm_kzalloc(dev, sizeof(*adc_tm5), GFP_KERNEL);
+	if (!adc_tm5)
+		return -ENOMEM;
+
+	aux_dev_wrapper = container_of(aux_dev, struct tm5_aux_dev_wrapper,
+				       aux_dev);
+
+	adc_tm5->dev = dev;
+	adc_tm5->dev_data = aux_dev_wrapper->dev_data;
+	adc_tm5->nchannels = aux_dev_wrapper->n_tm_channels;
+	adc_tm5->chan_props = devm_kcalloc(dev, aux_dev_wrapper->n_tm_channels,
+					   sizeof(*adc_tm5->chan_props), GFP_KERNEL);
+	if (!adc_tm5->chan_props)
+		return -ENOMEM;
+
+	for (int i = 0; i < adc_tm5->nchannels; i++) {
+		adc_tm5->chan_props[i].common_props = aux_dev_wrapper->tm_props[i];
+		adc_tm5->chan_props[i].timer = MEAS_INT_1S;
+		adc_tm5->chan_props[i].sdam_index = (i + 1) / 8;
+		adc_tm5->chan_props[i].tm_chan_index = (i + 1) % 8;
+		adc_tm5->chan_props[i].chip = adc_tm5;
+	}
+
+	INIT_WORK(&adc_tm5->tm_handler_work, tm_handler_work);
+
+	/*
+	 * Skipping first SDAM IRQ as it is requested in parent driver.
+	 * If there is a TM violation on that IRQ, the parent driver calls
+	 * the notifier (adctm_event_handler) exposed from this driver to handle it.
+	 */
+	for (int i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
+		ret = devm_request_threaded_irq(dev,
+						adc_tm5->dev_data->base[i].irq,
+						NULL, adctm5_gen3_isr, IRQF_ONESHOT,
+						adc_tm5->dev_data->base[i].irq_name,
+						adc_tm5);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * This drvdata is only used in the function (adctm_event_handler)
+	 * called by parent ADC driver in case of TM violation on the first SDAM.
+	 */
+	auxiliary_set_drvdata(aux_dev, adc_tm5);
+
+	adc5_gen3_register_tm_event_notifier(dev, adctm_event_handler);
+
+	/*
+	 * This is to cancel any instances of tm_handler_work scheduled by
+	 * TM interrupt, at the time of module removal.
+	 */
+	ret = devm_add_action(dev, adc5_gen3_clear_work, adc_tm5);
+	if (ret)
+		return ret;
+
+	ret = adc_tm5_register_tzd(adc_tm5);
+	if (ret)
+		return ret;
+
+	/* This is to disable all ADC_TM channels in case of probe failure. */
+
+	return devm_add_action(dev, adc5_gen3_disable, adc_tm5);
+}
+
+static const struct auxiliary_device_id adctm5_auxiliary_id_table[] = {
+	{ .name = "qcom_spmi_adc5_gen3.adc5_tm_gen3", },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(auxiliary, adctm5_auxiliary_id_table);
+
+static struct auxiliary_driver adctm5gen3_auxiliary_driver = {
+	.id_table = adctm5_auxiliary_id_table,
+	.probe = adc_tm5_probe,
+};
+
+module_auxiliary_driver(adctm5gen3_auxiliary_driver);
+
+MODULE_DESCRIPTION("SPMI PMIC Thermal Monitor ADC driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("QCOM_SPMI_ADC5_GEN3");
-- 
2.25.1


