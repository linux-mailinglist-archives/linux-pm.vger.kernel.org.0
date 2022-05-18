Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7C52BD1D
	for <lists+linux-pm@lfdr.de>; Wed, 18 May 2022 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiERMrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 May 2022 08:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiERMpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2022 08:45:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106C915EA61
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 05:42:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so3396930lfg.7
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2022 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2vgkcgkvD6wC0cwxlemq7x356q295GLVNbkOBzA2YxE=;
        b=rlTF2pGNUZ9xLVv7e1nEF+Z3G5BSfstynEyJnmTmPoeV6RSyZbW1LUGnGw1Q7IYPXM
         Q+VzTkQIlFuiGJ6IdMs+bx3r9/FZIZFKzAqWB4Dt4Si32pe5pXa3Zw7e5I3st9+Ia10B
         TfrsXjgZNHD8xT3A7CyE8qHgCIZr/9xpUKl1Hccz5PUGAB+6Ht3fVRQYbT2vo4ND0JYN
         DcJxaYIV2oSE2Ken3soy+f+wSqSWffY1hf1YTcY0YePoZOFGILCjpP+pbTN24wWQpiAU
         24efTgUqyn4IT6TP0hPnqKM67GA2FdJoheXSM4ncMif9/BKtWp87b+PvDSCEoTGaYZqg
         yFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2vgkcgkvD6wC0cwxlemq7x356q295GLVNbkOBzA2YxE=;
        b=Ee2lpw5R/ddVHen6+D4rhq+1SAcZZMWt6Dr0HjflZNk9hLAl8m/LgInrYBF3QbH8WQ
         RyWvaYVaFv3VmgRKnRN7xqHUwm3t6jNPR5YcIYhlCHB1iCGBIXFBPUqsVzQU+oVcAVHy
         JR4Drq6CzcfeVkBhTq7SF5AmL50fyuRlr7l+DJJbgPIA3zuTXsgAZKZs6135t99qhUGE
         2HROniyH1GfaWQPFas1xv7ugxYNd6wmaM5VYSYPyKCHx3ghxuZ961o+2sc5CTbjVzIgh
         hrk5epIqe4cJ7F++aIEtPkh7bKNg9vg+ERKanGFiD4+/S3z6Bv0FxIy8AtoIlL3EPRuL
         Y5hA==
X-Gm-Message-State: AOAM531R52/DpvWcMpVG39E6EX6Iy2pFSWcjirFTh0xwrHpzPARbZW1G
        r+JJHI5lLwNIS7+bDuBqKH0ccA==
X-Google-Smtp-Source: ABdhPJxN+RYfgFZsiy+AoktspD9yuD3bHCCzUdtzXetU8hXThMYhg4oVLuLhwc6T+t+3H8Oe3L/TQg==
X-Received: by 2002:a05:6512:3f96:b0:477:c0fe:9b05 with SMTP id x22-20020a0565123f9600b00477c0fe9b05mr103111lfa.109.1652877738130;
        Wed, 18 May 2022 05:42:18 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e994a000000b0024f3d1dae7dsm210967ljj.5.2022.05.18.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 05:42:17 -0700 (PDT)
Message-ID: <9417e665-c1d4-e82c-5c55-a2c5860cc453@linaro.org>
Date:   Wed, 18 May 2022 14:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v9 1/2] dt-bindings: thermal: k3-j72xx: Add VTM bindings
 documentation
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Keerthy <j-keerthy@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rui.zhang@intel.com,
        amitk@kernel.org, kristo@kernel.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org, vigneshr@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220517172920.10857-1-j-keerthy@ti.com>
 <20220517172920.10857-2-j-keerthy@ti.com>
 <783127cf-79cf-90f2-4200-30db56a1fd7c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <783127cf-79cf-90f2-4200-30db56a1fd7c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/05/2022 10:27, Daniel Lezcano wrote:
> 
> Hi Krzysztof,
> 
> I would like to pick this series, does the DT bindings have your blessing ?


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
