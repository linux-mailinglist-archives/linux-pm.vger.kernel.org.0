Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7521AA45EA
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfHaTf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:27 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33335 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTf1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:27 -0400
Received: by mail-io1-f68.google.com with SMTP id z3so21192771iog.0
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=k6plyY31z8FLjLduOrjM6cc+MzPm6Svu5Cwr3fZPjlY=;
        b=PH9wgczBIWF6sZkXtMDPu1fwFfqzdjvgH5deW1K8U+xArhx+mAjHTHqTmC6AVx0o9g
         yUls3EOK3sAT0nrQc4yH6Ci2i//MxwBJgXvU94SUa1QNqX9Ezgl1OlxdKKu3OtHVYPHG
         +BGr1VWa1UGFF68kUgXGAmnNMewS0oUct8RkyWXphzIJCqmr9T+AYgiJ9LLOpQlyD+UE
         A7zfZxYNWuwDPNPkQym8rEr/KaZPA/uRzViKwymCc3V/aSNPuf8pByOfzNoUQPp/Y+sZ
         aTuAcfk9Tdr8+lKjqIkXkYbILIlejSmWh7wtVWSOv0eP2R+jc9iCpkT0ybsNOf8LvPOs
         qloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=k6plyY31z8FLjLduOrjM6cc+MzPm6Svu5Cwr3fZPjlY=;
        b=rHhJq7V6AfR6I8ZqrcLBDswdOI73ro0VuzG9wjfi5jHpGmJ91ixQi1vkCPcibxz3Q+
         aPNtmjqfy43Aqs5MwI0d7zdXTmzCL2FZhVqbFWFF+mguaL8txT03I+zc2HaS0JYrh86C
         gkk36jfnGZUBfHbBQHx2cyuMNmZdspV2naeD24bdsxUXDIjHCjSnrEZNVljbjjIQ0CK3
         jhdr1KjUsjmyWbRGCrq1SGmKmpeO9uTbpTLA0MfImZ5M47CDgcuaw41YKff5byU9LF9R
         hXcp0wbW34sild7x4BjOgPGENDeedRj+G0JVahsDMqFNyyuyWJPFAjobW/AOSAGxZQRX
         WtPg==
X-Gm-Message-State: APjAAAX4BF0zY9P1Z5ZF5xe7U7YVv98xhzS12d/jgsDPbi3U08oXVUmP
        WIUEEKRKThOps7bMYjGKZVhsQoWX
X-Google-Smtp-Source: APXvYqz39g11+H0iTUhnwuzKvTcQAt7OeF4j3tBZ/jFRRFcv0daoSnWdxh5HQdnjrwubL0rJX0sLFw==
X-Received: by 2002:a5d:8cd2:: with SMTP id k18mr20929679iot.242.1567280126261;
        Sat, 31 Aug 2019 12:35:26 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:25 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Len Brown <len.brown@intel.com>
Subject: [PATCH 07/19] tools/power turbostat: fix leak of file descriptor on error return path
Date:   Sat, 31 Aug 2019 15:34:46 -0400
Message-Id: <15423b958f33132152e209e98df0dedc7a78f22c.1567277326.git.len.brown@intel.com>
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

From: Colin Ian King <colin.king@canonical.com>

Currently the error return path does not close the file fp and leaks
a file descriptor. Fix this by closing the file.

Fixes: 5ea7647b333f ("tools/power turbostat: Warn on bad ACPI LPIT data")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 02813a2a8ffd..41cf1206273c 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2944,6 +2944,7 @@ int snapshot_sys_lpi_us(void)
 	if (retval != 1) {
 		fprintf(stderr, "Disabling Low Power Idle System output\n");
 		BIC_NOT_PRESENT(BIC_SYS_LPI);
+		fclose(fp);
 		return -1;
 	}
 	fclose(fp);
-- 
2.20.1

