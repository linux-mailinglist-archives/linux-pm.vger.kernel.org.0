Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D133A515E17
	for <lists+linux-pm@lfdr.de>; Sat, 30 Apr 2022 16:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382790AbiD3OTe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 Apr 2022 10:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382780AbiD3OTe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 Apr 2022 10:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7B7F4D602
        for <linux-pm@vger.kernel.org>; Sat, 30 Apr 2022 07:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651328170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QPrMgDy5yB7Hta/JI8DxMyoAvcnzjiGrseGCPyjzNXw=;
        b=dkLQtR9ezRR6cfM1E2Wh1IF4FMc4uaSDzrF1rtxIPp+Tvyw8+L6TWQYUUFK989TNydlqAk
        XkFW7Q22ibNsCYkyYzp2Xfo8MNHPjQ4Rw6TrJhKS7GUNYg+FH0mK0dEBCjdyD5HSMNODcW
        keWuPSMuoYXpsaCygGdDHac+zxBLE4U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-OMH2pj0WOrWkcN4rP62wtw-1; Sat, 30 Apr 2022 10:16:09 -0400
X-MC-Unique: OMH2pj0WOrWkcN4rP62wtw-1
Received: by mail-qk1-f199.google.com with SMTP id x191-20020a3763c8000000b0069fb66f3901so3090111qkb.12
        for <linux-pm@vger.kernel.org>; Sat, 30 Apr 2022 07:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPrMgDy5yB7Hta/JI8DxMyoAvcnzjiGrseGCPyjzNXw=;
        b=CUmzSx23QABq+7lQ75ZNHCpHrE1byeAqopmF1X+5UkTVClttCrO8RMnPEn6j2rVzO7
         UNdSz9G1ROuAcvoFrO3kyEvUrMxrUbBtultvwfefXDi6WXxLyUoj8x7wNXuhzwfYTMAy
         4wEC/Vo+WGgiCWXmXTt5nloYdUPbJiPaV0KpwNsUBqRGP9CHMOri7QSyiMVPXAi8wbkF
         I+pq4iRBulks4JqcFpou4uj6n3sSgoz0fLLqXSrY1Neo89Q30yakWPpJb39szjEo5/Ri
         0JgDjV2n4EFIUXLPid6xeiJhkyUYmOXG1Pt6djTP6XgGL9S94wUnmXEd9G70dZobAaKb
         tu2Q==
X-Gm-Message-State: AOAM53104oIcOkp4UhmUVfs4VLSRMdaz8ZWZLoIkMyZQTz9441/02hOB
        g+h0rKnUCTUO/4fCXUkHSziQn8OA4NS3Yl4lne/h1dbSjo8My+WLC8reWMyofHwi34O6trLS2Fe
        SDq5+++KSS5mNzsUNQtQ=
X-Received: by 2002:a05:622a:38a:b0:2e2:2fdf:246e with SMTP id j10-20020a05622a038a00b002e22fdf246emr3646870qtx.482.1651328168855;
        Sat, 30 Apr 2022 07:16:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycuPFxc7mpvj76wRMMFa+8pkiJoTQXsRG6+O/KA8uzS5Mu+Z+k19n+bYltcBs/N7XHJpwVaw==
X-Received: by 2002:a05:622a:38a:b0:2e2:2fdf:246e with SMTP id j10-20020a05622a038a00b002e22fdf246emr3646851qtx.482.1651328168680;
        Sat, 30 Apr 2022 07:16:08 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q77-20020a37a750000000b0069fc13ce1fcsm1279581qke.45.2022.04.30.07.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 07:16:07 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     lenb@kernel.org, yu.c.chen@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tools/power turbostat: close file after use
Date:   Sat, 30 Apr 2022 10:15:57 -0400
Message-Id: <20220430141557.1065405-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cppcheck reports this issue
turbostat.c:2039]: (error) Resource leak: fp

When the fscanf fails an error is returned without closing fp.
Move the fclose so even if the fscanf fails, the file will be closed.

Fixes: eae97e053fe3 ("tools/power turbostat: Support thermal throttle count print")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index ede31a4287a0..2e9a751af260 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2035,9 +2035,9 @@ int get_core_throt_cnt(int cpu, unsigned long long *cnt)
 	if (!fp)
 		return -1;
 	ret = fscanf(fp, "%lld", &tmp);
+	fclose(fp);
 	if (ret != 1)
 		return -1;
-	fclose(fp);
 	*cnt = tmp;
 
 	return 0;
-- 
2.27.0

