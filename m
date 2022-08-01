Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E78587002
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiHASBL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 14:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbiHASBJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 14:01:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D22409E
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 11:01:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bx38so3304584ljb.10
        for <linux-pm@vger.kernel.org>; Mon, 01 Aug 2022 11:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uZR/I+yAkBmW0w7mHOk3YtgLxlXC2BKh5JL5UtMmwBs=;
        b=q+w6TE6z8roa1FS6pRp+tOhYcqoLK1RRU14NW5VdOJfv8hFjDkUklpCbJ0Zl4zmPBn
         RCi6pAbq34Qsp896AIPfQsEXgp4FmQ9P1asmBO/5jNtq7wXUDfX9UCfCUp3jhB94dxOx
         bAfL/QhWup7fU2XaCntjtXmyRRdyLfc1J5QqEsljVEOHviQjSxVn6v6KmX9MNtiMfOBW
         dnz6oXrJCAYm4G2Mnz5cwr+o4qtZcKhtz7JY4LiK5ZTLRkgstfhGCAjZP+43gi7bNxDZ
         hXwUACWS4Bigbxoz64aX9jfwSxHSRwx7i+EkjPU2ySYW/48LpOqbvlmdZYAvjHNZ2/d8
         m36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uZR/I+yAkBmW0w7mHOk3YtgLxlXC2BKh5JL5UtMmwBs=;
        b=C63ZscMWLa0JVkxj9as4HFktCUsaq/nWOLTpb9HhjPQfJGda0Jxrz6BY1R7qbfIl31
         rsiMmEJ2awiloxqn6ewv29Ql6RLGfALMRJ58VaIgsYRkkqptvqJJnodkoJFrZaNpfchx
         ISHSiODnLm90Bo6hNca9fkP7+RmKgDNClhKQaBYMfSjQQf4DRiza79VEUJMAU7QDREt8
         +4UZTTLQThXBu2qU3hwYU7GsVimS1iNt6HMVwU0tGPdS4pmZ0E6XVt//hTzFdOrOnAoH
         Mh+KffbShC/ua/CsHGXo9BLaoU2Cmx/HT62MhHt/IzL85F2EltXpjcv92KKZ9zJXDKL7
         btPw==
X-Gm-Message-State: AJIora9BO+fUQXGsBBrBR+z8qth3LyqDdc2N/sBA79rjkNfoQGGQJ/Fm
        /+m5tlRWOogFWx6eGwMdwQJJtQ==
X-Google-Smtp-Source: AGRyM1s+ieLndbXdmOHTogelfkNm1sPX5Vt3Z6RRXxCaWFy4HZux37fvLIAz14ZPc21Ux3ijqkBQBA==
X-Received: by 2002:a2e:934f:0:b0:250:a7bc:2b8f with SMTP id m15-20020a2e934f000000b00250a7bc2b8fmr5464878ljh.512.1659376866299;
        Mon, 01 Aug 2022 11:01:06 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c15-20020a056512324f00b0048ae7b7b077sm1151293lfr.200.2022.08.01.11.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 11:01:05 -0700 (PDT)
Message-ID: <57faa0a7-301c-c60c-6831-00a351ed3ea5@linaro.org>
Date:   Mon, 1 Aug 2022 20:01:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RESEND 3/4 v7] power: supply: Add charger driver for Rockchip
 RK817
Content-Language: en-US
To:     Chris Morgan <macroalpha82@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     linux-pm@vger.kernel.org, kbuild-all@lists.01.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, zyw@rock-chips.com,
        jon.lin@rock-chips.com, sre@kernel.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee.jones@linaro.org, Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>
References: <20220721161718.29800-4-macroalpha82@gmail.com>
 <202207242227.mttUkfTB-lkp@intel.com>
 <20220729162828.GB102@wintermute.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220729162828.GB102@wintermute.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/07/2022 18:28, Chris Morgan wrote:
> On Sun, Jul 24, 2022 at 10:58:00PM +0800, kernel test robot wrote:
>> Hi Chris,
>>
>> Thank you for the patch! Perhaps something to improve:
> 
> I'm afraid I'm not sure the best way to fix this. The only thing I can
> think of is for now the driver should only be for systems with a
> Rockchip RK817 PMIC (to my knowledge only ARM based systems from
> Rockchip),

Why? We want to compile test everything everywhere,

>  but it looks like the arch was set as parisc. 

The arch itself does not matter unless the actual warning is specific to it.

> Even still,
> as long as some of the functions ahead of it don't error out each
> of those variables should be used. Is there a way to confirm these
> warnings?

Just compile and see by yourself. The error should be visible on
multiple archs. If not, then use parisc. Ubuntu provides most of cross
compilers so it's extra easy to use. The ones not provided by Ubuntu are
also here:
https://mirrors.edge.kernel.org/pub/tools/crosstool/


Best regards,
Krzysztof
