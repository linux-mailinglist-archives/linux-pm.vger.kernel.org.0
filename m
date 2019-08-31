Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAF2A45E7
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfHaTfY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36467 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:23 -0400
Received: by mail-io1-f67.google.com with SMTP id o9so21126150iom.3
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=Brotjj0bAWiTq6owzVL+v4eiuQaLRD+EexpYdyEwa2s=;
        b=T4Xy5SGiLIkTpgXCj8LdhbteiWXlGu8wEtmi2G4gZjCT8t3fc/RSU6nAKGuX3/dsTA
         mfPO1SUdQBnQUWwPZ5a/xqhMiuP+my4FxSF36dFCWKTbXrygYjge5LBTyOCh3CUdAuIC
         fuKbtQR7g0xoHNCeV6ZHDZaBFbzeNXFosPVugd8u/p7kFYsJ1KGV7xZOfDwF2D3Sopvn
         GQc0gXQkgLNIVkLMN2unAVs20dRm0O+fhJCExhKv8UCVU4JyDmQlX/XzcltfRpiFSJrl
         DBDaSRRbXTNTYq77vbYnq2rVdShGbQYFvvsK2xDcVGP5YCzMPnpexBwn2pYygZ/z6ijj
         VZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=Brotjj0bAWiTq6owzVL+v4eiuQaLRD+EexpYdyEwa2s=;
        b=PoqPdIUU/Lxo5lxUOis+nn4mxwnjhCzBDooDiYv1xXUnaZFCMKv47hrJ9Q5EASYFJm
         RESqR3Y6rDvsNf2L0npBqvZY2TKTUvq2gGRq/1J1EcJpQu7Hmm4G5e0MQFqK+fC/fZzQ
         VCbjlBdIElUJaKFxFs+65fRvnZvVh386IQNkOo5DlPZ7Uz9s0Gth63grJbMjU+hCeDWV
         j5uLlUJcq62O/zmqoxFNyhnT2Trg2aDCtVmMWAC/h6ajYGpy3Sx4IVi5t9oSUbciWoF0
         oMJnE+wwg8E7y96vNblPP0pvsyACLw7Y5O5aKZukC6ALeM47ySlst9I3rJeHOcD08Dlf
         M9NQ==
X-Gm-Message-State: APjAAAUYBypn5vFBda4jcPrJBDnlK2TaNHqXQ7cYB4icZkXFT5xLWp1r
        4oiBpopiu5z1O20dgdrAvcogPsVM
X-Google-Smtp-Source: APXvYqwmWYhA+2HiEzM6KHToXRpF3aAqgrrZ5mVoso6ya2zU/s/QMb3cLK5FJ9KJPLbbrNhBsIC4dA==
X-Received: by 2002:a5d:8444:: with SMTP id w4mr21230006ior.51.1567280122723;
        Sat, 31 Aug 2019 12:35:22 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:22 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 04/19] tools/power x86_energy_perf_policy: Fix argument parsing
Date:   Sat, 31 Aug 2019 15:34:43 -0400
Message-Id: <03531482402a2bc4ab93cf6dde46833775e035e9.1567277326.git.len.brown@intel.com>
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

From: "Zephaniah E. Loss-Cutler-Hull" <zephaniah@gmail.com>

The -w argument in x86_energy_perf_policy currently triggers an
unconditional segfault.

This is because the argument string reads: "+a:c:dD:E:e:f:m:M:rt:u:vw" and
yet the argument handler expects an argument.

When parse_optarg_string is called with a null argument, we then proceed to
crash in strncmp, not horribly friendly.

The man page describes -w as taking an argument, the long form
(--hwp-window) is correctly marked as taking a required argument, and the
code expects it.

As such, this patch simply marks the short form (-w) as requiring an
argument.

Signed-off-by: Zephaniah E. Loss-Cutler-Hull <zephaniah@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 7663abef51e9..3fe1eed900d4 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -545,7 +545,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw",
+	while ((opt = getopt_long_only(argc, argv, "+a:c:dD:E:e:f:m:M:rt:u:vw:",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'a':
-- 
2.20.1

