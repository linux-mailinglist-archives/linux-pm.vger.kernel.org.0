Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3252E56A229
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 14:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiGGMhj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 08:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiGGMhb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 08:37:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC1125C73
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 05:37:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id ay25so902541wmb.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 05:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IQSNyij1zzfzY4iwOOgBF0n7a6XIfStBbfb72/OYucI=;
        b=efCNUJMPLSymMwWjaWzvPl7cyHSzYiiCxLcVUroM89rxmrMk5+stBiVYUBOJKp5eGx
         F0DlVntaQbFZPeGx3WGUICBlRTYqvmIgVnmOWt5b6SVagJlFB39+qooBhnF2g5tCr4hl
         bLn13gA3Qfk1Jaw2433sYyqjvXNYz/dfLVnR0rclEtHtBrK2dnYs0OUd609Muf+DshE5
         K3uKsRZ2VIlsBCYPKH5YVI9Ha1ZBv3mLiBJT2jdJPze0A8PCeZPp62Yfso2Nvm7tMO/z
         lho7889TJX2tWPpnZ8iDjOcVPP8QMQmcwfq01dmfWK5UaCwgVdDzlOIM7TiDxxrC3J8a
         lLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IQSNyij1zzfzY4iwOOgBF0n7a6XIfStBbfb72/OYucI=;
        b=HZtF6vgRDq8EcmZDztzOrEQoAir3yE2+2RHwKCJrPNIH2L3VLuDh1xa1H2T8yMncX+
         NTntbGVHgplnqbamEPP2inKjtJWU6VvL95jxBKYZHhYPKaH8xt/VjO3bSeVZCkhr/VKT
         e7HqEnODX3T6qgMxLcUs8luJ6zrcnjA+5BjEWOaDJl5A8IDqs5gqBcarXDIPoP/i5j4R
         JpUYmCq7Eg5slCnK2tGwrmHs+2HRUrO1cizj159dwiMZ1iUxAvinpZauJmIBMSgWNq7g
         Ej9ZueV1GQWpZ4AY1rMie63nIqqhY1OeeBVCzFgUlaYh3kWYT8Kp+RjnA6ltYHRZQNrf
         cH6w==
X-Gm-Message-State: AJIora8INfeEmByc+sux8TB1ocyjPFEtq0PPUDUefTtm44/NyF9XAHz4
        Vuc9IIW+GQIVNEsF4ODyIUNRFA==
X-Google-Smtp-Source: AGRyM1vVUGrRm3AF6K+6X9VD1A536tCyInsX+hOBlqrOrlQZABmjNKo9d4klcELHOV+qT0TRIgvJeA==
X-Received: by 2002:a05:600c:1d85:b0:3a0:3d28:bdd9 with SMTP id p5-20020a05600c1d8500b003a03d28bdd9mr4494396wms.114.1657197445701;
        Thu, 07 Jul 2022 05:37:25 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bn24-20020a056000061800b0020fe35aec4bsm37579172wrb.70.2022.07.07.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 05:37:25 -0700 (PDT)
Message-ID: <b92b3011-15b9-9390-5804-feb0650e255b@linaro.org>
Date:   Thu, 7 Jul 2022 14:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/2] thermal: rcar_gen3_thermal: Add support for
 hardware trip points
Content-Language: en-US
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20210804091818.2196806-1-niklas.soderlund+renesas@ragnatech.se>
 <20210804091818.2196806-2-niklas.soderlund+renesas@ragnatech.se>
 <40b2b8d1-f86c-4788-767c-22e60283e458@linaro.org>
 <YsasmbJotSd/aIu/@oden.dyn.berto.se>
 <2605a591-abf9-01ca-015c-efc3978803b8@linaro.org>
 <Ysa033e3BnH+wVBM@oden.dyn.berto.se>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Ysa033e3BnH+wVBM@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/07/2022 12:26, Niklas Söderlund wrote:
> Hi Daniel,
> 
> On 2022-07-07 11:55:55 +0200, Daniel Lezcano wrote:
> 
>> Thanks for double checking and confirming. I've a patch removing this code,
>> no need to send one. I'll submit it along with other changes around this.
>> Perhaps, I'll try a revert before, it would make more sense.
> 
> Thanks.
> 
> To be clear I don't think we should revert commit 47cf09e0f4fc5120
> ("thermal/drivers/rcar_gen3_thermal: Add support for hardware trip
> points"). Only remove the 4 lines it adds to rcar_gen3_thermal_resume()
> as they are redundant. Does this match your view of the revert?

Yes

>> Do you think the 'revert' should be backported ?
> 
> I have no strong opinion, I think it's a matter of risk :-)
> 
> There is no real harm in writing the trip points to hardware twice
> during resume. On the other hand if we *know* the thermal core in the
> backported kernel will always call set_trips() after the device is
> resumed, then there is no harm in removing it.

Yes, I agree.

Thanks for your feedback



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
