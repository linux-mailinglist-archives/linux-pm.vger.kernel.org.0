Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157F04D318B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Mar 2022 16:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbiCIPQu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Mar 2022 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiCIPQt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Mar 2022 10:16:49 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B817927B
        for <linux-pm@vger.kernel.org>; Wed,  9 Mar 2022 07:15:50 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cx5so2620166pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Mar 2022 07:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oYPf+ghIhV7r+agWznZ0k2zJGmzHc0daLWva3ZBCac=;
        b=COl2loy9SV2d5sun+kPh40dPD0uGJOmS+/HkjmD2g2sSi2FHFxzlJZwt31HkP+3V0F
         4wsmGvHnFNxW6j2LvyLHbCXk/MnsifYWuPnFHaXdeucHJzX2d/KJ1yzclKujTX2NqXYT
         5gPTt8JUb9d+Ce4LHMAY7+ciBYT0UWDEsV/3lEIRHR821NweJNebF0QqehCnig3e07K/
         DqHxiZKPmUekzY5YimL/O9+/RkZwCKR6p59ST0gnQdq5RqLTYZTpVpi19NYYJKFWbHfm
         bfXp4+NJXCFz5sZ4Qpp9g+agOQoOJnEmahdWRFTX6ryBqY8GF6wMx15vxOntf3vEUMHm
         5MNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7oYPf+ghIhV7r+agWznZ0k2zJGmzHc0daLWva3ZBCac=;
        b=26UbCU7zy/G97vxnuzdqecy8XCZJWG8u7qjo3H6zdYBcYr45/1zVOKHhOY+d7vUh0j
         K7SSjqJIRqJzPDGSzozVW0V6rWZOeE4qBniFdBKbSjux0fJ8U9kwMJxVBLbpU4qwM9LJ
         A+LatFBB2+wNVtNYd5tgY1A3+3B9IfWEdpBmpHckHoG73Z0QULIlksrgp+frdvt1F6z8
         +t8EtgyLQ98L5A+wCozdNP5DiCUR+r8R1H7F0BSTZikSZQgcX/vnf3xHKpKsYSRmiOz2
         Esb0IB0NaRT7jCrKE7oepGASZg5Vn+h05Vguex3cPtzZopCnS9MpnkubJDNNYUWq42L2
         txDw==
X-Gm-Message-State: AOAM530cSh105qxguyAHasr+QaX0iWyYstaT8ySEo2Lld57hMqQh908R
        3pOG4fYbw95nQxqE6jh7ZAPT
X-Google-Smtp-Source: ABdhPJzargKg1hYsYHqo1V8JbHKjOSnLSHJDtPS7/77n29fkgbS1+gT/nrJMALny/6sQsEC8S/yQ+Q==
X-Received: by 2002:a17:902:cec8:b0:151:cac8:f0a2 with SMTP id d8-20020a170902cec800b00151cac8f0a2mr142925plg.12.1646838949472;
        Wed, 09 Mar 2022 07:15:49 -0800 (PST)
Received: from localhost.localdomain ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id p25-20020a637419000000b0037fa57520adsm2727425pgc.27.2022.03.09.07.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 07:15:48 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rafael@kernel.org, viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@somainline.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/2] Convert Qcom CPUFREQ HW binding to YAML
Date:   Wed,  9 Mar 2022 20:45:39 +0530
Message-Id: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Patch 2/2 was submitted separately [1] but Rob's bot reported errors related to
the performance domain binding that used Qcom CPUFREQ as an example. But Qcom
CPUFREQ driver doesn't support the generic performance domains yet.

So I've added a patch 1/2 that fixes the warning by using MediaTek CPUFREQ as
the example and added both patches to this series.

Thanks,
Mani

[1] https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20211005044920.78544-1-manivannan.sadhasivam@linaro.org/

Changes in v2:

* Moved dvfs binding patch to 1/2 for avoiding DT Bot error.
* Added Krzysztof to "To" list.

Manivannan Sadhasivam (2):
  dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an example
  dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings

 .../bindings/cpufreq/cpufreq-qcom-hw.txt      | 172 ---------------
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 201 ++++++++++++++++++
 .../bindings/dvfs/performance-domain.yaml     |  14 +-
 3 files changed, 211 insertions(+), 176 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml

-- 
2.25.1

