Return-Path: <linux-pm+bounces-17582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B69C9504
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 23:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A67C285A82
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EC41B0F16;
	Thu, 14 Nov 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HN+/RPI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C301B1D65
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622179; cv=none; b=kEWaAp08NXcf/W4RsbcLE+L+h51ikXHvftXaaNmtWjEIiRieIzTdKgoYlC0jUPbDmuLdtTwM35NaSpBCRTirDe91Mlh+sckFi3JY6eLMSw7lQ/kgrhBRncg23sYlKtGUvGmJjmrs3zDtAkqc3JVnGoTinR7mVUlaCX1G4Y3zsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622179; c=relaxed/simple;
	bh=jYgI6Lv2TaRKTGXABWBeP3aEG3bkPZXhlUi0HpUIshM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=mHNjXxtGHeiX5YK7BI6nricGnbdCBXThXhhUBGWveWcCJAUji0/VXN9i9f0NH13OraMwtySl/LYZ/Xa6Zd0B8NNE/tkfEe2MJfn5Cp/lO09phjsIe0oCkAR8cR11yZmGBr/BKc+m3COVO2vNrbIUPf30JSlSZQeeFNNojskiAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HN+/RPI5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee484ec18aso16195587b3.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 14:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622177; x=1732226977; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK+OszyPJF9IsNwlHAXzh79EKRYRWDFx/RXocPFNckQ=;
        b=HN+/RPI5j3Ms+AoeGWTa0rVHwY6bHu35YMjC6nH4jYHXT11TSW8HgRkygYIahltTtY
         6FlotNcu0MO6fn7+18gO2We1bs761O+yd6nFy45B3DMlPEzsFo6IqottKYtvJHI7h2gi
         fci6zyubwoKHS1sjwM22ywHGJvgVMaJEDCbaNmb31Sye5VAVAB5aKM3EEohm6VcFcTGz
         TkFpC56qf21Hfip3LvkaS543VK/G30zzjN+BIJbRBP46QK8RO4L5hLiG0mOCzTqCmy1n
         YmDsKlLc1FRUJRya7mkbTCQ6KEcmkQrN//6msGz/qiWwf+nXmCA40V+zdyRlS4C7Zd1z
         BAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622177; x=1732226977;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK+OszyPJF9IsNwlHAXzh79EKRYRWDFx/RXocPFNckQ=;
        b=g9g3ebR7Oq4qjhsBZMqCDhiqzOvDZVdRkNjf9XWSY2VIdKbz/s/iDmqF12fkWfGL6c
         sAHsTyxrmuWP55mgrRRU7tbjdXsmKj1odzVG0ugVHxWrhBaqcUeZecWLWPox2hrWM0z5
         CB1czH3G8F1i4OXtBEWW2FPoFOQiBf9ihch+D1fchXlL6jGV4Lv0IRGdkn31LNtUY+xl
         l/5BGTC3NvNEl9ha1qpA57C6pbYdF6XgMvdtcAaCKmw8SCvnM6fjlEFKuUFYaws+YVxH
         z8Kg6iHGJ9JR4vigGGOD4VL98mbdmLy/PsDfJw5BgoDDob18ORng2LOyMJHwr4tDnR93
         G6CA==
X-Forwarded-Encrypted: i=1; AJvYcCXPBvrYH+GDrtw3bdDvDNu1SjqBveDtTb6dKEkqkHS5teFHpkHly8ncGLoXj7DJeIc3n1JH12gQgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym2hxmV8j2qjKJGa8KakFTAy/fCzPTCs92w5RbMFSwuoT+3hbC
	WjP5gPY4GaaKE3ApSYfXzrkMu85SfddhW/RkLJnMhfOlw87ud4Q6Qb8sLUf39yD3UvPACgfkKJR
	7VkvNsa4Ua6pYeQ==
X-Google-Smtp-Source: AGHT+IH5IPLhIyXGelZjgJIpI/dK6jQIqzw4zXbJcpm2KbdtZor186y0i6MHOA+ceIHOi+9vCMk9NuyHBVYsZQ4=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a81:ad0a:0:b0:6e3:d670:f603 with SMTP id
 00721157ae682-6ee55c2f44fmr218917b3.3.1731622176991; Thu, 14 Nov 2024
 14:09:36 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:16 -0800
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
Message-Id: <20241114220921.2529905-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when waiting
 on parent
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Locking is not needed to do get_device(dev->parent). We either get a NULL
(if the parent was cleared) or the actual parent. Also, when a device is
deleted (device_del()) and removed from the dpm_list, its completion
variable is also complete_all()-ed. So, we don't have to worry about
waiting indefinitely on a deleted parent device.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 86e51b9fefab..9b9b6088e56a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -284,18 +284,9 @@ static bool dpm_wait_for_superior(struct device *dev, bool async)
 	 * counting the parent once more unless the device has been deleted
 	 * already (in which case return right away).
 	 */
-	mutex_lock(&dpm_list_mtx);
-
-	if (!device_pm_initialized(dev)) {
-		mutex_unlock(&dpm_list_mtx);
-		return false;
-	}
-
 	parent = get_device(dev->parent);
-
-	mutex_unlock(&dpm_list_mtx);
-
-	dpm_wait(parent, async);
+	if (device_pm_initialized(dev))
+		dpm_wait(parent, async);
 	put_device(parent);
 
 	dpm_wait_for_suppliers(dev, async);
-- 
2.47.0.338.g60cca15819-goog


