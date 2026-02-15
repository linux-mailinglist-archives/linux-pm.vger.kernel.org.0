Return-Path: <linux-pm+bounces-42666-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMM/D8GqkWkrlQEAu9opvQ
	(envelope-from <linux-pm+bounces-42666-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:15:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8913E90E
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 12:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 753DF3001AF2
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002A42EA171;
	Sun, 15 Feb 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXe0MFJA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11BA2D46B4;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771154108; cv=none; b=mnkZ6VfNTvFu+Eaneeoh8uMGut5LVe+8dx4qDtee/OC72847kUGEc2afOW8nE6SDo3KkrDWQdT/ebEs+GeUaf0kPlFamhCoiAIy0WLlKjgSVqZY3tVy+G/+YuPuu9WxJGhj7xXLqk8FnnfHuPcGYSSmEuW45eQGzeucBoDPZKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771154108; c=relaxed/simple;
	bh=NQIjZ4ioUQRkgBsK3tTxiXoZE9AA6RuocC+q3Uk/4Y0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GfHm9GEXaERvH1n2hxNeAhjeCTwdFcAnLpUV/A4AZVvkiERkHlGFq0ulR3hSOvUKjEDM/DSAb1rdrIeGXWzbwEw8gb/ldMaUPey64a+B240wlXyEnvtBl5Zmxv6wsrDH6AvHJtMGEqEndBMXYiL0uP+puJwysifkUagJDMtpC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXe0MFJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B4C9C4CEF7;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771154108;
	bh=NQIjZ4ioUQRkgBsK3tTxiXoZE9AA6RuocC+q3Uk/4Y0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bXe0MFJAxMqHNS+DxiBiPGrmg8EZPmuoYWrJRI4dVgC+dozLZaWmQRTYJC8huGT9E
	 Eex7GWe8Xd6b2t/u6ykH2MC03SzCBtp7eHLr4dE9A5HIvXBV7ZZPirOlaVM0qX5qXn
	 vyEvXiaxlz9LQQ7ppL7xp6ZnHS35IGpFIwh2nCq7FHYUnekHFxZ0recwfMPw0wXJXA
	 EugGk+n4AokfzQ7Njo9AoMl+FjiqbMbEEUFxz3t3oYJwM7JOtTfcw/gd7DLkC+suTh
	 Jpk2btFh8eDZNl2yFVRRudx2AvSuoit96ntl3zgvpiIyXwvmUY2Ms2npaDE686bG6L
	 JeoSH/QA/tJfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E367EF5854;
	Sun, 15 Feb 2026 11:15:08 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH v2 0/2] mm/swap: hibernate: improve hibernate performance
 with new allocator
Date: Sun, 15 Feb 2026 19:15:04 +0800
Message-Id: <20260215-hibernate-perf-v2-0-cf28c75b04b7@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MwQ6CMBCE4Vche7YG1pSqJ9/DcKBlKnuwkLYhG
 sK7W0m8ePwnmW+lhChIdK1WilgkyRRK8KEiN/bhASVDaeKa25obVqNYxNBnqBnRK2+NOZ8sW9Z
 M5TRHeHnt4L0rPUrKU3zv/tJ81x+l/6mlUbXyWgMXoDWDvWUEh5CPbnpSt23bB9Yf3cauAAAA
X-Change-ID: 20260212-hibernate-perf-fb7783b2b252
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771154107; l=2398;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=NQIjZ4ioUQRkgBsK3tTxiXoZE9AA6RuocC+q3Uk/4Y0=;
 b=S3NiucafmUUST/nkOt+IvADfvetNDt1JzSV8IQDhzqNXwofm3wrAiMiPz3Uh43VWuydX61Fvs
 qflPpuuZ78iCwE76Uq1SqsbxlVzII2pvjz+ZZUo3EfmkLMiXfTvC13J
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42666-lists,linux-pm=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org,tencent.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: A1D8913E90E
X-Rspamd-Action: no action

The new swap allocator didn't provide a high-performance allocation
method for hibernate, and just left it using the easy slow path. As a
result, hibernate performance is quite bad on some devices

Fix it by implementing hibernate support for the fast allocation path.

This regression seems only happen with SSD devices with poor 4k
performance. I've tested on several different NVME and SSD setups, the
performance diff is tiny on them, but testing on a Samsung SSD 830
Series (SATA II, 3.0 Gbps) showed a big difference [1]:

Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) thanks
to Carsten Grohmann [1]:
6.19:               324 seconds
After this series:  35 seconds

Test result with SAMSUNG MZ7LH480HAHQ-00005 (SATA 3.2, 6.0 Gb/s):
Before 0ff67f990bd4: Wrote 2230700 kbytes in 4.47 seconds (499.03 MB/s)
After 0ff67f990bd4: Wrote 2215472 kbytes in 4.44 seconds (498.98 MB/s)
After this series: Wrote 2038748 kbytes in 4.04 seconds (504.64 MB/s)

Test result with Memblaze P5910DT0384M00:
Before 0ff67f990bd4: Wrote 2222772 kbytes in 0.84 seconds (2646.15 MB/s)
After 0ff67f990bd4: Wrote 2224184 kbytes in 0.90 seconds (2471.31 MB/s)
After this series: Wrote 1559088 kbytes in 0.55 seconds (2834.70 MB/s)

The performance is almost the same for blazing fast SSDs, but for some
SSDs, the performance is several times better.

Patch 1 improves the hibernate performance by using the fast path, and
patch 2 cleans up the code a bit since there are now multiple fast path
users using similar conventions.

Signed-off-by: Kairui Song <kasong@tencent.com>
Tested-by: Carsten Grohmann <carstengrohmann@gmx.de>
Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c18f@gmx.de/ [1]
---
Changes in v2:
- Based on mm-unstable, resend using b4's relay to fix mismathed patch content.
- Link to v1: https://lore.kernel.org/r/20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com

---
Kairui Song (2):
      mm, swap: speed up hibernation allocation and writeout
      mm, swap: merge common convention and simplify allocation helper

 mm/swapfile.c | 56 ++++++++++++++++++++++++++------------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)
---
base-commit: 53f061047924205138ad9bc315885255f7cc4944
change-id: 20260212-hibernate-perf-fb7783b2b252

Best regards,
-- 
Kairui Song <kasong@tencent.com>



