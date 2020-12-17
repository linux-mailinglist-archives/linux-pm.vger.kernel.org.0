Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877482DCC50
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 07:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgLQGBE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 01:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgLQGBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 01:01:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1478C0617B0
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 22:00:23 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c133so4423752wme.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Dec 2020 22:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UWUGj7vRR1Ra7bgeGXHDGwnpi7LWLsFY/4lY0Q3LcxI=;
        b=lN7BiMtiodNlR3/k9qYiT21EC2DhnAhv0O3G3JQM2jGQCvWf+0vc9GQH00kiQQrSlg
         FwuxZW3Ui/Jd2hp9bPDR38p7XMoskQNbPEPK6VlGR4NIMFf+bhjdbc8WceDrHGlfu2P9
         /yKYB2eKeQxRN+h4USTzdTJKimh9rmjBlhRhq65ODAzR29T7rmFZMaOH0PLEyvbsRckq
         zPpiod9d6+OGi6BG1Jm1c14qnsu3GvFB2il2WjBvw/jUQfdqI9HlCbpUxrMGAsf5sHYV
         wArBz5kxBtdd0yC1VsUIJkeppsXhSR5AsTozA/xD75/RSTWd4LOp3MWxPCIoZTCFbWdN
         oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UWUGj7vRR1Ra7bgeGXHDGwnpi7LWLsFY/4lY0Q3LcxI=;
        b=ms6bkDldE6fp/DogQp+Ct7d2Ib51PtRS1c9G99BRB4wKpB9ESbUszZa6OhWdVqMVb2
         GjKhhmxxFs6SyZwXrzhsPZ71NB8bf1tklzjBS4y09bWQKEyEjf1aP4F6dgav/ze9Cicc
         UTRENA5xPyIX+OT4B8Ch80OAvbVlaiozSx6rqEoXmBDTgnZRS5c13gCNsqehJDEk24n2
         sle84OCtiO/SfbqN4I+b2g8FiUeCPg652MH0SsShyTudjbWUB72UQDp4Q2NwRhC/lOyZ
         PykeghtSPetGqhZXgKQ5rOq9GE1OTEiINJ5GWTJmmDdTLCj/6WrxtnLwFz3fvbuwVas1
         IMww==
X-Gm-Message-State: AOAM5328njb0/T9CWQlxGf3Gc8OenyqN3HIaiAKyxKCTbL09psWInndx
        uO0itOgy+fBGEpbMg6iYQOf6GA==
X-Google-Smtp-Source: ABdhPJya424XSHoCxm4FRdCMnOQstNEHYDGUW5H/aLIHtUrslwbEA2UyxcnG3A6rNrzkB5i0uUikkw==
X-Received: by 2002:a1c:9dd8:: with SMTP id g207mr6664076wme.15.1608184822061;
        Wed, 16 Dec 2020 22:00:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1? ([2a01:e34:ed2f:f020:601a:58a2:ee98:f8a1])
        by smtp.googlemail.com with ESMTPSA id h98sm7698614wrh.69.2020.12.16.22.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 22:00:21 -0800 (PST)
Subject: Re: [PATCH v2 3/3] thermal/core: Remove ms based delay fields
To:     =?UTF-8?Q?Peter_K=c3=a4stle?= <peter@piie.net>, rui.zhang@intel.com
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>, platform-driver-x86@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20201216220337.839878-3-daniel.lezcano@linaro.org>
 <20201216220337.839878-1-daniel.lezcano@linaro.org>
 <00766bd10b90c0c3bebf25738b782ec9@piie.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <01b55dc9-0b17-4ccd-e930-5318c0693e30@linaro.org>
Date:   Thu, 17 Dec 2020 07:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00766bd10b90c0c3bebf25738b782ec9@piie.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/12/2020 23:35, Peter Kästle wrote:
> 16. Dezember 2020 23:04, "Daniel Lezcano" <daniel.lezcano@linaro.org> schrieb:
> 
>> The code does no longer use the ms unit based fields to set the
>> delays as they are replaced by the jiffies.
>>
>> Remove them and replace their user to use the jiffies version instead.
>>
>> Cc: Thara Gopinath <thara.gopinath@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>> drivers/platform/x86/acerhdf.c | 3 ++-
> 
> Reviewed-by: Peter Kästle <peter@piie.net>

Thanks for reviewing

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
