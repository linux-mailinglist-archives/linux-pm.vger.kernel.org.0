Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E843844B309
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 20:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbhKITMh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhKITMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 14:12:37 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4395C061764
        for <linux-pm@vger.kernel.org>; Tue,  9 Nov 2021 11:09:50 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so185939otj.5
        for <linux-pm@vger.kernel.org>; Tue, 09 Nov 2021 11:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YdPVVIaRA9wZMcPze3gudkM9XosVYjHa9S8ytOo71/4=;
        b=PV9r+D2OqtUgjOJXgrPBeNWTsrgFcJbFCEuXvmhikRrPdG1J9r/ASKdoRvvSskX9Il
         HskGBwKVkwbj3qIsMU2C3sQqUo6Nja+FSnn7W8S/Xz2Hxl1PvD0/M2wO9LjANltMvxA2
         1ScTcoRUmzODmo5XsBDgICGbeB+ZHUYq/Iy6SxCJVkxChK+5tl0xbc/EZB28AMxNPqyt
         zZkv57ukvAgRMgwljljMEP1TAnCR5IKVBc4URObFsHqQJAy9le0mG+A7Kl3GaTpLqO4B
         LnzLKJNrWAqmWwO/TddryaWv+YpoaZREK/ha6a1B3e//Xn2WF5KyZwP+M3aSt5Sqi9B+
         reaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YdPVVIaRA9wZMcPze3gudkM9XosVYjHa9S8ytOo71/4=;
        b=2PGVoMjaoO42Oo/MafBPsXjDyoal7GCBVOvV7UQBNmkxlsjSxEZx6OgqRQ+N4Or85j
         9hsF7hlxPdD6rTjGroaXKC/X20C8X/I4RWyIQMN0W0vEu25372LWu/AHRYNeDSh5xpyI
         ZHvAJigJDIMOJsLV2uxJd5/nRp9kPmyTlfhjh/BcEiAKiDl0NgtfZceTAK9xPjI24/lL
         zuZnf/qucPKlNMGJIZcXnNJgZN9m/MfHtcqmXsO6bFRtgINfXBgRCDWhZmmnZC4e/8j8
         zL+kf/g5tOWCnjWVJjzEnsTU/b0stUGrtwXiwQdv23hJTLV+lpABSZywQ604/Owhgief
         V0vA==
X-Gm-Message-State: AOAM5306s1F/2CkJAYKu6jfm3u0glHirOmGRk87UIqb6PFRsYza9fFw+
        5jwSzQdX4u7hQevhN5S5v3LEXA==
X-Google-Smtp-Source: ABdhPJz4F0soEuQPkxct9n1zHSq0FgmCq95t9B6GjehW4Gmx6JlCzEh1+sJsgVPju2IHgoU545c+NQ==
X-Received: by 2002:a9d:d53:: with SMTP id 77mr7985376oti.156.1636484990081;
        Tue, 09 Nov 2021 11:09:50 -0800 (PST)
Received: from [192.168.11.48] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id y4sm7903049ots.73.2021.11.09.11.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 11:09:49 -0800 (PST)
Message-ID: <83bab944-cc89-bdf9-e187-7d61a2494935@kali.org>
Date:   Tue, 9 Nov 2021 13:09:47 -0600
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
 <ac3f1771-0516-48dd-ee4d-5752e0433472@kali.org>
 <19ecab72-4a2f-1f4a-b999-d3967a4a1a76@arm.com>
 <676d79ca-ae2e-f5fa-1e54-253efd6934d4@arm.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <676d79ca-ae2e-f5fa-1e54-253efd6934d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Lukasz,
>>
>
> I think I have figure out what is going on with the issue that
> you've reported. On this rockchip platform you are probably using
> step-wise thermal governor, which tries to decrease/increase
> max allowed frequency step-by-step walking through the sorted
> frequencies. So it would always set the thermal pressure to 0
> when the thermal throttling is gone.
> On the Qcom platform there is a different policy in HW/FW which
> controls thermal and it can simple remove clamping 'instantly'
> and allow all frequencies also the boost one. The highest possible
> frequency is passed then to the this thermal pressure machinery.
> So we see the warning that the boost frequency value is trying to
> be passed to this arch_update_thermal_pressure(), but we ignore
> such big frequency value and unfortunately do not clean the previously
> set thermal pressure. Then the scheduler still sees the reduced
> capacity on that CPU and cannot request higher frequencies.
>
> The v4 patch would allow to pass the boost frequencies values, so
> the issue would be solved.
>
> Regards,
> Lukasz

Sounds good, I look forward to testing v4 :)

-- steev

