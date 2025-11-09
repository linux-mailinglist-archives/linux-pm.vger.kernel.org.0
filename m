Return-Path: <linux-pm+bounces-37685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F0C440AC
	for <lists+linux-pm@lfdr.de>; Sun, 09 Nov 2025 15:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C46B347332
	for <lists+linux-pm@lfdr.de>; Sun,  9 Nov 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694892FF668;
	Sun,  9 Nov 2025 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O/U/5VgC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKeOnd0F"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA92FE592
	for <linux-pm@vger.kernel.org>; Sun,  9 Nov 2025 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762699140; cv=none; b=bZ441B2g0shEIel5BNPdWf5uZibecDQrZIb5tDudI/MCwpfibnWowZDe2HYWmJPyEYvX2RZdXoxpUl7jDVFC68bdIbT1v2ScBhOZt1RZLWKMJ1Y3CWgODSosSkJilYMYrHyCC69zX0RID6ZNDqpsqLk+aikVZsOOzDKo8i0T8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762699140; c=relaxed/simple;
	bh=lD7kEuHLtxPB5/pfzwbQqcQgB967yAINPlEeVv9qg4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fgG5QF/CRXW6AEWl25PBM1/lZI6XtscaIrvOh69gvXZhwUKpLjUWm48TCPW/6tUtgi4bZ7BgT3OZLXjZJLc32hIPrP1vC+9Ev3GUjb1tI9xyKr3K2aRfvTFUmfS05Ursbasgq7B/WLGZT2Gd7iEcRV/AVooiXdR4VHqu1xmNW5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O/U/5VgC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKeOnd0F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9CxFeW633167
	for <linux-pm@vger.kernel.org>; Sun, 9 Nov 2025 14:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ITVJjoF8oZpX6CH3gig4SV3VeFTPVCOpuJTI/Zh540c=; b=O/U/5VgCt0tVUGhi
	1sTWsd8rg5gNFsb9YQ14KZGzk3An53UKweDTPlyyUGLwufyg6TAHWhCZ9t9ZzGgt
	rR2F6stJbxw/f0Trw2JuSHnXs2HwzKeO0l/CdTSLRKqeWptBDL9KaxJZ7EaBwlEH
	nvel7fBlaBbi8jhX3t3JPGpdZ2/JWB7FiNQHX/dru4O+kuRYUp8E/00i+NpL1yDk
	p5lOReIsheP0BPveaff9CQyU3Noof+MNQ6pmpuAGu6JsOj1JQ3z2WAMmVBkemyYP
	vV5LXSvDB2eg2jvIoAx2wkrgSXPLtKcGzse9Bks9iPCqlZKLEw0OhBEijK5fBbyc
	mRwVcA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aaue0g3em-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 14:38:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297ddb3c707so13113975ad.2
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2025 06:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762699136; x=1763303936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITVJjoF8oZpX6CH3gig4SV3VeFTPVCOpuJTI/Zh540c=;
        b=MKeOnd0FOg8YEHDp2sqvCj4uVpXeEmb1auM44vad0//gKaEdxXSeCNO7Ky7Ob2CoWu
         OOKrO3PYXIooSRmjtZWcf7oaVIl3YB0fEzKm43R0EEU3j1zw8ZfnPSIajAVTF+OtFpgF
         AhUb9J4A5lM8G0+o/Krc1IB4TTspBdXZEwadvMVQ9ZYqgy8NG+8Hvp7zm+oiI0v+bi6C
         kvgxDmSdw+hLERTZ5zeUHPDgjIEnZDaDAQkW3l0r6l1Aj7qsd9qixlQY2kvKNEmOYpkB
         h2qJhYgtdvBb3o6OKqeU+62KWf49VdJkJlRTl3lPlwLpjW9dX1deRD6fvpTOvAXt+nlP
         HMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762699136; x=1763303936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ITVJjoF8oZpX6CH3gig4SV3VeFTPVCOpuJTI/Zh540c=;
        b=bmuMP9dh8G5jbbSzbN7G7oXsw53S1gckh84m4W+do1DkW3ncASNz2sNGb0KFLnKRaC
         VRS9LVr9xP7oVUtvp4m4U6TN0qpzrFN/cVzRVK3FmrycdVuEnGS9zR6SiNNEYuWgvhnY
         uWxaSjllIdmkXC4YBJqt+CtHZt+BtUpHOyBwgbm8txaiDoUeFWkN0BzMSkWC94Wa+NFf
         KYu5BGMC9eU0FQKThpVb9tjqIIC7pjEOleVRTW6xG2E51lwJfbiT75ndMYEhenop3mK0
         DDy7GqbaLmjr4WnIoPGse+fMDyW9qieSKpeOxLkSC4PTLvxZvMk37LdoMTtGYX7bz0f6
         1Pyg==
X-Forwarded-Encrypted: i=1; AJvYcCUR6ZB9iCT7bFYqQ6RvxKsXrWp4A7Q63vJkWFb5pCn2n5G2elHOampAOrVxLXTIUief42Kv4KlddQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvuGVPF2KLFkKLYwvMdEj/hrsoTO7PfovWwZsqrM4ujDevozzV
	NzziA1anAjV52lF2sPV9K3T1Qsiu7FM2MCRCUimBoh8cHxrAseYO6dKiK8Aks6058RdPIVTESo/
	hW+XlubufsUJAGipmwohMDwL8F5LOQQpCbB/KVtGSUn1MkGVEzGbHVye4V5vWdA==
X-Gm-Gg: ASbGncuIfSdhoyidjoY6E0yAyubCXSFpZmaMclkD8VqylE/jkOZD5B65SvWS8oWgLvR
	3PHATQrrLwYrRFWxMHURWM6aLNsqoobFoUit8c3MNCGymryvtK6ZDLfsewTH9XKc6jsb576yIcW
	/xT7PB3jIwD8KsiGm+b7Db/Cm5ae5aGiNfWAWK7i5s2l+nleFgDcyy+0sKN6aWzLRvIuXknoqkP
	MFY9HPkYGWhSjXdFu6+e7xjCoYXrGZSqL5iFTwdFEDoBbO5oRUqSvXnssGFncSL0jFTy3N+Sxxe
	bTboIv/XDM3OPwGDCbWtOSEThbrNYmMx1m1UirouKv3XOmuo3w+d9U8WJzUsX10NFFYhG5IJ6Xf
	ABRs5Hxcs7qHPDs3n9+uTHmjAHdJvMNIV070=
X-Received: by 2002:a17:902:dace:b0:276:d3e:6844 with SMTP id d9443c01a7336-297e56d88bdmr63591465ad.33.1762699136492;
        Sun, 09 Nov 2025 06:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3UK3IxssuAt8f6Uf5qJF5IzeFnxGusDT91RpZ+I9igX3d1o15ZrL5lOOJz8dXAPHVZHqHFA==
X-Received: by 2002:a17:902:dace:b0:276:d3e:6844 with SMTP id d9443c01a7336-297e56d88bdmr63591025ad.33.1762699135919;
        Sun, 09 Nov 2025 06:38:55 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68a68e6sm14845401a91.4.2025.11.09.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:38:55 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 20:07:19 +0530
Subject: [PATCH v17 06/12] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-arm-psci-system_reset2-vendor-reboots-v17-6-46e085bca4cc@oss.qualcomm.com>
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
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762699073; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=NXUaK0H1266YWuSrue+BtWJ+iZQFKGg3Cd3Y8xvw8yY=;
 b=IBO1GIE/u618IwCGMuCa43qSii19KTQHEGwFzpPwYdrhllUCpnl1RodmdS6Jqito7Taa7pZ2j
 zMh4i8pdHxiACinhu7JfTus6mkQ6xs8ZVE6UrCP7Mrbw3Zehfpdh1i/
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: qNOZd_vzIc9gGS3J9twmdZkEFormeQzI
X-Authority-Analysis: v=2.4 cv=BfDVE7t2 c=1 sm=1 tr=0 ts=6910a781 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: qNOZd_vzIc9gGS3J9twmdZkEFormeQzI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDEyOSBTYWx0ZWRfX1MquwSAZAe4i
 Uo6fmsm5NEwP8hD5CgX+gcYXO1cNsqRUZ4cvBTie9CG+nMYp5A2Uha8jQqDOmXGzhVXGx/PE0KV
 L6LX22OXTpi/pw6VmNIJYsWL5VipgqbcN5+ZxH01lkvtt+bmm99z85NigXESMGXP/PybCHc2rZp
 lgSxD8VdSRPTFaAPG7O6nkCeM6uFV9qL2n9nIzwgG2LLC5JTSLkxEPwlJ6qq48/DYVO3gMdoAug
 aTJQJ3Yqph7mTCJg9hgLO8Mdz+L2LS9SswgnPYlcT0Nb3IIVKMgnmtsBp1jI88XARVRDwKWpzJV
 E0LpVb2F0PhOGraaaR1l6RzNbBR0io+5vmQSO7/Qplgf9h4/8sDEUa0xQA+yRt6CzQ7BDJcwk+u
 MZdScC7navQ9l04DF3gb2BDTIwp/7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_06,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090129

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 6e2e0c551841111fbb0aa8c0951dca411b94035c..5d4368d77d07e3340bb380df93aae31df40e2779 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,27 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 1
+        maxItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx
+          is the name of the magic reboot mode, type is the lower 31 bits
+          of the reset_type, and, optionally, the cookie value. If the cookie
+          is not provided, it is defaulted to zero.
+          The 31st bit (vendor-resets) will be implicitly set by the driver.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +158,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -260,4 +290,17 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reboot-mode {
+        mode-edl = <0>;
+        mode-bootloader = <1 2>;
+      };
+    };
 ...

-- 
2.34.1


