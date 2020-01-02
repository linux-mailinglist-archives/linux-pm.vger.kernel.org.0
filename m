Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59D712EABC
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2020 21:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgABUBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 15:01:11 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50123 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbgABUBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 15:01:11 -0500
Received: by mail-pg1-f201.google.com with SMTP id u14so23686903pgq.16
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kVgpbfrdFyyzSYGGFbgXSziUKzTWcn4XrnhMtwS4vPA=;
        b=UdXvDjVjDE18h3ONKld18ZfOZW7pR3vFqqyTPrQKJToK5J6AEggZmqaRXy8sZ2CFA9
         Q8hB54QeLPLclYtzAaai1ZfJ1InNNuRcXNSzEq94NIQk4I1eV7Yfb4ksENAjx5uiOAm/
         lgxAzsq/u++mCnvzKcIrfqNnLhlKPlw2vR3m+DRLq2Y+aVoGusJZIHDSMKLPlmMjQuop
         CmhDdAZvqSd11vo2jUTfvheqNUr067u9fXcPd2Hz9FUT1z2He6rGmBy0Cvyrf0+l9DIU
         Jjv1ROxvJPq5vCPyj8KgwfoUAI/7nuxEo81qcSkj37JlWKgFDPo5p1/RLfSIQQOtfbJ4
         x7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kVgpbfrdFyyzSYGGFbgXSziUKzTWcn4XrnhMtwS4vPA=;
        b=jkamYKbzeR8vR1x+1edIwEX/OC3Qj2lRB6uq8GzlpDsdWK6mMf4iTRc/zNMVhVrTB1
         wD+WEql7m/wXEKzEhc162tnN/SnjwOlfzzFhHKtuyofvF1EYyP8ygNlPWd3NK4JxVhFt
         myngnSwxFJ6FuoQhfZH6zwbeTQCD87TkpXfRR/ryMLSmIfA9bYk/7Ed0JYXX5yDrqOCf
         b8Y81DKqGj2pEugXlkxmoSTcJvSOr2yO8uyfLeAyjOFRdMrrwVGsEhX50drr9IG6Ev+A
         /CWkaEyEqRkb8SKFSCwB6bJazepkq6tSK4VqOHFxZ0qjkmv9v3rPQ8BEhbBIc71S3QLT
         qE3Q==
X-Gm-Message-State: APjAAAVWag6DJg2v27CSXdap7J7Yzv7WVOuieB24R7itWsjzlcImzgiZ
        ETdLFInG3lt5n/k+LtvspGnH3pzfDQ6HCh+NbO3/br6qOtjp2fnaae+0vqRUExg/Mzb0VHXNk1+
        d1caj0AEmJ4xaJlStb31mLEFttnX8b6QLUQkOiA0pbw0rPh/VpNJA/1pgEo/WFa2sKQT2dC9y
X-Google-Smtp-Source: APXvYqyqK46UMKubGB6NN9jCbFyC4Y753avcxlOHWCVW9wiWyZZLzBYXk1SWlKSxxIqhOwpNyG78HGuDVgRHnLk=
X-Received: by 2002:a63:1f0c:: with SMTP id f12mr94044751pgf.247.1577995270594;
 Thu, 02 Jan 2020 12:01:10 -0800 (PST)
Date:   Thu,  2 Jan 2020 12:00:51 -0800
In-Reply-To: <20200102200052.51182-1-semenzato@google.com>
Message-Id: <20200102200052.51182-2-semenzato@google.com>
Mime-Version: 1.0
References: <20200102200052.51182-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 1/2] Documentation: clarify limitations of hibernation
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Entering hibernation (suspend-to-disk) will fail if the kernel
cannot allocate enough memory to create a snapshot of all pages
in use; i.e., if memory in use is over 1/2 of total RAM.  This
patch makes this limitation clearer in the documentation.  Without
it, users may assume that hibernation can replace suspend-to-RAM
when in fact its functionality is more limited.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 Documentation/admin-guide/pm/sleep-states.rst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/sleep-states.rst b/Documentation/admin-guide/pm/sleep-states.rst
index cd3a28cb81f4..a2d5632b7856 100644
--- a/Documentation/admin-guide/pm/sleep-states.rst
+++ b/Documentation/admin-guide/pm/sleep-states.rst
@@ -112,7 +112,9 @@ Hibernation
 This state (also referred to as Suspend-to-Disk or STD) offers the greatest
 energy savings and can be used even in the absence of low-level platform support
 for system suspend.  However, it requires some low-level code for resuming the
-system to be present for the underlying CPU architecture.
+system to be present for the underlying CPU architecture.  Additionally, the
+current implementation can enter the hibernation state only when memory
+usage is sufficiently low (see "Limitations" below).
 
 Hibernation is significantly different from any of the system suspend variants.
 It takes three system state changes to put it into hibernation and two system
@@ -149,6 +151,14 @@ Hibernation is supported if the :c:macro:`CONFIG_HIBERNATION` kernel
 configuration option is set.  However, this option can only be set if support
 for the given CPU architecture includes the low-level code for system resume.
 
+Limitations of Hibernation
+==========================
+
+When entering hibernation, the kernel tries to allocate a chunk of memory large
+enough to contain a copy of all pages in use, to use it for the system
+snapshot.  If the allocation fails, the system cannot hibernate and the
+operation fails with ENOMEM.  This will happen, for instance, when the total
+amount of anonymous pages (process data) exceeds 1/2 of total RAM.
 
 Basic ``sysfs`` Interfaces for System Suspend and Hibernation
 =============================================================
-- 
2.24.1.735.g03f4e72817-goog

