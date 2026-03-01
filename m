Return-Path: <linux-pm+bounces-43369-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK8SAvuUo2l7HQUAu9opvQ
	(envelope-from <linux-pm+bounces-43369-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 02:23:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E21CA5CC
	for <lists+linux-pm@lfdr.de>; Sun, 01 Mar 2026 02:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC8F9300E24F
	for <lists+linux-pm@lfdr.de>; Sun,  1 Mar 2026 01:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B7D2727EB;
	Sun,  1 Mar 2026 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPdOMzwX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9A13B7AE
	for <linux-pm@vger.kernel.org>; Sun,  1 Mar 2026 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328174; cv=none; b=A+Xgdbtexfu6AgUEMxrUwKTzm4N/dUydnRfSOOlCmZSYu0fY1Sr3gGzSDAlaw3Iay77Y+KycW7FTB0WGXJo14nPGH2V2ZGO9btAjFB/H07eBphPD1l3rbxnQpp7b0WhSIU+4+cardp59VnB7jgyAK97q5CC/udynyj60lDJRznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328174; c=relaxed/simple;
	bh=5VQs+T8f7khh8eOV4deOnguWCwT6pfmhUkB6VESq+Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHmGv5EdJLSVxxIxPMvpVx3TCFpHr2zzIEsOaAiapa2CHCnX0ySIgDBKeLlYLZcDA0M3M+npzZZfgyTYzrm4JQL6UGt8PwVbjKGS8Ru1BghtUj+HRhgOv8ac2HMkdPLc3aph5NRMGXoShujtl6PDRirFfcZcHJ+AzdOgdjc41m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPdOMzwX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cbb2329e7eso358347185a.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Feb 2026 17:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772328172; x=1772932972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeI8Yu4HVZ542Nhlzz+UATCil4zR4DMccKGQpRBKyFs=;
        b=lPdOMzwXrCLDOG7G25CzxvrH/wNPGxFnzZN9+mfm9TLsbbXo5pnGvnWbvTPQn618lL
         vNxHT5ls3rh6bJLY6CISp+EBv+XDDY/L0Hf4Nf8djpbegtjFcp4nUM2uhPxfNgOz0SD2
         7UNzln40Sx7BfrrZPjsLimJVvIS3r/75PF9iKe/9FTYxaognIPObk50JlqAzOC6NVfxI
         ZpQFWe7gFoUKMdb0N4GgcGQC07gXEm8qdPRpHSSH4+VNpY6D0/oxH9e7fx3wJpDYa4HA
         +3NZt8N27mW2FSROpjaCt6nHuiuiifC56SAs2vsMPCOKyLwJicLMjZkbyYSIVZWGZml5
         CX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772328172; x=1772932972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeI8Yu4HVZ542Nhlzz+UATCil4zR4DMccKGQpRBKyFs=;
        b=Nggdj15OcIWn8ODTVQ6nTyZPEoFDwUjV/I2AL5cGHvnzLYyYcTnpb1VAr1GEZkOPaz
         CiJ7J0dvzt2khQ0scvs0P91cbbuDwcIoPZ14IWSuoQpk9wqzs7d+p32jbEikCpKYlDeN
         96E5dpA8OuHWLO67YvXziFLid9R9+ZALlmVHnZw1nYHG8DC8QPG4o7TpUvF4sS9wPFXV
         T3lN+357QSUU4KS9su0fBfYwmrv/1Q8T2ySwIbVcI/y9KV5Ojf/i9EXSfwm6qEjNKJPR
         CG/VnkNt4l0eIfz42xFlkt4x1fOIoU3fsphCB+H78x2x9A56LFId5sm/qaX75PpmfdzB
         3Kzw==
X-Forwarded-Encrypted: i=1; AJvYcCWHc7BhDypYVdO94szKfrpjIvJRth4lI2lwY0j9kT7gt4ZD5dmu5v4JuSK0kdKGy42YYUXqvRXhvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR3VIWnnhl2kbmPuwKIMDXud1aEfSY4Z58ixMgmsPkfiuNFxtp
	enZJnFp8WF1MLtG32NvFdiJPU5oc+tWHDZQKbuG6YEVJLmo2SJD2yYSE
X-Gm-Gg: ATEYQzxnAkfSEkIyPK/C/l9d6xVI7cMChyurLPbCYd6CpVd7CPKhRN0HxBlWH0FVCXt
	MNws9VwTYFoPxgESeVkVBV7t+r3eaG4sdiyUQ9nh5Jn498JsiMmrqlZzKe91T5cCqg7FUWfYBku
	y0ZuakgX85dAoQs9LAEJjWr84YiQd/mVC/R3jeqDK86rnf+Vgn9WFTODqsnDy0HhVmMVmbElUsZ
	823MP6EbmW2kRFR1D/NcZq+5Jfsud2dxDomd6EWuQk9DM1wl2Qjt3wdSLi6PmwtzHiNgpoNRzRp
	WBtIG3vvpnEaUoXan67EABL/oGpdErfXQmXgEcz2LdHaB7gMrN9mBv0vE3r6jG39Wcg4PCFeMDu
	M8iQLb6Vvpz4XnJjid7cIIroEcJEnhZ9kIia990xPidptWcem9pclRboMscZRhPucSfmJtCxRoD
	E93rzalJ6OisfgaxRNMjDIGGsAc8ykEB6ee9RrTv7M1w==
X-Received: by 2002:a05:620a:3711:b0:8b1:728f:952e with SMTP id af79cd13be357-8cbc8dedcdfmr924185985a.31.1772328171609;
        Sat, 28 Feb 2026 17:22:51 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf717301sm814409985a.36.2026.02.28.17.22.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 17:22:51 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: rafael@kernel.org
Cc: jic23@kernel.org,
	paul@crapouillou.net,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH] PM: runtime: add system sleep callbacks to EXPORT_*_RUNTIME_DEV_PM_OPS()
Date: Sat, 28 Feb 2026 20:22:46 -0500
Message-ID: <20260301012246.66404-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,crapouillou.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-43369-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelb2403@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B4E21CA5CC
X-Rspamd-Action: no action

DEFINE_RUNTIME_DEV_PM_OPS() sets pm_runtime_force_suspend() and
pm_runtime_force_resume() as system sleep callbacks via
_DEFINE_DEV_PM_OPS(), but the exported variants
(EXPORT_RUNTIME_DEV_PM_OPS, EXPORT_GPL_RUNTIME_DEV_PM_OPS,
EXPORT_NS_RUNTIME_DEV_PM_OPS, EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS)
only set RUNTIME_PM_OPS() and omit SYSTEM_SLEEP_PM_OPS(). This
means drivers using the export macros do not get system sleep
support, contrary to what the documentation suggests.

Add SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
pm_runtime_force_resume) to all four export variants to match the
behavior of DEFINE_RUNTIME_DEV_PM_OPS().

All current users of these macros are IIO drivers (bme680, bmp280,
kxsd9, mpl115, bmi088-accel) and none implement custom system sleep
callbacks, so this change is safe for all existing callers.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 include/linux/pm_runtime.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 41037c513f06..c6a6a0569b11 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -42,18 +42,26 @@
 
 #define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 	EXPORT_DEV_PM_OPS(name) = { \
+		SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
+				    pm_runtime_force_resume) \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 #define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
 	EXPORT_GPL_DEV_PM_OPS(name) = { \
+		SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
+				    pm_runtime_force_resume) \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 #define EXPORT_NS_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
 	EXPORT_NS_DEV_PM_OPS(name, ns) = { \
+		SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
+				    pm_runtime_force_resume) \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 #define EXPORT_NS_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn, ns) \
 	EXPORT_NS_GPL_DEV_PM_OPS(name, ns) = { \
+		SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, \
+				    pm_runtime_force_resume) \
 		RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 	}
 
-- 
2.44.0


