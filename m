Return-Path: <linux-pm+bounces-17679-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C089D0218
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 06:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DED31F23944
	for <lists+linux-pm@lfdr.de>; Sun, 17 Nov 2024 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968CD14A85;
	Sun, 17 Nov 2024 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="Tn1LpXPS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D440F10940
	for <linux-pm@vger.kernel.org>; Sun, 17 Nov 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731821710; cv=none; b=OvOETvaqKHW5u2vFjnz8Hs27s43JsvWp8vpBx6enTjJNTr5sWlewmsJHGKL7Kxc0ycUG75yDj9UwFnARC3yrI0PSnN+kwHhi2O9KSgR+eeZcKl16yqiEKvNuAnEabed+6Y5ZGmDdQONt5SSSTEevQMYCAcBuqTV5kZ2UFvNQ08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731821710; c=relaxed/simple;
	bh=nzbg6kkkpFsR5AMw/Pd9i3wEU4f0c1iRZEx+0SHEPtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URMt1KHxPWgomt4Zle9fnHn9uPVAWkGtgzlMYo8YTtkEZdVyd4M58vIqTNoCb+Z4prx3VUaf7/MhWcwe3gxf8w81+Aj/RaV8ERVqnbdPUomfyDX1o671hrj/xa2PMaBh6f7S63cVET6RQs54B87Bp0Yt+IFfOxKZgLOXriyDQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=Tn1LpXPS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2120f9ec28eso1027245ad.1
        for <linux-pm@vger.kernel.org>; Sat, 16 Nov 2024 21:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1731821708; x=1732426508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xioySJGJhfYF5zMTYwcy+Zyp7kJH/8KqwR8zz/AHa4=;
        b=Tn1LpXPSjaNNil6bR+B1ufbTQupfezqKi7xe+kEaqMfu3NOwW/b0RtC3JchXSMzj3g
         N1c6g6tv9RadwrJZ/HG+KClNYzqp03Pqqz20m2U/+aHAy0X8DrIyKoxmipVuhhZSTFkH
         dOgllnDqYRqdzHE0kdX3qGkDfltt3q4lNSszf+ua/9wu0OAQLpHLOTvy/wrMs/J/goE+
         qTsCK34I7Zmn+mRoQXpx9jH2aip2MAbDfWo+Gm87DaBAAfi100pnMO6o/czAEKngdHBJ
         JVZgYiCWzKWYWcpsSJYqAytxtYyhPFNTHjV3TdkWlP/6SW1ZdB18vDhJgug/XDHNw6P8
         G1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731821708; x=1732426508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xioySJGJhfYF5zMTYwcy+Zyp7kJH/8KqwR8zz/AHa4=;
        b=sW3N9RApTurd2ueBWAybVGPoEOyQo8A5peq8HXSaw4IpLV6TuUFcAuL/zTTYdORBfO
         YxRXA1zZ/es5zEkiIV46tZ0fFehdz+DnItSl+KmVJrIaiitigSyE0wOicMWnnsb7Rfmx
         DPOXdMryqx1nc3Qu6dIGIlNVgLvT7UcJz8PZtBQjpVpNq7mLmzvaQnJnUjukfdCj7Hbc
         R9UBFaqYlUH83efhE1+V4Gd3jymg1XVP05ZTyqle9I1EXWeHqR6d3fMf88OwPhsEwz3O
         EvDF3NyRXEEhMrv3ccVDHaTGgnHASRmDLttn4m5SYaZXqfu2T0jwZ5wXCc9EXlDwGQr6
         uEcA==
X-Gm-Message-State: AOJu0YyMi0paYYpG1iljr534tLjPuBkrYxqPhwkAyHnhthiBqWG58vQZ
	Mf+R/u8wfNaicjrWoBazVNve++09COZxQl2xmXxqRLiCLp0UWW7ZW1H/S8me
X-Google-Smtp-Source: AGHT+IEQCh0aDWW7PWBo+ILuoIa9T9qcn7UxxLpwkBNZYapl4xbSedztORaO8KpAAbOlgL1ADQKKBA==
X-Received: by 2002:a17:902:e5cb:b0:20c:e169:eb7b with SMTP id d9443c01a7336-211c0f3de99mr168696545ad.14.1731821708015;
        Sat, 16 Nov 2024 21:35:08 -0800 (PST)
Received: from localhost ([2405:6581:5360:1800:96f6:cb09:e09e:fe02])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f119b3f3sm18519845ad.192.2024.11.16.21.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 21:35:07 -0800 (PST)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To: Sebastian Reichel <sre@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Davis <afd@ti.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH v2] power: reset: as3722-poweroff: Remove unnecessary return in as3722_poweroff_probe
Date: Sun, 17 Nov 2024 14:34:43 +0900
Message-ID: <20241117053443.1148902-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return is executed on the devm_register_sys_off_handler() line in
as3722_poweroff_probe, so the last return line is unnecessary. Remove it.

Fixes: 348fde771ce7 ("power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWER_OFF)")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v2: Set correct mail address for Sebastian Reichel.

 drivers/power/reset/as3722-poweroff.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/as3722-poweroff.c b/drivers/power/reset/as3722-poweroff.c
index bb26fa6fa67ca7..8075382cbc3625 100644
--- a/drivers/power/reset/as3722-poweroff.c
+++ b/drivers/power/reset/as3722-poweroff.c
@@ -57,8 +57,6 @@ static int as3722_poweroff_probe(struct platform_device *pdev)
 					     SYS_OFF_PRIO_DEFAULT,
 					     as3722_pm_power_off,
 					     as3722_poweroff);
-
-	return 0;
 }
 
 static struct platform_driver as3722_poweroff_driver = {
-- 
2.45.2


