Return-Path: <linux-pm+bounces-38391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F5CC7B9F3
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 21:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF983A6A54
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 20:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2E27FD7D;
	Fri, 21 Nov 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEMMnXb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FE221D3F4;
	Fri, 21 Nov 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755879; cv=none; b=CYEzVanYrLXaRhyZ52Y2ALDqtpJ3rioZqpdAE2yXZ6JAs8LaBPdb63L6T1TP9zfpAKI4tDjjQq/x4T71MWqg6aeqlxl5t6KNEUzyhzl8XPHD1U9K/xvL+tghjDl02G9NYgvmn0b2Hpd9gdc1KB4BJdLAF2aRMT2QIZJJ7nrqznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755879; c=relaxed/simple;
	bh=ib7Xa+Wmzl2AJLZBVQPDC6tTC58Jge5UA9hTddaWVr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XHH0TODm11etEWiIw3CWysuVcEsf4mpHyzrzReITRsBq/I5+7rNDYtPRjAa7W+jwWPnTTvzCiv3H5NtTUuRoB7DuuYVzh7ZgGz2bl6prTSpGCykFAztsW/QzTrxBUJyMVRG7OnJN/FkcKDeJnXihfF/Sy6YLJIuMIRk64Sbl0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEMMnXb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A652C4CEF1;
	Fri, 21 Nov 2025 20:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755879;
	bh=ib7Xa+Wmzl2AJLZBVQPDC6tTC58Jge5UA9hTddaWVr0=;
	h=From:To:Cc:Subject:Date:From;
	b=lEMMnXb/GfHEaLqwVsM9jESd+X1DF8EuW+lSiwIh/yLq54yssKnC8xFJfqkwzCm/y
	 TN2DL+m07EFqKL8IYJOnWlAycT6MMht498Kzc9akAI/lbAO4vCzXBFeFEltWWvJ8xw
	 I16N9t0VWwE44Sfjz27dA2lfilZFGCoZiE9DjTrli88+u3mWDUMbZpzBL7kk3uqBrr
	 7unORZ81TXOxFasrtmbM48Y6ggUajSP+0CisI5ddehLQWAXY41wGqL46vQdrsMKJab
	 ROyoYwBTxl76EMFN8JCL+cAmnfFv04RKM9jhJliqu7PnwemWkrUFqGMHGzhh4aIHOL
	 R0aZuy+x2OCKA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Subject:
 [PATCH v1] cpuidle: governors: teo: Add missing space to the description
Date: Fri, 21 Nov 2025 21:11:16 +0100
Message-ID: <5059034.31r3eYUQgx@rafael.j.wysocki>
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

There is a missing space in the governor description comment, so add it.

No functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/teo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -76,7 +76,7 @@
  *      likely woken up by a non-timer wakeup source).
  *
  * 2. If the second sum computed in step 1 is greater than a half of the sum of
- *    both metrics for the candidate state bin and all subsequent bins(if any),
+ *    both metrics for the candidate state bin and all subsequent bins (if any),
  *    a shallower idle state is likely to be more suitable, so look for it.
  *
  *    - Traverse the enabled idle states shallower than the candidate one in the




