Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59F6E07E0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Apr 2023 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDMHhU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Apr 2023 03:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDMHhS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2023 03:37:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45849025
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 00:37:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i3so3918430wrc.4
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2023 00:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681371433; x=1683963433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NI4ANf+Myh5RCAeqmgmm45CBWTtC5LJOLsn9qKgWU6Q=;
        b=x8FLX0SE2cMprtTmPvF0fWoCSNz0OXORg0hNq0ikIX1cNz0PyI90MFEbbsjpMgP480
         pNOCa1SBDKZVXQIqOdQJrHpLkKvnqgj51qX2/x9gwaNwVdXIYT8ZtUl4J+6LwKbPn9S4
         PjWbQgduy1Wr9tjKIZiHOQPRz8n2M/TXir/ORU5O3jTh5yiwAd/5UwEByYS8fmEGt4Hp
         dmmIo1JNo/cGTa/MWa7C8dliByXEFX3A+L423jzkwG6NbKK2hZpC3rOq+Lxe7zk2wAJv
         Fe3InKq80kb/rqkHoNC1JUsKs13KMf/4yx0EIBsQf0xBytsZGg3h4438uAMmgkeIMYN/
         Xg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371433; x=1683963433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NI4ANf+Myh5RCAeqmgmm45CBWTtC5LJOLsn9qKgWU6Q=;
        b=M+PDqQtTpNRF9N5eZkLzTCUwRxYaDHH8Vo0PmwFxqmujjGu3gw+BVbHei0kXfB6Mm5
         GBPhg/lQW8nHjUzVb2usPAdUL1AV9EvVLwEfPHDpTj8rmDLYlZJcJc9azO1NHk3W6iRN
         E+l6uCKdtLV0FtJqYsFLbP9nVObdFjTyLso9A9jAEIpSg6fNQWKIByc8xkadtCjontbI
         zWUkxJ6zHr6Pt4oGLktPd0Jxz7vh8l6hCRLq5RQYXKCIARlvJm57BN9t7MnoreRzsfOW
         aE6dwqZaLlHsTrMPxpBYkIW9Q+zKxTEqS7W7Im/AQWPD8c6npWQBuf6dO3A2FhsIIkf5
         XSkA==
X-Gm-Message-State: AAQBX9drZTXpYJAFBLUEANnq+0VFDsCIuo2AQCbBjPZLZNxRcd4Y5dnP
        g4LvuY45egVSsxUVzz8MdAgJncDAjMCCnTiIS5I=
X-Google-Smtp-Source: AKy350Y7slEpE5cs+cx+S98UbtVsjGmxMenQyG6K2lxzNBo5N89XNFogTGmOA+VHyBd1Xs6PfEv6jg==
X-Received: by 2002:adf:cc87:0:b0:2f0:833:6acc with SMTP id p7-20020adfcc87000000b002f008336accmr628363wrj.61.1681371433055;
        Thu, 13 Apr 2023 00:37:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6418:c878:b0e:d11b? ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.googlemail.com with ESMTPSA id e32-20020a5d5960000000b002f02dbddc26sm641185wri.68.2023.04.13.00.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 00:37:12 -0700 (PDT)
Message-ID: <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org>
Date:   Thu, 13 Apr 2023 09:37:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To:     Di Shen <cindygm567@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Di Shen <di.shen@unisoc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        rafael@kernel.org
References: <20230320095620.7480-1-di.shen@unisoc.com>
 <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
 <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/04/2023 06:51, Di Shen wrote:
> Thank you Daniel. Any comments would be appreciated!

Still thinking about the changes...

For my understanding, why do you change the 'switch_on' trip point on 
the fly ?



> On Tue, Apr 11, 2023 at 3:51 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 10/04/2023 04:09, Di Shen wrote:
>>> Hi Lukasz,
>>> Could you please apply this patch if there's no more comment? Thank you.
>>
>> Hi,
>>
>> I take care of applying the patches. Give me some time to read the changes.
>>
>> Thanks
>>     -- Daniel
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

