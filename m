Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A23539B6
	for <lists+linux-pm@lfdr.de>; Sun,  4 Apr 2021 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhDDUXs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Apr 2021 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhDDUXr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Apr 2021 16:23:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682CC061756
        for <linux-pm@vger.kernel.org>; Sun,  4 Apr 2021 13:23:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i18so5799502wrm.5
        for <linux-pm@vger.kernel.org>; Sun, 04 Apr 2021 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C1jQrGsOj1FZAgOCaP1S43Qzv0rwYxC6Nbp1N/yRsoI=;
        b=wdc22zRrVWwGUbsXZ8b0nYRaVeoMtRsd8/zgF0UJXkeVyIYKM1ZJcQnS+nH2WM+PbF
         OTCSUed11YpR+HT7i8BkOsdJqa2es2ssRYbL/pxedfg5M8T63reIIUeFp5hLEv7zYy9u
         CpzzvtwgTGvSh/rk36NMPWHuVZxztq+WCGkmXXal3zPNjlDTYdpgSrwKRCCixuaE1LuH
         yb1WIKY5skGkV7ocKPAN+kpfXH2ph1iLTx1zfkbhNHzOcWxwNGZfFd3WyojOZ+bScxab
         PCzB9QK5pYmXyjOPvyYf9U1D23h4J9Z2to7mFMClH1el2w5rh7YOgdWTyuxskw2P+eFd
         AxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C1jQrGsOj1FZAgOCaP1S43Qzv0rwYxC6Nbp1N/yRsoI=;
        b=JZ7tGkDrRF06QRkUtDmeF7nJ48LkNV0uriAeac6/PG7lBo/IH/pchBmyLUqPc44EOf
         2ZUx28fQVt83quV+N/RgJ3QCwDRflyOOpJiARzQP1SriH6k9v2GCAcydMUp422MYACm8
         qpWwrZ6PyWmsZNs2dA8iSLQQ/0LjbmX1r7eGPKS2qf86/BrSNtLvtS/DRNjLLkae+gek
         acC98LsmaZ/LDFs521Gl5PZQ9wLc6mVV3l3MtmsRXYuaAKmhPygZqF24TZRxG/Q3W6Dv
         fhZTwNEF0cWTJN1imUcbi/L+eKdy05a7o1I3hZkLytKjy+PyoXM+30RM9dzM9k5+ymb3
         PD9w==
X-Gm-Message-State: AOAM532ftFopgD1AUuJa4jQHW1ZUU7KIKYkLz8pADAnGzkLu+G2eO2Fp
        ilZNQQBXzX/1cBEkjEnDgk+8vA==
X-Google-Smtp-Source: ABdhPJw8j9PgXlQH9VlMvl2oruDZm1rL24m2MgBfpTrqzr1FrBpTyBCU6gJIiaqGQGnLEV3ppA2a9Q==
X-Received: by 2002:a5d:6384:: with SMTP id p4mr25995489wru.368.1617567820949;
        Sun, 04 Apr 2021 13:23:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f? ([2a01:e34:ed2f:f020:6d68:6b9a:7a3c:4a9f])
        by smtp.googlemail.com with ESMTPSA id c131sm21781635wma.37.2021.04.04.13.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Apr 2021 13:23:40 -0700 (PDT)
Subject: Re: [kbuild] Re: [PATCH v13 1/9] drivers: thermal: tsens: Add VER_0
 tsens version
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20210331083520.GG2088@kadam>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ee996074-0102-376a-14a8-c655264572c8@linaro.org>
Date:   Sun, 4 Apr 2021 22:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210331083520.GG2088@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Ansuel,

I would like to close up the two series which are pending for this
cycle. Is it possible to send a fixed series?

Thanks

  -- Daniel

On 31/03/2021 10:35, Dan Carpenter wrote:
> Hi Ansuel,
> 
> url:    https://github.com/0day-ci/linux/commits/Ansuel-Smith/drivers-thermal-tsens-Add-VER_0-tsens-version/20210325-064422
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git  for-next
> config: riscv-randconfig-m031-20210330 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/thermal/qcom/tsens.c:792 init_common() warn: passing zero to 'PTR_ERR'
> 
> vim +/PTR_ERR +792 drivers/thermal/qcom/tsens.c




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
