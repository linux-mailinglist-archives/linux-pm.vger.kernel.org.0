Return-Path: <linux-pm+bounces-42703-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAfcIbMwk2mI2QEAu9opvQ
	(envelope-from <linux-pm+bounces-42703-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:58:59 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D4144E4D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 15:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CBB300CC0C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B60313272;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZnc3x0J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F528FFE7;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253887; cv=none; b=j6NQ4miXcwJQCJP5QjIwCxr/rJWSUZB6YQG1kdMSE+XY16Pl8PB1RrH+OgExeNjt+cVcVoHV4lMDltg0AbwmhYxSm5YGjmIEttgSuqw9FExmHvxqM+De3WIZn5WNfApHkLUzdFvk/C1He8DiVkUdH7vSGhIbsLFMl4yJ1fukbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253887; c=relaxed/simple;
	bh=sO7TBYofqYSM2bgeL92RYGu50mNH9qEmCpadIybs00Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z2x66ljXW6ukcwCcrFPglUVr/OJs7v0mqCv0s4+LYzM2bFiYH7WTVhRWXhOH70bqhnpz1waAwQCokcUcnY1gY/Dk6LyhS1gIB7Lg02nNaiRRMtHGQy3qz5659z6Uh4BwbLK4ZSZD2ImLeC8Tc5oe7hYmV3pHwJBcU8m1bD6ZVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZnc3x0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 321E6C116C6;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771253887;
	bh=sO7TBYofqYSM2bgeL92RYGu50mNH9qEmCpadIybs00Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=JZnc3x0JnNc+ceYmxA0Q8hIOBYkmwRQWjvhxe9xHkuPu7cxJ0AvJyyudsvWv9U7aN
	 Gef8uu5TCBVlC75HHs7vj+HItKK3CzbqyjTzLkx8OcWPXXdkIowNIa/ZC2RtutpiiN
	 LnGNUIkFVjOC+WbvwpMJfiYs0pqO3ev92Auw8A54Cp23izPE3GzJ6RYK6IyFsEUcyq
	 k+xih5YhFITZxTXKNh5oC72gCBf8Mu/g9jJ0sXDhiuJ+ILXRt6qtc31EzNvWQ6rKOD
	 MEGR1CbnRGQDv3Wjs2wVq96UxIhEIxbw79F+/SdsTBVdAGx2wwQBWlmGmiQogTLgSC
	 Rp4Q5L25nMFmg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10722E81A28;
	Mon, 16 Feb 2026 14:58:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH v4 0/3] mm/swap: hibernate: improve hibernate performance
 with new allocator
Date: Mon, 16 Feb 2026 22:58:01 +0800
Message-Id: <20260216-hibernate-perf-v4-0-1ba9f0bf1ec9@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33M0QqDIBiG4VsJj+fQv8za0e5j7CDtd3kwCxXZi
 O59Fgy2BTt8P/iemQT0FgM5FTPxmGywo8tRHQqih87dkNo+NwEGNQMOdLAKvesi0gm9oUZJ2ZQ
 KFAgg+TR5NPaxgZdr7sGGOPrn5ie+rm9K/FKJU0aNEIgtYi17dY7oNLp41OOdrFiC/wBkQBtot
 BSKVUrugfITqHdAmQFZIQPBWs4r8Q0sy/ICjdPWYDABAAA=
X-Change-ID: 20260212-hibernate-perf-fb7783b2b252
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Carsten Grohmann <mail@carstengrohmann.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, Kairui Song <kasong@tencent.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771253885; l=2863;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=sO7TBYofqYSM2bgeL92RYGu50mNH9qEmCpadIybs00Y=;
 b=CpIU6uKntmcDupIJYIVmNkZrat/SPDOFtjFTIqHnuR4BpQdR82jnesJYYScaxY4crDNFtIKs+
 pzIT1VZg+Y9CEOaqZvFVJ7o4WqAzx1ovXKLIf+7wkElkcoOdiDUWyUK
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42703-lists,linux-pm=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de,tencent.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:mid,tencent.com:email,tencent.com:replyto,carstengrohmann.de:email]
X-Rspamd-Queue-Id: 087D4144E4D
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
Tested-by: Carsten Grohmann <mail@carstengrohmann.de>
Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c18f@gmx.de/ [1]
---
Changes in v4:
- Reduce indent and improve code comment, as suggested by [ Barry Song ]
- Link to v3: https://lore.kernel.org/r/20260216-hibernate-perf-v3-0-74e025091145@tencent.com

Changes in v3:
- Split the indention change to a standalone patch.
- Update mail address and add Cc stable.
- Link to v2: https://lore.kernel.org/r/20260215-hibernate-perf-v2-0-cf28c75b04b7@tencent.com

Changes in v2:
- Based on mm-unstable, resend using b4's relay to fix mismathed patch content.
- Link to v1: https://lore.kernel.org/r/20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com

---
Kairui Song (3):
      mm, swap: speed up hibernation allocation and writeout
      mm, swap: reduce indention for hibernate allocation helper
      mm, swap: merge common convention and simplify allocation helper

 mm/swapfile.c | 92 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 39 deletions(-)
---
base-commit: 53f061047924205138ad9bc315885255f7cc4944
change-id: 20260212-hibernate-perf-fb7783b2b252

Best regards,
-- 
Kairui Song <kasong@tencent.com>



