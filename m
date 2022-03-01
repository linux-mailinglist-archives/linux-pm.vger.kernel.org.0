Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3A4C9747
	for <lists+linux-pm@lfdr.de>; Tue,  1 Mar 2022 21:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbiCAUr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Mar 2022 15:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiCAUrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2022 15:47:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A946A037
        for <linux-pm@vger.kernel.org>; Tue,  1 Mar 2022 12:47:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so1370593wmq.4
        for <linux-pm@vger.kernel.org>; Tue, 01 Mar 2022 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IWRthtglu8eRkkXULTpkF/YK78fARAhKmN/Na9bYdxE=;
        b=raOrzakU/APpa/kW7WaNpnlDiHQsQWrah4PXR7VazQ709QDuZDRWaI5ZDGUha8asHe
         0BgtqNM7KjebnpGOBNj44zPz4tATNqJKBCA8bAHe/qVZqIEsnCp/PrrlVsimSViKbGEu
         kafoTuHoqY4zc6AHUteV1JTxOLOcWXB0ZbdkOx98RO9PMcV1HHb+CDjwhxfHBUiwDkNn
         MWQHERhXBKie1Zoma1CJXznQxoJT+dIfKutalVdKK3CrMP3ud/Ke7JNGfTSjxbeo7+sG
         K2vR7tvrnMf85YQGFnW/wFBAvyJJVti1cpVCJhKUlohibKw0kRR8tsOPWjoD4zc2bUwG
         i3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IWRthtglu8eRkkXULTpkF/YK78fARAhKmN/Na9bYdxE=;
        b=TApT+vlZnzJnz4okM7bBqxuM0c3d6z3vatP7Z1+GhJiIfKVCFCe7bPD3d2xxQuuWf3
         fynLhBEpv1xAleG+MFBseXanNngBnZFXFYSte5uZHy58lQhqHr1epixY+dQkofdW+b4k
         Id+TML+/M8LIeBMGBt34IxYUxAn8FDcXejNShFiA0aydhf1hJzVS43noPO1wrK4NY+YX
         FaGN1W5dx8KnRQ7ZUqdSKsDtSBsJ7Y8xQMqpJcOOqbJpHO8MppoUUinyU3bbixlKLktf
         j08KeLrgQ1JtP0W0SEvOD5pdIOuFPdf9uzh6D7YdWCWgUd7xpuzqmnAs264aB+EB1wwf
         IWWg==
X-Gm-Message-State: AOAM531gY9QietaK9Wj3S+6fpLkrwsGCzdMEhwht1C6mbvvY9Y5nExfF
        UGOwDXrbVX4bp/hhqRdW6eUyhg==
X-Google-Smtp-Source: ABdhPJx3n8Px49CnN1M4jXMPkOofCg4r6VJP+S9+FplnOiXmS4KhG67BnLgQcm8RtSYN6IosPovTKA==
X-Received: by 2002:a05:600c:19cf:b0:381:7ab1:46ef with SMTP id u15-20020a05600c19cf00b003817ab146efmr7024095wmq.104.1646167623121;
        Tue, 01 Mar 2022 12:47:03 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55? ([2a01:e34:ed2f:f020:49e8:f41b:b2a3:3a55])
        by smtp.googlemail.com with ESMTPSA id f18-20020a05600c155200b003816bac83f6sm3988949wmg.27.2022.03.01.12.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:47:02 -0800 (PST)
Message-ID: <f6f61340-24b1-770e-6b8d-9b47218a87be@linaro.org>
Date:   Tue, 1 Mar 2022 21:47:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] thermal: brcmstb_thermal: Interrupt is optional
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210426213647.704823-1-f.fainelli@gmail.com>
 <933c889e-dee0-4fc3-bf1a-b3655cabbb28@gmail.com>
 <7359c3c1-8928-d448-e503-13f587cbb567@linaro.org>
 <2f8da2c7-98c5-4061-2e16-42b7fd4f9694@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2f8da2c7-98c5-4061-2e16-42b7fd4f9694@gmail.com>
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

On 01/03/2022 19:05, Florian Fainelli wrote:
> 
> 
> On 9/17/2021 12:51 AM, Daniel Lezcano wrote:
>>
>> Applied, thanks
> 
> Was it applied? I still cannot find it in linux-next or Linus' tree.
I thought it was :/


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
