Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E415783F4
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jul 2022 15:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiGRNle (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Jul 2022 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234440AbiGRNlb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2022 09:41:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535981EEFF
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 06:41:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk26so17082694wrb.11
        for <linux-pm@vger.kernel.org>; Mon, 18 Jul 2022 06:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ObygcEU1bNP9YjBSNZrLdihUIKljQZCQS76fCIhiELs=;
        b=xmUf9BGDfcUW0JrUxYEEz2+ksVKvB4+1vH6AFEdp+UonQsM3WgEIb1hZRiHgOWa/tj
         eU3v2ecl08TSl7Q/Zol0g9W14RPSfvXCvskVpFAr9SXbHJwUgcA+4CyHjQBDyTk5t+ME
         J3a3WEl7dhEa6iSWLIg7WoIalbB24nhuwPX7UP/VYnO4TJjeCYE094HAcvkCfUHhqN/z
         +e4A3vClAelhY76nfA37TgGrhPboegrPeb9KH85Xm0u/PPJbXCh/wMfLydedsSZeVYU3
         CMeal+6klsKoOHem040b6+b8QaQHkXl6uxW+ncrWMYUNQ31EAY+FjxLJEjeETBkCTYI1
         YQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ObygcEU1bNP9YjBSNZrLdihUIKljQZCQS76fCIhiELs=;
        b=ZiVbhsHu1yKWQb1c1R7rMsXpYgWj2SGViOkTOw8e+gvqW1lk2WmoVLzu/QJtArX3/x
         WYYPi3Y3W4WYD/eqsp1W2JysiOb2jj7Vy1pfTW0GLFx9sIAFjh2WX5Um+++y0Xu77d8G
         Emjgrmyyv9wudn17G5gSv8HATVrMdKx5M0hBxUeJ3kACNUz7N2cm+SdznhbmUBgxRdQn
         IQeATWlwOXkNK3WGkxtV684lX3hBTXmQvAwM5bgus0Bm5ZXpmOafqgA62DVtkylPPh1E
         977w3wBmBdaO6SYHM4sA26tpCYOJnKEYce5d+uYf18XUhgftGDPSd9/rtN4N0jGxYnib
         eRFA==
X-Gm-Message-State: AJIora/AQI3KntsgbyXGrKnGbjflPnBqO/zLnbHqa+InuhMRsx3CKxcD
        iw1RqmVFpUE/8SxVvWpJz5FQzQ==
X-Google-Smtp-Source: AGRyM1sX4SdS4hxELeQt8BctkLxRCKDuX4Q1o6cLJCy8Cmmrokad4dkj/Qz35gCKJaYntdV5ZCs4dg==
X-Received: by 2002:adf:fe81:0:b0:21a:3574:ec8e with SMTP id l1-20020adffe81000000b0021a3574ec8emr23420218wrr.410.1658151687784;
        Mon, 18 Jul 2022 06:41:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e? ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.googlemail.com with ESMTPSA id n6-20020a05600c4f8600b003a2f89c4bcesm18790439wmq.43.2022.07.18.06.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 06:41:27 -0700 (PDT)
Message-ID: <8db06b32-4baa-17ef-be93-dbd887b6125e@linaro.org>
Date:   Mon, 18 Jul 2022 15:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] thermal/drivers/rzg2l: Fix comments
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Pavel Machek <pavel@denx.de>
References: <20220718121440.556408-1-biju.das.jz@bp.renesas.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220718121440.556408-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/07/2022 14:14, Biju Das wrote:
> This patch replaces 'Capture times'->'Total number of ADC data samples' as
> the former does not really explain much.
> 
> It also fixes the typo
>   * caliberation->calibration
> 
> Lastly, as per the coding style /* should be on a separate line.
> This patch fixes this issue.
> 
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
