Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45FC5F4FFF
	for <lists+linux-pm@lfdr.de>; Wed,  5 Oct 2022 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJEHAm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Oct 2022 03:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiJEHAd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Oct 2022 03:00:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AE06CF4E
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2022 00:00:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu30so4609647wrb.8
        for <linux-pm@vger.kernel.org>; Wed, 05 Oct 2022 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE4YYswoUd6/7vbYuunvLATZVA5nGwNOYV0WjaSQLtA=;
        b=mVfB1cb7TkHBlFjDlceIJOs5IYoA4gnQMcKaI0iySBDQK/VERw1dERZeegVJThnO+k
         TGfPzMKEJhDhHCL62ln+b2NiIMIG0DsGXHPZ5wHnjppxvkthXziRV+adPooY3lvxw+tn
         VHAco+8CPCPR8NmJMWy5MJi7DENDgD95OqBp8gyrAG3PbcJn2TiEkv+3NCeii6GdFU79
         8XKD6iFwUIDZRpb+GK1JowhdyUmp5dXYEIT88mOUj2JuGmYifxJ0cDCAQG4EOtPA4jsf
         4+Waw8T12h1VufNLpHOw4sQ96/SLzHUEtVEAbJJInUjV5VD5oegQZyMt4D8nHnVypOmP
         iHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE4YYswoUd6/7vbYuunvLATZVA5nGwNOYV0WjaSQLtA=;
        b=rN+KQeaxEq4bqktHSXhIQxBhmngB9NVq8d61YHGl63G2Cq0oJG6pn+x+2bBuQcTEfO
         mSf6SMoStyi/oE6nK13baeRqpvdoFnMn1FvJ5wn6fkPgBZLPN86nNzY+ZnYr503xp0v4
         iuQTG9sAJzBcfqQKLELdxvR5SawABSxpeRxpsV4NXTdOU7+/4i/jF+Gu2IcQZL5cIbhk
         E2wk85VPjGhLReyepUfhVLOZD4cJrzSVc/A6/lRlkX/2BtqHyyPvcboYh4EDYaZyXC4M
         4P4YodzAqVtSi96dzWB5Kaf5RAYvKTDrFzVLcJNK+I/HzDyu6mqTGua9HGHNTI9DkuRh
         RRsg==
X-Gm-Message-State: ACrzQf2iQZavfzVbMH9W1o/PM8Y+zGjqdKfaN0zJJNPyRBt1afv/FXB8
        w5nEUtGysxD+BQXApsrfX39iXA==
X-Google-Smtp-Source: AMsMyM6GfIt3WR8bKa3VAfYGyCZN97BZcoU8vHN2RLTAkVDPbt96s2c74SOlpnI/TaIkX8yUGI0ETw==
X-Received: by 2002:adf:ce8b:0:b0:22c:dea6:6ea with SMTP id r11-20020adfce8b000000b0022cdea606eamr15707758wrn.387.1664953224681;
        Wed, 05 Oct 2022 00:00:24 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5? ([2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5])
        by smtp.googlemail.com with ESMTPSA id m12-20020a5d56cc000000b0022e58c14588sm2241482wrw.85.2022.10.05.00.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 00:00:24 -0700 (PDT)
Message-ID: <07741aab-c219-c791-c315-6d580736f7d9@linaro.org>
Date:   Wed, 5 Oct 2022 09:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 3/3] ACPI: thermal: Drop some redundant code
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <12068304.O9o76ZdvQC@kreacher> <1831358.tdWV9SEqCh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1831358.tdWV9SEqCh@kreacher>
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

On 04/10/2022 18:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop some redundant initialization of local variables, a redundant
> return statement and a redundant "else" from the ACPI thermal driver.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
