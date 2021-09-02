Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A23FF5A9
	for <lists+linux-pm@lfdr.de>; Thu,  2 Sep 2021 23:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbhIBVgu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Sep 2021 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbhIBVgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Sep 2021 17:36:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED7C061757
        for <linux-pm@vger.kernel.org>; Thu,  2 Sep 2021 14:35:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ot2-20020a17090b3b4200b0019127f8ed87so2014684pjb.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Sep 2021 14:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zCkd3JvyHoZ9LAWIPQYbpkAo5YW68kDeuOEoBqJRhY=;
        b=hKwCC7KdDOszi7xScsH3Xrs/7EFRh3iHI9sSxQgX3PbIySek1TBQ37ie8B3w+R/PVJ
         3W+tMwoFWQVSkHd2Y3T/yz72jRA/QIYpC2qUHq8f4L15lw4AIzkn0fHST0Ta2VWV/37Z
         haA0lf9LeyIwlCHvYDAJPSepF88x5nEGEpZaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zCkd3JvyHoZ9LAWIPQYbpkAo5YW68kDeuOEoBqJRhY=;
        b=iccVtQkWY1K8pgkB4mR4lE6zkgEnji5/94VQYQxYGjGSQGStw4Z+ztdYhk1IwPbsgi
         aVsizbi0GR4b7f6LBRVGfdhRF6UzGaGsOoBHIKZ+YOIfWGhPC7FbKYI8Kf6rkGuVLgZw
         MvAWGwFbS6silY2+qXfHUUj1skdVHKb2vUXmXNTfxBcNaxJwS147F0LKhjvFuEWkqvFD
         B0EUx4Af/+MlErcNqDQylrW/J/p0vjsOaLlwlM8WOg7kJR9dK+DNZUJbQotJNlEuXcZJ
         n/qZvE9PVm5nvtAk6dWj5yZxKVVXf5CS0dQDfWvOkwU5icKEOysfXuFPV6YufGck7FpH
         ZR9Q==
X-Gm-Message-State: AOAM531uzBywufLLNC/Mn9XSXBLDxfLJgPaWu3WpR6pSwiZkUPtc+BpX
        5wjGA6eEDXNvvo8FrW600+6vDw==
X-Google-Smtp-Source: ABdhPJw/kFot2iDRgNRI52oS3yjvEq82wiDachQhMt8HLLKkbzugaw+VBNDlC6IszciAmYmI1enbNw==
X-Received: by 2002:a17:90b:fc6:: with SMTP id gd6mr6167950pjb.186.1630618550978;
        Thu, 02 Sep 2021 14:35:50 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:d082:352a:f346:411a])
        by smtp.gmail.com with ESMTPSA id c68sm3167872pfc.150.2021.09.02.14.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 14:35:50 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-pm@vger.kernel.org, bleung@chromium.org,
        heikki.krogerus@linux.intel.com, badhri@google.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: [RFC PATCH 1/3] usb: pd: Increase max PDO objects to 13
Date:   Thu,  2 Sep 2021 14:34:58 -0700
Message-Id: <20210902213500.3795948-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210902213500.3795948-1-pmalani@chromium.org>
References: <20210902213500.3795948-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Increase the max number of PDO objects to 13, to accommodate the extra
PDOs added as a part of EPR (Extended Power Range) operation introduced
in the USB PD Spec Rev 3.1, v 1.0. See Figure 6-54 for details.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 include/linux/usb/pd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 96b7ff66f074..7e8bdca1ce6e 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -201,7 +201,13 @@ struct pd_message {
 } __packed;
 
 /* PDO: Power Data Object */
-#define PDO_MAX_OBJECTS		7
+
+/*
+ * The EPR (Extended Power Range) structure is a superset of the SPR (Standard Power Range)
+ * capabilities structure, so set the max number of PDOs to 13 instead of 7. On SPR-only systems,
+ * objects 8 through 13 will just be empty.
+ */
+#define PDO_MAX_OBJECTS		13
 
 enum pd_pdo_type {
 	PDO_TYPE_FIXED = 0,
-- 
2.33.0.153.gba50c8fa24-goog

