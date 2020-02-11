Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C652159433
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 17:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgBKQDh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 11:03:37 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:35542 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgBKQDh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 11:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1581437015; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=QIF/b3NfggKNaEL58o6pSYat7ZveBie4he5kxLcTGPo=;
        b=ZGUNhV0gfDvILhJn6bxsImZOYBaZCFmiSm8Ay4DW6RpyKqjHzD/VJwR2GNriuQ6iupPYpF
        sYRhBzULovbnF0J3BAH8D+Mx39h+t6zFqZ2LCulyvj3Pcn04rcNmVSMWjaZaDbFBaeucum
        UrVGIuWktfaQFSDz8YDFZK7y4FxTafo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, od@zcrc.me,
        linux-pm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [RFC PATCH 0/3] Introduce pm_ptr() / pm_sleep_ptr()
Date:   Tue, 11 Feb 2020 13:03:18 -0300
Message-Id: <20200211160321.22124-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I've seen many times things like:

#ifdef CONFIG_PM_SLEEP
static SIMPLE_DEV_PM_OPS(foo_pm_ops, foo_suspend, foo_resume);
#define FOO_PM_OPS (&foo_pm_ops)
#else
#define FOO_PM_OPS NULL
#endif
static struct platform_driver foo_driver = {
		.driver.pm = FOO_PM_OPS,
};

And always wondered why there was no of-match-ptr-like macro to make
things cleaner.

So this RFC adds two macros, pm_ptr() and pm_sleep_ptr(), which resolve
to their argument when CONFIG_PM or CONFIG_PM_SLEEP (respectively) are
enabled, or NULL otherwise.

Patch 3/3 is an example of what it would look like when used in a
driver.

Comments welcome.

Cheers,
-Paul


Paul Cercueil (3):
  PM: introduce pm_ptr() and pm_sleep_ptr()
  PM: Make *_DEV_PM_OPS macros use __maybe_unused
  mmc: jz4740: Use pm_sleep_ptr() macro

 drivers/mmc/host/jz4740_mmc.c | 12 +++---------
 include/linux/pm.h            | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

-- 
2.25.0

