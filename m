Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B54103C46
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfKTNmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 08:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbfKTNmV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:21 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5DE224FA;
        Wed, 20 Nov 2019 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257340;
        bh=+eCAHDWvaNuOH0t5py/dwIIAgOEWzjEuW1S3XNVtgTo=;
        h=From:To:Cc:Subject:Date:From;
        b=wLfaioBxhp59D+I7bod/1U5No5ftRjkZLfniIM9UVv7TlwYDaQOONXkLXRzMnSrfM
         42vf4ZjcwgwPnM2iI9xsLqyc0F346XPqH2GY+AqYLl2IJFf1bIDtEZrRr2XdbA9ku5
         7Ifn5Ycp0T5mrfbaq/4bj61Joi6rfV0LwlP6iGgE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: [PATCH] devfreq: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:16 +0800
Message-Id: <20191120134216.15713-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 066e6c4efaa2..59027d7ddf2a 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -119,9 +119,9 @@ config ARM_RK3399_DMC_DEVFREQ
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ_EVENT
 	help
-          This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
-          It sets the frequency for the memory controller and reads the usage counts
-          from hardware.
+	  This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
+	  It sets the frequency for the memory controller and reads the usage counts
+	  from hardware.
 
 source "drivers/devfreq/event/Kconfig"
 
-- 
2.17.1

