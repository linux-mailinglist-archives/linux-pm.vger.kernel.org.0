Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B082733F08F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 13:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCQMjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 08:39:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCQMjN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 08:39:13 -0400
Date:   Wed, 17 Mar 2021 12:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TkQ0BFqyDpd0Ap+vKcLy0es5qrTFHOzckzPJo3pwpjk=;
        b=VAT9MBjYucK7/r29q5ICh3A1oyJw2IzTh6pJYwG3vgeqXd1qcIxRf0QtiYEWJhFmzj15k2
        i7CQlXwL4XlsWXdgEX48QlpZG27jg/LV5ZtcGbt9/GIkk02hDpXAqWqrO17CC1MHixYBMH
        TzCqA4FWDjnc2aYVBHOQpmhGTWK61ObwZqUJ135M1geAlltECgolBqrkRvHM6VkXWoAff7
        2QAEUxgJyYxznXuzA78fqUcrLAvXGHcijIYG8dypK2v6IB2HyaBSW341zXdaO3Lch+9kt8
        PtxB60L3Oe7WLXuWMNlGjo1E9LlutxxPwyEjWMCJ80s2PiQKCu+2UAvP2dlPlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TkQ0BFqyDpd0Ap+vKcLy0es5qrTFHOzckzPJo3pwpjk=;
        b=BOfWozArX+ZKoYK2tKRfwAPg7RwlFmYndm6YbCIKgKjNd1QMYklpdUyja1TBGxaCEbJt+b
        zhBghqKLoFb2vvDg==
From:   "thermal-bot for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: Fix spelling mistake "disabed" -> "disabled"
Cc:     Colin Ian King <colin.king@canonical.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20210311093054.5338-1-colin.king@canonical.com>
References: <20210311093054.5338-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <161598475172.398.17716096056063973029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     312e3f8aefb5dc9c2f052ba0ee35a2fd6baa5bcd
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//312e3f8aefb5dc9c2f052ba0ee35a2fd6baa5bcd
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 11 Mar 2021 09:30:54 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 11 Mar 2021 12:13:08 +01:00

thermal: Fix spelling mistake "disabed" -> "disabled"

There is a spelling mistake in a comment, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210311093054.5338-1-colin.king@canonical.com
---
 include/uapi/linux/thermal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index c105054..9aa2fed 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -60,7 +60,7 @@ enum thermal_genl_event {
 	THERMAL_GENL_EVENT_UNSPEC,
 	THERMAL_GENL_EVENT_TZ_CREATE,		/* Thermal zone creation */
 	THERMAL_GENL_EVENT_TZ_DELETE,		/* Thermal zone deletion */
-	THERMAL_GENL_EVENT_TZ_DISABLE,		/* Thermal zone disabed */
+	THERMAL_GENL_EVENT_TZ_DISABLE,		/* Thermal zone disabled */
 	THERMAL_GENL_EVENT_TZ_ENABLE,		/* Thermal zone enabled */
 	THERMAL_GENL_EVENT_TZ_TRIP_UP,		/* Trip point crossed the way up */
 	THERMAL_GENL_EVENT_TZ_TRIP_DOWN,	/* Trip point crossed the way down */
