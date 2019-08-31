Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9108BA45EB
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbfHaTf2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34669 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTf2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:28 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so21166147ioa.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=gZJL2iIhBB5yJYfE+IFqeqeHKpBTg3suwKsoFE3jUes=;
        b=Gy5vAJtTN0q/XYWIidE6ZzKes+QqfcpW8Ksc7B0k81R8COC+3S6xTN292OhZZGOhzf
         X6Nx2yhs/AXIXhK0ILT0Yc8pQdmbL9fzKAEdGUNHQRUrfq+Usd/hY2768qycanDviugy
         eGehsbbJL4BTkxs4bnDInjeioftRShxtXNHA8ebbOeRcLdERSAMIln6yTrulT40pUB3a
         DyvmNrj0fGgyFAytn9y8++mcIvb3zfmGYIeczWpx5ljIVEnpWAts1bQzsgcGXntduje5
         tPy/YkydQGF+veGb07wYQMfs/9oXrXf/pAVeeAnsbjNVHdSBAk+x5KfCFLOTPq+EvGEx
         VAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=gZJL2iIhBB5yJYfE+IFqeqeHKpBTg3suwKsoFE3jUes=;
        b=lbuKatEmBi9hCYGNzFtZejAqubaIhHVgtSyBWwp08rxATix1Y2sKVfGcOBLs97LDNT
         JXSZxPPYdp48KN/4otpGkFiTu4PJf7i+yqJICT5esneu2uYkoUxXNjpXNRocNQmGQpCt
         pmtwAvpC99IC9l6JH+HgpO0CNzrpigKvIkuwpgoRZ5CCsQfW8MjFyWpomWLibAkQrjd2
         UqnDCT39MsIyNcvUuNs2qGASY7B7GisS7UuHOVUQc6088+gZtdJBYtM6NH/AosiVArlj
         QouILI20qWPCoY+2+wUQfVoatEQjXjPp1sWx1meafZ+0JNITqrBx8cGLExdLuZjrnAt8
         XpPQ==
X-Gm-Message-State: APjAAAUlrjN7+21rsgiTmIghDBJpzA/wd2xcHkfj++piCkcbA86xK2PP
        2Wqdpp88p/rKHVxS2bDxTIrgIRMN
X-Google-Smtp-Source: APXvYqyktVPQs4RHO3+1uvUSqjFAiqy0hfcs5IswK+LxoTMzUaokPTyN/m74dD9IjsruyuPvxVWntA==
X-Received: by 2002:a5d:9551:: with SMTP id a17mr9884521ios.37.1567280127396;
        Sat, 31 Aug 2019 12:35:27 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:26 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 08/19] tools/power turbostat: fix file descriptor leaks
Date:   Sat, 31 Aug 2019 15:34:47 -0400
Message-Id: <605736c6929d541c78a85dffae4d33a23b6b2149.1567277326.git.len.brown@intel.com>
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

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Fix file descriptor leaks by closing fp before return.

Addresses-Coverity-ID: 1444591 ("Resource leak")
Addresses-Coverity-ID: 1444592 ("Resource leak")
Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 41cf1206273c..2fb5c155289b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2918,6 +2918,7 @@ int snapshot_cpu_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle CPU output\n");
 		BIC_NOT_PRESENT(BIC_CPU_LPI);
+		fclose(fp);
 		return -1;
 	}
 
-- 
2.20.1

