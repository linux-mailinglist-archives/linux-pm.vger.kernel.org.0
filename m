Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3944AD2
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfFMSiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 14:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbfFMSiN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Jun 2019 14:38:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C061208CA;
        Thu, 13 Jun 2019 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560451092;
        bh=mCeTL7k6bagP7YI+YzWTIBqj23rm7VuKVFZ3HMOfpZU=;
        h=Date:From:To:Cc:Subject:From;
        b=uREaLO0oEkfJtBwIh15u3Z2XsoMRSh2tWjKbYRz5hSRkYHSrreLsaFmCDrtGTrelh
         jGHXkEVzYiS1TBi8LOZ7xaI/XlaLaTVqKs8yNB68HjDd2j6z6+TdzwTmQBJ0iz5qou
         /WxL1Ln+bau2jZ1saixMaKQxG8H6Wt9bAeH/zwAw=
Date:   Thu, 13 Jun 2019 20:38:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] thermal: intel_powerclamp: no need to check return value of
 debugfs_create functions
Message-ID: <20190613183810.GC32085@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index ac7256b5f020..39c6b589f2ed 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -713,17 +713,9 @@ DEFINE_SHOW_ATTRIBUTE(powerclamp_debug);
 static inline void powerclamp_create_debug_files(void)
 {
 	debug_dir = debugfs_create_dir("intel_powerclamp", NULL);
-	if (!debug_dir)
-		return;
-
-	if (!debugfs_create_file("powerclamp_calib", S_IRUGO, debug_dir,
-					cal_data, &powerclamp_debug_fops))
-		goto file_error;
 
-	return;
-
-file_error:
-	debugfs_remove_recursive(debug_dir);
+	debugfs_create_file("powerclamp_calib", S_IRUGO, debug_dir, cal_data,
+			    &powerclamp_debug_fops);
 }
 
 static enum cpuhp_state hp_state;
-- 
2.22.0

