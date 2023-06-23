Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9073BC1E
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjFWPyb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 11:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjFWPya (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 11:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25C52703
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687535632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RqBYL4rToudmasXW3rSZav1ahfNpM2ZL3pnL4m6T3fk=;
        b=S4G1Bl8dn7IQoaWMVgpKV8JxvO99HCJEv0N58PT7p9MoPJqyuI3IAoDfrpxFl5B7pTGCpi
        Ukj8vw0Njxir4gW+D40w7cBhRQdI9unkqKHO6Nr26dzPWyVDsWsWNnwIuF8Ryb+h8ZTUKc
        xA5wXRzNutKGEtpF+/UrW1A1kjxr8P4=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-Z256BIuoMT2ebkplz3KLQw-1; Fri, 23 Jun 2023 11:53:50 -0400
X-MC-Unique: Z256BIuoMT2ebkplz3KLQw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1a6bb99c9e5so657478fac.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 08:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687535629; x=1690127629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqBYL4rToudmasXW3rSZav1ahfNpM2ZL3pnL4m6T3fk=;
        b=en2fq2eE0q4GAau99pSCp6Wg12UDOMC+Yzbj2zBK4tAMSXzhfbafKS81w+A+MfVq1q
         Za/m7a8z6nEfSuhpHXXtFFNAh82r9LjC8jnaDpGZsCtZEhmsN2mUna5i6f8ia+uQZNTf
         M/2jUbqj3eycPMLNU+r6SpYvfzFcIDfI+gBkvlzGmyE4ce7iLtjcbGZl0Xa3pHPRDQbh
         RDBCv7rHn39aoaobB7VHWPJgisZ3y8uYDjmfdfFULf8A5y8ceEJ1Vv1jKnvUOdnvOFyV
         1roJSvwUGxkV8qbr9kxXDI5VI1ugvhN6pQPLNHBw38lFaN6MAcrKzwevK72OlpePCrRv
         R90A==
X-Gm-Message-State: AC+VfDwpOclGVms0CoeiqYyMPOewAhqlKPhmQ7/A0SQu74e2t8tzo9fV
        HvwjsKZY8dvebXvK2w6IRDJhj46QQ8Fn6OHz5iH1Pa3QwpMmeFDLx6Bm2rbm9NA98fr0ZxzRV2S
        kgkO1rTh9JX7L9igRIyQ=
X-Received: by 2002:a05:6870:7697:b0:1aa:220a:fc8 with SMTP id dx23-20020a056870769700b001aa220a0fc8mr12850283oab.19.1687535629276;
        Fri, 23 Jun 2023 08:53:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OJxGzvpc9x7SWvoFKtgYKlGMCHE6h1elLRYqUWtvbebfX2mgZRlXrHUXkT2nBaDs9/5MbyA==
X-Received: by 2002:a05:6870:7697:b0:1aa:220a:fc8 with SMTP id dx23-20020a056870769700b001aa220a0fc8mr12850274oab.19.1687535629003;
        Fri, 23 Jun 2023 08:53:49 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id a5-20020a056808098500b003a0598f7d12sm1955054oic.21.2023.06.23.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:53:48 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com,
        vireshk@kernel.org, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] OPP: Use dev_err_probe() when failing to get icc_path
Date:   Fri, 23 Jun 2023 10:53:38 -0500
Message-Id: <20230623155338.943655-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This, in tandem with dynamic debug, can print useful information about
-EPROBE_DEFFER like below, and keeps similar behavior for other errors:

    [   16.561072] cpu cpu0: error -EPROBE_DEFER: dev_pm_opp_of_find_icc_paths: Unable to get path0
    [   16.575777] platform 18591000.cpufreq: deferred probe pending

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/opp/of.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index e6d1155d0990..1f0923cc1cd9 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -513,11 +513,7 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 	for (i = 0; i < num_paths; i++) {
 		paths[i] = of_icc_get_by_index(dev, i);
 		if (IS_ERR(paths[i])) {
-			ret = PTR_ERR(paths[i]);
-			if (ret != -EPROBE_DEFER) {
-				dev_err(dev, "%s: Unable to get path%d: %d\n",
-					__func__, i, ret);
-			}
+			ret = dev_err_probe(dev, ret, "%s: Unable to get path%d\n", __func__, i);
 			goto err;
 		}
 	}
-- 
2.40.1

