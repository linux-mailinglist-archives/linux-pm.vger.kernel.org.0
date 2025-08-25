Return-Path: <linux-pm+bounces-33042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA351B347D7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE327A3E69
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 16:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA20301028;
	Mon, 25 Aug 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dkEjYpXW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272F2FE06F
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140253; cv=none; b=TXdFi2zUWMEHLSvdhwXaORToz1Y7EM1LbL8xnfkBJE4iZtSjpNzQpHQm/7OKsucysUdU+NcOdfT2P5+BWwIBltbsAUFTAE+df8gJ1foJuACKVyJKCFSL5IDhO5MLKaudf+Dg7yEMcFlQNdrqSISGZ2iowj/jqr7VvXttgdxT5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140253; c=relaxed/simple;
	bh=4+DrdL61UaJwKBOPyjvDbGLxMCh1l0N12pclwMqiu1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX55FP6dsLQzD58bhYffsT+0Q9ByyM6tuGbrQ4gAV3+mJ6fsJJUckqSkr4quM+/bVmuVcrHNQIs15ACs7Vc2mXeYSUqUv5hp7i2nDuOgyJ/xCS6sQuHVtRYy2pCsiQOm2OjfPl06aiaGqv/YKA6u6V26BLbZyqelbbq3UM0JveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dkEjYpXW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8YHSZ005884
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 16:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VkXgtXV7f37xL22OCgZ71BFwpcYjM8tCLgUNGf2Ra+o=; b=dkEjYpXW5sHvhH4g
	ghdGqvR2iEkwBjqgPHURmzUcyhmYK8tF82KGlkDrORTWNR4SG57jWfIaHY2KaQdA
	skJ0p0qxEMGw+SJUBJMU1PD6VEJ1K2hq1Fjr71j60nZMgQpCMbEd0uNYHfYu3jXL
	QzCZm9inT7LXSNVCD8A32S60W7XMHp8Lrc2VTsw8qWX+SMMAFNXK4E1U4bWMtRWo
	UHzS/AHSZK/LvzO8crc23P3sL81Uz1mfkM64PNaBzSjctycOZQoj8dmuaNSnv6TS
	Fvuzst8IlOfMdfzazl8DSqImr0yzwYCIFf5JJXqVS2MZ0qiZR56mBVdlVxn6+bTG
	cerzGg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unnqw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 16:44:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445805d386so53240995ad.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 09:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140249; x=1756745049;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkXgtXV7f37xL22OCgZ71BFwpcYjM8tCLgUNGf2Ra+o=;
        b=aYkXcUxFucrxk1IkvjNKhzhcJOQVss9XLPYWXcKX04EHsrd08t1jx8IDSj1ciYHI7j
         tKqM3GVnEPga3WaW+krKlfjdLr6NlzE7phzN5qWJwdAKF2fUooZE6qSt4W49V62wS6Yg
         18MT6awVuNadOabVUq8GPGU714I0DJTLLft65j6ZGGLqKiv2qI8ugibUN5Affut7MfdM
         KLC6BtQg8G3h57lsutVcxtgOHsiQASzEmT/q06GRJN4VgaXdZ4+Z/henxKzjnhtlp53N
         MMVnLodwefxdHJf9nEHHoKS8i+5wSWVBjSRvyzQlWfAZP3gqSUdYwbplIB4xvu88V6V4
         g78Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5rKoE4jaJfE6wglli+PA3cWF6Ssb8lkbDnr3NzqSXeouvDYcbXefSRO41cqe1PcWwguRz5t0tOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZ7OZLwQcYjwKk1Vq0f13Os6/KbS/wwQbEKplcSfhPsk2Zvuf
	Qc3S28MidPodH0EZk3EbRJYEJJt2q7TxSgAV8VL2h8APqhjyIWJQO1h90uxniFblU3cW7Isjw9p
	SsGn+lxtruTqEWMeJ6GwK0sOWgi28ZzM/ynwTZm7p+v6/YeoY4BLqll2VA1GRTA==
X-Gm-Gg: ASbGncssnbfss2s08YCglZhfFRt2QLMRQzMiu8e+fcK2pCz6zG7+oYtrCBjhm9urX3q
	Lk63foT65vSDHVccmvDSvuQSHBw5RUFgQM4Ndu+niXQUz5TQQ0cFa1cQT6qVXoLFRfJ7HhSCboQ
	D3wMbLyBDHFlpdtZzZu2L68cJHiVhAL6fS/dAC3pI4ViUfILqkwSfeIBNTWytfoeTWpJpwuKG1W
	SP23XVBCz2FAp1f+9UPs3hSvM/9Gsi748abkkvb2wI+aPY1YyFGAKcH6iHPNVC5xHE1xcdDAU/R
	u130XqTVijQCOeUKO420mBQF00u14V0D4sGk+zbAwLeNJ5ZLns1jo31dnq6MU5ZpZytY
X-Received: by 2002:a17:902:ce8b:b0:240:52c8:2564 with SMTP id d9443c01a7336-2462ee8e8f4mr191030495ad.26.1756140249193;
        Mon, 25 Aug 2025 09:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+qUQTI7dH9WfoK+mxz4DLGdk08USfScffsegOK+mgoCLUWBBdePL8ik/Y/ki6NK0tKflmSw==
X-Received: by 2002:a17:902:ce8b:b0:240:52c8:2564 with SMTP id d9443c01a7336-2462ee8e8f4mr191030065ad.26.1756140248682;
        Mon, 25 Aug 2025 09:44:08 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668889dbbsm72715395ad.132.2025.08.25.09.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:44:08 -0700 (PDT)
Date: Mon, 25 Aug 2025 22:14:01 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/7] OPP: Add support to find OPP for a set of keys
Message-ID: <aKyS0RGZX4bxbjDj@hu-wasimn-hyd.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
X-Proofpoint-GUID: m_toc4jZEy7SLj6rsuNV31cWnqq-j4aF
X-Proofpoint-ORIG-GUID: m_toc4jZEy7SLj6rsuNV31cWnqq-j4aF
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ac92da cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1xens5CjvSCak2KtytIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX0RvCFAL4ptZy
 dfY8GyZbm3lO78NfFuz/ewAxXPVeDylhkblk3cuJvyuQ2MKJ+K2fYKoxK4HOpzjnqQDFPdvG5Jr
 by9qXj32rGfxx9Vh9NwGMUoXBykS8KzaQimOxg89FP2stwrw4mf/3YvCtRFwsHfqxTioyPr6fqE
 YRha6MVpMzlS+zfRK6F2/Cr+eIk/4pbAFh7EMfKKsxuIytcqYmwphaWVAjiXIsS1O8092KVZP1r
 cnTr6GX6ZxvIXSOrz8aVwjx0kiIh3OINXw6OmR00Z0j5wkg+iSLe92H3+T5gbTb/8nayxpTRCxI
 DsCiNCg+AE0NesNuuFv7F/U3RolaOFusp8ZgGnuRmqnvN2k+LlMv1wj4v655FrA8ZH5loTUV0CP
 N1ysQoNR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

On Wed, Aug 20, 2025 at 01:58:46PM +0530, Krishna Chaitanya Chundru wrote:
> The existing OPP table in the device tree for PCIe is shared across
> different link configurations such as data rates 8GT/s x2 and 16GT/s x1.
> These configurations often operate at the same frequency, allowing them
> to reuse the same OPP entries. However, 8GT/s and 16 GT/s may have
> different characteristics beyond frequency—such as RPMh votes in QCOM
> case, which cannot be represented accurately when sharing a single OPP.
> 
> In such cases, frequency alone is not sufficient to uniquely identify
> an OPP. To support these scenarios, introduce a new API
> dev_pm_opp_find_key_exact() that allows OPP lookup for set of keys like
> frequency, level & bandwidth.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v4:
> - Included dtsi changes for all platforms.
> - Made the changes as requested by Viresh like adding comments, some
>   coding styles etc.
> - Link to v3: https://lore.kernel.org/r/20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com
> 
> Changes in v3:
> - Always check for frequency match unless user doesn't pass it (Viresh).
> - Make dev_pm_opp_key public and let user pass the key (Viresh).
> - Include bandwidth as part of dev_pm_opp_key (Viresh).
> - Link to v2: https://lore.kernel.org/r/20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com
> 
> Changes in v2:
> - Use opp-level to indentify data rate and use both frequency and level
>   to identify the OPP. (Viresh)
> - Link to v1: https://lore.kernel.org/r/20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (7):
>       OPP: Add support to find OPP for a set of keys
>       OPP: Move refcount and key update for readability in _opp_table_find_key()

Hi Krishna,

Patch 2/7 is applied in linux-next (20250825) as commit
b5323835f050 (OPP: Reorganize _opp_table_find_key()) which is causing
regression on my board (lemans-evk (arm64)).
Reverting the change is resolving the issue.

Kernel log:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000016
...
Call trace:
 _read_bw+0x0/0x10 (P)
 _find_key+0xb8/0x194
 dev_pm_opp_find_bw_floor+0x54/0x8c
 bwmon_intr_thread+0x84/0x284 [icc_bwmon]
 irq_thread_fn+0x2c/0xa8
 irq_thread+0x174/0x334
 kthread+0x134/0x208
 ret_from_fork+0x10/0x20

>       arm64: dts: qcom: sm8450: Add opp-level to indicate PCIe data rates
>       arm64: dts: qcom: sm8550: Add opp-level to indicate PCIe data rates
>       arm64: dts: qcom: sm8650: Add opp-level to indicate PCIe data rates
>       arm64: dts: qcom: x1e80100: Add opp-level to indicate PCIe data rates
>       PCI: qcom: Use frequency and level based OPP lookup
> 
>  arch/arm64/boot/dts/qcom/sm8450.dtsi   |  41 ++++++++++---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi   |  63 ++++++++++++++-----
>  arch/arm64/boot/dts/qcom/sm8650.dtsi   |  63 ++++++++++++++-----
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi |  90 ++++++++++++++++++++++-----
>  drivers/opp/core.c                     | 107 +++++++++++++++++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-qcom.c |   7 ++-
>  include/linux/pm_opp.h                 |  30 +++++++++
>  7 files changed, 341 insertions(+), 60 deletions(-)
> ---
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> change-id: 20250717-opp_pcie-793160b2b113
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

-- 
Regards,
Wasim

