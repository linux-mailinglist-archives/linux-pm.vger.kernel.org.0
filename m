Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664A024049F
	for <lists+linux-pm@lfdr.de>; Mon, 10 Aug 2020 12:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgHJKVT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Aug 2020 06:21:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55049 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJKVS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2020 06:21:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k54vb-0007dK-Ea; Mon, 10 Aug 2020 10:21:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpupowerutils: fix spelling mistake "dependant" -> "dependent"
Date:   Mon, 10 Aug 2020 11:21:15 +0100
Message-Id: <20200810102115.62405-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/cpupower/debug/i386/intel_gsic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/debug/i386/intel_gsic.c b/tools/power/cpupower/debug/i386/intel_gsic.c
index e5e926f46d6b..befd837f07f8 100644
--- a/tools/power/cpupower/debug/i386/intel_gsic.c
+++ b/tools/power/cpupower/debug/i386/intel_gsic.c
@@ -71,7 +71,7 @@ int main (void)
 		printf("\tsmi_cmd=0x?? smi_port=0x?? smi_sig=1\n");
 		printf("\nUnfortunately, you have to know what exactly are "
 		       "smi_cmd and smi_port, and this\nis system "
-		       "dependant.\n");
+		       "dependent.\n");
 	}
 	return 1;
 }
-- 
2.27.0

