Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677EF54022C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jun 2022 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244976AbiFGPMt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jun 2022 11:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiFGPMt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2022 11:12:49 -0400
X-Greylist: delayed 533 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 08:12:47 PDT
Received: from smtp.ruc.edu.cn (m177126.mail.qiye.163.com [123.58.177.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82D2CFE
        for <linux-pm@vger.kernel.org>; Tue,  7 Jun 2022 08:12:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp.ruc.edu.cn (Hmail) with ESMTPSA id EEBBA8009E;
        Tue,  7 Jun 2022 23:03:50 +0800 (CST)
From:   Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] power: supply: cros_peripheral: Use struct_size() helper in kzalloc()
Date:   Tue,  7 Jun 2022 23:03:44 +0800
Message-Id: <20220607150344.30669-1-xiaohuizhang@ruc.edu.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUIfTx5WT0tMGkJCTEpDQk
        IfVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kzo6Dyo4GD00Dxc8MzcXDTwD
        Kk0aCytVSlVKTU5PTUpPSUhKT05IVTMWGhIXVQMSGhQTDhIBExoVHDsJDhhVHh8OVRgVRVlXWRIL
        WUFZSUtJVUpKSVVKSkhVSUpJWVdZCAFZQUpCSUI3Bg++
X-HM-Tid: 0a813eb188442c20kusneebba8009e
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Similar to the handling of cros_usbpd_charger_ec_command in commit 441d38c60fbe
("power: supply: cros_usbpd: Use struct_size() helper in kzalloc()"),
we thought a patch might be needed here as well.

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
---
 drivers/power/supply/cros_peripheral_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 9fe6d826148d..1379afd9698d 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -63,7 +63,7 @@ static int cros_pchg_ec_command(const struct charger_data *charger,
 	struct cros_ec_command *msg;
 	int ret;
 
-	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
+	msg = kzalloc(struct_size(msg, data, max(outsize, insize)), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
 
-- 
2.17.1

