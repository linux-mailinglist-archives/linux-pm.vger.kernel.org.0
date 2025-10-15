Return-Path: <linux-pm+bounces-36122-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6FBDC889
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 06:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91E30501697
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 04:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63AF2FF65F;
	Wed, 15 Oct 2025 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AXIkmmS9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF012FF14A
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503239; cv=none; b=ZzGfsCfhuJvrCvi7Fq9u4qCjGuk6DFTYAPY9/t5dH5ycXscEAGOs2mj6vCb7j9dilIJDhUaRx7sqeiJo90/dm0qrfbru/5ZBEWWT9CKApGOIMcVpr9GOoDJ2aP/QsBqmOPMLfC+BdanJ82eM0BWcgHgO2TH6BBqgIgojVUOatyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503239; c=relaxed/simple;
	bh=9IjzMJlN9zEtU0sFSpSy/h7SjvAv8UW5k17M6MwN68E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEeGNBvrMZrkkBKzEUkBKK6ZFZHW6YouBdoSEXp8vXCjn8dzBdXG3PVN+PPOOPwYpu5iluP3i+fSHR8E8lAaZqO/cuuK/iGg93j4HPO+42ad+HiMPvZQKqELfJDMuWSepm8X2FgWCWpv1TZaKXlQXQXUfqpi/EwlxMgPc6HMY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AXIkmmS9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s8OK004000
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FjTIG/ndF7kmFm1KFgILV91linf+L9tY7iP4vjPrynk=; b=AXIkmmS9pyUzo8Fv
	mqzhC/7w1zqpq7LEELCMAeZfUp/tUE3Pw2LzkM2ADMTgtmQn0Dz6bjoQ268en2oc
	Btih0GGoPVefXtxa7nawCIUFSvw/Q1gvNZEzNKoIK6kUR7wmdIYX1g6cDqcVDumO
	5jzEPWN1pS1cwOLu3temVqfElp0CZGV+fERihcitO4lu1OubgNoC59ZgaZk+W064
	W6+iWDdp8CJI7HvbAGBQGBvfa+TubtjjU3f/M/Y7jULovKylIM43lIHwiilMEuKj
	wAAqubCc9k37hp5tCIF8YveLoziQds2/sO/txarRnJ604qw2NAz6Bouxn2yx4XpO
	z2D77g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwnbxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 15 Oct 2025 04:40:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so10152020a91.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Oct 2025 21:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503236; x=1761108036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjTIG/ndF7kmFm1KFgILV91linf+L9tY7iP4vjPrynk=;
        b=PrHtzxBaAiH8bztZSNnwDIiwhfwh0DzOCfVcznmISTkCCxGqKHwc4HEmKAz5djX9KE
         TKLtmCx+w2ilXkJohW00Jkjxk4KOnvWysTnoUH8qRFySOVsf3OHVVz34pXYUpKhq0owd
         ZrTdbvUaWZqgeRgWSPDH9oJpqGkfapYIZMt9bK+TWBTL9LFmOc4MxGJVfTCQgw6+tFx6
         2hqHCInvZigNrbyWEQxyQntoyWjB4AWglBnofxJhoMsDYIzth6EzjBggO50IVGQzFy5/
         USwDeexhF6GY1WJnXR48WJykXaZstTmdYz27E2T+IylyoWzotN0RIP8FSWy3+XJfI1L+
         CIlw==
X-Forwarded-Encrypted: i=1; AJvYcCUymFZXncv4n7SA7QlBWom0zAl2RDhltvY91ZZXOidUMx/dtGnJW562mbCDdu4STj/d+/ZOcnnfOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7LdGY0tFu2BPqY4S+P1G3KuDQV5hcPq3GJYxw65oDBRz0Lzf
	fTUg+gGYBrlqj/9zxaQ5Ym0TIkVxe4YH3hVTXZlIe3Inn1uKzPVdzn0w30Oxjhb2luiIe7Nwpl2
	aiJcTsQAESxfSlyaQA5KAJbQ87dB5FjYodtnffVGjk4rTBq+Ak8c8mXoCWIeOJA==
X-Gm-Gg: ASbGncsArMd9woug5CySoqqQ8d5tQjCyjUCc5IZcFJZ4yIqM0tLUUqjuLObFuLyxUVA
	e/GpJrnMhXfhvmxAw4bS68Rtpjhx+s0oUCTelsTJwXNFj9Yvk7tU89mH0uusuu+2IOBlceyNhVH
	+51pRtDbwpH/TNNUoBkb8H3Z/IV08C1gWMuxB/9LS95xS26SWkVM29GDmq1LIc8QC8qlXcZedir
	Y4mbz6S4dA9ev1lm+Q5LcTjXF37ZRxxX96B9dpJiD0RM83AKjJ2/LN+is7DrJAbllrdWTIc89HP
	//AYcH5va40R4bwI8Y5cRM0Fqsfvam/CXj3fT2eEbdDeiF481GxtNUSaIvJxTVg4xcy7QvSO91/
	3
X-Received: by 2002:a17:90b:3e82:b0:339:a4ef:c8b9 with SMTP id 98e67ed59e1d1-33b5127ac7fmr40641884a91.17.1760503236350;
        Tue, 14 Oct 2025 21:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHu/fh5mCQeexri4hyHIJ+5znOiZF1zUORQzO6knj6EhQWcqGep8TUPRpxsCMjewhs+3tmVA==
X-Received: by 2002:a17:90b:3e82:b0:339:a4ef:c8b9 with SMTP id 98e67ed59e1d1-33b5127ac7fmr40641846a91.17.1760503235839;
        Tue, 14 Oct 2025 21:40:35 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:40:35 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:28 +0530
Subject: [PATCH v16 13/14] arm64: dts: qcom: monaco-evk: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-13-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=989;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=9IjzMJlN9zEtU0sFSpSy/h7SjvAv8UW5k17M6MwN68E=;
 b=eKdR++dyMjdBMNY36k2+x34nY+d8eC3Efd9IO354picD4bMu6IjS098QETQt+9/1DnVL0mhUr
 2ovRz701RTgBcARNwJjYePv/sDEKqx+Mar0UMjSJneEp3CIfL5qmXUA
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfXzjhGCH0WOo4Q
 pRcJ9twbGQQpCb9MllTxMXEE37oPN0R0ZtUSXRhIZT3bL+S9r5IcUp9ql8cb7uUowLNC++Njsb5
 hg7qlYeEAWsyxDFsoQ9HxfFUGAOPxiqgaDMtpWq8TtlW2FyQLqJoEVAXb7QOMqFAilDjezS++XM
 C8KmS03Yljy1JYSAfdrjx+WIh9KxrvOANcqeF5X+cwVdu0fEz+nMunaegU1r6+CUWKrMrQiCIvP
 /jD7AAMybFgBURAVpIXitXuS9wymmInDWF8l6qaI7DnHIWROOk8fgS9NBDosdomvLR783g5ZYqK
 dgnjorn5dfiX7ADvAIfBV8OoyXlQcGKG7TkWxurmkjAXKDy4occuPAwwtiJ62Xko47xB1WykTdt
 NNextrnH7JvAIHMEQAkR8btH8K7H7g==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ef25c5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JGo1Z14By4IpQyqbhUIA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: LnX52N8_56BzAAU4KWsUfD7IT7j33k44
X-Proofpoint-ORIG-GUID: LnX52N8_56BzAAU4KWsUfD7IT7j33k44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

Add support for SYSTEM_RESET2 vendor-specific resets in
monaco-evk as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode.  "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index e72cf6725a52c0c0e017be800bfac1773fad1059..87d613094e551e1c3b56dc45362a588eeae07444 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -400,6 +400,13 @@ &iris {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.34.1


