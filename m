Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1752D571772
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jul 2022 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiGLKhu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jul 2022 06:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGLKht (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2022 06:37:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC3C87F67
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 03:37:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o19-20020a05600c511300b003a2de48b4bbso5127980wms.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Jul 2022 03:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tjMfaydTRTgJyx1lu/TEd/gXDLfuGAA5wpef6j4GRzs=;
        b=R4iv9NvBHsHbnieGm9h9f54MNH0+1zPRKzpiK2MGZkozv3iDZAlNfvJQDe/A4rcUPE
         gxriBYRtg9tuA0P86wjFAsQ5XjVLOYGjJwlOn/1NUDazoe7W7iQklaYkx1LyTAHegwkD
         65bwZGo48jtxlB3sWxv7ajELEenWQ7iW2PPRFMnsq4si7ineLz4qM76VRdPzgQChUnKg
         za1vfr+ej245kd8zePgStebBki2cmQqeULF2QSWaR3dWd3EArKqwA1o9GS30At9Bb0pv
         M5dZuVjiIlzdLOHYyGt6Sr0gFsVNIz6Zqp/mX6tlw4seyPzUXlHiEBme5F8UgvTKi+/M
         6Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tjMfaydTRTgJyx1lu/TEd/gXDLfuGAA5wpef6j4GRzs=;
        b=k72AFv6tKurMr3hX7R9E4fvYLyJWPHsQV7i+8+iR054DybABs6tQzvBcPVpZHEMxZE
         6fd+h9aMcmQD2TKvYg+ObQkNUNBM9GBthAZQykYY0MD/X4pXfDywGHsgCV/44me+MNRw
         9EMiC6uDly8hf2B3/AyPeIDg6es60FVcv2ENtcwy9jYoTCGHT8TxCG6+0zNbu2eCWCoG
         yyejWF3oBCsTvFf178K1uC6BXdAITkDgQdy5rQVk3kfy55DgcqBVhffzw0ohdIalcpKj
         9sBvCBWDM9GP9RgLqv9v50qrjEtBKM677SCTHDPua7zYek1+7DJHavBsyUBrB0uQZoMW
         N86g==
X-Gm-Message-State: AJIora+FIaDHdSrXGAE79yGnMPuPGcRgh/DAmjVMDXxWMMg7OEJAOFYY
        jHuQLvH/EnEMsYAGQCB3uM8aow==
X-Google-Smtp-Source: AGRyM1sfOUCYpj+BD8dbeZW43gKGc/Indmn6Bn8YnBzgqcY8lr56+nAZA1BsTvjgfuTtBngF900Bmg==
X-Received: by 2002:a05:600c:1908:b0:3a0:998c:313d with SMTP id j8-20020a05600c190800b003a0998c313dmr2898126wmq.19.1657622266938;
        Tue, 12 Jul 2022 03:37:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:da26:64bf:ffc2:b735? ([2a05:6e02:1041:c10:da26:64bf:ffc2:b735])
        by smtp.googlemail.com with ESMTPSA id k28-20020a5d525c000000b0020fcc655e4asm7955196wrc.5.2022.07.12.03.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:37:46 -0700 (PDT)
Message-ID: <c1d3ed49-096e-00b5-7100-dc3dca523bb6@linaro.org>
Date:   Tue, 12 Jul 2022 12:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/3] thermal/core: Encapsulate the trip point crossed
 function
Content-Language: en-US
To:     rafael@kernel.org
Cc:     quic_manafm@quicinc.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
References: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220708183210.1334839-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/07/2022 20:32, Daniel Lezcano wrote:
> The routine where the trip point crossed is detected is a strategic
> place where different processing will happen. Encapsulate the code in
> a function, so all specific actions related with a trip point crossed
> can be grouped.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Is it ok if I pick this series?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
