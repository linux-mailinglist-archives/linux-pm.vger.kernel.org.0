Return-Path: <linux-pm+bounces-33097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F8DB3573B
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6469A189F387
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 08:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3089D2FE584;
	Tue, 26 Aug 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BM+H5HlE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE762FD7AD
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197446; cv=none; b=sb8oAiYjtMoRajHusg7Wv99YiAmFtNebluV+6AKPJ2zPDc8dY8SqA0uhkzk/Pl0DtFsPQcfAkzuDPbUsWHsGnK8aOhrtxzSTPxIkU/jG6oUrxZP7uDXah8/B8/ieoEpfaZzBN3BCrYwVI4fp68wWMqwbU1I+CU/5sATmyi7eBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197446; c=relaxed/simple;
	bh=HcxVCSfyA3IHefD4lcYbGrP9j26BJjgQiq3Md7Ps0a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk/2+HwH+OwwSsVVvf3rW3Bz8TssQxJoyElK5GIR/+mmqksi2inbSkjV9p6qYyH4CBkOfXmx5hEz274FLc4GXJZzRVsVwET0T9PHwtI5E964Fyriup3j0y/0iSoplUgRzgaA7qfhu2+1PTM+xJzmAKWvxHvu6KCwGL2ysUeIgZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BM+H5HlE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8Ycd5019757
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 08:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NnYS9WtUIPu
	ziL0Yv49vYyeZc7XEI7/YfHi1dSBjcXc=; b=BM+H5HlEVgzUKpkS7dwePn/6DVx
	Nal7HAoB72aan3J+dv4e3HkEUMfxe1F0LB8yWI9gNkHf1xMe+w+eQNVy2h2ZNwXb
	dSnDFxBfrDrVLKrkvqgNswrx/wPlyorDd11G/M6+yikhxMzHrNWZzZ/dRP/KDhKL
	ycGAGtJovZhPQQYjJq8Yi1nSLlkEbJCujsvuEzoSl1Do5tT++nPihGCDkaCIqg9Z
	yUDefCkGHqMtat9EYVJnsvGAQXDGQtbiiWBYlgO9rlkBvqwkXwUO07thAZX+LFX7
	y7nDOZkpV9tKNz/3q6RybhpPIx0l2KpMg8xmXNgx3cylH+zW8BhDUmZR+Yw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unqygx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 08:37:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457ef983fso110713005ad.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Aug 2025 01:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197440; x=1756802240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnYS9WtUIPuziL0Yv49vYyeZc7XEI7/YfHi1dSBjcXc=;
        b=bigXjrHZcucCnMdlW4ZPTTSdEutt8bgALdK8EUyQ3ylMWpgVyzNEBmGoC8WsYoxwGL
         6DOh5CzsyqUNuYyO/grZzRj/c4SDZ9dK+4ahxgY9YaE5B3PHpA/KfU+NPM9w4NbsohJc
         mh0sRR2AMz1exmKLsgGa8zu5IUyJbO0PEGrBHfVugwywXnJq6Sxl9ooJS4uAyfXbS2c0
         Gcem4cxSTZE9cH3p3mjZX4PjvGmJcwr1mmt6V7RuWwm4fKJTAPuGh36v3yDj9fGCwuX1
         Js+IlGhKj4OyWBniowjr5dLgLsQYXDp0d7eBGL0fp1xe8oYqx31cQI5JO38STWVsgTQU
         ZA/A==
X-Forwarded-Encrypted: i=1; AJvYcCUKTZXaiM5Nd6/u6TTPDTMoVcb7Cd9JPJIEr9vkMi1geYMHHkR6fIzXLtchna6RLqHfU+X7MNKQfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2TQhAJw6tsR6MqH2BtBy/QIpWmvOpJ6++jQGybe3p9g2flt0
	Z/ngQQ19uVyVcf9oZ17dse82m04k5q/Q1SGf1ABs4szpoygF4tZpnj6jF6BJBtcTRs/aEcyq4gH
	+oCLtXYYmYgzrkdZ7ZgwEKuerqN+XLmDgDTp3n/WKVSWT8MvhC0K5nvhjhgUi4Q==
X-Gm-Gg: ASbGncsUFObw4Y7C8PYwVk6pbnhgfn3zO+F/GHdXdlxIC/8/G3/I3JX6U7P504WtpxC
	PSwwPc7HYy4CrHcecKF9A8f+8UV3iYTJ/t3tQdoHbviMnTikBqrSIgY/Yker4tVDF85h1EBNGyj
	ia5nl3uy5x/3u6BE2u95OOZuPd/6Bf/k+KH1Rlit8NXI9SO6MA8QavVSEYbLfGgWA+NiFf03+67
	5rYbo0DJOrM5n/n/clHgI14rpQwYJKVtmHOZOZ5Ky0RG++kFlLG323+GEIibeOaHw1VK7N3bCnr
	727eSppDKdia/qHB9qpz3u57UGSzAGh1rBJkRlV9Ddxo4JNzLvln/Fp+ytV63y7q3hCxloUfljE
	=
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id d9443c01a7336-246464d13f7mr229416625ad.2.1756197439439;
        Tue, 26 Aug 2025 01:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFGkO2J1KqHkm44334fdtcjjw4U6DbqEdXs6u14r/z46H1yPxBcW2ODzEOeItfnI7Mre3C8Q==
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id d9443c01a7336-246464d13f7mr229416115ad.2.1756197438772;
        Tue, 26 Aug 2025 01:37:18 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm36924785ad.136.2025.08.26.01.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:37:18 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_kotarake@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH V7 1/5] dt-bindings: iio/adc: Move QCOM ADC bindings to iio/adc folder
Date: Tue, 26 Aug 2025 14:06:53 +0530
Message-Id: <20250826083657.4005727-2-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VV6A9Bs6zhJR7RkW7Mn4GAoBQ9Nq7rJq
X-Proofpoint-ORIG-GUID: VV6A9Bs6zhJR7RkW7Mn4GAoBQ9Nq7rJq
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68ad7241 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=i0EeH86SAAAA:8 a=6H0WHjuAAAAA:8 a=bBqXziUQAAAA:8 a=tVI0ZWmoAAAA:8
 a=40pjNWuwAAAA:8 a=pGLkceISAAAA:8 a=H9O94b8ySLUdQZd_rL4A:9
 a=p4tsHYGwVsi209i8:21 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
 a=Soq9LBFxuPC4vsCAQt-j:22 a=BjKv_IHbNJvPKzgot4uq:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=coQwfJANHVg1YNGTr4By:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX/DdZ8kkK+r6p
 sjVsvvA467SxLfmPScuYEsiDZGmsVxwnBeest+jW5u1RHDywVVWvub4dBGzeO7RrgvMhr1tcrBJ
 Gh+Z66Fbzg+UW+U78VuO00fcPMYBxt0+MquThstAqgjt/9WRs6GiWyaps+idB333qVgD9K2vgCV
 zWSY82wv5bOr7iOfpRy68fGM+QW0/92X0LbILfzgR45Ke5e7ZpuVEZOzBGa4F+/I+tyESnyLvLz
 1GfEVeEGfN6fCoRx5iDhYgGfN6R1ifnsS4JDEHIYg9g+S3mbUXuCmAmvj4S8st9+t/qNhT6oO5p
 Mo9vjvCoKrlNWRdnSVqVjCEum7BZAJ/PnHHrC3jUo7tzDWLZWPKotRDamSEwaV+qZhgLTKesPmJ
 0ZxuU37C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

There are several files containing QCOM ADC macros for channel names right now
in the include/dt-bindings/iio folder. Since all of these are specifically for
adc, move the files to the include/dt-bindings/iio/adc folder.

Also update all affected devicetree and driver files to fix compilation errors
seen with this move and update documentation files to fix dtbinding check errors
for the same.

Acked-by: Lee Jones <lee@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v5:
- Updated one more devicetree file requiring this change.
  Ran full dt_binding_check and dtbs_check and verified that no
  errors were reported related to this patch.

  Mentioning this explicitly as there was an invalid error reported on
  this patch in the last two patch series, from upstream kernel
  automation:

  fatal error: dt-bindings/iio/adc/qcom,spmi-vadc.h: No such file or directory

  The error is invalid as this file does get added in this patch, in
  previous patch series too.

  Links to discussion for same in v5:
  https://lore.kernel.org/all/cc328ade-a05e-4b1d-a8f0-55b18b4a0873@oss.qualcomm.com/
  https://lore.kernel.org/all/9f24e85d-f762-4c29-a58f-ed7652f50919@oss.qualcomm.com/

  Links to discussion for same in v4:
  https://lore.kernel.org/all/16aaae04-4fe8-4227-9374-0919960a4ca2@quicinc.com/

Changes since v4:
- Updated some more devicetree files requiring this change.

Changes since v3:
- Updated files affected by adc file path change in /arch/arm, which
  were missed earlier. Updated some more new devicetree files requiring
  this change in /arch/arm64.

Changes since v2:
- Updated some more new devicetree files requiring this change.

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml       | 8 ++++----
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 2 +-
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml  | 2 +-
 .../devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml    | 6 +++---
 arch/arm/boot/dts/qcom/pm8226.dtsi                        | 2 +-
 arch/arm/boot/dts/qcom/pm8941.dtsi                        | 2 +-
 arch/arm/boot/dts/qcom/pma8084.dtsi                       | 2 +-
 arch/arm/boot/dts/qcom/pmx55.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/pm4125.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm6125.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm660.dtsi                       | 2 +-
 arch/arm64/boot/dts/qcom/pm660l.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm7250b.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm8150.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8150b.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm8150l.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8937.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8950.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8953.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pmi632.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/pmi8950.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi                 | 2 +-
 arch/arm64/boot/dts/qcom/pmp8074.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/pms405.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts        | 4 ++--
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts          | 4 ++--
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/sc7280-idp.dts                   | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                | 4 ++--
 arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi               | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts      | 2 +-
 .../arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi              | 6 +++---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts         | 2 +-
 arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts      | 6 +++---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                   | 8 ++++----
 drivers/iio/adc/qcom-spmi-adc5.c                          | 2 +-
 drivers/iio/adc/qcom-spmi-vadc.c                          | 2 +-
 include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h | 2 +-
 include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h    | 2 +-
 .../dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h    | 2 +-
 include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h        | 0
 53 files changed, 68 insertions(+), 68 deletions(-)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm7325.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350.h (98%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pm8350b.h (99%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmk8350.h (97%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735a.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-pmr735b.h (95%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-adc7-smb139x.h (93%)
 rename include/dt-bindings/iio/{ => adc}/qcom,spmi-vadc.h (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index b9dc04b0d307..bc3f8ccde536 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -70,9 +70,9 @@ patternProperties:
         maxItems: 1
         description: |
           ADC channel number.
-          See include/dt-bindings/iio/qcom,spmi-vadc.h
+          See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
           For PMIC7 ADC, the channel numbers are specified separately per PMIC
-          in the PMIC-specific files in include/dt-bindings/iio/.
+          in the PMIC-specific files in include/dt-bindings/iio/adc.
 
       label:
         description: |
@@ -276,8 +276,8 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
 
     pmic {
         #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1..11da55644262 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -276,7 +276,7 @@ examples:
     #include <dt-bindings/input/input.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
     #include <dt-bindings/spmi/spmi.h>
 
     pmic@0 {
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
index bfad8130a042..65b8c8cf802f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml
@@ -110,7 +110,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     pmic {
diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
index 4470a5942fb2..5d19a82b0319 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml
@@ -163,7 +163,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/iio/qcom,spmi-vadc.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     pmic {
@@ -204,8 +204,8 @@ examples:
     };
 
   - |
-    #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-    #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+    #include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
     #include <dt-bindings/interrupt-controller/irq.h>
 
     pmic {
diff --git a/arch/arm/boot/dts/qcom/pm8226.dtsi b/arch/arm/boot/dts/qcom/pm8226.dtsi
index 2fd4f135ed84..774120aa50bc 100644
--- a/arch/arm/boot/dts/qcom/pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8226.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: BSD-3-Clause
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm/boot/dts/qcom/pm8941.dtsi b/arch/arm/boot/dts/qcom/pm8941.dtsi
index aca0052a02b7..d995cc6eaebf 100644
--- a/arch/arm/boot/dts/qcom/pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom/pm8941.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm/boot/dts/qcom/pma8084.dtsi b/arch/arm/boot/dts/qcom/pma8084.dtsi
index 309f5256754b..f8790bbc225e 100644
--- a/arch/arm/boot/dts/qcom/pma8084.dtsi
+++ b/arch/arm/boot/dts/qcom/pma8084.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm/boot/dts/qcom/pmx55.dtsi b/arch/arm/boot/dts/qcom/pmx55.dtsi
index da0851173c69..af05ec5a009c 100644
--- a/arch/arm/boot/dts/qcom/pmx55.dtsi
+++ b/arch/arm/boot/dts/qcom/pmx55.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2020, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm4125.dtsi b/arch/arm64/boot/dts/qcom/pm4125.dtsi
index cf8c822e80ce..db175a55035c 100644
--- a/arch/arm64/boot/dts/qcom/pm4125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm4125.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2023, Linaro Ltd
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index d0db28336fa9..2bc669e8763b 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: BSD-3-Clause
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 59524609fb1e..24fbfee8de79 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 334f976f1154..5c0ae7a06bd0 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2019, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 156b2ddff0dc..0ae38647ec49 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm660l.dtsi b/arch/arm64/boot/dts/qcom/pm660l.dtsi
index 3f8b9eafe164..585d206b02be 100644
--- a/arch/arm64/boot/dts/qcom/pm660l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660l.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2020, Konrad Dybcio
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 0761e6b5fd8d..6ad46722ae38 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2022 Luca Weiss <luca.weiss@fairphone.com>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index d2568686a098..caf952e19d60 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 3f7b0b6a1d10..5192ab94e75e 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 3911d6d0d2e2..7822214f07b0 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -4,7 +4,7 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index f8e4829ff7f7..3a709095cda7 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8937.dtsi b/arch/arm64/boot/dts/qcom/pm8937.dtsi
index 77809c3534a7..e54a92839c71 100644
--- a/arch/arm64/boot/dts/qcom/pm8937.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8937.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2023, Dang Huynh <danct12@riseup.net>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pm8950.dtsi b/arch/arm64/boot/dts/qcom/pm8950.dtsi
index ed72c6101813..c1462d659ff2 100644
--- a/arch/arm64/boot/dts/qcom/pm8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8950.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2022, Marijn Suijten <marijn.suijten@somainline.org>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/qcom,pmic-mpp.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
index 64258505f9ba..9427062b8af5 100644
--- a/arch/arm64/boot/dts/qcom/pm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause
 /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8994.dtsi b/arch/arm64/boot/dts/qcom/pm8994.dtsi
index 353e4a6bd088..26cbcfd06d05 100644
--- a/arch/arm64/boot/dts/qcom/pm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8994.dtsi
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 3ecb330590e5..b948b98835a9 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /* Copyright 2018 Google LLC. */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qcom/pmi632.dtsi
index 8c899d148e46..eff176851b83 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2023 Luca Weiss <luca@z3ntu.xyz>
  */
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pmi8950.dtsi b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
index 3d3b1cd97cc3..9bd5b895cd58 100644
--- a/arch/arm64/boot/dts/qcom/pmi8950.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8950.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019, AngeloGioacchino Del Regno <kholk11@gmail.com>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index 5084de66fc46..3dd3adfa096b 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -6,7 +6,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
index 0d0a846ac8d9..9f3e4121d834 100644
--- a/arch/arm64/boot/dts/qcom/pmp8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
 
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 &spmi_bus {
 	pmic@0 {
diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 3f9100c7eff4..86c17094a92a 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -5,7 +5,7 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/input/linux-event-codes.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 519e458e1a89..a50c5ccd0dcb 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -9,8 +9,8 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index eb8efba1b9dd..923fc9c24e2c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -9,8 +9,8 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 7509c27bd3f8..fa22d37e6332 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -9,8 +9,8 @@
 #define PM7250B_SID 8
 #define PM7250B_SID1 9
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 3103f94cd685..8a99e0f97eb6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include "sc7280-idp.dtsi"
 #include "pmr735a.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ccd39a1baeda..e324c115ecef 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -5,7 +5,7 @@
  * Copyright (c) 2021, The Linux Foundation. All rights reserved.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/linux-event-codes.h>
 #include "sc7280.dtsi"
 #include "pm7325.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 7d1d5bbbbbd9..8fcd3e1bb815 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -11,8 +11,8 @@
  * Copyright 2022 Google LLC.
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
index 451c9b984f1f..ed1fcfdc3584 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x-pmics.dtsi
@@ -7,7 +7,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 / {
 	thermal-zones {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
index 1667c7157057..22fb116330a2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-huawei-gaokun3.dts
@@ -11,7 +11,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 0b479e98ba38..c91d9a4ccf86 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
index 29efbef5ef69..9fdb9078d2fc 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-blackrock.dts
@@ -8,7 +8,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 307df1d3dcd2..f7633730eaa2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -3,9 +3,9 @@
  * Copyright (c) 2022, Linaro Limited
  */
 
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 4afbab570ca1..5cb1ccbf6e1f 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -14,7 +14,7 @@
 
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
diff --git a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
index f16b47b6a74c..6d285923215f 100644
--- a/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
+++ b/arch/arm64/boot/dts/qcom/sm7325-nothing-spacewar.dts
@@ -8,9 +8,9 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm7325.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 0c6aa7ddf432..f2aeb64d72bc 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -6,10 +6,10 @@
 /dts-v1/;
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pm8350b.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
-#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h>
+#include <dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index af3c2f659f5e..389454edbf75 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -20,7 +20,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define ADC5_USR_REVISION1			0x0
 #define ADC5_USR_STATUS1			0x8
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 00a7f0982025..e4878770f88c 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/log2.h>
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* VADC register and bit definitions */
 #define VADC_REVISION2				0x1
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h
similarity index 98%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h
index 96908014e09e..f0ab57078ca4 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm7325.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm7325.h
@@ -10,7 +10,7 @@
 #define PM7325_SID					1
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM7325_ADC for PMIC7 */
 #define PM7325_ADC7_REF_GND			(PM7325_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
similarity index 98%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
index 5d98f7d48a1e..ef818248ec8c 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_PM8350_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8350_ADC for PMIC7 */
 #define PM8350_ADC7_REF_GND(sid)			((sid) << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
similarity index 99%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
index 57c7977666d3..d841bf00b7b0 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pm8350b.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pm8350b.h
@@ -10,7 +10,7 @@
 #define PM8350B_SID					3
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PM8350B_ADC for PMIC7 */
 #define PM8350B_ADC7_REF_GND			(PM8350B_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
similarity index 97%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
index 3d1a41a22cef..161b211ec126 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmk8350.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmk8350.h
@@ -10,7 +10,7 @@
 #define PMK8350_SID					0
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMK8350_ADC for PMIC7 */
 #define PMK8350_ADC7_REF_GND			(PMK8350_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
similarity index 95%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
index c5adfa82b20d..fedc9e3882b8 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735a.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735a.h
@@ -10,7 +10,7 @@
 #define PMR735A_SID					4
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMR735A_ADC for PMIC7 */
 #define PMR735A_ADC7_REF_GND			(PMR735A_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
similarity index 95%
rename from include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
index fdb8dd9ae541..812f33872e5e 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-pmr735b.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-pmr735b.h
@@ -10,7 +10,7 @@
 #define PMR735B_SID					5
 #endif
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 /* ADC channels for PMR735B_ADC for PMIC7 */
 #define PMR735B_ADC7_REF_GND			(PMR735B_SID << 8 | ADC7_REF_GND)
diff --git a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
similarity index 93%
rename from include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
rename to include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
index c0680d1285cf..750a526af2c1 100644
--- a/include/dt-bindings/iio/qcom,spmi-adc7-smb139x.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-adc7-smb139x.h
@@ -6,7 +6,7 @@
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
 #define _DT_BINDINGS_QCOM_SPMI_VADC_SMB139X_H
 
-#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
 
 #define SMB139x_1_ADC7_SMB_TEMP			(SMB139x_1_SID << 8 | ADC7_SMB_TEMP)
 #define SMB139x_1_ADC7_ICHG_SMB			(SMB139x_1_SID << 8 | ADC7_ICHG_SMB)
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
similarity index 100%
rename from include/dt-bindings/iio/qcom,spmi-vadc.h
rename to include/dt-bindings/iio/adc/qcom,spmi-vadc.h
-- 
2.25.1


