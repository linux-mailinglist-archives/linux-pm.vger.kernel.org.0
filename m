Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45338688389
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 16:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjBBP5z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 10:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjBBP5k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 10:57:40 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD272645
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 07:56:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4059575wmb.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 07:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99968d0mm1LQlV7FJfw5p+HomojgxRqcNOEkSpDZsMA=;
        b=ZSZR8w8HbvMhC+h0X2cHqNY6i4ijvCJlfuNuo0/S4yx8vREaSg1T2UGs93u0He6OBB
         nynGeRShOG1Vr4k2id0z1iYEbN+5+u+G/3v55cQ5pgbVfMoJptbF3HCkrrJFeywSe3ya
         uHzwZ349AAoQ1tQDY2Sp7Aj1nuDzd5OrXP79M7RIAJKxDdg94BALUO9nkGhA8eVwSag+
         65G4OwBTGHPKZAIUFbz5l5TY5F5dBXCyirIYGXd1T9/GSKO/S5msjWHVFCcDPjR4TyTU
         77wFIoObuNK4hkyOOvb4uNzuv+iSFCksKQ+8BecyWhyKAhW2UFEvNrO7x4lGihxJ/tjw
         j+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99968d0mm1LQlV7FJfw5p+HomojgxRqcNOEkSpDZsMA=;
        b=5XDLTvSgv9TRm+SpYRsK/nJpR4ph+q4HNmCzvtVyhb3KU5G3t+CFhPy/8vTUVqJh8R
         nKokPsUmB0yrgj14FYFrb067TtrC4W+60kJlB/+vH2d5Rss9tEREo4yZH9biLpHgGOeU
         eCid7pqkRdnBNN9z1LwpP4z8/ddFyO7IW0AS7Bf5WA8SZPS/yKcDDWGRi7kxNsezy2z5
         Z8z8yu295E2/bM+aALasKlYTBHYN7hBa8Nqilq7I03MsQjr/gM7+NG+XiwM/cjNqwIlY
         Bs6BsnuvMp1NcvhLloVTQe31gFzxT84eg2xujUjqYjefvqsOtk83kXZF8Cl1yPw+7cvv
         cyow==
X-Gm-Message-State: AO0yUKUQRhBPgFh9Qwulkknu8YLQiooL/h6wHIFtUZ0LbqKb8jD4mvmT
        zIgVZMumZDZ4wfIynDV3kDWQYXqnnLqWJRXh
X-Google-Smtp-Source: AK7set9GDnie7nr+qU25Exw6d95n4+U2pBygGp1lhPj89Y/R3QsatB0fZWe/iwttbtA5osEBT1f/xg==
X-Received: by 2002:a7b:cb07:0:b0:3db:25a0:ca5b with SMTP id u7-20020a7bcb07000000b003db25a0ca5bmr6553235wmj.37.1675353368230;
        Thu, 02 Feb 2023 07:56:08 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c3-20020a05600c0ac300b003db012d49b7sm8598131wmr.2.2023.02.02.07.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:56:07 -0800 (PST)
Message-ID: <2bc6368b-b089-a229-63d6-932930b9b78c@linaro.org>
Date:   Thu, 2 Feb 2023 16:56:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] tools/lib/thermal: fix thermal_sampling_exit()
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202102812.453357-1-vincent.guittot@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230202102812.453357-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/02/2023 11:28, Vincent Guittot wrote:
> thermal_sampling_init() suscribes to THERMAL_GENL_SAMPLING_GROUP_NAME group
> so thermal_sampling_exit() should unsubscribe from the same group.
> 
> Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Thanks for the fix, applied


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

