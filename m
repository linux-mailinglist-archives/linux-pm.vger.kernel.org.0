Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BAA12812A
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 18:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfLTRNO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 12:13:14 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33737 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLTRNO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 12:13:14 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so10168688wrq.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2019 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnU4xvfoNnMFHRMSFrsXcG1YgG1fyn/xauqN1cixU2I=;
        b=uYwyK2VtKQBp/NbuJmih9sxLppLZ6LHHB56L7qjb11pFtES/khKnUpWxpALlmCtVYp
         pmUQVraNEl5aowRXY8HqyZNdCi4v4LbGRsex6T3o1Xg39qtzJk7Y9v3VW/xx0F/pujK4
         exHrBOwT3H93AQRVHyQHL/gOoq0udEoM37PYXqoOJpKlD1PFbzw94NSWVlZYWdH+On1N
         iDnCf/0KlnBFKVlWv4DqAYnBEOVzKV4MklX+0seFQpxMmpTHXdPBUodW34ObneBcIjqv
         WmIw8turqV+UOsiThIS2tkpX8ouPcNxQulPAWbQ7bWJK7FQzK+t3a978irbB/Y8ASENU
         t9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnU4xvfoNnMFHRMSFrsXcG1YgG1fyn/xauqN1cixU2I=;
        b=Zko1W9mIW1DgHfg3p/hFTsk3GGwrlyFNxx7LtCnnI86ENmYbMdLn+bizvRNNtqXJx3
         ckbP27BVRRue/3QpMUsge22nZ4nRc5aFKpsh3rDeR/gc7ScQqXDL2SLmm+vXS0kXoqL3
         zz4Qe1xJCb+E524qjD2FzBZ1Af6vZvsxRbalGC2nBGk8mZcd/9s8mHgtAWsdzt4GxcnC
         n6Wi6Q/YvuCqRYo/9cvTSlryJ9QuytdO8QN1Sw1DL3tAY8K2iOJNKQSVRcxudqZyKbGa
         0gL3ijDIqrt6LRf4scjl6rrepKgpKav69Xlf/8POZQTbIfrds8EEoVU6uOTmLex7ia7l
         e3+w==
X-Gm-Message-State: APjAAAVBj+BqK/GnAs2EfwXo6BOzsJ+wyxw/4LLdIitSiDhpAbgrUOLg
        IR+wDBRcbZdw4pdRlYtYMQuHXN6fqEs=
X-Google-Smtp-Source: APXvYqxmxO9UFUF3xQfA5fp0bQKpI1PQbCxM6J/wAH6gpIdilo8iKFwjXyrtVbdIMu0087TFGHx0Rg==
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr16179218wrn.347.1576861992379;
        Fri, 20 Dec 2019 09:13:12 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k13sm10276085wrx.59.2019.12.20.09.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 09:13:11 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, georgi.djakov@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Check for valid path in icc_set_bw()
Date:   Fri, 20 Dec 2019 19:13:10 +0200
Message-Id: <20191220171310.24169-1-georgi.djakov@linaro.org>
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
 drivers/interconnect/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63c164264b73..14a6f7ade44a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -498,6 +498,11 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (!path || !path->num_nodes)
 		return 0;
 
+	if (IS_ERR(path)) {
+		pr_err("%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		return -EINVAL;
+	}
+
 	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
