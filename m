Return-Path: <linux-pm+bounces-22390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38EAA3B1FA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 08:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626EB7A13CA
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C81C07EE;
	Wed, 19 Feb 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j04rs2L5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812BF1C07DD
	for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739948875; cv=none; b=giYXn7QvoUb+/9wiK7nucAE+n7rbHPAfyHaHROYz8JmXu2QdrsLM63uOKDIXvQKTWqT2FBxSL09V+9fN57YJBs2qTfjFWVlTNSy8aENVraCq3dLeGEMsrrrAD2Yri5rV5L72ZBMNoUA4tEVw1eWPJkvb3gJ0Ba9iiSi8WIas0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739948875; c=relaxed/simple;
	bh=tRuwH6VxRqvMDaFXAUrYgi5POr3+De0fDLCYrpPVI5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JbekybDWFVhqGZODJ5YlTiz5fVVocGp/JptXm0/m5tPdZpYdgOAVmgyKluyBxdxgkxcREd0VB5u6NN4Jq+FZM5/DN/h7mxiOdF4813LsY4rD/LTxyLoS0cgYNimRBLsaPvFt1HFJP6Ii1eweRQzAMNwqJP+mrS3OMJJVGWeWCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j04rs2L5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220bfdfb3f4so128787435ad.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 23:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739948874; x=1740553674; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JySMFlXLgdYY+/iNRAMB6CwpEhlF84xeDqxk+lfquv4=;
        b=j04rs2L5VjnYxKPG8Wv78XJaLmBflmAfIEhMy2mrfV0e29VC0R9TD3WsqTt0EzzPNv
         cgsAS8m+KV+e/VVnHu8UTiRXd7VIqw3VrirlQ5TQy2jHmJB1J+3m5zL7NPMg5zF/0J1J
         Zt15+tLNBSv3BMQKMOzetcLtUMy9a2PmvENoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739948874; x=1740553674;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JySMFlXLgdYY+/iNRAMB6CwpEhlF84xeDqxk+lfquv4=;
        b=iR18EJHML2F7NZshc4DLxBmD877u//AIsWIaZ1ivIwtgs1cUe9w9HsE8ihzuqDl0M7
         4S9/4icyzwKXkOCYnlhdAT9ixCKmXbSzfXTB2CstdPO9BeYXb721KJ28k2SppuXkDO+5
         2EVugo8Q1ZjzI9HSMG98MG9QDMMQTb2o61A/Wf4SRTckIKbuNwWxW7SW9Y0Pxepehj23
         GYssQObRuuP5OAAeMyvROxdLh0LoeZ03iu13iycSA+/RvgC6CgyC5iRtPtQmWLGWG0Na
         lBmlxdpfPtc2p6fWeZ5yd7eKPLwcgKvWag16ZPzFhhaSEkKiBC5hqUR3PFY2OMJ5peH8
         PurQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeUnWbP35wnzTG0MqazqCZmsmVgu2PsixyvNhdGMIJ3EqBZ2HlonSj4r82Cxk8ARGIJZyQmGyYRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4zlkWb4xu9rLmHymOQ4yR3E6eBQ12+W0lMlKBqD1bWvpaduwx
	+xW1ELvQiejxaXiWUUxQEe3RgXJIKjVkJVWqKJqxgiRVNDXm1MuZSmfk6J0peA==
X-Gm-Gg: ASbGnctBXnHPvfnS6ih3oHdwQTzZ9CDm6b/vGZBx8Raxl3Gtw+fOeM3DioPvXT5yxLC
	TLSaOffiLrPJv1bhL7Z+/fvK75C+IvxA24XDdJdOc21IutEzCp9pU6/Sly/qUnOmgM+ZZyl7nvS
	1UIX8Pt6eq/PHC3tjQufW2U0Eplht0ELZ0WTHu/mbs/sFWMXxwFbth82WqKkOGlm2Tb+AFNYX4M
	SuOoEV10ByXxBkYXIemzZaeFGCUTFm0eptmTo0t9F7e9F+0e7DfGuTD1w/isnumhae5m3SvGnY0
	Vp2hUjmsKKRy9PgRu8OcGLEaWeJfcoYC34I=
X-Google-Smtp-Source: AGHT+IFNCLC327Tbgy3w8769F53bRAzhUse9206vwI6TMenlf9TyIK/Yx1MUEoN25QE8Ttyi6D3/xg==
X-Received: by 2002:a17:902:e746:b0:216:69ca:770b with SMTP id d9443c01a7336-221707775a6mr40769815ad.12.1739948873793;
        Tue, 18 Feb 2025 23:07:53 -0800 (PST)
Received: from giver-p620.tpe.corp.google.com ([2401:fa00:1:10:224f:3294:90fd:ad2d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d051sm97789835ad.108.2025.02.18.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:07:53 -0800 (PST)
From: Yu-Che Cheng <giver@chromium.org>
Date: Wed, 19 Feb 2025 15:07:48 +0800
Subject: [PATCH] thermal: gov_power_allocator: Fix incorrect calculation in
 divvy_up_power
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-fix-power-allocator-calc-v1-1-48b860291919@chromium.org>
X-B4-Tracking: v=1; b=H4sIAESDtWcC/x2MQQqEMAwAvyI5G4hlFfEr4iHtRg0UK6moIP59y
 x4HZuaBLKaSYageMDk1a9oKNHUFYeVtEdRvYXDkWnJNj7PeuKdLDDnGFPhIhoFjwJnIf9h3LXm
 Gku8mxf2vx+l9f0Pr6xpqAAAA
X-Change-ID: 20250218-fix-power-allocator-calc-f00b4ab650ba
To: Lukasz Luba <lukasz.luba@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chen-Yu Tsai <wenst@chromium.org>, Yu-Che Cheng <giver@chromium.org>
X-Mailer: b4 0.15-dev-42535

divvy_up_power should use weighted_req_power instead of req_power to
calculate the granted_power. Otherwise, the granted_power may be
unexpected as the denominator total_req_power is weighted sum.

This is a mistake during the previous refactor.

Replace the req_power with weighted_req_power in divvy_up_power
calculation.

Fixes: 912e97c67cc3 ("thermal: gov_power_allocator: Move memory allocation out of throttle()")
Signed-off-by: Yu-Che Cheng <giver@chromium.org>
---
 drivers/thermal/gov_power_allocator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 3b644de3292e..3b626db55b2b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -370,7 +370,7 @@ static void divvy_up_power(struct power_actor *power, int num_actors,
 
 	for (i = 0; i < num_actors; i++) {
 		struct power_actor *pa = &power[i];
-		u64 req_range = (u64)pa->req_power * power_range;
+		u64 req_range = (u64)pa->weighted_req_power * power_range;
 
 		pa->granted_power = DIV_ROUND_CLOSEST_ULL(req_range,
 							  total_req_power);

---
base-commit: 2408a807bfc3f738850ef5ad5e3fd59d66168996
change-id: 20250218-fix-power-allocator-calc-f00b4ab650ba

Best regards,
-- 
Yu-Che Cheng <giver@chromium.org>


