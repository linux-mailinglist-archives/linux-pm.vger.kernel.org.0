Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C198A34D001
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhC2MYt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 08:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhC2MYr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 08:24:47 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBFCC061574
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 05:24:46 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id y2so9072395qtw.13
        for <linux-pm@vger.kernel.org>; Mon, 29 Mar 2021 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B6IbhuxtYBidhaB+ByBwL1xwk2t2d4wdz49zsKjdjSo=;
        b=ueLciToiKDWqFKG63wIYCIzlOd06JBjzqCjsPxrrry2milFaHRB9LGy27pexD3JSLc
         283fzwEiEjHhCM3t5iOgKIIB+3AHKM5g+LLGyj4KCReJKx745kE3xSXaSedQecp40lZ2
         rKESCH/fSVovSxuGbvJjFFX5MD/VA9QGNxw0KquSjcg8/eq4P7C7Vqo/ZsR9CFDJVTeQ
         tyQWOKix83vTihW42fSIxUCU0j6uPGy9YPDH3kxxg6a0AK+LI70uJsexixrluvRVuz4V
         pi9/4VHg/cWFLVi54HQBkbrfjJGCCS8lebzvFObnfN0dwSLctt1nMKQJoLzCEa7HPn7O
         IloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B6IbhuxtYBidhaB+ByBwL1xwk2t2d4wdz49zsKjdjSo=;
        b=ZfNQZkZ9S2u71x1vWWgtvWKioFgQTQTSBSAqDJgcWIKdSYW3mXrS4hGVEy1UOjonxa
         0yicPM8utuWVr3+9VAkgDoLm3FiykFw7GuxIGmpQFRxWUBsFKrjT4tHsGO7jfvHSDmxx
         e1lNlSPIwIo33d2MCe74Lo0/aNl1fnYxUxDsHRxR9t/Z5+EYgH3HqUWcfM05+IAAnEx6
         yHelER6p4a34L4L3Lz8M2i83VHSjMtNBeEzST6WKaT4dRICVNTrRNAoLwQzLWPB8cF+Z
         fS1a5RtXAS6xug/VrnFjmDlYeDWjJS2qpW/2AswF6Ra+V5j7qCT9EvwCF0RcnQwaGent
         nAxw==
X-Gm-Message-State: AOAM530pcVWG4kkjiJISOc/jyp6oc73AFHEAPFauY18rdM43j+h0KziH
        N6Cz0TZlpBrcgc86dEKGr3g=
X-Google-Smtp-Source: ABdhPJxL7McLbQXdZ4EmesAHdMfS69I+aGb/iT4+srRPZCDvt9SNRu1GfXgkWIQ9tqTPJTHzvBNeaQ==
X-Received: by 2002:ac8:6c4a:: with SMTP id z10mr22002927qtu.229.1617020686153;
        Mon, 29 Mar 2021 05:24:46 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:919:7898:56c:200:f2a5])
        by smtp.gmail.com with ESMTPSA id s13sm13246877qkg.17.2021.03.29.05.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:24:45 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     cw00.choi@samsung.com
Cc:     linux-imx@nxp.com, linux-pm@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] PM / devfreq: imx8m-ddrc: Remove unneeded of_match_ptr()
Date:   Mon, 29 Mar 2021 09:24:25 -0300
Message-Id: <20210329122425.579386-2-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210329122425.579386-1-festevam@gmail.com>
References: <20210329122425.579386-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX is a DT-only platform, so of_match_ptr() can be safely
removed.

Remove the unneeded of_match_ptr(). 

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/devfreq/imx8m-ddrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
index ecb9375aa877..16636973eb10 100644
--- a/drivers/devfreq/imx8m-ddrc.c
+++ b/drivers/devfreq/imx8m-ddrc.c
@@ -447,7 +447,7 @@ static struct platform_driver imx8m_ddrc_platdrv = {
 	.probe		= imx8m_ddrc_probe,
 	.driver = {
 		.name	= "imx8m-ddrc-devfreq",
-		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
+		.of_match_table = imx8m_ddrc_of_match,
 	},
 };
 module_platform_driver(imx8m_ddrc_platdrv);
-- 
2.25.1

