Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6B77B1EEB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Sep 2023 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjI1NsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Sep 2023 09:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjI1NsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2023 09:48:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13411F
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:48:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40528376459so132807415e9.3
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 06:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695908894; x=1696513694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4OOWmretAa7TcVqNXxB5c5DBUS1hZWMqm3G0yA3Bim4=;
        b=VzXi0RI/+AgiIKw8LUAFxqj5zjZFSLvOWkvUZHitx4AZtw/8fhBaex0y4jwN5eF/hJ
         cLVLbGE5ey5X27vjhCIJzfY7xHgLzVHw9iYC/prQDr2AuAiFskphj66aQMiuXwe+8Tb5
         kUPbdZT/iVRDgV059eRFAAwipRINX9p9kqFU3VjjhMwayIgkUTJFzkdmRJWdld1aaMgk
         wcczIsvjOQuCs9zn6IcVbQnm083WNEj+kSLC+JiHAe7cop7so+ZF6LYU3XiNqAea1mVw
         bNVmXtAsxtUTJ2c1ySpCXUV9Hv6kH5zp4yiajFJqAsy8DGveEN2tRUnk6rUF8VH9gvKl
         jCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695908894; x=1696513694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OOWmretAa7TcVqNXxB5c5DBUS1hZWMqm3G0yA3Bim4=;
        b=hyqYo6J9RwyULJWnHwri1v5rf/Elaxs4FUTdihZDUMEUXsslLl5VPudMxnUcdMjs/w
         IWAKu9CivLe09B4s0eVBgVmOqUZbNf0SbcmKGtkk0EzzIHJI/0qfc6ufrVjWmEqWKke+
         BMQivXLpY27OSw65fQFt6Yk/O7rhqit7TlmRHDLvssiSWSKZqpLrsqaxNPcfU5Q7+Fbw
         MABvNU9KKL/f45B3giEAegApizDuO/zxByatwsgNJUwKyKev/+oJbvuhu6fcQBiQfn/2
         OvpuCT03hEi3KY7DAF2m3dPiok5yWxLNnsoLEmZyf2eP/0r1ZBteezc2BCrAggyDjoSi
         eCdA==
X-Gm-Message-State: AOJu0Yyg6HFejlv5NtqNpzttEuOLaCKjOo3jv33oj+4nMkGGQdnmbGlG
        TSOQ5YKDI3/dHz6OVvxbZ3UX7Q==
X-Google-Smtp-Source: AGHT+IEzbSfBNDBkq5ND6DwNYm34C++f8Meh+zxofOdZ3wFfE0O32sV1vduEtEP2AFl/XAvhFelFZw==
X-Received: by 2002:a1c:7917:0:b0:406:4a32:1919 with SMTP id l23-20020a1c7917000000b004064a321919mr1319929wme.29.1695908893604;
        Thu, 28 Sep 2023 06:48:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id l17-20020a1c7911000000b00406408dc788sm4957831wme.44.2023.09.28.06.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 06:48:13 -0700 (PDT)
Message-ID: <9b1be97e-b042-87d0-447a-9645c3039e59@linaro.org>
Date:   Thu, 28 Sep 2023 15:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] tools/thermal: remove unused 'mds' and 'nrhandler'
 variables
Content-Language: en-US
To:     Kuan-Wei Chiu <visitorckw@gmail.com>, rafael@kernel.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <93c87b5c-ae8f-d27d-0342-faa884a3142e@linaro.org>
 <20230926173736.1142420-1-visitorckw@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230926173736.1142420-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/09/2023 19:37, Kuan-Wei Chiu wrote:
> In the previous code, the 'mds' and 'nrhandler' variables were not
> utilized in the codebase. Additionally, there was a potential NULL
> pointer dereference and memory leak due to improper handling of memory
> reallocation failure.
> 
> This patch removes the unused 'mds' and 'nrhandler' variables along with
> the associated code, addressing the unused variable issue, NULL pointer
> dereference issue and the memory leak issue.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

