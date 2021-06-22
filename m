Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A5B3AFD29
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFVGqe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 02:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVGqe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 02:46:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FE8C061756
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 23:44:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h11so4760216wrx.5
        for <linux-pm@vger.kernel.org>; Mon, 21 Jun 2021 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=WC/cFZ8lgWvP8WFGSx5vr0gm1U7x+BAcF+01oXaqU5A=;
        b=SZ7zA6DuJHKybKieDSe8U6rI05iGm+s6z/lg0DxkNwimExI9AiSP/YJsK18upauQTF
         b5DfO0yRbNJEmzPkPIcO8Op8asx8GgCfCgVWZWinrcFC60CNgD+6kNYPuJjbi9X/mOSQ
         QJc8KFGoYZ+Av2Mm/kRi9IXQI1ivfVYsFvIwL+Tt762TXz+ZW8eOun31ROqPx0+PURII
         ocgjwXSzvgb1yVsuoyG9rejkYZT+5HxG5Ht3zSxm4Wju/ZWqWtmyrhi5pTQTmrcPREgE
         /yeyJ8G3mgPHK/gMcLs3MDilM7h+ZPofgL1Fd42KnJTtiavAq1T2NBPEVtIs5Myf3aGj
         7TNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=WC/cFZ8lgWvP8WFGSx5vr0gm1U7x+BAcF+01oXaqU5A=;
        b=Hest3njkCBXjh8lteaETAhlKUzj3NGR+LevEWqrB1xw73O2Jm0vSZYk8ezO0OhbtAX
         HtW5XMktkmm6p70OFAaAJ5CFM43O8EHKz+s9TGHhLtL5rFQoNo5UeAot54vPTtPzsbxh
         HNgIaUwyOhet4vmEOkSHwURAqHup6dOEy4Je8xR97Em07IXofMeLzG1Vb2uVZPe2l5Jq
         2WdxHCdNYrH1rbmAsuHWMQ1IAWBXScWeOTy1KPTC6ATzGiekKGMJl+MEbJ8W+W/q+IAJ
         fS7TemsHkj18Gs7o1UuyajxKPGEkH2F24XX59fdsqSqxYD9qkWOT2txFb7YX3sz4+2YO
         QX4g==
X-Gm-Message-State: AOAM530br3a1/4c5rNSSmf5j/VSo0YaOUw/COxdwC+Z+FEW6f2AXg/ws
        +EcjeN2hn/qtBQ71fvPm4RU3eQ==
X-Google-Smtp-Source: ABdhPJwmb/xVQxu2qBli69vl4Ebcew3/+SWBzyeUQbBx+Yr9UZKQJdrKYqhPZ9lH11gmnSmE3zW26Q==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr2759600wro.194.1624344257205;
        Mon, 21 Jun 2021 23:44:17 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211? ([2a01:e34:ed2f:f020:5ebd:8bd9:d549:4211])
        by smtp.googlemail.com with ESMTPSA id v5sm1262932wml.26.2021.06.21.23.44.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 23:44:16 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] cpuidle for v5.14-rc1
Message-ID: <da5ee4be-e62c-53d0-167a-55f6bc5bab4b@linaro.org>
Date:   Tue, 22 Jun 2021 08:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Rafael,

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/cpuidle-v5.14-rc1

for you to fetch changes up to 0f0ac1e4eef2753d4f9cd0117019da9501921fef:

  cpuidle: qcom: Add SPM register data for MSM8226 (2021-06-16 20:03:26
+0200)

----------------------------------------------------------------
- Add support for the Qcom MSM8226 (Bartosz Dudziak)

----------------------------------------------------------------
Bartosz Dudziak (2):
      dt-bindings: arm: msm: Add SAW2 for MSM8226
      cpuidle: qcom: Add SPM register data for MSM8226

 Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt |  1 +
 drivers/cpuidle/cpuidle-qcom-spm.c                      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
