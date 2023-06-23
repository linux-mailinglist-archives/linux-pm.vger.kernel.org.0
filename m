Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A765C73BC36
	for <lists+linux-pm@lfdr.de>; Fri, 23 Jun 2023 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjFWP6N (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Jun 2023 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjFWP6M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2023 11:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480582117
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687535846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8yB7HqTroWEhP9efqg+b7pKLnUsqA1PuT3Ijl2qFi+4=;
        b=NxPwH1rdh8GVReKolL0r+HeHdDDt4ZaZYoF6g6i4sWcXb3pqoDmho3pc9yO+1YcSFbbamZ
        0RNlWBY6V2uJ/VNfoCM1u7lp+Ak2zB1jxicoxv52/e7xRpZJ3/9HacK7DrlwPuRYHbHAAA
        EQ0CxGrLr3kAAcUQTTEsp730ozPuAJM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-1IrWSn2hNCit2_66hcDkGQ-1; Fri, 23 Jun 2023 11:57:25 -0400
X-MC-Unique: 1IrWSn2hNCit2_66hcDkGQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6b5d41d2f6bso587083a34.2
        for <linux-pm@vger.kernel.org>; Fri, 23 Jun 2023 08:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687535844; x=1690127844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yB7HqTroWEhP9efqg+b7pKLnUsqA1PuT3Ijl2qFi+4=;
        b=eJqf7USfr0MakAstyr2948qxuAWvdpD+NaROuuBtGOiwrRQvDH8wsprkqY1Ugqt7qF
         irdYb0nDOrpvCP1fHGJQ1ZBTmvDCJWxbtqASVoL2etEG/LrWck2SViRczhQIobQFykjI
         qO6mbOQzLTxsQOyFNTbtIOHPfDbmkB1FJMjnQDLE4fqRmbiwi47eEUZsaI9zfgiDI+tj
         zzNebX3/bqH96XTynZORYgx3Q0tDR38PjwWct3RjZIB7Gb3vmxlXxwPPHYe/MswRNNAv
         f4aeF1Thxps7IxVseeixIO+UgKLldiSdMxv0sVjqS9uNDuKtqtq3/d3qlWBgR6Zd7t9K
         n6aQ==
X-Gm-Message-State: AC+VfDwrwFQlrnGAh4Zfdr8ji3db4GsjN3aRP8I2hGrN2Hf+e0f2v90/
        dTiNOeLjv1/NFndI/2PPHtEq/PomqPqAx2yU3qfMy/6/7TDO+YrtSlRp8h/8AFj+h85TM0ZlMC3
        qdFRxoM/DdYWzdTV0YzbPgIpEqEg=
X-Received: by 2002:a9d:7414:0:b0:6b7:296d:3d4e with SMTP id n20-20020a9d7414000000b006b7296d3d4emr980455otk.30.1687535843982;
        Fri, 23 Jun 2023 08:57:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nubFY5xAfbSlXYXWVWjad3VSMli+Q/HTHaXj169kXem2BAiF1sIv7sOY1ukVSIq+NyDYRnA==
X-Received: by 2002:a9d:7414:0:b0:6b7:296d:3d4e with SMTP id n20-20020a9d7414000000b006b7296d3d4emr980442otk.30.1687535843646;
        Fri, 23 Jun 2023 08:57:23 -0700 (PDT)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d6391000000b006ac75cff491sm3883758otk.3.2023.06.23.08.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 08:57:23 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        viresh.kumar@linaro.org, rafael@kernel.org,
        konrad.dybcio@linaro.org, andersson@kernel.org, agross@kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to get icc paths
Date:   Fri, 23 Jun 2023 10:57:07 -0500
Message-Id: <20230623155707.944272-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This way, if there's an issue (in this case a -EPROBE_DEFER), you can
get useful output:

    [root@dhcp19-243-150 ~]# cat /sys/kernel/debug/devices_deferred
    18591000.cpufreq        qcom-cpufreq-hw: Failed to find icc paths

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a78d7a27b4b5..f2830371d25f 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -661,7 +661,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
 
 	ret = dev_pm_opp_of_find_icc_paths(cpu_dev, NULL);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to find icc paths\n");
 
 	for (num_domains = 0; num_domains < MAX_FREQ_DOMAINS; num_domains++)
 		if (!platform_get_resource(pdev, IORESOURCE_MEM, num_domains))
-- 
2.40.1

