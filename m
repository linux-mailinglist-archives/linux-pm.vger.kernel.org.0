Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E881A68A4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 17:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgDMPSH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgDMPSF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 11:18:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728EAC0A3BDC;
        Mon, 13 Apr 2020 08:18:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so4549030ljd.3;
        Mon, 13 Apr 2020 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GdKC161+a5UeWpGOznjCxdPHuVYqeTMUmqQiY/jkoXQ=;
        b=TFN6Q/Qgniz7+QYsjrimIJAqCoe+peI4ByNh8FPtgWl+IxMFdtouuBQ3DdCfB3D8PN
         oFoEqruP2xgPxXpyoHNn7qkhyEfX/knBklwQHC5cEDT3c8wCkZh5Ant45cCoCf7L+MnY
         H9jUYnfTNe6PyAgtlZ+i/fuxbnZVf4Dbs1zi4RBwYbjaTw5yYEp0ctKxn78YOe65eoPN
         rx8ERcL3GJNubbv3oJRiJylWBD6nwN0AzKmhs876f815+Z0TA5E5rUylFvQ6uRI0yiFm
         WPyD5sUC/vewP9l6d/8A9aE7jafPavBULRPl6+/Xcp/ROcHhElXempcZia6FYjyLEN61
         iDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GdKC161+a5UeWpGOznjCxdPHuVYqeTMUmqQiY/jkoXQ=;
        b=OqQxRhw8KrDurPNG806ifDojrf3ea2/cBx4r9mb714hzMQlTzy1xUxgmLO3hV3ZgKC
         KcVStm+r4W233qsXsaYw8nKSylNphoWhZFYY2GsyezDGenOG0Ukx8scM8rhAdS9jqlbW
         xu0flqlLuCTpO40OOze2VQD2KOoFzPjkGlWjFd8mDBiZW97cFhmvG7Cm+8DkEnn0gItW
         uCr6796aXbV9WsS57jOF46LDT619aaaaAyTOCNZldgOwjxXAuY7Bd9/imSdjL4SWyhhW
         jFYhX3xNRFmcQGSQonS7xAu7w7Qi5YH2VcDYnwmFsHJLBhl41m0Pm76ROqLUhA59fVPl
         1aEA==
X-Gm-Message-State: AGi0PuZgnnIWZdX0accSqktqutm6EVcEdjaAXEWjuEaAHJO/kyV5JkkS
        5920Gch3ORFL2ETbDrUD3YjlvtLX
X-Google-Smtp-Source: APiQypKxQ/EghHVYpg1HOEBLhbZ8HlHRew/LfP6ed1H+YL6pEvyGOKxv7C+tCEfvFdT33UG6L9Hk1g==
X-Received: by 2002:a05:651c:120e:: with SMTP id i14mr7500365lja.12.1586791083641;
        Mon, 13 Apr 2020 08:18:03 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id 64sm8427382lfh.32.2020.04.13.08.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 08:18:02 -0700 (PDT)
Subject: Re: [PATCH v2 17/22] memory: tegra30-emc: Register as interconnect
 provider
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20200330010904.27643-1-digetx@gmail.com>
 <20200330010904.27643-18-digetx@gmail.com>
 <d8e39d8b-b3f3-4a30-cb5a-67fcbe18a957@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8d072775-aec8-5a55-8fd7-7166e2a34c95@gmail.com>
Date:   Mon, 13 Apr 2020 18:18:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d8e39d8b-b3f3-4a30-cb5a-67fcbe18a957@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

13.04.2020 15:44, Georgi Djakov пишет:
...
> All the above seems like a duplicate of what we already have in the previous
> patch for tegra20-emc. Can we have a single driver for both? Maybe extract the
> above as a separate interconnect provider driver.

Perhaps we could do it later on, once the work on the drivers will
settle down. I think it should be okay to have some minor duplication
for now, we already have some other small things duplicated in these
drivers.

>>  static int tegra_emc_probe(struct platform_device *pdev)
>>  {
>>  	struct platform_device *mc;
>> @@ -1344,6 +1452,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
>>  	platform_set_drvdata(pdev, emc);
>>  	tegra_emc_debugfs_init(emc);
>>  
>> +	if (IS_ENABLED(CONFIG_INTERCONNECT)) {
>> +		err = tegra_emc_interconnect_init(emc);
> 
> How about registering a platform device that will use the same driver to handle
> the interconnect functionality for both tegra20 and tegra30?

It should be possible. But it also should be possible to make all these
drivers modular, which I'm going to try out.
