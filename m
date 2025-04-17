Return-Path: <linux-pm+bounces-25635-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B02CA91F83
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D0019E6AD6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285B22512F7;
	Thu, 17 Apr 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0kbnqPO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06C2512E4
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899935; cv=none; b=h7eX0EpticTEgi+8uusYqEnGDUA5EDFC4uCAPZ8SXGzQDBOVZfAIxPAOwQF9acqQPB+haBCqdAWggqkTyG1BBGAnAlRVhD2bIpbdlVYggkmUgH3SsdBW7NtOiYaNm8kP9ioUiCur8565VV1A2M0ZMfnEhItactP2ZBi+I2054oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899935; c=relaxed/simple;
	bh=11I5c3B4eQ1BcFsYiRplOZ21OUdijMolETfdBI+z3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWx7MEcUc2Fa/OxUZreby1SUiS/1+1Qsp5Ti0nNpRqbcZM+DdiHSJBI4s99jxYDhwJIKQwTXUiMZiOg9jnc6XaN2631HML+Aizi9L/4CdVxIW3oMDE+V3u5HIE+/zv6cReTSeg5XRTaAiQGcsI0uFgAOa/JsZZ5wEYbbvg4WKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0kbnqPO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54af20849bbso984006e87.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899931; x=1745504731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HatUJR7pfydRpRerJllcyKfpU70Imz3ne8kyK9KNniw=;
        b=m0kbnqPOAMJPV3/vS6sdpfL4TcMf3eVhJ9HCUOP/jOVcEufZFrZCu+crRXERIR7r4/
         Q6HlN8lG0muHRu8d/flQSIqQQOR/dXJbm3pWBtRAsUss7iaEdH1QV+9W7eNUeyyURS+3
         4H6CNAedvkwlc9FqrBrCZ6hlBP0KKGsAvEPMS81p5n/v5ZXAh/x39Nbxyj6XCVLaxBg8
         YNtMcx0GUNtHDFYzTZKaGAtI3wgHHCeJY6+8Z7DIhgTsy4PT2gnuBeNTOjdZHu06CXxT
         r0eY/0opIyAKZLA+YsN2vhwMObffjeqMFFjH56PcUYTISnzrD2+ub7y5GFSlaT0fJ3qL
         kR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899931; x=1745504731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HatUJR7pfydRpRerJllcyKfpU70Imz3ne8kyK9KNniw=;
        b=FNK9TE2C3acnNnfKICeaMvoZbEzvg5H5LnNRl5qKDTjVyqL20PqV0UtHYiGJQvfO+R
         91A03HiqN8/eJ/Jo4X20fVcldvTRjXd9JEbB8+q/MknxXXGVQku9rNk1aKIjMHr0My4V
         90PhwT2C/QmsvofKVFoaR0h8cFOQ/HxuGFkhE1w9PAB7XZAJmf99euSKA92fAzq7byl6
         toPd5cgJsuqk53Xk6+vGFBffOIq44vdbffvY6ImKGYb+MXGjPMb6UgxJxPXFuv/OC563
         47sjcIfaOQwvgss0ZKnbPw11S9k6UVo9d3n5H5HePtDvJ6361Ht1FvnHLNQ5lrYwAE54
         9r8g==
X-Forwarded-Encrypted: i=1; AJvYcCUCoT/DVEZxaLAxK0ai2rlIAJZLykDsh9gOXs3h1IAe6VLt6v1SyCXuzOhJktg39j0lBoXoxTiwvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznzit+7kV/tluLbGktYWT7ovGseDJR3rRPEKS3IMEvNyUW+vlW
	lU1r9xq2UoAdoPyLGwpG07ixybyJwFd5m7t22cFD8J8MIWIABaK5/xAao/U1Qlk=
X-Gm-Gg: ASbGncty4rrsSYNohQtAYqiwSyCsCIM0lb4H4lR5A4lru3oqi5KIRuturyqSn0gwNqM
	Pw+P2JizfEdNp6A8yvfHwIUcQEaPi1wYZ36bst8+nHO/sTa2FYPm4ukJVRSfQjjs4bsypPKRIT5
	qIMDqwTPgGkoW5rnz1nbkMotgI5B35b24fyAMH9rj7qma1I/nXptVterSnLGHLEMGchw99jTxje
	q022mxahfXoBTD68aH/0nP765hwT4qgWIHrtoi9rDcreG7drX8RuwDGG5sQPDB1tGNZS18HCxcb
	nN1MizLkk4FgzuHh/ytbgQrVcGvSm7rQ1fWgRzzOdAX4E5zwbsciXrqZMMkV8emXku7RAf83ETx
	Z1y1ScN6x6eZRKwTCXNXpkhIvXA==
X-Google-Smtp-Source: AGHT+IG6EsCnUo0eKWDGOg3mkKPpm5BPPY+Ezrmv+DqY8QKeGQ18bV/SmzaWgDutPvEppQHb4SvtsQ==
X-Received: by 2002:a05:6512:3e11:b0:54b:1055:f4b1 with SMTP id 2adb3069b0e04-54d6479a217mr2124920e87.0.1744899930795;
        Thu, 17 Apr 2025 07:25:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:29 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] pmdomain: Add generic ->sync_state() support to genpd
Date: Thu, 17 Apr 2025 16:24:58 +0200
Message-ID: <20250417142513.312939-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a PM domain (genpd) is powered-on during boot, there is probably a good
reason for it. Therefore it's known to be a bad idea to allow such genpd to be
powered-off before all of its consumer devices have been probed. This series
intends to fix this problem.

We have been discussing these issues at LKML and at various Linux-conferences
in the past. I have therefore tried to include the people I can recall being
involved, but I may have forgotten some (my apologies), feel free to loop them
in.

A few notes:
*)
Even if this looks good, the last patch can't go in without some additional
changes to a couple of existing genpd provider drivers. Typically genpd provider
drivers that implements ->sync_state() need to call of_genpd_sync_state(), but I
will fix this asap, if we think the series makes sense.

*)
Patch 1 -> 3 are just preparatory cleanups. 

*)
I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
Let me know if you want me to share this code too.


Please help review and test!
Finally, a big thanks to Saravana for all the support!

Kind regards
Ulf Hansson


Saravana Kannan (1):
  driver core: Add dev_set_drv_sync_state()

Ulf Hansson (10):
  pmdomain: core: Convert genpd_power_off() to void
  pmdomain: core: Simplify return statement in genpd_power_off()
  pmdomain: core: Use genpd->opp_table to simplify error/remove path
  pmdomain: core: Add a bus and a driver for genpd providers
  pmdomain: core: Use device_set_node() to assign the fwnode too
  pmdomain: core: Add the genpd->dev to the genpd provider bus
  pmdomain: core: Export a common ->sync_state() helper for genpd
    providers
  pmdomain: core: Add internal ->sync_state() support for genpd
    providers
  pmdomain: core: Default to use of_genpd_sync_state() for genpd
    providers
  pmdomain: core: Leave powered-on genpds on until ->sync_state()

 drivers/pmdomain/core.c   | 273 +++++++++++++++++++++++++++++++-------
 include/linux/device.h    |  12 ++
 include/linux/pm_domain.h |  11 ++
 3 files changed, 249 insertions(+), 47 deletions(-)

-- 
2.43.0


