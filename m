Return-Path: <linux-pm+bounces-15677-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462A399F3E1
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E87B20DA3
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE9E1F76CF;
	Tue, 15 Oct 2024 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMC7MkId"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4C71D514C;
	Tue, 15 Oct 2024 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012742; cv=none; b=n1pW9J+8266TZkBuwQ9TYoC5hdnUxmxhYmcRXhTNpkYhK/cf+G2JHMMapbQg/Zj2mC9p7slP3/mEC+E04nOS8uide5vet50zA7n/HUI/+XYKseoxI2oB0X0fgoKLUJ6zpStY2Kku7iA14KGqUjUlImtxwbJva0biXzejxGKol7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012742; c=relaxed/simple;
	bh=/4d7EoBzIlhcHDH9qkC6J52wMGKWA7EO9n7isAB5FvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rcj1tZMkPiqVRHOyG/UzPHMLH45fn9PGeYJTRwGux5/WDcN/dfaNZ1r9T50FHiAi5jIqlZ8/FDV6U2h7xtmZSwrRishV6EIq3OjX6lFKlWvj+R7SjJy9fdovB43OeuqnuAne10ma+x9rWrVlLxKjsOTl39AiG6AImj3QTrQ3T2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMC7MkId; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso4320765a12.3;
        Tue, 15 Oct 2024 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729012739; x=1729617539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSRsu/greOiguhxWKwTVAbA1IuBqHC3TjNHFAMMX7g8=;
        b=NMC7MkIdTzN5NSzZsXZklkGTBMOkkMmZUDU9h8oaWw42bA6mp4g1GqzFPAbSeugQmx
         uxEwhvzGltDWXSfUjHLvlfPwh17kM3OQGOtCV5Dp1yZozzuPam0UOdafOSt8R/1ROqiH
         JzPp4etNY1j+cOFLXVQLI8/SikXxxvuxgq+zZCyIv81UswSDTlSeU5Mxf9UDb/j21svX
         QU/A971st+QJp7OwcLk5qPkYyGiRSCRobWAIfBCbVt1rqyt+G/HHT63oIC0UJ7kmvHnQ
         2XuL9rATgsGZ0O2PDXBgQC2SNkcaYOwaB07kKr0vfWuB+sj/J335l7lqXAfpYg7TrowE
         M3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729012739; x=1729617539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSRsu/greOiguhxWKwTVAbA1IuBqHC3TjNHFAMMX7g8=;
        b=c49CzxF6BykYp9DC+N6MZBdiMUD+Nr5Gwa5bdU+lfTouV4aGANbB4PUeyd4ohxqixi
         KGlb5J5UhMd/YdDmJJuueU5urAY8anLtcQ6PSQFf2U2QSu2snDf+ZtzsTIXKFWqvs9nB
         rBT7uYHUE1qJcDi3GLyOtNMZsPnFsCJnArxUIakLFAXeopDiZnRUzjLvCEtMTdGZxaeK
         70fVliFfZPLw4WLjbSXHh/5RZ6Iw4wKajpy2JlY130shsNYYirzg2MMWRp0b063zkGrC
         NwtHJXYWuVHhy//XkzJtMqReIIBZYCaNqv8UEy9A764N+jRC+snPMPhrRtcmtsID5T6k
         JQKA==
X-Forwarded-Encrypted: i=1; AJvYcCV4D73cAYhXkupaOYdJB4Yi4jfCr5nxIXwQ+Lf54OCi7uKNIx9Ymo0EPGlQZz0do9E6/PIlin8/n3HIZRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FeyvX+tXBjgWWn7eN4nPBBeAFixx22M4M9dJXSGrZ3/CKhwt
	aW04k92ZsNMI5FzKXYQywaIUpbojA1y4d/WjAvwzYqgDK0V6AbG6
X-Google-Smtp-Source: AGHT+IEguhQUTD1gQ7IIpJaup7vCYhfOUC8FaXMG8j8bXdOvxgWzgi4JiTqF9brhLY3lJq9JtSN/rw==
X-Received: by 2002:a05:6402:51cd:b0:5c9:5ac1:df6c with SMTP id 4fb4d7f45d1cf-5c95ac1e675mr8462466a12.33.1729012739130;
        Tue, 15 Oct 2024 10:18:59 -0700 (PDT)
Received: from emdj-bno.. (0x5da5fe69.static.cust.fastspeed.dk. [93.165.254.105])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d507a14sm911763a12.49.2024.10.15.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 10:18:58 -0700 (PDT)
From: juhl.emildahl@gmail.com
X-Google-Original-From: emdj@bang-olufsen.dk
To: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emil Dahl Juhl <emdj@bang-olufsen.dk>
Subject: [PATCH RESEND] tools/lib/thermal: fix sampling handler context ptr
Date: Tue, 15 Oct 2024 19:18:26 +0200
Message-ID: <20241015171826.170154-1-emdj@bang-olufsen.dk>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Dahl Juhl <emdj@bang-olufsen.dk>

The sampling handler, provided by the user alongside a void* context,
was invoked with an internal structure instead of the user context.

Correct the invocation of the sampling handler to pass the user context
pointer instead.

Note that the approach taken is similar to that in events.c, and will
reduce the chances of this mistake happening if additional sampling
callbacks are added.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Emil Dahl Juhl <emdj@bang-olufsen.dk>
---
 tools/lib/thermal/sampling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/thermal/sampling.c b/tools/lib/thermal/sampling.c
index 70577423a9f0..f67c1f9ea1d7 100644
--- a/tools/lib/thermal/sampling.c
+++ b/tools/lib/thermal/sampling.c
@@ -16,6 +16,8 @@ static int handle_thermal_sample(struct nl_msg *n, void *arg)
 	struct thermal_handler_param *thp = arg;
 	struct thermal_handler *th = thp->th;

+	arg = thp->arg;
+
 	genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);

 	switch (genlhdr->cmd) {
--
2.45.0


