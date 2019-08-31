Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8FA45F0
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfHaTfe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36947 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:34 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so5857326iop.4
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=r0BZFCqeNNMORYOqW9EwnjHAkQAb/FSxUgaPTHccQvM=;
        b=OHyX9QE8nCNrdxEBg/kpA3vvZlDLVkF1RkPKA6mgMM29gjltAQLreqaNK9WVEX0hbp
         ICmO+CpN9uWQbnA5AuLGOC4dqJViB5EEEadz/xjcF3t2Nuu17DbI93huDXhjEPZfGtFI
         s/4uyvfpp7qOgbXK+k1zKOXGJ5OIsUqqfiOE/sOUaJCkMINdMf0OYCOIAC/a+j0js2FZ
         csAaK+JqbQlk6hHSl+Gb+5ajiNhIdh1jnantQLzNKOiS9v+MivWLBHVVW9XvGgQwFJT0
         SadLfm9YszzCfOIQ9thl3K1ettnn2smLFi9WkchZJsMt01ioqClBKNeHnXm20jXtNyug
         akIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=r0BZFCqeNNMORYOqW9EwnjHAkQAb/FSxUgaPTHccQvM=;
        b=lO0Fkyd8JvMvTVbJP0TGcQxJM5DjQwvKFVoaxbMiR8d+IfOqDytq+oyFXS85UT3vCd
         rooRYsA9EH3k/I3GXOwHmYQCm/xu1uqZavNXU+5NEedwm/ra7u7kSijyAv+CqomS2ae5
         xADWixfXLqJ7CBEkg2L/ov/bZPy5Fj2U1Jo8xTTf2sUkSBRkDozKl67iC0yxh/IrkzpA
         D5Eo301+wqwjwTPIdKQTp1tQcQiNUwbxQIwPw6dz2jYsJB5LZwRAYWxprmAyVaHwu7zD
         qRnoFjKFd6U/aq0Fpp6++r+aCVoxDEQqxU+86kI86VXl2HOLLpx07ty+AutHol2dRYF2
         kMPg==
X-Gm-Message-State: APjAAAX86eY0VqijYWbxtvXzVUfX1+JuK1QXLbzSesTJYEaB+kOEiua7
        QJPQ5++QleT1F63eRnVIau6blXFs
X-Google-Smtp-Source: APXvYqym8TZilZO6TpF5qwwBAQayVi08S1W5Ofu+KFVZOqN00nSyFjcu4/lUEgqPCCccYD05XFo5FA==
X-Received: by 2002:a02:3004:: with SMTP id q4mr23345678jaq.55.1567280132971;
        Sat, 31 Aug 2019 12:35:32 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:32 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 13/19] tools/power turbostat: Add Ice Lake NNPI support
Date:   Sat, 31 Aug 2019 15:34:52 -0400
Message-Id: <d93ea567fc4eec2d3581015e23d2c555f8b393ba.1567277326.git.len.brown@intel.com>
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

This enables turbostat utility on Ice Lake NNPI SoC.

Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 51c739043214..393509655449 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4592,6 +4592,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_SKYLAKE_MOBILE;
 
 	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_NNPI:
 		return INTEL_FAM6_CANNONLAKE_MOBILE;
 
 	case INTEL_FAM6_ATOM_TREMONT_X:
-- 
2.20.1

