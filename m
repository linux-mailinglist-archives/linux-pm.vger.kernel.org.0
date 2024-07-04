Return-Path: <linux-pm+bounces-10576-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A1927011
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 08:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E33A1F23401
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 06:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC471A0AE0;
	Thu,  4 Jul 2024 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRBavK1J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3CC1A0B11
	for <linux-pm@vger.kernel.org>; Thu,  4 Jul 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076056; cv=none; b=cMh7C2iWYRUGlc2Ea93F7IpMKxUids4I7KBzCxg+2lddvOoacIsqL6zdKg2ptdfgIE6twFEbK0fIo6Tzg7Xq1i0rtkXmrULGdh5YSNbgeJqOsArrHUYGU8kJtYlNcSHMXR+DdNNJ7T1YgfHLdVbr6V8xP639+qgqzaIJqWKol+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076056; c=relaxed/simple;
	bh=TZ8lUJ+EdtbvrUI0mVlJgpMBTSp9t3SM/Ev/g7RgE8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiEwq8bvzRMegkJBoJRwUR+v+PxTM9M7FPXz6roq8YQ8aKqDwIyMZwlEQtBN6xluugwVto0fNHl+xaBwFxnJVcIuQXi+TPGTFrKAB8JBH4ldhM0OmmlHqjBzvwbKoBddFL8vg4JEceUPFpZkK5C97AAxFf/ESZhyDyn4+mEtlqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MRBavK1J; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-700cbdd90fbso187097a34.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jul 2024 23:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076054; x=1720680854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=646R/nei8b6Pjif+wq+djuFAbamOolETBvkXxk7jQQ0=;
        b=MRBavK1JZPakSgqoy4vTWxOX76XkauuQIrDUA5J5mELIglsym0dlX+aRPFKgkblf2J
         c+13Zp1ZCOvsKmvkENeJRom3KhDFb+7KYetyjJkNH0PZPUysXXu1ImP6NbktVQW4/9EM
         uttPyuH0dkQ0ccnuNHlBN3EIMJvZaqJWlKH6W+0e2qDq8aqndTpMeYO2Hc9qkSXSrkxo
         9BwmVuxOEaKdGUJDWM8r9GvFPS9DCo0L6mPVn/zSDOYKf7shA0bJmqZrXix5aEwJSWF/
         WlA8AlUsqru07w3GnlpkjUytmDE96obAKLB01zRPVlcR6Th9dPn3oSYsdres9imwqQOR
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076054; x=1720680854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=646R/nei8b6Pjif+wq+djuFAbamOolETBvkXxk7jQQ0=;
        b=AyjRL9suTjynT4pVb5bes4Hgk8W/EDgtVRzFW1nKgwbtpnx6qrapfVJ7+CHiA9Hd7z
         SASdBo+hDaoDkzn4QE1v+YLxIGCrvbRObOWAJCWUBKsRTB+1uzZl9MENop3ShZpDI1su
         76QAYAQm8vspHBmxssRmxP5k2TlIkMbkH6ebbUrx0qi2sUFPbVWnCNF5fiov5L2DJvbT
         tgWsAO7pSmT2CuBHisi3uBRg+wv3x66QophOYuaCklpjSZAmwkNfdbc5+EtTfNFw5PIg
         amAibOaZf8X9KbkKd0A/E8YnnEAbaafW39zHSMXiwNsG6Q3Ey5Y5T3tmW1orIrwNBS70
         p73w==
X-Gm-Message-State: AOJu0YzDDWUvTkzoj1Y0xKBvb+qiYPLlGcVK4cbiPL/Eo01gfFyP6brG
	OqgB2zo03WsRY8aQsQLnlbfY4I3l6bzKLZzRL/tdW9/q7T3ovJGCPllnWq7eizE=
X-Google-Smtp-Source: AGHT+IGjYh1lTXxVRjoahxmOdu63Hv9FjAowD7DcCHLak2Or+s2oM/b9Q24N9BhJjSId5owDNnm2wQ==
X-Received: by 2002:a05:6870:8a0d:b0:254:9ba7:488b with SMTP id 586e51a60fabf-25e2bed77a3mr690546fac.40.1720076054170;
        Wed, 03 Jul 2024 23:54:14 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802565b3asm11476391b3a.53.2024.07.03.23.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:54:13 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cpufreq: nforce2: Remove empty exit() callback
Date: Thu,  4 Jul 2024 12:23:52 +0530
Message-Id: <5f62b0af67ca9ebe2f28a379d807b47a7f54a824.1720075640.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1720075640.git.viresh.kumar@linaro.org>
References: <cover.1720075640.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exit() callback is optional, remove the empty one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-nforce2.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-nforce2.c b/drivers/cpufreq/cpufreq-nforce2.c
index f7a7bcf6f52e..fedad1081973 100644
--- a/drivers/cpufreq/cpufreq-nforce2.c
+++ b/drivers/cpufreq/cpufreq-nforce2.c
@@ -359,11 +359,6 @@ static int nforce2_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int nforce2_cpu_exit(struct cpufreq_policy *policy)
-{
-	return 0;
-}
-
 static struct cpufreq_driver nforce2_driver = {
 	.name = "nforce2",
 	.flags = CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING,
@@ -371,7 +366,6 @@ static struct cpufreq_driver nforce2_driver = {
 	.target = nforce2_target,
 	.get = nforce2_get,
 	.init = nforce2_cpu_init,
-	.exit = nforce2_cpu_exit,
 };
 
 #ifdef MODULE
-- 
2.31.1.272.g89b43f80a514


