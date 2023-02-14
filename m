Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798A695895
	for <lists+linux-pm@lfdr.de>; Tue, 14 Feb 2023 06:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBNFim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Feb 2023 00:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNFil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Feb 2023 00:38:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135ACBBBB
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 21:38:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id bx22so14056517pjb.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Feb 2023 21:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nv4r3vS4RW8bUctypTbEN5D4BD/Zbkb/lXJjvWehqa0=;
        b=FCU7iY3tZI5lgY31eZCU66RWm8/4qhJBskgxfELGnPXava2WmR/Qp2jknEe7RocR7J
         gRlCXrONB+h2TQR1601IHa3mCKN5lmIdh3i6fTLT0cNMrrWtYjebv6yP5KpZCvqRbCrm
         a9mBsuAavxVvFrq3Oq5ktO9JbEeaz8LXTm/trvRR3esnMdR/fSKnwM9k+LZ5oy9eQXcL
         SlEEG/VhwpAUwxwDeo6fBj6A4TZ4GqYdIRP3HM8iJACziGqfHuKq1CMY5c5XpD7kdmUa
         syUztZRdxxNp2na0FV3cTOYVegRxl6+ffbNvJr8y2wqHhyEg+94uhoamxWot1hEgfaii
         dFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nv4r3vS4RW8bUctypTbEN5D4BD/Zbkb/lXJjvWehqa0=;
        b=UR+qnU3ba63FjmBxvL3BFs7rLYoPHI5FCyxSvT9NdSqdARddSa7t0BUFPE0/f6PuUp
         o0pxBOLmYKjyhTBE6InltaXqPZjobED6xCbF+UZGPfm08Ja++eT7L8nCI9KW9oIkQ9az
         TJkqtJ/+zXzZyKX+QWrf526unW+eHJ6rYgEfIE7P+bTgyGvsX8hseJ07PfF1hfZ/lQYj
         /fuJOm7wZZZYhgKm0boGB3oNxI2RYNTG2CNIWw04bsersAK9LaSrnfqd8oqxOh8VhxPw
         nVRufVdDd615Lfuw3JHxf4RCcjLPj8wQtF22UAa5fZUvP/fbolGo8nkN0jPlLKaE9Ftk
         i5DQ==
X-Gm-Message-State: AO0yUKVccu+4aVPaP5HJoG614+datxXN0zggDURBkVliZ5dwOj3IriJO
        CX37OpKHlPp+X/1bkLqOOViN4LmX2PPxgNdS
X-Google-Smtp-Source: AK7set8HGy/TTa+dskU+LzcmP8sP+mgArCTdYqDQ+mZiWgI8JsZlC7zGBdBdlWBF0iHLpKpwh+5Qww==
X-Received: by 2002:a17:902:d2c5:b0:19a:586c:2b81 with SMTP id n5-20020a170902d2c500b0019a586c2b81mr1602559plc.40.1676353120621;
        Mon, 13 Feb 2023 21:38:40 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id f3-20020a170902ab8300b0019607aeda8bsm9175305plr.73.2023.02.13.21.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:38:40 -0800 (PST)
Date:   Tue, 14 Feb 2023 11:08:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.3
Message-ID: <20230214053838.5tyq375sxbrprque@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.3

for you to fetch changes up to eca4c0eea53432ec4b711b2a8ad282cbad231b4f:

  OPP: fix error checking in opp_migrate_dentry() (2023-02-08 10:40:59 +0530)

----------------------------------------------------------------
OPP updates for 6.3

- Add missing 'cache-unified' property in example for kryo OPP bindings
  (Rob Herring).

- Fix error checking in opp_migrate_dentry() (Qi Zheng).

- Remove "select SRCU" (Paul E. McKenney).

- Let qcom,opp-fuse-level be a 2-long array for qcom SoCs (Konrad
  Dybcio).

----------------------------------------------------------------
Konrad Dybcio (1):
      dt-bindings: opp: v2-qcom-level: Let qcom,opp-fuse-level be a 2-long array

Paul E. McKenney (1):
      drivers/opp: Remove "select SRCU"

Qi Zheng (1):
      OPP: fix error checking in opp_migrate_dentry()

Rob Herring (1):
      dt-bindings: opp: opp-v2-kryo-cpu: Add missing 'cache-unified' property in example

 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 2 ++
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 4 +++-
 drivers/opp/Kconfig                                          | 1 -
 drivers/opp/debugfs.c                                        | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
viresh
