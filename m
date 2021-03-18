Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4F340EFB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 21:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhCRUWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbhCRUWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 16:22:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E456C06174A
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 13:22:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e7so8238446edu.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 13:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ob6fG8E3fraktkj4Dkda1Ej1rAzBgKLv2wfHT9YI+l0=;
        b=d2ZY25srhFd+MVnK8htlvrHP4JIgt860DnBj9ibJRS8sWNDxf5YX58uEgk1QYvYDlK
         OwMUBl1GiN8Zx9786Xh823f/URSandGDJOLvIVteLsx9cNWZAFthqO52g6a25weZvXsV
         g8yRjH2RaffWPMLMKGeOa3VTYTiWPHWyZUaMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ob6fG8E3fraktkj4Dkda1Ej1rAzBgKLv2wfHT9YI+l0=;
        b=uRdPZp4hYHa7K2M4aHi2bzTKWbtGsa+N3oW9l23rSxP2tQjcEwpYZb4kyMNrkIQJbi
         B6ZGRnQnkh4VL+RoEOqWlhraIT2VNvqQYt7yzP+5DkL+xL6AzMxHKc3eV+Rbc2Rdi99K
         rWFjEEqzMpDZHFwjvuExAq+7abIKBBocmDL3CH1CzQwi3+PeQUmMQJexbOsRxNsvi4Xg
         cz64rfxBei8zx4J4Ry4FJ8YeuzrCicE5hBnnp+vc2SWxQ49th110F97KMrn3iU4uczHB
         dNqEWXtDYLlt36PRlwnmbJ2VUL5VWDS7g0vboi8dxrrw+CtJzmVFKIOWLhlS6CGOzFim
         08hA==
X-Gm-Message-State: AOAM5304nbXg734KPLC/wlg20bkPXMf4nQYcWcL8OTVtABugpAU+o5HZ
        E4SxHR5s5VlRcI1Gyo7hZ2hAUw==
X-Google-Smtp-Source: ABdhPJxvSab8IKyV46iMQ1e2euP+FgAPOJi9UpG6z2YOpYFNbKocXxaLMlfGtUJ/ocpofk12CqhHFQ==
X-Received: by 2002:a05:6402:699:: with SMTP id f25mr5853913edy.47.1616098950004;
        Thu, 18 Mar 2021 13:22:30 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id e16sm2481120ejc.63.2021.03.18.13.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 13:22:29 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     trivial@kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, linux-pm@vger.kernel.org
Subject: [PATCH 9/9] pm-graph: Fix typo "accesible"
Date:   Thu, 18 Mar 2021 21:22:23 +0100
Message-Id: <20210318202223.164873-9-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210318202223.164873-1-ribalda@chromium.org>
References: <20210318202223.164873-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Trivial fix.

Cc: linux-pm@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 tools/power/pm-graph/sleepgraph.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 81f4b8abbdf7..ffd50953a024 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -6819,7 +6819,7 @@ if __name__ == '__main__':
 			sysvals.outdir = val
 			sysvals.notestrun = True
 			if(os.path.isdir(val) == False):
-				doError('%s is not accesible' % val)
+				doError('%s is not accessible' % val)
 		elif(arg == '-filter'):
 			try:
 				val = next(args)
-- 
2.31.0.rc2.261.g7f71774620-goog

