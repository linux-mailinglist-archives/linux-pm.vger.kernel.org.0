Return-Path: <linux-pm+bounces-18867-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A845F9EA130
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 22:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2651664B5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017CD199E88;
	Mon,  9 Dec 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7mCcaYL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA249652;
	Mon,  9 Dec 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779409; cv=none; b=Bwg2a/4st8rPRmQ2WJmW8R3nkr+pZRAyv6xLxGivUKRuGIyiZNBWqeNEiVWWCWH384JjWKPrP6ghpzcGHHKqsc/hx4P0NgQQ4Lcuuvf7CfA1U78VQmFY5Pp5DWe1jldnixcMbVrp+HiVSs6bOdRl1hMAirIYJdvfHDo2fQSWdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779409; c=relaxed/simple;
	bh=9d+tXAJwrm1VcVoEcEyuuE2OXR2lpshS3t61asi/CMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ulusWcqKdvuA8IeJ1MIHbY4nv8mnAjUje2/rm2IsWiLKm/5zUz62sYUv5Z6q6m51/pva0Gz5wLDXGuzh/nl2FINbOT0NhPp/K7p1V0wK0E1B3g8x97ECL2d+RQoLiCMFNtWOBDD8y4kFKCCvHz9tZP2y1d/s4fSkDrARFxg140c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7mCcaYL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d34030ebb2so6386379a12.1;
        Mon, 09 Dec 2024 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733779406; x=1734384206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1pWQ6LqAWq3YV7o4EcNDWS2na1ucsk/w9jiAbBxSzS4=;
        b=f7mCcaYLMnKXXBxkFpv4/EtQLQKVXmWSyK1ES4qjdymDdye8d+vQ+lIw6TzGMd2Fzn
         kqhiYnBW/N07/fzvKqpT4z8GWyrEr5XKSWMpuJS9YtZ4zhLadgiz0Ug1TRMeq97nyKEa
         pbyvazNXxvgfVqD/bT5OZ+quH2/0fIKzs/ADPFkOg1i+l+BpYD9MoP3jvo9T+jeSiVIC
         FdAjTz17X21mKZmu4jGc76D0LAhMKMPXUlx1bHtwAzH0Z99ldBnxG0beQ8wKAp6S2CF2
         wRNcdUawLsMINwGzDhm+9DCpWg1hwIEdtKE/EKIuhlTDhD7pA0LezGvfTg3uJJP8IbE2
         9f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733779406; x=1734384206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1pWQ6LqAWq3YV7o4EcNDWS2na1ucsk/w9jiAbBxSzS4=;
        b=N11XzCHFFPL4V4jHRuP5CoZc3fkmkA8ypN3kI24G09wxgy6uc/TOker6FjKA3oHG6s
         CJLV6WOkjESeziH9JnduZB0+eBrFbvSdzVWIIPWuVQwOP/UZdYNgJPxJ+FQO8mV64tnh
         EaApmdGcQO4NSzW73VVjVGqJSnt+D6nLVKEp4nCJSgOAWS3iQ+1Bf7mK1dLI0LGxLPyU
         UIysfzYzfXsqLIcpbft6HxKknA1QOxlAEM4BhFAVuRwlnfyWHcf57NvmPuAc9DpNZWP/
         qW4Fn6zoS8jUXqhF70snHT7XlkanqYnek9MkeA97r2GzsPjqHtZQUI/eYSbFG6pgXLBW
         DDLg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUT0CTAo/vtf3wTlir2cQwfCWoiYJd7xBh4/u5jKZ09+TZpHG1pwdc3KNp6CLxlOTz/Sha4hzQxFp0rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgN8/VSQ01pmxI4W4blc+Sg2mwPlz0LKe/99uDWdPd271Og6ne
	9luEv8eihERDGwRkfcNfvOK/C/WSaympu9j4t2PaipOpoc2M0hHayCrbdNjD
X-Gm-Gg: ASbGncugT0CW11zaQp/IJijhg0T2oOu6aH7Q1aSUyN0JBbvJEhSQKbCZ8OX6ZZH0irm
	74687yZJyL2Hd9RkoD862tNZTBMoKCULB/O/xFmQfiEOsBxgywnhn/WGB909Gh3l4OwFsYKuYQp
	euTmtvSdPE/1kKxpzPbZhakMr0hIjcOCqqExMXj3cJOWcq5vDMj9COyivZgpb7cltm3GKVix/Nb
	sJ3DhOaJ78neR/fypKBG9c/mnxXhpvFAWydcbb9fz1PkS8TR5Yyo3tMOFiM7Taa
X-Google-Smtp-Source: AGHT+IF+T0oM82qRTIyqK1e8qxpc4r5pk57QyDxoxhiHuouPRXUE8dptHMMq4JSTWO62fjFkw3Dp7g==
X-Received: by 2002:a05:6402:35c6:b0:5cf:c33c:34cf with SMTP id 4fb4d7f45d1cf-5d418566d08mr2749217a12.15.1733779406221;
        Mon, 09 Dec 2024 13:23:26 -0800 (PST)
Received: from localhost.localdomain ([83.168.79.145])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ea09245bsm3352923a12.78.2024.12.09.13.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 13:23:25 -0800 (PST)
From: Karol Przybylski <karprzy7@gmail.com>
To: karprzy7@gmail.com,
	samuel@sholland.org,
	sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] power: supply: Fix uninitialized variable in ip5xxx_battery_set_property
Date: Mon,  9 Dec 2024 22:23:23 +0100
Message-Id: <20241209212323.71228-1-karprzy7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable vmax in the ip5xxx_battery_set_property function is used uninitialized when passed to switch/case statements.

This patch initializes vmax to 0 at declaration.

Issue discovered in coverity, CID 1602239

Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
---
 drivers/power/supply/ip5xxx_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ip5xxx_power.c b/drivers/power/supply/ip5xxx_power.c
index 4bcf0ea0e..65d3266c3 100644
--- a/drivers/power/supply/ip5xxx_power.c
+++ b/drivers/power/supply/ip5xxx_power.c
@@ -541,7 +541,7 @@ static int ip5xxx_battery_set_property(struct power_supply *psy,
 {
 	struct ip5xxx *ip5xxx = power_supply_get_drvdata(psy);
 	unsigned int rval;
-	int ret, vmax;
+	int ret, vmax = 0;
 
 	ret = ip5xxx_initialize(psy);
 	if (ret)
-- 
2.34.1


