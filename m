Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5014D1B5577
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgDWHQz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 03:16:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2875 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgDWHQy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 23 Apr 2020 03:16:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 298ADE534613296DEEAC;
        Thu, 23 Apr 2020 15:16:49 +0800 (CST)
Received: from [10.166.212.221] (10.166.212.221) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 23 Apr
 2020 15:16:47 +0800
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
From:   "chentao (AS)" <chentao107@huawei.com>
Subject: [PATCH] qcom:sdm: move the static keyword to the front of declaration
Message-ID: <ae29b195-3529-e993-0219-cbf86ac4281a@huawei.com>
Date:   Thu, 23 Apr 2020 15:16:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.212.221]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following warning:

Move the static keyword to the front of declaration of sdm845_aggre1_noc
sdm845_aggre2_noc sdm845_config_noc sdm845_dc_noc sdm845_gladiator_noc
sdm845_mem_noc sdm845_mmss_noc and sdm845_system_noc, resolve the following
compiler warning that can be when building with warnings enabled (W=1):

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
  drivers/interconnect/qcom/sdm845.c | 16 ++++++++--------
  1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c 
b/drivers/interconnect/qcom/sdm845.c
index b013b80caa45..f6c7b969520d 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -192,7 +192,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
      [SLAVE_ANOC_PCIE_A1NOC_SNOC] = &qns_pcie_a1noc_snoc,
  };

-const static struct qcom_icc_desc sdm845_aggre1_noc = {
+static const struct qcom_icc_desc sdm845_aggre1_noc = {
      .nodes = aggre1_noc_nodes,
      .num_nodes = ARRAY_SIZE(aggre1_noc_nodes),
      .bcms = aggre1_noc_bcms,
@@ -220,7 +220,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
      [SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
  };

-const static struct qcom_icc_desc sdm845_aggre2_noc = {
+static const struct qcom_icc_desc sdm845_aggre2_noc = {
      .nodes = aggre2_noc_nodes,
      .num_nodes = ARRAY_SIZE(aggre2_noc_nodes),
      .bcms = aggre2_noc_bcms,
@@ -281,7 +281,7 @@ static struct qcom_icc_node *config_noc_nodes[] = {
      [SLAVE_SERVICE_CNOC] = &srvc_cnoc,
  };

-const static struct qcom_icc_desc sdm845_config_noc = {
+static const struct qcom_icc_desc sdm845_config_noc = {
      .nodes = config_noc_nodes,
      .num_nodes = ARRAY_SIZE(config_noc_nodes),
      .bcms = config_noc_bcms,
@@ -297,7 +297,7 @@ static struct qcom_icc_node *dc_noc_nodes[] = {
      [SLAVE_MEM_NOC_CFG] = &qhs_memnoc,
  };

-const static struct qcom_icc_desc sdm845_dc_noc = {
+static const struct qcom_icc_desc sdm845_dc_noc = {
      .nodes = dc_noc_nodes,
      .num_nodes = ARRAY_SIZE(dc_noc_nodes),
      .bcms = dc_noc_bcms,
@@ -315,7 +315,7 @@ static struct qcom_icc_node *gladiator_noc_nodes[] = {
      [SLAVE_SERVICE_GNOC] = &srvc_gnoc,
  };

-const static struct qcom_icc_desc sdm845_gladiator_noc = {
+static const struct qcom_icc_desc sdm845_gladiator_noc = {
      .nodes = gladiator_noc_nodes,
      .num_nodes = ARRAY_SIZE(gladiator_noc_nodes),
      .bcms = gladiator_noc_bcms,
@@ -350,7 +350,7 @@ static struct qcom_icc_node *mem_noc_nodes[] = {
      [SLAVE_EBI1] = &ebi,
  };

-const static struct qcom_icc_desc sdm845_mem_noc = {
+static const struct qcom_icc_desc sdm845_mem_noc = {
      .nodes = mem_noc_nodes,
      .num_nodes = ARRAY_SIZE(mem_noc_nodes),
      .bcms = mem_noc_bcms,
@@ -384,7 +384,7 @@ static struct qcom_icc_node *mmss_noc_nodes[] = {
      [SLAVE_CAMNOC_UNCOMP] = &qns_camnoc_uncomp,
  };

-const static struct qcom_icc_desc sdm845_mmss_noc = {
+static const struct qcom_icc_desc sdm845_mmss_noc = {
      .nodes = mmss_noc_nodes,
      .num_nodes = ARRAY_SIZE(mmss_noc_nodes),
      .bcms = mmss_noc_bcms,
@@ -430,7 +430,7 @@ static struct qcom_icc_node *system_noc_nodes[] = {
      [SLAVE_TCU] = &xs_sys_tcu_cfg,
  };

-const static struct qcom_icc_desc sdm845_system_noc = {
+static const struct qcom_icc_desc sdm845_system_noc = {
      .nodes = system_noc_nodes,
      .num_nodes = ARRAY_SIZE(system_noc_nodes),
      .bcms = system_noc_bcms,
-- 
2.17.1


