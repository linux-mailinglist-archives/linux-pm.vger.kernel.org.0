Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 109EDA45F7
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfHaTfl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:41 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41386 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:40 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so21051902ioj.8
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=dOYCARJAXbdzDNt2l66LDCjrByZn+oDuMXEZVZLikvM=;
        b=BfANC23qPs1iFJn5TBsUUywcuHhFPriH/5vtQ0nbSWOd8C/XXb1hGsV6xAJJqm8v4d
         uUTQLCz6rBkBiLmPk4E2YQyS76b2c12Awq2Uqk2k+FAAeyVtCkKbitQ4Fb2Ati+mevFk
         RZw3z36zeUn3mtPgtzcUOFz9SYueoPua4fLMH6w0d9+7Gl/65r14vN+LjB29wjvB/V+1
         0NFsYUIXLzaJRr/ZrOY5QFlOtBBtoVaBxSLj1jJSr5b9JxbdohAGkiNVYZSMGJxQ3EGv
         0mSFpA8OU6epvv5+D8inVfdeZnhHSOYgFTFDPiDgiiPFNzwGlLZQ9SDN4FGrHXLQvbNb
         CZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=dOYCARJAXbdzDNt2l66LDCjrByZn+oDuMXEZVZLikvM=;
        b=OnXC1Dke4F0qkONZ/jTIk/oe3jtH5rdddjk+jTY4zzKH2/jwmnTWyUSnYJyUCST9lb
         srG64krJ4dAu1LfPQRw1wfrwTrZu3dfrZ/lOjlgbeFG4R2zhAX34wbmh57RAR1oj0hXV
         92yYN04iVKebzSTdllzqPN/iCFXBpo/Sb/+omyHlskuInFQVsxPrXgzdvsSni/rxULBw
         XD7I37D6x3p7xDgXn6rAktepbj0OQroiq3nmvV0uCH9SXm3/fuTbGUlkzAmHtAMxw/mA
         bqj4dcLErOVir/isf1/xFWN6TUcOJkbfg679FfK/PIgdBTmifrgfOitF9GK0W94RW5vH
         doDg==
X-Gm-Message-State: APjAAAXnN3EEWPpkljVfAX+eLIb95Sf+hFQ7FV85GCGth4G/9AVG6AU0
        xe9me4omgWr/cVxYu7JhcH8l11dN
X-Google-Smtp-Source: APXvYqzHsWZJGf2jNsa8oUZPkCBwE0L7kCZCoaEmHs0sNivNg4jv4rJicYnF1ceeXFL9dsw4d6mwZg==
X-Received: by 2002:a5d:8444:: with SMTP id w4mr21231025ior.51.1567280139965;
        Sat, 31 Aug 2019 12:35:39 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:39 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <len.brown@intel.com>
Subject: [PATCH 19/19] tools/power turbostat: update version number
Date:   Sat, 31 Aug 2019 15:34:58 -0400
Message-Id: <9eb4b5180d33c827f16829644ae0cd7382ecdb82.1567277326.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
References: <adb8049097a9ec4acd09fbd3aa8636199a78df8a.1567277326.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Today is 19.08.31, at least in some parts of the world.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e8b6c608d6d1..b2a86438f074 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5306,7 +5306,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 19.03.20"
+	fprintf(outf, "turbostat version 19.08.31"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.20.1

