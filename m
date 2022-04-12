Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487394FCC5A
	for <lists+linux-pm@lfdr.de>; Tue, 12 Apr 2022 04:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbiDLCXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Apr 2022 22:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiDLCXI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 22:23:08 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6832DD6D
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 19:20:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 9so20866161iou.5
        for <linux-pm@vger.kernel.org>; Mon, 11 Apr 2022 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XhnTklp0fQG5pWOShkm/danr9fm3RkxrfyE711IIN7k=;
        b=U+1PDjTuoCGYknyL7HpFT/+ttl3I5qlCt/8Mw0EsMBgbZbMJ6dY9XpX0AEDK/+ckiv
         m+cjSCPj7jOrvat0rklcSnY5jOA/wzz/ufNzlNGRXlzcn4CsWC5NEicUGTo+Rwf6F8zd
         FRdcufcaJ38zz9IMVSNqOof4U8mVxnENoHykvzkzePsZydnb1iBTQCQr2rK7KZ65sjgL
         UOnhFDCDAGpGXtTc5bYEWnD6avl+i3GZ65Fgo+IV2hSMaiTF1lWtcuim7/yYPKP8Rhoa
         1+CbeQ6uCFEVCaMYFfI9CbOjoH1R91hjUfE9+ZXYCzhQYurJoO+i6e/ALGqKb0WfKU1G
         5q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XhnTklp0fQG5pWOShkm/danr9fm3RkxrfyE711IIN7k=;
        b=XeLftFnRWMspTAkcuHx0LqPgSFeYVeZgT68NwooLpoetjvbL9YSkLdJML3+e9DdDLI
         FYPhMeLr2AxPWpj2GoDFuCVAx10jx5XyEtmAmdsGEUHRsLSLHj6xlP9NoPd9Cb/FDd0F
         mwUqoOuk7QhDWE7vck4P8KLOz49xENbKaE3vN3j2PndEIelzJuy+zRDNU+Hla7FdgxJo
         T6Fdkt2zVTxxXe3EyvL/mhJC+ceiAAjQnpfuM3/1ry6cVfGNjbqn6iKdyymOMeBvjvEs
         5Q2dmTSzckvhkTRTXr6U9Q3RaXlOlP/6/EJy3sqRmaVw1LOe6m2LTgriANLiRqG3ItAV
         hJFA==
X-Gm-Message-State: AOAM531GYFD0lHWyXYlvgM53f4WQi498BaAgyf21ioH1/iVWT8BFYz0m
        sATOB0+b4Hs8SNZ9HZWXQmZ9OQ==
X-Google-Smtp-Source: ABdhPJzhpeEsiMfRJacURjg0vZNsByvJdMIjOgp3eU1Kxs8hl8gYMXtT8CDzZ9u90TPydF5CXiMnxQ==
X-Received: by 2002:a05:6602:134f:b0:63c:a7ba:e8d with SMTP id i15-20020a056602134f00b0063ca7ba0e8dmr15081382iov.180.1649730051372;
        Mon, 11 Apr 2022 19:20:51 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a5-20020a056e020e0500b002caca72891fsm654390ilk.27.2022.04.11.19.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 19:20:50 -0700 (PDT)
Message-ID: <d39cc8a1-ca52-e902-e761-35e06a67aba9@linaro.org>
Date:   Mon, 11 Apr 2022 21:20:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] interconnect: qcom: icc-rpmh: Add BCMs to commit list
 in pre_aggregate
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, djakov@kernel.org,
        okukatla@codeaurora.org, quic_mdtipton@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mike Tipton <mdtipton@codeaurora.org>, mka@chromium.org,
        dianders@chromium.org
References: <20211125174751.25317-1-djakov@kernel.org>
 <CAE-0n51xeigKFS9Zek44HZGD9cdc4Em91aQ5HHzuy7P1FBmfFg@mail.gmail.com>
 <a96a010d-9bd7-f760-3c03-d842feef41aa@linaro.org>
 <CAE-0n51-hpG_5O11FbGrHaMr_mN0ZAky8CVzZNmDj29aK8wGog@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <CAE-0n51-hpG_5O11FbGrHaMr_mN0ZAky8CVzZNmDj29aK8wGog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/11/22 2:06 PM, Stephen Boyd wrote:
>> I have a hunch about what might be happening here.  There is
>> some synchronization that must occur between the AP and modem
>> when IPA is starting up.  Until that synchronization step has
>> completed, we can't allow the IPA network device to be opened.
> Is there a commit that implements this? Or how is the synchronization
> done? I can debug more and see if that synchronization is happening.

After testing today it seems maybe my hunch wasn't
the root cause.  If you disagree and I'm missing
something, say so.  I will take a look at that
though--my hunch--to see if the thing I thought
could be causing a problem can actually occur.
If so, I'll figure out a fix.

					-Alex

