Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48E61BD960
	for <lists+linux-pm@lfdr.de>; Wed, 29 Apr 2020 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD2KTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Apr 2020 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgD2KTJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 06:19:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD701C035494
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:19:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so1821631wrw.7
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 03:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2wu/gy1tHoWVzLeL4pUGCtzvsoDpfDGzq7gpcYUF8tA=;
        b=heZazT2s9kPfyv6NTu8eImJ1nH2p3ed4yDakzZzC7FnVlRzH1gCJG1NnnURFgRzK3q
         RuBBWjVYeTG/cPgj+txQ0EtlgfghyyTWT89izOlRYzwaH4UaM5s3xyqy7k2kKZYZ4ykt
         w76IXMNamSswR1+80emM3I6YbwLXYZaMA9/WMNfUJqRv2v84SBaDkxIbUTG1vMP5MHMr
         MylxeQWHOZhVjPk38iw4Nrz2DE8psD7D6rd1rJ7lgolnAkcJQs4UDEhmMYTpnh56g5iZ
         rnOVwROUSxFUCd28VPqX1PaC0fl99MudLhdWeKFstobGWRY5WOvuHfSjctM/kg34xtgf
         rkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wu/gy1tHoWVzLeL4pUGCtzvsoDpfDGzq7gpcYUF8tA=;
        b=PBoPOZkouWeRCe/sV2PwFRPbEinKrzjZujMkWq4ihxCPyRh62LZakWTCxFU54HEjG/
         J5ijb4+ykRDvJn+t/GWMbZfW4VSaLCXB/y+L4CeXnShq9Z11f4g2LeGL1lzc/gjoWqYX
         vuM33j0N7yxUgGEq3u/xmBMixARXoQV0n9QbK/lXE8TkNg/Z/NZHMGWIoO+fowfAjBvQ
         3whdYTQWce5VgReBxggLCShi18TvYy4C8Xje5kMoaphEd1saZeF/I8WzkSVS5JUOcuhd
         LKFqAurC9zxjmnbs9R1zFm5ur1dU/LhubCQc6qziuhc41Y+cN0HtCd00DUcsa3taj/B/
         Xxmg==
X-Gm-Message-State: AGi0PubiJobN5IKfhGzN82Z1Sgd6U4GPLDt3Ks6/qjQdI9DP+cxsVsRT
        J0pB8x7DvlAHp9TPUAGagfHPbQ==
X-Google-Smtp-Source: APiQypKX51nZ88wriy0wpsyb6PmJdRjnyn5ipdyt18ZbnclL4eiPGgTcPj6kgXejx8si5pSpE/0g2Q==
X-Received: by 2002:adf:ead2:: with SMTP id o18mr22591202wrn.333.1588155547393;
        Wed, 29 Apr 2020 03:19:07 -0700 (PDT)
Received: from localhost.localdomain ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id c20sm7504873wmd.36.2020.04.29.03.19.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 03:19:06 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org, ChenTao <chentao107@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH 1/1] interconnect: qcom: Move the static keyword to the front of declaration
Date:   Wed, 29 Apr 2020 13:19:04 +0300
Message-Id: <20200429101904.5771-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200429101904.5771-1-georgi.djakov@linaro.org>
References: <20200429101904.5771-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: ChenTao <chentao107@huawei.com>

Fix the following warning:

Move the static keyword to the front of declaration of sdm845_icc_osm_l3
sdm845_aggre1_noc sc7180_icc_osm_l3 sdm845_aggre2_noc sdm845_config_noc
sdm845_dc_noc sdm845_gladiator_noc sdm845_mem_noc sdm845_mmss_noc and
sdm845_system_noc, resolve the following compiler warning that can be
when building with warnings enabled (W=1):

drivers/interconnect/qcom/osm-l3.c:81:1: warning:
 const static struct qcom_icc_desc sdm845_icc_osm_l3 = {
drivers/interconnect/qcom/osm-l3.c:94:1: warning:
 const static struct qcom_icc_desc sc7180_icc_osm_l3 = {
drivers/interconnect/qcom/sdm845.c:195:1: warning:
 const static struct qcom_icc_desc sdm845_aggre1_noc = {
drivers/interconnect/qcom/sdm845.c:223:1: warning:
 const static struct qcom_icc_desc sdm845_aggre2_noc = {
drivers/interconnect/qcom/sdm845.c:284:1: warning:
 const static struct qcom_icc_desc sdm845_config_noc = {
drivers/interconnect/qcom/sdm845.c:300:1: warning:
 const static struct qcom_icc_desc sdm845_dc_noc = {
drivers/interconnect/qcom/sdm845.c:318:1: warning:
 const static struct qcom_icc_desc sdm845_gladiator_noc = {
drivers/interconnect/qcom/sdm845.c:353:1: warning:
 const static struct qcom_icc_desc sdm845_mem_noc = {
drivers/interconnect/qcom/sdm845.c:387:1: warning:
 const static struct qcom_icc_desc sdm845_mmss_noc = {
drivers/interconnect/qcom/sdm845.c:433:1: warning:
 const static struct qcom_icc_desc sdm845_system_noc = {

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
Link: https://lore.kernel.org/r/20200423132142.45174-1-chentao107@huawei.com
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c |  4 ++--
 drivers/interconnect/qcom/sdm845.c | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index a03c6d6833df..96fb9ff5ff2e 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -78,7 +78,7 @@ static struct qcom_icc_node *sdm845_osm_l3_nodes[] = {
 	[SLAVE_OSM_L3] = &sdm845_osm_l3,
 };
 
-const static struct qcom_icc_desc sdm845_icc_osm_l3 = {
+static const struct qcom_icc_desc sdm845_icc_osm_l3 = {
 	.nodes = sdm845_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sdm845_osm_l3_nodes),
 };
@@ -91,7 +91,7 @@ static struct qcom_icc_node *sc7180_osm_l3_nodes[] = {
 	[SLAVE_OSM_L3] = &sc7180_osm_l3,
 };
 
-const static struct qcom_icc_desc sc7180_icc_osm_l3 = {
+static const struct qcom_icc_desc sc7180_icc_osm_l3 = {
 	.nodes = sc7180_osm_l3_nodes,
 	.num_nodes = ARRAY_SIZE(sc7180_osm_l3_nodes),
 };
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
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
