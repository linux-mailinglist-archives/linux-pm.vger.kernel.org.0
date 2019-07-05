Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1623F6037A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfGEJ5s (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:57:48 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35338 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGEJ5r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:57:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so5956345lfa.2
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aR9uAvgeaPzmKk1YhWutKX7D15M3aAKx9HHCruqrY3s=;
        b=MWycKuBRX+yk7xrNtRuZUKiQquKUSF3f8BCs3i94Tg0jpBzZZSvrg/KD7XjF4dZzSj
         WSrqJ6zerqnMOvMfSPwSVX3FvQGTSplMbTnriDo9DNz+qLIXcuuEsZ5lpvxuokKTpCBK
         91jIzkvGtmoB8LaQtWv0mH8JH43enZMRtsDRSFjZY/Lh4IBxpsbtWgkEWI2FSsmU2vRs
         e5akyZHNQOVUmjeUAH2tLlxyWfr/pDHyCokuz1SLnr7wKHi8quESwtQgQdlN8CW0Eqlp
         is8yXlOGy337hHmkBlxu5b/sOae3LXt5VVrrXfKPDVNivJ+s5X4AhNns1P5oip54DDm6
         UzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aR9uAvgeaPzmKk1YhWutKX7D15M3aAKx9HHCruqrY3s=;
        b=CwBR6J0Iwp6iw2/AFbonqVYV/DrsGsJDx9dV2aAWNgbqQ7S3sYubY6pxRiGHO68itU
         N/YTHsaNNFiUK3120GtO4Nk1+OBRJ4kQbPLUV3jeHBq/l1VG1fvHfHAkr43RynU1vRlc
         ouju43G1Wi8wy732qEknM8xsHIqxRn54UEbdeUzNAHtn8WBO/f1kwtkmCq2k1WlNKweX
         4x0S3JTvzNzTtpWJsiGCwTcdBuqjmjaMQ593Jwg0b8ozBmWuTAiUy1xk8gGWF5269S7G
         vb57uj5hDMsTzbvkl4VhsfDJCI4tH+E6Q83rUJrD8TgNE0mJ+uo4GXNHx432TaIK252c
         1T2w==
X-Gm-Message-State: APjAAAUJ3NVnVrsNyMn9y/GtKao8f+Ut45c7WBqz5ThPwNjptCWslcvS
        06s3mewORYTb1kHz2DXfPBouQQ==
X-Google-Smtp-Source: APXvYqzKvDyiKWeIXmJyoQuAirsIgVLFmJHimarCgDX5CCLbzQQDbDzznUGhL8wvlYup85IAH62Q6Q==
X-Received: by 2002:a19:7709:: with SMTP id s9mr1485305lfc.86.1562320665755;
        Fri, 05 Jul 2019 02:57:45 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id q2sm1298364lfj.25.2019.07.05.02.57.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:57:45 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] dt-bindings: cpufreq: Re-organise kryo cpufreq to use it for other nvmem based qcom socs
Date:   Fri,  5 Jul 2019 11:57:12 +0200
Message-Id: <20190705095726.21433-2-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sricharan R <sricharan@codeaurora.org>

The kryo cpufreq driver reads the nvmem cell and uses that data to
populate the opps. There are other qcom cpufreq socs like krait which
does similar thing. Except for the interpretation of the read data,
rest of the driver is same for both the cases. So pull the common things
out for reuse.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
[niklas.cassel@linaro.org: split dt-binding into a separate patch and
do not rename the compatible string.]
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since RFC:
-Made DT bindings a separate patch.
-Keep the original compatible string, since renaming it breaks DT
backwards compatibility.

 .../opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt}   | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/opp/{kryo-cpufreq.txt => qcom-nvmem-cpufreq.txt} (98%)

diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
similarity index 98%
rename from Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
rename to Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index c2127b96805a..198441e80ba8 100644
--- a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -1,13 +1,13 @@
-Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
+Qualcomm Technologies, Inc. NVMEM CPUFreq and OPP bindings
 ===================================
 
-In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
-that have KRYO processors, the CPU ferequencies subset and voltage value
-of each OPP varies based on the silicon variant in use.
+In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996,
+the CPU frequencies subset and voltage value of each OPP varies based on
+the silicon variant in use.
 Qualcomm Technologies, Inc. Process Voltage Scaling Tables
 defines the voltage and frequency value based on the msm-id in SMEM
 and speedbin blown in the efuse combination.
-The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
+The qcom-cpufreq-nvmem driver reads the msm-id and efuse value from the SoC
 to provide the OPP framework with required information (existing HW bitmap).
 This is used to determine the voltage and frequency value for each OPP of
 operating-points-v2 table when it is parsed by the OPP framework.
-- 
2.21.0

