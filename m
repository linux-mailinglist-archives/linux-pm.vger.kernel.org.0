Return-Path: <linux-pm+bounces-9503-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 814DE90DC4C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8A71F226AF
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 19:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7C161337;
	Tue, 18 Jun 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfCpjrwO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96628160873;
	Tue, 18 Jun 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738488; cv=none; b=GCt7Y8vlPmuLnZoHu19FIwkOUL15sNixwF+CoXtoGNf/9aUfisQuXOqR8qUmcs4tUZaKWDpjZAADxy/U5OeqYGLPoNQKa+rXiWGDpYBUzdlNpMBEd2nXxCDXhO5AeGJvp1nHR1T15YaxMs10fHtRGYbEgRX8W2XoPlLxzTotwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738488; c=relaxed/simple;
	bh=qguTjeAy2Z/scLac/lyof9AClI7qTzDnSmloofIkUn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YDzP1iOzlTcN5ZBS8ykE3kocKN/OjtkVrigOWnBAzAE7PiBDwr3LEqa1ZSL7GJqmmN1zDW59AYDfxolDrL9MCAWUD7+oSA67W667BtFCZ2K6o2bBggkv4k7xcjacQ8GtMDuGeLjbIBL9AuCzRE8gBFaL8yR+Q90W/USahei6Yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfCpjrwO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42138eadf64so47027475e9.3;
        Tue, 18 Jun 2024 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718738484; x=1719343284; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pchh2odHcmU3CdscbrO/Fnxv7MxpmGp5B4JKAi9AQjQ=;
        b=jfCpjrwOe9C3w31A3lWd5bwrK2Ad+iY4Zuq/tLYs8HcnD4uoX6Nvk2iuw6+QK3Sh69
         wwtkasSICfcNt8vaToG9iYWk8UZZmpqfIOs65VUS/yZU+rfa55JA+Mza2+DN+vhfWjlg
         EolBa5Tf2Mw5L8kOox4OBAdwCURfYlZ8b9ySCfzfrPSuc+GEVd3P7KvVxf+T04580zey
         QxvYnXELJclHjF139vuSFwaNASK/tO+otK76WBq7SmOEaV9qxr5+vriGqJeo43A+X9+I
         yhfAclWOBtm2saMqncdvh5eUAezQCjQrVj/L43pMUHPgThxUt2Y6cNlWVJ0CyUNJNSNF
         F/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718738484; x=1719343284;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pchh2odHcmU3CdscbrO/Fnxv7MxpmGp5B4JKAi9AQjQ=;
        b=YsMdMD38EbAuJ+BY5aRZn54Oq7VD1I7g5wXMt8joRvpeJgUBC3cvt97HPRGMPW15LQ
         A4633uMVMTFmnsCW7hXgDyqFC7th9xpV9e4aN3mD5sMubL16Fg/zKeUxPZ8ZitRLkjI2
         0Fds/V1OhzzoF/AE0H7+xbnn2vhKWRCpOKQbCNwoPYlLkOq93+IlIl539vXj5g3Z3g76
         Jn4r3Ff1USH7bKuUg0f487w2pvdZWXc6AaQv7X2kOFw70L30Ipa0Ln5YAXxZxk1ergII
         R9pSB5GygBd6KOGRZLXMzMTly2jjG2I1bO7+GCo1lArpD1WOVYkck35KUi3Gd3gylW7Q
         jeVg==
X-Forwarded-Encrypted: i=1; AJvYcCVj1mCGeiZvZ+WrjItORyp8Slt0dL4tspZBYk7IckXZiPnVROstkn1zY8fkIUARrzXkT+gdYls4KxiefUUphjFsnJM840bJGw9qvlQlaFGaztdPIWzfyxFeQhFz4a4bQekEz4Yf7dI=
X-Gm-Message-State: AOJu0YyT+B4lwX63xZzUNd4Cr6gxdS2EfXEOpLVMUnw65V76Dpz7R6UY
	oud14BJL5qICmi9irvT/5MZb1kxdbynVZqJkrXbCeZcmlSFfX4XxiMYsfg==
X-Google-Smtp-Source: AGHT+IFiit/oGOg9IzPavVOI8qAoio9GqNSaXKOEQvmRE54GqkfQvo1DOqhdp62aPfun+1X/1vKPKg==
X-Received: by 2002:a05:600c:548f:b0:421:a575:99b1 with SMTP id 5b1f17b1804b1-42475293dacmr2579765e9.29.1718738483784;
        Tue, 18 Jun 2024 12:21:23 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm295757f8f.2.2024.06.18.12.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:21:23 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 18 Jun 2024 21:21:12 +0200
Subject: [PATCH] cpupower: Remove absent 'v' parameter from monitor man
 page
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-change-mon-format-v1-1-efa263a8e286@gmail.com>
X-B4-Tracking: v=1; b=H4sIACfecWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0MLXahobn6eblp+UW5iia6xgYGhqbmZYbKpRaoSUF9BUWpaZgXYzOj
 Y2loAtUVeZGMAAAA=
To: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.0

Remove not supported '-v' parameter from the cpupower's 'monitor'
command description.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
There is a '-v' parameter described in cpupower's 'monitor' command man
page. It isn't supported at the moment, and perhaps has never been
supported. When I run the monitor with this parameter I get the
following:

$ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -v
monitor: invalid option -- 'v'
invalid or unknown argument
$ sudo LD_LIBRARY_PATH=lib64/ bin/cpupower monitor -V
monitor: invalid option -- 'V'
invalid or unknown argument
---
 tools/power/cpupower/man/cpupower-monitor.1 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 8ee737eefa5c..991f931cfc38 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -81,11 +81,6 @@ Measure idle and frequency characteristics of an arbitrary command/workload.
 The executable \fBcommand\fP is forked and upon its exit, statistics gathered since it was
 forked are displayed.
 .RE
-.PP
-\-v
-.RS 4
-Increase verbosity if the binary was compiled with the DEBUG option set.
-.RE
 
 .SH MONITOR DESCRIPTIONS
 .SS "Idle_Stats"

---
base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
change-id: 20240618-change-mon-format-30015761c58e

Best regards,
-- 
Roman Storozhenko <romeusmeister@gmail.com>


