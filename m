Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837416164F9
	for <lists+linux-pm@lfdr.de>; Wed,  2 Nov 2022 15:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiKBOV5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Nov 2022 10:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKBOVr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Nov 2022 10:21:47 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B8286E8
        for <linux-pm@vger.kernel.org>; Wed,  2 Nov 2022 07:21:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2079882pji.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Nov 2022 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tv0O8gGygG1cBg83m0a3ZlrLdLId5rS4r7Y8GfdODRk=;
        b=VO79yoByjD2Q5e2iSgycnz3i3HpEaRSS6ix4F4bKxqfLGvqBMmDvtIwMx5FBEDkPCN
         oopTAhVrUA/W50LH9tABBj9KYCbzwkB5rlNIJDRz31AlCHni5JlFIdwx7oj/BJsYKxMu
         tGtqxH+kxnsdWRIrxFOWQMQE2mukPOl+MEyLhV8l3Wegd8+naVz9cLEyvn2z6E/3X5wo
         221a3ShTSaNcdKeh8w1VgwO3iMAItlvztTAozbWWaw4GS8bQQZpcGnUMohyGsBSXDnvR
         8xkHeF7KX20K9N4nrV3NYcwctnPqIgtWFTnaFKqm59tx+9e2To1kYXns6hNTOOu4xyxt
         y2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv0O8gGygG1cBg83m0a3ZlrLdLId5rS4r7Y8GfdODRk=;
        b=e1o4lDxKUotepkn6b8sB95qoAX4B+Z8dXjlX0D1I4ni9wIQcyLpP84+l+2pTdeoyz+
         PEkEIlbzs8Q171WMTI5d+qN+W9LpW/2WHIFUmrt4F2ddwmBiiGrRP2rMP2P+5BRoyM1B
         YDzyH/z60xZ+NzNkxBqLnn73ypCt3cEroZvdLAD9FtTMqv9pWWjVJ0UclRuIRvWBuzHR
         5Rhhd+IcbIx+PPom1EJqZiHlWh1HXqEhUriQq7hZ/wF/ZsbCayeHrF1zzx2HxZnR29nD
         Yr8xxMqTN3Mx6kgDpA5bqXVMACQKfWuYZjBR42nqDYAv/3Gqc/nVoKkzL4+XTk54pCEO
         qf5g==
X-Gm-Message-State: ACrzQf3ZFUPEeMYLWbh/fhcW5K5V8bEK1/95OKUK3hpUnxGz1I5p6qYv
        LIczxhXI/INyfq/C9WOBxPc+Ew==
X-Google-Smtp-Source: AMsMyM4Et9Gwo+ZRf0lg2usVxIirtPv5Ba3yDqOT3Bbkxqbk8/jvKfYbKce69kcLxzji6TR5QW3lCw==
X-Received: by 2002:a17:903:244a:b0:187:10f1:9f91 with SMTP id l10-20020a170903244a00b0018710f19f91mr21657289pls.37.1667398902819;
        Wed, 02 Nov 2022 07:21:42 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id o28-20020aa7979c000000b0056b8181861esm8817773pfp.19.2022.11.02.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:21:42 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/4] Manage domain power state for hibernate
Date:   Wed,  2 Nov 2022 22:21:00 +0800
Message-Id: <20221102142104.2006554-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The series tries to fix a hardware lockup issue caused by missing domain
power state management from hibernate .freeze[thaw]_noirq hooks.  The
detailed description of the issue can be found in commit log of patch #4.

Changes for v3:
- Add one patch to drop genpd status manipulation for hibernate restore
- Add Ulf's Reviewed-by tag (Thanks Ulf!)

Changes for v2:
- Fix kernel doc of genpd_finish_resume() to use the new function name

Shawn Guo (4):
  PM: domains: Drop genpd status manipulation for hibernate restore
  PM: domains: Pass generic PM noirq hooks to genpd_finish_suspend()
  PM: domains: Consolidate genpd_restore_noirq() and
    genpd_resume_noirq()
  PM: domains: Power off[on] domain in hibernate .freeze[thaw]_noirq
    hook

 drivers/base/power/domain.c | 114 ++++++++++++------------------------
 1 file changed, 36 insertions(+), 78 deletions(-)

-- 
2.25.1

