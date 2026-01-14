Return-Path: <linux-pm+bounces-40881-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C834D21172
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59CD53038CFD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA98F32571B;
	Wed, 14 Jan 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0RTgv1L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97851322C78;
	Wed, 14 Jan 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420129; cv=none; b=XTfet4sZg/7I+vt1kMwGs9Oh6fvxzLVUzAS02cAla88Oyj2gffdQ4DdBFrHBMHtmXCNjVM94d0rS+9HmpqsGgALs3SaO5lu/UvZxOKzka/EQRdLwHP4shhsPpVO2KG1MBTvWPJrJknh3tcHYPZ+3tEXDDX3l9HwFyUXdQ5RDpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420129; c=relaxed/simple;
	bh=s4+zyNQOCW3pRbSw6GbxKwlXfaqGq0ABP/cnwA2NwL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cE+7FRFAEVmBJuX/syz2Z4jTdJym3ZY2KO5kQ3yE7PVnrhs2a8Mv9b7we/Kk7a7KqddBqF6GAkL119G3S8lnC51d3rFaFxy1DSISNi8pZ/3AVnvg/xcyevHIcqNSimUvbij8UkGhXehLIumnj7w+HYTyosHYPv5EmCNpAmAjHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0RTgv1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821FCC4CEF7;
	Wed, 14 Jan 2026 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420128;
	bh=s4+zyNQOCW3pRbSw6GbxKwlXfaqGq0ABP/cnwA2NwL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0RTgv1LfdAAmD7ZQolICfv7L+p7TXOreSVnymct4bBANKrV/duI4iBIOBL851QZM
	 CRdGZXsuC7mDOEQ6sT6bcUUUg1JOlTjDi+cnC3S1uN078St26o2ofIMYrNqnbwyJA1
	 1XCxNZLQAm3cBFdSDaiEp0HoFM4z17YIHFt0eZ8C+Ncy6LeMkMqLapQkhND/L0hw1m
	 4JriU4E6bTJVFaYGNhe+CyN1Alc62Baa2EMZW7Mep1KBQ3t1Z5EQINwLYIb0TzmLzu
	 nn3c+aDqy4wBTx3CG5bSOaRuhgNkjkaXB/uczaYVN2QueAVxj1VCOSvJc6lsWM3UaR
	 4w2v3NTyZjNDQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1 3/5] cpuidle: governors: teo: Refine tick_intercepts vs total
 events check
Date: Wed, 14 Jan 2026 20:45:30 +0100
Message-ID: <10793374.nUPlyArG6x@rafael.j.wysocki>
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

Use 2/3 as the proportion coefficient in the check comparing
cpu_data->tick_intercepts with cpu_data->total because it is close
enough to the current one (5/8) and it allows of more straightforward
interpretation (on average, intercepts within the tick period length
are twice as frequent as other events).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -485,7 +485,7 @@ constraint:
 	 * total wakeup events, do not stop the tick.
 	 */
 	if (drv->states[idx].target_residency_ns < TICK_NSEC &&
-	    cpu_data->tick_intercepts > cpu_data->total / 2 + cpu_data->total / 8)
+	    3 * cpu_data->tick_intercepts >= 2 * cpu_data->total)
 		duration_ns = TICK_NSEC / 2;
 
 end:




