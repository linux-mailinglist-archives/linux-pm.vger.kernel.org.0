Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71652465081
	for <lists+linux-pm@lfdr.de>; Wed,  1 Dec 2021 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbhLAOze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Dec 2021 09:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349993AbhLAOzc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Dec 2021 09:55:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC339C06175B
        for <linux-pm@vger.kernel.org>; Wed,  1 Dec 2021 06:52:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l16so52836142wrp.11
        for <linux-pm@vger.kernel.org>; Wed, 01 Dec 2021 06:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhTR2RpsOZhfttIaymZmouctyuIz4tPGUr5syZXyOfw=;
        b=MUypRpEUojQzx/+jVSeK8jvkUN24wUxp5R21Cb+6e4KzmUWvSxxhKAw+8h0jHC2CHD
         wsM3iwtBKeP0HxKuT/fQDOMypUS1KtqPiUaV6qZsG7Np75PbXaGmDTGvc87NYDSwzvE6
         PcJRKerUfid+KfSiAznnppzVg4mox3NBjG/Wukw667Ts7uoy7v8VW5e0v/kmNXLLeQ9W
         jtLBTMHnUDtbg2N8gqlIoJm0edeDRMOJCGLyLavFj2b2XXpMlKdxs/RsBi0c2fVLTLIS
         vkgKLn1vU6yMmd4j/iTMQW+E9hmyHk2utbl3YPwrIhe8lO8/raC93sB/avU9umYaYGmd
         D+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhTR2RpsOZhfttIaymZmouctyuIz4tPGUr5syZXyOfw=;
        b=78sjWUqHew4BLNM5GbQOeUp/b8QdoEVO4UnUcS9m8Lv9eWzv3F4sKsTNJJ8gyASFqo
         TTUxiFXacaj1PY964nnsEg6uRO6M6lmFNVxdii+s8fXvli8soTzABNxIWC41U3e/spep
         6Iu0CHcp+f7xzXJVnOf5YxsvpLxy8raJT/79Pu4w6QcJRFvdvftnRb+PtAXYiSFrWTJS
         wuy/JAORVtFcQG7tv6D/mjlVPlaXPzYBdCp4lXygDLelgWvhTualEbruj3w+9T6gX1y6
         NJyYvys8bdBLnOyb23jyBMtRnu04RUJz2qJSlnIWOQhI3QuFT8e8EFA9/KDHv+IniIwT
         THnQ==
X-Gm-Message-State: AOAM533c8QeJ4kc1b4H0b8LveZk5VzNBb4MQzP7aruh4V82UAeP9L32b
        LaIIaEzN9wU057hBpGvQ50KvLQ==
X-Google-Smtp-Source: ABdhPJzmTM+J8lTU0oSwYtK5coE+pWqm1t/3x/xfsR7qdtxGBPS+aOFY3Ju2lTSioE1GKQaj8eHTNw==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr7230935wrv.212.1638370326265;
        Wed, 01 Dec 2021 06:52:06 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ae29:582a:93e5:4eb8? ([2a01:e34:ed2f:f020:ae29:582a:93e5:4eb8])
        by smtp.googlemail.com with ESMTPSA id e12sm89434wrq.20.2021.12.01.06.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 06:52:05 -0800 (PST)
Subject: Re: (EXT) Re: [PATCH 1/1] thermal: imx8mm: enable ADC when enabling
 monitor
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Paul Gerber <Paul.Gerber@tq-group.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20211122114225.196280-1-alexander.stein@ew.tq-group.com>
 <2786750e-0556-a1b8-e464-30de05ce7cf2@linaro.org>
 <ea1af2b2091c0cab822c9ef5810db6936365d7ef.camel@ew.tq-group.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f3248b92-c6db-c3a3-f26a-65a2fd272d4c@linaro.org>
Date:   Wed, 1 Dec 2021 15:52:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <ea1af2b2091c0cab822c9ef5810db6936365d7ef.camel@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/12/2021 15:45, Alexander Stein wrote:
> Am Dienstag, dem 30.11.2021 um 15:49 +0100 schrieb Daniel Lezcano:
>> On 22/11/2021 12:42, Alexander Stein wrote:
>>> From: Paul Gerber <
>>> Paul.Gerber@tq-group.com
>>>>
>>>
>>> The i.MX 8MP has a ADC_PD bit in the TMU_TER register that controls
>>> the
>>> operating mode of the ADC:
>>> * 0 means normal operating mode
>>> * 1 means power down mode
>>>
>>> When enabling/disabling the TMU, the ADC operating mode must be set
>>> accordingly.
>>>
>>> i.MX 8M Mini & Nano are lacking this bit.
>>>
>>> Signed-off-by: Paul Gerber <
>>> Paul.Gerber@tq-group.com
>>>>
>>> Signed-off-by: Alexander Stein <
>>> alexander.stein@ew.tq-group.com
>>>>
>>> ---
>>> Often this bit is set already by the bootloader, but in case this
>>> is not
>>> done, the file /sys/class/thermal/thermal_zone0/temp will always
>>> return
>>> -EAGAIN.
>>
>> Does it deserve a Fixes tag?
> 
> The more I think about it, the more I'm inclined to add one.
> Please tell me if I shall iterate v2 adding a Fixes tag (or other
> changes)

It is not necessary to send a V2 as the commit log will have a link to
this thread. Just answer with the Fixes tag, I'll add it myself to the
change log.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
