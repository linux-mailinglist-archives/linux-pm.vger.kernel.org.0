Return-Path: <linux-pm+bounces-43593-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FCLDcB3qGnpugAAu9opvQ
	(envelope-from <linux-pm+bounces-43593-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:19:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4752062AE
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B5AC3168DA9
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CC43DFC73;
	Wed,  4 Mar 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BLBRchu4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8TlKbHK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFDC3DFC62
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647427; cv=none; b=iun4t7IFK89wwpm8QjU/c7mPr0/khCkzB4vaK0Q7HSCbWXiJBwpnsA0fMwSyP/3yjKpCKwjAP6wToRCkzJdQkEy9VQPCVqQNPxt72CQU7jjrne5hyCwuzjwe8pcJlzcuo6Lvl4Ynq3SurNw6O4Idy0AXWcix/BU/hMBCSFEVNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647427; c=relaxed/simple;
	bh=8KcQuYEpP24a6WBCDAg2F+ny1MptqZFFDATDZNiqhrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyAYXkwKK3jxONFn3nzqa6WAGucFP4pmBJeTCKwLoi+NK2HLc+mHH1F8HRpFbAN8YDCcY4OkP8JXgbWsjzpw5WWjAMQdCKaUqAX2YpNihl4YU2SEoiMlIHiMdF5203YpIiY0BVI3a+5zinINfPb147fFg75OeqoLl9OXX93tDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BLBRchu4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h8TlKbHK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HI6UF2613894
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5leCT/obbHTfFTbu8A2pbgBO1nV7mxacWx4r8X8VVnA=; b=BLBRchu49Q7lOaah
	r2rUqDTXtYnhAoypPmnBKbLt9v0/T9mDZmB7OCm4b8m7HhnNJLpUbQtqiFjcL9lf
	FicUQSKttndKvp6osG61QMRJJ2Dx3jwiXoiH4cghUJAKQCXUilS0Rm3CYgYfTD+J
	2iWghoxgzijDG2rXxaJHtfEPQb9dV7tzF67M93oQnAGzsxxLOJKgPaYrbw6aqxzv
	x5rV5NXJSCRT4tW7vKpe2HYGFCyUR5z5fE5PbpSqq6AHdVap2NOyWVraFYpmwlqR
	4LuUIFBYRlewridfWbROb3cQO+F85OlwjIbrh9eoN8x/DSa2x0cAeam0+FQEMHrk
	9EQr1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0w84jx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:03:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35641c14663so7424930a91.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647425; x=1773252225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5leCT/obbHTfFTbu8A2pbgBO1nV7mxacWx4r8X8VVnA=;
        b=h8TlKbHKt4CvxKV5ERtbBXfQ4EUErGLkPouieN42dl5qa26PIrfCtSLVfUDC0Y+o0u
         ex6Ag27Fa2kRddmB8Qcrl5u7Lo+rPzsEHSmmrFlRc4c3rm4G6aVkFHsTamstKGcNOfXw
         dyBMROye0Xa7n0s0aIv8DwQ+jxCFgGwPxZmixI6qXBR6mhHlNHJ/PCBMOsWsso4xqBu2
         PzS1ywI6htfY9+zxUJnaL+rBh7GMEXXn4e8FI6dtiEoJjQTF8g6gesrZkM4BVhpvrR0U
         gR2h68tGJSUnmiqbY54azF6fSETGraqtnRRXoxKTbRGZPjCmU1QrpExs0PWAUlEBjVeA
         sOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647425; x=1773252225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5leCT/obbHTfFTbu8A2pbgBO1nV7mxacWx4r8X8VVnA=;
        b=MGU4jd6vtaUGbJuvwu+nHIfM3/87kXvOEQpe4QgySEVCj4jkiMGpEgaC9YTt2z5dFn
         M+SKbcII+vK6/pjPqgT0tyrSkaIPs6W07Mxw1f9kmyfSufEiaHTw7lTJlpywEWO1uSCt
         4bjIJClNjl0VsaRKNQRRB7m8BTM+tTs5XwPoATtoHG3konu7Z54XyTOM1nL/22P4XvLp
         uVscXUU/2OGuXHndcBP34AY5GOTJUHm4bDD8obDFY5M59kN6/vOvr0hJjfEkLyf/RaEe
         OIhNtx8bGS2hoMpg9AptS1U+7BszDQXf1rHkYJzS0NbCLbbHUJroi2njD4HrzN6hJ1XI
         QxLA==
X-Forwarded-Encrypted: i=1; AJvYcCXjmq5u50ENG5rP+Gi3J/W4BawjEO+UWYpwDo8mj9jUMqNvSaETv+3kkor0gzdOyPRjCbCAI3RsDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4FAclzETDR3SWgrq7YaOyPeYN/phkXCWth5h6A1LqRFSaJWC
	Mw4mr0m4TbBNEYkYEXqGqF1FiAZiP7t/of9JXx6tDApULnIUG6YsYq5OwS+Kj5CKOy8nn6LWXCM
	UtCeRX+pHx9mL6vCuNoPEZE5CzUS+WAZxqnBH7j901IMAEDLx4AOMQe3MwEo+rvq9wQyfow==
X-Gm-Gg: ATEYQzxlyjC/SuuNW+uaT3wPnDZK/wn9LX6jQjI9u+JP9RV/EVwmvVWnE4mbcaUcghG
	1Y+97ABNQZpedmEfDtns+IhmQVCs13gHRPtjZkO8fXL5J9XDuO1bme6AQrCcrPVmkXnzQbIUaGj
	j14Zqr2cTrv+Fa7NFsuyzkTkbS47LjAjFGS2r5U96x9VD8K8JmAZ81eWUWQGi/5kRoiTtdbeXW3
	27MbOxsfQETizTA2iUg4oJaGTpgvS3Rqrj6UaCqWTsB6IaUj3ipKgu7J7PJsYg+jhcMg2EJ4VHM
	u/Ix1E8rtRE/58PSH3H787IPfUQ3vxvrGLbRR1VJN+LqpAKyOKm6TeftF5+xHdRG8jInpb6oVAf
	Zi6TVTfVIYJt/46xIZtV3XVhGWT13BoBLBEvbfWFhXOCTdpaptUZomz6tXQ==
X-Received: by 2002:a17:90b:3fc8:b0:359:dd9:3de5 with SMTP id 98e67ed59e1d1-359a69ae7e7mr2522696a91.4.1772647424477;
        Wed, 04 Mar 2026 10:03:44 -0800 (PST)
X-Received: by 2002:a17:90b:3fc8:b0:359:dd9:3de5 with SMTP id 98e67ed59e1d1-359a69ae7e7mr2522654a91.4.1772647423957;
        Wed, 04 Mar 2026 10:03:43 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:03:43 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:02 +0530
Subject: [PATCH v20 02/10] power: reset: reboot-mode: Add support for 64
 bit magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-2-cf7d346b8372@oss.qualcomm.com>
References: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
In-Reply-To: <20260304-arm-psci-system_reset2-vendor-reboots-v20-0-cf7d346b8372@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=7396;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=8KcQuYEpP24a6WBCDAg2F+ny1MptqZFFDATDZNiqhrY=;
 b=Quxdo+gN7haqmu+eDMts1IZ0ljKit/vaTkr3wMfpYRhp8casQAkwwj1uz2maGX4edprwxn4sU
 2UFOUZ+rj+vAzN33bwNlxHfyCrttyCETbo6UYJ3f3OZB75WXP7ppGpb
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: GZy4fUzyTYKkxoNpzmqmLchXfFX-zrr7
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a87401 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=MO_J9Aa4ypbE8kPWTcIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfXx6yI0awdvO7Y
 +HQnX3cZJZsNsod9zIZGMOl9fQ42ELDj2AihMgLVnUEdU/NJDmvCdqMPY5zBZt/V+xaRI5PyACy
 O40PWCNMVrqbqkziRUrGHmNfE1HRuPO8pa5qGFe5icfXXOUj04rzK2FZZM+mnKwkkMgy5a3/WUr
 Go/4/UhkBogNuAGRKNjlkyZ/Rd95dr9q2Wug/wSKzD8wAVGqaFgx5pjLM3DLDTK4PIozJggGjTO
 ZyQdvjLXTE8pZJE7OdnkKGkEFwYlrAEMkPZdBLVA4MpQHNloQVdGZ9v+T0okEJLWB53XplHmf64
 v/uvdRqKhtKW4yO3slwbkePcGdUPCvBOMw2mFoFvvc3ap+LJ3SyJOjVhyhGmzuIpXmq6+cKbNRp
 FirRmdFLLIExvekZK6Q8yzSFPw9olmF+jabSHYj7OT22ddeAtvZwMquDZ9vnrgxF0CYz0vg+GzD
 x+585z+iZIAVMJnfa6g==
X-Proofpoint-ORIG-GUID: GZy4fUzyTYKkxoNpzmqmLchXfFX-zrr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: AB4752062AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43593-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Current reboot-mode supports a single 32-bit argument for any
supported mode. Some reboot-mode based drivers may require
passing two independent 32-bit arguments during a reboot
sequence, for uses-cases, where a mode requires an additional
argument. Such drivers may not be able to use the reboot-mode
driver. For example, ARM PSCI vendor-specific resets, need two
arguments for its operation – reset_type and cookie, to complete
the reset operation. If a driver wants to implement this
firmware-based reset, it cannot use reboot-mode framework.

Introduce 64-bit magic values in reboot-mode driver to
accommodate up-to two 32-bit arguments in below format.
|    Higher 32 bit  |   Lower 32 bit    |
|	 arg2	    | 	    arg1	|

Update current reboot-mode drivers for 64-bit magic.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/power/reset/nvmem-reboot-mode.c  |  8 ++++----
 drivers/power/reset/qcom-pon.c           |  6 +++---
 drivers/power/reset/reboot-mode.c        | 16 +++++++++-------
 drivers/power/reset/syscon-reboot-mode.c |  6 +++---
 include/linux/reboot-mode.h              | 15 ++++++++++++++-
 5 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
index d260715fccf67f9f072bb56c5defbf885750650e..bd05d660490c686b43134f82f1eadd7665403d20 100644
--- a/drivers/power/reset/nvmem-reboot-mode.c
+++ b/drivers/power/reset/nvmem-reboot-mode.c
@@ -17,10 +17,10 @@ struct nvmem_reboot_mode {
 	struct nvmem_cell *cell;
 };
 
-static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct nvmem_reboot_mode *nvmem_rbm;
+	u32 magic_arg1 = REBOOT_MODE_ARG1(magic);
 	size_t buf_len;
 	void *buf;
 	int ret;
@@ -32,10 +32,10 @@ static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
 		return PTR_ERR(buf);
 	kfree(buf);
 
-	if (buf_len > sizeof(magic))
+	if (buf_len > sizeof(magic_arg1))
 		return -EINVAL;
 
-	ret = nvmem_cell_write(nvmem_rbm->cell, &magic, buf_len);
+	ret = nvmem_cell_write(nvmem_rbm->cell, &magic_arg1, buf_len);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582e8243c5c806bd4a793646b87189f..57b36e6186f80aff947fd7f5aae5ce280c65dc6b 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -27,17 +27,17 @@ struct qcom_pon {
 	long reason_shift;
 };
 
-static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct qcom_pon *pon = container_of
 			(reboot, struct qcom_pon, reboot_mode);
+	u32 magic_arg1 = REBOOT_MODE_ARG1(magic);
 	int ret;
 
 	ret = regmap_update_bits(pon->regmap,
 				 pon->baseaddr + PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
-				 magic << pon->reason_shift);
+				 magic_arg1 << pon->reason_shift);
 	if (ret < 0)
 		dev_err(pon->dev, "update reboot mode bits failed\n");
 
diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index d033043f5250a4de152a7786ef37e88a0ace3bbb..f5ab6eab210bcd9670441a4d2a301d9efdf2f322 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -19,12 +19,11 @@
 
 struct mode_info {
 	const char *mode;
-	u32 magic;
+	u64 magic;
 	struct list_head list;
 };
 
-static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
-					  const char *cmd)
+static u64 get_reboot_mode_magic(struct reboot_mode_driver *reboot, const char *cmd)
 {
 	const char *normal = "normal";
 	struct mode_info *info;
@@ -56,7 +55,7 @@ static int reboot_mode_notify(struct notifier_block *this,
 			      unsigned long mode, void *cmd)
 {
 	struct reboot_mode_driver *reboot;
-	unsigned int magic;
+	u64 magic;
 
 	reboot = container_of(this, struct reboot_mode_driver, reboot_notifier);
 	magic = get_reboot_mode_magic(reboot, cmd);
@@ -78,7 +77,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 	struct property *prop;
 	struct device_node *np = reboot->dev->of_node;
 	size_t len = strlen(PREFIX);
-	u32 magic;
+	u32 magic[2] = {0};
 	int ret;
 
 	INIT_LIST_HEAD(&reboot->head);
@@ -87,7 +86,10 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 		if (strncmp(prop->name, PREFIX, len))
 			continue;
 
-		if (device_property_read_u32(reboot->dev, prop->name, &magic)) {
+		size_t count = device_property_count_u32(reboot->dev, prop->name);
+
+		if (!count || count > ARRAY_SIZE(magic) ||
+		    device_property_read_u32_array(reboot->dev, prop->name, magic, count)) {
 			pr_debug("reboot mode %s without magic number\n", prop->name);
 			continue;
 		}
@@ -98,7 +100,7 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
 			goto error;
 		}
 
-		info->magic = magic;
+		info->magic = REBOOT_MODE_MAGIC(magic[0], magic[1]);
 		info->mode = kstrdup_const(prop->name + len, GFP_KERNEL);
 		if (!info->mode) {
 			ret =  -ENOMEM;
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset/syscon-reboot-mode.c
index e0772c9f70f7a19cd8ec8a0b7fdbbaa7ba44afd0..9f4b18c5e46f6a8bf197773ceceb80b250f57541 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -20,16 +20,16 @@ struct syscon_reboot_mode {
 	u32 mask;
 };
 
-static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot,
-				    unsigned int magic)
+static int syscon_reboot_mode_write(struct reboot_mode_driver *reboot, u64 magic)
 {
 	struct syscon_reboot_mode *syscon_rbm;
+	u32 magic_arg1 = REBOOT_MODE_ARG1(magic);
 	int ret;
 
 	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
 
 	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
-				 syscon_rbm->mask, magic);
+				 syscon_rbm->mask, magic_arg1);
 	if (ret < 0)
 		dev_err(reboot->dev, "update reboot mode bits failed\n");
 
diff --git a/include/linux/reboot-mode.h b/include/linux/reboot-mode.h
index 4a2abb38d1d612ec0fdf05eb18c98b210f631b7f..2ce189fdfff4b396d7cc6f175b30016781ae4fe9 100644
--- a/include/linux/reboot-mode.h
+++ b/include/linux/reboot-mode.h
@@ -2,10 +2,23 @@
 #ifndef __REBOOT_MODE_H__
 #define __REBOOT_MODE_H__
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/* Construct 64-bit reboot magic: arg2 in upper 32 bits, arg1 in lower 32 */
+#define REBOOT_MODE_MAGIC(arg1, arg2) \
+	(FIELD_PREP(GENMASK_ULL(31, 0), (arg1)) | \
+	 FIELD_PREP(GENMASK_ULL(63, 32), (arg2)))
+/* Get 32 bit arg1 from 64 bit magic */
+#define REBOOT_MODE_ARG1(magic) FIELD_GET(GENMASK_ULL(31, 0), magic)
+/* Get 32 bit arg2 from 64 bit magic */
+#define REBOOT_MODE_ARG2(magic) FIELD_GET(GENMASK_ULL(63, 32), magic)
+
 struct reboot_mode_driver {
 	struct device *dev;
 	struct list_head head;
-	int (*write)(struct reboot_mode_driver *reboot, unsigned int magic);
+	int (*write)(struct reboot_mode_driver *reboot, u64 magic);
 	struct notifier_block reboot_notifier;
 };
 

-- 
2.34.1


