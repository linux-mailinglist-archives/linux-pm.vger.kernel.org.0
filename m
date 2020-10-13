Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73128CD71
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 14:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgJML7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 07:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbgJMLyn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:43 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF04D22409;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=DCvUUE4fRCUtr8UmfHjxl3UfgcUqLeXa8MLjLmb+NdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojBDe8JIYbdv9BS3EHCImEo1CqNhmqveCvHmyyVYEZirXlt7JxnQ041YIGFR/wSDe
         FxZreHfyqQgPD1GC4u7It3CATlci4/hgMFgCPn5flzoxFhnKUiJ1yPGca5nXa2rcJX
         weDcB3P+eKFv1lbQG1vvCEsQ0cdx3e/phQH9FKgc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt6-006CX8-5i; Tue, 13 Oct 2020 13:54:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v6 80/80] PM / devfreq: remove a duplicated kernel-doc markup
Date:   Tue, 13 Oct 2020 13:54:35 +0200
Message-Id: <6ef19d45428ceb44589bc1d44a71c2ef3ff5505d.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The update_devfreq() is also documented at devfreq.c, which
has a more complete note.

So, drop the duplicated markup, in order to avoid this
warning:
	.../Documentation/driver-api/device_link.rst: WARNING: Duplicate C declaration, also defined in 'driver-api/infrastructure'.
	Declaration is 'device_link_state'.

(and to cause a problem with cross-references to it)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/devfreq.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 12782fbb4c25..1fbd3a5e97f9 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -228,12 +228,7 @@ int devfreq_resume_device(struct devfreq *devfreq);
 void devfreq_suspend(void);
 void devfreq_resume(void);
 
-/**
- * update_devfreq() - Reevaluate the device and configure frequency
- * @devfreq:	the devfreq device
- *
- * Note: devfreq->lock must be held
- */
+/* update_devfreq() - Reevaluate the device and configure frequency */
 int update_devfreq(struct devfreq *devfreq);
 
 /* Helper functions for devfreq user device driver with OPP. */
-- 
2.26.2

