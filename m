Return-Path: <linux-pm+bounces-37691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 432FAC440F4
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F121E4E68C1
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73998301006;
	Sun,  9 Nov 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LouQCAfv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVQ8bqgp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E22FE566
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699194; cv=none; b=ZvtigjmN6NrZRDiO8hMD7WKlcO9afEZU4bwj2wCI7+3fk9jchf6liGNzcWRh+mxL6QoNdhEUS+yo2uSZCdRTAMSCSablgVCnnXqTfrWLnrXHwPyIJuq0sRWu2f9hsL11MBJ5NE1EQqK1qNj4eI1xeJoW/0fQJHoo/R9df0qWhwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699194; c=relaxed/simple;
	bh=0DTO16A80WGqaz3z0hmwtkj7NXigq+2LLdiQNk+Q8ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uz1sZZcdxlPdA7p93TxVvn51HKnmlVBx/HdNcpLYZE46jkZv1ROzRS6IepobIeAYmV7OhNRLsSRP9lTsguDObWYHASMkk6ETPKv7kcZYXVj1NoB2lrKlofiSr3QH8Sx/1xVCK7cJjphjQ8rOJxwi4yViQu3H2fGq4wlKgbMENqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LouQCAfv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVQ8bqgp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9EVncI834250
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XptDc+YZFL8JqGr8hCEtPLAIPxbU2ERemzFyFeabLdI=; b=LouQCAfvJVsviDRk
	e4CY4qK42rhnC0FvsyR2Cy/0F5qmsBpki4Fqpd6Ilw3/karaAt+lzYTtsXLMiboY
	mGuBD20b1cO+uOCgAHGusvJJrjG69B990iYgFvyDpMKUHe6a5FNkPzQaoR3YQkt5
	E8Ffsahc1ecGoxpaiRw5CeSIuKs0Gdc9lgbNmxMnxMw2reAGoHQd66xTG0qrQI/Z
	F2fG3D/j4eD7tt/NfXvMq1u677K6Wo6lfeTiNyC5f0Lnht90N9oMjp0w9kbMurth
	m3ojc9ApXLNT4xSsyoZE38iKk47TJ2O/HR7iwTLi8vlqtYG0KvhnKRAHtnw00VfK
	dagjPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu2t84c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:39:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3416dc5752aso5720614a91.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699190; x=1763303990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XptDc+YZFL8JqGr8hCEtPLAIPxbU2ERemzFyFeabLdI=;
        b=JVQ8bqgpSRlZ4k5zw1QUKvz9n+S3uGkAhfmMlpCAxhaFytUaT1T3dHAeF4ZCgXMo4l
         yWdnmvo+rx5PWU+f4kkLROG4LBzokJZLJX5lphv9pjBMBLvvNHD9ZpJVxxTkP/zRi7KA
         94IWDcbI+TiGBeuwobuahrmk2lhW5pVr3mVfDKG7IVi5REiN1900X5DKkPVvXa9Hmx9K
         yTL8kzkmv6h+JvPH9NiClrQni12a3UTqeIJUNGY2MPU/ssTsuLNHEOOeQ+AXlObMZx+Q
         e6dEZc6d48SfRPm2IEu9gL7FOouO8b+nvs0ec/fARj4ZNcYzt4Qy4AjDheCB1PL1ucpC
         0USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699190; x=1763303990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XptDc+YZFL8JqGr8hCEtPLAIPxbU2ERemzFyFeabLdI=;
        b=QhyCpEJj+ozjDmLYQEJuXZeVm5TG7h2gTJXY+FNCDjMcv7EYzD3Cq2O4LX7sHXtSWH
         EEctecgKuT5jQIHaWYcK9HjE9fUhcM8LIVumiL5UddhAY5bup8evQrFJR7JK8IO7X46n
         0cbqo7hE/pQZQrJXsHhMqL56+UGb1JJHh+qpW6YJSVwuCu0sUzA0d+zHpaT+UqcJPKAc
         b3VG4Oabrvfvc9jFhTdYOYXf3Sc1IrckvuwMxm5HYX0Oo1JHAtQsqgV5QY7MifunW0FS
         r+bbvEj6+nr5dHyPLoNeENPI/dxRyz2yhRu56ku02IGtS09GH+VlquoAWmB/sqSNyh/t
         oEYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1IY4L/BzK+Q7i8E04j+DhftswU/X4p0zwuOQeQqg0JkeIyetXJAg/HoimARghY0n37SYKqQB1Ew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vZdY+X87OD+9W98TrJO2wSpi456tub7CNoktYePky4kpPd1J
	uWehCsU2deQBe9FqmRbPHkcQQ+6F9m6S3D2Llq9jCZMqbklgrkRzvtEhmgxLzq6IUMfSBFb6uF/
	SOJqtzgqokH307xisgtTkCOgDqNuKkeSv7WkKFMHXi+6zW5R6ckiFh4sIlaBYqg==
X-Gm-Gg: ASbGncsTWNkuPVN8iyeHx5G0NIYUY400bpCRQ+g+VP5TL83tuLl+liwI9nHi1/252Lg
	9Nv0dtjz+KtUe/n9kh4rt1nfoMOi2zqf5XshjFgSZOjh+J4khcgHGNemXngQyUurxiTjwJz1V1R
	urjKI1gscDugAIZBX8bTLPceZZrS59+gLogO5BZ3R2f1PxFlQEoYxI8lSTrDzRQgtJnpkPDuxXk
	cjz0p/N4rr4FRcexIBoQzvDlmnnnEDcVYURUfU2i0QmbApVjAuVcCf+hHAvsUagrCv65YarJXdq
	wgZ3MdTyIdGLG9FI8CBIKfw/oHh9F/qYfPBWfsBp9oPgNMU/d9+qZ+X5d+i145JNBGjRdStrJeX
	vClh1Kwexusnd5VbuO663vJFLJ7ca1f6ES20=
X-Received: by 2002:a17:90b:254b:b0:341:88c1:6a7d with SMTP id 98e67ed59e1d1-3436cbb3db9mr5858490a91.18.1762699189605;
        Sun, 09 Nov 2025 06:39:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOq2jGoZdaGTg/RuLpVGRCaTMc0nO8pbXIWYTS2/MK7JSUVoJbW0TcdZDyaG0BSL/En7Uqvg==
X-Received: by 2002:a17:90b:254b:b0:341:88c1:6a7d with SMTP id 98e67ed59e1d1-3436cbb3db9mr5858477a91.18.1762699189136;
        Sun, 09 Nov 2025 06:39:49 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:39:48 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:25 +0530
Subject: [PATCH v17 12/12] arm64: dts: qcom: talos: Add PSCI SYSTEM_RESET2
 types
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-12-46e085bca4cc@oss.qualcomm.com>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
In-Reply-To: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
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
        Xin Liu <xin.liu@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=1067;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=0DTO16A80WGqaz3z0hmwtkj7NXigq+2LLdiQNk+Q8ls=;
 b=tP463FsuDoN9+kJtN2MV9dK0Lk1uV0U1Hzq/yfzIbjg8ificPJU+/kUUPfp6nFtHl03InJtGh
 9VS6Mie4djKAilbj5ymty9l4y4D5eBAcfYCHZhg23+5Kh3vudrPO9iG
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=dMWrWeZb c=1 sm=1 tr=0 ts=6910a7b6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=4cuBwC7xTQKafrdxVH8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AaFHnOdQLnufDTIt7q1RZjC9TPTr3djG
X-Proofpoint-ORIG-GUID: AaFHnOdQLnufDTIt7q1RZjC9TPTr3djG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX9ifziuci3wUE
 lJm9fbtcCPbKS4QRSIGPctCJaRdB1azCIZPQpxUJBPhNtdY75SIUWZVCT0KdH/5b8iZiznrgiD2
 AsoyxkFmZM0k1dJQ1eBGcbN9x/aETn8PkXaDvEgSioGsIuopP2lV3pEjx9hJZePynCFU6APfdiS
 Ee/CvOMJ4F0H/7BQuLehALrrzLALc1wa6JgkbHpj0x2psgIrZslcwFcFFPqgH37FdiseAK37yvm
 4SrAgdX9plMZaOowycawOZlRu5pS1izZ+zRU81O9RG2ukfIFXCVKEc4gjzpPx3GsqUqRvJ/5VL2
 3UJ0+l46CrGS9DQdVraJTvB0MfCbaEXiMb5D99ejL/aukAuNmd5lOtjxl+VmUlctht61vnFiyLs
 1n/ruOGVNr0k1fs0MV2lwnGX7jmtxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

Add support for SYSTEM_RESET2 vendor-specific resets as
reboot-modes in the psci node.  Describe the resets: "bootloader"
will cause device to reboot and stop in the bootloader's fastboot
mode.  "edl" will cause device to reboot into "emergency download
mode", which permits loading images via the Firehose protocol.

Signed-off-by: Song Xue <quic_songxue@quicinc.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/talos.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
index eb6f69be4a82ea47486f5c8e39519d0952b146cb..c946d07c540f5ae40f147ccb06539ecf0de18df5 100644
--- a/arch/arm64/boot/dts/qcom/talos.dtsi
+++ b/arch/arm64/boot/dts/qcom/talos.dtsi
@@ -612,6 +612,11 @@ cluster_pd: power-domain-cluster {
 					      &cluster_sleep_1
 					      &cluster_sleep_2>;
 		};
+
+		reboot-mode {
+			mode-bootloader = <0x10001 0x2>;
+			mode-edl = <0 0x1>;
+		};
 	};
 
 	reserved-memory {

-- 
2.34.1


