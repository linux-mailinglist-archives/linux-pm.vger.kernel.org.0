Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009C7524EF
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjGMOSZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjGMOSL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:18:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC8A268D
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f122ff663eso1362873e87.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257889; x=1691849889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClKt2dqGr90pfJCDEIL5kBqRNqWrFunM9K2+lWl18hs=;
        b=NAj+jbiM9Tu8MCcU1PxC+4e3LRO6omJn8LCyx/dBLFTyE8OUFBYmRF50ww0iVxvayg
         fe1ZCuKEmCZEvhGiJ2mkjrfDfyaWlRiN5Zbncm73VFIEGrXvbwJPcUqLS7kpjE+BTf2s
         E/NfyAdJAQkJM9jVer6opth2ysJ1JJqWwG78PwsFs4TqCbf3agpNiGrjCbTJLWArl+e+
         7dwSvmpg89Y1qnZjsCZ5eNDuQFeLrq+0MccYzdfbOmKBvEiaxPtVYY70CJcRi+u7foIx
         7+AHyjtgCQPqP15l5OHGXRre1KP3u7DYUWy/r7ZO+OS1GnyHiqJi35SEQhwtw5CWaEu9
         aljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257889; x=1691849889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClKt2dqGr90pfJCDEIL5kBqRNqWrFunM9K2+lWl18hs=;
        b=l4lZnKsHMDzPCuLHOY9MMsw4QSNgudUS+BIcRH2HWBCsaEiqnBxjrh+NqrtFJg8074
         DhH7CQJyFSqwBoyXOPwNX1FrEuVgevrLV2XBu7fRutvNaen7cRe8MRjfd4eZHnmfoVGR
         QLtYWD2niODiKpKcXGCduC9RDXqdaPwLJtOyvSjgYI3TekO9zklstmBWIVcuqd3M+AHH
         TEOzvAyVihy8zxn/w0CieMiDgvmLPxPgtP9lOsf+V2zJC90C3SFvCNJmqh0+1T+YRdqF
         BUtfvtm79m4uw3vE5cRM6E6SDuCme+Gi8M06XJpBEJvf0jLKFAwYglHr/Y6x9v2MjltU
         jq0g==
X-Gm-Message-State: ABy/qLY8TI3jXJp264JNC8ppMPrpCwilHSKFeQsA4Qc42OA4wLsX7A9R
        RcDUqUIjfBIqFzThhYb2NVF+QQ==
X-Google-Smtp-Source: APBJJlENcUAaIeNwgSOtgl6xNx6O2vsFm/Y12z+f41X65o7DgK13iulXHR6f0m0EzwNjn8xuzHvfaQ==
X-Received: by 2002:ac2:5984:0:b0:4fb:82d8:994d with SMTP id w4-20020ac25984000000b004fb82d8994dmr1223532lfn.42.1689257888710;
        Thu, 13 Jul 2023 07:18:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:07 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] arm_scmi/cpufreq: Add generic performance scaling support
Date:   Thu, 13 Jul 2023 16:17:27 +0200
Message-Id: <20230713141738.23970-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes in v2:
	- Split up the series, to get the basic support in place as the first
	step. The part that remains is the integration with the OPP library, to
	allow consumer drivers to change performance level using the OPP lib.
	- Re-based on top v6.5-rc1.
	- Other changes will be described for each patch.

The current SCMI performance scaling support is limited to cpufreq. This series
extends the support, so it can be used for all kind of devices and not only for
CPUs.

The changes are spread over a couple of different subsystems, although the
changes that affects the other subsystems than the arm_scmi directory are
mostly smaller. The series is based upon v6.5-rc1.

Note that, I am runing this on the Qemu virt platform with Optee running an SCMI
server. If you want some more details about my test setup, I am certainly open
to share that with you!

Looking forward to your feedback!

Kind regards
Ulf Hansson


Ulf Hansson (11):
  firmware: arm_scmi: Extend perf protocol ops to get number of domains
  firmware: arm_scmi: Extend perf protocol ops to get information of a
    domain
  cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
  firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
  firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
  cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
  PM: domains: Allow genpd providers to manage OPP tables directly by
    its FW
  dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
  cpufreq: scmi: Add support to parse domain-id using
    #power-domain-cells
  firmware: arm_scmi: Add the SCMI performance domain
  cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()

 .../bindings/firmware/arm,scmi.yaml           |  11 +-
 drivers/base/power/domain.c                   |  11 +-
 drivers/cpufreq/scmi-cpufreq.c                |  48 ++++--
 drivers/firmware/arm_scmi/Kconfig             |  12 ++
 drivers/firmware/arm_scmi/Makefile            |   1 +
 drivers/firmware/arm_scmi/perf.c              |  60 ++++---
 drivers/firmware/arm_scmi/scmi_perf_domain.c  | 155 ++++++++++++++++++
 include/linux/pm_domain.h                     |   5 +
 include/linux/scmi_protocol.h                 |  18 +-
 9 files changed, 262 insertions(+), 59 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c

-- 
2.34.1

