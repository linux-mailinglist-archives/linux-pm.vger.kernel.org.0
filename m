Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76F3318CB1
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhBKNvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 08:51:53 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:33552 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232185AbhBKNtu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 08:49:50 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11BDlpMn007387;
        Thu, 11 Feb 2021 05:49:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=YmkCPSy4LnAclW31OySWPKpjYg4msFSDLJ3PxqY/wLk=;
 b=MpXe3EyjbDzQRzKG9t7e71sTWj+KLdOYLUlVPYZvZqLz5cHvPUsQNroD0nrsO1MCeSP7
 KoQLY9X/ap62klbeU33DHfCBWuK6FZLP4G4suv/+0kqgHQI3ZaErUuESZJM82BOXk0p0
 sQ6of71BFxaJWuHhx8HdNptPsKQPd3/q7PhM7HavCl9V40JaxuLfHsZKO445c/W7cMMK
 63OtCQu0ouwU/NucD/KtyEKlXsBFu7gvIZNrE2JD/QwFW9kf6oIkB/PVX8pjXt7+UZJ3
 gDLOPSgfpfhqqLdi5a3prS9vZRhodVs1u+63UiPhUrDH4uZzMAR6QyZaLgIP4uf1wivC NA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrq5en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 05:49:00 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 05:48:58 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 05:48:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 05:48:58 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id C582F3F703F;
        Thu, 11 Feb 2021 05:48:54 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-pm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Julia.Lawall@inria.fr>, <amitk@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <miquel.raynal@bootlin.com>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH 0/2] Enable usage of Marvell FW SIP services
Date:   Thu, 11 Feb 2021 15:48:50 +0200
Message-ID: <20210211134852.23648-1-kostap@marvell.com>
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
* fix build errors and rebase on clk-next branch

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

