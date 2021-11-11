Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F1B44DBF7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Nov 2021 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhKKTMU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Nov 2021 14:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKTMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Nov 2021 14:12:18 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B360C061766
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 11:09:28 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id n29so11448557wra.11
        for <linux-pm@vger.kernel.org>; Thu, 11 Nov 2021 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P7UrfQgvq2ToNlm77Gssyc1qEdXEl3/ohGdZ5AMGoKc=;
        b=jTHhBMWJHP67st2xjCvFM7ngxj+wIYa/qS8o6k5gVSHOkUdNrADsRQhillRzfpRiBL
         vGNR9MJWgJSH3p6D3r0dW97FhcpDiKMc2jYReHfL2vvkktBnIp5cXmRgG+eKVvSMXUbH
         i+uI8afOx7Wn9yh2vDSvB4Em3PrX5XNkJCTM8P2dAE3dIQp1WP0F0FeZQSgmkQoglEQZ
         ezeWI3hP+NDMQawSzTauH3t4XfYPmGOM1pJpYl+urNeGxD7fmjz4JxDVjkqpa6Di+cvU
         J/oF/sGV6MeX+92knM99ILUzNgi/xa5YUZx6fp7cjS7WSEySxc8K9as054lPSPZMHWXp
         oOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7UrfQgvq2ToNlm77Gssyc1qEdXEl3/ohGdZ5AMGoKc=;
        b=t8h1fywhi53rCL9l6xszU9GFfq3F/+Y+l3IRH0kbjweqQvMdPMyzmxPSCRIYOIxhG/
         6I/nVtAhu1LDz1dXRH0V+roNk/wNj0TUKiG7ZnkJ2kO4CdzE7L0qBbTADyyqLF1GCBFl
         UiUT5a0NJ/VobDeMRUn72MLPhDKsT6L2ERdjkLkvqGddAmS4iM8N4ts/5YEwmvWXgpEY
         h/R4gqlEdj0NNdAeA9VNE4OEtgRrNWjxG2N9JQOMjIVG2YQ5VziRX3yWu8GsmIjJLgXP
         MAGmcmoBLpXIbwJ0uXnVBJ7jRKUC4a4niaR09ojF1kcO+iFO/0JnHO4aBW9+GSesrwCl
         p9jw==
X-Gm-Message-State: AOAM533L/pQnBRaMpm9EsV7dOnofsw0oHO4qd/NG84mX+oEXLDghaTux
        UI8ROL9yWkk72HWE9Rysz2e5Lw==
X-Google-Smtp-Source: ABdhPJwZ2NAmfpIN0oS9bg3KQMr4crjCEaBzxw2LROM5FmPPJg29gkbeVZPwW1qD8hCCQ874O6KSlw==
X-Received: by 2002:a5d:6da5:: with SMTP id u5mr11775104wrs.374.1636657766790;
        Thu, 11 Nov 2021 11:09:26 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b8fe:ae15:ab50:664e? ([2a01:e34:ed2f:f020:b8fe:ae15:ab50:664e])
        by smtp.googlemail.com with ESMTPSA id h18sm4219823wre.46.2021.11.11.11.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 11:09:26 -0800 (PST)
Subject: Re: correct source tree to make contributions to Linux thermal
 framework
To:     "Balakrishnan, Anand" <anandbal@lab126.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "amit.kachhap@gmail.com" <amit.kachhap@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>
Cc:     "Healy, Christopher" <healych@amazon.com>
References: <1636488946043.43408@lab126.com> <YYvuAU+d3TAS6fI7@kroah.com>
 <1636656130551.5237@lab126.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5007f2fd-285c-73fd-21a9-ab0029578d4a@linaro.org>
Date:   Thu, 11 Nov 2021 20:09:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1636656130551.5237@lab126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/11/2021 19:42, Balakrishnan, Anand wrote:
> Hello folks,
> 
> At our company, we maintain an internal thermal framework patch. We are exploring the option to up-stream this patch so we don't have to keep porting this from one Kernel version to the other. Looking for advise on the right device tree to get started.
> Thermal framework code resides here: https://elixir.bootlin.com/linux/latest/source/drivers/thermal. What is the correct source tree we should use from https://git.kernel.org/??

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/

branch : next



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
