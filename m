Return-Path: <linux-pm+bounces-10760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC792A285
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 648C41F227D6
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518487F48C;
	Mon,  8 Jul 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vkLbade8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517B3C08A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jul 2024 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441379; cv=none; b=DX2u2VBn9o01IZ0hG0TS/Uum1A1ElTcWaCEY38QNXYqf7ACPhTndbWjujuSC2j/YemPLZ7l+03II9KtPJRaxUZeupawy4kdGZRDRqoLQDwVq1OgkIGraOr+sQjwcVgfrMIDm6sUcxFAiYl5FZ7Na3oR+e6YFUAsJ0uyjyHyX95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441379; c=relaxed/simple;
	bh=MAHjih4/z8a5oFeoIniEUkXxcdOXeRNLt/JayAbbDow=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sml1qLHgJmIR3IfDHQN0pzb+O5BypT1i3OM04d5I0IoBJ3p6tsU6LHpie0OTquqtQyf+hkSni+rDAPggHd2/CDNz5iWMYXAVLQT61l1V4fQeiraGr6g73UR+TfuwTc13jThyZ9iJSUVfglY8eiZzrekmeVhuKB2ccVIt6sp1nx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vkLbade8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77d85f7fa3so401341566b.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jul 2024 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441375; x=1721046175; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq79+KMVKV19LMA76rLpTjDXYJBOLbA44znePN4XGqI=;
        b=vkLbade8MYXZVrFVjxC+iyS2o1YtKup08Gdykb0qHJU3N8XfzWPYIhZW1Hjtgkc6aW
         srqu81jTUnKiAJgIOw8Gl/z3hLH8quBL6QxsSAYH+GA2HnJS/QBcGtS8IDE0h+tqjbib
         GeKA2OHOz5PJYYNQHDVipRLKJwMvrSOPFrumMoNIl5SqBo3bT9FePO7ySJ8cHQ3RPCxu
         yo25VAzLRHMK5P6BsYBFBrOX6sUDMLpOcZ/NuraV2bnXDKEB+rCSyeENHEyF7KCS4/Yu
         /n1nW4tEai/U3ZJJZfoFAdItKteMVZmfdED2GFXvEyoBbfVYAajbIuHpQPwxOh+M8sl1
         WiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441375; x=1721046175;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq79+KMVKV19LMA76rLpTjDXYJBOLbA44znePN4XGqI=;
        b=UWNM9EEK5/Ev8dbuyGqJ/anoNg3YqH5zqQE0NHEiTKcGbVlAMFbbvv/Bx3pXmtbtim
         QJ3QzN7DpG9mWzkGUKdQVJQIeoMgkNZ/OdxebPFVcPYkXJhgDZq4ZgTRZfs3kIJ63pGI
         ovjU14VpLTZn/PpiJqZqLs3KBdtFDo6G1fW5yAhVEZjjYiAHl+Z+D+oZ0es16BDP4bhg
         uKPhnF81b218iaQFCZ7eIdaRYQzvD9yPYUI5UFhviLNOr6N3ritza5QZDznnhZjEfSTV
         2yS3K4/1fyHhk9CKfVoXnys2WvtwNPlBQ6WeMPn9MwSHQY/8ZrvH0THd8XdOB4y2XBEG
         omeA==
X-Forwarded-Encrypted: i=1; AJvYcCVRtwPuqAJjv3+iX32XcyWFwBCCnlmyE/h895j0ggNl5xASaCZGZjXfkOGLEI/aloQxTersS6kfo495PGXQ2r84tQ3gSUjQXhM=
X-Gm-Message-State: AOJu0YwpXwzYIwC9EsEuLur4Bllzb29e+VLfOhx8mGpYowUInYqx4LQU
	d6sklDI2XrF9Vj8wcaG3s9DrQj0vnMJSI0/ViuetWsD31YbJtcopGwnDqPDAgV0=
X-Google-Smtp-Source: AGHT+IH7U0uVpJeA0Ty3MuvcRh0QSliM+atpFry3MmGqLPZvauklqgd2sXsxvqr9mrrvh3+MWmdzEQ==
X-Received: by 2002:a17:906:6a93:b0:a77:a1f1:cfa0 with SMTP id a640c23a62f3a-a77bdae45eamr842007766b.36.1720441374772;
        Mon, 08 Jul 2024 05:22:54 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:22:54 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v15 00/10] Add support for Core Power Reduction v3, v4 and
 Hardened
Date: Mon, 08 Jul 2024 14:22:31 +0200
Message-Id: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfai2YC/33QwWrDMAwG4FcpPs/Dsp1k7WnvMXaQLbkxBCfYX
 dgoefepvY2MHPWL7xforhrXzE1dTndVec0tz0UG6F5OKo5YrqwzSaCssc5YGPRtXnLUcalu1MT
 W2ZCCHzgqEQEb61CxxFFM+ZomCZfKKX8/b3x8yjzmdpvrz/PkCuYR/98uS210PyDTW6KEPbxPu
 WCdX+d6VY+qFeCIg/CA1gZPiB31e26PuBUO6Ml0hoH7Yc/dEXfCyUBMCWLnY9pzf8S98HMiebA
 Hf3b0h2/b9gsLZPUuuwEAAA==
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=10219;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MAHjih4/z8a5oFeoIniEUkXxcdOXeRNLt/JayAbbDow=;
 b=TEnHuTS02MwkDmnGUgOjQfQKhm7k3OlUT/8DfyQoF1cDqhVSKbrYYYdOqGDPWMPAqQ3ul0ntf
 H4PqTqyXOePCaTjVR2k5HdahRu52zZ934XRdLi6q134nJ0ZfQiKbqot
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Changes in v15:
- Rebase (incl. genpd -> pmdomain rename)
- Change the maintainer to myself
- Drop tested-bys
- Rewrite some commit messages
- Temporarily drop CPR3 support (easy to add back, adds complexity and
  requires more testing.. unnecessarily slowing down this already 3+
  years old series)
- Boring style changes (fix indentation etc.)
- Sprinkle a lot of dev_err_probe to make failures meaningful at all
- Fix some misleading comments
- Rename the "cprh" power domain to "perf"
- Allow and mark the CPR OPPs as shared
- Include fixes equivalent to Varadarajan's (over at:
  https://github.com/quic-varada/cpr/commit/f025f13a2e64b13c8e7866bedc3bfa73f2aaf162)

DT check for the last patch fails with:

Warning (unique_unit_address_if_enabled): /soc@0/qfprom@784000/rosel3-pwrcl@218: duplicate unit-address (also used in node /soc@0/qfprom@784000/rosel2-pwrcl@218)

but that's.. intended.. so I assume it's fine for now..

This can be fully tested along with the CPUFREQ changes, which can be
found (in a bit of a dirty/not-100%-ready but working state) here:
* https://github.com/SoMainline/linux/commits/topic/cpr3hh/

- Link to v14: https://lore.kernel.org/r/20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org

Changes in v14:
- Rebase
- Drop cpufreq probing block (merged)
- Pick up tags
- Drop quotes from CPR3 bindings $id:
- Drop useless description: under compatible:
- Link to v13: https://lore.kernel.org/r/20230217-topic-cpr3h-v13-0-d01cff1c54cf@linaro.org

Changes in v13:
- blacklist -> blocklist in cpufreq commit message
- rebase atop drivers/genpd introduction
- remove quotes in cpr bindings
- describe reg entries in cpr bindings
- define the # of power-domains in cpr bindings
- pick up tags
- Link to v12: https://lore.kernel.org/r/20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org

Changes in v12:
- Add the !independent! patch to block cpufreq-dt from probing on 8998 (it tries
  to when we attach OPP tables to the CPU nodes)
- Include all promised changes to the CPR3 driver from v11 (I managed to
  send the wrong version of that patch last time around..)
- Partially rewrite debugfs code (to make it work and be cleaner)
- use FIELD_PREP/GET throughout the driver (managed to squash a bug when
  exploring that)
- Fix and finish the removal of cpr_get_ro_factor() by introducing
  cpr_thread_desc.ro_scaling_factor_common
- Replace underscores in node names with '-'
- Fix some formatstring issues that clang apparently doesn't care about
- Link to v11: https://lore.kernel.org/r/20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org

Changes in v11:

CPR COMMON:
- split the commonizing patch, make it actually do what it says on the
  tin..
- fix some overflow bugs

CPR3:
- fix some overflow bugs
- don't assume "lack of qcom,opp-?loop-vadj" means val=0"

CPR BINDINGS:
- drop quotes in items
- drop clock-names (there's just a single one)
- rewrite the description a bit
- fix up the example
- drop bogus minItems
- "acc-syscon" -> "qcom,acc"

DTS:
- fix qfprom children so that the bits=<> doesn't overflow reg[size]
- drop unrelated changes
- place one reg entry per line

Link to v10: https://lore.kernel.org/r/20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org

Changes in v10:
- Skip "Let qcom,opp-fuse-level be a 2-long array" (Applied by Viresh)
- Use b4 (it may be the first time you're receiving this if git send-email
  omitted you before..)
- +Cc Robert Marko (expressed interest in previous revisions)
- Add "Document CPR3 open/closed loop volt adjustment"
CPR:
- %hhu -> %u (checkpatch)
CPR BINDINGS:
- Drop QCS404 fuse set (it doesn't use this driver, what did I even think..)
  but leave the allOf:if: block for expansion (sdm660, msm8996, ipqABCD should
  follow soon..)
- Drop Rob's R-b (as things changed *again*, please take one more look to make
  sure you're okay with this file, Rob..)

Link to v9:
https://lore.kernel.org/linux-arm-msm/20230116093845.72621-1-konrad.dybcio@linaro.org/

Changes in v9:
- Restore forgotten MAINTAINERS patch (oops)
CPR:
- Include the missing header (big oops!)
- Fix kconfig dependencies
CPR bindings:
- Fix cpu reg in example (why didn't dt_binding_check scream at that)
- Add newlines between nodes in example
- Change opp table node names to opp-table-cpu[04]
- Change opp table labels to cpu[04]_opp_table
- Change CPRh opp subnode names to opp-N from oppN
- Remove some stray newlines
- Bring back nvmem-cell-names and add the 8998's set
- Allow power-domains for VDDCX_AO voting
- Remove Rob's r-b, there's been quite a bit of changes..
CPR DT:
- Send the correct revision of the patch this time around..
OPP bindings:
- Add Rob's ack

Link to v8:
https://lore.kernel.org/linux-arm-msm/20230110175605.1240188-1-konrad.dybcio@linaro.org/

Changes in v8:
- Overtake this series from AGdR
- Apply all review comments from v7 except Vladimir's request to
  not create the include/ header; it will be strictly necessary for
  OSM-aware cpufreq_hw programming, which this series was more or
  less created just for..
- Drop QCS404 dtsi change, account for not breaking backwards compat
  in [3/5]
- Add type phandle type reference to acc-syscon in [1/5]
- Update AGdR's email addresses for maintainer entries
- Add [2/5] to make dt_binding_check happy
- Separate the CPRh DT addition from cpufreq_hw addition, sort and
  properly indent new nodes
- Drop CPR yaml conversion, that happened in meantime
- Reorder the patches to make a bit more sense
- Tested again on MSM8998 Xperia XZ Premium (Maple)
- I take no responsibility for AGdR's cheeky jokes, only the code!

Link to v7:
https://lore.kernel.org/lkml/20210901155735.629282-1-angelogioacchino.delregno@somainline.org/

Changes in v7:
- Rebased on linux-next as of 210901
- Changed cpr_read_efuse calls to nvmem_cell_read_variable_le_u32,
  following what was done in commit c77634b9d916

Changes in v6:
- Fixes from Bjorn's review
- After a conversation with Viresh, it turned out I was abusing the
  OPP API to pass the APM and MEM-ACC thresholds to qcom-cpufreq-hw,
  so now the driver is using the genpd created virtual device and
  passing drvdata instead to stop the abuse
- Since the CPR commonization was ignored for more than 6 months,
  it is now included in the CPRv3/4/h series, as there is no point
  in commonizing without having this driver
- Rebased on v5.13

Changes in v5:
- Fixed getting OPP table when not yet installed by the caller
  of power domain attachment

Changes in v4:
- Huge patch series has been split for better reviewability,
  as suggested by Bjorn

Changes in v3:
- Fixed YAML doc issues
- Removed unused variables and redundant if branch

Changes in v2:
- Implemented dynamic Memory Accelerator corners support, needed
  by MSM8998
- Added MSM8998 Silver/Gold parameters

This commit introduces a new driver, based on the one for cpr v1,
to enable support for the newer Qualcomm Core Power Reduction
hardware, known downstream as CPR3, CPR4 and CPRh, and support
for MSM8998 and SDM630 CPU power reduction.

In these new versions of the hardware, support for various new
features was introduced, including voltage reduction for the GPU,
security hardening and a new way of controlling CPU DVFS,
consisting in internal communication between microcontrollers,
specifically the CPR-Hardened and the Operating State Manager.

The CPR v3, v4 and CPRh are present in a broad range of SoCs,
from the mid-range to the high end ones including, but not limited
to, MSM8953/8996/8998, SDM630/636/660/845.

As to clarify, SDM845 does the CPR/SAW/OSM setup in TZ firmware, but
this is limited to the CPU context; despite GPU CPR support being not
implemented in this series, it is planned for the future, and some
SDM845 need the CPR (in the context of GPU CPR) to be configured from
this driver.

It is also planned to add the CPR data for MSM8996, since this driver
does support the CPRv4 found on that SoC, but I currently have no time
to properly test that on a real device, so I prefer getting this big
implementation merged before adding more things on top.

As for MSM8953, we (read: nobody from SoMainline) have no device with
this chip: since we are unable to test the cpr data and the entire
driver on that one, we currently have no plans to do this addition
in the future. This is left to other nice developers: I'm sure that
somebody will come up with that, sooner or later

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
AngeloGioacchino Del Regno (6):
      dt-bindings: soc: qcom: cpr3: Add bindings for CPR3+ driver
      soc: qcom: cpr: Move common functions to new file
      soc: qcom: cpr-common: Add support for flat fuse adjustment
      soc: qcom: cpr-common: Add threads support
      soc: qcom: Add a driver for CPR3+
      arm64: dts: qcom: msm8998: Configure CPRh

Konrad Dybcio (4):
      MAINTAINERS: Include new Qualcomm CPR drivers in the file list
      dt-bindings: opp: v2-qcom-level: Document CPR3 open/closed loop volt adjustment
      dt-bindings: opp: v2-qcom-level: Allow opp-shared
      soc: qcom: cpr: Use u64 for frequency

 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   16 +
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    |  286 +++
 MAINTAINERS                                        |    5 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  760 ++++++
 drivers/pmdomain/qcom/Kconfig                      |   22 +
 drivers/pmdomain/qcom/Makefile                     |    2 +
 drivers/pmdomain/qcom/cpr-common.c                 |  362 +++
 drivers/pmdomain/qcom/cpr-common.h                 |  109 +
 drivers/pmdomain/qcom/cpr.c                        |  394 +--
 drivers/pmdomain/qcom/cpr3.c                       | 2711 ++++++++++++++++++++
 include/soc/qcom/cpr.h                             |   17 +
 11 files changed, 4314 insertions(+), 370 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20230217-topic-cpr3h-de232bfb47ec

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


