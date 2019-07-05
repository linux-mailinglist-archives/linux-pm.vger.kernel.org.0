Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19D8D6038B
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfGEJ6Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:58:25 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32837 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbfGEJ6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:58:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so9392lfc.0
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3d7DZVDxTF+1P1r04sZgrqNLdKAcaTJiZmOQo0Hf0lo=;
        b=A7ANQjbzgETo8bypTd7CTupdPefiX80rr3iB1lplbcFGJ6Lj/pEend7B5Yar5Obj58
         b9syE3gDdc0YxdFoY7jgQ4YuhUJsSAIMW4t/iN2py89kVd5pmUYKfHiEVbIzJodiEFY9
         REW23yadtF1F9/NphlTSuc9JY4ds7EUyt9t6OgqYh/3aZU+P93J/bZevFJYs9xu+PFov
         Trbk5dYDBDS550f6U/ryk9FiTqppLaFfXAHeHSvpDXaZEMrIf8k0GEZaQiYFKh0bk4cb
         lEwDZ6EN1CZI0y4fr3RkOMzfStU4VYn5NcRXBxW5cxO3GJ0T+nmsEXtC8qmAFITi9D67
         oeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3d7DZVDxTF+1P1r04sZgrqNLdKAcaTJiZmOQo0Hf0lo=;
        b=cxjuPYRQQCTD25KB0jzP9K1d5IedA6EnuhSNde6dMVBhE+5kdPp/e67WsjQ7hxlURf
         dJiVlL+A6E+JuBKC7ZP10dFTpzc+GS6ECt5OhmGfR4B/hs77f8i3Si7FowupfVNspkmh
         Q0N6XgdEgQ054ZuHM6lNu7hTaZwHjsVQ+0g5kfzUiFpa4bZuwB5abRA6cX7M6c70qcWJ
         +3fnBZZvFKlYIzOEq60uqMee9/Y28jZrC0og9BGNECIXR8Hfr6Aq5+261tNGO8LSBlkt
         N7gikfj72QQLV85jGNOeZEQQ5Fmf6aTKvpCrPC6JIY62Fwxn2QHy/5hnGzYUMc/2eLuB
         xMmw==
X-Gm-Message-State: APjAAAUeKW/lWkqpHJOu9MIYDfNHtU/PbEz4Eve/Y5TAXOw6M9C46CKj
        9wAfrvydKsloqLASu8DIRiXqCg==
X-Google-Smtp-Source: APXvYqwjbM7AX8hHIJs5YC6nRjkyBuavTgd0+gyyiJpufgKhogx9bn+W5bDoNQhNintlVXWZmy1smg==
X-Received: by 2002:a19:8c57:: with SMTP id i23mr1531184lfj.192.1562320703024;
        Fri, 05 Jul 2019 02:58:23 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id o24sm1674955ljg.6.2019.07.05.02.58.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:22 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] cpufreq: Add qcs404 to cpufreq-dt-platdev blacklist
Date:   Fri,  5 Jul 2019 11:57:18 +0200
Message-Id: <20190705095726.21433-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Add qcs404 to cpufreq-dt-platdev blacklist.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 03dc4244ab00..ec6ef996e637 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -123,6 +123,7 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{ .compatible = "qcom,qcs404", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.21.0

