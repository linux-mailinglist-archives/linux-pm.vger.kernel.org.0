Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA24BB9F6
	for <lists+linux-pm@lfdr.de>; Fri, 18 Feb 2022 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbiBRNSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Feb 2022 08:18:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiBRNSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Feb 2022 08:18:20 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9E447565
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 05:18:03 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so8620961wme.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Feb 2022 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1tjby93Kc0Rn0tn7HQGSR30mDcuNIiCk/GNgyX9AHkw=;
        b=bvMMy9//es+9+ewHV20w2BEQo+h4RaTbmkqBVO6dIowt5wZk9jNqLvH29R1QTcy26+
         u0sGCtZDFWX0FVc9Yb0Gk2gOhMWe1Cg/mbRnrPqrocrplYKzeOCNhMK7qEuf9vBYdA+G
         8XWElUDu6zeeiWRNbDFn/0tA2cvhS8gOmSKZHMGFn1Ne9A2UDvHudKH52Amin2ZMrXod
         2TXd6RU6xvJ4AuVJp3xVN9MAjAfqx2auYaukjwol2ry1/pt/B2pztYdW88VaSAuTdt1s
         pf62Ky1j0a0euiquOQX863Y25e7JFO5cPjFAsngoStB4W5XPzkSBrNBIR8DN9d+gZcW5
         qdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1tjby93Kc0Rn0tn7HQGSR30mDcuNIiCk/GNgyX9AHkw=;
        b=l/7ih2jYtlHz/SZ/jihN/N7ZwZKWqnlCPBNGLfwPDANiTQqpNjvIPT+dd/HE6OCn1G
         wIAx+eeHWbr+MkVbggg0P46od1mNK35dV8aGKzZfgYoBc7DMtVjnzm8nKXyJ71Bg5vUn
         +vLJQaWOX4Rac693vnSihNbDRbkfa7BtKXloFvn5onml1+acOeWa1Rx37j6GYeourwqw
         Ya7bg2SvuF97uNCiQIycIQRUoxzZ9RPuYmF/aZPVqot3t52ysnU37xDuv5Sygin21n4a
         P5ItlW9raIBZSKkMWXCpN1LqhmZliB5YKwHHENVK8nGFAJFvx4FeyewM/M8GfmntZ85i
         B7yw==
X-Gm-Message-State: AOAM531jX4F4my71sXD7yptI/8cpAVbCeklI4CKdhzGThLRx+27BSfBg
        NrV1sqgKGGik2CGXG1XxaTISjg==
X-Google-Smtp-Source: ABdhPJz0Xa/vx1HB7VdVRhG685lAUCyCyEt2mtKyi+OdqV6Fwc5a2yuxce1Zhb0sH1txCPdXVasgcQ==
X-Received: by 2002:a05:600c:1c1a:b0:37b:ead2:8e6d with SMTP id j26-20020a05600c1c1a00b0037bead28e6dmr10938796wms.94.1645190281772;
        Fri, 18 Feb 2022 05:18:01 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:5828:300b:5226:ef02? ([2a01:e34:ed2f:f020:5828:300b:5226:ef02])
        by smtp.googlemail.com with ESMTPSA id m22sm4727187wmq.35.2022.02.18.05.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 05:18:01 -0800 (PST)
Message-ID: <41214f23-ddb1-f60c-5e2a-96ba161cf727@linaro.org>
Date:   Fri, 18 Feb 2022 14:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org>
 <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
 <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org>
 <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
 <cfbaefa5-fc7b-bd0f-e4ed-8f046de2a7cf@linaro.org>
 <CAPDyKFoWq+i09Ts_+SAz9ctC2a7-cqC71buDmvb-LZFTVSH+DQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAPDyKFoWq+i09Ts_+SAz9ctC2a7-cqC71buDmvb-LZFTVSH+DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/02/2022 16:45, Ulf Hansson wrote:

[ ... ]

> Does ops->release() also resets the "dtpm" pointer to NULL? If not,
> it's good practice that it should, right?
>
> In that case, we would be calling "kfree(NULL);" the second time,
> which is perfectly fine.

So you suggest to replace:

if (ops->release)
	ops->release(dtpm);
else
	kfree(dtpm);

By:

if (ops->release) {
	ops->release(dtpm);
	dtpm = NULL;
}

kfree(dtpm);

?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
