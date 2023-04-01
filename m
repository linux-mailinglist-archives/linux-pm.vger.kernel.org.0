Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E390D6D3384
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjDAT0e (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 15:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDAT0e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 15:26:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15C319A2
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 12:26:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id o32so14814113wms.1
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2023 12:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680377191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQRytjytsEiYcMZDbuNUVXlNDLCOKJzift2W+Ng+xEk=;
        b=mCBMjqlgRGa8zhbvfQ0PlUdww5ls6cGVUXAgNFTR/ZDGUwsKmlogETkNRXli2sHZLT
         R4Ww68e1Jymgk2wp6PP8wXsaSyRU2k9DT6O30nevWJ54x0c3QYve0JclUskY7m4IXWFL
         41lq+dn/1ukl4BYJGS5DvcxRj+efWVZQLGdr+NHg4sdBgdekS2VTlLP8n278ixBdwG/n
         JWaZWy85Cq/P02z8BjkU+YQy7m+Ql7qUJIQ9jw/yjvbshtOJiI8DdpIPUGHF2iaZJnyA
         qOFTeNIG7Kr7flM8Dq5uTHjhT2+0MTBPZqeLDA7vn2E5OrzA8r3T74klzZ3jbTdv/j9t
         Dv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680377191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQRytjytsEiYcMZDbuNUVXlNDLCOKJzift2W+Ng+xEk=;
        b=TzWjC2DrrhmvZ8wJ94HhOSIF3xET+cg/peSCpVjxv2zlkZ4cxGqyNuIlB5uXoNMD0v
         ncSL95i8lTRrLHJXgL4HKyzV+Ziu/XELgDUw8uzwbVoCOjcXh/XbIWcj4DYIMS7LB1Vw
         z7cz/tuxEPnu96Lywz7Dfbc6vcDNJ5rd9l/PNnMNPwbtmNEbL2jFbge+vMep6AMvkYsY
         aQ+13ZNgV7krBjhv/z++wDHYvdUTACY14vAmwPmV4heJydGCNxjKHiqQ+uJL4id2aoY5
         07ASffHbUPRjTiO1/7Y0xTLlJjQzMWRYnCMCF5YFknxgiXJoUd2t1uNawuh6zE/FPfmN
         1JWg==
X-Gm-Message-State: AO0yUKXLslVDygWxUXKQjgqaybnUSQy08LikeKMsu1aO4visXrDZ7ILo
        t2Mjcp4dZS56kLFYWTbB+6N08w==
X-Google-Smtp-Source: AK7set+J1FiQywg4s1jpd+AQbRjltoaADnPelb/qRGV5JzasjQrS8UZWtYA+Xdr99vhZ2DDXLOZZmQ==
X-Received: by 2002:a7b:c7c5:0:b0:3ed:809b:79ac with SMTP id z5-20020a7bc7c5000000b003ed809b79acmr22977255wmk.19.1680377191375;
        Sat, 01 Apr 2023 12:26:31 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id y5-20020a05600c364500b003ee0d191539sm6995456wmq.10.2023.04.01.12.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 12:26:30 -0700 (PDT)
Message-ID: <7aafa534-412d-d7b9-96f6-d5cef98c8021@linaro.org>
Date:   Sat, 1 Apr 2023 21:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] MAINTAINERS: adjust entry in THERMAL/POWER_ALLOCATOR
 after header movement
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-pm@vger.kernel.org
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328091737.6785-1-lukas.bulwahn@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230328091737.6785-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/03/2023 11:17, Lukas Bulwahn wrote:
> Commit e97b6e04095a ("thermal/core: Relocate the traces definition in
> thermal directory") moves include/trace/events/thermal_power_allocator.h to
> drivers/thermal/thermal_trace_ipa.h, but misses to adjust the file entry
> for the THERMAL/POWER_ALLOCATOR section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Adjust this file entry in THERMAL/POWER_ALLOCATOR.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Daniel, please apply this minor clean-up patch on top of the commit above. Thanks.

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

