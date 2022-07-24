Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED14657F667
	for <lists+linux-pm@lfdr.de>; Sun, 24 Jul 2022 20:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGXS2A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Jul 2022 14:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGXS17 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jul 2022 14:27:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D5610559
        for <linux-pm@vger.kernel.org>; Sun, 24 Jul 2022 11:27:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso5168365wmm.5
        for <linux-pm@vger.kernel.org>; Sun, 24 Jul 2022 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=qt1aI68JPk+yFMgieLmwwFbYBpyY4LDiXmO9WB/LvSU=;
        b=tzrGLmAQ89B4gqHZfsNPAiZ3PRHVJftO8zQt//3j9sGVDEI9Bh1rbSa6dw6cJ6ipkg
         iKLzn9lHpOgrPLU8rjHVn3DG3Tdf7DXyTHjoIV3LqToc7dBKiyyCHS8yLFsYuJ1UDVnV
         9JzChKeXmrlrPmHc2RZ5aD1/ZOo54nhZFg70wj2g2HF4VKZcllgS3gWDZye3AjI28aWo
         p2CkSGy82Wg2ovRrlYEpt9Nj5QZ88G+7OajBkN2YAnFWLg4f81Zqk0mpIc7RTsbzPI/y
         CM7jIq3X2DF0s9TyiK8BEPKKtCQQiKZT1guBLz13QgJJJXDmhTvx6+tWodcv2mFMGaHO
         OUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=qt1aI68JPk+yFMgieLmwwFbYBpyY4LDiXmO9WB/LvSU=;
        b=Ao4gRClgWdE/CkHkwcZr3CmJfzn8pz8StyjUt/6D3fCbMejQIN1sIeY84Wec86eEUC
         972uwp+dUhBFx+ux/UYmvNcZSbxVozs1gddGstdjYiSZvIYM+C24SIfD7lPTPxT9gyl+
         mrAjR83EiqiArNZTBZv9l54mEU2Bm7NPha6sAOIXbZbO7+6zrSd/oWoePvGvbh49QlG1
         PtA0hNE1Mtk6Ja7xSSNtUG2cY/ohOeMvZ9PXmoMjYd2Scg61oouq9c3PK0T8+zoYXPFs
         uqu2n0QBmwoLDtMSdlie28R65GiO1I73r0o8fykO7r/Dl1zyO6AdnKnJtd3wGxYAq9XH
         A1bA==
X-Gm-Message-State: AJIora8vVXopGP2LnB1bZmQcq2dgzEwd5P0y20rveV6Bbzf7Bakfxq2P
        tiG26fr8IN5/qTiMKF/Too+t4g==
X-Google-Smtp-Source: AGRyM1sjq6r4lCCXcIRAD2gAykcxk/ihD6ntTZG2GPA59qR4zIAwbQZPeCh4DrsvPKk2AM7HiNYswQ==
X-Received: by 2002:a05:600c:a47:b0:39e:f953:84e2 with SMTP id c7-20020a05600c0a4700b0039ef95384e2mr18497105wmq.202.1658687276763;
        Sun, 24 Jul 2022 11:27:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:feb7:6a58:3e0f:a58f? ([2a05:6e02:1041:c10:feb7:6a58:3e0f:a58f])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b0021e4edba1e5sm10102085wrp.111.2022.07.24.11.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jul 2022 11:27:56 -0700 (PDT)
Message-ID: <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
Date:   Sun, 24 Jul 2022 20:27:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
In-Reply-To: <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Niklas,

I tried to reproduce the issue but without success.

What sensor are you using ?


On 19/07/2022 11:10, Niklas Söderlund wrote:
> Hi Daniel,
>
> Thanks for your work.
>
> On 2022-07-10 23:24:07 +0200, Daniel Lezcano wrote:
>> The thermal OF code has a new API allowing to migrate the OF
>> initialization to a simpler approach.
>>
>> Use this new API.
> I tested this together with the series it depends on and while
> temperature monitoring seems to work fine it breaks the emul_temp
> interface (/sys/class/thermal/thermal_zone2/emul_temp).
>
> Before this change I can write a temperature to this file and have it
> trigger actions, in my test-case changing the cooling state, which I
> observe in /sys/class/thermal/cooling_device0/cur_state.
>
> Likewise before this change I could trip the critical trip-point that
> would power off the board using the emul_temp interface, this too no
> longer works,
>
>      echo 120000 > /sys/class/thermal/thermal_zone2/emul_temp
>
> Is this an intention change of the new API?




