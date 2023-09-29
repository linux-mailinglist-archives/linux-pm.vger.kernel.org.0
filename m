Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457287B2C49
	for <lists+linux-pm@lfdr.de>; Fri, 29 Sep 2023 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjI2GaM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Sep 2023 02:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjI2GaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2023 02:30:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6961A5
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 23:30:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5041335fb9cso21749859e87.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2023 23:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695969008; x=1696573808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8B9U0J03v9W4gmh9II0yrpUaLY38JPff5+I8zBDe+g=;
        b=RUrK9O19upc+H6Fr4LpZ/zd/ZrOeKbwwwPH8KqXTCXGzTkhfNvFd7WnvTSp1iqmw8B
         bRl8nI1+R9mhkOsIdL2WjVS6auuIrTtE+cX94Qf9mikKchJaBfx+u+l+yvhrWjWQxq4y
         ivuaEzseYqWrTZNxlD3YKAUo1+8IEdFQlogLHCFIE5VX8q6hIIHvGSoElsLUt4aHKeip
         hER5jlffgMQOq0DfTjRDP/TqGd9d5tZgleX0ckuWYHtI071BVN2O44aRZLvXkPu6Yz29
         Fiaj3GpHOmLrCONT2wCxGw0ec5iwGJUV+KnrQLT3gQadE+fZ4ibAla9IlcZUYsgb4N0W
         IXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695969008; x=1696573808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8B9U0J03v9W4gmh9II0yrpUaLY38JPff5+I8zBDe+g=;
        b=dJW2OMY0DkUji1fDe52K6r/E6eoauwCEy8/iAxtb2dotkrzLeKEo1saC+7c2vgDdEH
         WnN7JkjRtVdixpWzXnV4Rlq9k9wvYTBCDM7wvosmITDdLTX1jejZvtQqfUd/3YeaS7EN
         jeaaqRv7ho7XSuEWj3Isn4x/3jmiqAWkLXfFASPhqBWMu4wfcfGPjcyeQVrICvaWzCoH
         E1a7U9Ru9fjOopv1aav1dt83vgnzu/4pLmrmtLgablvpFIXs0CPq58QSTgd3PkhqQxJl
         tYCySZj7fnxlBqlpllj2KRlKaxDMF3a2rlIDBnx3LPJvxCzTKrBWf6h940rHfzafftYT
         rFQw==
X-Gm-Message-State: AOJu0YwxEZZW9FIRJtXTcRjZowolImM3q0o6Y8MbqGdkbV/O6p3cPVKk
        /bDwFQa/kN2AMMwJ8LXhxT/NBQ==
X-Google-Smtp-Source: AGHT+IHLZnh0NqyTg1Kdur6wnM9TSTcEAapIYnlDf2JcJPIh701wlBLegZxwHVbibElyKi4ZGrPDNA==
X-Received: by 2002:ac2:4bd6:0:b0:505:713a:4bb8 with SMTP id o22-20020ac24bd6000000b00505713a4bb8mr397240lfq.27.1695969007058;
        Thu, 28 Sep 2023 23:30:07 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id k15-20020a7bc40f000000b004013797efb6sm745516wmi.9.2023.09.28.23.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 23:30:06 -0700 (PDT)
Message-ID: <d1abb7e6-c71f-faef-3488-4d723d3d9e17@linaro.org>
Date:   Fri, 29 Sep 2023 08:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] ACPI: thermal: Drop list of device ACPI handles from
 struct acpi_thermal
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <2725347.mvXUDI8C0e@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2725347.mvXUDI8C0e@kreacher>
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

On 28/09/2023 20:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the list of device ACPI handles in struct acpi_thermal is not
> used and drop it.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

