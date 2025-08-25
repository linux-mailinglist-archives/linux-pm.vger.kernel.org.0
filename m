Return-Path: <linux-pm+bounces-33026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997DB340C7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 15:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539341699F2
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 13:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22A4271454;
	Mon, 25 Aug 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+UtrlE/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0F1A83FB;
	Mon, 25 Aug 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128748; cv=none; b=khg4kpvO2+E7maGsOfcuAw2qW9jBlbZjSd1TSvJ2MkmW5WfHKTGI+uAzSU3V+FBOl70vEmFju7fwbfL4r5Vj0568XD1ZCDvqCXsPZuTpdyMkKnSF7Zvhh43rn9e3sOFKSmWMux1Jbm0lPKCtahCYFjXOTL3EyHK44ethacbQEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128748; c=relaxed/simple;
	bh=EmCPsytqi1MNyRan12b0CRrMN9lJY4kllwbmfzdc4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILrVjB63CEbUTCvHJw9/FzQY3Y8b3JTzHh1FGuf3K8pP+4e/2pIqw1LlELFG5OReTU/gqaAsClq5S7MS/z6tOG9rBF0yXULZ+7kd67TcviFxu5czwHriJQhQdLpaQc8h9BjQXlNiipLZrHBzOVfRmOh2RfDX6cCFEs4oy2udCfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+UtrlE/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEEDC4CEED;
	Mon, 25 Aug 2025 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128748;
	bh=EmCPsytqi1MNyRan12b0CRrMN9lJY4kllwbmfzdc4Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+UtrlE/i5tMvVHUYHCIYanGDjq9v6lQqf4ycjiymEvtKCKAEguIVJeo1aRRr0L6M
	 tb/WjlLvz5sKd2yv83X/AurmsMqU9u4+AEO9Y0L8uJs66CqqXENz/ao0xc+YpLCPKR
	 vfDwWTrt3RtEGWGJvbB2vo1vMOA4OMUO/c6NLwx0nib4fXo3x716t2eQHGsSaRZjGG
	 1OxIJYqm8Zz3TXKT+JFEh7wdPGjKkgS1lt2oahEd6X4Y3CKL3VOJsXbWk4A/v5+YLz
	 JLIxyBrUEpcMIZXpgYQeXsUc0ymNJUlkogeCPHVjMU/2Qe30Eqw5+hBQKXJqz3OVkc
	 fg3Hk5lNCMHLA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject:
 [PATCH v2 2/3] thermal: gov_step_wise: Clarify cooling logic description
 comment
Date: Mon, 25 Aug 2025 15:28:34 +0200
Message-ID: <4690596.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12745610.O9o76ZdvQC@rafael.j.wysocki>
References: <12745610.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The cooling logic description comment next to the get_target_state()
definition is slightly ambiguous in what it means by "lower cooling
state", so clarify that by replacing the ambuguous phrase with "the
minimum applicable cooling state".

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_step_wise.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -23,8 +23,8 @@
  *    b. if the trend is THERMAL_TREND_DROPPING, do nothing
  * If the temperature is lower than a trip point,
  *    a. if the trend is THERMAL_TREND_RAISING, do nothing
- *    b. if the trend is THERMAL_TREND_DROPPING, use lower cooling
- *       state for this trip point, if the cooling state already
+ *    b. if the trend is THERMAL_TREND_DROPPING, use the minimum applicable
+ *       cooling state for this trip point, or if the cooling state already
  *       equals lower limit, deactivate the thermal instance
  */
 static unsigned long get_target_state(struct thermal_instance *instance,




