Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD850651ED7
	for <lists+linux-pm@lfdr.de>; Tue, 20 Dec 2022 11:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiLTKc2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Dec 2022 05:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbiLTKcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:32:25 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF917061
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:32:23 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bp15so17882584lfb.13
        for <linux-pm@vger.kernel.org>; Tue, 20 Dec 2022 02:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1t/IWVw7r10QCWW4I+HlY30TmCiUf2ypn13OY8W7dy8=;
        b=jAjWA4xT7kPjRYfD4kJQbAgN02+MOjaWyb39y8dip8mOoziJIeoCslS44Q2pN3sCxB
         UiDoLfm3/f2cpZZseNmB07FF1sFgqqPeP9HHSBnnehypsu6sgsvxXGd1xNiudOe3m6i2
         5cpMaintn5pAW8yAWO1vM+g7LOHDxE0PXvMvmD3zfgzYZL5tQSpH4xsDwICDr9qfAFPi
         JKLLHYtwxDS+uEtfGN9JCVgg0AcG0H8ideq0FDBHD+kUXgfhgVbeJbv3+7NcKbWCIR7i
         gP1RghIwQ9zc5yBtly1mfahaYvEj9EW6uqNRrrBX2v/92upl6/MU3v9XdkuaNgbBAoh7
         ekwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1t/IWVw7r10QCWW4I+HlY30TmCiUf2ypn13OY8W7dy8=;
        b=Ct8tA9az5Aif8WHAvdW3zIvGjLDc0cJZ7Ce9HyS65DPPJH95myqqBMjclKYebXkL1q
         gUOnW0Lu7qN8zDM4dnQ9xS/xWAKHgOXfZPNc/vVNsDGdfN89JYGlmULq1qubfDMlvSzn
         Yyt+KBttWA9434lmLuupdlSvaTBMJtBezusI3UmQMnXUsv050eGhPNMkpXLqedqrhAfZ
         syVWhg4N/vKIdCMCOV8/0OOwqwBSf4le78diX0zAni1Kki1ZUxWJWyhYlO39bckpc9yi
         ESdeStf5bHzH2hLJDHihwiHLiA9nCJDanB3DGdlC4tNgz0MQMoPCFYZIDNtb1v2x8dJX
         q6Ng==
X-Gm-Message-State: ANoB5plhSzdE3eNCN3vdl+qEEOgxX8k0LNFJMpFNMJaBzHvMyYJmXW/S
        IpkD5E07h6RNU+h/KOoaivcmXw==
X-Google-Smtp-Source: AA0mqf4b3ocOYQJkS+PY99VtTIfthteZE0+FPQAbNjx0pVkZzgXiew6heHs9apE47RtuS9zoiFdylA==
X-Received: by 2002:a05:6512:3ba7:b0:4b5:7c02:39 with SMTP id g39-20020a0565123ba700b004b57c020039mr18547421lfv.47.1671532341836;
        Tue, 20 Dec 2022 02:32:21 -0800 (PST)
Received: from [192.168.1.101] (abxh212.neoplus.adsl.tpnet.pl. [83.9.1.212])
        by smtp.gmail.com with ESMTPSA id 14-20020ac25f4e000000b004b591c33b99sm1413157lfz.13.2022.12.20.02.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 02:32:21 -0800 (PST)
Message-ID: <5f4046df-906b-5673-81b9-ab37294ba443@linaro.org>
Date:   Tue, 20 Dec 2022 11:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 08/15] thermal/drivers/tsens: Drop single-cell code for
 msm8939
Content-Language: en-US
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20221220024721.947147-1-dmitry.baryshkov@linaro.org>
 <20221220024721.947147-9-dmitry.baryshkov@linaro.org>
 <78fd7174-9aa4-f067-72ca-514c8fb09ee5@linaro.org>
 <d0a6b9cb-f321-7d5b-5767-acd12cfd78f1@linaro.org>
 <5bd2c0cd-741c-8865-5f35-25baf6787480@nexus-software.ie>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5bd2c0cd-741c-8865-5f35-25baf6787480@nexus-software.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 20.12.2022 11:26, Bryan O'Donoghue wrote:
> On 20/12/2022 10:21, Konrad Dybcio wrote:
>> The point of this patchset is to remove logic like this, as it's
>> very repetetive and all it does is read fuses with a ton of magic
>> offsets. Dmitry pushes that to DT with the generic nvmem API, so
>> that instead of these magic &s and <<s, one is simply supposed to
>> define QFPROM fuses at the correct offset and with a matching bits=<>
>> property. This does not remove any functionality, it just changes
>> how the fuses are accessed and makes the code more generic.
>>
>> Konrad
> 
> Hmm but then there's extra work to get this working again on 8939 right?
> 
> Seems very dogmatic to drop working code for want of sending a dtsi out.
> 
> Certainly my preference is to keep exiting working code and just complete landing the relevant dtsi, rather than eject working code and have to do the same work all over again.
Well, I don't really know how to say it in a way that wouldn't
make it sound mean, but trust me I don't want it to be mean..

Mainline does not and will not (for the most part) care about
out of tree code, so cleanups of parts like this with no users
are wholly expected if your DT hasn't landed upstream (or has been
stuck in review for a long long time like it is the case with
various parts of 8939).. Keeping this old iteration is blocking
progress, as the other similar ones (that *do* have mainline users)
are left in place just to be backwards compatible with old DTs
that may have been pulled from torvalds/linux by third party projects,
like U-Boot, *BSDs or something. Trimming away this now-duplicated
code will shrink the driver, reducing bloat for everyone that
compiles it in and doesn't use the 8939-specific path.

Konrad
> 
> ---
> bod
