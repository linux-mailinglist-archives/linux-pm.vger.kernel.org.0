Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1422E02C0
	for <lists+linux-pm@lfdr.de>; Tue, 22 Dec 2020 00:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgLUXBD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 18:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUXBD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 18:01:03 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D1FC0613D3;
        Mon, 21 Dec 2020 15:00:23 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c79so7330337pfc.2;
        Mon, 21 Dec 2020 15:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65pt/EpKbKnqnWANzNSM/MF57uxSvX6gWSCDRynSRlA=;
        b=WxVL33ES70LsqsN4AA7yZyhE4dkhaHXl0+g0SzjRmv9x+dL0ILzQvdo98UOj9nza25
         yexpKtG20dvF9QFUzqcQizmaJfzf0UeeCmfxMAkUpd2nigbOfCVRmm3XlwwsVtTfoLuR
         hQtpFslAupUCpq3xS/xZ/TR22ziNYnm+Ak61SyCYShWIIr49j4VegVhb+DKHv4RKUDpJ
         et+OCoAb2IojFp/3Xfd875wM8XWYAe9mLNgcteweCiGtnUpDs04UH5h71BAHQ7JbKJ+o
         Hqi93kB37kJ05K+0Nr59fO5UiFnz6k+bnf3+vzEp44ySkaxWUdOGr46e7yXIfhArvk34
         tqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65pt/EpKbKnqnWANzNSM/MF57uxSvX6gWSCDRynSRlA=;
        b=jNYQ1IaA3URYqNiXOFTMRAPyJ8/5hz/XorGBVI5BHu3tvWeiJdrXMnz5RYyttL9c+0
         q0tRf7mK5OmJb1iIIWOZBgjEjTC6eX1zfXwvATPBKmLkFr4JcYBe6k8ZTVlChie5ldSl
         qjSvZKae1KIsHjHhQNZ0A1r9B+r14BD8z+cglUNiBqcTRG4X/66V9iVp2/3stOhoV4IW
         8i+g6on0rrmtgOcPkRg62ghakJKBg0oCoBcOvdOccuuIXfaVbVZCblvmACzAPNLNMrmo
         TasVgT7I64mFGjV9scwIzssDH+hXCJNmznvW0iQ4paquFFwYGMlgRZt/7C4Pos60/NmH
         Mw7Q==
X-Gm-Message-State: AOAM530PMpwdB5zEgIyZfDMAT6E9J0qjeRH43ZeXY+1WNBBpWwiSAwNV
        8kHu80033DD/V9Sn+I9c/WcoiXCpI0g=
X-Google-Smtp-Source: ABdhPJx4blbyV+GNHUeZersi/78OT573VQmpJDni0rEUoDkBlL919baDrYt5gH3bDZC00CzA1gYIjA==
X-Received: by 2002:a63:5460:: with SMTP id e32mr17254953pgm.59.1608591622405;
        Mon, 21 Dec 2020 15:00:22 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id gm18sm16675885pjb.55.2020.12.21.15.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 15:00:21 -0800 (PST)
Subject: Re: [PATCH] cpufreq: brcmstb-avs-cpufreq: Fix some resource leaks in
 the error handling path of the probe function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        mmayer@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, f.fainelli@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20201219101751.181783-1-christophe.jaillet@wanadoo.fr>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1cba966a-2485-3333-40fd-26ffa1c3d78f@gmail.com>
Date:   Mon, 21 Dec 2020 15:00:19 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201219101751.181783-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/19/2020 2:17 AM, Christophe JAILLET wrote:
> If 'cpufreq_register_driver()' fails, we must release the resources
> allocated in 'brcm_avs_prepare_init()' as already done in the remove
> function.
> 
> To do that, introduce a new function 'brcm_avs_prepare_uninit()' in order
> to avoid code duplication. This also makes the code more readable (IMHO).
> 
> Fixes: de322e085995 ("cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver for Broadcom STB SoCs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

We could have considered switching to device managed APIs for automatic
cleanup, but this will do as well. Thanks Christophe.
--
Florian
