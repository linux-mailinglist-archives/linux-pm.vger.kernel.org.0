Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4873E109
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jun 2023 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFZNuv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jun 2023 09:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjFZNuu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jun 2023 09:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5008497
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687787405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7RchIzLEFr49hSDoEPp8rxOvgg/jdjjvX3M5T7yGIGQ=;
        b=Lmrlnj2Ta/7BZUZMnCEOgZUQUmBUBKTLXd6amyHaHDb4a6olJ+qcxyKrjtxoqxjp4+jFJa
        T8Kfe6xWph3Z2yN7sPPKU01MVg1xiUK+Rc8WqOjdKoxZEOAKqzAG5oqSq1zxUfXL7fK0jq
        nuBoF05TGWeY064z8yZRuU/HRueHQ4w=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-78MNjWivOdaTPgE5KkY58Q-1; Mon, 26 Jun 2023 09:50:03 -0400
X-MC-Unique: 78MNjWivOdaTPgE5KkY58Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-573cacf4804so44192197b3.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jun 2023 06:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787403; x=1690379403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RchIzLEFr49hSDoEPp8rxOvgg/jdjjvX3M5T7yGIGQ=;
        b=KtPlQXPkAZD8noTBBG/2OYwDDZgjUhH0h/yTWrTaIqnubakIwjLz3TYoxlzzAg/3p2
         CL8f8cbwkDwSvi5CRoj0+sHqVA90lKsIfeigvn4rKCtEKVPZuy8X4EFdp6m/raHgkUy8
         T/uwU5tNa28LFCyToLY9mu1GqFLBS5HLYO1mD8phHD+tATx0m82j2xag4yTAUzcGIYQb
         2Caulh9u3jXjSbQM8Xc+OhCn0giAptx59ESCMb+HlIuzo59RRxnqbDRujLmhx5Rn9Ola
         CYRwjd/POCcQlpX7gotdtQs/pUtjBrfW0DgOQo6QpDAMaoPDWknhenF8wY+6/oPNCiXA
         5GXw==
X-Gm-Message-State: AC+VfDw/pfFhcPULQw8JyJFooVzb7hilNpedAFwm6Mq8UG2Z3ZhETLt0
        9PTc6xtYTku6ttiiXXrRzDN2+RemiDaxGmzIYa7JDutGaTBhZRWDZeq6w/WpL8+LdpcnCyduWal
        hZ/404Q0wadbMGjJ3Q+A=
X-Received: by 2002:a0d:f187:0:b0:573:bb84:737c with SMTP id a129-20020a0df187000000b00573bb84737cmr13040315ywf.26.1687787403048;
        Mon, 26 Jun 2023 06:50:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RZ5OK0Ds/pNf7+Fd6FJVJmf1ymc+daX8VibeE26jNxRg2COtxHdJPdXhdLdiPptCHMdDibw==
X-Received: by 2002:a0d:f187:0:b0:573:bb84:737c with SMTP id a129-20020a0df187000000b00573bb84737cmr13040296ywf.26.1687787402730;
        Mon, 26 Jun 2023 06:50:02 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id p64-20020a817443000000b0056d1c26f5b0sm1290844ywc.21.2023.06.26.06.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 06:50:01 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, sboyd@kernel.org, nm@ti.com,
        vireshk@kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] OPP: Properly propagate error along when failing to get icc_path
Date:   Mon, 26 Jun 2023 08:46:46 -0500
Message-Id: <20230626134645.57902-1-ahalaney@redhat.com>
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

fa155f4f8348 ("OPP: Use dev_err_probe() when failing to get icc_path")
failed to actually use the error it was trying to log:

    smatch warnings:
    drivers/opp/of.c:516 dev_pm_opp_of_find_icc_paths() warn: passing zero to 'dev_err_probe'

Make sure to use the right error and pass it along.

Fixes: fa155f4f8348 ("OPP: Use dev_err_probe() when failing to get icc_path")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202306262008.guNLgjt6-lkp@intel.com/
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---

This slip up was totally my fault, apologies. I've got a "dirty"
working tree (where I made this enhancement while debugging) and a clean
tree for submitting patches along the way. It looks like I made a slight
change in the patch that was sent in the clean tree, then rebuilt and
tested the dirty tree and sent it off.

Won't happen again, embarrassed to admit I sent a patch that was not
properly tested but oh well. Here's a fix.

Thanks,
Andrew

 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 1f0923cc1cd9..ada4963c7cfa 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -513,7 +513,7 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
 	for (i = 0; i < num_paths; i++) {
 		paths[i] = of_icc_get_by_index(dev, i);
 		if (IS_ERR(paths[i])) {
-			ret = dev_err_probe(dev, ret, "%s: Unable to get path%d\n", __func__, i);
+			ret = dev_err_probe(dev, PTR_ERR(paths[i]), "%s: Unable to get path%d\n", __func__, i);
 			goto err;
 		}
 	}
-- 
2.40.1

