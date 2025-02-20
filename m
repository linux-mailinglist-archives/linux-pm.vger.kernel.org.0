Return-Path: <linux-pm+bounces-22558-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB10A3E100
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 764BD7A7EA6
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11790204840;
	Thu, 20 Feb 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUqVdRtN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADF1E32BD;
	Thu, 20 Feb 2025 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069539; cv=none; b=NOZMms87hIAD7Do5faBYEIeb4SozzR7SnvX3RO03Hu8Brp/KJZyyMpg9jANw0xFl4jxIm/MWwR+vvfvBdwIBZOgmKgg1TFchoQSWmFb4cZn3LEjJ/cp8foEi5aaO52p4lXW27jT/DZNhCxRvAQbBEDFgav9R1SYsJsD/O8jBmzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069539; c=relaxed/simple;
	bh=enw3vpdlwjuqr/D+m0WXDrtOqoqKbZbyUyAjN8kC5kY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhnFgR//MqB6tnu6e+7IwZfTTEa2xMwovT36HWiAkRIeX4IpAc21YjfF3hvtAPcYTaYwI4cw7Izk1cQth/1GaP3IIdq+Rsc2XWnAGJhAwRfefGhdPxTH26b0qMm4I61hj5jy5K6Cf95g+au8jtuuYkUUZcb9h57Hm28aUh8PCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUqVdRtN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9b9c0088fso2150223a91.0;
        Thu, 20 Feb 2025 08:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740069537; x=1740674337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YabjOh7WpvJZVKAfwb1a4vLOh26YIuOrbHAk91VmU0g=;
        b=TUqVdRtN9/yxf5DVkmSHnCtF1A1TkNHMsgze9Xl4F44YFzXuw26kP6n2qVvx4775JY
         BSvhtzd64QQGFnJdLI/cSQNgjv244HOuTumKmfwLndR/xcqRE71tuMcPLrW1+ZWy7hXY
         lUKBvD15nVaygEoE8Cyu/EOc1Zm/1E49APP/9eCnMGXzuPj6ONA7tdJiutykRUr2oaU/
         3qmoGw3Z211W4aGaNuEiP73JDchX9aL7Y3jcuvEhH+BVPq3FHw2/Z3GNlbbByNnPh585
         dAMlVvuwHSPkOIJkeBUoQGXSzOi+GHqzc12iyNgSi9vqAGTYYPe6+LE/8Ov0v3NEr4gh
         kpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069537; x=1740674337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YabjOh7WpvJZVKAfwb1a4vLOh26YIuOrbHAk91VmU0g=;
        b=PRoKqgU432PdYIpboU6IocI5NjSGpceKpqRKAKjxfjITVvPO8Yh0vjEjk52JUcnCXN
         Ma68dwajHXtNtqDdhL824qnvTE2WGvbHwWv4QLmfLRqjbbGFA7GdED8IHejrBrsUBUoK
         cQYG7wY2W7jPz2Slwn4bY69M0+jBv97da4x4OetdRVIfudoHapCwDRzEo1kbiSDyizOm
         K3VNOBJeRM7H9vvqKDNgAKqNljU6hlFvs4N9eihb3KOkxdcJBav7npmjolsV+riq0JDB
         aR3bovHxlNy8oH1boU9seMx81jBbw9Y43jW69YSc5UdhXfmYBkf8blmX90q0ItUWoL1e
         39zA==
X-Forwarded-Encrypted: i=1; AJvYcCWw1bFsle1uaKvOl5CsqlNxCM4eGHjIEOVxEbL0eHJ3O34QyvWAqdxB0EWcZEx3oxRRcF99fXK08lOW9ME=@vger.kernel.org, AJvYcCXC3XqEsVsPfvUpH74e+xJQVsONd2HTSL/EGD3cbayc191lInryCPvazerO+2rktbfKjLYDPw+FhxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnqz7QGrIef+95QmUJWNCKwN8/W1Nh8pIaqhUWxxSrX2uZoB7F
	qUrzsZD2ikmaA79n9f6brOIVJWFsn/UB4UTL546lPNxQM5q+vDgojhCZ6mXh
X-Gm-Gg: ASbGnct0ZcsHEneMNExBu3KsmQwVxlI1k7RRAZjJoIhOtwJlxB1i7KTjL3mlDpqxGQE
	KdgzD2+hdxKU6U+7LtI2gfEWDGJjRX7Ezyy18L60lOkgvTA7ucTlkK6FK+ThgHH6doNfsEFDvqM
	CHfjjUAo4O3VzMUZhjywhq4w0MdNP5CbSf9SzKjxYr+kJZKKoLK/MuVsAeMw+D0TpUY0AyO3mdo
	Z7rWhPE2ynBOSELmudXT+Tko/kTCTRPdC+xAejbh9S26KNpRXDsxG+cXAIX+LIrsGffozQLP9aK
	csDnuRD9DbhkLLxIfmDwNKQkylb3RHzep/IMFNbDTYWe4u5hGo8E2GsYFKBD
X-Google-Smtp-Source: AGHT+IHm7I3jyzH88/nJ/wlPRDt1bCVRKuuvraYNrio2tLf0ppW5sSdHzjaLFWilmSVDf6k5FnBX4Q==
X-Received: by 2002:a17:90b:3805:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-2fcccb9cbeemr6782140a91.15.1740069536587;
        Thu, 20 Feb 2025 08:38:56 -0800 (PST)
Received: from localhost.localdomain (59-124-78-18.hinet-ip.hinet.net. [59.124.78.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98cfd66sm16158267a91.12.2025.02.20.08.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:38:56 -0800 (PST)
From: Yiwei Lin <s921975628@gmail.com>
To: trenn@suse.com,
	shuah@kernel.org
Cc: jwyatt@redhat.com,
	jkacur@redhat.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiwei Lin <s921975628@gmail.com>
Subject: [PATCH v3] cpupower: monitor: Exit with error status if execvp() fail
Date: Fri, 21 Feb 2025 00:38:46 +0800
Message-Id: <20250220163846.2765-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case that we give a invalid command to idle_monitor for
monitoring, the execvp() will fail and thus go to the next line.
As a result, we'll see two differnt monitoring output. For
example, running `cpupower monitor -i 5 invalidcmd` which `invalidcmd`
is not executable.

---
V3:
- Modify output message content

V2:
- Check return value from execvp and print message for invalid command
---

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index f746099b5dac..e123aa578881 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -6,6 +6,7 @@
  */
 
 
+#include <errno.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -294,7 +295,10 @@ int fork_it(char **argv)
 
 	if (!child_pid) {
 		/* child */
-		execvp(argv[0], argv);
+		if (execvp(argv[0], argv) == -1) {
+			printf("Invalid monitor command %s\n", argv[0]);
+			exit(errno);
+		}
 	} else {
 		/* parent */
 		if (child_pid == -1) {
-- 
2.34.1


