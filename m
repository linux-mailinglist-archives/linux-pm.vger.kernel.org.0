Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C137B0365
	for <lists+linux-pm@lfdr.de>; Wed, 27 Sep 2023 13:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjI0L6S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Sep 2023 07:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjI0L6R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Sep 2023 07:58:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B29FC
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 04:58:16 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso79810355e9.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Sep 2023 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695815894; x=1696420694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxBT05QSaKYLy2VHz5mpN5js/FV2wLDKiGhrnovBJpM=;
        b=xq/0WbYP9QsWTd/8pk7bMcHl22hgLbTMarCfwcQdshQm+/YYbC9rA22lbvaVhSCEwa
         R6uZ92je3wppp1tmdauk+duYzNSFECL4EtbzlsPk6P1VM23VJm6396+Yc2TL/gxBBz2L
         7R/ZYGhWb6n7E0VXvLasInqSlgfYm/DT7pxB3+HveBD0SCO2e0Q8YWeTJmA9X2m9jMS2
         A44wOstRnEQ7x8Q82+8sJ+nF5UaDwVZ2g148cyLJhyewKBfXj1rndI+rSJCI/mE6wffJ
         qURG9uxMCxeU9w4kiDlaWN3hjn8FzXK/4BRCAXL3mUdOaP2jZ83A8PhXYqaFENuNKLDz
         Lphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695815894; x=1696420694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GxBT05QSaKYLy2VHz5mpN5js/FV2wLDKiGhrnovBJpM=;
        b=U2DbqftQ6qdweS5fLtpU51Y3sfuC78e0bP69TOMMOl/qbZCDXDceflgxPVD+wRLrQP
         dpSPPs6r4KiMbEAt2sF/LrqazVN5WzSfwK/dp1wclwANqK8esEU0FEeOJ4dH0tDaoz8I
         OQjuoANJuwh7KyGA50ui6VuIUlhnQVcuxjCdD7ttyQd8ImRhMdG/8JYcp5UV/DxOBA8c
         bmIEpL82k1PnsA+ZCxvQjU+zypHpBErDgHqY1Z6y+RnFZyAYq1EAjEHLsk2JIWWU0Qu6
         xPchgAV+qQui76KV41WXOo4duAWoPqieBuIPDcUGLgOcp+DmZEc1sKOxbyaeEGHMeevu
         qmFQ==
X-Gm-Message-State: AOJu0YxO4ngudfpmPHg5m3t8NLC3DkhfHlqwJNtEpWad6dKE+njtqZWl
        f1UknStLRo4tubRBxVdYZwEj6aNZHSUy6NQ/eoY=
X-Google-Smtp-Source: AGHT+IFC1nJTi1+9q1YPtODs3+1SqLVX/KlO7kVRVqmPJV7UgGFXZDSWD24bnnFuSRUjHFEAaPNKhA==
X-Received: by 2002:a05:600c:28f:b0:405:39b4:314f with SMTP id 15-20020a05600c028f00b0040539b4314fmr1966413wmk.24.1695815894432;
        Wed, 27 Sep 2023 04:58:14 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id t21-20020a7bc3d5000000b00405c7591b09sm5389181wmj.35.2023.09.27.04.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 04:58:14 -0700 (PDT)
Message-ID: <704d7983-16e0-a614-7db8-b1c71859800c@linaro.org>
Date:   Wed, 27 Sep 2023 13:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 04/13] ACPI: thermal: Merge trip initialization
 functions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1957441.PYKUYFuaPT@kreacher> <1785516.VLH7GnMWUR@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1785516.VLH7GnMWUR@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/09/2023 19:51, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In order to reduce code duplicationeve further, merge
> acpi_thermal_init_passive/active_trip() into one function called
> acpi_thermal_init_trip() that will be used for initializing both
> the passive and active trip points.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

