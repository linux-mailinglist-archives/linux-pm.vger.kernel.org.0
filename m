Return-Path: <linux-pm+bounces-9694-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FD910ACE
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 092C11C21886
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851261B012E;
	Thu, 20 Jun 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQe17xob"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC651AC434;
	Thu, 20 Jun 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899049; cv=none; b=Th+TaivM2ZRP1DkyDy1y6MUxO3Fx27AOpFz4xp8B9nbC75KGfpy8zCOwhh2v1teRzwgp+eASU9Lo2EBmdxd6OSp0Q+i9VfXSJV0EQ7eAnMfeBrIvrw5vsfWQJL6gcUQ6r7mtbSgcjHOfltbAdfIk3p0hWs8VwcoTDlhgB+NjfqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899049; c=relaxed/simple;
	bh=IBg9FOGrtf0ZUWzjrhDktAzEEfLTaDQH7ZEscHxRINE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f1uWl84dIPnY5rqVtfWsMWvGGNldu1pGQl494g6iXCTwj/rqJs5XfZNp1BAUobegZBSWFok8unVlYSVNsDCMbW6vft47LqmwNHbAvV05XjSmdvqvd0HPz5u1XFS/KRe/5MXw1Hab57WJC6jjDGKPfSHmvNM0CClVgMQp/tOGrGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQe17xob; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso12075291fa.0;
        Thu, 20 Jun 2024 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899046; x=1719503846; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeSVlqKZrBZNAMEMX13RYK8sjXiLSAEea+d1BM4/W0E=;
        b=HQe17xobM98igJoxwn7t4Ay5Q3fCiTH5IcV/8ohUfFRyyEdaE1MGM9zw1E7PL8xk+C
         yvkDioHdzp8tepnAGHberBT6GGr57TTn2TgnL5z8+C4kSeXq/mhl/UV5ha9zDQEDe2Q7
         T8ntPiPnFTu1d6EgdWwqVJt6ZeJhRdVWkSKX38BFjmE8khCSN+J1VbSC+9M/jl2s3xfw
         AHGi63pxDZvQ/feiycvfLzTmcgp9qBBoOrQd3WUsgpg1qlSqdu3nUGIANu0VcD8RQHBI
         IITHIsm50gBBpFFs6UA0aZaC34IdhyzgltbXmnHUZA8FrSMk58ukoAcr97NhGuJJ/83B
         nK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899046; x=1719503846;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeSVlqKZrBZNAMEMX13RYK8sjXiLSAEea+d1BM4/W0E=;
        b=faPZtkEjSq3OGb10HHUHmetv9tEx9PhbqIxEwo/kKaSxA/qSzVGVALen40MCXRAT9f
         SC92+tPTAUF9kwGD+eFeBrMJ+WEQDXeQj3WFON+hDZb1EEENwFccMVs/MMAqo4yAGhmn
         Ci19V3sL1ttZe3AORgWeadUW5VA58xMzhgTh+iLZ6xRhhywtcBet6tJhi+LB+v9NlHHM
         8dvsIHcW4yZYkbXS+aFH8LgIX/Zj+eiQeQvrOvg8pDRwmiyIRxmfJuH4RSqIjCuv88t1
         ThWeXBUPr97uXVMCc4Mnl9frIaXEV9IwXgXXnyVIbT+p4mQ3f3lT4KvejxqntKmkdnwu
         PbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxKV31UWs08V2pp3WCZwtd9zP0XeeKkOSSvAlHpEXJKciZ3UybbMvo0RocaCw0vcI/DIfkGTL6cX0+PikoOx0OzEnHKlj1ZWdSuIrhX/KUWeGOvjYF+1UroYc8rXohxZSZeJGQmjw=
X-Gm-Message-State: AOJu0YzN19+1ZIkXXqv6w4LtC6GTYoxOC0sQP72GUzDnhhax6Vr/VILs
	N+ZHSrTQH9+fLJf/xXo5JALrMd6uIJ3iqFxdr7o5EoAYpkmKFS4fPvGJ5w==
X-Google-Smtp-Source: AGHT+IEazplnmw4eOPCYrxAvRGqz0UYJMJ2y36T6UieRc1EqAYYCDc80ytg/Guepa/j5TjgCKBxKDw==
X-Received: by 2002:a2e:9699:0:b0:2ec:4399:9bff with SMTP id 38308e7fff4ca-2ec4399a3c8mr21779441fa.42.1718899045416;
        Thu, 20 Jun 2024 08:57:25 -0700 (PDT)
Received: from [127.0.1.1] (31-179-0-202.dynamic.chello.pl. [31.179.0.202])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d1046dbb7sm1790680a12.81.2024.06.20.08.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:57:25 -0700 (PDT)
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 20 Jun 2024 17:57:23 +0200
Subject: [PATCH v2] cpupower: Change the var type of the 'monitor'
 subcommand display mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-change-mode-type-v2-1-8c3a499be64e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGJRdGYC/32NwQ7CIBAFf6XZsxigqNiT/2F6ILBtN5HSQENsG
 v5dbDx7nEnevB0SRsIEXbNDxEyJwlxBnhqwk5lHZOQqg+RS8au4s5/1wSFbtwUZaodatdxaa6D
 OlogDvY/ks688UVpD3I6HLL72TywLJlgr8IbqwqUe+GP0hl5nGzz0pZQP/bST+LAAAAA=
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
Built and tested this with different monitor cmdline params. Everything
works as expected, that is nothing changed and no regressions encountered.

Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
---
Changes in v2:
- Moved cover letter content to the change log
- Link to v1: https://lore.kernel.org/r/20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com
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


