Return-Path: <linux-pm+bounces-42650-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZUFsC8kGntcgEAu9opvQ
	(envelope-from <linux-pm+bounces-42650-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:19:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD0413CCCE
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003CF30166CF
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 18:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4A42DF6F8;
	Sat, 14 Feb 2026 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8BJun/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1529827E
	for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093179; cv=none; b=KDyQTryLOhmx5wAYH6olqplECIYEn7Ip/E9pGmCPhCs3LWEu7YAGX2lCrZNqcMrjYYbGKOZbE4kNMRuiYrz2yRDI+HcXTP+gXHgG0pQuPpkmj4P7NrRAZIl9V43UXjrhvVGqw+1WBmQdoBMG0NPIT0xcRL9Cthdwq1HVzG8EYdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093179; c=relaxed/simple;
	bh=Z5DKtGR8+CrDHXa8SPC7JtEYn8mGrUmgCA/wZCeWqoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtAo0IzJVQE8lFInP7BiHZOToIMCg5P/oS1yYgMeNFNqALhbYNl8rPks+PzIlwxNCuWDWRulJNxxN+homFdUzBJeFKaASLXeMvbT54JbzxGkCsxhWc8zOMU4Hd6kb0Lwevbp3ZOZL+qnYqLrZNdHv4Y1bAgkvAcMwCbE0spN3qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8BJun/M; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a91215c158so11081855ad.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Feb 2026 10:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771093178; x=1771697978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZthU/dBSxhU1jw5Zz5Kc0iDhp0uS8p8MD7uxvdSwEY4=;
        b=X8BJun/MdqJC8/Qmg2IiogO/YEsr7EMtbsLDvPuJHuGvLXsMtrLaQAK8CBpBz+RMdG
         oppVlPTTzEn36m+e7jFJednO6hNJFeMkl9M93CvZo32NNDuiZWgyiPNjRADBXehHs1VU
         7exT1N3PkXaxqZXTvt53H4QedYh93Zonx7dw7p50z5y2Dh8dHUWbrozWKsiQ2RHM0OLf
         jVxKbF2GFnFYiR/sHdpFeb/eALIli1co2OISspTiQ/WhcU4h3LWA4W3/t9okVRFPxDtJ
         RX//kFu1RQ+AOnXD8wGzgDqxKZRj6pO4R/oERIzdhmnBUIvhlvy/XuDAiytINAkfFWEV
         jFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093178; x=1771697978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZthU/dBSxhU1jw5Zz5Kc0iDhp0uS8p8MD7uxvdSwEY4=;
        b=TVuh0DgrVVcHKzFzNeUkBcSRf5unjUJwya2Wp8mFzWRhxB6aVcuQr3RNBXz9V9MuEp
         IPchnpjwiwQqj7GhHj7FuQ6TjZXKUhwgbKcCHJtHgJi+puEVrKJ7HhKi2jI9jVkjhLEm
         JZigYy3ekDgFRrM4a0AQO1n/y1uVSqH91sPqZve/72lOocB2LTRYUiM8SnJIRiIL92vO
         KJePzhp4QntQxac6GF0rVDFsyv/GhcHwz81M9oR/+3Q1MHyOjsRhoMz51d2E23anB/6a
         bS81LoDVAxu4ud6bl6DsR3zewyjL10gJdiYMt8DLKEv0rNGMnxU3PCMtcv0CY6N9nD8J
         p6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBHJjtFxZm+m7Etw6uLETUzoo/A+Uq8b3OblwTLaYmjv3OqAy8CAqpOBJCTU+xN8lYxri4Hjdhhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5rtm5cRkC6yRN3lpOATvm+gCxFpBX0AE9lvgzFtprwK4uNRyh
	qnQmX27d/ipql7Wyp5OHXR6zHM/jO5mKVxiL2cNEhmCSxebVPNEB+uMx
X-Gm-Gg: AZuq6aIqnkPXqYeh5OBNXIiIJ+Y6ugV9w+h6zWb/y/793OqUP9rntRcbicgzufT3Q1p
	5MjBVL7TSJmH8KjkXG6ZWib3lNCHRGS8ofszk0ypwFUCKHyfh1+DUi4et6Cn3TTT8zgfRGcigCh
	I57ZNzIAsbRKufu0BPuREuhwKd0GDSVj3hKX+8IHoyqtvzMyPQwwy3KOpB4CZwURLk3nKVkiwrA
	Sw2F7HiAMRMjeHwBHXtojNdFrJsBvJDXVjaEibmiPmKMlOuCo+NJNxBE0xCZ8lBcXfGJS+0jwNk
	QrwPhyk5rjS0ll8zHrygdiyYM3jrJqr+0bLvLxRtY6az4UmEmqS5+jsRoARuw1/K7FatSXk9qmu
	6cF2ijxse7LtvOg+BToZCgauHiIv7swwwsUYddjZljW6xcQkpH0EmQToV8QPq4Bkr6WEsp6XgeG
	/j08dbSHF/5Z7l05jHwAc=
X-Received: by 2002:a17:903:37cc:b0:2a1:e19:ff0 with SMTP id d9443c01a7336-2ab505cf397mr61192685ad.39.1771093177563;
        Sat, 14 Feb 2026 10:19:37 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5e06sm28406615ad.50.2026.02.14.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:19:36 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 0/9] Exynos Thermal code improvement
Date: Sat, 14 Feb 2026 23:48:57 +0530
Message-ID: <20260214181930.238981-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42650-lists,linux-pm=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linaro.org,intel.com,arm.com,samsung.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACD0413CCCE
X-Rspamd-Action: no action

Hi All,

This patch series is a rework of my previous patch series [1],
where the code changes were not adequately justified.

In this new series, I have improved the commit subject
and commit message to better explain the changes.

v8: Refactor SoC-specific configuration to new exynos_tmu_soc_config
    structure which help clean up the callbacks.
    dropped the IRQ clean up patches, with new approach 
    it will be much eaasy for new SoC to be integrated
    and the code will be much better way managed in the future.
v7: Integrated my RFC patch which improves the IRQ framework
    for all the SoC link below.
v6: Add new patch to use devm_clk_get_enabled
    and Fix few typo in subject as suggested by Daniel.
v5: Drop the guard mutex patch
v4: Tried to address Lukasz review comments.

I dont have any Arm64 device the test and verify
Tested on 32 bit Arch Odroid U3 amd XU4 SoC boards.

Please sare the feedback on this.

[7] https://lore.kernel.org/all/20250813131007.343402-1-linux.amoon@gmail.com/
[6] https://lore.kernel.org/all/20250616163831.8138-1-linux.amoon@gmail.com/
[5] https://lore.kernel.org/all/20250430123306.15072-1-linux.amoon@gmail.com/
[4] https://lore.kernel.org/all/20250410063754.5483-2-linux.amoon@gmail.com/
[3] https://lore.kernel.org/all/20250310143450.8276-2-linux.amoon@gmail.com/
[2] https://lore.kernel.org/all/20250216195850.5352-2-linux.amoon@gmail.com/
[1] https://lore.kernel.org/all/20220515064126.1424-1-linux.amoon@gmail.com/
[0] https://lore.kernel.org/lkml/CANAwSgS=08fVsqn95WHzSF71WTTyD2-=K2C6-BEz0tY0t6A1-g@mail.gmail.com/T/#m77e57120d230d57f34c29e1422d7fc5f5587ac30

Thanks
-Anand

Anand Moon (9):
  thermal/drivers/exynos: Refactor clk_sec initialization inside
    SOC-specific case
  thermal/drivers/exynos: Use devm_clk_get_enabled() helpers
  thermal/drivers/exynos: Remove redundant IS_ERR() checks for clk_sec
    clock
  thermal/drivers/exynos: Fixed the efuse min max value for exynos5422
  thermal/drivers/exynos: Remove unused base_second mapping and
    references
  thermal/drivers/exynos: Refactor SoC-specific configuration to new
    exynos_tmu_soc_config structure
  thermal/drivers/exynos: Relocate exynos_sensor_ops for forward
    declatition
  thermal/drivers/exynos: Add missing drvdata assignment in Exynos TMU
    probe
  thermal/drivers/exynos: Fix some coding style issue

 drivers/thermal/samsung/exynos_tmu.c | 501 +++++++++++++--------------
 1 file changed, 249 insertions(+), 252 deletions(-)


base-commit: 770aaedb461a055f79b971d538678942b6607894
-- 
2.50.1


