Return-Path: <linux-pm+bounces-43599-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM+MCS15qGnpugAAu9opvQ
	(envelope-from <linux-pm+bounces-43599-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:25:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A9D20648B
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 98D55306B1D1
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11393E5590;
	Wed,  4 Mar 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jJaMHWVj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H6FojKtP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E713E556F
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647478; cv=none; b=pDHrgskZ2M9vbFlRkxecgT3fFB3jr14ul/Pou/oJUZD6FleaPdMhuKkD/gnJ3S70ZkoMmr58h3u4FYE88LeCB6tknBT1x06yXHr1W4xbQ81SW7I9iYksjJyjwxuquLTX/hh7UpZTGMnlM81/y2Awz6G0tw1nCfgMdFRSsfz0XAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647478; c=relaxed/simple;
	bh=UhQBeFgHwK+VhUEZZ9u/QamtLLiZ1oP9pqxntRK57Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAo9JZDcZeAyhOMlcj+5q1ZdlXU93KiB5UhmORiYdha6sGX09MKFmElPZE9aYuccvXBSjyI+6UwE3NrAWw2tr2rcZ/LRziR5oan1A6IfDFJiiTPYFLPZvYG2K6tlcGbO+lXI3QmRVF3VIbGACYHeQN35wkThOIN6wqOtTaUsoUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jJaMHWVj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H6FojKtP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HHlCW2494822
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NhDn1FDSw+c7UhbFQL/TJrvi10/P8i7V+vblELzHcoI=; b=jJaMHWVjsJjwa2u/
	aC0yykYaleCxm8NyrmFR3Bz1NCDL3FH1w5jjPlOadDOkQZ8sV73EyQTln5q6t8xs
	0J/CxMm3EwxgqY/1f1cmgFUn6fIR+jS6xNKbmxxyoXqoHODkTeE6Mifwo8/pejad
	J/mLYl+r7ThQkqBFMAsGhiNP8tNbNuOQMWZ3o02f+UaXf+QKdlIoFRKb2h/Yj58l
	FEek1ZSYPYjrScpyziIF5Q+XuuVr1SrbjSNufoah04obrMGzgDj1IAiBdrxK10qZ
	LlWO+ncPE3RxMNOrsVRhuZX+HWdPFXoS7erpNwHDEeOiHQIkBi39OUQA7EMUKqPF
	L5oQ8Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cps0wg54d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:04:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3595485abbbso5705714a91.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647474; x=1773252274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhDn1FDSw+c7UhbFQL/TJrvi10/P8i7V+vblELzHcoI=;
        b=H6FojKtPvupiNRHdmSZubsgMrBFftskYhZpYaU480NsSh10kbugwoRuaetq0CDghZ4
         QsFe+WaiLaa3YDKRojgSvo3HRQb8ePG04ZOlOdDLTVwHvpzuNzOGy3033OoRoGJ5OZkM
         ntZRN+Lg5d5keB4K0h4JqiiIFnNBSoWcXy5dZfDHYAk7euag2kSJeXr1GxR+xs90oXvp
         EYoEvBxiDsr+f10BA5Qsx5uDewLBQoq1UbPAN35YUV0ePZFCHV6v/E2uhqqDxPlep4U8
         YYQ2PCQ6MMUMSnFGvPBatXdtqsMZ44PYLAJXeLu40Fs85Zd1x+1+D41gYWj2b8o7AdAG
         8VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647474; x=1773252274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NhDn1FDSw+c7UhbFQL/TJrvi10/P8i7V+vblELzHcoI=;
        b=d5VBx3aDaKJUztOqC3TWY823lCYpisiR2VyYA5ReJ19qu0LZ9NJ7pwnLhz3jYoZPTx
         /qyo3k/ip2NPUmKgcewqgfC5s5QVPyMMczcfDp2IKRoSf56NBp3jxEMz/hUnVrvp9LJw
         7U21mcdEkfb1zNV1SsjYdcd0SbeGLA+mfHZzHL9NeYshyQ0IPTbCSN77WWWK2Rl5VjHc
         mMJddaSWARtMiuwyfc4T4ZKa86PNH7TBryp9VDk2/fYFSA8138atyOODtr5GN2RTMvDX
         X5i6kRWC0GfGdEB45VdG58tzAAtlmAGUJYySLi727xPtMJ9QWtHTr5tL6r0b13yKEPoX
         MX7A==
X-Forwarded-Encrypted: i=1; AJvYcCXPi9nUrTRLszNy8ENZfT8V5yDcBxoGDOhVTZayWDra80j9s+TBTCFEjGmh2ynzr9o+wHJLq603gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8H7H52rBa65/0c/s9LowUPhpoebjpz1NggXYfVQ3SvrVUMRSm
	qaUSWXglJsMxbKkS8JqtMPw/lMo1F2eKg3IX4SrZ3tpHjVQaFk4iUQggXlC7WY3Kr5W9izrG+n3
	OWOeckSOoaFyc77vpxarfVu18r8BeQRbAek0YyAKD3QsmkRUossJj+draflsJLWSoA3pm/g==
X-Gm-Gg: ATEYQzzrjMAlcVxFwAyZraW6IDYt+DQOsC4+E83BsBC5YFCZLAA1zzVHvXdDLK9YQ2B
	fY5gQSRCDR1p0Bku5oanG9DvVDNqJtigQUyLve9mX1h6MRVSbGc9EU0dMaKSX2uFajw5bV23TCo
	amqxph4tbUZLrXZ3xE/oyurMLvxZYrHPjuKRsn1y/sKGzxD+3Z8WkTSu5ZQyB/9/s6ihsFHyBlx
	aTWEaLd6qXvcm+4vbhHaKu+n2FJFYw7RzLROkmWPcD41g7SmNPQsfYSvpiDO4oT+3iQOpLMZEyy
	xEE58ueSdh6HWvQAfhrgfidAGikhuiOMDBJmadg2L5YSPY2hj2aCdwVZt6ArqHRcVR20ELEiEMm
	T5fOMkvu7AZuvf1RRhhQuCcPVXQyWY2i91c5QFB/oCZtsQj/1ijZEELB+dQ==
X-Received: by 2002:a17:90b:3d81:b0:359:9669:c879 with SMTP id 98e67ed59e1d1-359a69cd901mr2630715a91.11.1772647474541;
        Wed, 04 Mar 2026 10:04:34 -0800 (PST)
X-Received: by 2002:a17:90b:3d81:b0:359:9669:c879 with SMTP id 98e67ed59e1d1-359a69cd901mr2630695a91.11.1772647474050;
        Wed, 04 Mar 2026 10:04:34 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:04:33 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:08 +0530
Subject: [PATCH v20 08/10] arm64: dts: qcom: lemans: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-8-cf7d346b8372@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=1079;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=UhQBeFgHwK+VhUEZZ9u/QamtLLiZ1oP9pqxntRK57Dk=;
 b=RcmoQ1fYDcRXvDooluVeIsqC7tRYg4rdhmuADpGjwdfi7jgzmdro1TicHjZj8DieHX9B5HeQr
 oPFfLSLbZ/PCKjddL8VgGur6YGNV74s8lBO/Y3lhg+hfpieOYAYNN56
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-GUID: riP-ihF4IFiK_5Oa8BPctA-W7UvomBzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfXw1gjpnN1YgSm
 /rNV3L1XGe03eqh8OYVVf98KZSt+KAX6tuJHUiFMsYqLlOuvMMyRjl39wyWykcPDeFEWMK783jz
 nO2H61kid+0JtCjMZDeWYUNkaFpIlTW7eER0TcVI5mDbrgrMh8XnbwyyUvwC4fClkvRTVAQcXRo
 kO60dpFkexLTlt7ETpMr/NzSL8WDxOdh93VL40+s+vIsG0lnp8NMDKMVlWWpt4XhMqn8r8VYCtM
 gSSneFx6Q61SEDtB5WZ0OUSoLUjYsKGmy41AU6fKkPNe5xaZQVeAtbWK1gXGhUFVcq0jqCSGAbf
 0y8ubdpWdXfSjrqtPzJUgadQntFBRtMrtigoeEvrByu8b+mFV7eTJA121wrwsEq2paUp2vXAyMM
 cUbCqCrU4Bn0z2+4VM03ZDMbQReTFUcanWB48+0Ow2+5ye/kBHtLKz3VKdo+3J91ibiwOlM9BuC
 SdmFp9xppAxVuEMD1/A==
X-Authority-Analysis: v=2.4 cv=OYWVzxTY c=1 sm=1 tr=0 ts=69a87434 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Ld_RF3OM1xByVwKNVVYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: riP-ihF4IFiK_5Oa8BPctA-W7UvomBzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: 24A9D20648B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43599-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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

Add PSCI SYSTEM_RESET2 reboot-modes for lemans based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 808827b83553dd70904d771cc1da784c85fdc1a5..b5234a1b31761a6565299733a30cf3808c439976 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -635,6 +635,11 @@ system_pd: power-domain-system {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&cluster_sleep_apss_rsc_pc>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x80010001 0x2>;
+			mode-edl = <0x80000000 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


