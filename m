Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD81665EA1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jan 2023 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjAKPCT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Jan 2023 10:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjAKPCL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2023 10:02:11 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E481C90C
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 07:01:59 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bn26so15352356wrb.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Jan 2023 07:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaucJbeurArINzx/XqwlyeZxosCdZQCp+GGH59FoJLw=;
        b=BzJQPThURwdCce7DSuHydqHFnFmMUYBpD8p+nqaJSxRUdS/2Xl6wckfZ2HjLnPcPN5
         wE5o0YbTLBfcesWxHslwUojicom7kbnBpm/v0z81lnYABLl3zBtYkIGzU6YIRzS/xBbD
         zoPhqylLhAalYVX5/wBk0lX/HSDo6UY5fOVP5d/8+BYOIRVReHteo4i9Xb5fkae6z17t
         VwIpjW6WO/aL14f9vG9eq51Y/J5Lj85/30T3kzQlI/42D5pUn5Gjk0ZI5r/yZGplPf09
         N3xi77sGwgWRjHNUuW7U91/x4ntr6EPjW7tKYoUeYibNGdhTofrob3G1eoPTgQNxEiGb
         8iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaucJbeurArINzx/XqwlyeZxosCdZQCp+GGH59FoJLw=;
        b=ofuJL0feIFChv3n+JxWGcKChgEoskQVIB/v/v6VZdcHGtC34UdBflQItiPFJSiSrfe
         8mJPV18xsQPWjGfc4LHreuoyyM4tX+XClrvg3bPWZKYfVbgkf0bza6z4e2aDfU/bBLbE
         elhSH/1Y/tdQwY2IGYBWgpGLWwW8HoHR0bAs5Ll0f+vSywaClO1DJlU4UQ4zUEQP4G0D
         ELMeKIZZbsyCYaSwUMzFfHjxHHcADGotGmejhli0DKxyyu+8h+FMl/p2gtuoDrSuyfYi
         Z174ujuZ+LUBqbOXMQ2K9PRmdwNlTt+o+Y8BC4xcN8JY5F1r/rvc5dMv9SVLbFpUiVLe
         mwhA==
X-Gm-Message-State: AFqh2kr6NF2uhSPmQDcTN2i8ZFX6PSNcNI/9i6Z//aorvcpIC5bnOkLg
        xncAJNJ5D43yNpAeSlJbbgY5ow==
X-Google-Smtp-Source: AMrXdXtpWlmaH1CYDfLd+6Dy7rAPz1iLEIGX1Pos50zqDNV/j7WqrZblwbuWeIbTNepd9+4SFvngww==
X-Received: by 2002:a5d:4cc2:0:b0:2a3:3a96:709a with SMTP id c2-20020a5d4cc2000000b002a33a96709amr21707353wrt.57.1673449318389;
        Wed, 11 Jan 2023 07:01:58 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z6-20020a05600c0a0600b003d96efd09b7sm27310573wmp.19.2023.01.11.07.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 07:01:57 -0800 (PST)
Message-ID: <31c07acb-adcf-3c7e-c415-fa2cd67fd12f@linaro.org>
Date:   Wed, 11 Jan 2023 16:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
 <b070cfab-b8ab-f795-0c98-fc874f05f16b@linaro.org>
 <d51432466ed6b1a8eef0e966bf1b2c2bb2e1e37f.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <d51432466ed6b1a8eef0e966bf1b2c2bb2e1e37f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/01/2023 15:49, Zhang, Rui wrote:
> On Wed, 2023-01-11 at 12:52 +0100, Daniel Lezcano wrote:
>> Can I consider these changes ok for thermal/bleeding-edge ?
>>
>>
> Hi, Daniel,
> 
> In general, the patch looks good to me.
> But can you give me more time so that I can test them on my test box by
> this week?

Ah, yes, definitively. If you have a test box for these changes that is 
awesome.

Do you have a suggestion for a x86 platform to test quark_dts, 
processor_thermal_device_pci and intel_soc_dts_iosf ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

