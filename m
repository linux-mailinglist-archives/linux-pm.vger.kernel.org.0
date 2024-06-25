Return-Path: <linux-pm+bounces-9979-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1953F91740B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2024 00:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497EB1C20D69
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 22:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D81487EF;
	Tue, 25 Jun 2024 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGiNOjzS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68E8F48;
	Tue, 25 Jun 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719352883; cv=none; b=Pxerd++IrZYiDdV+DCjWjV0iTukVs06YHqrddaDCouKD1/PkxtIqetdVjoo/Al1p/y0fccT/GVVnxKxSJlgXWXBFMzCC/3cvGr6JnQi/r0kv0uNJgkYyuXxy7Y9CVs89BT4e0KYnGCvz7nFA7EmSe24XjDffIo6HKh+YZpl/aUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719352883; c=relaxed/simple;
	bh=iB8suN7K68nTSbpwQgUXTiEvdDxJdcdALkx1fqEMllU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhMZr/CBSF1EcTxxngyd+L3r3vnb0TndtuGQIGDYy3c31dEpVME6kLvbYEQnLwaBVwJi3GUskL4jqKjVVg8hJmsZHybgSqx3KC6DOllXYYT/uNKA2mHUKJn+ldgnKMUSNNBPw4jj6fTLo6Gr9NfeUSfYm9IWzMVXw4Ac4yaY9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGiNOjzS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3645e9839b3so4660239f8f.3;
        Tue, 25 Jun 2024 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719352880; x=1719957680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDXz1LUXU6ZlWHC70FR62Vj76MX7HfzlwWXqLyqg1s=;
        b=JGiNOjzSoDJvtQp+S3QKLDZTfULPuxN9P+pL2Nxnop6UBozISGSp/i1TYHWCUDVHic
         58UWMAiF9wDbVvYAAykWKdo92yCXRLmXpbsFJoSDvYY/rGnn4L3PF30rAeRCteWwaiVE
         ZjBXnVDmlHzYqvgoWBXHho426O8O5OjPNRfSj2TSbg1hAerEgfolvR0liq9oQbQRCvAM
         m31+aikEo+UqOYMwJa5wIz8qXxwewcr2HaSDehKHgBmXYhTNj3LCAgIAuyje0M2GzWbb
         YSq5lBMuvPFecysm5VkzgNMQ5IY0+l4sgKuaQ9uiGpG4ilWWP92G4PNfgdHfivMINKOp
         C2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719352880; x=1719957680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHDXz1LUXU6ZlWHC70FR62Vj76MX7HfzlwWXqLyqg1s=;
        b=AAlIEpQFj6VfcpmgLMZfg/tfHephFsRiYwXedGZ73tKkGf+mwupTRQ9JvBJiCxajgJ
         Ck16RuzrZN5YxDqhx5laAgz/mNLSrN+eFb8ZvoOWpZxUyOY6uPco8D9kCt4HRvd2CiZ2
         BfFeCi9SLUCy3935MLce0iJNsaL0+wgzuOlU1j/A8HhPLDDhUqEdxw8miLUeBtHjr3B1
         frFItudsdQVVb+cXqk1To6BMNbVIW+R3Fd6N+9DklNzXXeiWY6EWaV6xHC4fIDyLVmPX
         clau2mMuAWGPhDDyUUVD5bk3ZeJjt+xhNUd2n3afRjp+x12gALvbxnT9nFfaZuZLU1OO
         PF3A==
X-Forwarded-Encrypted: i=1; AJvYcCVBU/Lvj0hM30ZiMU4NpYVh1KErSF9MkRcLdYLyBpIDzBToGWld8yxw+sehvJvoCjO/VatSi77PG13rN3bYS3lpBedzssXSnrYsYxcNcQtAir3ZmZfjb0Q0H8ZFBTq+7k6iRMw3hkU=
X-Gm-Message-State: AOJu0Yy+iGhz+zOEi224vbbVBq6mpVP6jwI509DZYJ7zQzZ8jvI8EVkA
	gEe7dmE2TPATW4weJjaZI2o41Wa4ghjcPhghIcoyD7lYU2O/O10D
X-Google-Smtp-Source: AGHT+IHr6o4+7kZYcRqbVPgGro0ftP5uukV5qZS6qgoWQUcpugSg7FOw2CSarFn4/rTei1JNNf3zeg==
X-Received: by 2002:a5d:694c:0:b0:366:f323:f59b with SMTP id ffacd0b85a97d-366f323f70fmr3993667f8f.1.1719352879642;
        Tue, 25 Jun 2024 15:01:19 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c823c28asm2335045e9.5.2024.06.25.15.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 15:01:19 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: sti: add missing MODULE_DEVICE_TABLE entry for stih418
Date: Wed, 26 Jun 2024 00:00:56 +0200
Message-ID: <20240625220056.111913-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'st,stih418' is missing in the compatible list.
Add it in order to use the driver with stih418 platform.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 drivers/cpufreq/sti-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 9c542e723a15..1ffa23dd8907 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -293,6 +293,7 @@ module_init(sti_cpufreq_init);
 static const struct of_device_id __maybe_unused sti_cpufreq_of_match[] = {
 	{ .compatible = "st,stih407" },
 	{ .compatible = "st,stih410" },
+	{ .compatible = "st,stih418" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
-- 
2.45.2


