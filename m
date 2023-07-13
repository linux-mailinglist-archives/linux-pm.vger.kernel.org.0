Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C980751D62
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 11:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjGMJhE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjGMJhD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 05:37:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918651FD7
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 02:37:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso4082015e9.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 02:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689241020; x=1691833020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LO16C4afbNedSS278cp3vmRjV8M4ZojnE40vSnvuOp8=;
        b=B/VTM2A2Ff3BsEm+Dbic99+WuEDCVmGDbMJ8LxrF/1GvrqW9fyeUzF0jbT+93kmuRL
         wBwaRymNlRxHrndKfk4fokF0IpTXckHiFGblNgMTNMwJfDzQNZqpXl+svQw/Vi+NlI+Y
         vFAUnNn3ul5VB9mhtlPK9iiZHLaTJrlPVXqeFpUuQFvyFmtpvNK9m7h2wdukITeUa9cN
         b2L0HaL58ZFakpnHHbqUworYJYj4A1+0CDor56dtDOZHaU0GEORvK/xiVza8pcmsDjBj
         RwHLzPtKtFEPMKnfgMOB+lK8ahwsSyBh92mPftSJRtIUACJOBDvK/7j5sQI9Ow+EAnus
         J+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689241020; x=1691833020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LO16C4afbNedSS278cp3vmRjV8M4ZojnE40vSnvuOp8=;
        b=g1siJ6v63mDHyJkazcza9wEknndS9dNyEBccrJY2XdyOd1Vwo2Znh58UpUoo5lkdfQ
         AYiYK109rw86pqlEqxQw2MMsnhwIOaAI4j0o/K2htD6gzCAPe0YDy1/ES0A3NLroJmLE
         O+TWgyZuDPG0hzFFVXycJ9hKnR04YuCAZtmgByDq7wEYZv4fBNTQngXsq9K/n59+oDo5
         T3JUKVGJJjyEDBYnisJ88/+d7PAkO3dRtYxwcHqpPXBr4tRGSUP7frRKz95+qnl0S7rE
         0inhk7bHD3ACfJWA1l9lSbpZYEYK1QxyycksqXOjRfFxCrtVEyU+WsHRWc9APQcwok6u
         6OWA==
X-Gm-Message-State: ABy/qLbP6JDQ98oqATeAyJWt5zvxLZJR3OO+r3YMs4AbOOXlTorqfLc7
        fVCE5if8ympwtfichA8HddpDZg==
X-Google-Smtp-Source: APBJJlFMBriV29WbzhyFY/CIsPKFOcUSWfGpPjnDXBfv+rkLWEVpKUsGQ5WbYCNvuo4SjnPi7x5rww==
X-Received: by 2002:a1c:7c05:0:b0:3fb:b56b:470f with SMTP id x5-20020a1c7c05000000b003fbb56b470fmr861224wmc.14.1689241019909;
        Thu, 13 Jul 2023 02:36:59 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c3-20020a5d4f03000000b00311d8c2561bsm7343117wru.60.2023.07.13.02.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:36:59 -0700 (PDT)
Message-ID: <30b4eb6e-5df8-3696-8552-45f523e6ea99@linaro.org>
Date:   Thu, 13 Jul 2023 11:36:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal: imx8mm: suppress log message on probe deferral
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230708112647.2897294-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/07/2023 13:26, Ahmad Fatoum wrote:
> nvmem_cell_read_u32() may return -EPROBE_DEFER if NVMEM supplier has not
> yet been probed. Future reprobe may succeed, so printing:
> 
>    i.mx8mm_thermal 30260000.tmu: Failed to read OCOTP nvmem cell (-517).
> 
> to the log is confusing. Fix this by using dev_err_probe. This also
> elevates the message from warning to error, which is more correct: The
> log message is only ever printed in probe error path and probe aborts
> afterwards, so it really warrants an error-level message.
> 
> Fixes: 403291648823 ("thermal/drivers/imx: Add support for loading calibration data from OCOTP")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

