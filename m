Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0C76BE885
	for <lists+linux-pm@lfdr.de>; Fri, 17 Mar 2023 12:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCQLsM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Mar 2023 07:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjCQLsM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Mar 2023 07:48:12 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DE9ADC3F
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 04:48:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id fy17so2615794qtb.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Mar 2023 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679053681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86bjnBxGCm0NjFMdjhahRkvyPrfitJ2dq65dYbzGQGE=;
        b=GfULVuOXYnL8m+Lb2iOwl8z52CS6ftmCFFgEK+f5Mv8B/TdTnvG93nPLj4aaCm2U+/
         Yn0nmtDT4rHEmTt35RxsU2qIJLdPJFRH7b9S9rzpsNlJiWjNRRJzKG8rM2CrskNb9bf6
         gssqdxav2kNYqw59VaAFVhCC79xjeDlJFyC8rwhn1WZ9E1a2IprszizTI48uUQHsEcG5
         SkP4di08f3/0Lna0J0p27Ctj6Pu+K+zjN1KAbChoHWSHUU+/X2P3vEne6XrZMXvxObMz
         JrjiaC+zudcEnc2iHz3NFjFeuTNzv9L2Pu0+K2Ty4oBD4qirJRBwYxCdMGKuP8UmoYhS
         sNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679053681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86bjnBxGCm0NjFMdjhahRkvyPrfitJ2dq65dYbzGQGE=;
        b=MT6YJwfBp7VANfY7Lder/McR/YeUA7RYmDA8qFH7zSIpnOU6lc3CSvKbkbnJy/NKsk
         yNrhBFMzIHbRBcL5xzuC5nLah7m33TvDOJqglfs/ZnVhbR8wjqF1UX82Nw3pdTTyD+PJ
         C9XSJcnUTiK8xRJIiijriZkk/iKKik4IJARpkhwEoQkP+qkoiIGt6a6gzPymFjqQX9+t
         9rQxUDtnwXxhG5jmNhQ3fsLpwiz4EKl6TcZZdOOcCUVXjwgGu1LnQOYLA16CSJrayu2F
         I8v947Rcle+izU+DabwUMhv8xy6sZNu9+ni7egM7Yxf9o/D/If/nueA6uNMjTw92ewX6
         eYNQ==
X-Gm-Message-State: AO0yUKXMWMgwqqB7ASiTl/SbnM4ZCpiuwgHfcD+41ZceMmcA0N0schA4
        dOtLX7YDlcmMWY/Aw3wSZB0=
X-Google-Smtp-Source: AK7set/zCQkWO+dI/Zekg7QMT8MO+asb3mCImfwhLs4bE8HMmvLoCW2/CDmRp6RFNnhw7/QPEeA7dA==
X-Received: by 2002:ac8:5986:0:b0:3bf:d2ed:ace0 with SMTP id e6-20020ac85986000000b003bfd2edace0mr12925381qte.13.1679053681078;
        Fri, 17 Mar 2023 04:48:01 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id h12-20020ac8568c000000b003d75bb8e652sm1141745qta.65.2023.03.17.04.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 04:48:00 -0700 (PDT)
Message-ID: <42aa3ce0-b1a9-5c4c-173a-eb671ea00f71@gmail.com>
Date:   Fri, 17 Mar 2023 06:47:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] cpufreq: warn about invalid vals to scaling_max/min_freq
 interfaces
Content-Language: en-US
To:     qinyu <qinyu32@huawei.com>, rafael@kernel.org,
        viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, zhangxiaofeng46@huawei.com,
        hewenliang4@huawei.com, linfeilong@huawei.com
References: <20230316031549.1343340-1-qinyu32@huawei.com>
From:   Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20230316031549.1343340-1-qinyu32@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/15/23 22:15, qinyu wrote:
> When echo an invalid val to scaling_min_freq:
>> echo 123abc123 > scaling_min_freq
> It looks weird to have a return val of 0:
>> echo $?
>> 0
> 
> Sane people won't echo strings like that into these interfaces but fuzz
> tests may do. Also, maybe it's better to inform people if input is invalid
> or out of range.

AFAICT, the patch doesn't actually cause it to error if the input is out
of range. So the commit message should not be worded to imply that it does.

It is good that it doesn't, I think, because someone might have a
fail-on-unhandled-error program (ex: shell script) that writes this file
deployed on hardware with different cpuinfo_max_freq. A new
unanticipated error would cause such a program to crash where it hadn't
before.

