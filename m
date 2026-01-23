Return-Path: <linux-pm+bounces-41339-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOcuHG7LcmlgpgAAu9opvQ
	(envelope-from <linux-pm+bounces-41339-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:14:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D69276EEF5
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 02:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C06300850A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jan 2026 01:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B7836655A;
	Fri, 23 Jan 2026 01:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J3QaCRwG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030D81CAA7D
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769130856; cv=none; b=p5xFtx0AtlOuXD9ntL9eiUzcc81BmLW6tOUDkXoVrCWQB2BdOhAdONL4ITnjiMmicuA4gdAb9PqNdtU6sjeVfFqZVEGV+V/vMtthoRbSp/5NjUfTVLcaGZszWkAudm/6uj7iClUYgxgDGKz5w1Qo1Chz30ZD7weV5xtBUZovA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769130856; c=relaxed/simple;
	bh=aY3lzdYo34rzzl5rEA1NOAbbPbFMvxFb3wjxISqu7SQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qRndlXMGOZA9rHzEZIGu9fiNc4anQQKRMU/1Y0yuePEbfeqqBBSqKmGEPLxCzgtGRsP1UH7eDGWoFfNVLpCMupsY5rZ272MHGuXmIW4LqCtuYEYG6nTeMcEsTuSprDSXA2XkgP9d5NNRPod/pEWzYF6u8ZjM5x8vJ9JCjmIf7eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J3QaCRwG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7b47a5460so10814475ad.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jan 2026 17:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769130847; x=1769735647; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WRGD2YWjrtmwGYVwivTN08CsAVPXSr88y6f4NIlNfN8=;
        b=J3QaCRwGdyavKFsHN5awhCZf+u1HtFoeQvffyHjMsLC501Rdy/w3ttC4v3J83ekTgb
         ODqn9SsS5WImJ1hC2CKwxpEAPJ7fuMFWvvd1JkTGFtvGAFP7MAKuIgnbQF4X+3CYBasI
         MRs13SPzl88zMAoZ6L+SdYNorSU6wga6E5JiY6ZfYuCiE9t6Dl1C2fxHIBl7fCOQVPk1
         jljLjWNJLrHKrbFU6rZ5Q9kPFDVkLdpyAC8s+UNVvOIX4BJToQ0JL+mFhEQyZRjQzioP
         3e+Jphy4nHgAdIjoPi/uok63WGgX9/RPU04cRmphDbX+EaljB/MkUuMZitZEcRQevE3L
         xj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769130847; x=1769735647;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRGD2YWjrtmwGYVwivTN08CsAVPXSr88y6f4NIlNfN8=;
        b=uBatVG2B1yj9hWUdpPzH04fhmDiwj8jw+zxMBp7xVsLNR+yijlTHD/s8NQ8BOFu2L7
         Ch8r/fd8hBKRPJnE5PPtR3TIKl8ftfocVCXSeeNpf8RPLyorOtqd5nZuNyyEI8vQbiDe
         u8I354IdLOkOharS1uQaVj46KWglM+I39ntWPCCsixzZ0i+1Aarb6sSG1AVaA12jkMdb
         wEx3rVH64pKMrtGxHukwzB8TiAz0e/wuJInlsAUwqM1gEMv0W1T/3gebcE/i0Hpf8wA0
         kmDdool/sfN9g6KOPHPegMOLdi06P6uRYyPRuWXnZjLvN9Vqp+iMEaQ9K3Po8uMNi5Nq
         ZiuA==
X-Forwarded-Encrypted: i=1; AJvYcCW4hwxC420rtqm+WQH4GyDK6Y84esx5xFJvlsVDuDy1xGMEvDT8RnudjTi+Mg3wOWfkvSx30SWpOw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8dWpNh+dDm6pNEQHGSjh6v4gINFh8TfYj2/Rppy/DlDX6qq+
	Bn8Gr0gJIFf9u72UYELa2gzi8Sx9iH6KVatKAPGnY9jv3Isd2xhtP2idN/Yu5hLkTpE=
X-Gm-Gg: AZuq6aK82z59EtPWWpJkXqPM3XcHU+XOy/B3Hf5Y13sM6Wh8unXzJV/pbqEyWS4CSo6
	Og9bMvFgDElMhmwMbJyPev+I555fN+YEiTmrW8HSkfCF/s8P04hzxvRLHJeNn5xBqddvo8fXsgl
	HLkjQY8MOLs7W1+wFkSQltVCU2u6oivCfJA/p/p8+wHIlVx8yRvPj9gLR+jiIrkb8JWOByJkjSd
	auLHBkGM6PVXNgvoRdv7m6K0WWzPHrCT3XHHnWkuIfkJfTahNPd4c+0Pmye/VlaIhpxg2xY9pzE
	K71OPKNBCt8senVtd3IJ+mY3PQ8CjT1lK33A9bAiw1jRg8DPJZy/kMkjolQwr34vPhG2ljyt5ua
	chk3ObaYbOk52pZjRcem1eLazNRmteBtL9AHiklHz8ctSIcDFWVOp3+j+1WqC9yqtaIfYNfnTNj
	k1mLWjLShY
X-Received: by 2002:a17:902:f54b:b0:2a0:9238:881d with SMTP id d9443c01a7336-2a7d2f7cca4mr48720845ad.15.1769130847498;
        Thu, 22 Jan 2026 17:14:07 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fda160sm3960495ad.88.2026.01.22.17.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 17:14:06 -0800 (PST)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Subject: [PATCH RFC v5 0/2] pmdomain: core: add support for domain
 hierarchies in DT
Date: Thu, 22 Jan 2026 17:13:59 -0800
Message-Id: <20260122-pmdomain-hierarchy-onecell-v5-0-76855ec856bd@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFfLcmkC/43RTWrDMBAF4KsYrTtBkvUXrwqFHqDbksVEHtcC2
 3Jl19SE3L3CLWkpIWQ5GvgemndiE6VAE6uKE0u0hCnEIQ/6oWC+xeGNINR5ZpJLzbV0MPZ17DE
 M0AZKmHy7QhzIU9cBKtNgrWzttGYZGBM14XPDX9nL8xM75Mc2THNM6xa4iG11j70IEOC0sI5bz
 r1xj0dcu3BMtPOx3+RF3q9J4GCd00hKk977K1r5qxlR3tTKrGlvLTfWNJ7sFU1dNCHE/qamstZ
 IjaLWXMrm/0/P35dN9P6R25p/znvEiSDv+zBXxWJ2OSN5wf7WWBWX+DmOwUM39hAb6HGE7CTMv
 cBiQDhAI5SySpZY+yrf9XA+fwHl5LjwKgIAAA==
X-Change-ID: 20250528-pmdomain-hierarchy-onecell-a46fad47d855
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=aY3lzdYo34rzzl5rEA1NOAbbPbFMvxFb3wjxISqu7SQ=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBpcstejbN/+il4BUXiOOZpRcNwNGsz74GvjwhTB
 7ou/Vz0eMaJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaXLLXgAKCRBZNxia0/vG
 ZWeHEACe7CpdiIWB2PxK/uKxOKEiOMTBcVQNvq4lj1vZw4q9o7qyG5DQL5hUSCPWUWtvyoU+2EP
 t5xX53KzA2crRXbSzkhfOBRv/fJ2BN8eHrjBbca9OaSIpbLDKVXbjViDn2RpuOHwM3KTxFHV4w2
 5Dp6BngEnIPrz3IARPdH5R2tB04xMIUgevYw/83E6WkixELZGsNaof7uQQT6vE2nxHFlkOGRNrh
 29QDnZ/21z1p9uqDGjBAKvY17Pc2IckmEEWVWf3++3PzC2On+IxlAV9bAuKqjNbjqaELAFmtctI
 Tj1MoCTM3RywCAia85SjJPOCyGRw5NE2C1c3yPl+Vpnf4ZMeti0GZZ4MwHp3CO2IGFLuiiaUfvS
 SbVhmXjao4xXBL8xJHUhbKC5GSSYGjb49WQrbYP+RZCaZaqPXPy3afgS28rRqafd2hljFW5ilZ8
 jJLnntwZVYpqdskBDlQaor0Yz7mpBMIXuMzsOvK2WqRIIDqLTBMZBkE1VUjFOo1FnPb9LMma4ik
 42TKoQTflbbagSeoofQ9ic6gi1drt+ArEOyu3f6v4d7i3FsHzgwF9obnxVtLNrQseQql5nKh3DC
 2v39nHn7ooOwGGO4QM1lA9W0JS4xIEm5p0LUkpZdSUC1o1eFY3L7G2RlZ0mUgFyv9JpjNf/6NuC
 in79ZCaFdxuAF1g==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-41339-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D69276EEF5
X-Rspamd-Action: no action

Currently, PM domains can only support hierarchy for simple
providers (e.g. ones with #power-domain-cells = 0).

Add more generic support by creating an of_genpd helper which can
parse a nexus node map, and create domain hierarchy.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
Changes in v5:
- update subdomain language to parent/child
- add remove function to remove all children
- if any children in the map fail to add, remove them all
- Link to v4: https://patch.msgid.link/20251119-pmdomain-hierarchy-onecell-v4-0-f25a1d5022f8@baylibre.com

Changes in v4:
- use new OF iterator for parsing map. See:
  https://lore.kernel.org/r/20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com
- instead of mapping on probe, create of_genpd helper to be called by providers
- Link to v3: https://lore.kernel.org/r/20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com

Changes in v3:
- use of_parse_phandle_with_args_map() instead of custom parsing
- probe when device is attatched to PM domain
- Link to v2: https://lore.kernel.org/r/20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com

Changes in v2:
- Use nexus map instead of creating new property as suggested by Rob H.
- Link to v1: https://lore.kernel.org/r/20250528-pmdomain-hierarchy-onecell-v1-1-851780700c68@baylibre.com

---
Kevin Hilman (TI) (2):
      pmdomain: core: support domain hierarchy via power-domain-map
      pmdomain: arm_scmi: add support for domain hierarchies

 drivers/pmdomain/arm/scmi_pm_domain.c |   5 +++++
 drivers/pmdomain/core.c               | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h             |  16 ++++++++++++++++
 3 files changed, 181 insertions(+)
---
base-commit: 3e7f562e20ee87a25e104ef4fce557d39d62fa85
change-id: 20250528-pmdomain-hierarchy-onecell-a46fad47d855
prerequisite-change-id: 20251119-topic-lpm-of-map-iterator-v6-18-a61447423adc:v2
prerequisite-patch-id: e5697df059c17cf967fa6e4b1edb70874fee4ad3

Best regards,
--  
Kevin Hilman (TI) <khilman@baylibre.com>


