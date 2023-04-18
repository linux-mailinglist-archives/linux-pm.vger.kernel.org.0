Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F0B6E5D35
	for <lists+linux-pm@lfdr.de>; Tue, 18 Apr 2023 11:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjDRJUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Apr 2023 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjDRJUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Apr 2023 05:20:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ADBE49
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 02:20:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so1590116b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2023 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681809599; x=1684401599;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nE+ToeXo/y5QrdGrRhkz+0lI+sZ0yLLTzEiwKJvVFz8=;
        b=PGA+FEYVWtl77f3zOHjYMRz717VpYLxPyfld4+3Z6XiYL4M0y6yFWsf/h5VbR2o+Kv
         UiBYvJguWJ9XgncjTlUtrQTksLXw0ze+M9Y4R5iQRF4SyocoFiV8XfnnH3J/7qMR2D0v
         nGg2iXbTCIvHBr1qohioGwtrzjWr1QueLakDMTrVCJemHaSbsYRjbQlxbQuW28ciDkKC
         lRmEupAZrcMjD98nYICvRZ4oIhZzuQKhMBcdFOFat6bCGgEe+FzooEnwzlNrvWabsDIz
         xBPqoYjgCb+X2I9c+dNGYgyhoF3/jyZh0qh+bbt4TnN1cnd57tEH1Um016AwcfM+FdW7
         lzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681809599; x=1684401599;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nE+ToeXo/y5QrdGrRhkz+0lI+sZ0yLLTzEiwKJvVFz8=;
        b=CvZ69AlmQPYKyvT+kcRbAianH2uhhkDeaLkJrFvUjBb+y4VWuq7vLC6HHYwWdwcZDq
         zYKUCFjkjcCgmrRH+WuHLj0NCiqsw+TW8qBgSKjuTfODjXjsOdyWlY6yNz+UmKQRL+nS
         uA0pmRqW/yShsBgZF4KhVnIvLC8UVD61Uq5NyKOn7dbc1O5gTID9tuXDCfvRS6dK9auI
         2RqOFX97jraMkH+pavtLmNzBcQBksKDLfHqstwJ1CZ4eU7SVnVPMf7Hqaa66RWpAjF9M
         XX6+vLJrpu5AMDbZr29o9eMrWOWOCWooAgTZrmzBN1jP3bg+OjgXPQIHraJA2Zl3N/Z7
         IK7g==
X-Gm-Message-State: AAQBX9cWIuUx4ZQhWRhROdZBOMi29kNjwFoE48YStEyfDJZ36HvJuQ2H
        4Q3x17lfk2OOjL0abvsaaam7gw==
X-Google-Smtp-Source: AKy350bDrCERgFDMwiZpncAk/g+DAKiOIyXEjKBngx0cnMoB67T3aSF5w6x5vSqACqAzgXDr45IJZw==
X-Received: by 2002:a05:6a00:1589:b0:639:9089:798e with SMTP id u9-20020a056a00158900b006399089798emr24241527pfk.19.1681809599680;
        Tue, 18 Apr 2023 02:19:59 -0700 (PDT)
Received: from localhost ([122.172.85.8])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm7244020pfn.11.2023.04.18.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 02:19:59 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:49:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.4
Message-ID: <20230418091957.5e7sopmiaoa4fw2r@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.4

for you to fetch changes up to 528f2d8d540a3c374d6b765c769620d91536b176:

  OPP: Move required opps configuration to specialized callback (2023-04-03 09:45:09 +0530)

----------------------------------------------------------------
OPP updates for 6.4

- Use of_property_present() for testing DT property presence (Rob
  Herring).

- Add set_required_opps() callback to the 'struct opp_table', to make
  the code paths cleaner (Viresh Kumar).

----------------------------------------------------------------
Rob Herring (1):
      opp: Use of_property_present() for testing DT property presence

Viresh Kumar (2):
      OPP: Handle all genpd cases together in _set_required_opps()
      OPP: Move required opps configuration to specialized callback

 drivers/opp/core.c | 78 ++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 drivers/opp/of.c   |  7 +++++--
 drivers/opp/opp.h  |  4 ++++
 3 files changed, 53 insertions(+), 36 deletions(-)

-- 
viresh
