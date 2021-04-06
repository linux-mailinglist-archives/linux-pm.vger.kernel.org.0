Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630F6354FB4
	for <lists+linux-pm@lfdr.de>; Tue,  6 Apr 2021 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbhDFJTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Apr 2021 05:19:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16345 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244823AbhDFJTi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Apr 2021 05:19:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FF23f5s0mz94Ck;
        Tue,  6 Apr 2021 17:17:18 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.179.202) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 17:19:21 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
        "Zhang Rui" <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] thermal: ti-soc-thermal: Remove duplicated header file inclusion
Date:   Tue, 6 Apr 2021 17:19:11 +0800
Message-ID: <20210406091912.2583-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v1 --> v2:
Arrange all included header files in alphabetical order.


Zhen Lei (1):
  thermal: ti-soc-thermal: Remove duplicated header file inclusion

 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 35 ++++++++++++++---------------
 1 file changed, 17 insertions(+), 18 deletions(-)

-- 
1.8.3


