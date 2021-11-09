Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B888444B09B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 16:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhKIPtN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 10:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhKIPtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 10:49:12 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B4C061764
        for <linux-pm@vger.kernel.org>; Tue,  9 Nov 2021 07:46:26 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so31464232otf.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Nov 2021 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Nhd1cXLoARHfuxijxW1CC8tXdTo48PjAHCwKpZq0Ohs=;
        b=IKxmNKTX0BIWoiJVskOWy25AW2N8zqTy4fIP0lluheBJPb6RR1HGWEcAHuwHK3XXKN
         nQFDNMBxdgoBMZ+zfGlDzEFGyZVsZFTU9hhONQ+Yn+3HIgl0qlMdLyRHuMbYRYDyHf0v
         TiDtEXaMz3rSGQLrg8ez3XZs+rszck4hArdyX5U0D3YELE4JsUMpnh5JJ7C3/CuyMs/r
         54vcG13G//Zju+1iQhAWmTogb8mWB7XfGblWrJFFMT7PO6hka0efOdxIxJyTvnHYMAGS
         qlphXdeiSYmFj9I6WwLQA+3zxKXUo8CMUH4gpUxzADZIsjcahm5O12FMBbotMKTxiXRb
         Yg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Nhd1cXLoARHfuxijxW1CC8tXdTo48PjAHCwKpZq0Ohs=;
        b=hjVIWEsTU8Mz5IMhDr0zjiufLvg4qkcL5KzoxBpW45Nm2GYF1jNIcXF5Sdbso3BF+Y
         5WWNVsH2UN1HBiXNtCnwmDJzSP63OleTKLrCv+KJn/9tRtjzAbj33A7WsV8deHvkFlDt
         fHnhpMhdt6ReZtqtXHKLQ4khxvA3DZC1kXvPk4QG8hpE6fSLQYuKgWCJmPfPi8ClsB98
         K1dPz79gbqFBl1gSL8EtyZxdaS7dfICeliNes53PNCCGWhbzDoWDChjGjBbg+l1PcrXb
         LElEFxDEJRUP5VtGiUrcgkIj/qFaC86W2QLRCyXtDJwgFsZVLqdpmXQ8va1kx9oskwfm
         n0zA==
X-Gm-Message-State: AOAM533C5nltLMS+w6BzijyQIi9AEcgQIuoV6Oqw0kjuIGX6kDdu8FWT
        xngPan2nB+Z9MG2U8EtZfrPmlw==
X-Google-Smtp-Source: ABdhPJwMddWy/2opZdv1H0HcP66DI5B4SNXuxuecEiT10xIXb7rTcbNEsMS/6lJop5oEBqi3iRisPA==
X-Received: by 2002:a9d:6f09:: with SMTP id n9mr6847374otq.357.1636472785577;
        Tue, 09 Nov 2021 07:46:25 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id v66sm7430632oib.18.2021.11.09.07.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 07:46:25 -0800 (PST)
Message-ID: <ac3f1771-0516-48dd-ee4d-5752e0433472@kali.org>
Date:   Tue, 9 Nov 2021 09:46:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 0/5] Refactor thermal pressure update to avoid code
 duplication
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, sudeep.holla@arm.com,
        will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        bjorn.andersson@linaro.org, agross@kernel.org
References: <20211103161020.26714-1-lukasz.luba@arm.com>
 <c7b526f0-2c26-0cfc-910b-3521c6a6ef51@kali.org>
 <3cba148a-7077-7b6b-f131-dc65045aa348@arm.com>
 <9d533b6e-a81c-e823-fa6f-61fdea92fa65@kali.org>
 <74ea027b-b213-42b8-0f7d-275f3b84712e@linaro.org>
 <74603569-2ff1-999e-9618-79261fdb0ee4@kali.org>
 <b7e76c2a-ceac-500a-ff75-535a3f0d51d6@linaro.org>
 <f955a2aa-f788-00db-1ed8-dc9c7a1b2572@kali.org>
 <59054c90-c1cd-85bf-406e-579df668d7b4@linaro.org>
 <eac00041-a1b8-0780-931d-52249d538800@kali.org>
 <2c54dbbd-2ecb-fb76-fa9f-9752f429c20e@linaro.org>
 <97e93876-d654-0a89-dce1-6fe1189345e2@kali.org>
 <d83a5c25-2eae-3626-f78a-e42915076556@arm.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <d83a5c25-2eae-3626-f78a-e42915076556@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 11/9/21 2:29 AM, Lukasz Luba wrote:
> Hi Steev,
>
> That's interesting what you've done with Rockchip RK3399.
> I would like to reproduce your experiment on my RockPI 4B v1.3.
> Could you tell me how you to add this boost frequency that you have
> mentioned in some previous emails?
>
> I want to have similar setup to yours and I'll check all the subsystems
> involved in the decision making process for triggering this boost freq.
>
> Thank you for your support.
>
> Regards,
> Lukasz


Hi Lukasz,

It was actually something that Armbian had been doing as an overlay for 
their setup, and I thought, why does it need to be an overlay, when we 
could simply hide it behind turbo-mode so that if users want to 
overclock, they simply echo 1 and if it's unstable or cooling/power 
isn't enough, they can echo 0 or leave it off (boost defaults to off) - 
so that being said:

I apply this patch 
https://gitlab.com/kalilinux/build-scripts/kali-arm/-/blob/master/patches/pinebook-pro/pbp-5.14/rk3399-opp-overclock-2GHz-turbo-mode.patch 
which adds the 1.5GHz for little cores and 2GHz for the big to the 
rk3399 dtsi

To enable at boot time, I simply have "echo 1 > 
/sys/devices/system/cpu/cpufreq/boost" in my /etc/rc.local  And to 
disable, simply echo 0 in there (it defaults to 0 so it's off and most 
users won't know it exists.)

I'm pretty sure this is "abusing" turbo-mode, but it works well enough...

Hope that helps,

-- steev

