Return-Path: <linux-pm+bounces-43600-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLbfHXl5qGl0uwAAu9opvQ
	(envelope-from <linux-pm+bounces-43600-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:27:05 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73202064EA
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 19:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8C23023DDB
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23C3E7145;
	Wed,  4 Mar 2026 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UPeSScBH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KzWKkZE0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0033E5EF0
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647486; cv=none; b=ANydRD4it1fdnJXvqw/ku2Nte6GeJOh0Ez+Yi02B1lsud1I5fU6K+fzRDl+YQzdD1KKRLmGrhAU763lzo6MtxNq3Z42jweIpTEsSKjBGWhzydQCju0JF8vWBL257lWVCadsm43o0KI6ArJG6fSBGCZU+wyHVkCbs+r73SnWlnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647486; c=relaxed/simple;
	bh=Padqu+PvS9ADlI3cueabj4f23ybpQ0vF53i2fpuD/lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFaXqATzN7eBkwSVE8dTsw0OZts49g06sl79InaTnTvlJqcs/yVcx/KwmP4LlemyI0jRPFRq8qruzpCvSRSt+8zhcjfVxFPkd01NuUxMrsYKlkgpPdsBzq83r2QkWh31Sabuc+tGlevOIqpbJomA246Plfc3NRyQbMNe33BXllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UPeSScBH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KzWKkZE0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624HTFSS1706225
	for <linux-pm@vger.kernel.org>; Wed, 4 Mar 2026 18:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kTTNZDsVcxtX1XnLnS05CMFNUc+dltAX8MCcE9nX8jo=; b=UPeSScBH9jwnA4bR
	Ni03xOurnQYCwd56akYIQPKVvob6IqeVx8eE7xEnfrYQ9ACfVbgbXbLd+7mqoX9D
	p7b5GBqXXg/D0x8ZL3xkLi90jOTXARtsOvqzP/hM0JANggQ2Ue1sdtrNR4KLOE8n
	MH7WgUCGJ3FvZbo92NFsd0Bb5s5URXXzTGQcqmVgLuAyPgWWKZSXABzKvaT9y6bT
	H3AH/uk3IqKd64UgqzZ2V3RRdFW7iwd5hRwK3WL35WYN8noduI/AYJsv3zq0JKZK
	qH0eypK4kOS7H692C8CmJ13WnwN0/KwfiZh02Z5bwx0yRjceeiayUAjoXj9JZSxh
	4UdWog==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp3tvmpv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 18:04:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3598c05c806so3517181a91.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772647484; x=1773252284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kTTNZDsVcxtX1XnLnS05CMFNUc+dltAX8MCcE9nX8jo=;
        b=KzWKkZE04FedBPHi+DVxpn6kIMbC/WK2I0CWX9DWESrvFJ+10ZbhgbORa9x+pBiTNp
         nzvMNJKQh95Yb94kqM3VViZi0iPrNnUnQVHJ27D5ZF7+ekXbUmr9WjvVzjE/m6jgeTPJ
         LEREbD+vnoXUSnjlcwApI/vVsvExZ95rpxNcOE72IabzLoTy5vfBeaAw54l+C2utVOJ0
         SkAXaAEQVOS7uXsmX0T5SM4g1Ou7aXWum5/+stw+jw4oi5Slv6SXfzCmyt3QPMMyLLwA
         hv7AXY/6YOc68hNOGd2Xd7qMHGajObl09bBxqc3z/hc4psNfxf/++E0VOGNGYyxpLZKj
         hYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647484; x=1773252284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kTTNZDsVcxtX1XnLnS05CMFNUc+dltAX8MCcE9nX8jo=;
        b=d5elQh0+QOK5ce9umHxqFy6iafxdozmkJjOdS4XhNfSyXKfLjPqo62FzM3s91dZMK+
         hxJ+ZUprjzVM8fxy0mWad5QEPThnJH+qASK9ZatgqegwxUGNLVtva8+Ngn376vj8x8d3
         w7X9MmDI7T5H5hoQMpamSCQoXqrpXzDeTANjxNhcnx3JNeTtZ+7tv44AkUBC4aYErPkr
         GjS6Kxyv0jbFj3xMNcpCuTM+YKakb6NeN3cdxHewjf8RJjm6IbapWtONBBJ+s8cKu17O
         VL/S3uzPTz5rj0r5lnh/J0rkH1p0/Q0x1z19k0oQlUsweAhz3XVCx3/WxY8bHSZcG6nr
         0r9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXY6gzdQQzh5TeVXJWuUY+Ui+OeQ84rUNEzA00c4UeyVHMv8cqTVn7ixtcw+t85WVkm4B4l/WxQLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRprEAePO9xqvCuNEO9VFsl2TwHrd3fR5wcB50mXyUn+RfYCop
	YeBYY3te0Fgnf87qD2V8hGWq8BnVPKVJavQdnGHwtreWp/b47G6F+0rG/2AgNtEVozIYST6iNsh
	etbDaNZTQRXD/LwXA+fja7wH/6MXc/P/n/AT++6fPG6RNZl3XRCBEqhX4m52N+IgW7TVvRA==
X-Gm-Gg: ATEYQzwG8NF7cytTOEqboX0qDAmzNuh3oasEox8B4SvCZOZ2VV0bFrTBwoPmP8zQERV
	voCi32GJ0jxGu2nsdFNzDRals+x9tm6hLMvDf2PLxvc5E4osC5HR2k0sa0Y7Hm0Dn3K2bWetKTv
	dq1isUWZQRSJYRoaQqIqc0f2fmdcUL3X9oIgH2Ql5SXi943ZP5UQ+gu+D/6X0OkxAa1/rMXfgNu
	G0OjNgRWsuNmCFsdxtCvVo+dA1DkEh5MucFO1dedXVKUGvkrpTKLEiV6uVs94PI1oyOjPwImcXg
	BeAxbvMkL7oVjeyyeibG6FUpnLOYwnEFuU4N+Lsqir6TcQx1fkRQ3MVvrdKD6qPJsE9OML7fdqX
	DuxA0J8mWoOOolJ534eaF4pZrufjxv2qOnYBG5kYkoJdCIlijN5NTV2WEMQ==
X-Received: by 2002:a17:90b:1d51:b0:359:8d2e:6f79 with SMTP id 98e67ed59e1d1-359a69e4ceamr2610450a91.14.1772647483916;
        Wed, 04 Mar 2026 10:04:43 -0800 (PST)
X-Received: by 2002:a17:90b:1d51:b0:359:8d2e:6f79 with SMTP id 98e67ed59e1d1-359a69e4ceamr2610419a91.14.1772647483396;
        Wed, 04 Mar 2026 10:04:43 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359a8f22062sm1080606a91.1.2026.03.04.10.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:04:42 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 23:33:09 +0530
Subject: [PATCH v20 09/10] arm64: dts: qcom: monaco: Add psci reboot-modes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-arm-psci-system_reset2-vendor-reboots-v20-9-cf7d346b8372@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772647398; l=1066;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Padqu+PvS9ADlI3cueabj4f23ybpQ0vF53i2fpuD/lw=;
 b=qRU8pwtXB6YToHNyc5AW6gfYjLZkEIrjxg1hQxmiDTVXZEto3zgV6elR626vGLihxk595WpII
 cfyi/8WtGvtA1BOjl70TJ/Ijiozz76laP0WmYq4RdUc2G/RypRpHdNU
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDE0NyBTYWx0ZWRfXzx5w9mrKex4/
 x3+XnPpYSJKhLrNfhO1X0v4TWPoJe5mD4J6As0SrDyt5wvaxEKZh/bnxA50jCvRHSZh/U33e0K7
 n+ZiKNKGI8sOiKdqi3V7wQMdrCGCbAjDitxUGFhN8BQfmTU0YAN0v5jaHjRN+kH2sBwTxLbyb0R
 pFzZMQ7qr9NES/S+6ypj/bkBCiC/G+6vCMVAaIIT+BXzcL3EEjUTJSeowmWBwXLW4BG9fMXbAkd
 HQZPLAuFyJNDmpbo7Z/Lk48A1ch03sx6KAp3WGNUiR6VzKC8PVjKXZEGCw9QPYB3xfmszIfZnT9
 EeIeEoOgFmuSOHxxCWMd3yXK9lLD9WiEpEL3A99BMILiEWh73wZCWcrT4g7F186EklODO5zX2OG
 /+BDapDM850q67buPyu9HNgCnXLHD8OKpIeTDunsfeNFTMnHvls/FkhpnoUF6shw9Pq/EP9n6YD
 Gj5VFx+nsxFnBkl8u8g==
X-Authority-Analysis: v=2.4 cv=VYv6/Vp9 c=1 sm=1 tr=0 ts=69a8743c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_PJuSq69R3b4qrRYkJAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: n4U7NA-Wsnzw4LYWH6jFi3QzYR9666tv
X-Proofpoint-ORIG-GUID: n4U7NA-Wsnzw4LYWH6jFi3QzYR9666tv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_07,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040147
X-Rspamd-Queue-Id: D73202064EA
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
	TAGGED_FROM(0.00)[bounces-43600-lists,linux-pm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,arndb.de,arm.com,rock-chips.com,gmail.com,linaro.org,ettus.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
index 5d2df4305d1c1c450c7be53614da9d8c08123e66..a3542a300a27715eecc46da9b2a82ac7e76e6232 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -740,6 +740,11 @@ system_pd: power-domain-system {
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


