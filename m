Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397912323BA
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 19:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgG2RuS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 13:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgG2RuR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 13:50:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C30C0619D2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 10:50:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so14648631pge.12
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2020 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFOBg7cBb4oehrnTDCb9xOdyBwFJ4COpuNMHWHXBjA=;
        b=it3ps2+cGfi5Ga7sDZ5AL5gGWr9ZJ9AdKwPWeqiSy6hvwG2DEkj0naR2f8QP0/7Bbz
         b8kkEEDYqh57Ca18OTWWLz67pieseOvJY4XSTdGyCXnJ1syvWJmwf0D36OwyHEna8x6+
         7ew4LrePQx2RdR5NOeflNrxgjtilm21KSciOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFOBg7cBb4oehrnTDCb9xOdyBwFJ4COpuNMHWHXBjA=;
        b=T2XJFogVTRbYe/OkXAbRkw5k36T2Q48YmZ3aM4/sjt2xTO3NIGGhklKWR3Rx7KVYjR
         jGpgbewAZ5WsSA004zC9jzZYVh8f57Du03JUUfErIXDDP92UlW5ct1hwhf+ObGNshYrw
         6IsX4wj0eF2SNBzTI8PYzj0reHWWbFCLAADFro53/XaIUoapS3/6b4Ie7dZkJiGgy5ml
         sznLVPKmqDYIl7xFQUg+3A8ZwEE0uX09cxIAsM2yuP8T06DgrhOqkZDeas8m3Z82HNqT
         J8Zdxt91/VMHP5FDlmydF1esVEdTdk4qa1J9NdPcN3GzLPBkuXei2n9T/WX/11aCKpzt
         d3lA==
X-Gm-Message-State: AOAM532pVsIoJUz6s/HzDeYkNQLKA+A1046FeDgAsgmDVnKko96oISnw
        1ifm6XeNyO0zRtQUpwCjHTlNebwyUQE=
X-Google-Smtp-Source: ABdhPJyevtmlqH1MdtEvbTRG4+iprYKWvuh0jEFDY7GOxBx+aUAJGHNQm6DbVDWB05k8If7J1uJWMw==
X-Received: by 2002:a62:37c6:: with SMTP id e189mr30263119pfa.207.1596045016859;
        Wed, 29 Jul 2020 10:50:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k12sm2788502pjp.38.2020.07.29.10.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:50:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] interconnect: Show bandwidth for disabled paths as zero in debugfs
Date:   Wed, 29 Jul 2020 10:50:12 -0700
Message-Id: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

For disabled paths the 'interconnect_summary' in debugfs currently shows
the orginally requested bandwidths. This is confusing, since the bandwidth
requests aren't active. Instead show the bandwidths for disabled
paths/requests as zero.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/interconnect/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 609e206bf598..3491175304d1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -55,12 +55,18 @@ static int icc_summary_show(struct seq_file *s, void *data)
 
 			icc_summary_show_one(s, n);
 			hlist_for_each_entry(r, &n->req_list, req_node) {
+				u32 avg_bw = 0, peak_bw = 0;
+
 				if (!r->dev)
 					continue;
 
+				if (r->enabled) {
+					avg_bw = r->avg_bw;
+					peak_bw = r->peak_bw;
+				}
+
 				seq_printf(s, "  %-27s %12u %12u %12u\n",
-					   dev_name(r->dev), r->tag, r->avg_bw,
-					   r->peak_bw);
+					   dev_name(r->dev), r->tag, avg_bw, peak_bw);
 			}
 		}
 	}
-- 
2.28.0.rc0.142.g3c755180ce-goog

