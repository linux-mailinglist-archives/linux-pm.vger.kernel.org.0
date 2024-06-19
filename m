Return-Path: <linux-pm+bounces-9546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F2890E4F3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 09:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F10228162D
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78606770FD;
	Wed, 19 Jun 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGv8fIjv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE11573441;
	Wed, 19 Jun 2024 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718783665; cv=none; b=LL9rFjF7/5Gcmd8izjoCEipmkfiAZ6mijkTfdF5KT5LsMgJTierFBzpoo5ZULcuY/ZREYxckxK7VjT3bLxz6a+kIlM91d3ai7QnL2iWPoem+h/FLyN8h3MqTBrFFAdMM8pwdLwKwQQdBn660w2FbHXnQ/1nvTkB7WJlxsY8sjJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718783665; c=relaxed/simple;
	bh=LTToapAKP6UAkHaapfTFukux86NCyuG/NWgDBwZJx+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ncWeDfmLUQMIdmFnhBUn62TWKir5GBgFQzQNWl071FA0djUec5nqcZSFnEg4q6fWnv/SeMHFRJvu6thWwXqqTmaD1NR7JM5AaMlttNrT4fqA1EFGdlwHWK8nPNeTL7a4iClts26xJ2qMJRJ++nH9Uerrn/6GgyJ43++B305JKuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGv8fIjv; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42172ed3487so45729405e9.0;
        Wed, 19 Jun 2024 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718783662; x=1719388462; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XrsKFiVHinE6w9PnCKaLFRgdZMnWkq5wpwpgtVbkuk=;
        b=MGv8fIjvwgtYTg5FhtJlLLAwEvurc99x8FUWGARMFoJUjwHx0Bpt1HmLkcS0ey1uOa
         /7r+/4yEvltlZnlyKihXpPVXmh3MwnXhW7hiIO8Pj+R9MfLu1g3vhw+96uj2BOx53JCg
         z7N5QrpftT7dAHMWU7CEDW64Ey/rwvS9YndZhc0TSPdTj2/W0DyaoG1gwFDK8TNErVNl
         wrXWK1in9qxKuFu94aEucjwpZ98KsFsFoyIPoCP1CEumF8NnvtXWFPhlqxpgOR9Vuenu
         M93jVK5yCL8NJqQxJctDhY20Q4CpboUy/4pvAxfwWuJngq9LqKD+RrXCVEsx8buiYstV
         tSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718783662; x=1719388462;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XrsKFiVHinE6w9PnCKaLFRgdZMnWkq5wpwpgtVbkuk=;
        b=FQWOXnOSzi3+CRrqyR7UDcHBhbaiY4wa/l3JegtFPp603oFea0UXe+uRKRT5BMntA0
         b0zQ/ly1ElsItIzQenP/3vlUfbpvJOStNJjt0ge9i+iz+v6himS6h0MNYxwaKosEfmVu
         AujeGrLzwT6/7Bwz3q60dbMtntusLgpRKLxlgqpyeC3TUJTqVRAVPYzZUmEA5dpEE5FU
         0JuLhqPp+C+Fta2VgOWEHyLnEXcIZhYDotFWbiPBc1sXY/jmUv/UyGkVMfMOCxtW9LIF
         j//EN8zvNQvMGH8FzpEdiO7+2HNEMJbGRoarFaeLpxc8+BgqeSj4c5YYqIFQ5DZo5kLo
         27Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWtfR8AzegeN59qlgw3oWZTs0Se8SsLKI3nqC5UJPDhfgtJFaHkyoE4ImRxwunTXTJ44kh55OqsE1yGtQkgxeKy6cmd6g9pn/Uch03tt8hB/wQ4saO3y0t0hVhbAfAJLt3cQWS5WFk=
X-Gm-Message-State: AOJu0YzM8MqI9tQj14R21h+3dQ2Lu6UHn01cIcSAHnT6ZzA609eL1RKR
	HGgyJ02o7U0Uux9+oGZ2IWDY/7V0nT37pt6MYE7ObEPjARdwqIM5QDp8hw==
X-Google-Smtp-Source: AGHT+IE8L3zCAwhnsolM1i/CYCjS6EEhIZCLm8SSTWEQ5e8AFz8tJWfW5iiT0vBqCw3l+Z8i+kwkQQ==
X-Received: by 2002:a05:600c:4a18:b0:422:13b2:584 with SMTP id 5b1f17b1804b1-4247529bc53mr10719335e9.37.1718783661808;
        Wed, 19 Jun 2024 00:54:21 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e71dcsm253030375e9.44.2024.06.19.00.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:54:21 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Wed, 19 Jun 2024 09:54:20 +0200
Subject: [PATCH] cpupower: Change the var type of the 'monitor' subcommand
 display mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKuOcmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0NLXahobn5Kqm5JZUGqbqpFSqqFibFBcnJyohJQW0FRalpmBdjI6Nj
 aWgDB1uVhYgAAAA==
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

There is a type 'enum operation_mode_e' contains the display modes of
the 'monitor' subcommand. This type isn't used though, instead the
variable 'mode' is of a simple 'int' type.
Change 'mode' variable type from 'int' to 'enum operation_mode_e' in
order to improve compiler type checking.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Built and tested this with different monitor cmdline params. Everything
works as expected, that is nothing changed and no regressions
encountered.
---
 tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
index 075e766ff1f3..f746099b5dac 100644
--- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
+++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
@@ -35,7 +35,7 @@ static unsigned int avail_monitors;
 static char *progname;
 
 enum operation_mode_e { list = 1, show, show_all };
-static int mode;
+static enum operation_mode_e mode;
 static int interval = 1;
 static char *show_monitors_param;
 static struct cpupower_topology cpu_top;

---
base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
change-id: 20240619-change-mode-type-e8de8430ccca

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


