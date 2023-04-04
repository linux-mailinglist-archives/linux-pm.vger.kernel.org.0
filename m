Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F7A6D5592
	for <lists+linux-pm@lfdr.de>; Tue,  4 Apr 2023 02:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjDDAec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Apr 2023 20:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjDDAeb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2023 20:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B02211B
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2023 17:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680568423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HCMKpUEBBb41wumrKRtFt3l4UFUDKQm0e5vMvIDSbHw=;
        b=A7Txrsh0JOtH0Lb/G5Nep8CFf1Q2K7a0zPbfZmg8zDFUNbwb9e0KtJvDWzrenwUVzvyPD2
        elHPtiftH17IvAV8Ix0xOEnxImVcm3GGSherYO+mUke8hrMRrsWrZPNZ+1gXmqR3GISJu/
        cLd62XmyZInK4LLBk+NOcfNAOryPyFQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-ERHLueO5MjSjC3EnOvQiXA-1; Mon, 03 Apr 2023 20:33:40 -0400
X-MC-Unique: ERHLueO5MjSjC3EnOvQiXA-1
Received: by mail-qk1-f198.google.com with SMTP id t23-20020a374617000000b0074a4dba4b5aso1329193qka.16
        for <linux-pm@vger.kernel.org>; Mon, 03 Apr 2023 17:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680568420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCMKpUEBBb41wumrKRtFt3l4UFUDKQm0e5vMvIDSbHw=;
        b=IbPAInDQKHDqQ4KowG/A7JwQ1oV/Bg3BnZglN/xZo7SRXxnAIj7BfGmDTEWF21X1DZ
         696XUigJxPq4Sd7LLeTM4zLpbxg2yB14ORGbYFGOAlqXqK28irf2aXWYMmI7ODM3v9B1
         vjj/uLGwzsaVQNTghPjDeGsOVSR95ebnjgKy7bhGSwLuc+fOXw2qQaR/jJClt/VjH3To
         Lz/NYTfqIyq+pp8PfVknrblatjJht/mQRmoTQoWf71RxHDQ4feATlg25mjmyOGkhpOoE
         /qGtcWmo7yxcxWjr/IUwGA65KxJnJuQ1KhZ++pX1QRIfAA/YCrN5LIiAK1hQ5q+OLzsd
         X2XQ==
X-Gm-Message-State: AAQBX9fYr2aUqeJy9msh0drFjGjn4h3/Jkm7QdA7KTOFlwsmdbAHPfAv
        rZVMmTSbOrmxl7vldCB8/Wkt/+hBS2uP7fnIvTJmcQEZiIEZKps7jd7D+8vhv9N8uYbuEpVzvpX
        GDcKAfUrL4FSmOvPwCo8=
X-Received: by 2002:a05:6214:c4d:b0:5ad:c532:67e6 with SMTP id r13-20020a0562140c4d00b005adc53267e6mr1092103qvj.42.1680568419885;
        Mon, 03 Apr 2023 17:33:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlsnwoS/IsQsObFTXFkOS6WrQ4JfYBiqEJugHfljD3oCZexxoqhGjadhA+cFVWghQwgzJIzQ==
X-Received: by 2002:a05:6214:c4d:b0:5ad:c532:67e6 with SMTP id r13-20020a0562140c4d00b005adc53267e6mr1092076qvj.42.1680568419614;
        Mon, 03 Apr 2023 17:33:39 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q10-20020a0ce9ca000000b005dd8b93457csm3006035qvo.20.2023.04.03.17.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 17:33:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     ray.huang@amd.com, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cpufreq: amd-pstate: set varaiable mode_state_machine storage-class-specifier to static
Date:   Mon,  3 Apr 2023 20:33:37 -0400
Message-Id: <20230404003337.1912901-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

smatch reports
drivers/cpufreq/amd-pstate.c:907:25: warning: symbol
  'mode_state_machine' was not declared. Should it be static?

This variable is only used in one file so it should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6f4b8040d46c..5a3d4aa0f45a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -904,7 +904,7 @@ static int amd_pstate_change_driver_mode(int mode)
 	return 0;
 }
 
-cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
+static cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
 	[AMD_PSTATE_DISABLE]         = {
 		[AMD_PSTATE_DISABLE]     = NULL,
 		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
-- 
2.27.0

