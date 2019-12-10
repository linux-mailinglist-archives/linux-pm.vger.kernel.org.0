Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C02C119CD5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 23:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfLJWdd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 17:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbfLJWdc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Dec 2019 17:33:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F572207FF;
        Tue, 10 Dec 2019 22:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017211;
        bh=dGlrQtKk+2i3iVauwHrp2MuaUdZqTCOvi9Gm7Ko0JIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AjGZeC/4VLtMNJuUMNInEaTzTJX0jhNxTegip9q6m7zcDlYE7eizxsSVlZRY0+NjG
         qqhlltC3dR3AvgqI2plOqoAv7LF21eWSiO0r3BJzlG4B4UOwMNBXotYC26hqX+BtYH
         NIYD8idsG9WUKCbxWZNfsTM0IAjNNrmBB1BJtP1g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.4 12/71] tools/power/cpupower: Fix initializer override in hsw_ext_cstates
Date:   Tue, 10 Dec 2019 17:32:17 -0500
Message-Id: <20191210223316.14988-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223316.14988-1-sashal@kernel.org>
References: <20191210223316.14988-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 7e5705c635ecfccde559ebbbe1eaf05b5cc60529 ]

When building cpupower with clang, the following warning appears:

 utils/idle_monitor/hsw_ext_idle.c:42:16: warning: initializer overrides
 prior initialization of this subobject [-Winitializer-overrides]
                 .desc                   = N_("Processor Package C2"),
                                              ^~~~~~~~~~~~~~~~~~~~~~
 ./utils/helpers/helpers.h:25:33: note: expanded from macro 'N_'
 #define N_(String) gettext_noop(String)
                                 ^~~~~~
 ./utils/helpers/helpers.h:23:30: note: expanded from macro
 'gettext_noop'
 #define gettext_noop(String) String
                              ^~~~~~
 utils/idle_monitor/hsw_ext_idle.c:41:16: note: previous initialization
 is here
                 .desc                   = N_("Processor Package C9"),
                                              ^~~~~~~~~~~~~~~~~~~~~~
 ./utils/helpers/helpers.h:25:33: note: expanded from macro 'N_'
 #define N_(String) gettext_noop(String)
                                 ^~~~~~
 ./utils/helpers/helpers.h:23:30: note: expanded from macro
 'gettext_noop'
 #define gettext_noop(String) String
                             ^~~~~~
 1 warning generated.

This appears to be a copy and paste or merge mistake because the name
and id fields both have PC9 in them, not PC2. Remove the second
assignment to fix the warning.

Fixes: 7ee767b69b68 ("cpupower: Add Haswell family 0x45 specific idle monitor to show PC8,9,10 states")
Link: https://github.com/ClangBuiltLinux/linux/issues/718
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index ebeaba6571a38..475e18e043187 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -40,7 +40,6 @@ static cstate_t hsw_ext_cstates[HSW_EXT_CSTATE_COUNT] = {
 	{
 		.name			= "PC9",
 		.desc			= N_("Processor Package C9"),
-		.desc			= N_("Processor Package C2"),
 		.id			= PC9,
 		.range			= RANGE_PACKAGE,
 		.get_count_percent	= hsw_ext_get_count_percent,
-- 
2.20.1

