Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B8596D19
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 12:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiHQKyo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 06:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiHQKyn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 06:54:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8120B5D124;
        Wed, 17 Aug 2022 03:54:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBCC113E;
        Wed, 17 Aug 2022 03:54:43 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26A1E3F67D;
        Wed, 17 Aug 2022 03:54:40 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        dan.carpenter@oracle.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/3] Add ARM SCMI Powercap driver
Date:   Wed, 17 Aug 2022 11:54:21 +0100
Message-Id: <20220817105424.3124006-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

this short series builts on top of recently introduced SCMI v3.1 Powercap
protocol to implement an ARM SCMI Powercap driver which takes care to
expose via the Powercap framework all the SCMI Powercap zones that have
been discovered asking the SCMI platform firmware.

Basic testing has been performed against an emulated SCMI platform
supporting SCMIv3.1 Powercap protocol using powercap-utils.

A couple of fixes spotted with Smatch by Dan are queued on top of the
driver itself; these may have to be squashed finally into the driver itself
(with the Fixes tags removed) but for now I have just added them here as
patches on top, for clarity and to preserve authorship.

The series is based on v6.0-rc1:

Thanks,
Cristian

Cristian Marussi (1):
  powercap: arm_scmi: Add SCMI Powercap based driver

Dan Carpenter (2):
  powercap: arm_scmi: Fix signedness bug in probe
  powercap: arm_scmi: Fix a NULL vs IS_ERR() bug

 drivers/powercap/Kconfig             |  13 +
 drivers/powercap/Makefile            |   1 +
 drivers/powercap/arm_scmi_powercap.c | 545 +++++++++++++++++++++++++++
 3 files changed, 559 insertions(+)
 create mode 100644 drivers/powercap/arm_scmi_powercap.c

-- 
2.32.0

