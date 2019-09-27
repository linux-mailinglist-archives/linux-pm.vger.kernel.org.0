Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 108B7C098C
	for <lists+linux-pm@lfdr.de>; Fri, 27 Sep 2019 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfI0Q1O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Sep 2019 12:27:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40752 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfI0Q1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2019 12:27:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so3816721wru.7;
        Fri, 27 Sep 2019 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lCuiRbFgOSM4Ubgy+288vYl4eCNEBz3B+rKFzHjDeg=;
        b=ARglq3II831kl9SJpiHk4BObl5q90bachb52+Bz99uKW4lGlE2FLntfVndzQk6D9JD
         YYHLNqZrw03Il/uC5HESYuFjzeo922UfFEZV7pQQERANNqK48OftLcLpMFBOULa0Vqtn
         8SavKkE13AJISWTaJxCiaxQIlRKyHnvpq6vjaruVBo2ML/LuOHKkZ/ma23nd807n2AVW
         lw9HmXPGaOJEcBRGQZOVKQ5kt2lrmbphjXS0pC02to4zeqcW5nna2KpGNvcKCPbL29Y0
         xoliAF4lln25vM1eHoYq68gYbvdpBum5rL1IriHOSBpVT8lL9K41fogVYiOSRbqwhvLA
         Vlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2lCuiRbFgOSM4Ubgy+288vYl4eCNEBz3B+rKFzHjDeg=;
        b=pBkySAobYllzN21lTplyeN5htB6cAMUglv2yeuML/VbsJ+cuNbgdC79eArLFLTwKut
         i9bQ1nSe+cUH6Ccr9aBQa5ILzspskLMymbdy27tzxxIO6/dIDWwrzTGHgD13rLElTW8X
         Y4VbAEHBX0br76oXnwaosW8TEmI8T7ViVg9/rMNscwDM3I9eWrft21wLCNLKsIjG38/a
         Vfvuubvfhnm7fc9hUPTUZ4IOlsw0OZC8tkDT6SXBj6Wvu9aj7Ge2L9A7ElSj5JWV+ABz
         zYsWi9UKU/IB4EL+1vthe5XqpkKWNDGnhqFjWOSl0Llxy4CB3rEw9VulbF1+DVB2s7a9
         y2GQ==
X-Gm-Message-State: APjAAAVsFoqh5aNz7Ua/AexS4RUfEsoG9/bcrh0KZ/wMx5ChgIVM6fo3
        VcFe9AyePPGGhGiLAAxWdm+AQvBB
X-Google-Smtp-Source: APXvYqwepQ/8jJXnJ4c/0HgbDtzW+vuzmS0Fjhppbh3cGGqW+DRpiG8aeCciTNrretkSXaoh2vvI7w==
X-Received: by 2002:a05:600c:2052:: with SMTP id p18mr7841656wmg.13.1569601629706;
        Fri, 27 Sep 2019 09:27:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id o19sm7609986wmh.27.2019.09.27.09.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 09:27:09 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] tools/power/cpupower: Fix initializer override in hsw_ext_cstates
Date:   Fri, 27 Sep 2019 09:26:42 -0700
Message-Id: <20190927162642.2292584-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

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
---
 tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
index 7c7451d3f494..58dbdfd4fa13 100644
--- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
+++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
@@ -39,7 +39,6 @@ static cstate_t hsw_ext_cstates[HSW_EXT_CSTATE_COUNT] = {
 	{
 		.name			= "PC9",
 		.desc			= N_("Processor Package C9"),
-		.desc			= N_("Processor Package C2"),
 		.id			= PC9,
 		.range			= RANGE_PACKAGE,
 		.get_count_percent	= hsw_ext_get_count_percent,
-- 
2.23.0

