Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE771280CC
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 17:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLTQiz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 11:38:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36604 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQiv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 11:38:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so9890238wma.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvxa0Xnr9nkcLaOalM1HckZFWjf459g2PFBnyA+1Iv4=;
        b=Opyl8zrWxfG0T2eYgPBCYlAFhLgCFaTHdUTXn2LxdfuGNDC2GdzYXG1yF19O38Us6K
         1AsYjkhAk42CChTlLYqNfHgAu+vSGaZm0yPEMw66FdJ2Yz0PmpKEAS0U5+gwOogm8goU
         gPyZz+CLK0axB1A5WOPgA4tUa9IVt+ZxzhvvPKdxDGaiCUUMTl92dldhdPb79bYd+Q2R
         ZjECpnvcx+cGrskEDW5EZ3HGjA7Do9m7fGzKCc8bL1CUgXZg5I61E14M3pAyNWlObYjj
         4GQbyEq8NZBsuetsHAzqEVKR1RS4z8kEJ1rgAeZ+wI4ac6Gy4QXgGGrQ1aooDe55ympf
         Wn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvxa0Xnr9nkcLaOalM1HckZFWjf459g2PFBnyA+1Iv4=;
        b=H2EOxKHkVajb43TQ2lqphMaFqxcOTpOygCY8kT13nIM3Sp55bb/8Sl5mVTbGCIS18c
         TeomMIW7R+9TbDg0ZgUOZ+p7/foKt6mGArC2Tvf33YSSXcl3psQEtUrUoDOe0u6YXjEs
         sP6I/ieZ6IKs0WDkaxfLMHutp/5RF3YJ1HMZ34fcpXjDVah/deTUyW2jaFBl/PT5SuTU
         966Ikhl2Ov2ckibqm2gZ99qDq7Y55Qoz6kVYqdpuLaK2AtBoUQ9TQaysiHDQrpfMgXEZ
         C+XN7716NaJ8RJN/aTtHM2sJIaorqqMfYq+tdsqxjTb3p+rQLYK64MTXUmzFz+5knQBU
         6T9Q==
X-Gm-Message-State: APjAAAW/Z5d4IQ7hKzXDp4lHcQknJeWp0ZvxnQkCL45xbQxQcjoX1O3g
        HK+IVerxT6yzCg8QZyeNXbG7VPhjtJ0=
X-Google-Smtp-Source: APXvYqxjax6hqfjHaodsvksvLvuP0wGDpdHU8lOPkcx5J9+yf6G8YILWdnEjGCWoHy1btGBX/sLMSw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr18453304wmc.78.1576859929814;
        Fri, 20 Dec 2019 08:38:49 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g23sm10225807wmk.14.2019.12.20.08.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 08:38:49 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Print the tag in the debugfs summary
Date:   Fri, 20 Dec 2019 18:38:46 +0200
Message-Id: <20191220163846.6485-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now we can have a tag associated with the path. Add this information
to the interconnect_summary file, as the current information in debugfs
is incomplete.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1867fad56c0f..ae80fbea5d2d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -34,7 +34,7 @@ static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 	if (!n)
 		return;
 
-	seq_printf(s, "%-30s %12u %12u\n",
+	seq_printf(s, "%-42s %12u %12u\n",
 		   n->name, n->avg_bw, n->peak_bw);
 }
 
@@ -42,8 +42,8 @@ static int icc_summary_show(struct seq_file *s, void *data)
 {
 	struct icc_provider *provider;
 
-	seq_puts(s, " node                                   avg         peak\n");
-	seq_puts(s, "--------------------------------------------------------\n");
+	seq_puts(s, " node                                  tag          avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------------------\n");
 
 	mutex_lock(&icc_lock);
 
@@ -58,8 +58,8 @@ static int icc_summary_show(struct seq_file *s, void *data)
 				if (!r->dev)
 					continue;
 
-				seq_printf(s, "    %-26s %12u %12u\n",
-					   dev_name(r->dev), r->avg_bw,
+				seq_printf(s, "  %-27s %12u %12u %12u\n",
+					   dev_name(r->dev), r->tag, r->avg_bw,
 					   r->peak_bw);
 			}
 		}
