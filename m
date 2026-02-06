Return-Path: <linux-pm+bounces-42196-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLoNFMyzhWmbFQQAu9opvQ
	(envelope-from <linux-pm+bounces-42196-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 10:26:36 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F19FC018
	for <lists+linux-pm@lfdr.de>; Fri, 06 Feb 2026 10:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81E1130226BB
	for <lists+linux-pm@lfdr.de>; Fri,  6 Feb 2026 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF635B64E;
	Fri,  6 Feb 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+W61SwE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B452B355025
	for <linux-pm@vger.kernel.org>; Fri,  6 Feb 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369822; cv=none; b=GspkudXnGG6ltI42j7egiWqvgRA7iKkioNhdj2JTWE4p/HHuNlpdsrUGsWmlD6tKJXQ4OLJOkoTHAJM64/ad9j2B4JYPRo1XmhWPzKPTQ5lU7IzhkGRFtlxPM3OiM7tA58xoGjJJLELxnELbs91x22f+kBgO4FU+rvolyfvyCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369822; c=relaxed/simple;
	bh=oHrIAjiA3w8rr/43sMJV+DvF/OlfA20d1q3N81NAVV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlL7Ym/5Kp1HTy7Cwj3NsPla06YBRKgU2owQ/TDg93K85GdrkQExDk2PoqQkWMcmoIObgwtSOshiTqy+7cxdvAjMZnTU9H8epjsHRXSKDVE2QZek2H1iI7HvcK1BJqLrVX0LYbLyTCH1ZI6hwnZ0DGywOwxWPdBccdB5JaNBuMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+W61SwE; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-29f102b013fso4852755ad.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Feb 2026 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770369822; x=1770974622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yuTzOBlCIALqpyQtHwJ+tH2O4xb49e/uTcQGRnE7ybI=;
        b=l+W61SwEe4A8hXGObDhNqGpYIF75xG36MbZipS38qFTOvRXGOH8HLrWwGXt1Erf033
         EfVTdnkC+qn8rTfVrAgY1P/3nbV2uyeWURKgtsvpQ8k+koab7Gfs1q/GkgZVNo43z24p
         ajwRiAL0HxhQT6+dZ574ycOnRu3IFRp9V/PGgMp9ekJQhLfoYsK2PCE0mc7tM4kIOcMo
         eHNhynCoXzYRe4SGxe0n0/5Km84qtCvdQLR3WT4GE/k6Tocsi2uKFU+FZ3lpQOz4AoR8
         mPU359KOc4wu0T1vAtXX1mEp9X1YkGD3kkjc0KZgrKK1kCRcn4ujxTE7w2kcK7POaVkU
         XpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770369822; x=1770974622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuTzOBlCIALqpyQtHwJ+tH2O4xb49e/uTcQGRnE7ybI=;
        b=L8y2izgDEi0cOeS9jhSM+nTzFQr8MyVlA9vLM5sM1IrqBwRQDrfUBz3v4hQh2tTWH7
         g70dKEFG0qf6uQWaHR2IIpFcin7Exsp2PCZzCNMLFxDpuqRbHG1htmEKT5jIeknANal4
         j+vByWForqGjzzsE5cOd5KJifP2xqEkM27dlv2JgZsuRPzIXhUklk+xCPjKTqD075fH2
         RTH8kzNJzSJYisqxXJVCJZthP+vSn/vcvWB4dcooiVZ2IfWBYgBex106+geX+Ker2//z
         5yEmUki72pLuj5e2lY7slTcfN92Nm+uAlfyqZFbxd98LPPKkkZzjSM9gT7KoLrHxfuKU
         0U+g==
X-Gm-Message-State: AOJu0YwTB8S15r7f5w7JJyi0wg9wNcS+CVtLZ59rLKSwtH97GKyPIuEL
	h9a7qDqhOWpEyhO5l72AQKnf8UKoGxun29Pjp69XbvL6p25Xvbt0u9lXOir7Pa4Ylac=
X-Gm-Gg: AZuq6aJrRofMIQg45KCkkjycEdi3MKn9d9mHYdPgXW4XqXKl7Bauq1vlv934hOuAVZO
	vuYJgB5FGdCh7isibIf7LGzq/EEHOpJBF8M9sGKYAbGYmqXQQOFb2cwZatuLphSK6Iv/FUg1tgq
	LsRtNPF/T2kPktOZrfFIO2/QFFM2ScB4T45nkLaC+7PklRD6M4qLoMQ2vadYOEBz2nWUGDYMK8D
	5HRnUGw1H7uvTA8w/B96LaGY1h/PooBdSawnc7i8vN4PGO0E+PfZgpuBKRJZM18vCcksDoEdl0d
	hC4vEH8OZp2G7XJrzkIdVV3lbM8R/9Dam791p9P1RRpvKsPTSeo2hJ1iOLr93ekBK4/8d4CIOv/
	GPf/gyGTBB+tmYwHXtnqwcguCp/Ams01JijiV4ac0zihcpzzDMh7Q8kq927G93yRqUyEeOhTxw/
	CPkMoaaCXWSbaNzNz3ePaDFlFhdz/+al3n0/xZag1vwVYEST2JGokUlIAoeB9XQITV810=
X-Received: by 2002:a17:902:e84c:b0:295:62d:5004 with SMTP id d9443c01a7336-2a9516c4cb8mr25023275ad.26.1770369821942;
        Fri, 06 Feb 2026 01:23:41 -0800 (PST)
Received: from eurus-Lenovo-Legion-Y70002021.. (n119237241079.netvigator.com. [119.237.241.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8578dsm19124415ad.32.2026.02.06.01.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:23:41 -0800 (PST)
From: Wang Jiayue <akaieurus@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	gregkh@linuxfoundation.org,
	dakr@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Jiayue <akaieurus@gmail.com>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH v2] PM: sleep: wakeirq: Update outdated documentation comments
Date: Fri,  6 Feb 2026 17:23:17 +0800
Message-Id: <20260206092317.148885-1-akaieurus@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-42196-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akaieurus@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A3F19FC018
X-Rspamd-Action: no action

The comments claiming that dev_pm_*wake_irq*() helpers must be called
with dev->power.lock held and only from rpm_suspend/resume paths are no
longer correct, since pm_runtime_force_suspend/resume() call them
lockless. Update the comments to reflect it.

Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://lore.kernel.org/all/CAJZ5v0jN9fU9NdWqc-+F5hiSEP4JkR=_qcdGzzHtk1i5tvCDbQ@mail.gmail.com/
Fixes: c46a0d5ae4f9 ("PM: runtime: Extend support for wakeirq for force_suspend|resume")
Signed-off-by: Wang Jiayue <akaieurus@gmail.com>
---
v2:
* Rephrase the comments to also cover the
  pm_runtime_force_suspend/resume() case, as suggested by Rafael J. Wysocki
v1:
* Initial fix just remove outdated comments
---
 drivers/base/power/wakeirq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
index 8aa28c08b289..f5db37c4818e 100644
--- a/drivers/base/power/wakeirq.c
+++ b/drivers/base/power/wakeirq.c
@@ -270,8 +270,10 @@ EXPORT_SYMBOL_GPL(dev_pm_set_dedicated_wake_irq_reverse);
  * otherwise try to disable already disabled wakeirq. The wake-up interrupt
  * starts disabled with IRQ_NOAUTOEN set.
  *
- * Should be only called from rpm_suspend() and rpm_resume() path.
- * Caller must hold &dev->power.lock to change wirq->status
+ * Should be called from rpm_suspend(), rpm_resume(),
+ * pm_runtime_force_suspend() or pm_runtime_force_resume().
+ * Caller must hold &dev->power.lock or disable runtime PM to change
+ * wirq->status.
  */
 void dev_pm_enable_wake_irq_check(struct device *dev,
 				  bool can_change_status)
@@ -303,7 +305,8 @@ void dev_pm_enable_wake_irq_check(struct device *dev,
  * @cond_disable: if set, also check WAKE_IRQ_DEDICATED_REVERSE
  *
  * Disables wake-up interrupt conditionally based on status.
- * Should be only called from rpm_suspend() and rpm_resume() path.
+ * Should be called from rpm_suspend(), rpm_resume(),
+ * pm_runtime_force_suspend() or pm_runtime_force_resume().
  */
 void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
 {
@@ -329,7 +332,7 @@ void dev_pm_disable_wake_irq_check(struct device *dev, bool cond_disable)
  * enable wake IRQ after running ->runtime_suspend() which depends on
  * WAKE_IRQ_DEDICATED_REVERSE.
  *
- * Should be only called from rpm_suspend() path.
+ * Should be called from rpm_suspend() or pm_runtime_force_suspend().
  */
 void dev_pm_enable_wake_irq_complete(struct device *dev)
 {
-- 
2.34.1


