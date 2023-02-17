Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBA69A8E3
	for <lists+linux-pm@lfdr.de>; Fri, 17 Feb 2023 11:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBQKLz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Feb 2023 05:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBQKLx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Feb 2023 05:11:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464F7627D0
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 02:11:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id l11so2835725edb.11
        for <linux-pm@vger.kernel.org>; Fri, 17 Feb 2023 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XDRpdpBWdFb6EOdNes1o07LdLE88/XFjpZQhQSJTWak=;
        b=rlVVIK+5+nFzlvkFNn8hiBNsq969o9yo4H9uLGDFrY59+XMPHc5MufC/iCqzlRE/rt
         LxuceQ8JEYI/rzPbnx+PbNbX2O7x6AWT9xujroy7+PnBsGouBFJw1hcPrRezCGuO8TMc
         4ZaKPyyLPJ8lgT2TIJej58n4nwaDdPRFCNqVYiPYzOWmAV5xAickd+MdutsG2xLXJD5L
         6ID59mUtWyWiYv4COtGOKRy5vGrgCQGk0QmNxFRZ1SUfvnl1OTPrkGDGDG30RjNyHuMi
         5GK+lQwb2oab6fFS9bii2IQIEDNrgrPl3divqjvuqHFDDSGJHcRs5+VXNYZrnNYiUkOK
         cevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDRpdpBWdFb6EOdNes1o07LdLE88/XFjpZQhQSJTWak=;
        b=TdbM2gx6m/9XfeNJOeVrQyLJJzjxeUXM2BhdLe0S0LZ/GCR3VfnkbeW02oh/7Qdcs+
         dR5gszGb24DuSjBpkXYqlu6ujegURdEBO/SFDCVS+9+ECGBkRP3C+4N5aCnxDZcXL/y0
         GQ0EslbRuSvaHWV8Clo0jT/ze2OLhVBnS3BpoFxEqjpAPiAejCgL4N88W8RZ6Ym++lE9
         lPVH6JV9X1U3rZFzFxs6GQaFjQOJ2k89yeVkiwg4yb2IDzxadblcM5LlRHZWVl/vjDyH
         gxiJgJzOSyU2clyrmOZg86zzOOkBxnwtdZVDZXEcWttVN+AVkr7l8JacsMkCFR+W/U+K
         QOgg==
X-Gm-Message-State: AO0yUKXrW/wRZuwouA5plCbxLb/yQUGYREZFIMk1zxIM2VaqVxT9w+EB
        /en+LNLBp2nmBfGZtN3Bp2G+3w==
X-Google-Smtp-Source: AK7set9IAzpQ6WhPu+U/GhhX7HihyBSQKr1YCJLTTgg/FdNj1d63I8AQqIpQUeGg33gN1FafpXuX7w==
X-Received: by 2002:a17:906:5357:b0:884:c45f:1c04 with SMTP id j23-20020a170906535700b00884c45f1c04mr386648ejo.2.1676628709805;
        Fri, 17 Feb 2023 02:11:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w18-20020a170907271200b008710789d85fsm1945128ejk.156.2023.02.17.02.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 02:11:49 -0800 (PST)
Message-ID: <ec046b79-ac83-1d5c-4a77-59a8f313e52f@linaro.org>
Date:   Fri, 17 Feb 2023 11:11:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
To:     ChiaEn Wu <chiaen_wu@richtek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org
Cc:     cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
References: <1676627755-14349-1-git-send-email-chiaen_wu@richtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1676627755-14349-1-git-send-email-chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/02/2023 10:55, ChiaEn Wu wrote:
> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> "richtek,rt9467" because it has to match the "compatible name" in
> the source code.
> 
> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 battery charger")
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

