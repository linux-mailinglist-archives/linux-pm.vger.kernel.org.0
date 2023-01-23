Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80A6779D5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jan 2023 12:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjAWLIe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Jan 2023 06:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjAWLIc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2023 06:08:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E7233D5
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 03:08:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n7so10424024wrx.5
        for <linux-pm@vger.kernel.org>; Mon, 23 Jan 2023 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQhr3/JItD8hiN7B4W7XTXf1SnlTBU1RgIeCnQ3jPKA=;
        b=cdX/kt69lIxdnoYMqHALGJ85P2JsDX7UIgix1qTebzlEAE4wFYkZRWuS6tr4Wg5RlQ
         tpUsh7OAKuQYChuXpqsSkpUYZ5kpNjKktcQOU2RGepS8vQm3XZKDY3cfpefVlMvep76L
         TQpLv2rwgTVzAHVATahafe9KB3kZYEqvPnCO9YAtw+NThIiHVHs1n2qGshd+5b+sPGeB
         OS0RQ3UgUHb4zimpE/Vt9xX5zC48zjeMmZuxQmOPzcQWFNT9+47Igf+M6cAE78HBBpMa
         IMfHfnsq3HJJ+PkfHQ6jovCLBKbaiBf0I1rQFXgVwVtjSnO5LDvuzWpGMuF/rbg0JPOl
         AA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQhr3/JItD8hiN7B4W7XTXf1SnlTBU1RgIeCnQ3jPKA=;
        b=EpNdgHz0EaUt5F4MuqGeKFYNR+d7abC6rnF3FlJqZvnPTiYS73ggEuHGoOZiXE//jb
         tPFfKWMngAdzhbJZ+byWeBy20chfkBLygjzJyzjdmQh27HFlQYMaeN/+a9GiO/TYjJQZ
         o6n5DKQR4PQk6Zdghwusce7+1c01Vb+Llc7+q2dn49fISVSZG6DgKNhXAbLfU5MTu9aI
         Eu1dbuVddKk/nY4IFO8FAyXnjYGOO/UXnW+KrKG8Ek9z+vxMIEhC5t8xIzOqHf/AkrAa
         vdrOHbnjkna7ByCXmsVW/0HTOdbZTobpu5TgYp1c0wpxhkCjs2UN2FndKQAJbs/lr3cf
         1rGw==
X-Gm-Message-State: AFqh2kqX82nyzfuNRtL387Ppy4nQUvkkFMGtqwxwsczDO2jGSR/vuYVX
        sP/q4L/bcIQbEGVVW9k9bCgWkQ==
X-Google-Smtp-Source: AMrXdXt5O7dxKnG4Glq1alTML0xWLrojOeN5LDDkhRQ34p8sStaW4LtOUIFMQQKPT3KO6CtLnx/8tg==
X-Received: by 2002:a5d:660a:0:b0:2be:5162:c8da with SMTP id n10-20020a5d660a000000b002be5162c8damr12676248wru.16.1674472109680;
        Mon, 23 Jan 2023 03:08:29 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id bt14-20020a056000080e00b0027cb20605e3sm18488946wrb.105.2023.01.23.03.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:08:29 -0800 (PST)
Message-ID: <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
Date:   Mon, 23 Jan 2023 11:08:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/01/2023 02:31, Bryan O'Donoghue wrote:
> V4:
> - Adds Krzysztof's RB to snoc-mm
> - Re-orders alphabetically missed nodes in previous iteration - Bjorn
> - Adds LK address/size cells comment - Bjorn
> 
> - Left _AO for wcnss as downstream reference uses this - Bjorn/Bryan
> - Uses qcom,ids.h and QCOM_ID_SOCNAME for qcom,msm-id - Bjorn
> - Revises comment from "Regulator" to "Power supply" - Bjorn
> - Leaves dummy power-domain reference in cpu defintion as this
> 
> - Relabels "cpu" to "CPU" to be more consistent with other dtsi - Bryan
> - Moves msm8939 gcc to its own yaml file to capture 8939 specific form - Bryan
> 
>    is a required property and the dt checker complains - Stephan/Bryan
> - Removes CPR entries from qfprom - Stephan
> - Left MDSS interconnects. I don't see a bug to fix here - Stephan/Bryan
> - power-domain in MDSS - dropped its not longer required after
>    commit a6f033938beb ("dt-bindings: msm: dsi-controller-main: Fix power-domain constraint") - Stephan
> - Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
>    Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
>    GCC_BYTE1_CFG_RCGR : SRC_SEL
>    Root Source Select
>    000 : cxo
>    001 : dsi0_phy_pll_out_byteclk
>    010 : GPLL0_OUT_AUX
>    011 : gnd
>    100 : gnd
>    101 : gnd
>    110 : gnd
>    111 : reserved - Stephan/Bryan
> 
> - pm8916_l16 -> pm8916_l6 in dsi definition, typo - Konrad
> - Moved regulator_set_load location - Konrad
> 
> Previous:https://lore.kernel.org/lkml/20230118050948.bibhq26s6sgzullg@builder.lan/T/
> Bootable:https://git.linaro.org/people/bryan.odonoghue/kernel.git/log/?h=linux-next-23-01-23-msm8939-nocpr

Let me translate my 2:30 am email to english, I meant to group this by 
reviewer

V4:
- Adds Krzysztof's RB to snoc-mm

- Re-orders alphabetically missed nodes in previous iteration - Bjorn
- Adds LK address/size cells comment - Bjorn
- Left _AO for wcnss as downstream reference uses this - Bjorn/Bryan
- Uses qcom,ids.h and QCOM_ID_SOCNAME for qcom,msm-id - Bjorn
- Revises comment from "Regulator" to "Power supply" - Bjorn
- Leaves dummy power-domain reference in cpu defintion as this is a
   required property and the dt checker complains - Stephan/Bryan

- Relabels "cpu" to "CPU" to be more consistent with other dtsi - Bryan
- Moves msm8939 gcc to its own yaml file to 8939 specifics -Bryan


- Removes CPR entries from qfprom - Stephan
- Left MDSS interconnects. I don't see a bug to fix here - Stephan/Bryan
- power-domain in MDSS - dropped its not longer required after
   commit a6f033938beb ("dt-bindings: msm: dsi-controller-main: Fix 
power-domain constraint") - Stephan
- Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
   Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
   GCC_BYTE1_CFG_RCGR : SRC_SEL
   Root Source Select
   000 : cxo
   001 : dsi0_phy_pll_out_byteclk
   010 : GPLL0_OUT_AUX
   011 : gnd
   100 : gnd
   101 : gnd
   110 : gnd
   111 : reserved - Stephan/Bryan

- pm8916_l16 -> pm8916_l6 in dsi definition, typo - Konrad
- Moved regulator_set_load location - Konrad

