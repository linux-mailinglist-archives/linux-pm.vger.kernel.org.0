Return-Path: <linux-pm+bounces-3360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD784925F
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 03:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FF61C20A39
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 02:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377E17EF;
	Mon,  5 Feb 2024 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="fRTUbibM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AEAD22
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099922; cv=none; b=Ut4nmeVUN3n75m3hLCnsdP5xMZsjerwZ1Hb8Pn1APGB2ZgUn5p7GroYkazIjenc8DUUojNdc+B0UOR4VswaOatsDha4e264ou1o2espjypg3XQHDIbgKNUjJevDja1V0wUjh/jRfgr+1BYo/ftcuEcUFk26uoWnqBSbEadmbz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099922; c=relaxed/simple;
	bh=8e2ZtlAdrtsfponDxeWJ9SpUMacZnh0zw7mhcfhkb88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PPY+s3Zm5L9OCFGti9WRkyId54RRmvJdFRs+Vn0gevPuiR5srCFhOSy4getK115ORTqvmUQ9w9OfBAWEzrbJlY7eVfOux3oo1WJsEMY9tB02WnyiEW+V8mkkXTfttvSPdiAUTvUija/NCMvWqbh3XyfYlVr313duZiXRz6t1mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=fRTUbibM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fd6c24812so6763115e9.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 18:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707099919; x=1707704719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w8scmLEsyzGxoS8Gc0uCCvoQDZ8pPxzLZfnYWsrBWUA=;
        b=fRTUbibMeu8IOUrMBRykoIhEFldewn+85ilF1zECtXHml7+qXISZo251hJoH8xfNzh
         TXPKKb5S2pxLL3Ma3IBsTqJHpy/kgET4W5W+K6gbYTf27SRwiKdlO2i8G446yHLsypNw
         gUX0v4qtRp9l9cszG/4Q7R9CgoJpk9mXDQXTAHTYmeXDXCEtSFptgVaDyfpUtpnODQnE
         DESTYHGgD9lyuR9o5vDzdvS6NdqknKc72fi/6a36cpv95O9iovv3FFV39Y4nB7wRAQ7v
         N8MUw3FupsX1UgEr+advRah+Equ0o7ElFuRocQ20dwKp27of+ooqpjNbtJdfcm6DQK06
         uPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099919; x=1707704719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w8scmLEsyzGxoS8Gc0uCCvoQDZ8pPxzLZfnYWsrBWUA=;
        b=JhoGzx5YL/CiTnz+R5e6mbIK6hhb9J94bz+hajXpG2tY9i+GC7bLH9ktRHTQ520D8D
         uNaV19FFmcRUYLGOqtZiJc7ibiXBAqA5RPlkvPNLEzrvtFe5OjjuOEdVPsl37AszPnW5
         1s7X3nBEmdd3Y8vmr3QLqsCBwtGMO7zAg+AXLum3+8dPmsXpgWufJPisvds8fzqeWBwn
         hwlvVDXYTPYe81/5wtcCa+D+SrOWvGVy3mtp+YxrDPbDh0SuQsjE0mZoX6sLIOSPayzY
         lwS/T8W6ZzyeuGXBvMX1dH51deiqLex+GAjht3ZQhUj+PEJ4BJZ3d+S+WjzKltcFQPMb
         Ehkg==
X-Gm-Message-State: AOJu0YyPzySTIU+rUy+BX6nsXypcd3vXpCfa1gyGXj3w5XKfmFU7Jm9A
	EigBD49hLz/Tbss70S+5KrNZNMN4bb1L/5hJjziBQPr9mx6bvkWIg/zEg7xi87Q=
X-Google-Smtp-Source: AGHT+IGFgnJsXnfu8s6Z2SS2anOiJGG6PLT0W7S2m34AkU5x9hit1oXft5S64KpZWwFPrOfrnr/llQ==
X-Received: by 2002:adf:fcc5:0:b0:33a:e2d3:c3ec with SMTP id f5-20020adffcc5000000b0033ae2d3c3ecmr8699060wrs.60.1707099918847;
        Sun, 04 Feb 2024 18:25:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXl4Ig7R7yZxUjzj3JEz1+xOHBtc/N6U2uE07YtlDNBfjKKklvgEV4vxbQ56jwyhh77pLVToizjHEmHEO5GhPaz5CcJRivwVUN0f6eS4cHKc26l6Voe21ivkxAD5I42aqMvXKfI7Vo0eAnm7XsW/B4iMjC1eH4Kxz4vXHNo6sfujNOmBYRdyQnLfV0NgYNBCxFA5K/XlfwqyBL91pNrp+GJfNcBjud0Utide8L5Nfsbkl37jQK7n8z1CLggN+HoAI+9rc2oP+tLFOMeP67lwhnevmZHw==
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id x9-20020adff649000000b0033947d7651asm7032099wrp.5.2024.02.04.18.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:25:18 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH] cpufreq: Change default transition delay to 2ms
Date: Mon,  5 Feb 2024 02:25:00 +0000
Message-Id: <20240205022500.2232124-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

10ms is too high for today's hardware, even low end ones. This default
end up being used a lot on Arm machines at least. Pine64, mac mini and
pixel 6 all end up with 10ms rate_limit_us when using schedutil, and
it's too high for all of them.

Change the default to 2ms which should be 'pessimistic' enough for worst
case scenario, but not too high for platforms with fast DVFS hardware.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..8207f7294cb6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -582,11 +582,11 @@ unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
 		 * for platforms where transition_latency is in milliseconds, it
 		 * ends up giving unrealistic values.
 		 *
-		 * Cap the default transition delay to 10 ms, which seems to be
+		 * Cap the default transition delay to 2 ms, which seems to be
 		 * a reasonable amount of time after which we should reevaluate
 		 * the frequency.
 		 */
-		return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
+		return min(latency * LATENCY_MULTIPLIER, (unsigned int)(2*MSEC_PER_SEC));
 	}
 
 	return LATENCY_MULTIPLIER;
-- 
2.34.1


