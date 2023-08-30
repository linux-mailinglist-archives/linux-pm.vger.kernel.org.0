Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A535A78DA3A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbjH3Sfw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbjH3HL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 03:11:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50221B1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 00:11:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a4b62c2f5so6803388a12.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2023 00:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693379482; x=1693984282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X810Sd+FAfinOuDeQjJFxdDeSuw3tPSc7gW/bUxxmc=;
        b=a9Y5QTZNXXKs9nPMXo417JCz/QKAcQy1xgeBcXtqVuXe8uLKIF/yrOaNpEqX5Pf/io
         qnuGi5UXluXpNgEWOMuiC4+Ggl2M0NZOjzcklz6pcZqj+UgvxAwRdDyqwSPJTKtQ8gCi
         E6r3gXNYg6pZmJvhTzV41yfhyS6mfmHJfZug5MngAZFOj+hp5fdpWHyOdjUH1IiXNCv1
         jalUgZPSNf/zajd4QppFkTKpi287wr+TGEa7xceG9zzvCugTzra0mSuN02GSSlhpIOtL
         4YIlKRcCf3Rof4g2Z8+IuqizM6pf39m6nGuhIissvFGfQ12UQghjwZd5INmkAZngSYHK
         5SgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693379482; x=1693984282;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X810Sd+FAfinOuDeQjJFxdDeSuw3tPSc7gW/bUxxmc=;
        b=G32NNRNRar5elyygii1jeOkgYa3CNkTSSDGCG5U74dxWOvTRnHVllWmYXM1VhSOJT7
         MYlksVWMOYzBbnqDq+ElG606Ue+nb6/885WyWKKZMyYjnhp8ZTHStR31tHnT1EDU0k5a
         D5sN4PpIwD1Wk8qCt8mZdDNa/YPsbn0HhBLy+Y/+Pv3NQo/t/2ofeNrg0qCpMp9v7hcE
         zUvidn0uKuEcIGGz0w/X12TUDgZDaDtaCxiqr8Euw9+oAuiWHm7m6YdziDjmt9cgG5DP
         58vP6A+f2dn57PHn7ypLLltlam8vEifsCdu6N1wwaVyFFfylXKN5Vtd3ntOdF8RsFxj6
         0/EA==
X-Gm-Message-State: AOJu0Yya+WtAE39oqoHwOCeUrfDOLGInjOZG+12qaDN4Y8pcby2sPwJP
        wd1I3IFXqQ0Rlun2fwFWecpwkg==
X-Google-Smtp-Source: AGHT+IEYCPnvQKeOC3qIczHiEZucOO/GNEh252whblJjg9K7h3SNi2mOr9jig7a/o2KtxMadPr1MLQ==
X-Received: by 2002:a17:906:76c8:b0:9a1:d67c:b4eb with SMTP id q8-20020a17090676c800b009a1d67cb4ebmr913139ejn.48.1693379482411;
        Wed, 30 Aug 2023 00:11:22 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090625cb00b009934855d8f1sm6910043ejb.34.2023.08.30.00.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 00:11:21 -0700 (PDT)
Message-ID: <db8d5123-19d7-50d0-935b-a25d235e6e2e@linaro.org>
Date:   Wed, 30 Aug 2023 09:11:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/1] scripts: Add add-maintainer.py
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, workflows@vger.kernel.org,
        tools@linux.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1693037031.git.quic_gurus@quicinc.com>
 <141b9fcab2208ace3001df4fc10e3dfd42b9f5d9.1693037031.git.quic_gurus@quicinc.com>
 <2efba6b3-2399-9deb-d0ce-78f7b5e12f30@linaro.org>
 <20230828175629.GC23466@quicinc.com>
 <78aa33f9-ead8-b128-2a7a-40530a1a3ed0@linaro.org>
 <ZOz4XtX3DFRQpvQY@finisterre.sirena.org.uk>
 <670a87e9-2f0c-ec9e-ebb4-9041c8972ace@linaro.org>
 <20230829231638.GA27843@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829231638.GA27843@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/08/2023 01:16, Guru Das Srinagesh wrote:
> On Aug 28 2023 21:45, Krzysztof Kozlowski wrote:
>> On 28/08/2023 21:41, Mark Brown wrote:
>>> On Mon, Aug 28, 2023 at 07:59:54PM +0200, Krzysztof Kozlowski wrote:
>>>> On 28/08/2023 19:56, Guru Das Srinagesh wrote:
>>>
>>>>> Your function adds mailing lists also in "To:" which is not ideal, in my view.
>>>>> You've mentioned before that To or Cc doesn't matter [1] which I disagree
>>>>> with: it doesn't matter, why does Cc exist as a concept at all?
>>>
>>>> To/Cc does not matter when sending new patch, because maintainers know
>>>> they are maintainers of which parts. I know what I handle.
>>>
>>> That might be true for you (and also is for me) but I know there are
>>> people who pay attention to if they're in the To: for various reasons, I
>>> gather it's mostly about triaging their emails and is especially likely
>>> in cases where trees have overlaps in the code they cover.
>>
>> True, there can be cases where people pay attention to addresses of
>> emails. Just like there are cases where people pay attention to "To/Cc"
>> difference.
>>
>> In my short experience with a few patches sent, no one complained to me
>> that I put him/her/they in "To" field of a patch instead of "Cc" (with
>> remark to not spamming to much, so imagine I send a patch for regulator
>> and DTS). Big, multi-subsystem patchsets are different case and this
>> script does not solve it either.
> 
> Not sure what you mean by "does not solve it" - what is the problem being
> referred to here?

Exactly, no one even knows what problem you want to solve by swapping
To-Cc between patches...

> 
> In case of multi-subsystem patches in a series, the commit message of this
> patch explains exactly the actions taken.
> 
>> Anyway, if it is not ideal for Guru, I wonder how his LKML maintainer
>> filters work that it is not ideal? What is exactly not ideal in
>> maintainer workflow?
> 
> I am not a maintainer - only an individual contributor - and as such, even
> though I may get patches on files I've contributed to, I deeply appreciate the
> distinction between being Cc-ed in a patch vs To-ed in one. The distinction
> being that if I'm in "To:" I ascribe higher priority to it and lesser if I'm in
> "Cc:".

That's your feeling, quite subjective. I understand it comes from
corporate world, but again...

> 
> If this script is accepted and gains adoption, maintainers like yourself will
> only be To-ed in patches that touch files that you're a direct "Maintainer" or
> "Reviewer" of. 

It will not get traction because:
1. People should use b4, not this script.
2. Remaining people will just use get_maintainers.pl.
3. People cannot get right even basic commands, so we will never be able
to rely on To or Cc distinction. I can give you example: my email
address in get_maintainers.pl is a bit different. Does it matter? Often
not. Entire bunch of folks were Ccing me on different address. Even
though every tool told them not to...

> For all other patches in the series you'll be in "Cc:". I
> imagine that this can be very useful regardless of the specifics of your
> workflow.

Zero usefulness for me.

Best regards,
Krzysztof

