Return-Path: <linux-pm+bounces-39885-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E201CCDA0FE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6197C30AA6FF
	for <lists+linux-pm@lfdr.de>; Tue, 23 Dec 2025 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E3346E7B;
	Tue, 23 Dec 2025 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KXVpmBMF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fyaE2wrR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AC346AEF
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509731; cv=none; b=h6gqKSErLJEnKtBN0kcdIRO/eSSZ+GjjRdSbcU/uISrR5uJX9cQz5QrVncE2H4nfud8xMLdFzNegEVvp0vjKyOqVXGFIT3nVtGSN99O9JNkN57q8lIY1wsiJqGBPHpIi/+nPU6V0QrQ+OUsfqV+ruEFBETfJxce//GbTZU8g4OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509731; c=relaxed/simple;
	bh=djZF5UFBEvnca6xGc5FxK/x9Ur59exsc3OaeKnFwerY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ruO4pbUsvhwotzgfM9F0s5qAzsOb6qtCeEotOP15zGnTcCWVfhOdNsWD0by1ZfWCZNfDj60QyBukij5Vg225tjgoK1UDFHbPJ/gJ9JwF/Bzq6cKYMaMRF2va1BxEe7rc//cmFVFmOhaBy7cebD/OXnwZA69BRuVwokZPHKHtjCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KXVpmBMF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fyaE2wrR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNFr0Uw4133842
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pQNl6k9FVRxiRZu36Ul1H7qw6ya4whFcoD1DtYOJAek=; b=KXVpmBMFRvDzraWy
	FbO4NFJq2kfKoyUZpreawPEnEJn9egJWvU3Kk+tgbfjL0vxV9pHMj7ul5sDX+I/I
	PkZYsLHGz5CUv4+f3T94zQ1loDaG1ZH54vuANduNpY5hHZStDt3B745rrAkp1Daw
	rcVnEN1PK+jK4gSuNwlZFkWnrd2vix+Roq2koaqMmZrN0z8uwIxrkVMtZIDfbESv
	actDg2pJKGVMpzamXrpFyBOe0gJ4L4BQKJdA56AZTRHeZ5jH7hKaiU3kP/sGKRXA
	J16LGO5mr4FvTXNwCteCLFkTl0UZn75kmaJ3J1lGFhyh1rdqeaw9iYPjZbDnSxdw
	jHToVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b7x46r8cg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 17:08:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a0e9e0fd49so60598225ad.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Dec 2025 09:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766509729; x=1767114529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQNl6k9FVRxiRZu36Ul1H7qw6ya4whFcoD1DtYOJAek=;
        b=fyaE2wrR5uI/U6iJjM2IpIRTXppX930vrpwtZ5o0qp27LiXp6U/MEjadCBi99vmyso
         zI2ek86UsIYDfRM2YQON7khkwn0pKsyDe+GiQq69AnHy7nHLyPTWgWt6feT+7JBLjn/J
         Chyxi7Avhis+1Qai2Fkm07xBU6rI5CzWSx/HjigDoYNj7/3alkLxENKkrf0/9Nagdeq+
         2SmcKaxoOJrGpifhzk4zDmbcoWZwk47eRSSX60WnoK0xj1adgEyNcha2+5KKVn6b7lBq
         ugvunGWnQT8yslTX/03L9EaR572nXpDtWDw5CQXno9j9WwGVPUwk671GzPb8kSYPoueN
         6uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766509729; x=1767114529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pQNl6k9FVRxiRZu36Ul1H7qw6ya4whFcoD1DtYOJAek=;
        b=qvUP7g+3ulTX50EPn7RIFxgzeNXPRSqda4qdxWo0drbN51qO2bPny+GxiCjrSgpWgK
         JKrDWPSOTvvjqC6zQPGEYvZZoXM6ZkaQ+AAjmgDQDoR1XwwOjwHUINPy2cqBZ5aSdzcE
         Z42BHmOzQvxdMjwRgzIRLUv15Etik+af3B0arj6gcwrrV8zKQVhxPVVLgjhipoHDPL8H
         fgFihruk0leehtMfYazp5ky35xp6DqLFxz/h/jBMH5TpKnCYvovOuFv8rYJAPXGSKtMz
         12nd4GXQkGR97rLg/S20Ouy2LXSbk2wRYkEiSGGGuSHb7cvmkl/xN22k7PjhMridjhVl
         Yw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+duYAHfjPcO69IwnrO9gSdAxKhFrGZ7K+cipDGcBcBqqR11IdkRqMfuWdUmz3MHwHfdXEyk3pbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQO0UMI0NU1/Yz5gMcT/qZwH2smieeB64DENiuiYB3fWZ5juFp
	PuSRmtVRgufGShYnU4ygXHE+xH5jjrDubYg6wUiK23FrXUCcdc7a+HOsuiwWuywoJbNbyEBNGJq
	tGIeF7s89fh37clvm8uJzNJzRgepRWDKYHvttqbYmcy6EsSGmH7xmBYzYS0D51g==
X-Gm-Gg: AY/fxX5ZOWfqpdkNqu0sP7HlpeHZzESHi7JZJMEeO+jSDHZgFpMW33rbVq0ihP4ML6X
	zNYjZpeO+yyPj0aO4oklwMaXb7xyNK4ojWK0Ad/wxVq1/jl4cIu2rsJADQcuba5lI8EJq1ZKg15
	cw+b8YXbM6Wg+mHViRi0g9RGDYcJyG1SMT89u0tKr3mQkI7mlkUEzbNfj62Jc2B0w2OHcGAa7W1
	B0gC2liZLvE9SMQMkpGcjRDnYKBZy7Jn/1YIPU/vBZn7mHRV8Ia7amamBXDsT5SVapXp3qRrxhn
	wvCxfu58Bk+Erqa+WJHxusR2RXd22ZP86RX+AXriJmJOE6xXnHnmdYEsgNY+WeXDtT+8zf6XI1Y
	ulz83xrCwfrCzfgI27K1Ab+K5VHxdgiJFYYjuOkGNLEhwhw==
X-Received: by 2002:a17:903:94c:b0:2a2:b620:12d9 with SMTP id d9443c01a7336-2a2f0caa70amr189654725ad.5.1766509728839;
        Tue, 23 Dec 2025 09:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnGtVcBotVXJAPKzHeYTY5P1Q/ScCn+k8fMmJH94TyRGtDjnZNOLRhMrDflhFYB1wXqlZYtQ==
X-Received: by 2002:a17:903:94c:b0:2a2:b620:12d9 with SMTP id d9443c01a7336-2a2f0caa70amr189654225ad.5.1766509728309;
        Tue, 23 Dec 2025 09:08:48 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm130019325ad.80.2025.12.23.09.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 09:08:48 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Tue, 23 Dec 2025 22:37:40 +0530
Subject: [PATCH v18 09/10] arm64: dts: qcom: monaco: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-arm-psci-system_reset2-vendor-reboots-v18-9-32fa9e76efc3@oss.qualcomm.com>
References: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
In-Reply-To: <20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766509672; l=1066;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=djZF5UFBEvnca6xGc5FxK/x9Ur59exsc3OaeKnFwerY=;
 b=fmzIoBglPR6F2b9xO27gFGHEzXk6aliiIcIYRLz28MY/i0vm6glGgNgEGEYz0Cax97UIEIO9P
 coj/ZXRR+w3CIw5VLyIQLGln2qGDYB9897apH0CN3f9wWSXNzpmz9ZN
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: kdUxLM0vYaNTLZ53D_eSOL4k0SzsSbEe
X-Proofpoint-GUID: kdUxLM0vYaNTLZ53D_eSOL4k0SzsSbEe
X-Authority-Analysis: v=2.4 cv=aOf9aL9m c=1 sm=1 tr=0 ts=694acca1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=_PJuSq69R3b4qrRYkJAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE0MiBTYWx0ZWRfXycw1B2VjJG/d
 IS0KXorZpTpXwdTlgJ4P2M/BRUW1yA55k/D4Vd+kwa0LldLrxGhPbfgUKlhHYP+G6llRdNVvF9f
 pgzln8qjUe7JiB3D92pLZJQly/iu3WOPvpZHsacH9bRCcxP63Z4tC6vjnEIeeKtf7G1V4TRfKiB
 YOL/18/hfbuIZQ0QCCUV+qej6z9xJHVzc3CYEHInhAbD6oE5c/lFzz/SDQTiNhKH2V5kIFgztmB
 2euS4EEmTzgvMMq2+DfJvKH3GIIoJ0pMQxrBYT5ENvM2F0VjzqPIflVo1l9imD4gVxRUpBFs7G0
 E4BT2VvqDamvM3SubuTIBDBNWDeVhdPso0Krqi0Rz+AsGma2xELrcTUk3M/PCtd0vYn3JiGdorv
 Z7K2iz8lhIy1EqHDu9V0e8eCVzRlRUQ8XZaP0xdrnaXU3krQ43EcXF+G44p5+9oW+Dl0O4KNgRQ
 eX+RG2uChGTAFklpbyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_04,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230142

Add PSCI SYSTEM_RESET2 reboot-modes for monaco based boards, for use by
the psci_reboot_mode driver.

The following modes are defined:
- bootloader: reboot into fastboot mode for fastboot flashing.
- edl: reboot into emergency download mode for image loading via
  the Firehose protocol.

Support for these modes is firmware dependent.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 816fa2af8a9a663b8ad176f93d2f18284a08c3d1..9c8087f870fc8889edffda63c62f4d5167729cbc 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -732,6 +732,11 @@ system_pd: power-domain-system {
 			#power-domain-cells = <0>;
 			domain-idle-states = <&system_sleep>;
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


