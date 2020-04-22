Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377F61B46D9
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 16:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgDVOIl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgDVOIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 10:08:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0759AC03C1AA;
        Wed, 22 Apr 2020 07:08:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t63so2487135wmt.3;
        Wed, 22 Apr 2020 07:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn/XLaNsEUc+JrRQ7mg4yGN/42PXRkrYATqvOjyi41s=;
        b=snwH3gA2y8hxo2yX0BZogJrmkiRtOPUxjXX+dPm4cR0dVk9LX0VxJ7oPquVLBJbHqz
         AWnwU3Mhtf0HovRIhUHzwtrkmb9A4hbMEuyPbYmr869gTWKpZ9nPKxwopbxNddiNT0iO
         k95XZEP72PHNiVNwG/Wmr+htitVZPOUMLegX7fQFxuH6K/643K5oMFXCotPVRHG5OblZ
         xcAnlzlRxlAYONV4tjcdkDdRPdzcr33n9n0qSv65oa+5hlCLxfiY1UdBC7PSos/Sc3Id
         DNTZU26mI5J9GuQBD88ysDyCov7KTkmiRHTeQDVWryCdAkWal+U18AwAOPnPOd1vAUGi
         to9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn/XLaNsEUc+JrRQ7mg4yGN/42PXRkrYATqvOjyi41s=;
        b=c3wFRSH7RIAg41n76ETY1Dss0GA1v/2B0t+TAIquTICvHQlajeqUJD5E9dgc337lea
         y+78nVBVDEvimV8TYL0p5izb2oK+923TfYzRCMAiC7fnXk6XvcmAhzPNVWhLAEbpDt5a
         Y6gMdibTu9gyuNw0RTrO2XjWeqLLcLZ6psYHlI4FFoEXNC8aIKWqbXTkFKYPFhrYlVSa
         P91lao3qUy4ytsStIEeSZit1C62V+aKxQF48edLHBKT6ZtfMnI6GEKpzp4+9EcrRTEGF
         5jZYntaHVkTY5rVBcbgeOnuxR4GFnEXekMrmrl+K0WDN9ENSLO5yG29hsBlIz6HGGUdX
         3HrA==
X-Gm-Message-State: AGi0PuZE/C13bIEiBCorxJYuUoxiLICMpgkMpHbMQgty7xnFLkjnJYXU
        JRVKsc5tjzJ+MHBG1VhQ2/8=
X-Google-Smtp-Source: APiQypLcBdgKcojkVDWJDUlHMTtYzEZSNEqVPBloleybYbcysXDKZ/PSC6WiURn0kRHtcRsdukQqQA==
X-Received: by 2002:a7b:c850:: with SMTP id c16mr10268138wml.108.1587564516651;
        Wed, 22 Apr 2020 07:08:36 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host36-18-dynamic.45-213-r.retail.telecomitalia.it. [213.45.18.36])
        by smtp.googlemail.com with ESMTPSA id a9sm7526790wmm.38.2020.04.22.07.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:08:35 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: opp: Fix wrong binding in qcom-nvmem-cpufreq
Date:   Wed, 22 Apr 2020 16:08:27 +0200
Message-Id: <20200422140827.1726-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200422140827.1726-1-ansuelsmth@gmail.com>
References: <20200422140827.1726-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update binding to new generic name "operating-points-v2-qcom-cpu"

Fixes: a8811ec764f9 cpufreq: qcom: Add support for krait based socs
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 64f07417ecfb..537e1774f589 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -19,7 +19,7 @@ In 'cpu' nodes:
 
 In 'operating-points-v2' table:
 - compatible: Should be
-	- 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
+	- 'operating-points-v2-qcom-cpu' for apq8096, msm8996, msm8974,
 					     apq8064, ipq8064, msm8960 and ipq8074.
 
 Optional properties:
-- 
2.25.1

