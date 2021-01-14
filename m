Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB32F5EB9
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 11:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhANK2P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 05:28:15 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39660 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbhANK2P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 05:28:15 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EAPAHK015418;
        Thu, 14 Jan 2021 02:27:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=woUyolyurnTezvvaSPzeuvOj7ryhJiz94lX6g9eo9xA=;
 b=cKqaTRKhFMTlBUJUc2DVJxUsuAXMESGcw0HJcBGMnJJ7avgCdPvGoEHHPDmYA9WpCoTO
 ils1EuWhsaNg2LzjcfUpEJcTYIkyoIvfhGbDAjBe22pxw/MwkBciDfiaS0T9ZLdEhuYQ
 uATp+0Rcyt9G+Yo8G3fmp/0VTh46xsgRHTLLemaYXWZccBAn0MLdiPPHPxci0mc7NSyB
 zlOURexqrHRl+eIKwX2j3n+IftfCuyEhArYyivSJ0/7rHXe6y3YN+Q8blP2lwdGpDRWY
 I5Kjwm0M3icU7acGGKFk5DX8M4CEsUvHpfyxRYcYuDsxkKMDFjMQ6W2P7LfY4bCaMq0k og== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35ycvpxknt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 02:27:28 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 02:26:52 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 02:26:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Jan 2021 02:26:52 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 292F63F704A;
        Thu, 14 Jan 2021 02:26:48 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-clk@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <miquel.raynal@bootlin.com>,
        <rui.zhang@intel.com>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v2 0/2] Enable usage of Marvell FW SIP services
Date:   Thu, 14 Jan 2021 12:26:41 +0200
Message-ID: <20210114102643.16108-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_03:2021-01-13,2021-01-14 signatures=0
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


Grzegorz Jaszczyk (2):
  thermal: armada: ap806: use firmware SiP services for thermal
    operations
  clk: mvebu: use firmware SiP service for accessing dfx register set

 drivers/clk/mvebu/ap-cpu-clk.c    | 168 ++++++++++++++++++--
 drivers/thermal/armada_thermal.c  | 125 ++++++++++++++-
 include/soc/marvell/armada8k/fw.h |  22 +++
 3 files changed, 296 insertions(+), 19 deletions(-)
 create mode 100644 include/soc/marvell/armada8k/fw.h

-- 
2.17.1

