Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9987E7521F7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjGMMzM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjGMMzL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 08:55:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5417B199E
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 05:55:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso5308505e9.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689252909; x=1691844909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJPCLMCOPjf7pqpG3E3SteaiCM4QTxX5EIsvUr4Ng3k=;
        b=wN3gv1xaDV2JPw5FDBxOIYYgaKB7bR/BmRq3Vcz7RApscHjjK96Cro8qkhAPZClami
         8MdB6i1EL/CXPp4ZmyNuP6B5CYVqxjY7KnUBfaC6JyBZ3yZUDFKKrL1WTn+8GPBycOLb
         lJQ4mVX8M8CII3AzsN+n9mq0TvpgxkHTw/zPj8RVCHyB7VDBmOqb2bMJaCzul674FgKk
         1SGL2N+O836xf7BvYNFn77AuKEpdrEv7HR1XFaXgATJnaATB4bsky9hVgtOTor2oBhvO
         Z04XStmX1++tEHijtAbtyEOQ7u+OUCRGZnP9lw+T1BPENzmGUwsSzf105l1ThblP/IPh
         Qzaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252909; x=1691844909;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJPCLMCOPjf7pqpG3E3SteaiCM4QTxX5EIsvUr4Ng3k=;
        b=fL4GezkNpgtkeogRENXitjbMwm4p5hkFOqe5Q5gFsCSaIoH1HwQJMAayyKdJqJs0HG
         Cnzjxn8KbBtTE9TmFe0gicx6zlD19TmX1XPio9thPeft8wjZwjLN4sLnqYG2fqYUF75g
         AkowDiA2ObypSB0niK7lUYoSnVI518oSUdxuTZj9glu0nzMkMb9lWqfFXcQMduFg3+n7
         tX1DZQy9Sg7wrqFgH+AudOI6Wy9czUwXrnTxAgmnOeJ7bcW8FRvbXeJi0Ob8j3q1E7lI
         C+HIIEelt1d8BJf8FJdbvoma2V5TONQ9SFAHWHJtUFHcOEotSxp/1ZI4X2TLMoxcAia9
         wD3A==
X-Gm-Message-State: ABy/qLY9WLO/mEC3k2CCtE13YmtCbgHqpxXoYE8xNzO2zbcCJlt5+ujb
        XU8rGN7pvw6CNLbDB45fGSwG1g==
X-Google-Smtp-Source: APBJJlGNbBaZNZzhRqvBhmZxwxOkXQHv5tfhCsX27CPDxO54TJ55M2kLTGHBSD6Wjfv23AAJ33ALOw==
X-Received: by 2002:a7b:ce0f:0:b0:3fa:964e:e85 with SMTP id m15-20020a7bce0f000000b003fa964e0e85mr1658220wmc.5.1689252908757;
        Thu, 13 Jul 2023 05:55:08 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n22-20020a7bcbd6000000b003fbb618f7adsm7691549wmi.15.2023.07.13.05.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:55:08 -0700 (PDT)
Message-ID: <29d2533f-9297-6383-e26c-dced2756f817@linaro.org>
Date:   Thu, 13 Jul 2023 14:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] thermal: core: constify params in
 thermal_zone_device_register
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/07/2023 13:27, Ahmad Fatoum wrote:
> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
> parameters structure"), thermal_zone_device_register() allocates a copy
> of the tzp argument and callers need not explicitly manage its lifetime.
> 
> This means the function no longer cares about the parameter being
> mutable, so constify it.
> 
> No functional change.
> 
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

