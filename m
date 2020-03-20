Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0B18C6C4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgCTFXC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:02 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34896 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgCTFXC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:02 -0400
Received: by mail-qv1-f67.google.com with SMTP id q73so2373328qvq.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=mfq+jbDtLvNFwCkgXQFFx1U0KzFwGmwWgMQRhdX+ggg=;
        b=SiaamRppyc1pLmbvwUZdKMI9A+G+P0pUeZNdCNotkhO9Ph+cxbI/2RIqzeYJQiHMaC
         Ak1/14+8II800sgaDW8dJqJV1WE7m47icjWzBG0OunkehJPkOGYUswnL+0UI03r9XzJH
         84uXz0SgxNxrNs98o0dpNrKkE3NSmSsUTTPHiruO0ham/BENaLX+thR75Vbx1uPZdSy1
         rIiP2Q5OTfmK5K3g06rwu9wAzLZJGVwpMu/n+/8e9GnR+0RAyiLdsnLp6IkSOXyrDrxG
         LyQsMq5jwpBZ6/YXE/iJqu0d51a+xmhNakc2Ld5Jz9BqJHkIZVPakN+6h/vBHXPJfsBj
         ZCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=mfq+jbDtLvNFwCkgXQFFx1U0KzFwGmwWgMQRhdX+ggg=;
        b=O1sPN7D4QNibQwAgXSwR6qBfofzdLhoIby4tFJKGjVpawILjZFhzfY8AkROkX2ZF1B
         BYyKoayN4iVM4KzfbIVrniGXkiXMGVWSS0lFzX+i0Qc9MSBpls5RKlNNKuo5kjqwbqGg
         CXxi5kq7ni2ku5s43b9Ql8y05sCEYMss3p325xfJq66zq5WfEqj2sSeTXuD94oOMCALF
         Q+PaA+c9SquSL99fiXXEZGEKb53nUi9D0V5lpwj/cZpNDssTAfscdBDT+g3o+aRIedI9
         ykAzwlXGfYJX1L0Hf6kizAkIkFenzTM8GAQOn1yDra5pSMGxvOF+H87IG1nt0GlgiqGW
         faXw==
X-Gm-Message-State: ANhLgQ0GXGb1k5lgreQ/fDrvTCzEoi0ITagykskS8B6pC+50SDelJMxe
        EZF5uVvN/EPKWv4CDD6It7YiB8Li
X-Google-Smtp-Source: ADFU+vtg2u8l3emT7GpQ2m/BkbMMXLs9pVFHi7/EGAP3N6di6XnZaw7fB7mHVm2G0jJyj7aiGQMnhQ==
X-Received: by 2002:a0c:9b95:: with SMTP id o21mr6571501qve.175.1584681780729;
        Thu, 19 Mar 2020 22:23:00 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:00 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>, Rui Zhang <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 01/10] tools/power turbostat: Support Cometlake
Date:   Fri, 20 Mar 2020 01:22:39 -0400
Message-Id: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320052248.13037-1-lenb@kernel.org>
References: <20200320052248.13037-1-lenb@kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

From a turbostat point of view, Cometlake is like Kabylake.

Suggested-by: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 31c1ca0bb3ee..dd5ac9f52ac5 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4610,6 +4610,8 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
 	case INTEL_FAM6_KABYLAKE:
+	case INTEL_FAM6_COMETLAKE_L:
+	case INTEL_FAM6_COMETLAKE:
 		return INTEL_FAM6_SKYLAKE_L;
 
 	case INTEL_FAM6_ICELAKE_L:
-- 
2.20.1

