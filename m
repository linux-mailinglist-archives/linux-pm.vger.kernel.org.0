Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0C818C6C6
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgCTFXF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:05 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37054 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgCTFXE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:04 -0400
Received: by mail-qv1-f68.google.com with SMTP id n1so2372557qvz.4
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=41MFQc5i5QqXVpDWq9ZYXUbE2CVVgETOjycHGMDMWqs=;
        b=Rh2ff9SLf4vSPUFkTUXvFS2o2lF5aEPJs4RDohEXctpwNpe9dAf4jXaJ12cyO6WCiZ
         8lgH/uMnZOk5Xg9+iwFq4MxQBvorqfUjKzAWu1tDXETyyE3plCUkYYnjTrfV5vlnkRAC
         XLcIG2EJTZbrrSDt6kofnTHO989T64aNO9HJtit+NpsuRkuP2KJLk8kxebz/ftXFeAkq
         Oje68Q17gtdPlwBG8kmYe+/+5UXb0QeHKxJhKjS9+Ecje/icUbkuRtJ8QONw6JMT+4Ap
         2qhCxHU1LEyxtLg4V3IjXB4fIDwAMlwcxoQ3CeRq+z2oPZM7Zva4DTY/qwC6RFrXcDaB
         gHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=41MFQc5i5QqXVpDWq9ZYXUbE2CVVgETOjycHGMDMWqs=;
        b=BT1TgpVdUY868Vkhaey0cLisq1iB8G0hPG3fFKTGSmwf/iwy+E53fBWXl2+vfGkHt8
         wn0INeR/oHEpkfamI6El296/tXuS68HAVBS3KNfKrVwt3ofKNlMoIFGil6tSdr8E9hoU
         bb9gOT5ZQ4ncjNJPrj9lXNDa6zHxDcgY0hLBiJTGrc4o5ILsOQJjFnJq5q9X9b71RkNV
         Cb2zLOgNLxGKxBE68qzN+lJrsx1I3gTqtc63TtKoSWgJzqDWYs8Whf+LpUHerpwIkJAC
         vlBlAbUO65vKZCM1m70q5z9Nork4URg8pwxBseWCTW7QgttbMA6KzBK8ryOtdc+IBCcB
         QlyA==
X-Gm-Message-State: ANhLgQ0fAWnr91zve9nh3BsKeFJIM7Agp9D8YmQ1BBhaZAQjXn9c6tZG
        0j3erwVGQhOxRH4On6X7LE11HLOm
X-Google-Smtp-Source: ADFU+vsXXfY9G8ZohEfImhG1DHv5QUMxVK+Vk/qZMfRSMpSQ0ptUdOs+aqhfjkvJo7ukFm9e74jZVg==
X-Received: by 2002:ad4:44a7:: with SMTP id n7mr6169076qvt.152.1584681783180;
        Thu, 19 Mar 2020 22:23:03 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:02 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/10] tools/power turbostat: Support Tiger Lake
Date:   Fri, 20 Mar 2020 01:22:41 -0400
Message-Id: <4bf7132a0ace8888398af8cec6485ee4c6db5ea8.1584679387.git.len.brown@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
References: <081c54323b27d8d4b40df6b2375b9e1f6846d827.1584679387.git.len.brown@intel.com>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chen Yu <yu.c.chen@intel.com>

From a turbostat point of view, Tiger Lake looks like Ice Lake.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index fa95a8ca5565..d2c3f294da2d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4616,6 +4616,8 @@ unsigned int intel_model_duplicates(unsigned int model)
 
 	case INTEL_FAM6_ICELAKE_L:
 	case INTEL_FAM6_ICELAKE_NNPI:
+	case INTEL_FAM6_TIGERLAKE_L:
+	case INTEL_FAM6_TIGERLAKE:
 		return INTEL_FAM6_CANNONLAKE_L;
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
-- 
2.20.1

