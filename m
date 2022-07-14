Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8401E57527C
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jul 2022 18:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiGNQLp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jul 2022 12:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbiGNQLo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jul 2022 12:11:44 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C2558F0
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 09:11:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id v185so1779588ioe.11
        for <linux-pm@vger.kernel.org>; Thu, 14 Jul 2022 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1d6yUsmgcZyXfHlWcDV40Ru822KjO2Vp1bovNsGCg3U=;
        b=bjar8jBBc6vxB7yyOkaWNdb/bGFKZkrTGaexhSMRamru03GoyAfL+yqdTWBcET1Hwg
         brEoF0/BoU+x43lEBfA8zepa7ejS1DCFlYpw8dIt6BG1DtscLymVwhb0sjFlIyhXS4LT
         hwerCxpEiaBb9q1q1k81NNjdhGZuRfahp0Oi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1d6yUsmgcZyXfHlWcDV40Ru822KjO2Vp1bovNsGCg3U=;
        b=ZqlK5S+gR7OvRMr5agCg6btnzuduksOenyemTbojKs1ek7jzqrCU1qzRNsgRm8j/ae
         a/YMmHv4roOb5dbmHgMIrphWPXqpcxIn5bACqzvz//8KWwNOj6jpMMlNkvN+mFehLZtw
         8tWbTLgmaoVLbMwPpK/UjppiEKZFhl4hJZ4/PbgUL1xT4zx0ftuG0XHIkUNb0USCx3cf
         dDGFDdojD07PfkMsJ1sfz50+j756jBmVJNGm0fmlmPUZNX8KxseJVKzwFTWsWGElZbaU
         r7KXSHqxCbBMtfLGnKiiQDwXYO1iYQab/L4HBtjo8xEtu0M/G4+CtO2imnIndIq+yOj9
         gc2A==
X-Gm-Message-State: AJIora8hzRfIdK9nHs//y5lAbY7j03Q19GoSWxM9e3UTJbROSuNw5OaU
        DgAGGyU7MJq0Mw0UHZExTxcUkY6TkVnRVQ==
X-Google-Smtp-Source: AGRyM1uejILq7/p4qKhE8hOoDA6ylBMb/lfIou0vdKNhJX35dfh1mgogWDOfmxpuHnShq61tgnMg9Q==
X-Received: by 2002:a05:6638:2642:b0:33f:5172:e77 with SMTP id n2-20020a056638264200b0033f51720e77mr5014172jat.85.1657815102376;
        Thu, 14 Jul 2022 09:11:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x9-20020a026f09000000b00339cdf821dasm874726jab.51.2022.07.14.09.11.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:11:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpupower: rapl monitor - shows the used power
 consumption in uj for each rapl domain
To:     Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
References: <3720988.KDN6dyLT6n@c100>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <115847ff-a0b1-96fb-144f-00e8db9adf02@linuxfoundation.org>
Date:   Thu, 14 Jul 2022 10:11:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3720988.KDN6dyLT6n@c100>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/9/22 2:13 AM, Thomas Renninger wrote:
> cpupower monitor -m RAPL
>      | RAPL
>   CPU| pack | dram | core | unco
>     0|11599641|308837|10748813|  3662
>     2|11599641|308837|10748813|  3662
>     1|11599641|308837|10748813|  3662
>     3|11599641|308837|10748813|  3662
> 
> Signed-off-by: Thomas Renninger <trenn@suse.com>
> CC: Shuah Khan <skhan@linuxfoundation.org>
> 

This is also corrupted format:

In the email it wasn't clear to me, however the corruption was
very clear in patchwork view:

https://patchwork.kernel.org/project/linux-pm/patch/3720988.KDN6dyLT6n@c100/

thanks,
-- Shuah

