Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F6745DB4
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jul 2023 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGCNrx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jul 2023 09:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGCNrw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2023 09:47:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37944E51
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2023 06:47:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso531541566b.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2023 06:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688392069; x=1690984069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mR8kflAUl3Rreoc5lJ+BkszrAX8k/kBUds7AX5wTeQ=;
        b=luH7LMT3M6gjy+U9cz1PKrhJaitqeIjGWzyuCQk1Fg98SinFKK84u425JS/Pod4SEY
         W5iAMYzShDe/QD4iDQNjApF1N6nEliO1cv99bqxinSAVA/D3pgTnbHDCov21AJJ2UrdT
         Uh27Y+hdz3Q5nVDBRdA/DWhQyyCi+iJbXIavvGpbv90UClKFWobx5dGZAo4iRXpGmQ5V
         533VsGBlyklrUzpITzl6qeVIWbmF0rQApIENtAgSBRjhUWitb25lNQ4HzJh0ElGoDjzU
         /uZIzP80x6zRcdRRprqCzm9AQZpJ249deanxwT6mjuGM9LZBtY2aKfzTQOL+8RvaTAEv
         yPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688392069; x=1690984069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mR8kflAUl3Rreoc5lJ+BkszrAX8k/kBUds7AX5wTeQ=;
        b=VATnl+QXBp9R2sHIBfK05XeX3+i6MPmGQSN5CajZtkLr61AXqsrYHw2gJrwCzqBj2I
         0sy2LKtPC57bW0n7E2A7x7Ote3xt1qwookI5CvzfIqPJzt+WAhH/Xdre/pj2C+HHbMOz
         pjm4cs1UmZhIebgFUp6h23lBve0DuPv7IDzPktBfS7TFCfsTXh/Hl2KnClXhSp6QiJPU
         b0UCW9VG7uLDGLOFSFXGPqMKDOM0S8QVkgNpXucFPLZo9iJ3yxMMv3kb7eIjFMWY3jXZ
         xHGT9wfYRL9I0DZV7v/jDxpiCxCxYonT1ErpLItrGuHb/BLPub+9wRQlMUM0LikA3mvm
         0wdg==
X-Gm-Message-State: ABy/qLYnoK1JtxLwhphbhEhO1O77xT1eD+fKv1WB2tfOeBSXyid5MdmN
        7tynWphtpMM1YCY7yb1tR42IZw==
X-Google-Smtp-Source: APBJJlEL46+KVkuqPX8uIyw1aGCUFwRRFtVipSjMFgZQOsSGE44XK1wwr4iA1h2F4ukGGad+KbHMZg==
X-Received: by 2002:a17:906:1690:b0:96f:5747:a0de with SMTP id s16-20020a170906169000b0096f5747a0demr7622915ejd.6.1688392069742;
        Mon, 03 Jul 2023 06:47:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id oz31-20020a170906cd1f00b0098d15d170a0sm11936803ejb.202.2023.07.03.06.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:47:49 -0700 (PDT)
Message-ID: <5f501f0f-2362-4079-d833-6883b674e588@linaro.org>
Date:   Mon, 3 Jul 2023 15:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/2] soc: loongson2_pm: add power management support
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Yun <liuyun@loongson.cn>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230620090811.721-1-zhuyinbo@loongson.cn>
 <20230620090811.721-3-zhuyinbo@loongson.cn>
 <bd9661f1-b77d-2ce9-0de2-f559576bf55a@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bd9661f1-b77d-2ce9-0de2-f559576bf55a@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/07/2023 03:30, zhuyinbo wrote:
> 
> Friendly ping ?
> 

Please avoid pings during merge window. Not much can happen with the
patchset anyway. Resend or ping afterwards.

Best regards,
Krzysztof

