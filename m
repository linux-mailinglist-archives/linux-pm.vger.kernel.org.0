Return-Path: <linux-pm+bounces-40883-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6894AD21187
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 20:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5C40305C42D
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jan 2026 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7109C333427;
	Wed, 14 Jan 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/oGBCZI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B131280A5A;
	Wed, 14 Jan 2026 19:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420136; cv=none; b=emex8Tp6OB+x3hW+hwJ87hY9C37aw1EZhFYXXTtPu1ITmdMLqpTp+DqlzDRs+nre0D+/v+7E7nOiGZeWbsISHC5/RGk3Js3HztMXoIrVIvhQWQtJgnpD5Zvv7qo1z7vQuOjfmYlqNusvTlnLkan18g8k1GguQeHuCAbZxn0HDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420136; c=relaxed/simple;
	bh=67dRnXhT5swd+9o6UzzoBwZCRbkwliPMj3x4H4DbXto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5zlBJ2L6azUZ/yt9b5q+ScEiXdo+kmPWkSquA2JjhF/H6x5LeF9xqm7Vwicggbh/4eTMpu5TRL7gbvqunLJB4ehG7TdugpS1mSkJVf79zFjrJWGheQyQ6v7/5N4LDl1jjjrbhoayECzgOgU0Qi6fgpeJwxBYS7/e1cYetHdy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/oGBCZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DBDC19421;
	Wed, 14 Jan 2026 19:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768420136;
	bh=67dRnXhT5swd+9o6UzzoBwZCRbkwliPMj3x4H4DbXto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/oGBCZIic+EOB9sVSPAm7f48wBVEBkroNxu2CM8knPhTOIWP6VKU+2frM6lzgdka
	 9dn9Uj3PPATpm0l/tU8Ku2XSUA04lAh1OrXuSnJ7PGvKQqbk9lPKvefBeZbFTU+V2Q
	 o4FM7fXgOYNN2lUH23HW3tRJRGNt2pDlsx2GVSHcRZjCI1W3BIBVt5XumqmYWbY1Ka
	 whPuWA7aUDv0qE6pTPYRGGzuG8Brv+4y5VNy9/VRgPVH0gdWvfv9Sw9owiWeqKhaLW
	 qnPvvseDijbByPrISxa0cJHr5wtXPfimj5aAgQ7ZQZLBb9snpBS2IXuo4KeKDHyn1y
	 /nUVX5zbQaQPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>
Subject:
 [PATCH v1 1/5] cpuidle: governors: teo: Avoid selecting states with zero-size
 bins
Date: Wed, 14 Jan 2026 20:44:04 +0100
Message-ID: <3033265.e9J7NaK4W3@rafael.j.wysocki>
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

If the last two enabled idle states have the same target residency which
is at least equal to TICK_NSET, teo may select the next-to-last one even
though the size of that state's bin is 0, which is confusing.

Prevent that from happening by adding a target residency check to the
relevant code path.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -388,6 +388,15 @@ static int teo_select(struct cpuidle_dri
 			while (min_idx < idx &&
 			       drv->states[min_idx].target_residency_ns < TICK_NSEC)
 				min_idx++;
+
+			/*
+			 * Avoid selecting a state with a lower index, but with
+			 * the same target residency as the current candidate
+			 * one.
+			 */
+			if (drv->states[min_idx].target_residency_ns ==
+					drv->states[idx].target_residency_ns)
+				goto constraint;
 		}
 
 		/*
@@ -410,6 +419,7 @@ static int teo_select(struct cpuidle_dri
 		}
 	}
 
+constraint:
 	/*
 	 * If there is a latency constraint, it may be necessary to select an
 	 * idle state shallower than the current candidate one.




