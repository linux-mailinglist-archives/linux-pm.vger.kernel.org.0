Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0494FFBFC
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 19:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbiDMRDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiDMRDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 13:03:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660A6A056
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 10:01:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id n22so2190786pfa.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VWp1weXzZ3bgjyBCOs8IUs3xAXx94RSN9bjrxALf5u8=;
        b=csEMxCUF4W/Sf/PDve78Hu+y5gbo1eEMYXl1runK1SsqQIDS13STZRMrMy0EbBeUAx
         PXztheGndRA26RHOeb/keE1MzPymqUwkGgGOyuSiQQu7BVGmiriqPpYhH12TmLPNeLf+
         16b+ZNj3ef+2RU0Fk5dWybqfrJ73xvGwMQ3cmra8GmQUMAabBpy4L7AerYyDT7GIEefx
         Z4e2f/4hYhs9YVe5QeYEPYMPZDKt6xOmhNsND38MeVovtweG899CSxQyrxMe49wnh5MS
         hbZZQKFZ0Pwh5d8yVWITaAwEVMjp1GEp1BkEml0h2j0Ho35jCeVmHWKoWMgKLyDcpJl9
         AOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VWp1weXzZ3bgjyBCOs8IUs3xAXx94RSN9bjrxALf5u8=;
        b=w68d/OPZPSYURZZeFxZYxrsJGiT5r1hDtPtydH8/SuZs6vPHq1pGCYEQW8S5A1tFa+
         dq1o3AFihtUMDPn9PQdLS1E4e4CKXWaOka9ah2wHBWpytChyOkK9RsGMC7ADejgcz58b
         7GVj91Kr+iYgoy/kP/FI4FfvEgZUTpT40hEn2M/LfV0lLik1h6OqzsXas3OJz4ekZmLg
         SBBlPc53cFC5LGIt2snTMyvOiuSDgLvNSMMeGNV2/+4OQPU/YQTr/66z1i8+YPfclVmo
         rQCmlFKLGxR215QecjdNZUd2Mxf5Da+qpPwzpWL9QZUivOliV8iQK2yHuQBTa6nqrH+h
         d2JA==
X-Gm-Message-State: AOAM532NySZ/XdWEqL/XS38tBDJAR5+YYHwSnLFE3kPtcJR4mNZiaJep
        6CayiAKCIJUbi4mE4rIBxEw=
X-Google-Smtp-Source: ABdhPJz4dc7T0Vn+5iV23TlICmCKKaqpb5MwUhs1K8lC3IGPTvl7FffLYUvI3eI7Z6q4N1sEGlVZdg==
X-Received: by 2002:a05:6a00:238f:b0:4f7:78b1:2f6b with SMTP id f15-20020a056a00238f00b004f778b12f6bmr44328969pfc.17.1649869282905;
        Wed, 13 Apr 2022 10:01:22 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090a114800b001cb95a92bd7sm3450463pje.13.2022.04.13.10.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 10:01:22 -0700 (PDT)
Message-ID: <194b63ba-0961-88e0-daf5-2c7ad3094194@gmail.com>
Date:   Wed, 13 Apr 2022 10:01:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] thermal: bcm2711_thermal: Don't clamp temperature at zero
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20220412195423.104511-1-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220412195423.104511-1-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 4/12/2022 12:54 PM, Stefan Wahren wrote:
> The thermal sensor on BCM2711 is capable of negative temperatures, so don't
> clamp the measurements at zero. Since this was the only use for variable t,
> drop it.
> 
> This change based on a patch by Dom Cobley, who also tested the fix.
> 
> Fixes: 59b781352dc4 ("thermal: Add BCM2711 thermal driver")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
