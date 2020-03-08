Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA617D105
	for <lists+linux-pm@lfdr.de>; Sun,  8 Mar 2020 04:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgCHDXA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Mar 2020 22:23:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCHDW7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Mar 2020 22:22:59 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DC92070A;
        Sun,  8 Mar 2020 03:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583637779;
        bh=udtvriTR0q24CtSe13/uuLQjPwV5O+ibypb6042FoWI=;
        h=From:To:Subject:Date:From;
        b=IVaSyaur//mvEy70vJdFxJkHv6odnzYpppA8/9Ef383nYmYNG9aRkqCxD8pNhiyA/
         eK/C4Vcf3tO0ABRoMSlspdYYjYnZLJqwXdG8Pz+BN5D508PHj5CZjA+R5JWdIPBZcU
         rAHdNI9qtwCXo6ph9jVxdWevAeoEpW5DZDTpQhHE=
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org
Subject: [PATCH] docs: power: fix docs for ioctls that return loff_t via pointer
Date:   Sat,  7 Mar 2020 19:22:16 -0800
Message-Id: <20200308032216.998068-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Correctly document how the SNAPSHOT_GET_IMAGE_SIZE and
SNAPSHOT_AVAIL_SWAP_SIZE ioctls return their result.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/power/userland-swsusp.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index a0fa51bb1a4d..1cf62d80a9ca 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -69,11 +69,13 @@ SNAPSHOT_PREF_IMAGE_SIZE
 
 SNAPSHOT_GET_IMAGE_SIZE
 	return the actual size of the hibernation image
+	(the last argument should be a pointer to a loff_t variable that
+	will contain the result if the call is successful)
 
 SNAPSHOT_AVAIL_SWAP_SIZE
-	return the amount of available swap in bytes (the
-	last argument should be a pointer to an unsigned int variable that will
-	contain the result if the call is successful).
+	return the amount of available swap in bytes
+	(the last argument should be a pointer to a loff_t variable that
+	will contain the result if the call is successful)
 
 SNAPSHOT_ALLOC_SWAP_PAGE
 	allocate a swap page from the resume partition
-- 
2.25.1

