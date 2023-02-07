Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96F468E1E7
	for <lists+linux-pm@lfdr.de>; Tue,  7 Feb 2023 21:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBGUdS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Feb 2023 15:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjBGUdR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2023 15:33:17 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1437B50;
        Tue,  7 Feb 2023 12:33:14 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id cr22so18228353qtb.10;
        Tue, 07 Feb 2023 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACnOp18Cw9sVFaRz+DHpDGjm7Thlarubraxtwk1GdtE=;
        b=ZPtal6XqEg5h9vGXn3Tpj+XjFZ/AXB0sOvRcopoZ89vuN9YDvq6piWVTamHUujJSJu
         yOkr0zBqCwNqj41Dz8DmoEnx6JEF/5PToOQnKgNeeY0Q+T8s5VAyaWu2YuGBvoGILlCk
         92baiNX1O+lJLVVQIvW+Lodu1izfg8CflK1OnPM50j6nh+9hBQDdwUh0HyOLANnTAAeF
         ++I5ezxwhYqxXKXVRW3upiDLEDdy4OtYq7apsDbTKW45uepaCAQJBcrp85PazgSA1rWC
         Hnh/j8S9k+Kg7KxbRFk7/0vhe+L0ssyMQIjopquea/kVUdmhPxLsoGFmhfezjd6xfg+D
         tktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACnOp18Cw9sVFaRz+DHpDGjm7Thlarubraxtwk1GdtE=;
        b=gkYG+kmSCI5NBy8nJcVshNvV50rRx4jiQPUCvSRYbPup2piT9V4/Y0A1a69Rdv/7U5
         OE+V4F+ZrG2R3Gr5yPQkW7f5mqN+7QCmSkKUO6Dyn5ZgmtmsxVyUSgNYSv9ZglZksLF1
         DGKn/O6VAoWwZQlmLhnBtI4Kwi+AX6oodaPrOSD80asN0DGPIGT11iJKJt61Z8Cihs9p
         vknCE7Cm+nvY797e4oFSzzAinOKc92KxS0wOripSQVxqZ6+qE1I2c/rtC5i7EEpfBxgV
         eFBFIUOfVvOCEh0t+SgYimSmlCyROpfKJCzi4Ns8Us2Wi/4YtzytkUzW9uBhOaLheNLK
         LTeQ==
X-Gm-Message-State: AO0yUKX9Ngag1HsFYrPvw1tM6Zna0FDN4wpW5jzW472SdWn9cbdsB+HQ
        x3nm/wlaHTUc3e2v9YeL/7Y=
X-Google-Smtp-Source: AK7set/hNBjGKVokty8Kg7Hj+M/AZK5P9t99MexEgK0y64YxB5Ho3ND4mmbt2lgppKWclZ7x7fJtPw==
X-Received: by 2002:a05:622a:148c:b0:3b6:2f22:75bd with SMTP id t12-20020a05622a148c00b003b62f2275bdmr8014753qtx.28.1675801993929;
        Tue, 07 Feb 2023 12:33:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z7-20020ae9c107000000b00731c30ac2e8sm3631619qki.74.2023.02.07.12.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 12:33:13 -0800 (PST)
Message-ID: <cf4d3028-fea2-be31-4636-f739279d5806@gmail.com>
Date:   Tue, 7 Feb 2023 12:33:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cpufreq: Make cpufreq_unregister_driver() return void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        iresh Kumar <viresh.kumar@linaro.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Kevin Hilman <khilman@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
References: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230207195909.474953-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/7/23 11:59, Uwe Kleine-König wrote:
> All but a few drivers ignore the return value of
> cpufreq_unregister_driver(). Those few that don't only call it after
> cpufreq_register_driver() succeeded, in which case the call doesn't
> fail.
> 
> Make the function return no value and add a WARN_ON for the case that
> the function is called in an invalid situation (i.e. without a previous
> successful call to cpufreq_register_driver()).
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/cpufreq/brcmstb-avs-cpufreq.c | 5 +----

Acked-by: Florian Fainelli <f.fainelli@gmail.com> # brcmstb-avs-cpufreq.c
-- 
Florian

