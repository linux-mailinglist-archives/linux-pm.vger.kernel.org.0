Return-Path: <linux-pm+bounces-42084-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMc0BetQg2kalQMAu9opvQ
	(envelope-from <linux-pm+bounces-42084-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 15:00:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11CE6BCE
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 15:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236E0303CA55
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 13:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA7640B6C8;
	Wed,  4 Feb 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs6voFQl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B03ACEF6;
	Wed,  4 Feb 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213303; cv=none; b=j9z3aEXtht39Qjq6TwIPScy6YP0dUN97XedQO7AyxTD6xAoU+S4a5+EGaXWjoApOUbKrP8EtRShsVSYx6pHMvrGBmoIDnLWFwYTuAK2MHhidt6LgTaHdESLxEW0eeKz+hXvDKhUAZdzSsycL8h0TshYArohmqKkhvHEafj7E/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213303; c=relaxed/simple;
	bh=QA34CW9B9ugapqXr/GhZtpNQarlzduKWIjku1M9XNdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFQXZAUhEow4i1TqkGoGWgQ1IQLpz8RWDG9frMdSd41v5KhrxTdLNB9ioKDxpi/nD4iCDgQXg1vpQV9J0bo/IuXpG/JobdLtp/UrU6t9YbD8NA5pPEAwaabpbTbQkxlwxNbTWhmdD9FJGnZcGBe0v9W4OVWulEdVxryexCssZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs6voFQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFE1CC4CEF7;
	Wed,  4 Feb 2026 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770213303;
	bh=QA34CW9B9ugapqXr/GhZtpNQarlzduKWIjku1M9XNdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cs6voFQlZcvQ4iVlH6RQwaxcYDCr60E1Bz8rDe7xZ2814NMfbAvBO+6A3QDj1y8e5
	 H7FsiWqlNgLlwuhyvhr84pchIJ5jkprDv9USNsfBDi79IAbTQXKWQFhyxMYn+hx/YV
	 9b5JpsDfyCafLIHxjRGsrj+nvAkWvIcPM2HjxqTi3e68ze95DitbyC4YVqVnXJfinr
	 f8pO+h8EYcVi7HopfV2QZGKq207unlmpexJaIKFCwoBMzMiZlV9wzpGsd2bqaRI5+z
	 fIah0uYMw8ZIevsByOZHBxu0uPENUlRY5BsX7XQMkcOplzFQnG1lTyQhIY6tkeKZoo
	 XxiOCYhagMZbQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Saravana Kannan <saravanak@google.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Subject:
 Re: [PATCH v1] PM: sleep: core: Clear device async state upfront during
 suspend
Date: Wed, 04 Feb 2026 14:54:54 +0100
Message-ID: <12845851.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAPDyKFrDRRU_WxKFZ-ni9Wc8JboYB3uUHpoOM_ppzghyJ3V1ow@mail.gmail.com>
References:
 <12852589.O9o76ZdvQC@rafael.j.wysocki>
 <CAPDyKFrDRRU_WxKFZ-ni9Wc8JboYB3uUHpoOM_ppzghyJ3V1ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-42084-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,unisoc.com:email,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 7E11CE6BCE
X-Rspamd-Action: no action

On Wednesday, February 4, 2026 2:37:20 PM CET Ulf Hansson wrote:
> On Tue, 3 Feb 2026 at 21:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In all of the system suspend transition phases, async state of all
> > devices needs to be cleared before starting async processing for any of
> > them because the latter may race with power.work_in_progress updates for
> > the device's parent or suppliers and if it touches bit fields from the
> > same group (for example, power.must_resume or power.wakeup_path), bit
> > field corruption is possible.
> >
> > Rearrange the code accordingly.
> >
> > Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
> > Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> > Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Looks good to me!
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

In the meantime though I have decided to commit the patch below instead
because it is simpler and basically no overhead.

Please let me know if you have any concerns regarding it.

---
From 0491f3f9f664e7e0131eb4d2a8b19c49562e5c64 Mon Sep 17 00:00:00 2001
From: Xuewen Yan <xuewen.yan@unisoc.com>
Date: Wed, 4 Feb 2026 13:25:09 +0100
Subject: [PATCH] PM: sleep: core: Avoid bit field races related to work_in_progress

In all of the system suspend transition phases, the async processing of
a device may be carried out in parallel with power.work_in_progress
updates for the device's parent or suppliers and if it touches bit
fields from the same group (for example, power.must_resume or
power.wakeup_path), bit field corruption is possible.

To avoid that, turn work_in_progress in struct dev_pm_info into a proper
bool field and relocate it to save space.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
Cc: All applicable <stable@vger.kernel.org>
[ rjw: Added subject and changelog ]
Link: https://patch.msgid.link/CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 98a899858ece..afcaaa37a812 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -681,10 +681,10 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	bool			work_in_progress;	/* Owned by the PM core */
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-	bool			work_in_progress:1;	/* Owned by the PM core */
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
-- 
2.51.0





