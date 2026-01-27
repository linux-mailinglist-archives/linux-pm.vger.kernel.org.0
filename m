Return-Path: <linux-pm+bounces-41561-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPbwGGroeGmHtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41561-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:31:38 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A4897CB3
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E1BA30A959F
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA49361651;
	Tue, 27 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7QtjTqX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UaXRELZ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD936166C
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769529504; cv=none; b=GW7DeEMzJIRW8XF0RUxkDATmK7ht7xwtaS8p85Wg8oO8hwfOC4XQQsMWuoP0QKzvoCsJnZ7Q1/lmEE9nd9nvbtTHNnfek5H83emLkNrzMavSK8yLHmGTGMUCFzXw8Sy1cuUJklG95TbDekVOrFrc4da4W291p570eWMVo7IA3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769529504; c=relaxed/simple;
	bh=F/WRCepjFcpZUUlC6qKcNtIckwG89xuifemDPktE66M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQXJRyFsUy0Tfx0BHLIbq8Cj/uRv5yFuzusNQLseMWG0sOv33pk4owZYCKu6D8i9/aFyDdtg7bxbCn4G6nYXa16uLgiJlckiEzNFsyLaevAjhapUE6aKqBUSHQMvHw7m0uGQHtrJJD54jsSJ9e7PvmjSBFbPsL547ocvy9vyHpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H7QtjTqX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UaXRELZ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60REQ99u2379294
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uXzCklFu+psMk/IKlNTq5oAZ736zPPobE3f7vWSqzaU=; b=H7QtjTqXAuw4k9a4
	occA8r8M3E+Detbe8qIyRppt19qKFtMzZ0M/jgg7SFUYmUppEdtv/iWZzL6ArC2y
	m7VTpWEHYmoqalkwunzqygE7IXaZASNdWVB1eO/Vh0Q7g5IEQwsFTvpzNdHnA+Eg
	4lhbsn5PysOrUyZUP4rGoMVmh2kNNCYX6PYfv8IN4SjeMGfBNVeLDd/4kTnKyrKj
	7iG4DEynQb5evfIYFPAWKCFPliexrQpLWww6+9E4wNhhaZmdCG/T9SZYBQig5NGu
	1AEOMQCEOoUwBcgXUz4iNMYVjWpm+v32CpJzeZtq4N0cV4VdTccDk25x75H0HrAh
	FUlSvw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjr9heh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 15:58:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a08cbeb87eso59259635ad.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 07:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769529500; x=1770134300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXzCklFu+psMk/IKlNTq5oAZ736zPPobE3f7vWSqzaU=;
        b=UaXRELZ40uKgg7IWbpT3RlbFfHWtgj1MofiKhs5WO8MIIjaGaZfNaVM1uRhOSGEjOW
         2W5gYdftfDYa6BF9Wl+0OOKbXAIC/mjOJk9KYuIExESpWzlUThHK0VpMBkXOTmsfQ8NV
         wrcmcndxccE2pf2HJ5+PB4kg9Yd14+GZn4UXKscwXKNPZ4G26CsfcNrVOVIoYgXXYJfO
         CQ2bgKi0pGjomTuZnsF/NkTKjQYcjln4bi0sf5sFiGWuF7c6XhUT4e31DBQ7jyZMYv4e
         XMn+SeMFWqpaYiVtTMg54kDGEwztCXbO2UcajF1oXOcLRPQALtvndGePsctjl2I019BJ
         V/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769529500; x=1770134300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXzCklFu+psMk/IKlNTq5oAZ736zPPobE3f7vWSqzaU=;
        b=S5/3gyfADPeYO2X0aOosSE9nsZFkVqY1UNVDyFzwx39mt7OC0oRMP31bLJZ76bGQM2
         SlklFlwizk5qY7D8de9VxctglIwzG1auE+TYR430hJ/a6B9AXBrVJOG8V4d2hUVWbUcX
         Dq1sUH78O+Uj9xXHeonf+rk1xzhrAS6qRCXiQ8TT/PvgjgnAswQ1egLtwmNc/IEQm8fK
         pFFfhsr49eRpJy3ibXlSvpPZTsiv/wuj2wO+Hv1kbcjOyBQrDKsXzdYvC+xihXbnQDkf
         SvC69nojipUr9eAYKFYdiRYfK43Hgq887LX5knQwD+3M2NBcuLrwhWzxTWiWSy+d2sd8
         79Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWKLaU3ABhLoh6AkqUtXz6OsWo7GvsVMjsYH5CQ4hdYo5b31+f0z4kEK/eIUyBe7oJqy9ctR1sr3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGg4FpQ5La0gJ6EHmfJgbBYI7FU1l/ip9Q9nkN2pJwVOS0YNx
	1xbQ3E0jZqfG6m5ipdVUQRY4mww4oTEFixlltJXf29nt/kzvzn+6Mo6yae+tgHaZA84Fz1v1G2p
	IUIvA9aVtJxg+VHpasUO1ElSo9bsZZsBW3kV3E61VVQMk1Fndw50fTTlo3CujQg==
X-Gm-Gg: AZuq6aJbkHH9bAdtA+eIYEOG6GJNAKUFIfetK0pWkg51sS+dgK14kbLmpd48Dm0O+4O
	ao/Obexp/AwYVH3alczoRK1CG4u9eT/o9GhDhT4LIt5laYUe/NCjhh6VGC4Rmb/EqHJSCO2+Ee0
	4q3XwBuoHUQqA6C01rY8CxFS9qDMIVuva9wYEHJ6TsPsN0N2/w4+zVAjEM5ecAMVNEbwhAXkKlN
	GA/JtJhBT08qcHxudbDwulPXfbNALFiNcXkxGy/p2t85CIUh6QYjWi7CgfLYILF98Mi2Ys5nVjI
	HAxw5q/SdMpXzVsCrMQqBwWafFtSlRWV1siLBhBaVGqPs9WygVieVLBYA5A2RVcbai4Zr79+uv4
	IYo6dm8ZcGWQdLZwvS7xdN5n7+cbiHZ/spBQ+qKo=
X-Received: by 2002:a17:902:ec87:b0:2a3:bf5f:926d with SMTP id d9443c01a7336-2a870d79392mr22357195ad.24.1769529500366;
        Tue, 27 Jan 2026 07:58:20 -0800 (PST)
X-Received: by 2002:a17:902:ec87:b0:2a3:bf5f:926d with SMTP id d9443c01a7336-2a870d79392mr22356865ad.24.1769529499779;
        Tue, 27 Jan 2026 07:58:19 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede745sm120577465ad.44.2026.01.27.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 07:58:19 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
To: andersson@kernel.org, mathieu.poirier@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, konradybcio@kernel.org, mani@kernel.org,
        casey.connolly@linaro.org, amit.kucheria@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gaurav.kohli@oss.qualcomm.com, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 8/8] arm64: dts: qcom: monaco: Enable CDSP cooling
Date: Tue, 27 Jan 2026 21:27:22 +0530
Message-Id: <20260127155722.2797783-9-gaurav.kohli@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
References: <20260127155722.2797783-1-gaurav.kohli@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NYVXd-XZ3jQX9W2kC2CLkk8lSR95bFoz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMCBTYWx0ZWRfXxuYzADc3mkSy
 PCTz1YNRcCCSa3J20xmR2zDcn0p4VOlFjEJ/mUPSDpIpULS02jRlPemm0mS7gLf/6ZO+kyFus9q
 RIeAw1ijCnOqshJ/V2X/Kb5vmEdBmcs330hbsowiMBAx5fbFWjku4iN5DMg297KeH1Oz3ZOsxhe
 voqZCoRwsU4mn1HBCIo4tBTKF290j38TIMQXLd6D7ALvZytgUXGoK5pOpO3X8ffu58G7hR+432x
 5kP+wcapOo5Bzqv033QAln6RKobviW/QQ9Nl1ApqaNvYFSJGZVQquff/iWat/AQabZXnBGVEEnH
 c+x2+d4ufLvf2IP3rgRpwuhTfIiuhdCohJxjfDZVOk6hFGk5jHg9vkzdwP4gRJk9qLkQTvxBjKn
 ave1oUPz/u+3RrolJi0eqOIFahMoDbMJLsjBoku5vY0v4aOd2bfo64QhV9HHHBeJTl0WwnrlEl5
 f00jWhSISVwYBX4KXEw==
X-Authority-Analysis: v=2.4 cv=b+i/I9Gx c=1 sm=1 tr=0 ts=6978e09d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=L7ffWoggXZAuNz6kUr0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: NYVXd-XZ3jQX9W2kC2CLkk8lSR95bFoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41561-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,0.0.0.4:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaurav.kohli@oss.qualcomm.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 81A4897CB3
X-Rspamd-Action: no action

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in monaco.

Set up CDSP cooling by throttling the cdsp when it reaches 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index 5d2df4305d1c..6d7a269cd98e 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -7194,6 +7194,15 @@ compute-cb@4 {
 					};
 				};
 			};
+
+			cooling {
+				compatible = "qcom,qmi-cooling-cdsp";
+
+				cdsp_tmd0: cdsp-tmd0 {
+					label = "cdsp_sw";
+					#cooling-cells = <2>;
+				};
+			};
 		};
 	};
 
@@ -7528,36 +7537,78 @@ nsp-0-0-0-thermal {
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
+				nsp_0_0_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_0_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-0-thermal {
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
+				nsp_0_1_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_0_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-0-thermal {
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
+				nsp_0_2_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_0_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -7648,36 +7699,78 @@ nsp-0-0-1-thermal {
 			thermal-sensors = <&tsens3 5>;
 
 			trips {
+				nsp_0_0_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_1_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-1-thermal {
 			thermal-sensors = <&tsens3 6>;
 
 			trips {
+				nsp_0_1_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_1_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-1-thermal {
 			thermal-sensors = <&tsens3 7>;
 
 			trips {
+				nsp_0_2_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_1_alert0>;
+					cooling-device = <&cdsp_tmd0
+							THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {
-- 
2.34.1


