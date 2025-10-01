Return-Path: <linux-pm+bounces-35647-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA6BB15EE
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870A0189E1D3
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1227A255F3F;
	Wed,  1 Oct 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwlXQfzK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE040254AE4;
	Wed,  1 Oct 2025 17:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340074; cv=none; b=c+raqcVtytW2C7ZKLYl4GEdYzlZ86i5PlMjLCT9DNeOzx/Zlkx/tVaQLapnYEJrslcYsQIfmS+nqhFDLhHVQIK0yzdzcZZSsMZ6bcOAV6EAyTSprQustAxCydG2udaUW5QHLOFMPUFn/jV0vuqwTI1wUX+Rlf+kUGwhwYxEdOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340074; c=relaxed/simple;
	bh=RcC007vheekuBms74xJJDKBu49gcwxLUFbD4TD8pQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qa3CsRSQhgSxChf7lnxBjGToROrwRk7BjsDdO2DmWNBujtIx5OK+lpX5A48xFMYZc6NcI2DAO0VSZZ/k0axc1KPMyvodmwP7vn4nQ46/BevXiMzCiHbPJkowIbBZR603Y8pcRGfFRt62MJQBxcV9PjPuDopO1mZxwjKo9neNkuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwlXQfzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35EEC4CEF1;
	Wed,  1 Oct 2025 17:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759340073;
	bh=RcC007vheekuBms74xJJDKBu49gcwxLUFbD4TD8pQiw=;
	h=From:To:Cc:Subject:Date:From;
	b=KwlXQfzKiLNV7NmYr1mkEoYSz40D8jpSdwPy4/7+8Zx1grmK2/ruJfHl0827kh4x4
	 CfO5vUYnRvuwfQ5xFNSeh22R0PnJ8FlpIOdYXV1KBF3qV6z2xkCDFOfmSmUaLoQzDN
	 99EXwygT3deejBz6u2PFOXyCqNK39I1VmQTi7+1D3dPcmBgVLRi/yhT+iIU0tkZTQh
	 pcyaxMSqbyZQdgfXCmloXuGwRqsyPGQbPQdNjM7AmHjQl6bPyyuwSS9Ib5QG5JIo2h
	 LzYO6G+aNIYP208EdRdPCquEWk4nWrql13yzjh5mf+MCdfVZM/0yPcKIk2x+t9pga2
	 ap0/2r1yif09Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Takashi Iwai <tiwai@suse.de>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v1] PM: runtime: Introduce one more usage counter guard
Date: Wed, 01 Oct 2025 19:34:29 +0200
Message-ID: <12752072.O9o76ZdvQC@rafael.j.wysocki>
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

Follow previous commit 9a0abc39450a ("PM: runtime: Add auto-cleanup
macros for "resume and get" operations") and define a runtime PM
usage counter guard in which pm_runtime_get_noresume() and
pm_runtime_put_noidle() will be used for incrementing and
decrementing it, respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit 9a0abc39450a is there in my linux-next branch.

---
 include/linux/pm_runtime.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -610,6 +610,9 @@ static inline int pm_runtime_put_autosus
 	return __pm_runtime_put_autosuspend(dev);
 }
 
+DEFINE_GUARD(pm_runtime_noresume, struct device *,
+	     pm_runtime_get_noresume(_T), pm_runtime_put_noidle(_T));
+
 DEFINE_GUARD(pm_runtime_active, struct device *,
 	     pm_runtime_get_sync(_T), pm_runtime_put(_T));
 DEFINE_GUARD(pm_runtime_active_auto, struct device *,




