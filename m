Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECAEC90E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKAT25 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Nov 2019 15:28:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40722 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfKAT25 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Nov 2019 15:28:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so9974317wmm.5
        for <linux-pm@vger.kernel.org>; Fri, 01 Nov 2019 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Mutma0I285HLAM6Sw5PmtAvnBP2OZbW46A3J1dY9kk=;
        b=TGRoCxKACJ9VtmiTGZQHEaYEdxpZQOpr/Q2KzvtQoVIJMdZqdG5NtWy3ZhNQyoIlWL
         rUCsxm3aeT62XLB1CWUyTKX/z2ChTvUZ6BfGjDCFBhZMkOCcnLnoJHIgcCdUHKvgqiXn
         F6+3ChT8uGSArJQlizjjRlF/C8sN/OZq4Nrsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Mutma0I285HLAM6Sw5PmtAvnBP2OZbW46A3J1dY9kk=;
        b=YUKbizAa+wizj+YwHE8RWR1tVIu3LrjtJcsFQu5BhqGMbYpEY+9wXw/RUs+MUmwYfc
         hRiiARw1ujtnqyK7KMc7T5a1b+luiMX8npBUl28JW8YPjopBIyWJHQ6+LpIvFEQnqEG/
         HSsVMUeQvme3/Q6yNKdrnb8AYl7wsDEIpFR+u5jmMGLGzzf1igsEq6EmkVWBYotkDy0y
         zd/ij+nccRxwEyJfwjdiE7ERjrTeHwEC1SrRzaC5F5m0TS44isJC4fem2qqOLxcDD0nB
         0bADCKs6zfEnp0IdPNaFbrD8gHMhmOVB7KJBMvVZetGB78vMAIN5HsUAM8f6ef6cnP75
         VnPA==
X-Gm-Message-State: APjAAAUZ18UzW5od1oKieNIc5UJ8cCeXsPDkXeUwbOpqGUhl3xALVgrb
        ubyNC0nYBpwKxwe39ALHpiH23w==
X-Google-Smtp-Source: APXvYqzLIKewNStvLv8a4CM24iYDjlSWZc7mf3HWJvdAslTWYLuXcXhtD9k/sua9kX7hD0Tu22Zn/g==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr11509610wmj.126.1572636535053;
        Fri, 01 Nov 2019 12:28:55 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.245])
        by smtp.gmail.com with ESMTPSA id a8sm9786395wme.11.2019.11.01.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 12:28:54 -0700 (PDT)
From:   Louis Taylor <louis@kragniz.eu>
To:     georgi.djakov@linaro.org
Cc:     corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Louis Taylor <louis@kragniz.eu>
Subject: [PATCH] docs: driver-api: make interconnect title quieter
Date:   Fri,  1 Nov 2019 19:33:14 +0000
Message-Id: <20191101193314.67994-1-louis@kragniz.eu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This makes it consistent with the other headings in the Linux driver
implementer's API guide.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 Documentation/driver-api/interconnect.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index c3e004893796..cdeb5825f314 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 =====================================
-GENERIC SYSTEM INTERCONNECT SUBSYSTEM
+Generic System Interconnect Subsystem
 =====================================
 
 Introduction
-- 
2.23.0

