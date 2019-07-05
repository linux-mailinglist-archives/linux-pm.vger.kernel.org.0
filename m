Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D290603B5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfGEJ7b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:59:31 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33722 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfGEJ6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:58:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so8712788ljg.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VUCWK2MsD9fKCW5H56U5T5vRzO2k7QDz1z157zPKgz4=;
        b=yF9Y4TXdbukUm95Tym+SSRRKXOgy30rcUTY/I/w2ob/pI2Xk6mM2EFws9z/z9Jy5cn
         5yH51ejAX7BSHtxlej6Sietfapi0cefT59q9jJN1ifMQjBqWA/apLst7ul9igPrQzDk2
         drpnxdar+aTtUDEWi3y8Cvaxy3V5c8w9TqANXQggoaL7EEGMCiDWenolNKnmfMlIz6hF
         LA7dy1MeKgwm/taneDq3mE/Cww1ynKWrGI+PksCPx8K3tIZOtjsxbHUhCVxP0us659eW
         TmBrcMnTRQnSIVFZY+/4qysi0crgRy02/xmt3FLPdAsn0bXiaXQyjMv1jXGLbzNsj4go
         eyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VUCWK2MsD9fKCW5H56U5T5vRzO2k7QDz1z157zPKgz4=;
        b=OAPZzNp0Skj9uuRYzTASpwZdGVcdRqzsyKeHxzEnCqAskg02p5UTkzdw6/O7RG99yt
         vn8KP20w/j4y0gkzjXlPk8d5CpgywWV/j1qQob7CPe4fZYjlXreLuBCWSo05Svdov57k
         xkZr4SWPC24ao7avMrB2hpX6X6+mX3XkOEZOKij5u+U2GaFFToFHd3rn6+GOn/SHJb32
         uHFuB9AEt7g9BnZC1LcCZk7R2pqjfRBHnH39I/iyuIAjHPOW98cRoMMbJKGCgj9YFcdX
         E4euWOMjIVOgRSer7lraVsCWZD4K7vkO6+DdF79SM2LcDv4ZIbNLlJtHSDVEOO9GLsnd
         zBRQ==
X-Gm-Message-State: APjAAAWUYmKVf36FBb2lFHViwfFGo8JvuWuloBzrpX/WUYVnoiRJVutR
        J15vPyW10/LymkjAWUXLq3memQ==
X-Google-Smtp-Source: APXvYqx0ZiI7NUTcCSAcDJg+m43On7JBoo/yMllTvC1H2ViTfIYfM/r31p51tmof/TzmGg/DplB8aw==
X-Received: by 2002:a2e:9758:: with SMTP id f24mr1723330ljj.58.1562320683615;
        Fri, 05 Jul 2019 02:58:03 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id 25sm1692704ljn.62.2019.07.05.02.58.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:02 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] dt-bindings: cpufreq: qcom-nvmem: Make speedbin related properties optional
Date:   Fri,  5 Jul 2019 11:57:14 +0200
Message-Id: <20190705095726.21433-4-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Not all Qualcomm platforms need to care about the speedbin efuse,
nor the value blown into the speedbin efuse.
Therefore, make the nvmem-cells and opp-supported-hw properties
optional.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 198441e80ba8..c5ea8b90e35d 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -20,6 +20,10 @@ In 'cpus' nodes:
 In 'operating-points-v2' table:
 - compatible: Should be
 	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
+
+Optional properties:
+--------------------
+In 'operating-points-v2' table:
 - nvmem-cells: A phandle pointing to a nvmem-cells node representing the
 		efuse registers that has information about the
 		speedbin that is used to select the right frequency/voltage
-- 
2.21.0

