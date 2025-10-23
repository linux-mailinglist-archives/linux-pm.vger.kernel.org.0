Return-Path: <linux-pm+bounces-36752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C12C02ADC
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF549349EB0
	for <lists+linux-pm@lfdr.de>; Thu, 23 Oct 2025 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39E2DAFA5;
	Thu, 23 Oct 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc1j2XTj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3F235063;
	Thu, 23 Oct 2025 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239581; cv=none; b=kxGiRKw/Md37sMb89ejiVzi29rHUlmJ/Fzj8DDCBIQIPMZYLS0e+jbC1QOTZ5ITZXgwBGxbofFu+FMsKBrj+oVlFha5xtT+++aXpQmgp27CLpDgJthyWISBf6DO6v/kv0dWKfTk5h/W2fIaG2Z3Lh5NzrGQePoqpOur2EHNJrZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239581; c=relaxed/simple;
	bh=uThquYsLE/eESBSNMrBv+gcGJQb1x5hHE3EyT9MbTp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ltiff9GFgoc6UTd6THzzWnVLs8kpUnDurn8oz5DaO1JUpaGj+CI2T2HSNWaZYcMXyylWPFiMjhm/oST4MJPfNBfri1ao6S8klH0E+F+Pr/zxKWK6uoNOGWZGo/YJMSMfjefPAXOcKePgeaWV6HEDM8eQgCWR09ya0jdG0Dwgmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc1j2XTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02251C4CEE7;
	Thu, 23 Oct 2025 17:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761239581;
	bh=uThquYsLE/eESBSNMrBv+gcGJQb1x5hHE3EyT9MbTp4=;
	h=From:To:Cc:Subject:Date:From;
	b=Sc1j2XTjrruOB6MUoCqJOu6NtZchvbHwLKK7U/10WUVPmQ7Qd4CYOOdTvyE2cG1Kj
	 NM20Wg1k1qhn2kA0EwVuZlBuyOt5jB4qubpruettgccxK6UVrKt2bXr5n/gNoqyW3W
	 OHjCIGfTcNipWlHyX0LiLQkCPrk6WOgqKEFU4TGO4Qbqs5leLvO5FlJ4y1Kc8guoz2
	 oYG69cWhaAJFU5It5O5Pk+oUFoESXuSObsJeTiWhyRqBGaL33wh9S5uM52s01QiuUp
	 miCkmuEYKibTIkZy9Fk3iejGD2bjWVhADW4YfSZBcXV9OmHp6s9+BilyGChEuUanBm
	 QLu1TlQXFw5fg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1] cpuidle: governors: menu: Select polling state in some more cases
Date: Thu, 23 Oct 2025 19:12:57 +0200
Message-ID: <12786727.O9o76ZdvQC@rafael.j.wysocki>
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

A throughput regression of 11% introduced by commit 779b1a1cb13a ("cpuidle:
governors: menu: Avoid selecting states with too much latency") has been
reported and it is related to the case when the menu governor checks if
selecting a proper idle state instead of a polling one makes sense.

In particular, it is questionable to do so if the exit latency of the
idle state in question exceeds the predicted idle duration, so add a
check for that, which is sufficient to make the reported regression go
away, and update the related code comment accordingly.

Fixes: 779b1a1cb13a ("cpuidle: governors: menu: Avoid selecting states with too much latency")
Closes: https://lore.kernel.org/linux-pm/004501dc43c9$ec8aa930$c59ffb90$@telus.net/
Reported-by: Doug Smythies <dsmythies@telus.net>
Tested-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -321,10 +321,13 @@ static int menu_select(struct cpuidle_dr
 
 		/*
 		 * Use a physical idle state, not busy polling, unless a timer
-		 * is going to trigger soon enough.
+		 * is going to trigger soon enough or the exit latency of the
+		 * idle state in question is greater than the predicted idle
+		 * duration.
 		 */
 		if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-		    s->target_residency_ns <= data->next_timer_ns) {
+		    s->target_residency_ns <= data->next_timer_ns &&
+		    s->exit_latency_ns <= predicted_ns) {
 			predicted_ns = s->target_residency_ns;
 			idx = i;
 			break;




