Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6ED18C6C7
	for <lists+linux-pm@lfdr.de>; Fri, 20 Mar 2020 06:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgCTFXG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Mar 2020 01:23:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39546 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTFXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2020 01:23:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id f20so4001116qtq.6
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2020 22:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:reply-to:organization:content-transfer-encoding;
        bh=7FcOp/sgWLl2793MNlnRQpX9CI+8SvdKRappctIhTtY=;
        b=RFvmu3HDoP4LcYMwUQaCws4qyhKYuEWnrPyVEThUpqDQNLZR7q1mwq6K9dsiQhjFo0
         I5nmRVFE1uEXyCPLYF4MpJY5w7hvLcyfTge9Du9y0kBsusVxBAOZrtIoK0tZ++ojIdnH
         wZjQSl2W8kRx6ProSnExihqHiEn4kWWXphz6Wb8xrhf8hczyulQHJGv3lJoSwrfMcs2I
         t5zNebRzHmaSRAumzYIrrU0uppLkGro5+R1YsFN9IG/3Ugd04c8HE2sRUTiypPY9q3u5
         5CfyWp0Sb6FTfvXVF3oaLxf81Qpm7+VdjCHqoSARhNv5R2N2B98MAADA4Un/MNnjXrkR
         plhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:reply-to:organization
         :content-transfer-encoding;
        bh=7FcOp/sgWLl2793MNlnRQpX9CI+8SvdKRappctIhTtY=;
        b=ks9MOgFLXThgDjoVXS6AM/VkHaF6p2WZ6s4dLp7ugQ2pL14qLXH1sl78ZrBjrUKItc
         Bfbn6sbSRGsyX/tNQ0ZRoNshoF0HFtGK6uxaRTrQK2ZUry1vggZBvrFT/rtbBDHDCU67
         4BUASbP0GREfUUr1YeX720MMfwOEgqDk83s/OTJSLLVxR948HKZHD6Y8E/y2fbCXbZsR
         1IoJZyhzRBvOCH37+mENkVa5Iez4lyDozA06hP3Z0ZljsqqE5vz6e0kDPbxLYxLZQ/DH
         DWd9VPcjEYmW27knMl1hPBl0vSvjQd63I0SjcBYAuReK5P5HnGx6n7w5O+kPdiCo46Uj
         ugcw==
X-Gm-Message-State: ANhLgQ0Ymt6ATHIdmbWcJ9piXWNJChDpbmA1SEGNkfwpOKj5g3xOpg/s
        sOHZ3sibRHNm6KqgwRsMS86NrAIq
X-Google-Smtp-Source: ADFU+vubhRDK9VQfHiBo16Ux8bHyjhXDNYsmw3vN+A8JhgnApeGVFbSlFXvQfMc2F7KIEdU51mFsug==
X-Received: by 2002:aed:2625:: with SMTP id z34mr6710768qtc.276.1584681784422;
        Thu, 19 Mar 2020 22:23:04 -0700 (PDT)
Received: from localhost.localdomain (h96-61-82-19.cntcnh.dsl.dynamic.tds.net. [96.61.82.19])
        by smtp.gmail.com with ESMTPSA id w134sm3273383qka.127.2020.03.19.22.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 22:23:03 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Cc:     Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>
Subject: [PATCH 04/10] tools/power turbostat: Support Ice Lake server
Date:   Fri, 20 Mar 2020 01:22:42 -0400
Message-Id: <23274faf96500700da83c4f0ff12d78ae03d5604.1584679387.git.len.brown@intel.com>
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

From a turbostat point of view, Ice Lake server looks like Sky Lake server.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d2c3f294da2d..26088b2a27cc 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4622,6 +4622,9 @@ unsigned int intel_model_duplicates(unsigned int model)
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
 		return INTEL_FAM6_ATOM_GOLDMONT_D;
+
+	case INTEL_FAM6_ICELAKE_X:
+		return INTEL_FAM6_SKYLAKE_X;
 	}
 	return model;
 }
-- 
2.20.1

