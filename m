Return-Path: <linux-pm+bounces-39985-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B79CE5380
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04E3E3004C9D
	for <lists+linux-pm@lfdr.de>; Sun, 28 Dec 2025 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DA01EFF93;
	Sun, 28 Dec 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gV/ovo0E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RT8LslmP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E413A3ED
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766942438; cv=none; b=dvnCRXzXQ5tX0mFADSeTXw/Rhz3x/GVJwSgFtZ6xnYVFuSI5LYc1f/Wqy9R9WFEriA1W2IzNyN/QNIyiVyyPDgcS4RZwlbi6j71uQ+AiX7/j1dEwn2sTWqENHsN1yCKwgThvTTY3v8Z7U2bgpGw64Z0VdZK2gEIYADb1KiWiG9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766942438; c=relaxed/simple;
	bh=Ttfimu4h1cuyBplYI6KZjSbBH25h/Xr/9ABhktJGti4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FpllUYY/5xrX+rHGSue7ZFwvNlwcyIaGY9LhkKSLPYefoM0b+5tUd2XXzt6bIkDGyyBDnoXuNsffzeJgT0Y92dMxR1EE4CXb0xtheZHtbVIWtkq9XGgueRTcmmzYT22ynXv2jSMjHEQaJ9fIV/MY9mZO6gCz/VvV4AqPUl5ecqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gV/ovo0E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RT8LslmP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSHBqc92571261
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=f9pmMQaQxz6kiyMw6rVEO/
	kXmYUxjzPGCxcPHB8w8oI=; b=gV/ovo0EJq02x+kyWxpK37OIb1BOGvGS7d+bjS
	Mvl0zbDsoUD3F++DMs5jkkW1vXjuCNnqHtGJf1aQaqTo1moqixF7p4GkCu8XlTL5
	WesXR43MgaWZK6TWhsC+GCWVdUMxTa+FC8LBoIVquGmYyQckIy4Nn9zRKBi5fSVH
	KHq88dUjgfGsmy2Dgkq8glg/0ROgi8WgQ3qR/LKkXvgVGEu+jFAxMmbf2Ki9uGiI
	+El6deK815YLNbCWU0gIB1qFUGzZA/BaKSicncvGPxLSLVxgzZl4OYJYnR4lUuO9
	lHE3jrmzgS+idP/Nkx4awvGKIeTZX6bKM7ROvHKeJMi5DPnA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba8r6adhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 17:20:35 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0c495fc7aso126270865ad.3
        for <linux-pm@vger.kernel.org>; Sun, 28 Dec 2025 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766942435; x=1767547235; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9pmMQaQxz6kiyMw6rVEO/kXmYUxjzPGCxcPHB8w8oI=;
        b=RT8LslmPXqXVCdt0NoD8Y5b2ee6+UI1qS+ukc+GT5Vokw+larH2gjJlq3X9reussSs
         1yBhGIJwr0b5LLjrjxvQC/c0/y9ueSh4Fpnzh10sZXv5hfpmO8L80DQJ+QRazF/IGB2V
         MxhpewbzQkD1qJRBG5YB7e1xO8DchfE8FxXRgXc9yNlklGLe4lDAy+JyCOiz1D82oGNG
         /BkgVVutEyjsvX01bYShiCs2rHBIUKjn/8J65EIWaGR6Y0STIuBSXH2dsWGhxn3st/RM
         HErEaOFf4SAQXVkoLF85DUGvJtLlii976jlfXjL8tSgJCXQzp9cQomqkJmY17svHPB19
         8L8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766942435; x=1767547235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9pmMQaQxz6kiyMw6rVEO/kXmYUxjzPGCxcPHB8w8oI=;
        b=o9tf22tDlJjEqlnCh20l8GS8j/Qkz9CaS2O1LaeEUukBNnA07tx9xKJAwclLQlE6K7
         h6QUE7PpslHyi1829wT/NTGUnph0DD3PDoG6uGkc5T+cR2AsMeRRzMa64v+XqoPGy5Tu
         eJV9E7y98a7So3Ptb0Wm44rs8aYNlYpAGQMN5rSQeQNFQ6uEOGhB5bxPPc1mXI5Z/dwQ
         D3BrMrNlQUsBZ37hIcqVtajyt1A60Q/3Ntd7cyxPPIaUgxvjzbNI5vWUFmfz4KR7f8Jk
         XXeT/fjRvtYJalzM2l0kWVlikeZGYwSa7Ju+TjgH2GuId7MTDmxkako00hKlNDLfTtP3
         ebXw==
X-Forwarded-Encrypted: i=1; AJvYcCVX5jXN8p/BKFHNipUgTUGwAXQ1zJhsmC0xcX5WGlzZ4lshq404BZamJZ7A3PaFrPNgUjPJM1P9kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkri6M0lEVrasKqipNBOfwufEnLj+RYlRbgF9i69Td3RqmG2mQ
	LlG1wMNkRUymcBvqZBc2lNhmKyKv2tjqVi6SplMsPxl+q+wFTHz0uSAzUG0dzx7vZlwpDLx+khY
	04z7WhG8ST8+W12Xu4yqtr67s22J6dUt59yXdH2nohnrbZeaYT8zBCgxBDaWDTQ==
X-Gm-Gg: AY/fxX6wWWhEVk9A221rdQ7iVs5+foYrXA/82UiWMIjq0SvBwWTwwndK58kzZkNhulW
	D645RPARiJL+lSo95Z1zU3YU9TwoZB11nuYk3jKkY9II+3xC11k+VzC5mke0nbFfsWoN7i91Lxw
	ZQnnegeJmIizXM9gjsxAKM6Ijf9Gv85IpUkF6W8TH4xOJgXX6snLiE+SK7W5VZc/8x+thOW36ku
	V/pLK8fBL0F4xiIvxAQAas/PmhMrVHkfv3XMhgSBKyU5yUkRqIVrQTy6Tiyil+LdQqwq+jKjRaX
	2hi11foI2YnMeRxnTJrRe67U3ozTAoym6tnnufjH4Kdq2JAx5TzjXvHwVFbXttl7MpeJzgB4oPb
	ez/s+D2qjS/PFNFPXL8GkStjRGxSA9jMkD81vmBXaspxnzA==
X-Received: by 2002:a17:902:e849:b0:2a2:bff6:42ef with SMTP id d9443c01a7336-2a2f2202e4cmr334962985ad.7.1766942434621;
        Sun, 28 Dec 2025 09:20:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5oyeK+K15P8m8OEMXA716k+xD/zT30+xJOBKjj/gv60zCDbt7KoTPB+C4AOE9qDaltY/YhQ==
X-Received: by 2002:a17:902:e849:b0:2a2:bff6:42ef with SMTP id d9443c01a7336-2a2f2202e4cmr334962765ad.7.1766942433976;
        Sun, 28 Dec 2025 09:20:33 -0800 (PST)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d776ebsm255743965ad.99.2025.12.28.09.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:20:33 -0800 (PST)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Subject: [PATCH v19 00/10] Implement PSCI reboot mode driver for PSCI
 resets
Date: Sun, 28 Dec 2025 22:50:18 +0530
Message-Id: <20251228-arm-psci-system_reset2-vendor-reboots-v19-0-ebb956053098@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANJmUWkC/53T3WrDIBQH8FcpuZ5FjyYed7X3GGP4cVwDa9NpF
 lZK332mjKWwBdxuhCP4+x/leG4ypZ5yc785N4mmPvfDoRTC3G0av7OHF2J9KBsNcGi55obZtGf
 H7HuWT3mk/XOiTCOwiQ5hSCyRG4YxM9V55FwpG31sinVMFPuPa9DjU6l3fR6HdLrmToLP218Rg
 ldGlGOMM9JaSY1SBuUfhpy3b+/21Q/7/bYsc/K/VAdBOkRwhO1Pdb7AJMRt07qaF4UPURI4ECi
 9XOPhhgdRzUPhUTvrJXkFQGu8vOXru5eF7xwGkFK0aHCNVwuPoq3mVeGlDmBia6w3do1vF94AV
 PNt4bUnaTmixijW+O6bF/wP3Xfz5Bi0FKwFSatvrxdeVP+ocqzwqiOOrfNWeb/G48IDyGoe57e
 HaA3pjuKvg3m5XD4BRvIlmzIEAAA=
X-Change-ID: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
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
        Srinivas Kandagatla <srini@kernel.org>,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766942426; l=16416;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ttfimu4h1cuyBplYI6KZjSbBH25h/Xr/9ABhktJGti4=;
 b=kpfm3MX8Ye4ulJkuxJFy0a0i3tCR1kAd2MiBGQRvdp2m2rdsLNP5Y9tt9l74vX1UnjTPQYATx
 J9/KSUiEo3+DCVcgPQgzdAqSrs+fX9TlyZihdwPBAleLy03cJyMJtnc
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=Raidyltv c=1 sm=1 tr=0 ts=695166e3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=L5iJcrboxw6gPMw248gA:9 a=eiR0ridJsEDSdhW8:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: oZl5_MrKyeirdNO0sxQ8DkziQIUjG8B6
X-Proofpoint-GUID: oZl5_MrKyeirdNO0sxQ8DkziQIUjG8B6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1OSBTYWx0ZWRfX+vrTPOGAjnht
 3//9c3Af8YLOn8GbrOEB7l3PzwGP4DV37cxIxO55S166zWUmMBZTIw2HgeYz3vF3mphHZFDGgO7
 uNZjw+GqItHJfpoqK7s4z6rO2gsuTwuPYcgDZOcHH7vb+2FHm/aukJrbhqn0GwnebEzrkvLZxgx
 iYKoO+HNVgv0H2a5kW0HkIIk7rOgFjBYU74hv5EhHpS76ianpjvQHZt+KxcXDHfan7FiVIz+MIK
 TCTaKXi24Qb1jfU1ZqclyOFN0DyHJzEXzvkg6DnOrlt5xtO15x1+ENlVPjiajbK0lvjRoaDRBld
 axnFWMFVjZDDJfWBf/5AYnBEtM44fqbfX0dHKsNKMcU1dauLI4mewaa8VCaZ/I9VsOMufPuGqz+
 YiU43z/feGfHEGVK8zgmwgybZsSMej+jEU9LCpgWETaMqUOJSXmprNGK5PjQOVzx4wRyPzeGbaK
 P8VDnU+YpL4aZc6pT4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280159

Userspace should be able to initiate device reboots using the various
PSCI SYSTEM_RESET and SYSTEM_RESET2 types defined by PSCI spec. This
patch series introduces psci-reboot-mode driver that registers with
reboot-mode framework to provide this functionality.

The PSCI system reset calls takes two arguments: reset_type and cookie.
It defines predefined reset types, such as warm and cold reset, and
vendor-specific reset types which are SoC vendor specific. To support
these requirements, the reboot-mode framework is enhanced in two key
ways:
1. 64-bit magic support: Extend reboot-mode to handle two 32-bit
arguments (reset_type and cookie) by encoding them into a single 64-bit
magic value.
2. Predefined modes: Add support for predefined reboot modes in the
framework.

With these enhancements, the patch series enables:
 - Warm reset and cold reset as predefined reboot modes.
 - Vendor-specific resets exposed as tunables, configurable via the
   SoC-specific device tree.

Together, these changes allow userspace to trigger all above PSCI resets
from userspace.

Currently three drivers register with reboot-mode framework -
syscon-reboot-mode, nvmem-reboot-mode and qcom-pon. Consolidated
list of commands currently added across various vendor DTs:
 mode-loader
 mode-normal
 mode-bootloader
 mode-charge
 mode-fastboot
 mode-reboot-ab-update
 mode-recovery
 mode-rescue
 mode-shutdown-thermal
 mode-shutdown-thermal-battery

On gs101 we also pass kernel-generated modes from kernel_restart()
or panic(), specifically DM verity's 'dm-verity device corrupted':
	mode-dm-verity-device-corrupted = <0x50>;

- thanks Andre' for providing this.

Detailed list of commands being used by syscon-reboot-mode:
    arm64/boot/dts/exynos/exynosautov9.dtsi:
	mode-bootloader = <EXYNOSAUTOV9_BOOT_BOOTLOADER>;
	mode-fastboot = <EXYNOSAUTOV9_BOOT_FASTBOOT>;
	mode-recovery = <EXYNOSAUTOV9_BOOT_RECOVERY>;

    arm64/boot/dts/exynos/google/gs101.dtsi:
    	mode-bootloader = <0xfc>;
    	mode-charge = <0x0a>;
    	mode-fastboot = <0xfa>;
    	mode-reboot-ab-update = <0x52>;
    	mode-recovery = <0xff>;
    	mode-rescue = <0xf9>;
    	mode-shutdown-thermal = <0x51>;
    	mode-shutdown-thermal-battery = <0x51>;

    arm64/boot/dts/hisilicon/hi3660-hikey960.dts:
    	mode-normal = <0x77665501>;
    	mode-bootloader = <0x77665500>;
    	mode-recovery = <0x77665502>;

    arm64/boot/dts/hisilicon/hi6220-hikey.dts:
    	mode-normal = <0x77665501>;
    	mode-bootloader = <0x77665500>;
    	mode-recovery = <0x77665502>;

    arm64/boot/dts/rockchip/px30.dtsi:
    	mode-bootloader = <BOOT_BL_DOWNLOAD>;
    	mode-fastboot = <BOOT_FASTBOOT>;
    	mode-loader = <BOOT_BL_DOWNLOAD>;
    	mode-normal = <BOOT_NORMAL>;
    	mode-recovery = <BOOT_RECOVERY>;

    arm64/boot/dts/rockchip/rk3308.dtsi:
    	mode-bootloader = <BOOT_BL_DOWNLOAD>;
    	mode-loader = <BOOT_BL_DOWNLOAD>;
    	mode-normal = <BOOT_NORMAL>;
    	mode-recovery = <BOOT_RECOVERY>;
    	mode-fastboot = <BOOT_FASTBOOT>;

    arm64/boot/dts/rockchip/rk3566-lckfb-tspi.dts:
    	mode-normal = <BOOT_NORMAL>;
    	mode-loader = <BOOT_BL_DOWNLOAD>;
			mode-recovery = <BOOT_RECOVERY>;
			mode-bootloader = <BOOT_FASTBOOT>;

Detailed list of commands being used by nvmem-reboot-mode:
    arm64/boot/dts/qcom/pmXXXX.dtsi:(multiple qcom DTs)
			mode-recovery = <0x01>;
			mode-bootloader = <0x02>;

The patch is tested on rb3Gen2, lemans-ride, lemans-evk, monaco-ride,
qcs615-ride.

@Florian/@Kathiravan, Please note that reset_type in DT needs to be
full in itself with 31st bit set. (eg: 0x80000000).

PS: As advised from Lorenzo, "PSCI maintainers should be added as
maintainers for psci-reboot-mode".

Previous discussions around SYSTEM_RESET2:
- https://lore.kernel.org/lkml/20230724223057.1208122-2-quic_eberman@quicinc.com/T/
- https://lore.kernel.org/all/4a679542-b48d-7e11-f33a-63535a5c68cb@quicinc.com/

Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Changes in v19:
- Add missing To/Cc entries (include devicetree list) – Thanks to
  Krzysztof for pointing this out.
- Fix compilation error in reboot-mode.c for ARCH=powerpc by explicitly
  including <linux/slab.h>.
- Link to v18: https://lore.kernel.org/r/20251223-arm-psci-system_reset2-vendor-reboots-v18-0-32fa9e76efc3@oss.qualcomm.com

Changes in v18:
 power: reset: reboot-mode: Remove devres based allocations
 - Update commit text for alignment. – Bart
 - Read magic before assigning kzalloc(info) in reboot_mode_register. - Mukesh
 - Update error handling path. - Mukesh
By Bjorn
 - Expose sysfs for reboot-mode bisected to different series-
   Link: https://lore.kernel.org/all/20251222-next-15nov_expose_sysfs-v21-0-244614135fd8@oss.qualcomm.com/
By Bjorn/Lorenzo/Mukesh
  power: reset: reboot-mode: Add support for 64 bit magic
  - Use FIELD_GET/FIELD_PREP for u64 magic wherever required.
  - Update commit text and add documentation for structure of 64 bit magic.
By Lorenzo
 - Remove direct reboot-mode registration by psci driver.
 - Add support for predefined reboot modes in reboot-mode framework.
 - Add psci-reboot-mode driver and implement a psci-resets to accommodate
   all psci-resets including warm, cold and customizable vendor-resets.
By Bjorn
 - Update DT patches for qcm6490, lemans, monaco and tolos.
  - Update commit text to include more details – By Bjorn
For Alignment
 - dt-bindings: arm: Document reboot mode magic
   - Update reboot mode documentation to clarify that argument1 should provide
     full value of reset_type along with the 31st bit wherever required.
 - DT patches for qcm6490, lemans, monaco and tolos.
   - Provide full value of reset_type including 31st bit.(eg:0x80000001).
- Link to v17: https://lore.kernel.org/r/20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com

Changes in v17:
 Remove the patch to synchronize list traversal - Bjorn
 power: reset: reboot-mode: Remove devres based allocations
   - Remove devres based allocations as a fix   - Bartosz
 power: reset: reboot-mode: Expose sysfs for registered reboot_modes
   - remove devres based allocations in create_reboot_mode_device
     and manually free resources on failure.    - Bartosz
   - Add driver data while creating reboot device and
     retrive the same in reboot_mode_show.      - Bartosz
   - Remove the mutex lock.
 firmware: psci: Implement vendor-specific resets as reboot-mode
   - Call put_device(np) once processing is complete - Pavan Kondeti
 Move reboot-mode to SOC DT wherever applicable - Mukesh Ojha
- Link to v16: https://lore.kernel.org/r/20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com

Changes in v16:
 firmware: psci: Implement vendor-specific resets as reboot-mode
  - Use GENMASK(31, 0) instead of 0xffffffff - by Kathiravan
- Link to v15: https://lore.kernel.org/r/20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com

Changes in v15:
By Sebastian:
  power: reset: reboot-mode: Synchronize list traversal
   - Change mutex locking to scoped_guard() and a Fixes: tag
  power: reset: reboot-mode: Add device tree node-based registration
   - Change reboot_mode_register external call to use fwnode
  power: reset: reboot-mode: Expose sysfs for registered reboot_modes
   - Use sysfs_emit_at for printing sysfs entries
   - Add driver_name to struct reboot_mode_driver instead of passing
     as argument
   - Update reboot_mode_register, devm_reboot_mode_register and
     create_reboot_mode_device for same.
  firmware: psci: Implement vendor-specific resets as reboot-mode
   - Update psci to use updated reboot_mode_register and store driver_name
     to struct reboot_mode_driver
- Add DT nodes for PSCI SYSTEM_RESET2 types for lemans-evk, qcs8300-ride,
  monaco-evk and qcs615-ride boards.
- Link to v14: https://lore.kernel.org/r/20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com

Changes in v14:
- mode-dm-verity-device-corrupted documented in cover letter -by André
 ABI Documentation:
- Updated KernelVersion in ABI documentation to reflect base commit
  version. – by André
- Revised ABI documentation to clarify space-separated format for
  supported reboot-mode commands. – by André
 power: reset: reboot-mode: Expose sysfs patch
- Modified `show_modes` to output a space-separated list of supported
  reboot modes – by André
- Added error handling in `create_reboot_mode_device()` to ensure
  proper cleanup on failure.
 firmware: psci:
- Locate psci/reboot-mode node using psci compatible. - by Krzysztof,
  Dmitry, Sudeep.
- Added error handling for additional code for compatible.
- Converted hex values to lowercase for consistency. – by André
- Introduced panic notifier to disable valid vendor-reset flag in
  panic path. – by André
- Added check for `psci_system_reset2` before registering vendor reset
  commands.
- Updated Commit text.
 dts: sa8775p:
- DT file name changed from sa8775p to lemans and commit text updated
  accordingly. – for dt renaming in base commit (sa8775p to lemans).
- Link to v13: https://lore.kernel.org/r/20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com

Changes in v13:
- Split patch1 into two (Synchronize list traversal and DT node-based
  registration) - by Dmitry.
- Move mutex lock inside get_reboot_mode_magic - by Dmitry.
- Reorder the patches – pull patch8 for exposing reboot-mode sysfs before
  psci patch - to align the change in reboot-mode sysfs patch.
- Update patch- reboot-mode: Expose sysfs for registered reboot_modes
     - Introduce a driver_name in reboot_mode_register. This will be used
       in sysfs creation  -  by Arnd.
     - Update documentation and commit text for above.
     - Fix release function to properly call delete attr file.
     - Fix sparse warning for devres_find.
     - Add error handling for devres_find.
- Split ABI documentation as a separate patch and update ABI documentation
  for usage of driver-name in sysfs - by Arnd
- Update patch - psci: Implement vendor-specific resets as reboot-mode
     - Fix Kconfig for CONFIG related warning.
     - Add driver_name as "psci" in register call to reboot-mode - by Arnd
- Link to v12: https://lore.kernel.org/r/20250721-arm-psci-system_reset2-vendor-reboots-v12-0-87bac3ec422e@oss.qualcomm.com

Changes in v12:
- Added lock for list traversals in reboot-mode - by Dmitry.
- Added proper handling for BE and LE cases in reboot-mode - by Dmitry.
- Removed type casting for u64 to u32 conversions. Added limit checks
  and used bitwise operations for same - by Andrew.
- Link to v11: https://lore.kernel.org/r/20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com

Changes in v11:
- Remove reference of cookie in reboot-mode – Arnd/Rob
- Introduce 64-bit magic in reboot-mode to accommodate two 32-bit
  arguments – Arnd
- Change reset-type to reboot-mode in psci device tree binding – Arnd
	- binding no more mandates two arguments as in v10.
	- dt changes done to support this binding.
- Remove obvious comments in psci reset path – Konrad
- Merge sysfs and ABI doc into single patch.
- Fix compilation issue on X86 configs.
- Fix warnings for pr_fmt.
- Link to v10: https://lore.kernel.org/all/569f154d-c714-1714-b898-83a42a38771c@oss.qualcomm.com/

Changes in V10:
- Change in reset-type binding to make cookie as a mandatory
  argument.
- Change reboot-mode binding to support additional argument
  "cookie".
 From Lorenzo:
- Use reboot-mode framework for implementing vendor-resets.
- Modify reboot-mode framework to support two arguments
  (magic and cookie).
- Expose sysfs for supported reboot-modes commands.
- List out all existing reboot-mode commands and their users.
   - Added this to cover letter.
 From Dmitry:
- Modify reboot-mode to support non-device based registration.
- Modify reboot-mode to create a class and device to expose
  sysfs interface.
- Link to v9: https://lore.kernel.org/all/20250303-arm-psci-system_reset2-vendor-reboots-v9-0-b2cf4a20feda@oss.qualcomm.com/

Changes in v9:
- Don't fallback to architecturally defined resets from Lorenzo.
- Link to v8: https://lore.kernel.org/r/20241107-arm-psci-system_reset2-vendor-reboots-v8-0-e8715fa65cb5@quicinc.com

Changes in v8:
- Code style nits from Stephen
- Add rb3gen2
- Link to v7: https://lore.kernel.org/r/20241028-arm-psci-system_reset2-vendor-reboots-v7-0-a4c40b0ebc54@quicinc.com

Changes in v7:
- Code style nits from Stephen
- Dropped unnecessary hunk from the sa8775p-ride patch
- Link to v6: https://lore.kernel.org/r/20241018-arm-psci-system_reset2-vendor-reboots-v6-0-50cbe88b0a24@quicinc.com

Changes in v6:
- Rebase to v6.11 and fix trivial conflicts in qcm6490-idp
- Add sa8775p-ride support (same as qcm6490-idp)
- Link to v5: https://lore.kernel.org/r/20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com

Changes in v5:
- Drop the nested "items" in prep for future dtschema tools
- Link to v4: https://lore.kernel.org/r/20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com

Changes in v4:
- Change mode- properties from uint32-matrix to uint32-array
- Restructure the reset-types node so only the restriction is in the
  if/then schemas and not the entire definition
- Link to v3: https://lore.kernel.org/r/20240515-arm-psci-system_reset2-vendor-reboots-v3-0-16dd4f9c0ab4@quicinc.com

Changes in v3:
- Limit outer number of items to 1 for mode-* properties
- Move the reboot-mode for psci under a subnode "reset-types"
- Fix the DT node in qcm6490-idp so it doesn't overwrite the one from
  sc7820.dtsi
- Link to v2: https://lore.kernel.org/r/20240414-arm-psci-system_reset2-vendor-reboots-v2-0-da9a055a648f@quicinc.com

Changes in v2:
- Fixes to schema as suggested by Rob and Krzysztof
- Add qcm6490 idp as first Qualcomm device to support
- Link to v1: https://lore.kernel.org/r/20231117-arm-psci-system_reset2-vendor-reboots-v1-0-03c4612153e2@quicinc.com

Changes in v1:
- Reference reboot-mode bindings as suggeted by Rob.
- Link to RFC: https://lore.kernel.org/r/20231030-arm-psci-system_reset2-vendor-reboots-v1-0-dcdd63352ad1@quicinc.com

---
Shivendra Pratap (10):
      power: reset: reboot-mode: Remove devres based allocations
      power: reset: reboot-mode: Add support for 64 bit magic
      power: reset: reboot-mode: Add support for predefined reboot modes
      firmware: psci: Introduce command-based reset in psci_sys_reset
      dt-bindings: arm: Document reboot mode magic
      power: reset: Add psci-reboot-mode driver
      arm64: dts: qcom: qcm6490: Add psci reboot-modes
      arm64: dts: qcom: lemans: Add psci reboot-modes
      arm64: dts: qcom: monaco: Add psci reboot-modes
      arm64: dts: qcom: talos: Add psci reboot-modes

 Documentation/devicetree/bindings/arm/psci.yaml |  42 +++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi            |   2 +-
 arch/arm64/boot/dts/qcom/lemans.dtsi            |   5 ++
 arch/arm64/boot/dts/qcom/monaco.dtsi            |   5 ++
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts        |   7 ++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts    |   7 ++
 arch/arm64/boot/dts/qcom/talos.dtsi             |   5 ++
 drivers/firmware/psci/psci.c                    |  46 +++++++++-
 drivers/power/reset/Kconfig                     |  10 +++
 drivers/power/reset/Makefile                    |   1 +
 drivers/power/reset/nvmem-reboot-mode.c         |  11 ++-
 drivers/power/reset/psci-reboot-mode.c          | 111 ++++++++++++++++++++++++
 drivers/power/reset/qcom-pon.c                  |   9 +-
 drivers/power/reset/reboot-mode.c               |  80 ++++++++++++-----
 drivers/power/reset/syscon-reboot-mode.c        |   9 +-
 include/linux/psci.h                            |   2 +
 include/linux/reboot-mode.h                     |  15 +++-
 17 files changed, 332 insertions(+), 35 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20250709-arm-psci-system_reset2-vendor-reboots-46c80044afcf

Best regards,
-- 
Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>


