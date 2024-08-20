Return-Path: <linux-pm+bounces-12579-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 374A2958C60
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DDC284C60
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998471C57AE;
	Tue, 20 Aug 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="pl/50XDE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997C1BE228
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171815; cv=none; b=CPMm1jNnPj15MxpZqm5k6maKvpqYpxb30HTlX0o/QpVSC1PYIjFIEYZu9tPxY3nNbmrHG9uVxJ5MhgQ68B8MOf4ki0TlHMG8kT2qKt37ExyVpdwDjGE8wVk8gxZmL88bvKnRPIEcgS1WMO9zqeL8JbZLqzxutuN59CUQA62YJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171815; c=relaxed/simple;
	bh=nw2KAMga+N9SBRpuwZhMNhiboc0xudR9Yyh15QBkKfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETU3nbCm3bLaXQhKeJALG0UJw8PnEgb5TKPmKUzrz8phpEAr8psSMJxjMjsGgr8I1Wht7PEXiZfbifubBl3T5c9yhgIOSoCcQpr0wzVlpFlx1Xg1u+3wvieWy087gv3BgdSMBq5eh0pYYfTcoSDZxIjH0CKovAXXA5WcUQTrWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=pl/50XDE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b3so4442407a12.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171812; x=1724776612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2cahoYdlsFx3NF9sR068SfEnyVTIFV9fZk/j7POxiM=;
        b=pl/50XDENJksbaqzw4PK5B0o7XTiHGuKR+mRP5tKuYaEta1OmQv7i/eD5lK6XkHlDQ
         a/qfJSbzn+aezmGgu3sBOB/ghRpQgJSjHVXk7XrxOWGCHsxT4g7tS0RyKAJh4qfNnDZe
         MrNA2HLqNIk9236txVQ7FNfsYLglwn9dBCOt0xhSRwP02jP7XJZzLfjxPYhqbbUttXdt
         fs61SypRsU8SK/DY47EIbeDI9VXXP3Tj0GH0UdrNKLRgpaneR22f3Sj4BGRC8ahMKkQ1
         PXNEaT3SxDXRqfxmSSiF8oqyCp06nslixr/cvoqlHye8xbUUc+TdxdL2vQRNt7xk+TMG
         r8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171812; x=1724776612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2cahoYdlsFx3NF9sR068SfEnyVTIFV9fZk/j7POxiM=;
        b=gESLxrLV4AJn9Ut/PKnCZnJ1fAQ/aRMXcqI0e9raQcfm6UEiD8h274JWBC/jR/G+pW
         /5akHwLxt66bszEntZ2k4p92zW5CfF1njophvQeJtfIopf52PiZXGDc92ZkCf/pef9Nj
         GlKSuIlW1YAcYk9ye5RNwEG9UkQfKYdaFy6HPwlz/01MmUi6lKqnsd62vWn6P15DcOMv
         grCN/vsL72rQ8RDXGylpgOlW1r3lg6tefbV4wUVuHibOoxY4Q3lMSvhdNNNMEiBWiTtC
         HGIfh+GAW2NSw1OgWn3aymhigml9OTJy6dHYK9wXzxSAmaIE7i6J4sAhDFqwkgTBGMlx
         Ub5w==
X-Forwarded-Encrypted: i=1; AJvYcCXY/SDJZVZGZBKZzYx5a14uIMAJQ7kKg/p0MvlHZzQaOmAenSGwDlrNRAFxSm6t+T9ZWg73utXxCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkR7svX4UjecDdHv2LX5QSThm4npLFs1I/JyoyE9PLr1S4FnXQ
	DU+01fN6D9dIxP1Vf5/k+bxq0hRHI9DKnZdBCCadoUo4oCHcMtBEaOuu9Kdu/dY=
X-Google-Smtp-Source: AGHT+IGYJnTxET1FI2CgmIVhGwHAm0Rvsu+OSAWgb5x2sIlIex+roRD/rs+GaRWocmTPkLXygBK5rw==
X-Received: by 2002:a17:907:2d1e:b0:a7a:a557:454b with SMTP id a640c23a62f3a-a8392a47a85mr998867766b.66.1724171811750;
        Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 15/16] sched/fair: Enable disabling util_est via rampup_multiplier
Date: Tue, 20 Aug 2024 17:35:11 +0100
Message-Id: <20240820163512.1096301-16-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

util_est is a great feature to enable busy tasks with long sleep time to
maintain their perf level. But it can also be expensive in terms of
power for tasks that have no such perf requirements and just happened to
be busy in the last activation.

If a task sets its rampup_multiplier to 0, then it indicates that it is
happy to glide along with system default response and doesn't require
responsiveness. We can use that to further imply that the task is happy
to decay its util for long sleep too and disable util_est.

XXX: This could be overloading this QoS. We could add a separate more
explicit QoS to disable util_est for tasks that don't care.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8dbba0b755e..ad72db5a266c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4918,6 +4918,14 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	if (!sched_feat(UTIL_EST))
 		return;
 
+	/*
+	 * rampup_multiplier = 0 indicates util_est is disabled.
+	 */
+	if (!p->sched_qos.rampup_multiplier) {
+		ewma = 0;
+		goto done;
+	}
+
 	/* Get current estimate of utilization */
 	ewma = READ_ONCE(p->se.avg.util_est);
 
-- 
2.34.1


