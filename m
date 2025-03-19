Return-Path: <linux-pm+bounces-24279-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C86A68C08
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 12:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615F11887E8E
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8483254AE4;
	Wed, 19 Mar 2025 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTd/qYAY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2F254AE9;
	Wed, 19 Mar 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384645; cv=none; b=pgREXnxA9v/qxExt0jqj0J06pWsvhodvEB96NeqbkZ8/orVZKND7LNHT2ORP6kUIYSVE0hGQ2SYCuvtxqC31MH8J+Tp0NnPaTAhrvblhBw82FKFM4y0ex82j3O1/AYdN5WAgXEtQVhx1NO5OP0R9Ih0v/yy45Iyjs4i3F6xil9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384645; c=relaxed/simple;
	bh=+pSipfeI+B+vV/e1XnG3T5gmVUXNbL9HXdZf0Q9JU0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExSShk2YtSoYlnRZ+c01mGfJBd9Et5qJDu6th3fXbJbvAqZ26DbqdjHWp1t8D7w3cHNkVgV2v9s1vWx4mz+VJGd80IDvIQ+Ze6AuZd1nzAlqXwv3wCjmviArx3WeCCT9aYhvgOu77TMbslPCqRNQsnE5+4u0RXu9AI8wDr67/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTd/qYAY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so20945195e9.1;
        Wed, 19 Mar 2025 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742384642; x=1742989442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QL7BS25s4toe0J9QffAsg3Jfdyw2hfEy684XAQsMWEw=;
        b=GTd/qYAYsIlL2ctFtLMhS59T4kVxXo0Es7ltNs7nvldVCsdDVWVg8mXRHE3s24XQYS
         NIj/GvHIypqvxyVn+UKvYYYq0rD4PJ3QQ8Hl+RYt5fw26lGkEVToK01hJgHjtk0uuBCf
         uvzXF5QIuOrDQJOV9R8aGO02718b60yIL2Oo50HBWmiAn/eq1yDzv7v5H+64JH6sg5uO
         K1u/nfSArkJmFkBtXp51KhpgLmogbd5tDH1WIt1SpgV4iiI4EpIeM6BNwi5+H4+kdVKo
         0haCO8UZdGif0KPg5Dlas54aNE2btzmXnzhHkvBbe9ual4NSj0ZlOYzwacriwFAyr9zf
         PzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742384642; x=1742989442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL7BS25s4toe0J9QffAsg3Jfdyw2hfEy684XAQsMWEw=;
        b=hu8FH2mgXgYsqcdVHr8f4BZMKPjkePTX6sfOLFtVL2rZk2QLpW6pLoo97DPlEhMatC
         DkvyEoCK+9A31+ZGh5drr+AoPqDQxtaTQoTMFaRPkP6kSSBK50eIlq5K0HmJ+kBZYBPw
         YZjaXckG0rqBm4/xsKBbV6YW3NhF+K4IN5RyBsUSY5N8rUL0mfK7/zdhU37DE+ONeBf0
         SVyUyhiGUIYEejTyo6CHmjoBlowCuYxiVQq47H0LZMZSJPzPvcwWQkzCoivXuqqoiD33
         jIiFkawMX3y4xUumLNkS1JSBh0mSoxX+b8gbimA41N9KEwXz3yIlUXoIxHxbGYtzy59o
         Vbrw==
X-Forwarded-Encrypted: i=1; AJvYcCUAh4Pi0C8S/jnmsNI2BQA54bhG/mKgxFqNcEZmDMm5p/p2Zi/wLsd+nDaajThXBZ1NHi2Y3Oxb+o0=@vger.kernel.org, AJvYcCWjYrTPal7/kzgX+hJzIYSenrQ2YDrkZc135ITJF27UIfLwUmtElcqp/JW8J51kQ05dnQPTMh2Nd+rn6qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDw8oi7EHp20yOjuCIYrJEFZOFoyD2DZuifC2wMdYRXqN3vOu/
	uJNege+qi/7eDpO+mGVw4TpU3LiPhR529EK4Gmg4PnncqtM/rmGIBudFG+D1B7w=
X-Gm-Gg: ASbGncu6XcDtENNlUhVNVjsszjhv2QIp948sVEno7cgCLIzrW3ey8nG5tfWONLYjtz6
	8xheJnBaBOu5/WWBqaMQBfVKAOlX9dupR5byupmdVbIxAaR6Ntpk1NQEWpCvH2TgKef+6p6s9xq
	cdbOCrR0N9Lk/VFDs8CBExreggVnIP2UX7IemfnPhggg035LukzlhSy6NMxnWVUHZZVEg0khjDm
	1rSD1MAi1NN1X3OChP+syDPum+l8V6eh7tvHlZyN39rx4h8/lJV7AFdboghRsEn2qDP2Q02eYPF
	Rushc5StZoChCbqE04X4NjGcbZwt4sTOEGYxcPooo1bArw==
X-Google-Smtp-Source: AGHT+IF7L7ygVo4N1A7Gdl1rTjfOLv0RMXKxqf4sN48Uize/BfTL/jm4QDLk58FaYcYVgIEsKDxf8Q==
X-Received: by 2002:a5d:5982:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-399739c1524mr2483183f8f.14.1742384641961;
        Wed, 19 Mar 2025 04:44:01 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb40cdd0sm20819122f8f.77.2025.03.19.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:44:01 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PM: sleep: Fix bit masking operation
Date: Wed, 19 Mar 2025 11:43:24 +0000
Message-ID: <20250319114324.791829-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The mask operation link->flags | DL_FLAG_PM_RUNTIME is always true which
is incorrect. The mask operation should be using the bit-wise &
operator. Fix this.

Fixes: bca84a7b93fd ("PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ad50018b8047..ac2a197c1234 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1836,7 +1836,7 @@ static bool device_prepare_smart_suspend(struct device *dev)
 	idx = device_links_read_lock();
 
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
-		if (!(link->flags | DL_FLAG_PM_RUNTIME))
+		if (!(link->flags & DL_FLAG_PM_RUNTIME))
 			continue;
 
 		if (!dev_pm_smart_suspend(link->supplier) &&
-- 
2.49.0


