Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6707385A52
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2019 08:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfHHGNL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Aug 2019 02:13:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45898 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730694AbfHHGNL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2019 02:13:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 910D260595; Thu,  8 Aug 2019 06:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244790;
        bh=dwIXAsZOBU3kUMYddc2Uc4hGfr5PsRFpZuqOH7l1jak=;
        h=From:To:Cc:Subject:Date:From;
        b=FOFeUVny9SUX4zWZHpJSBHUv6mT7vMsf9iSBbbBJIdtDYaOEJY8t01YHP/iaMkYZX
         lLwMGW3GstWHsMJ+BGuqCA/dSpapFa8qs/FcCs3aMS8TSrS3aOFbY610k+2LsmXzSf
         EpUlZ7UccnO/ROMUAlrpsLmOIqBjPSbgygert5AM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCB0C6037C;
        Thu,  8 Aug 2019 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565244789;
        bh=dwIXAsZOBU3kUMYddc2Uc4hGfr5PsRFpZuqOH7l1jak=;
        h=From:To:Cc:Subject:Date:From;
        b=XFeQd/Xvgno7FAj38NLD0h+NxvRdkore8WNXnDCNjUFnzujtGrCBp4yXWRfZvUVYM
         vDKH4/ehuKFXw7OW7Vg1+GfPrj7wLLFqSt/gypN7iWe1XD/jfFcjlbkiDp1VmzVyni
         Spx8ONsRnkiL52riWlZlFDIDgUJwvrDNKX58T0h4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCB0C6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org, mkshah@codeaurora.org
Subject: [PATCH 0/2] Introduce SoC sleep stats driver
Date:   Thu,  8 Aug 2019 11:42:26 +0530
Message-Id: <20190808061228.16573-1-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Qualcomm Technologies Inc's (QTI) chipsets support SoC level low power modes.
SoCs Always On Processor/Resource Power Manager produces statistics of the SoC 
sleep modes involving lowering or powering down of the backbone rails - Cx and
Mx and the oscillator clock, XO.

Statistics includes SoC sleep mode type, number of times LPM entered, time of
last entry, exit, and accumulated sleep duration.

This series adds a driver to read the stats produced by remote processor and
exports using sysfs.

Maulik Shah (2):
  dt-bindings: Introduce soc sleep stats bindings for Qualcomm SoCs
  drivers: qcom: Add SoC sleep stats driver

 .../bindings/soc/qcom/soc-sleep-stats.txt     |  36 +++
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/soc_sleep_stats.c            | 249 ++++++++++++++++++
 4 files changed, 295 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/soc-sleep-stats.txt
 create mode 100644 drivers/soc/qcom/soc_sleep_stats.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.

