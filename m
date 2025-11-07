Return-Path: <linux-pm+bounces-37634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E03C41441
	for <lists+linux-pm@lfdr.de>; Fri, 07 Nov 2025 19:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A28BF4F01DD
	for <lists+linux-pm@lfdr.de>; Fri,  7 Nov 2025 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D032863E;
	Fri,  7 Nov 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYmAk4es"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BF2F83BC;
	Fri,  7 Nov 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539565; cv=none; b=TY9lpCJKWZQxSLTYLhxo800Q5dHYM9Izhj0ILsbEUxLpVIxe5S5DnM7hbbLyCeLre2k4vdwKTW2fj4BYi54Gj3fXo1PGjUE4qGKjob+1k3IJg79OhW7zkzNI9RkuiVNyMweCAC5DyTT57lN6ogjCkf21+PJFovNHotz0O07jxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539565; c=relaxed/simple;
	bh=M0slxHbV7wZavtVVRNUtrb7s9AgZM4xj2aLlMwjHvpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S417zqlHVBqBS7LOjDdJyLoufxkHLSTlWzZce1ljTpRfzvGCeYD0+Xr1dTLpNohYX9tURyzGOwdjrLux6GuF79+M/2OWQspzIF8sjJVKxdVulOvBpxETUcSpxqsWKBUPREHKC2BPGdGzmUioLIvdnD/qa4xytH6D3FVf+OefaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYmAk4es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11063C4CEF8;
	Fri,  7 Nov 2025 18:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539565;
	bh=M0slxHbV7wZavtVVRNUtrb7s9AgZM4xj2aLlMwjHvpY=;
	h=From:To:Cc:Subject:Date:From;
	b=FYmAk4es9c1YbrK7bGuyXUOmyFvwLEzMQjpypFdIFq3wc7B+3diQrFhVZf4CIyDNj
	 x1Lm5EaRyKfgedBRev3JhqXB8fWmpTBpyCQb9j/GmVSDXjn6u2XJPXyz2xEQAkLN91
	 dNLGAECVfJhHsiwQtrxOgXwtyo6CSg0r7m2ujN+n/vh7gfTewFlvx7/clkqKXKZEX+
	 S+kW8WIeHCBQ3Fi0ejf4XqsrVLXG/9ydqE9EjuAbXoQ/SC3QiV5r6sU4x0CPRhwh4b
	 C4ev+KpUt0GRfOoSQk57KPqa0xXhOy8ebY9VHkP0ojZ2R7aIuE+Jh0qqDK/ZNPXrM3
	 uyQNvRc6QEdNA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject:
 [PATCH v1] cpuidle: Add sanity check for exit latency and target residency
Date: Fri, 07 Nov 2025 19:19:21 +0100
Message-ID: <5939579.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make __cpuidle_driver_init() sanitize CPU idle states so that the exit
latency of a given state is not greater than its target residency which
would break cpuidle assumptions.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/driver.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -193,6 +193,16 @@ static void __cpuidle_driver_init(struct
 			s->exit_latency_ns =  0;
 		else
 			s->exit_latency = div_u64(s->exit_latency_ns, NSEC_PER_USEC);
+
+		/*
+		 * Ensure that the exit latency of a CPU idle state does not
+		 * exceed its target residency which is assumed in cpuidle in
+		 * multiple places.
+		 */
+		if (s->exit_latency_ns > s->target_residency_ns) {
+			s->target_residency_ns = s->exit_latency_ns;
+			s->target_residency = s->exit_latency;
+		}
 	}
 }
 




