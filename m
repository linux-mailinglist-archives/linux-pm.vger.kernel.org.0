Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5907AEE3A
	for <lists+linux-pm@lfdr.de>; Tue, 26 Sep 2023 15:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbjIZNsc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Sep 2023 09:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZNsc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Sep 2023 09:48:32 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90A1AF
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 06:48:25 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32003aae100so6795454f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Sep 2023 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695736104; x=1696340904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzS+keettZOd01HN2xZh16fkUfdIkcS5wOJyuirXrFQ=;
        b=vBDycfenJxqwpInoOeWzjshvAsTBnOy4MDP/9EtSvgNA3r7lEi1kUHh6eIWm8z0Rqw
         fVdg7sIKs/bYqN6a9QibDGgj2zN2Z5Ac5Xz1g/WvvIbQUT79vBh17aDjiZoHo6I5WQR8
         DhCMWijYspd9CVMwHyVJfbETZlkl0QYFU5rRTEreaWcmbO51gPIzFuyZFREpVQSgteNb
         F+BB9zxVNoETQuXuSgiN0vxCFu2YCZNrAXhaAChp6Us/1BhZJKSMxSm8nmiVCwlcD5Sp
         RpJold6epqwjTcj0YI2PW74i5g/Vf1uw/Z1/ERl4zQesX2Lu5mmFxLIDU2mTXjn+UC8r
         juRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695736104; x=1696340904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzS+keettZOd01HN2xZh16fkUfdIkcS5wOJyuirXrFQ=;
        b=Saqj1eQ7yRV1mG0dajLk3ABrXmlky99vgRVGO9x8dV95cr5zkGVQIh3oJ8JF40l3u1
         G93Zk9VZmCaG+H896jkul7fjmkahiAZl6iNZqWbMAaoHJf9SZUODhzyGMa1EHOrH/pAt
         dREysjKIDX9WcQFGkhx1nK7e89vMGcZk+VgF1Y81GOoxPwZDNfzSJe/+6LwRwmja8GIN
         amdsG9JkiVs+qYMy6+a/GKyiwPJYSuhOSUYnDeJbXGO9xvVa1aw0u11RoE01E2RnJBXC
         jyKEAYuFcovq03f7GhSH3vkRYpy1iZKj+wvhVdWVZv7cUsiY6mjunH//mK0Z1Jv+/On0
         YOlQ==
X-Gm-Message-State: AOJu0YxLWfC1mRbKXV8afs+/MMOdT14RKC6BBwgNNa+9k2WRkakrM5hW
        amKE/uW85YfCApaVOOe718Il/w==
X-Google-Smtp-Source: AGHT+IERVS/jYe1PG1KyYRy/F1EQXclRDoumeocBI+M/3oUk+8PNCCJR/U8ukqVLE4zRvT80MMsuBw==
X-Received: by 2002:a5d:63c9:0:b0:31f:335b:f436 with SMTP id c9-20020a5d63c9000000b0031f335bf436mr2092424wrw.22.1695736104266;
        Tue, 26 Sep 2023 06:48:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id v11-20020a5d610b000000b0031435731dfasm14715049wrt.35.2023.09.26.06.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 06:48:23 -0700 (PDT)
Message-ID: <fd90773d-eb70-920d-fe33-30c37453b4fb@linaro.org>
Date:   Tue, 26 Sep 2023 15:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] thermal: core: Drop redundant trips check from
 for_each_thermal_trip()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <5981326.lOV4Wx5bFT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5981326.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2023 20:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is invalid to call for_each_thermal_trip() on an unregistered thermal
> zone anyway, and as per thermal_zone_device_register_with_trips(), the
> trips[] table must be present if num_trips is greater than zero for the
> given thermal zone.
> 
> Hence, the trips check in for_each_thermal_trip() is redundant and so it
> can be dropped.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

