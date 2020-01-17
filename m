Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 361DE140727
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 10:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAQJ6d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 04:58:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39458 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgAQJ6c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jan 2020 04:58:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so6912263wmj.4
        for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2020 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o36RaHkWyNj2yjr65Y8zkIjoLWUVDNL+2aT4mOgUFjQ=;
        b=orgmIPca4KHssXZTIiaaRlV4cLwG+SS7V9EG7A4tIU2q56gAHfFgc1Twib1UcgnJrT
         geFR4EMjNQvLMfndpgqbSkRJhcBIHqJ8QItpx/EYI0Qup358daqOkMR8GVYQG06V5mkp
         Bp52h8Ri1gqeR7BKy2uEhqixPbp5iR13A9E3k0Kf6Jv7aaLKPuCuSOaT4n6u3R8qmzql
         0pTSNN8VEvXOCAvDNmDbo8XToi1Rr7xwU6EKrw1RzgZwBFSvR35yrs+Kb5DRGR2SxCys
         Ri+r8bJBkzys0eDGWwf5v0QJUVUiKaYgnXB2IdlAV5bGW+Ne4r5R1xixW1PH3jN5pIY5
         fxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o36RaHkWyNj2yjr65Y8zkIjoLWUVDNL+2aT4mOgUFjQ=;
        b=hxqhTgr4oyKaNC9jVtLAJgtp4RgV8NIPtYPt3NXanT32Hn9o9QhVG1he1hDrhaWyz1
         Ot+YZlfN9GcVbvB4DokLGRifEMRwTaVGt/305WV7Bdrlsv1CwQIgI7Z5OS0K4u0mX7Wc
         3SWZEffSgC9Oyqiy2WoDRRY0H/RlQc6FBfUkThhjvXeZIkEiol8PU+uMkk6wZO6merFh
         imnIMP3rn4gH2Ok1NgCOa9h80ASzQhwptvmQO7mpEBgl/DSrUdukWYTIufkJcPvY6uNC
         Tr5qEVuyORTEtnqg90eEJ8dEaENTLgBOq6816kBqdsr2VV9UYdhIsc1LWq8iLnC0d2pl
         rT4g==
X-Gm-Message-State: APjAAAU/FUwCVj4pxNQ8N20sh4foELGC3IkpYVX5+eA7UocX4XvQwE5X
        L6z+ecQXdEYktbp9D3UCJrJ6+g==
X-Google-Smtp-Source: APXvYqynLhYzdsHo8Ekhd4n9nYAazzRaxIZY6lBiwX73EYhDy5ibn75qhbg8XmhajaFx1jx9UPFwyQ==
X-Received: by 2002:a1c:2187:: with SMTP id h129mr3619005wmh.44.1579255110547;
        Fri, 17 Jan 2020 01:58:30 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r62sm9967007wma.32.2020.01.17.01.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jan 2020 01:58:29 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 09/12] interconnect: Print the tag in the debugfs summary
Date:   Fri, 17 Jan 2020 11:58:13 +0200
Message-Id: <20200117095816.23575-10-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117095816.23575-1-georgi.djakov@linaro.org>
References: <20200117095816.23575-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now we can have a tag associated with the path. Add this information
to the interconnect_summary file, as the current information in debugfs
is incomplete.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63c164264b73..10dde5df9251 100644
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
