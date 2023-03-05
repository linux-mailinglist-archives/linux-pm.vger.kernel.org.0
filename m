Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948A6AB31A
	for <lists+linux-pm@lfdr.de>; Mon,  6 Mar 2023 00:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjCEW7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 5 Mar 2023 17:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCEW7u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 5 Mar 2023 17:59:50 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CEFEB60;
        Sun,  5 Mar 2023 14:59:48 -0800 (PST)
Received: from stefanw-SCHENKER ([37.4.248.41]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxDck-1qWX1g1Nxw-00xYl3; Sun, 05 Mar 2023 23:59:32 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-imx@nxp.com, Marek Vasut <marex@denx.de>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 0/6] ARM: dts: imx6ull: Fix dtbs_check warnings
Date:   Sun,  5 Mar 2023 23:58:54 +0100
Message-Id: <20230305225901.7119-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GtTkE+FMcT/7qlg82VO3GhRcLNmmlxmwJQK+2DM18tSNhjOmjYz
 RlUh+VZL4CPuN28s4E6qAUuLcqdmfkWU/nZfI2h3xnkJIzwPYjVs1cyRGvnnJadOqoePamQ
 FZWoZTdPwatw1ElBSrfkRDGPzKNW8LATW4ouumCI2YKei6whGk29YaAK16ghLKQhqi9paXv
 qGKy0EHKzd1eQynMqj5fw==
UI-OutboundReport: notjunk:1;M01:P0:l/oqCQQqwGk=;RwNmjQeUrI3DPhcnyjvnVAicZig
 rNey9t+9w8tBz6UXDR7pODhMt8v3/BHAuSk6iXcAuR/uq888HvwgH9c6uIbAx7FzZWIxYjuYB
 6LszfmnULPBh69PchfYyDz30o7WUom+Nv+A2ugrvtetO/JEeNm/lBzpiaRcLl1pHqGtV9qB0a
 3kW6VwTxGCMYhsVigkTHdDVwA/ZaMtsoMWo0O1ma1PzB9be5B5va5AfLlb1w/AxytilX8rt1U
 pfs9v/iz3DufNRRuo1Bv2moibiyEgMvc+jgP2HrM6lYaYFQsMqdivG0gnfjw4UvhVUHkAkNlJ
 2HGwgN++FY0+UBp1eE73LTI5mibVXlFZpWbIuAcem1/1/iV9RrAQCu3A92l2agaPs1MTlMTiD
 kfTgCIz1zORvKCWjH6RU+V+AvgNLiQN96s9HiHIN8UrMxUtkaT+O0/6WwsAT+qYZwcf568YRH
 MMrrpBEZAeCjrF6eyFC7lq56ZOqEqT9cc+uM66W4UPxeKSp/dvNn4a8Un6g8CHDO6NTFnb97I
 vgYwPK+ev025EBh0nOntdzSlmRhuS7CQRblUTJk7ePl31TpeSRSXP1oLTZO86s2/R68O3/O40
 cP//T70a5QX64p+OO41bLLd/tXi1JS8KkW41/4Ym/0TYwRecASCTbLxpNQo1C/nxtnoVZ53m1
 AQ/MEEkKLEwEBXIHH2qm1vxe2FbJYmlsSDIs7Imjqw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series tries to address some dtbs_check warnings on i.MX6ULL.

Stefan Wahren (6):
  dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
  dt-bindings: imx-thermal: add imx6sll and imx6ul compatible
  dt-bindings: imxgpt: add imx6ul compatible
  ARM: dts: imx6ul: Fix second GPT compatible
  ARM: dts: imx: Adjust dma-apbh node name
  ARM: dts: imx6ul: Add clock and PGC node to GDC

 .../devicetree/bindings/crypto/fsl-dcp.yaml    | 11 ++++++++---
 .../bindings/thermal/imx-thermal.yaml          | 13 +++++++++----
 .../devicetree/bindings/timer/fsl,imxgpt.yaml  |  1 +
 arch/arm/boot/dts/imx23.dtsi                   |  2 +-
 arch/arm/boot/dts/imx28.dtsi                   |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                 |  2 +-
 arch/arm/boot/dts/imx6sx.dtsi                  |  2 +-
 arch/arm/boot/dts/imx6ul.dtsi                  | 18 +++++++++++++++---
 arch/arm/boot/dts/imx7s.dtsi                   |  2 +-
 9 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.34.1

