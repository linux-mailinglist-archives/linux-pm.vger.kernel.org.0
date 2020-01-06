Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A79581316B5
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 18:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFR1r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 12:27:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45137 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgAFR1q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 12:27:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so50514839wrj.12
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA5OqXkB3++UqCw3nWhtcdXsiHuPwWe3zZsMrY+R6g0=;
        b=jzpuGAHB6DfsAm0+WuzL4ucBxTHVpKeYsWix/3HqlDl/edJ/k1pa7eKLvJPg1I9b5x
         /KRJ3qh4H/O+NGKjY/7bQM9LmELJTS3ZIIyxXp/lhVPeODk3JK5r3WQa91+3foXpUdLf
         kI+io8ZjBwrS6qmYGu5Bqw/fNNCwnnDauNCl5moVv8JmjzLmt0lza/L/gKo6PH/vk/0n
         FPpAwtDPxch0nChyvNUxMOR7KlcEcV6Y61WGG9mrzWa/Qib7Lm+OSwOGB+/atVUdA3F/
         mmNtHZwldHU0b7JiBcme5V3ekCtC7hdEPmKxijaiYc5UheEkoqMMWgDLprFv0kjyHBpO
         Za2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA5OqXkB3++UqCw3nWhtcdXsiHuPwWe3zZsMrY+R6g0=;
        b=Yt1xAB7UtL0jmfroMiUtjjDcEqQ0LlqmQGqA0QH9CqhuL31iBr3Lrh/6gQcLVqpQOV
         0Q9rjYynPKNr1qGePWjlNBaXpcmAv6Fjb32wCkJllIHSnHUidtMYcBbE3Mx9NPoQUQPe
         AUdrCE/WPSfayJT6W+ewqXm4fqzlL6iaiCHj0RVte2wYbbqH6hm1BAl271pzeLntaJvM
         H1NhV/xuiQC6+3z1tkQfg8ch1/h88ZtCJuwbfWygQYpzZ1YNc+wmf42KeActylfgutAt
         wD+BymbiPDjK9hy8cTA6Xq2BFiBe1j1z4YX2sU9MYE04T9AYxXhJRy3hQUu0fVmlBQ4M
         zIzg==
X-Gm-Message-State: APjAAAWAblbFDD003Idjo2LPhh4h4P3gB5+uS1udh9RxJd2e3OV1QdP0
        V3Q8qppAF5In7aRPF3ff/NtvDQ7axbw=
X-Google-Smtp-Source: APXvYqxvtLdAzA4Euyn71p/fPtmaNI3o9qzBh3vLsIJoUiDtgviZd1Out3FTo5PZH5A0cZazGSBx0g==
X-Received: by 2002:a05:6000:f:: with SMTP id h15mr98382623wrx.90.1578331664634;
        Mon, 06 Jan 2020 09:27:44 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id z187sm23725757wme.16.2020.01.06.09.27.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jan 2020 09:27:44 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, georgi.djakov@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] interconnect: Check for valid path in icc_set_bw()
Date:   Mon,  6 Jan 2020 19:27:46 +0200
Message-Id: <20200106172746.19803-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2:
- Use WARN_ON() instead of pr_err() (Bjorn)

 drivers/interconnect/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63c164264b73..d2ba5ae7d25b 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -495,9 +495,12 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	size_t i;
 	int ret;
 
-	if (!path || !path->num_nodes)
+	if (!path)
 		return 0;
 
+	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
+		return -EINVAL;
+
 	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
