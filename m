Return-Path: <linux-pm+bounces-42662-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJVsFyafkWlMkgEAu9opvQ
	(envelope-from <linux-pm+bounces-42662-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:25:42 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57613E772
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B2E23003728
	for <lists+linux-pm@lfdr.de>; Sun, 15 Feb 2026 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1842882BB;
	Sun, 15 Feb 2026 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGbsa3nI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F822571BE
	for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771151131; cv=none; b=lkoWWjVJ/a0S4mLK0lP6DtPOXQH4fxv4DhovDR4d1JuJr7xdxHYqqlJAXYC7IEy2sVTnm5Rwmb68SFz/ID1Edb0tB7rR7xq/fHOgHHZJHVklfyvyoS6ucWyAt+T/SCtleMGO8NQMU61PSlk9A4f5cWiKZV3hHDBtbtH5XHrx4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771151131; c=relaxed/simple;
	bh=zsPaUwrv0Ep8jMwtrRvaCSXD2/IbtK73bkP0ZVnB72g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s9OdqjvKWLEYn8mzJyewAt1bEsBcsh0VLCtfwyEbNROu7B7CMlMwtDCiRz/WfyikDtUvVdTw8NPc64xiQTFpG4vbq6oyRM1PSBVzk9UU3gb2O48irWHA1E3oWUKgjJ94/+ponOE0mV5SP0FacZSRrG7rx9ZA/WWH9WDApjMa6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGbsa3nI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a929245b6aso24937635ad.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771151129; x=1771755929; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7lqDo2NqhO3vqudm4FoktJz4U05rX2reLP4IjhP7Pk=;
        b=nGbsa3nI1DUiOOT46AUNrA5huR0X/2FRqULZj0/C5+1Nn0SQIvnFyeJVA5pJ4L0E7i
         hG/rLxLlVkVl39/+Q8BHbC9L8y7IuGOmtamxtw6nAs1CiB8upupD9DyLuLXU9aQuosIU
         6MopMVPryUIKjdZv0DsYyb7HCpl+Tk+ZC4/xyibXpg9o8QJFeN3xPb2+im18g/Kg0Nll
         8nC64Yd0V4bwow/BXxjIHOfl5rZLUjvZY5eukGx2Pp/3KF++5uBjChUQ84uPqdEGxn+I
         U5ZMYWB4uUMEmCallLGq6tXErQpr56j7gaxTqwz85FVFOjksZAh3bamMtrxnNm2hMCRM
         veCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771151129; x=1771755929;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7lqDo2NqhO3vqudm4FoktJz4U05rX2reLP4IjhP7Pk=;
        b=QZR2a1jhCUkH0mg6AoH/A0gyxaewNQcXmbAjkkT0YnXO6e0VTF3yLjpj60fEqMzL21
         gpSVx4wy+8xKDizfVXWWXB5DpYX1pl7CyJQ3iDKcr2+8Xb8xpFLdV4O6Glf6qSM3sejC
         u9WVFrgAjVU8QbnpX5PiqUQQBgVT4VJKAa1qNqtEJgF3I9N2mlT37n5/HelXvdblZXqO
         BW7+clax2d8xWyOgVv4zrwM33WF+yaREbB2lXAyVuKyagDfJqJiP+FVdgbOnyzrKWyC1
         9etbyDktn7ufCcOm5Aqra70uLmUNluFE4CO+XVH2mg4mtPwe0y4poSmAGiJLvTAC/Hf+
         uJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8v9LW+rzaE5ITMjkyo+I3Z8aS8gvjacp1WHINe7qRxPYnHqTKj4PRxI24grOT2OJoPGUeFOOI8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjasuyVW900ymOC6wlQY+bJLuRik7wspidel9ngG+HwH2vJCy
	gEU78u6XknKiy1GO9E2ZznLln0Lf1bqqr1WFSRh0M9k6NCgwMvEq8+A8
X-Gm-Gg: AZuq6aKeWoyxFhaJe1fEy0hUTqiLtQqaMHHWCByOfaC2PLihjkFbfFyXHF88RUwAAVu
	NaA6BUhOsY0Iwcjh95LIBxPSybG6BTggj7WIMVrYb0RpyxEOnw7sBoNiNuqiY3i122ExWwrlCeV
	4pM99btyrJ/xIJiv2XVARSVFYrhmmxgUsuz/OZ+mToVIuqqBsnNNfLGXuVGxHMl7QDtXH9TzlNf
	YdmEOpk4E/2rvEtoBXp7VkjpUDV2Lf9HnngYNpdGRk7GeXcdMyM6aXf8TDTfDAVTojaVVid5tYW
	QeYqeRO6Mldw+feyE9XFFRbfH27tCNfEYJ4BCK0i8gYQyrCxXYwhO9AHYIPuMjgFa8xMaWM2njg
	ItS6jaeZfZwQDF/y7vEOqHPo5CxLXX879WGH/Yh970w6s/ijNaNfNNCRkV+K6PP5KHXzkxOp+jf
	G2wCvzPSKAauBtlfJtxnQWDMZPVIpWJSd/ZtXgwa3xnlKMZu+Yg6klYbRKazh5
X-Received: by 2002:a17:903:1447:b0:2aa:dbf7:7449 with SMTP id d9443c01a7336-2ad17501fbemr57945775ad.37.1771151128948;
        Sun, 15 Feb 2026 02:25:28 -0800 (PST)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a714786sm41862045ad.31.2026.02.15.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:25:28 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH 0/2] mm/swap: hibernate: improve hibernate performance with
 new allocator
Date: Sun, 15 Feb 2026 18:25:08 +0800
Message-Id: <20260215-hibernate-perf-v1-0-f55ee9ee67db@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQqAMAxA4atIZgs24g9eRRyMppqlllREKL27x
 fEb3ksQWYUjTFUC5UeiXL7A1hVs5+oPNrIXAzbYN2jRnEKsfr3ZBFZnHA3D2BISdgglCspO3n8
 4Lzl/q/tiIGAAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771151125; l=2198;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=zsPaUwrv0Ep8jMwtrRvaCSXD2/IbtK73bkP0ZVnB72g=;
 b=t5wPF9nPCJVtgwv9frP/KZqIAiCCzBg34C0hj0d2KRli973tstEbTbBUcT4gb2we2fqfqoLs7
 6n+nChJM20iBRFwsZIZm65VL0C0FeviTGTDiuYlASCM6gNFyK/KXuvm
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42662-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,gmx.de,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,tencent.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: CA57613E772
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
to Carsten Grohman [1]:
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


