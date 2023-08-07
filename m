Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6877222F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Aug 2023 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjHGLaX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Aug 2023 07:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjHGLaJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2023 07:30:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB58D3A82
        for <linux-pm@vger.kernel.org>; Mon,  7 Aug 2023 04:27:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe490c05c9so15608785e9.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Aug 2023 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691407538; x=1692012338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaTgcJnET5axySMhn1ansn2vWDflHknuCQCKOYFZG0I=;
        b=KxYgUm1zyiSyj4grNEO0VfG4WSa7ZB//Sd830C33RDHkbHmf9tbJ4Au6ONe8Fu/+sg
         sZmoegEuJHdBsChUN0cdUU6XEyh89A4Izejzvy5wCbj2Myxyk+tNtWjgWqlY2LULpIeZ
         NjyA0bjW5CiFuGWp2oUriK41gdBY2e5458zwplRtVn0AaNXg5AVZizf1M6FkhFjSnEXK
         NuktxsSliyr/CyjUKK7trNvdZ9nHbTBIegQTd76RUOnv591a64djpO6WG7RZmDZpV26g
         K+7B2+rko49MKJCh6wo/b2I+a5NpwLwsbN+Nulvg+n7qmpgcIWx0phf9I5T3kP5VQA25
         A0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407538; x=1692012338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OaTgcJnET5axySMhn1ansn2vWDflHknuCQCKOYFZG0I=;
        b=QiYzJ8fkHFiTl5x5m9TFOqnMh77V4pebxGs7RpBw/EK5CTZ2iMyEimMOu6oGazHPO9
         B755KOGMEdh/PYcC9YrvD4jqxSVhTYmo32fFMmK97PW2C4lAJ3zBhUjiCIl38w5fPVi+
         kAIODVmPxMrqIEUS9rg6urJf66+aBgvpfKBcnLsqfp/3lDOYSkBj7OPiT/VUnpXWPE+e
         Srkdv/mwt9EYtd8EqhMijNf1oJO8yqM0QIpE3NytYfxJeMJDm3aBW13UDMNN3oGmsYe3
         h3bFJNZrkjvOMvr7/I4hmExGlk/sZ4MYZqmYc243AzJAs23bANt/igKitP7k61eGqjKo
         2d8w==
X-Gm-Message-State: AOJu0YwuC/A532FT3xmqN1EaaJatEpqRGLpYF8LDvgqFL/nkj20NGWpO
        soUFk9CxrWriImlmDx0GDjIawg==
X-Google-Smtp-Source: AGHT+IF+kqj+cozNxEOXkK9z4mLBo8nEFcsWl+nAJBlldz47RgyxOBAZOl5hWhRhdZQO0pfqXKgWIQ==
X-Received: by 2002:adf:f08e:0:b0:30a:e70d:8022 with SMTP id n14-20020adff08e000000b0030ae70d8022mr5035723wro.26.1691407537921;
        Mon, 07 Aug 2023 04:25:37 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z22-20020a1c4c16000000b003fbb25da65bsm10397141wmf.30.2023.08.07.04.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:25:37 -0700 (PDT)
Message-ID: <78fffdd5-045e-3a29-bc7d-91d5379d63b4@linaro.org>
Date:   Mon, 7 Aug 2023 13:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 03/10] thermal: core: Add priv pointer to struct
 thermal_trip
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
 <10344810.nUPlyArG6x@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <10344810.nUPlyArG6x@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/08/2023 23:04, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a new field called priv to struct thermal_trip to allow thermal
> drivers to store pointers to their local data associated with trip
> points.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

