Return-Path: <linux-pm+bounces-43598-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPWcA6l2qGnpugAAu9opvQ
	(envelope-from <linux-pm+bounces-43598-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:15:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9252206084
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B66BC3070BB2
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5863E51D8;
	Wed,  4 Mar 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JVeeyV7A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kIjbtPa3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81923E3DBE
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647469; cv=none; b=NhGpfrhTfhRYMX8PMvbQXDxQqgVQUhx9yZ5YKEO4B8uhmb7n7WFAfQQorVY163M8K/TtUTVxg4r7tngOKHMwANyJ/BJpyJezJ3V4G+YZ1hTT0PMfynGxaBeppGN/okUOmpMQiwdaQT8rR004GngOi56GDA8Z00upxmE/L+yyaUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647469; c=relaxed/simple;
	bh=5Re4Fcu614uHWQ7uwIVALFVPUqCLosVU7TPLzsP+VBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=on/qeB3ScmhguDlutXMIR5FXPRvIwALi8vD2B+ExxP/9VUZRtYptwH+Nh39aVzlKJgoLdeHaqmpG7qnRtuU1VjeLujHD8kZd+a0Wl7+qpuX9IBvkwvkYYHn2MjEd7AXCa3U9DKiYjDfB0J66IkvdMHIYCu7VPpm5V0Ht4js05F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JVeeyV7A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kIjbtPa3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HHnwP2612150
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rdU7H+Ufp7jUqtoufnsWZsR/aNT10n8aiLapu1wjI9k=; b=JVeeyV7A4bR5mH6U
	WI4ug+RaEtYXuDq5K1HEv/LKxrppZpkKx6x/Rp6A05ma9lINah7T7s2Ih9HjY/WC
	w2pxuaA5G5O1Qa7F47ngjkedSO0uTmRBljU9My/5zmXId7Xc/t5g6TXT43Mg0+sX
	DXcfjSZuEKju8EeJr15SOF29xPuQrnZEEjFGM/49FFfxzTB2biHMrjbThxlSShDv
	FtzzH8bmJQFkY6h2fJQxIAR8Zws9RaZ/QenpiLzeCc2k9Kn40bUedEFEtZZOkMZ1
	R1s2Fikom6HN01ELnR2oNiMy0fUcOn3HQWAvp26JDBeWo2EanqGtaxJmOv8OIIvN
	TPUMCQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0w84pk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:04:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso33116685a91.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647466; x=1773252266; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdU7H+Ufp7jUqtoufnsWZsR/aNT10n8aiLapu1wjI9k=;
        b=kIjbtPa3aASGMY5mWgQwOG4v3fgyz+TfhwhL8vD7BND21T/ObH8IsWxcvJSce+A+B2
         ArDubeuJ5Nh7LDec9n9S7KncwrBx3s5QgZ+lQ/bTFVW4Pkl10vq1i1h76iWRp0KvC9IH
         Tej3ZsZUQ43BV19fqTkktmsvH6/vo/7kCnrz48odebeaLi/F+lrXEWJsgVeMakUDRyJz
         dkn6CXZQWDspcf7EHWI2QT3HH/nlZf2GTDgn8QMu0Hi01ENSoi0MwjN1nN9vypgv7fJi
         6mFQllN0ZvbrZa+61RsEbOkzvQEfn14OiELF7wIPygSvlCUcHQe6uKm5gg5FClZD5oSz
         +WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647466; x=1773252266;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rdU7H+Ufp7jUqtoufnsWZsR/aNT10n8aiLapu1wjI9k=;
        b=DCfEpz3JT+PTkYrbBieCPBNtL0KUlViXTr2RmgV8kxUvXkvYtezNyZxuD13BJo2BVk
         bILMil8wUWegaDuvCmBynvTWogKBFRiNWHIlCGKzenGiUIczFWFkxtqqW3m2P/s4325n
         Zj9CVC3D+DXlHC8/4H6ZOMm5exCFofT8pegtcXMmUg5EICjbupGncpumP1brxaeX/5cS
         6nmI5ha8nS1hKK96F8mnqEryRdBM2yy7T0HElqrYPB7xVJ8azVlgCNo2CoZL7u8Yf4ey
         qTWHSHUVxRBVVS+8t5VLAtYf2s/2MiRz9NyU3UpXP+7jtPH0hjQpHiOsXdExueeGYbgD
         b3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV6nufmllO4XdZrsl3RvjLf7SN7RaUlKdAyb9t+zqW5GtlCS5l+/bEESmYcmB2UVKtVw43r5RUe5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjeF531Ux/YJqqTXqz///6LpOrHFxOtI0NWVE4TKoGREmW4Yh2
	DsiahWC/xB5JC9jNonFTBDSDwm2gdmno62DgVkUnR0Dc3/DJ6h7Zq0+JC/Vne0GzwwwTcwMMsCV
	jbVMiQ1JV9l8gOlMd6FK7ePXgv8sSQT1zH8KaoaGvQwwkDxpF1U8RrGSjQPoCu4MyrViyxw==
X-Gm-Gg: ATEYQzyg5l+oG1nkYffT8N2OCJCOeHwmZNwa69vntGn4B3CVBhNPHb3LcFSXp+w/bfu
	BsFVohQWpWPVVP0jcKmDf9rHNVwmRuNZied1+0NjNKWf3LsNm9cq38r2hXT+3Gm4g3R8uukXHNp
	FQTNj3YeTYqyBgv9+o/3URsB7GizyZxqm9WJ7Xa+/Nk0mX8jiGAdfPa2JtKsFSxH1kEIYdqk3/H
	jtGxC9nUtYiIoMZOaoqzqKFZhLKaP9+9QQm6H0n/M5R9BNMamSZnqFsT/vb7ksolCMAvVKUWg8Z
	k6DC8eCAqbUWmJuNe/4YC1Jy6x3shhN4bB/vBUSuQgBEMrU6RHdkenWXIiL0R3FrugWufqrErHg
	5Ssdb0c1ZW7uh4/fO6EVRPzMJs+DXiPS+b3HDrHS4dcsJNnXbaDmaJaVbEA==
X-Received: by 2002:a17:90b:2e85:b0:359:7ae5:89eb with SMTP id 98e67ed59e1d1-359a69c796bmr2658581a91.11.1772647466285;
        Wed, 04 Mar 2026 10:04:26 -0800 (PST)
X-Received: by 2002:a17:90b:2e85:b0:359:7ae5:89eb with SMTP id 98e67ed59e1d1-359a69c796bmr2658530a91.11.1772647465645;
        Wed, 04 Mar 2026 10:04:25 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:04:25 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:07 +0530
Subject: [PATCH v20 07/10] arm64: dts: qcom: qcm6490: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-7-cf7d346b8372@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=2240;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5Re4Fcu614uHWQ7uwIVALFVPUqCLosVU7TPLzsP+VBc=;
 b=5o65AVsItHdOKBx5+J9aZ+vWyhKmaBgKRSV+ow+UzhDZhopfM4hoZbNUWmmtA54/gbX574Wk0
 jNFiJGqo78hCznF2kzQcdMNiuiEFY62XUNoOcP3KH7Nq9bsl6r+yh+V
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: NoWyoo334S04JbvOvLJNXBEB7yQze0b2
X-Authority-Analysis: v=2.4 cv=BNK+bVQG c=1 sm=1 tr=0 ts=69a8742b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=t9IVmYW30V31rltyR78A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfX0NHITDMJQnNx
 dENJpbgJ31MPLhDij5MDau1xKJ5TSX+boBP5jAvsLZUurB5BUvk27nrHd4nhgiXEvwOCYhOltHN
 ENttiVfdOJe0/GYkuu4Bnyz8+vwGBZgACVmv/QKd+ypXsatmWn86o5oeX0x2Sn9KKArSlYJC2iJ
 QzaOUPlhyy72O4VDsaZ6/kyAEBlN6akXzkDXgBuvOm6b8NtuK2os+7OP5IGhXFQcJvkfPJ8PDCY
 i69a46p2aweoDgPl+aBA3pX8P4fZpDsSOyPb3+o2dgMPuzIdv3Z62+/KIHJFT1F2zujaPW9ZeMF
 Catl5RgEF0+Tz0wbysmFsBL9eolQCH2zsEP47Dv/+fuPBDv5ICbUWfmreYE4aM94Ij1RB1CJfNw
 GCwcxjJ7MUJJrgKc+WDpAa3HFzR6yRI132ZHxElvPYEFiyMT9ZZ2ZGzjdku51DgUa53Qm+1rFyi
 Mc/jEy/gv+3fBNK6cbA==
X-Proofpoint-ORIG-GUID: NoWyoo334S04JbvOvLJNXBEB7yQze0b2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: A9252206084
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
	TAGGED_FROM(0.00)[bounces-43598-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivendra.pratap@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add PSCI SYSTEM_RESET2 reboot-modes for qcm6490-idp and qcs6490-rb3gen2
for use by the psci_reboot_mode driver.
The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent and not available across
all sc7280 based boards.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi         | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 7 +++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829b5233bb87fdcb37d8a05d30fb87b..44dc8eb55a213f81205584650382b6b7f79f6e88 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -863,7 +863,7 @@ pmu-a78 {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
 	};
 
-	psci {
+	psci: psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index b2f00e107643dcc79da89e40206f86a834da9e33..5792cd75b61a53f321d3348eb66945f17c84153c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -695,6 +695,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index e3d2f01881ae05f17796f9c97f10b53cea50daff..bc7814ad62b824bef148bec4cffcf10f89a21c96 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1031,6 +1031,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x80010001 0x2>;
+		mode-edl = <0x80000000 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


