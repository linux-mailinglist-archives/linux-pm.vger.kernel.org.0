Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43177421A
	for <lists+linux-pm@lfdr.de>; Tue,  8 Aug 2023 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjHHRdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Aug 2023 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbjHHRct (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Aug 2023 13:32:49 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A5DF9A3
        for <linux-pm@vger.kernel.org>; Tue,  8 Aug 2023 09:14:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bf3f59905so853895866b.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Aug 2023 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1691511245; x=1692116045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA7k4XuYhqMiq1aimPn7yYHaKH+IPXSpGngvmVHTGB4=;
        b=Ocrt+7ZW9WknfQ1WZZ3LY17HY6T3ur3vH7tG/zJv00T5xrI8ByGPaT2v0K1Q6RiIMD
         LiMimlDuL/D4KbV1gc9F6Lv6MSK6EVVYX3IJZraelOPoD1hyD+Kk2ZKb6YAXJB0a5rV7
         F396z01R+N3Qs5D2MUrEN5L7UAlRrGIBKunCEzqOcMcCDg5n/WhnSmrUjfATIKcHl6rx
         2CjVen7vEWoOLk7bERkY5sAvUyX3Fscr4i+WEvJjgm5T+7obGqNT/TkeGLyB8H7/qzvB
         xc/4wHinV2JK5pDxr7/OgF6zGo1tWv105vZpY25IeQAA7LxUNVSo6IaNnMdVTJ/Fif7Z
         wshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511245; x=1692116045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VA7k4XuYhqMiq1aimPn7yYHaKH+IPXSpGngvmVHTGB4=;
        b=e4ytleu4uBLORBSu3ap9jfoGPFWLnya854RBr1LcJmg+hzVvmfYLqiAv/Wbm/oyufz
         r1b8vInDWiSez6u3reNQ9u7o07F2PlZhqGW5sbT/vnw3ZC3bYrAIVVHfXwv5xmhJbCr8
         dA5Tn8Bq8Gp1vG8LJjyAoEbjcYIkMmBx6kd3Oxr8tsP6NZvhkFKrzvk8o94zXdtjm6kD
         PZ3M4oBFmRn+chLVap4GXfjV+Cr8Rl9LSo1lmGiXLwVi8Gak+PZmIMjlRFio0f5bFwBp
         6A3uixBAx3ulNJUJGuxw0jTNMWmE2h5HT5/TUoJ0srhuIgQdx/JpqPv/8SeNeT38Wk5W
         1wxQ==
X-Gm-Message-State: AOJu0YxUgirblhOLY44NuZoICdr8TlPJpcvdSZ5esUfujtdvJpervXAq
        NdpCr+TIe8GqeR24P1ebU382l0bOVMVa+UWwWxfTjRjX
X-Google-Smtp-Source: AGHT+IGI3NvWLARIAIJ806WzFo1Gu4YYpyDDo+Y24Lhf1uUKTQCBoWPTHY8UkO7PvmeembXLpAFOxg==
X-Received: by 2002:a17:906:2081:b0:993:e752:1a70 with SMTP id 1-20020a170906208100b00993e7521a70mr11879972ejq.19.1691472062881;
        Mon, 07 Aug 2023 22:21:02 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id k18-20020a17090666d200b00992f2befcbcsm6125952ejp.180.2023.08.07.22.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 22:21:02 -0700 (PDT)
Message-ID: <745d818d-fbfe-da02-b98d-bd7b2c5059ed@tuxon.dev>
Date:   Tue, 8 Aug 2023 08:21:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, maz@kernel.org, srinivas.kandagatla@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        sre@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
 <20230807122508.403c1972@kernel.org>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230807122508.403c1972@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 07.08.2023 22:25, Jakub Kicinski wrote:
> On Fri,  4 Aug 2023 08:00:07 +0300 Claudiu Beznea wrote:
>> Update MAINTAINERS entries with a valid email address as the Microchip
>> one is no longer valid.
>>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Thanks for updating the email!
> 
> A bit of a cross-tree change. Is there anyone in particular that you'd
> expect to apply it?

No.

> If nobody speaks up we can pick it up in networking
> and send to Linus on Thu.

That would be good.

Thank you,
Claudiu Beznea
