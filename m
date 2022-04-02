Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0BE4EFF27
	for <lists+linux-pm@lfdr.de>; Sat,  2 Apr 2022 08:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiDBG0j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Apr 2022 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBG0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Apr 2022 02:26:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32C65006E;
        Fri,  1 Apr 2022 23:24:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s72so3975409pgc.5;
        Fri, 01 Apr 2022 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OWpfUOyThc7LArwewOiHCOHI8uXy/pwCBjcxkPQ5nkg=;
        b=gKmS//GkAbvcxWrNqvbM61ubaXxXErDvbMjllwiKsNgqMd6zNKkTpfeBPzRKR66br7
         Y5G7wqTW1m+7dl2Gnqqd1QzIs6dxZIeSXhySCNQHFni8GSZvfUeXpP5GZLudd8xMGcLW
         xI9naEr3xSXWvEKJ2JD3UK9v0vdEk1MvC2OmQIwQKfDU50Vp5ctJFr/zuicmXoHLp7y0
         K5QZA5nfR3EBecitV2lkb/xF281yADm9oG3CflOgSHCxi6D5iS6o+CqGKDSMDStvV/aa
         tjiLPWAlW+7FGllI74o96D5qljRCpp9NJnjiKvNUMPUFqPLtyjcaRMRgaKOmG0rg7i8H
         sN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OWpfUOyThc7LArwewOiHCOHI8uXy/pwCBjcxkPQ5nkg=;
        b=uNThoOAlf/yilLwx2pfs17go29Lrk/5sJ2uK8QAOmwCGvIb/3oWDobFBOh+pCAcqP1
         VNxXnyxMUAjPQ5+r9QZYKLUG8vjqxm29XVH38L9jZ51BvwxFvkIrgXqfC52oNyWdIIl9
         vTYgmlkJ7+3UuSzL6YkZpc7+ghYTYdv5/2h9qP2YCT24yqtWk5RYSvFCKCor/hQDhPTi
         yMujzqLfJG5++aRjq8vzxyBjorISLwNK9hCL/5CuC4JfjE3x6KIm/YKh4NeqVuLaqgCB
         M1LsAoDSEJdBN7MiMcGhCuE5ZIymymjd9wzdC3Wq3VJZGgQmQqbse3f8QWkJmvIhY/Pe
         FhGQ==
X-Gm-Message-State: AOAM530kqBO4VOZxFxM1MUAeJohK5fqvt1fbbvg9jadEi6ryRkFVgefN
        wyPc2XxvCnskbPgooUs+dVcmTwe95Vv2eg==
X-Google-Smtp-Source: ABdhPJxtCRIFD7zxVumioDxpCN3lIDhVvtSfNNQksNPRIsNajPrUE7Nh25hsWDs6FwDAmy5NQklrVw==
X-Received: by 2002:a63:fc01:0:b0:398:d3fe:20bb with SMTP id j1-20020a63fc01000000b00398d3fe20bbmr7277256pgi.174.1648880686383;
        Fri, 01 Apr 2022 23:24:46 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-29.three.co.id. [180.214.232.29])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm4937553pfc.190.2022.04.01.23.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 23:24:45 -0700 (PDT)
Message-ID: <6773799d-57b1-8c74-d936-f7723b302ef7@gmail.com>
Date:   Sat, 2 Apr 2022 13:24:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -pm v2] docs: driver-api/thermal/intel_dptf: Use copyright
 symbol
Content-Language: en-US
To:     Akira Yokosawa <akiyks@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <fffa1d50-f155-b6a4-bf58-22e395d7401c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/04/22 06.19, Akira Yokosawa wrote:
> Using a substitution pattern of "|copy|" without including
> isonum.txt causes a doc build warning.
> 
> Using the symbol "©" itself is a better choice for those
> who read .rst sources.
> 

Hmm, where is isonum.txt as you mentioned?

Why not (c) instead?

-- 
An old man doll... just what I always wanted! - Clara
