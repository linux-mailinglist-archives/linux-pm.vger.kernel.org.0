Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156005F47DA
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJDQpH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJDQpG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 12:45:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902F13E17
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 09:45:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso7894875wmq.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DA6ATCFI3nwbOwLZFNUBSjoAf7jNM71Mn0lBDKhoxpA=;
        b=M+3rzufIbKktEhqsxbobcR09mtYJOz7dmxiH4HN2OOB4mDAtKGUaavo+nQRHE4cXft
         EPP9kdIMQ0hXGSb96bCDe0UPMkiY6nMW22Hoo+hXZMR0Ef3nrvuuwV3obSEYf1dyJ/Z7
         apONWCTEzydYRJQJtBSgMzyPtx3kb5eYZK6u1ZtY3/Wb5lwVgMmrRny2EdGgaCKR9o7T
         Q9nqG4c3mDLEIW5YIrcGFx48D2uLilOHxkbe9N/C6vN17mm5oBOe8LvAe+qXzPY6evDC
         crTy6j1uaF9ZOTA8R26uavBtQuCtucA5KghrCHA9segqx/SJAXD6Z8r32HAAOB0sMhL7
         WY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DA6ATCFI3nwbOwLZFNUBSjoAf7jNM71Mn0lBDKhoxpA=;
        b=rfGfKmlXuzksF9a8h8R9OmEiXYOb8wm1PpAMZLyNTUJ30oQTLhJz2cZHvlA8cUAuk2
         fJr2UVC8XaTQ9zwPluftfdpvgTgof3zvPCmiOSUOHTkdTkHFQxxYNyGilAG1OhhRYCM6
         bkzBd3F2buRG2EzGwVnkZaexKZ34/O+zf2scCbhnWQFiI7SII4oc/ic3QKk1dkW+cGpO
         jaGWWSgxHB97sALkiAKWZlrHO1Bp6FgVfOurn8vZAZMLwVHjc+0/EztfUuowJp7ee9QK
         1itlu/I7p62KMcbrqZ2q3ch2nn6c5yoy9vUiS7mSGeYUclpQBqjIi2zZ0mOHaog79qW0
         00aw==
X-Gm-Message-State: ACrzQf0UJi5WUmqa3oTpqRpMWQB6LxiUSzpBXlDR6aJYTQVe+Ud5paSw
        UHXFbeN2v3gVqufA/cJjlb0UFQ==
X-Google-Smtp-Source: AMsMyM6IL5yWhA0pw4EdLZnURthskQyquD0fHAc2iTZfoc+ZCAi6TW2Ry3WE7xdqN8QKSlSlSztlwA==
X-Received: by 2002:a7b:c845:0:b0:3b5:5e45:b266 with SMTP id c5-20020a7bc845000000b003b55e45b266mr484982wml.82.1664901901681;
        Tue, 04 Oct 2022 09:45:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id y10-20020adffa4a000000b00228da845d4dsm13061257wrr.94.2022.10.04.09.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 09:45:01 -0700 (PDT)
Message-ID: <97e3971b-cb6a-634c-6c58-d4348c52767a@linaro.org>
Date:   Tue, 4 Oct 2022 18:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 0/3] ACPI: thermal: Clean up simple things
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <12068304.O9o76ZdvQC@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12068304.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/10/2022 18:28, Rafael J. Wysocki wrote:
> Hi All,
> 
> I've just noticed that the ACPI thermal driver is in a need of extensive
> cleanup, so here are just a few simple changes in that direction I would
> like to get out of the table quickly before doing more intrusive stuff.

I've done some cleanups in the ACPI driver. In order to not have 
duplicate effort, shall I send in response to this cover letter a RFC 
series, so we can join our efforts?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
