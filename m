Return-Path: <linux-pm+bounces-43595-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNnKOGJ2qGnxugAAu9opvQ
	(envelope-from <linux-pm+bounces-43595-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:13:54 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 462AB205FB6
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952DE31FABE3
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3123E120F;
	Wed,  4 Mar 2026 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocSBfwS7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e80AEgbj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CDC3E1202
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647443; cv=none; b=AOwAWp6tVXrILbTeZVGpAVCxPGCDS6rwTqKQR1YPdFQ5lP+8SyauO+yX9pTNwRGxUbi6WBy7dz8zdish9KAWonZEFa/qZtyGR/dn1tNd1o3Fl59ko9tVmA0KSEyLLklXLDxhJs43X5d/mcmukNgWHxeBAneOnUWpPz4dhodJvT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647443; c=relaxed/simple;
	bh=AmJ/4s4g3aYrMbA4gYXXe4kt530xNpdozBMOFvrv/ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKEjooRpxw4R6lnD0U23XS/bFqwqQw7pN3otRNGXyn1WLrB7Qk+ODg9HafxaQ80FPNOOqnBU09SRTQ0Pm89uV2rCcQDyw71rpor9Ewocb9S1nmUKFn5NgyG/UczoLaw7H7PqQ96bRjfCR+p65QOP5AfJ5TjZLWnK0szimkk/nNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocSBfwS7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e80AEgbj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624E0bNs029448
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6K2GYPaT0CXFc6s+49BofuLoHb7MJAM3YjniV/PTVb8=; b=ocSBfwS7W/Cqi/ue
	ZKO60KY+TP+VXwxHOycgTe49YR91RvnTVgtJIm5D2HRSguOBT3tG665Jbaicvk9y
	ROgzKVtPamxVB6dT66ls626XYV/icTNUpXk+Au+E8BmQshznRl5b+3ljI2NxU+DC
	BwepL6Y5b+daHg7u+CyeempgDqkX2lEfulkHaVMwgETG0MZot7HtIFaikaqTbxjV
	0/LtASQp3Dm6R3PvHjtOzvPSU2NoD1ReT2K1UgHbYYqQazU8IUoP4Ty+b6LfqyEY
	xt2Jpw0jDQSjztCZibEHmOLrTjt6hvYAu4UYgK/BTdy/ecj8UEtiYFh0TDtPQlTs
	kJMFVQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpp4fgv2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:04:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso5953147a91.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647441; x=1773252241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6K2GYPaT0CXFc6s+49BofuLoHb7MJAM3YjniV/PTVb8=;
        b=e80AEgbjvL9UHPUi8L9oM0mxI7MUQIenA2c/uC14U3DvbmIbV3FVAv731WdhzmURcK
         zwetes0tspmaq4CPlSSZUua2gja8yVYJbgct8DR/O2bRUG9UvUqIcK84GEXJWcqNgP50
         gRdHpCFnW/qpbaukHtw051m7wMwnAASaWgsIhcD0oUfEZo/afWcR0/p/cG+FY/UKIw++
         dLQxUiE/dKDUksQWiwkObM0YCHFnSLVlDvhZvum0hWYcfmbK+Mz6mo3QBNYif0Jt/S7w
         ULoCx2TDHmP6I8vcsOrPHYPxNCInIOYNltuOxs7FIapYEmFncGJdXBa76NvZD7uDy5tX
         sTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647441; x=1773252241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6K2GYPaT0CXFc6s+49BofuLoHb7MJAM3YjniV/PTVb8=;
        b=jJ2jV0dHqISdjFNq5wRuCF+wOa1HJWghk0kKJAEpfETLMr7zOEfUQPL1TlrqbUI/nx
         OAyVHNIIDGoXn9Z0ytdb/lYtA8bG66tK/XRyN6TJxDrhlnRqKNVUTQswVKQl+fXgh3Ln
         Ry30HZre//iYWjCB62lFsQeok+tgunJq/lEVT91Mxk4rhs+iotS3nPOI7peZOfBw/f9C
         b/+WbJgV5fTbk5hIKp3OcznJGFuQTjnMe1LAkRA6iVnDT1VxXg8WXNFMPUQuQdFq9UxF
         MIa7HUbD6WyDoAVDJvqNLTD42t8RevezmSK4kRfvpAyoOGpE1U4rm1c75iOLaWzkQLSf
         ugCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkWMXaJu7TKobdJgJQcyaa7BCFiUlVPcVKW8zAUjMh+nfMg6875wfPLcRxBiX1ewV117RW/7psJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiCT5t41s8YOqztwqdQPTDsGEuoe6bO4iABE9PCU/sRWa6bQv
	nQ7O7tyMFVVx3Ja+VIqespC9VwZe1v1RD7aKqf1CY71MzCGHELqQvxYW3kxWHqXCiAZCiiMWWnh
	SjLcLo5O3ucdrT0iKKM9LFwzWbNFMjvdUSRM9qrtxVfncadM4yZxpZljggX9nRfQ0e0YZQw==
X-Gm-Gg: ATEYQzxYjDE6SEMQZL81kvxgdIi+wp5TL0p/4rOGfo78JCVyHG8rBHmYamK7seG3DAR
	l/LUuweUHoRBRsMRNQWMXr4tRP8+Ekj7KNDsuwDO8Z4A7bRel6FVO3RCVDztV5jUTFhfcvT0z54
	mpQe8om0l/e7ciPUghsMvu0AH8JOCIr8wQL8Lsm/xVMXya1R3EZVHG/iPP+6TzssgNNxitJrNC/
	wAMeocRyyD398VoGtqolmxid3aeNzxNGj6yEXxM/SeScSgzWGP/FsIWTvnE4/J2ZOBEMyc55Q4w
	sVEl/vyNho+SvccEhDeGtOvVx2QbwZ/M0seDC9HRKtd5nYe/kRePBmnv+hyIyHyrOjvsHzgF1oh
	di6uKdJwSjuviszRKq7EyYcGSRt0pQ0sT69YN0NSgLEeQm1IbIOINQWSiMQ==
X-Received: by 2002:a17:90a:c2cc:b0:34c:35ce:3c5f with SMTP id 98e67ed59e1d1-359a69a2776mr2352355a91.5.1772647441151;
        Wed, 04 Mar 2026 10:04:01 -0800 (PST)
X-Received: by 2002:a17:90a:c2cc:b0:34c:35ce:3c5f with SMTP id 98e67ed59e1d1-359a69a2776mr2352313a91.5.1772647440632;
        Wed, 04 Mar 2026 10:04:00 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:04:00 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:04 +0530
Subject: [PATCH v20 04/10] firmware: psci: Introduce command-based reset in
 psci_sys_reset
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-4-cf7d346b8372@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=4337;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=AmJ/4s4g3aYrMbA4gYXXe4kt530xNpdozBMOFvrv/ik=;
 b=PjZRL0pismwX2J7LSY8RYJf4oRN9Cgr6rxdBO9Kub43Gke8+/H2QuB/RnbSvXRgPxUMIJ1JCK
 g0qm1UeINtEBiRYrjScfhqXYtH4z8Of/X/mu89uj6JPBnVbU+Byt2jf
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: nVZkIY0CagknW64hs33dr5Vct5i6zjOe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfX9lB9TLjs2PPX
 +DMle4YgOc2hnrMU2yRlJBw1A8J3wfhNQt5hMYWFdqhvjifD5fK5e817xPsbt0IIhCYgSEX4gSA
 ni7jd2nRFCmal+ERImTCyxVcgUv+Zs53dCkzAzP5MF6FAd2/vynQCRAQx3KdbIQI0FEim12agu2
 IlVxz9I3CjBmCUzIfGa1NxaPowkZwrBHoNoDgd2DuChhTiJFppixoget8A90LVeLLIIWOmkoXkP
 i2gXEEdM30ASNwrOTeOquSiFePcXSQZtSHPpO+3k1E61XIayvqCTfO2pSYOHXKcq0XEFE4ZOGxu
 T9V2vyI5NkIcC7OcKdb4CQQ3Y/JzGO8uHdN9c/MVldgAj9dEJSME/Y0kEHxMH9IOwWueRI9hUmb
 CFXNrxg38ypqilEHzowlnVmFDzIdjCTeRwKFvQlVrakyUfmEJoS208eBENtf+C/i9hs8pAlQ0xE
 ILs0oYi/GbGV50i/M0Q==
X-Authority-Analysis: v=2.4 cv=CdMFJbrl c=1 sm=1 tr=0 ts=69a87412 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=eczEI0HPkUfQIoTEgvMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: nVZkIY0CagknW64hs33dr5Vct5i6zjOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040147
X-Rspamd-Queue-Id: 462AB205FB6
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
	TAGGED_FROM(0.00)[bounces-43595-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
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

PSCI currently supports only COLD reset and ARCH WARM reset based on the
Linux reboot_mode variable. The PSCI specification now includes
SYSTEM_RESET2 for vendor-specific resets, but there's no mechanism to
issue these through psci_sys_reset.

Add a command-based reset mechanism that allows external drivers to set
the psci reset command via a new psci_set_reset_cmd() function.

The psci command-based reset is disabled by default and the
psci_sys_reset follows its original flow until a psci_reset command is
set. In kernel panic path, psci_reset command is ignored.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 drivers/firmware/psci/psci.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/psci.h         |  2 ++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38ca190d4a22d6e7e0f06420e8478a2b0ec2fe6f..ae6f7a0aead913d740070080d4b2a3da15b29485 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -51,6 +51,15 @@ static int resident_cpu = -1;
 struct psci_operations psci_ops;
 static enum arm_smccc_conduit psci_conduit = SMCCC_CONDUIT_NONE;
 
+struct psci_sys_reset_params {
+	u32 system_reset;
+	u32 reset_type;
+	u32 cookie;
+	bool cmd;
+};
+
+static struct psci_sys_reset_params psci_reset;
+
 bool psci_tos_resident_on(int cpu)
 {
 	return cpu == resident_cpu;
@@ -80,6 +89,28 @@ static u32 psci_cpu_suspend_feature;
 static bool psci_system_reset2_supported;
 static bool psci_system_off2_hibernate_supported;
 
+/**
+ * psci_set_reset_cmd - Sets the psci_reset_cmd for command-based
+ * reset which will be used in psci_sys_reset call.
+ *
+ * @cmd_sys_rst2: Set to true for SYSTEM_RESET2 based resets.
+ * @cmd_reset_type: Set the reset_type argument for psci_sys_reset.
+ * @cmd_cookie: Set the cookie argument for psci_sys_reset.
+ */
+void psci_set_reset_cmd(bool cmd_sys_rst2, u32 cmd_reset_type, u32 cmd_cookie)
+{
+	if (cmd_sys_rst2 && psci_system_reset2_supported) {
+		psci_reset.system_reset = PSCI_FN_NATIVE(1_1, SYSTEM_RESET2);
+		psci_reset.reset_type = cmd_reset_type;
+		psci_reset.cookie = cmd_cookie;
+	} else {
+		psci_reset.system_reset = PSCI_0_2_FN_SYSTEM_RESET;
+		psci_reset.reset_type = 0;
+		psci_reset.cookie = 0;
+	}
+	psci_reset.cmd = true;
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -309,14 +340,24 @@ static int get_set_conduit_method(const struct device_node *np)
 static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
 			  void *data)
 {
-	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
-	    psci_system_reset2_supported) {
+	if (((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	     psci_system_reset2_supported) && (panic_in_progress() || !psci_reset.cmd)) {
 		/*
 		 * reset_type[31] = 0 (architectural)
 		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
 		 * cookie = 0 (ignored by the implementation)
 		 */
 		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
+	} else if (!panic_in_progress() && psci_reset.cmd) {
+		/*
+		 * Commands are being set in psci_set_reset_cmd
+		 * This issues, SYSTEM_RESET2 arch warm reset or
+		 * SYSTEM_RESET2 vendor-specific reset or
+		 * a SYSTEM_RESET cold reset in accordance with
+		 * the reboot-mode command.
+		 */
+		invoke_psci_fn(psci_reset.system_reset, psci_reset.reset_type,
+			       psci_reset.cookie, 0);
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 4ca0060a3fc42ba1ca751c7862fb4ad8dda35a4c..d13ceca88eab8932894051e7c86e806c2ad8a73a 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -45,8 +45,10 @@ struct psci_0_1_function_ids get_psci_0_1_function_ids(void);
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+void psci_set_reset_cmd(bool cmd_sys_rst2, u32 cmd_reset_type, u32 cmd_cookie);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline void psci_set_reset_cmd(bool cmd_sys_rst2, u32 cmd_reset_type, u32 cmd_cookie) { }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)

-- 
2.34.1


