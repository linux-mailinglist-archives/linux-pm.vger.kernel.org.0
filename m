Return-Path: <linux-pm+bounces-27385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C159ABCDAE
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 05:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFBC3AC7A2
	for <lists+linux-pm@lfdr.de>; Tue, 20 May 2025 03:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634C255E32;
	Tue, 20 May 2025 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFVxMPTl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7551C860B
	for <linux-pm@vger.kernel.org>; Tue, 20 May 2025 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710568; cv=none; b=F44DzNAAMbATZsZHxgfdNaLZMHWygcNCzN9tnnRl0xkmnN9SEYPK5N6HmEcFPFUDtXSEROVSzqFTLusthlWxIHHfBKvBXdihNqrqUFcS5dsoOe67HRDiUlk6Thetx6G+WKQALtMevDqi8W3knTo8gvTzvZYgZJwcedHOGYjPAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710568; c=relaxed/simple;
	bh=WFIJhpj8kHnoZQR/hf5HHxL5h/aWV/NOwBwPTu1YjSo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHgwwIVmILF63O2qg4bdB977240IJVUXaCg/NZ/WWYlazo90VLhIiPpJCZJ2dBgQxYig+z7IIL0gISAGVkCSkx618IboPuM4jssTPDquo+FTZdbLZIvY6gkfkuL1bR1k+AIl7LiX4b0Ick8w39GMaSUsF5SzWOMVuZ8oK5SsFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFVxMPTl; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b061a06f127so3383609a12.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 20:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747710566; x=1748315366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUyeLkns9IfRG/8V3c0lYiMThv/MhJAXlf6Hx02ddXI=;
        b=YFVxMPTliWwpltk/wNTz/c0RagzeB5F4fSwBeDhE5nooc5FkupBY55HE6gFRvSaTmw
         IUDeRmzisV9N5Dh6tjzz3fNcmMYJsgXpEwmZX75AJDduTalHvPtLCEJyFO+GSTLmK3+8
         La/jkcB1jxLpN2XDJQIO/Twc/HW87PgeRpGaA9sJ16NDPdqsqK1qBPYZj8VNVTL6Elpj
         WvAkvFIrd2Ub00hGfdBkdcuCvTAorSvv2INcK19zCDhMsGHTdf6fk1jjcrojVoYfBzvI
         Gtax/WEq77KhzsXPKYrz1XZXo+BmuPaphxFvQH9HVYWuPtq9cU/JNE32DpMwrA/fJEW3
         pcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747710566; x=1748315366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUyeLkns9IfRG/8V3c0lYiMThv/MhJAXlf6Hx02ddXI=;
        b=uWPA8rUAAOi6B5ovaZjNpT27Ou6CUprNMLdcVLuv1tYKNwyTtQpmjQy5BLbQ3n7CQh
         Qi+RPgx2CBxInzG+VvTzYl/DQxVeXhDwByACVW7dwEaHfT3SC5bZ4XKqUM/DhNU7vsKs
         CFDh5XhiSh6iOzgu8ZH/YUiuI1wWh04pWLfFMPc8OmwFSdXhgV7md+UMrvok8MnqUhaV
         1lmmxoc5ZUOCsxzVHyMwMWsi2DV0o6cuuWDlWWIEiu6SPxpg85XHIWDq01cKBALRo8x2
         PLhQVqgv4aMAiGESZ74dvIle/Wrx8JeioYeoiD5zYLf4DgBLQ0Olaz7mTofofAnTv6ra
         ffzg==
X-Gm-Message-State: AOJu0YxDJ/VHbWP408GvO5rIgCDfIztixceEGX5J51aVP2+4hIRckUeQ
	iemSHaEk45H025Fty0gDVAZcK0W4c3LemNfs5tt0egh0fDBOAY50xghQ
X-Gm-Gg: ASbGncsmpL2Dj5z/pvP1Ss8NYgRgPUtrWVb6j0K8DQlrN5EzZ7TufOVXl3j9yGBbspp
	iWA7fdTNvstIV4qGkfhPo0hcW1jHLs0/7LxobiVQ7TRN+PCTprgqyTYDQtqJ0LENnANzkncphxs
	ARATj3R7rEB9hc0S75g3ARxG+lNKwFgWI/AbR8DFDdX2oOCme38cnlcjCPws1fe1qwOSQGnxx1p
	oKOPzUOQJCO2JPWHBHPMGtlNH+PnfLLOhpnzgIiQldkoQk87fJedOZdJIdZO2ACpIcU1FtGG7eI
	0rCOCuKIWsGIhKL5olFhvzCmFoQwV8v4Wje9eo/GkYdG7vGPXEfhLty6EU2S
X-Google-Smtp-Source: AGHT+IF1EH0S3UJO61+AOv7LmyvrKoE7wCgmqSnvQt+pg4Z0TcfIVg12LADlSjYbkzb6uK+SWxpsnw==
X-Received: by 2002:a17:903:94f:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-231d45a9aa0mr232819085ad.40.1747710566294;
        Mon, 19 May 2025 20:09:26 -0700 (PDT)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e9784bsm67167645ad.113.2025.05.19.20.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:09:25 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [PATCH] cpuidle: add tracepoint for enter_s2idle flow
Date: Tue, 20 May 2025 11:09:22 +0800
Message-Id: <20250520030922.9505-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tracepoint cpu_idle in enter_s2idle_proper for tracing
the enter and exit events with a determined idle state.

Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 drivers/cpuidle/cpuidle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..9ff8fa5db444 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -147,6 +147,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 	struct cpuidle_state *target_state = &drv->states[index];
 	ktime_t time_start, time_end;
 
+	trace_cpu_idle(index, dev->cpu);
 	instrumentation_begin();
 
 	time_start = ns_to_ktime(local_clock_noinstr());
@@ -178,6 +179,7 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
 	dev->states_usage[index].s2idle_time += ktime_us_delta(time_end, time_start);
 	dev->states_usage[index].s2idle_usage++;
 	instrumentation_end();
+	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 }
 
 /**
-- 
2.25.1


