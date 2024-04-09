Return-Path: <linux-pm+bounces-6089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8E89CF6C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212AB284AD1
	for <lists+linux-pm@lfdr.de>; Tue,  9 Apr 2024 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2679EF;
	Tue,  9 Apr 2024 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvW8GD89"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD979E1
	for <linux-pm@vger.kernel.org>; Tue,  9 Apr 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622722; cv=none; b=fMnLVbQ4RCCW33VRpmqQYpJQy32GiXV6Yni5c/GLD6kyMG7x9C3xGLuWT+iFvrDRTQwJjnLTBOOiuxdtEOwXGtURcUvINqhupv7P23zMpnyuUARlAwAKBAZkzE5VpcVyK3Cc+/gbrituYaC0+7eAKD4qfBVLsP/lXHv2FREM/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622722; c=relaxed/simple;
	bh=noACAgdCsvIYg/IQxOHAXhHxxxcxQkua+DIlMfjkLf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNjE0GE1uAC5zbZXlaxROskAMYo5eRCtpZJpdsnN+aLX1prZsSZ5VkVfbonb2J26nt7YQzJipVdB9I24CnZcfZ3XSeLpF71lfkw/xx97QiU0vtJy+kmTprZ/1rGnpDFKHOuVC/9rkGo3WL8sHYXN/ZPsLhEIMOka5WHJ5NIDe8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvW8GD89; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso5863690276.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2024 17:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712622720; x=1713227520; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StVRKBL98ENz5r+ex0T7UwqmJmohfNVfgYAh1m7P/d8=;
        b=fvW8GD89/pnVNae8RoruOyLAUJag/9ZHzTbAvPrtJn6HKngM0Mv2cUKi7XXdE1LZZ9
         CYtG6pDz/jJhgj54GwKi2FGqVRZDOU6W/o00bt+Hshl+5NJUqZPZcRJOfvpybaMq8E+E
         mknfQwzrZdlnNQlazTYuUOrUg0CXYl2rh3nF1u5wwB7wO6jaNfKx5sW5IUf/Mw0tO8tL
         dGnaKaWyo/h9vsEdTVmuMbPmIh6ZvX+tEFAOwkXcKHp9bHRGcwxCRjOYqrhBMNEbDy7I
         a+Ny2vmROM4vRVgzuS2iUxbABPo8M3nLLGz51eDIdCrwWrAnZVhjNJInGAP5aJWG2yJk
         XWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712622720; x=1713227520;
        h=content-transfer-encoding:organization:reply-to:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StVRKBL98ENz5r+ex0T7UwqmJmohfNVfgYAh1m7P/d8=;
        b=cqMFIZxaDeRaEHqr2CN/OvTwPZfYkl1lMq8YyEbnIhMCvELRxx0CJ2o5wPhdT8gOfU
         7ifaghUo6EHlgzfbU6x0mj7avRvBMFSiqOtwdVsV+AK/D4viScPgMWsotKR76AQWmB9+
         PSG8pOa1Enkuw/nwDAR/A3c1u62NTd3+rtS6au8jiXCvQ14pkEgh+9VyR2blHGnO15jc
         o2YffDOPk/WUhGxB9BSM55CkHYGtTZoFGEiSuItpWvGstlMt4YxdFQLjaq7wAOAUsVua
         XwDw8O4U9fmQAzH8swwpxZpzStjH3PlIcbMQr0EMMZJsmyLde7MAc9Zl5ih1xHsUW8mp
         cfNA==
X-Gm-Message-State: AOJu0Yx/fPVGaa7G54Yyx7G5ysGHzXCLM7q1wiMsk3UzVgFmQ8Z5zD/0
	FxMZQBLF5IJSo8rmzkwvCGKbE+0asOafvICHwFhjEu+YS7NA/h1Ls8QF7CLb
X-Google-Smtp-Source: AGHT+IF1J01Dfae5tdsy/iu3/diw7ZrsjedAFU4GIqgpMvE4luNGEO/Sk9/jRIP2TRiMqQspLZXaUw==
X-Received: by 2002:a25:820d:0:b0:dd0:97e8:74e6 with SMTP id q13-20020a25820d000000b00dd097e874e6mr8073473ybk.55.1712622719645;
        Mon, 08 Apr 2024 17:31:59 -0700 (PDT)
Received: from lenb-Intel-NUC8i7HVKVA.search.charter.net (2603-9000-9f01-67cf-100c-5508-c194-b194.inf6.spectrum.com. [2603:9000:9f01:67cf:100c:5508:c194:b194])
        by smtp.gmail.com with ESMTPSA id h6-20020a25e206000000b00dc74ac54f5fsm1531949ybe.63.2024.04.08.17.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 17:31:59 -0700 (PDT)
Sender: Len Brown <lenb417@gmail.com>
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 18/26] tools/power turbostat: Add selftests
Date: Mon,  8 Apr 2024 20:31:12 -0400
Message-Id: <ca621758890d2dc844384d79e7e1324f4c418a7d.1712621427.git.len.brown@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
References: <e5f4e68eed85fa8495d78cd966eecc2b27bb9e53.1712621427.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 .../testing/selftests/turbostat/defcolumns.py | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 tools/testing/selftests/turbostat/defcolumns.py

diff --git a/tools/testing/selftests/turbostat/defcolumns.py b/tools/testing/selftests/turbostat/defcolumns.py
new file mode 100755
index 000000000000..70d3b7780311
--- /dev/null
+++ b/tools/testing/selftests/turbostat/defcolumns.py
@@ -0,0 +1,59 @@
+#!/bin/env python3
+
+import subprocess
+from shutil import which
+
+turbostat = which('turbostat')
+if turbostat is None:
+	print('Could not find turbostat binary')
+	exit(1)
+
+timeout = which('timeout')
+if timeout is None:
+	print('Could not find timeout binary')
+	exit(1)
+
+proc_turbostat = subprocess.run([turbostat, '--list'], capture_output = True)
+if proc_turbostat.returncode != 0:
+	print(f'turbostat failed with {proc_turbostat.returncode}')
+	exit(1)
+
+#
+# By default --list reports also "usec" and "Time_Of_Day_Seconds" columns
+# which are only visible when running with --debug.
+#
+expected_columns_debug = proc_turbostat.stdout.replace(b',', b'\t').strip()
+expected_columns = expected_columns_debug.replace(b'usec\t', b'').replace(b'Time_Of_Day_Seconds\t', b'').replace(b'X2APIC\t', b'').replace(b'APIC\t', b'')
+
+#
+# Run turbostat with no options for 10 seconds and send SIGINT
+#
+timeout_argv = [timeout, '--preserve-status', '-s', 'SIGINT', '-k', '3', '1s']
+turbostat_argv = [turbostat, '-i', '0.250']
+
+print(f'Running turbostat with {turbostat_argv=}... ', end = '', flush = True)
+proc_turbostat = subprocess.run(timeout_argv + turbostat_argv, capture_output = True)
+if proc_turbostat.returncode != 0:
+	print(f'turbostat failed with {proc_turbostat.returncode}')
+	exit(1)
+actual_columns = proc_turbostat.stdout.split(b'\n')[0]
+if expected_columns != actual_columns:
+	print(f'turbostat column check failed\n{expected_columns=}\n{actual_columns=}')
+	exit(1)
+print('OK')
+
+#
+# Same, but with --debug
+#
+turbostat_argv.append('--debug')
+
+print(f'Running turbostat with {turbostat_argv=}... ', end = '', flush = True)
+proc_turbostat = subprocess.run(timeout_argv + turbostat_argv, capture_output = True)
+if proc_turbostat.returncode != 0:
+	print(f'turbostat failed with {proc_turbostat.returncode}')
+	exit(1)
+actual_columns = proc_turbostat.stdout.split(b'\n')[0]
+if expected_columns_debug != actual_columns:
+	print(f'turbostat column check failed\n{expected_columns_debug=}\n{actual_columns=}')
+	exit(1)
+print('OK')
-- 
2.40.1


