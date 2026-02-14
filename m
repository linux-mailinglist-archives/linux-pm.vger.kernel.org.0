Return-Path: <linux-pm+bounces-42623-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAYKIBvLj2nMTgEAu9opvQ
	(envelope-from <linux-pm+bounces-42623-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 02:08:43 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB18213A881
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 02:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B58BC3029648
	for <lists+linux-pm@lfdr.de>; Sat, 14 Feb 2026 01:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381F22E3E9;
	Sat, 14 Feb 2026 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhcAX9LX"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200421E5B63;
	Sat, 14 Feb 2026 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771031218; cv=none; b=UUkMkQzN2VsWsOLbzMZvvFvxOu5K+bljg+Mq6wK8fM82QFzSsxSHBQ6bKMji9SWhhu1DoaAuqX81RWNC3utZnm38p0qsziQFkoj+btluOqAlRWVKxa6F3pzRNCkCNMExELFi2WTHuiRduh4gj3Ci1awWdX4fk8o68vFosigrjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771031218; c=relaxed/simple;
	bh=aLnq3Vhro09RFihhmybNksuVx+/a8US1ZR2sadPBDvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeg5jGYEVS3eIFcrqujO8dz9E3iu1JeqcYzBB8ttTuLzAnxOv2ZW8eaUfE2+1GVZz0aEuQtaW+uDT/uq3L63NXV4Np71Otmx5MWjtPN6oK+Ok2KQ2DmYTv/gyLg9dGFBxfgner+cXQC+4OSkBnAbGhtaXfQiVP6arcpK6HfmPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhcAX9LX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4383AC116C6;
	Sat, 14 Feb 2026 01:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771031218;
	bh=aLnq3Vhro09RFihhmybNksuVx+/a8US1ZR2sadPBDvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhcAX9LXEKx0cIfuY0DUr9QIep8lApaV7mMBmI0sN0EQPrK1g0XXseDpR7sh94bxP
	 Lm+xz2rasEW5SGOw0ZVa+3pmLFR8Zx7dlsGHW2m2H04m96MaqrWAGNci6wFVGYEAiR
	 ZKK2CScfn8EKhMX+jYq9ToWSwCk6DUU08sE1W5STHQ5m3BgJ7pd0On+2kp53csDCNL
	 O4HocxPzayW5m4Er+zJA2ZGo4AKsYdsRJsN9fCBbVXAfbZIP4/SaZ1DjY6WLEqUngp
	 kbYGYiuL9SwL1+1ki5aJa0VNm+nMwckGpC8b2GtkU8kxZOdGnyBlQRXNI8rAn10l+o
	 rGImIs4M0Zalg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	brgl@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] power: sequencing: fix missing state_lock in pwrseq_power_on() error path
Date: Fri, 13 Feb 2026 19:59:48 -0500
Message-ID: <20260214010245.3671907-108-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010245.3671907-1-sashal@kernel.org>
References: <20260214010245.3671907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42623-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:email,northwestern.edu:email]
X-Rspamd-Queue-Id: AB18213A881
X-Rspamd-Action: no action

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

[ Upstream commit e1dccb485c2876ac1318f36ccc0155416c633a48 ]

pwrseq_power_on() calls pwrseq_unit_disable() when the
post_enable callback fails. However, this call is outside the
scoped_guard(mutex, &pwrseq->state_lock) block that ends.

pwrseq_unit_disable() has lockdep_assert_held(&pwrseq->state_lock),
which will fail when called from this error path.

Add the scoped_guard block to cover the post_enable callback and its
error handling to ensure the lock is held when pwrseq_unit_disable() is
called.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Link: https://patch.msgid.link/20260130182651.1576579-1-n7l8m4@u.northwestern.edu
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The power sequencing core was introduced in v6.11. So this fix is
relevant for stable trees v6.11.y and later (6.12.y, 6.13.y, etc.).

### 8. SELF-CONTAINEDNESS

This is a completely self-contained fix. It doesn't depend on any other
patches. It simply wraps two existing lines of code with the appropriate
lock scope.

### VERDICT

**Meets stable criteria:**
- **Obviously correct**: Yes — the lock is required (enforced by
  `lockdep_assert_held`), and it was missing.
- **Fixes a real bug**: Yes — lockdep assertion failure and potential
  race condition.
- **Small and contained**: Yes — 6 lines changed in 1 file.
- **No new features**: Correct — purely a locking fix.
- **Low regression risk**: Adding a lock that was already required by
  the callee.

The fix is small, surgical, obviously correct, and fixes a real locking
bug that would trigger lockdep warnings and could lead to race
conditions. It meets all stable kernel criteria.

**YES**

 drivers/power/sequencing/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 190564e559885..1fcf0af7cc0bb 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -914,8 +914,10 @@ int pwrseq_power_on(struct pwrseq_desc *desc)
 	if (target->post_enable) {
 		ret = target->post_enable(pwrseq);
 		if (ret) {
-			pwrseq_unit_disable(pwrseq, unit);
-			desc->powered_on = false;
+			scoped_guard(mutex, &pwrseq->state_lock) {
+				pwrseq_unit_disable(pwrseq, unit);
+				desc->powered_on = false;
+			}
 		}
 	}
 
-- 
2.51.0


