Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810A8318CF3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 15:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhBKOGM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 09:06:12 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13260 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231293AbhBKODw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 09:03:52 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BE1XbY022387;
        Thu, 11 Feb 2021 06:02:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=0elgG08z95Mp0bp42T6eKXc/pbp6nML5TVGVwcbMJp0=;
 b=WsFZJYLcM4JpHGrj1V7DI6O8kqunBbE5yjECzMZO8zhr7wRheTYRWnp+Ck4edr4JfoCw
 +1RsHw2TsJzxUIINxmGprMOY6VyU7J6igYkh42j+GhvtJvmYisbPy8pTec19ZzpEf7vn
 0w/FNvlGqSWUnLSjWvfWX+XZ9ELmmywGYtZ4te+4xu2tAZi4pnjv+ogCa4ikLWx2qOHE
 y5bEyH0EE6OJkywDCuIo8rtvFy+6q87io+ZSIq8gg0pAalbiZ0s4MoNj7uXTjDt86ILW
 6wpKw3zXUcWsu5L8nF3s6dC3kC7jzDct8Vqm65kyDiOT2uH6tlCpO2RaE8to2K0jvSt9 XQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqew71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 06:02:49 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 06:02:47 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 06:02:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 06:02:47 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 8E5B63F7040;
        Thu, 11 Feb 2021 06:02:43 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Julia.Lawall@inria.fr>, <amitk@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <miquel.raynal@bootlin.com>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 0/2] Enable usage of Marvell FW SIP services
Date:   Thu, 11 Feb 2021 16:02:38 +0200
Message-ID: <20210211140240.23778-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_06:2021-02-10,2021-02-11 signatures=0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

These patches enable usage of Arm Trusted Firmware SIP services on
Marvell Armada plaforms for accessing system registers that are not
normally accessible from kernel or user space (EL1/EL0), like DFX
registers group.

v2:
* use separate legacy/smc regmap functions registered at ap-cpu
  clock driver probe according to FW response

v3:
* fix build errors and rebase on top of clk-next branch

Grzegorz Jaszczyk (2):
  thermal: armada: ap806: use firmware SiP services for thermal
    operations
  clk: mvebu: use firmware SiP service for accessing dfx register set

 drivers/clk/mvebu/ap-cpu-clk.c    | 174 ++++++++++++++++++--
 drivers/thermal/armada_thermal.c  | 125 +++++++++++++-
 include/soc/marvell/armada8k/fw.h |  22 +++
 3 files changed, 302 insertions(+), 19 deletions(-)
 create mode 100644 include/soc/marvell/armada8k/fw.h

-- 
2.17.1

