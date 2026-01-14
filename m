Return-Path: <linux-pm+bounces-40882-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D04D2117B
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF5C305500E
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FE434EF12;
	Wed, 14 Jan 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THGcfVhZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50FF280A5A;
	Wed, 14 Jan 2026 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420133; cv=none; b=Iz31P6x5ounyJXKK+LCOGUoOWGCpOnpOTWWUtnJrCi3HhNEluLWLYthc5KqIMFiIFjo5eKMcSUpZrK2PGFC6bLt+GjLyCke9pUzObSg0rcZCxsTnWmFlFlDHetBVjUhKvl521aIf4lyY6TL4G18hN5sULaOOXFsxspBJrV8nnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420133; c=relaxed/simple;
	bh=zhryapkG2c9pQx60JvjS9D2cBynGd4krI98bHe0uwok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJKkolYhBOtTaDePRL9uQIg/6oNIvoGxmY17LeCylpXTmAYuBrMXPasvg0Y9zKAibnYfYZnZPX60QvbpkuJtkoVJyyO57YemjIO2JRhHK9CHBxPv5MgG58Offx4F5dmCd/Jpmb0wCnyRt8Uwbl7O//BZiMDLoqFgEBRC8/rD58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THGcfVhZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB2EC4CEF7;
	Wed, 14 Jan 2026 19:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420132;
	bh=zhryapkG2c9pQx60JvjS9D2cBynGd4krI98bHe0uwok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=THGcfVhZLjbAvlkOLnvIAFq2zrqeF5uXbQrgdojcleQaP5huLJk2zhzwEVyp/HWqv
	 hxBt7N2gzocWvPdGLewguV6UAbq9S5iGUVZJ85wwd9T1O9wELrP2Iqta4UOeUEpEsb
	 Tt+RgnrffsfNMrQEfq3A4Rd7EPQ+VYtsNzJ6pwZy6fuXbPqzFVZuAgCjV3aQm/2kMn
	 G4O60i4GZSXGvPd3ZG2ua0k9sRtiP0VWGuhv1rkZodbwliNLBx67pXmAZCC3K4KSs4
	 7IXAqjvQYheiw6Ecrk7o6LFwCilzVIrrTmP1QM17MbPhlf7MwCDTKsF6aBXfwNKq54
	 BGzR1BGfEd5LQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1 2/5] cpuidle: governors: teo: Avoid fake intercepts produced by
 tick
Date: Wed, 14 Jan 2026 20:44:53 +0100
Message-ID: <3404606.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2257365.irdbgypaU6@rafael.j.wysocki>
References: <2257365.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tick wakeups can lead to fake intercepts that may skew idle state
selection towards shallow states, so it is better to avoid counting
them as intercepts.

For this purpose, add a check causing teo_update() to only count
tick wakeups as intercepts if intercepts within the tick period
range are at least twice as frequent as any other events.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -239,6 +239,17 @@ static void teo_update(struct cpuidle_dr
 			cpu_data->state_bins[drv->state_count-1].hits += PULSE;
 			return;
 		}
+		/*
+		 * If intercepts within the tick period range are not frequent
+		 * enough, count this wakeup as a hit, since it is likely that
+		 * the tick has woken up the CPU because an expected intercept
+		 * was not there.  Otherwise, one of the intercepts may have
+		 * been incidentally preceded by the tick wakeup.
+		 */
+		if (3 * cpu_data->tick_intercepts < 2 * total) {
+			cpu_data->state_bins[idx_timer].hits += PULSE;
+			return;
+		}
 	}
 
 	/*




