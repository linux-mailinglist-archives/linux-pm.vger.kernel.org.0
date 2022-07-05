Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FEB56633D
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 08:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiGEGhs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 02:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGEGhs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 02:37:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9011149
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 23:37:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i17so1136063pfk.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 23:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNhUefXI/iA3aUgQJKA6BpzZ+eBCreA9KdOWYZIzvwE=;
        b=gouLVLUTBtOAK1J9D3xGdrEnD0pR9cPvx6fdq/lISiRdPiWt2MTxEWos95Rox3mwlq
         R0YCX8SkPCieQipmuih9GzXzui1xD+0N62XnGnaUgpTMcZzcjXQhGMJjWSXpmmT4YWE8
         rsAzDG6d9Zz/VjwSajrEbdYDJM6cPxW1KNbZg0zooAjxun5uF/ziTsVwG+Ii53/ZWj/6
         EF8j+RudU0oYZGzmpNJr1COLXii+SlE14qSN9R66C8JlcQn7pGdxGtCcA8j3juc5BQ9E
         q7y1RIzjMHUSBAJqk1QOyOpZKIgN9b76qNmTEb9igVLRiEFO2g4asfcTq9einh7ESgv0
         oexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NNhUefXI/iA3aUgQJKA6BpzZ+eBCreA9KdOWYZIzvwE=;
        b=dUfGsqtjbUKKURWu0+W2r9Gjog0/kbjXeg4fifn5pXfzR3e3Md9Xe9ol32yN3BYN6t
         35REZYf2xwEnUcPPslzfsG+bT1bec/kdfYltQKu8VPBBmhiSZSwyRrAPu6rFyuneNBDX
         se7aw0LeqiujxK3GZrS0q5/bARFMwAi0cCoM6x1zhBYjrHUbVSdfG71EkswaCy1tW3f8
         mAigau6U76/UqqvOW6u79afDvX2LNDBM/v4GYiOi4xAAsSfrq4XSElGlyRPI9bGf0l1b
         UvZxu5KIcxtTZB58e6QMf080BLhGp5R4x9Tm853INqhznV3zvzMDIx4Ty3suUq/53Fls
         bdNQ==
X-Gm-Message-State: AJIora+9h+Jt/Vr0hcX1jhiJXy9HdQCk5dQNv/pRk2g017RblJ+fs6AZ
        y7edXFzMBT0C+itp8IkvoqXvLQ==
X-Google-Smtp-Source: AGRyM1u+KARsThTIfoLh7SHM6OcjktYxhqmwE69N7nJkhjmsyZ4ZL8r0EATbuEClYRy4qLEMyr7Yew==
X-Received: by 2002:a63:5a1e:0:b0:411:f24a:a78 with SMTP id o30-20020a635a1e000000b00411f24a0a78mr17072357pgb.519.1657003066271;
        Mon, 04 Jul 2022 23:37:46 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902cf0900b0016beea47800sm1320317plg.41.2022.07.04.23.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:37:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] OPP: Make ceil/floor/exact helpers share code
Date:   Tue,  5 Jul 2022 12:07:36 +0530
Message-Id: <cover.1657002904.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

All helpers of type ceil/floor/exact do pretty much the same thing. Rewrite them
in order to reduce code redundancy.

Tested the freq based routines on Hikey platform, works as expected.

This is rebased over other recent OPP changes and is pushed here:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

V1->V2:
- Don't cast unsigned int * to unsigned long *.
- Rearrange into 4 patches instead of 5.
- Move back to 80 column width.
- New tags.

--
Viresh

Viresh Kumar (4):
  OPP: Remove dev_pm_opp_find_freq_ceil_by_volt()
  OPP: Add generic key finding helpers and use them for freq APIs
  OPP: Use generic key finding helpers for level key
  OPP: Use generic key finding helpers for bandwidth key

 drivers/opp/core.c     | 429 +++++++++++++++--------------------------
 include/linux/pm_opp.h |   8 -
 2 files changed, 155 insertions(+), 282 deletions(-)

-- 
2.31.1.272.g89b43f80a514

