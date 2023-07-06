Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70467493FE
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jul 2023 05:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjGFDGd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jul 2023 23:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjGFDG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2023 23:06:29 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909711BCD
        for <linux-pm@vger.kernel.org>; Wed,  5 Jul 2023 20:06:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6687466137bso247377b3a.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Jul 2023 20:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688612785; x=1691204785;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99rLLs4Jp9MCNeQLMP7yzims2WyoJRlW8GyAoOBPdRE=;
        b=DQzN8sQN/PaSjDYG+l3ruz8n7BxH21WYyyAlBrmbriGKybP3RCBFVWaWBXLg9IlqXv
         uIXu84E+ipHxS9/93wdfcBdGg9WdvrhE2pB/EvlcS1GeEVCDVHVHPLTVV+lBRkIkhVoc
         RhHgXHPO8io/W8sY38ME1/lCcOVGPrzDeYHcm1BXoHpZYUmEEMmqCcnSsan/Fla5vsGS
         d8PFpsf2vCKDrHtrew0qfuJMzgR8JhLg3KfnaHQ38jKoSM70H8nELskCOcXsY0hsQmHC
         YGQoFUawwdauNfCE3KEB97O5VPfTlUis/QAUZV1f11Dg8pDeRVY2eIaw5uYJB6FTSdB4
         /QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688612785; x=1691204785;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99rLLs4Jp9MCNeQLMP7yzims2WyoJRlW8GyAoOBPdRE=;
        b=XVZFaZseTlCqFr6eQEmcapJ46xIM78Y3GEbAmkhscNC11pKuLuAM9r99fdAnJP1iMn
         oCS4rR3UsAUVt0Ut8+QXzrB8ziKp+9ttNz1Cp7WIMUaK74qU2P3IdwFVxc+M6CauNi2K
         PNEMulQ8+/hVrzL8aLvbvLXyMyeuhHIHoEoUSOI88vkel8c5xvTB5GMgcbTk3UiVEAXr
         x1fLk6hVe72QeAJ2E8uN+9tjV23nadTAGfHgt6T1y6SW488rynlRPL3HvjO0Zt8Wkguz
         pUzE+rXzruul8mMPTvCr6H3PvtXCKb55gyBTo/lT0eqHO9/DBPUr71y95XOiDmrHspAY
         eJHw==
X-Gm-Message-State: ABy/qLa6jZNJcxu+zt041mzA1IdMrmsDRcEtuOckizkVx4qC4XR2E65g
        WwtcVTN1WAxIKIF8h1mxCPn4TQ==
X-Google-Smtp-Source: APBJJlHOZPK7P19lXlINFr/Dqp79j8rxfnvTDK3ZVvTCnOzJbys8o8pl2d+qk/AQLF7RxsZlOMrG0A==
X-Received: by 2002:a05:6a00:2ea3:b0:682:95ab:32f with SMTP id fd35-20020a056a002ea300b0068295ab032fmr587148pfb.1.1688612784886;
        Wed, 05 Jul 2023 20:06:24 -0700 (PDT)
Received: from google.com (41.183.143.34.bc.googleusercontent.com. [34.143.183.41])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78294000000b0066e7a540ea5sm197156pfm.205.2023.07.05.20.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 20:06:24 -0700 (PDT)
Date:   Thu, 6 Jul 2023 08:36:14 +0530
From:   Ajay Agarwal <ajayagarwal@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     linux-pm@vger.kernel.org, manugautam@google.com,
        mshavit@google.com, quangh@google.com
Subject: Prevent PM suspend from powering off the domain for non-wakeup
 in-use devices
Message-ID: <ZKYvpgs6p3S7nglh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Linux PM experts
I have a question on PM domain. As per the current PM domain driver design, the genpd_finish_suspend turns OFF a power domain if it is not already turned OFF by runtime suspend.

I have a usecase of a device having to stay ON during system suspend. This device will be used by a co-processor which is running its own OS. Thereby, it requires the power domain to stay turned ON, so genpd_finish_suspend should not be powering down the domain.

I studied the code and found the flag `GENPD_FLAG_ACTIVE_WAKEUP` which can be set for the power domain. And device_set_wakeup_path can be invoked in the suspend() callback of the device. Together, these will prevent the genpd_finish_suspend from turning OFF the domain. See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/domain.c#n1260

But this flag is really intended to be used for devices which are capable of waking up the system from PM suspend. But my usecase does not involve a scenario of the device potentially waking up the system, it just needs to stay powered for the co-processor to be able to use it.

Can you suggest if I should go ahead with using the existing framework of `GENPD_FLAG_ACTIVE_WAKEUP`? Or add a new flag, say `GENPD_FLAG_RPM_ONLY` for this scenario?

Thanks
Ajay
