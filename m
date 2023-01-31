Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3503F6831AA
	for <lists+linux-pm@lfdr.de>; Tue, 31 Jan 2023 16:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjAaPit (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Jan 2023 10:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjAaPis (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 10:38:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E931259A
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 07:38:44 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso5904734wms.5
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LHtH3bJ+q5MZMDliWaNSJG1cRpwfIRUNjGZgww+vEs=;
        b=ecx8uctjXOWtRMTS/y3varh5ANvb0+M/RaMhOzCFULxvmxs4/ztcA/Up8cVFOvTqhA
         fDBn59GXuIIlNagvxb8b6Hq3VY/nBY5yzkokO6iAoOT4qE1d0LMvpiEnmEfv0D+zX5sW
         +uIXD69G0fZ+YegCxt+ZnbO4Ie4+haUYSloYSwVNKPIif+JzO4qkBqc45B9FA1AW2PIC
         OnjbZYSFjX16UEcNJlAWuQWJ1zzorRbRVzBfTbz+YuVaKdkeU5ZlbFvEGSQfzgvDldTW
         /7QlhG3TgF3Y1y3BBoxaZIl6AlCReoGTx8qo1ycojFhI47T1W0puSu1pNVAIZ/Vl/GRx
         szYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LHtH3bJ+q5MZMDliWaNSJG1cRpwfIRUNjGZgww+vEs=;
        b=Wixpmetrm2PybmPUrXsDtEk+DkIxjdrIp4cXWyF7EyYlqFGy3EQaIocQgVTwAZoDBf
         MKxz2Qj/j7yezee59lEMEvukrH7HIYWPdmIwNhgehq5r2aOhOw0lHDfXJ7AYrrHFakp6
         +CERspxJZgv7Splt8p/kNPPO7gKZRZAHaQvl19aj66KTLcNwdTm0eUO5HnjTKRibGORa
         wF23bUMeAquuB5ByLaPE+ymCGVvYjCgfhtnqibAP6MQN43XZTn+pNuRbIElthEIJEddJ
         N55GcnYEDnx2OUw0DUCItgCYMSSmRaJiIPDLxzJdz/O2QvQlxBQtuyVMzqEUyk4f2SLL
         cekg==
X-Gm-Message-State: AO0yUKXljDicUQTi0bLrA0CAeY2bQWAL8/X/Giyaf9+eKnBqJBTnZxfV
        syp0Dy7Ehi9AiT2SKph49I+yxw==
X-Google-Smtp-Source: AK7set+qXEO5f6dM/+ByOJF3uNln+DhK4z5qtfoz1VcbfCM/HgCJKWfILh4TRd9lo8Bwr4d98fApGw==
X-Received: by 2002:a1c:4c12:0:b0:3dd:1c45:a90e with SMTP id z18-20020a1c4c12000000b003dd1c45a90emr3725660wmf.25.1675179522630;
        Tue, 31 Jan 2023 07:38:42 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id x2-20020a05600c2d0200b003dd86c24005sm1686377wmf.42.2023.01.31.07.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:38:42 -0800 (PST)
Message-ID: <20034fe0-3fa8-9ece-b0e8-96143cd2deea@linaro.org>
Date:   Tue, 31 Jan 2023 16:38:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/4] thermal: intel: int340x: Drop pointless cast to
 unsigned long
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <2133431.irdbgypaU6@kreacher> <1921559.PYKUYFuaPT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1921559.PYKUYFuaPT@kreacher>
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

On 30/01/2023 19:45, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The explicit casting from int to unsigned long in
> int340x_thermal_get_zone_temp() is pointless, becuase the multiplication
> result is cast back to int by the assignment in the same statement, so
> drop it.
> 
> No expected functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

