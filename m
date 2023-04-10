Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C886DCBCC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Apr 2023 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjDJTwE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Apr 2023 15:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJTwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2023 15:52:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D5F1BF0
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 12:52:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id g5so8793989wrb.5
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2023 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681156319; x=1683748319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=taWwTe6wScZ3G/J8fctKbIgQCcWpQ5BGQKWdQ0SkwQU=;
        b=ahiGf8+XiIR4j7Od31UPEYNcuHdiFPpx5kFdggaXF3v3e4owxzG7/R2yvVVFsHj1iX
         OPyXGvIp9l1AYmZYwISymshoequq1vBuMPcXrVJPISUFcu4DzB/AgCw8HojUsiAA2o/5
         q8GreNulQY1z6cgTgpZD9CM6FtsyNmRelYMvY9ckG+shw2cYfL0e9yBQqgy/WNEVNPCV
         TncakvHjGclIsiufR1Mr26ub+mIYvxqUkYRQNQNaskNN0kg4rtLiS+GeNir3FAtGQ15s
         nR7BK1U6ERtutIKLTcqTUQAAi0dxUCqCaHMz66WHhKMpqGv/Q4pyHK8Qcqyi9jyZj72Q
         bUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681156319; x=1683748319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taWwTe6wScZ3G/J8fctKbIgQCcWpQ5BGQKWdQ0SkwQU=;
        b=be7kR8IUxmbGWDMZYkfWncYbHPgCe9XfSPkUSAcnbEZfn5PW/uOLNSUbEjnNWHhX4Z
         h2jKKB6NqVvPBXz3lXHkJkoSTfqKNerdW4ZnWCGj8vzslWCcxG8S0jVpPDXGb7+VT7pa
         Unezyuqp3DL+cUQNc11huAImgwnizTTKfdlvxA7Aq/01pRtaaKx9tPe4DXQB1irZl5RB
         B2SJYauRQo86qA4E74Il2HTQc84Mk4owihf56qft+eQDXbIOMiQFeQIAWHswJpUz6gos
         SHl/9DxJQfpHIKC6iscYLeZYO3QIDhOVmk8JcTMcnqbwLIV2vc3lYTXt43+ox+wFRyEg
         qqnA==
X-Gm-Message-State: AAQBX9fovuIbsa1piEDodxL3GKZEqHAeHCyKzXFtz+i/BaZO0NfEZjHF
        u2BKbonuIeHrQ5augukN5MIZFg==
X-Google-Smtp-Source: AKy350YTQMgKrxdoT+dffU+cBpX25HAoMr6sq7alo7PPBJSJPU6mhT5W2NVr80wYbMoAD+oIYMZ6Bg==
X-Received: by 2002:a5d:678c:0:b0:2ef:b6e6:5985 with SMTP id v12-20020a5d678c000000b002efb6e65985mr5467620wru.58.1681156318776;
        Mon, 10 Apr 2023 12:51:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2611:592:3b9e:d2ae? ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.googlemail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm8520224wru.87.2023.04.10.12.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 12:51:58 -0700 (PDT)
Message-ID: <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
Date:   Mon, 10 Apr 2023 21:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To:     Di Shen <cindygm567@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc:     Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org
References: <20230320095620.7480-1-di.shen@unisoc.com>
 <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2023 04:09, Di Shen wrote:
> Hi Lukasz,
> Could you please apply this patch if there's no more comment? Thank you.

Hi,

I take care of applying the patches. Give me some time to read the changes.

Thanks
   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

