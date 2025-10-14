Return-Path: <linux-pm+bounces-36071-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C39BDA06C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C31B04E335C
	for <lists+linux-pm@lfdr.de>; Tue, 14 Oct 2025 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0912ECEAB;
	Tue, 14 Oct 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bjkKe4IG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420A28751D;
	Tue, 14 Oct 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452556; cv=none; b=NrsM313nHuEz3FSAKk/mkcz6Rt2vD3djhRdC6B1X/0TeirJ1sAD63LrjISPxUgKmRGcbRFUAboNZbUI1hfH7pslKKl6vbzc9TrxWhveqbH437/glzs0QCTyKnbAUSu/QQa3f3Xok3VPy7ha1lFgUSgH2FoJLutdzLoBXwRnp344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452556; c=relaxed/simple;
	bh=7KNa7wMTbQbmZ467rE28JO0t2zhoYtNlOvlIQNscl48=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OdrplKkSt9w3xTWhxvQQhUE7xZjEu4LJIIhjUbC51O5Qje/pANXplajpXXwobn7jd0VhLQlmxz/vuFeNWUk17uvsr5ubrXU7kOAhtnMpLarxqIyN3m8pr05Zn7a+NB2CJgNbM6MSXtNwDdS5lLV41R0qD90niZuodYzWxtdHTvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bjkKe4IG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87G6b019855;
	Tue, 14 Oct 2025 14:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=moyjh2Z/8bfDBFji1OPTFR
	7wVBaNaU9yBpbA9EtFOc4=; b=bjkKe4IGIVd6nTwf0SWq/2ajHCCxlMcskWXl+E
	JBLIR3HWOQ6lqAVNUFyosziC23uyhzI/Vna4r/MW5rvwLZ4+zShJLSLYj+V3Js1e
	QtJT6ekRRVHCEd3ibADeA3MXhQn+cxtYeFlYlOXhpX438es2tT9+8KBZKGvrIOnx
	ZUJemVDdpb+Hj4BfQdW/eAK9RvAOrNVR+SHfx9mXlvgQKnZdcrYEgMdFbH7H/r0k
	oqC8k8lo1Dp9DrPKz5JDiHjr1vmV0WJ/cqxbqwdSDh2yGy8FCHSm9Zlzdcr7r+eQ
	CPCVh24XTbNN0UUQliZiE/MEaPGqfF8HN+iwSWYHU9/1GsVw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c0sy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:35:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EEZgKh004513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:35:42 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 07:35:37 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v7 00/10] Add Network Subsystem (NSS) clock controller
 support for IPQ5424 SoC
Date: Tue, 14 Oct 2025 22:35:25 +0800
Message-ID: <20251014-qcom_ipq5424_nsscc-v7-0-081f4956be02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK5f7mgC/22NQQ6CMBREr0L+2pq2tEVYeQ9DCJSP/IUFWiUa0
 rtbu3b5JjNvDgjoCQM0xQEedwq0uATVqQA79+6OjMbEILnUggvFNrs8Olo3raTqXAjWMsRhNLI
 vBVYK0nD1ONE7S29t4pnCc/Gf/LGbX5p1vJb6n243jLNq6kdTD0KV+nLdXmTJ2XPqQhtj/AJSs
 3FKtgAAAA==
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Varadarajan
 Narayanan" <quic_varada@quicinc.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        "Anusha Rao" <quic_anusha@quicinc.com>,
        Devi Priya
	<quic_devipriy@quicinc.com>,
        Manikanta Mylavarapu
	<quic_mmanikan@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad
 Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_pavir@quicinc.com>, <quic_suruchia@quicinc.com>,
        Luo Jie <quic_luoj@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760452536; l=5119;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=7KNa7wMTbQbmZ467rE28JO0t2zhoYtNlOvlIQNscl48=;
 b=SulFvGhg7QlW1UrWht7gQbOVva0v6rrAT+WRheLpyOe5cAJytMygDjadhGti9edzT4p2K5hJV
 rraTPg+2zWXBNPy9juNxL9Xu/Xpa2Sdr49USyeNUYBlNvQGW38suZ9d
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _6Jkyj4yyEGTHcVvLS2jWlAe-Ml-dNBT
X-Proofpoint-ORIG-GUID: _6Jkyj4yyEGTHcVvLS2jWlAe-Ml-dNBT
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ee5fbf cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=ZVt5iEiquArM4_yOc0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXxelgXNtMd6YY
 w5t8iM4+RzsFyhDO7Z5qsSXtfax/+zlsRapncbfWEMPwDWAK7hdh8KXCK1CwHER0SHNwKzA7pum
 Biy+cU7EKvw6kNw+E2SXzK+RjYgV5DkQCArMsEULwSJeZ/kAlc87XSebed2zwKKPQahqDKiDusv
 pczO/r7bqZO09fU1QSMF8t7U81in6mlS1jRMSdFpfTvvxcMG5UeC69aMNSC6isPVVyjxVv30sv3
 aHfhtV4V0v4fzANXaj6Pemqm31jyROteSvorOQ/KEP+lCita2fKZT4WwrFXhE4BF8Xq4OxKphz2
 9yq4ZUjNHR3Z3NJjVyn4ZVBE722wcECMQ5jhhyCd+V9ma4bNxqqeAusvFC38gXc+i4A4HkKRSNT
 L8Qti4qRFgxCLz1AFJjHtk08j6czkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

The NSS clock controller on the IPQ5424 SoC provides clocks and resets
to the networking related hardware blocks such as the Packet Processing
Engine (PPE) and UNIPHY (PCS). Its parent clocks are sourced from the
GCC, CMN PLL, and UNIPHY blocks.

Additionally, register the gpll0_out_aux GCC clock, which serves as one
of the parent clocks for some of the NSS clocks.

The NSS NoC clocks are also enabled to use the icc-clk framework, enabling
the creation of interconnect paths for the network subsystem’s connections
with these NoCs.

The NSS clock controller receives its input clocks from the CMN PLL outputs.
The related patch series which adds support for IPQ5424 SoC in the CMN PLL
driver is listed below.
https://lore.kernel.org/all/20250610-qcom_ipq5424_cmnpll-v3-0-ceada8165645@quicinc.com/

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
Changes in v7:
- Update the commit title to use #interconnect-cells as recommended.
- Collect the reviewed-by tags.
- Link to v6: https://lore.kernel.org/r/20250925-qcom_ipq5424_nsscc-v6-0-7fad69b14358@quicinc.com

Changes in v6:
- Remove '#interconnect-cells' from the list of required properties in the
  DT binding.
- Add the Reviewed-by tag to the IPQ5424 DT binding patch.
- Link to v5: https://lore.kernel.org/r/20250909-qcom_ipq5424_nsscc-v5-0-332c49a8512b@quicinc.com

Changes in v5:
- Reorder the fixes patch "Add required "interconnect-cells" property"
  to the beginning of the series.
- Enhance the commit message to clearly explain the necessity of the
  #interconnect-cells property for interconnect providers, and why
  there is no ABI breakage for currently supported SoC IPQ9574.
- Collect the reviewed-by tags.
- Link to v4: https://lore.kernel.org/r/20250828-qcom_ipq5424_nsscc-v4-0-cb913b205bcb@quicinc.com

Changes in v4:
- Add new, generic clock names "nss" and "ppe" in DT bindings to support
  the newer SoC such as IPQ5424 SoC, while retaining existing clock names
  for IPQ9574.
- Register all necessary NoC clocks as interconnect paths.
- Separate the fix for correcting icc_first_node_id into its own patch.
- Separate the fix requiring the "#interconnect-cells" property for NSS
  clock controller node.
- Update commit titles from "clock:" to "clk:" for consistency.
- Update copyright to remove year as per guidelines in all driver files.
- Remove the Acked-by tag from the "Add Qualcomm IPQ5424 NSSNOC IDs" patch"
  as the new NOC IDs are added.
- Link to v3: https://lore.kernel.org/r/20250710-qcom_ipq5424_nsscc-v3-0-f149dc461212@quicinc.com

Changes in v3:
- Remove frequency suffix from clock names for PPE and NSS clocks in
  IPQ9574 DT binding and DTS.
- Update IPQ5424 DT bindings and DTS to as per new PPE and NSS clock names.
- Expand the register region of IPQ5424 NSSCC to utilize the entire 0x100_000
  address range, ensuring inclusion of the wrapper region.
- Collect the reviewed-by tags.
- Link to v2: https://lore.kernel.org/r/20250627-qcom_ipq5424_nsscc-v2-0-8d392f65102a@quicinc.com

Changes in v2:
- Add new, separate clock names "nss" and "ppe" in dtbindings to support
  the IPQ5424 SoC.
- Wrap the commit message body at 75 columns.
- Fix the indentation issue in the `IPQ_NSSCC_5424` Kconfig entry.
- Enhance the commit message for the defconfig patch to clarify the requirement
  for enabling `IPQ_NSSCC_5424`.
- Link to v1: https://lore.kernel.org/r/20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com

---
Luo Jie (10):
      clk: qcom: gcc-ipq5424: Correct the icc_first_node_id
      dt-bindings: clock: Add "#interconnect-cells" property in IPQ9574 example
      dt-bindings: interconnect: Add Qualcomm IPQ5424 NSSNOC IDs
      clk: qcom: gcc-ipq5424: Enable NSS NoC clocks to use icc-clk
      dt-bindings: clock: gcc-ipq5424: Add definition for GPLL0_OUT_AUX
      clk: qcom: gcc-ipq5424: Add gpll0_out_aux clock
      dt-bindings: clock: qcom: Add NSS clock controller for IPQ5424 SoC
      clk: qcom: Add NSS clock controller driver for IPQ5424
      arm64: dts: qcom: ipq5424: Add NSS clock controller node
      arm64: defconfig: Build NSS clock controller driver for IPQ5424

 .../bindings/clock/qcom,ipq9574-nsscc.yaml         |   63 +-
 arch/arm64/boot/dts/qcom/ipq5424.dtsi              |   32 +-
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/qcom/Kconfig                           |   11 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-ipq5424.c                     |   28 +-
 drivers/clk/qcom/nsscc-ipq5424.c                   | 1340 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,ipq5424-gcc.h       |    3 +-
 include/dt-bindings/clock/qcom,ipq5424-nsscc.h     |   65 +
 include/dt-bindings/interconnect/qcom,ipq5424.h    |   33 +
 include/dt-bindings/reset/qcom,ipq5424-nsscc.h     |   46 +
 11 files changed, 1612 insertions(+), 11 deletions(-)
---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251014-qcom_ipq5424_nsscc-eebd62a31e74

Best regards,
-- 
Luo Jie <quic_luoj@quicinc.com>


