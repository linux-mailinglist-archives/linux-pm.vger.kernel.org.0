Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91276E416
	for <lists+linux-pm@lfdr.de>; Thu,  3 Aug 2023 11:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjHCJQm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Aug 2023 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjHCJQj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2023 05:16:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072EDE58
        for <linux-pm@vger.kernel.org>; Thu,  3 Aug 2023 02:16:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307d58b3efbso606746f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Aug 2023 02:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691054196; x=1691658996;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3qjTxnd4KtTTOKG14S4/4BnF9x1FwZI+P+SQK+cy1Q0=;
        b=CNJ2m5qzGE5gwyNdXs1sH6KOgQxlKSIHDjGkj6guZkjEyYkkO/XOqo/bP+FrP1ErPd
         ezB2MKpzBPnZLymibjrG6yL/pPAXWBRaf1kHrkKZIELELGLRvs0aWl4OEL2NALEGZm6l
         aAXtdq42NEv4YLPCJ4SKdR1cvpwrQBFAfeNdo93rpxPt3zg64ugXOaGAolNanT8v50w/
         Wd+kV0GlBFcvgDfQ22Bqnho/zumP59kxYuxJxJaFQpCn8tXOmVUgfjQOJOCcFOwddr9u
         iq0vcJtAAJ/oLYWvAbZU2qgu8h7/HoL5DBd4NZg7qfXFmT8gYIz1wI4gqiUn2E8yNjCX
         3m/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691054196; x=1691658996;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qjTxnd4KtTTOKG14S4/4BnF9x1FwZI+P+SQK+cy1Q0=;
        b=iuU3A917ZFr6osSkw/ZjporrhBWS9JTuyYRv7pjAsEI+r0C4Da2ri9TBxAZxWwzJMA
         8aLgo6FGFolsfE8uiJQKHFg+R+AyPyAACPfcbvRtSQfquuXw6bYPbF7krVd7rw8a7f0L
         eZn3MPpL07K24FkY+KaWfbk6lBqye+Vz01Gt/COKZkUFltBezPqk36OFAGFei2jBQjFq
         uoVp3Vk+1UtT5swBIUi2L0f5iJ13mOdv7qsCVMy5Y87YycMOXOmlyqvQjVpkI/VqkaEt
         SK379g6VJFsXBlKUt4+uz+jLBPU8JBgTUbZqFIx30YPBUp/IsG3+cNLKTDdxGGnAknd1
         7H3w==
X-Gm-Message-State: ABy/qLavZ3ETbR4PGb61uP0ENsXXkpoWteWZK/pOPN6xtqj7LVevAYY9
        /7jTjhuIwMelaC19YBa9V2yHOA==
X-Google-Smtp-Source: APBJJlEbMgvuYyt6jh+e+n6VqroGKijmgJQ7xQY+spS0oF/gn/I2gqCbv1hokho+dYSXUMUWKBIkAw==
X-Received: by 2002:a5d:69d1:0:b0:316:ff0e:8213 with SMTP id s17-20020a5d69d1000000b00316ff0e8213mr6661940wrw.15.1691054196274;
        Thu, 03 Aug 2023 02:16:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8656:583:d034:d966? ([2a01:e0a:982:cbb0:8656:583:d034:d966])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b003143c6e09ccsm21481602wru.16.2023.08.03.02.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:16:35 -0700 (PDT)
Message-ID: <27b8f21c-f705-ba65-5b2e-912fb97a85a9@linaro.org>
Date:   Thu, 3 Aug 2023 11:16:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <cover.1691049436.git.quic_gurus@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 03/08/2023 10:23, Guru Das Srinagesh wrote:
> When pushing patches to upstream, the `get_maintainer.pl` script is used to
> determine whom to send the patches to. Instead of having to manually process
> the output of the script, add a wrapper script to do that for you.
> 
> The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
> editing it in-place.

FYI the b4 prep command does this:
https://github.com/mricon/b4/blob/e8045d1353165cc065b2f1b180bf1b0846af510e/b4/ez.py#L2055

Perhaps it could be useful to make sure the output is similar ?

So far I've been very satisfied by the output of b4 auto_to_cc.

Thanks,
Neil

> 
> Thanks to Bjorn for being a sounding board to this idea and for his valuable
> suggestions.
> 
> Please try out this script with `--verbosity debug` for verifying that it's
> doing "the right thing". I've tested this with a patch series from various
> subsystems to ensure variety of maintainers and lists output and found it to be
> doing what it is supposed to do.
> 
> I referred to the following links during development of this script:
> - https://stackoverflow.com/questions/4427542/how-to-do-sed-like-text-replace-with-python
> - https://stackoverflow.com/questions/4146009/python-get-list-indexes-using-regular-expression
> - https://stackoverflow.com/questions/10507230/insert-line-at-middle-of-file-with-python
> 
> v1 -> v2:
> - Added set-union logic based on Pavan's comments [1] and Bjorn's early suggestion
> - Expanded audience and added more mailing lists to get more review comments and feedback
> 
> [1] https://lore.kernel.org/lkml/63764b84-3ebd-4081-836f-4863af196228@quicinc.com/
> 
> Guru Das Srinagesh (1):
>    scripts: Add add-maintainer.py
> 
>   scripts/add-maintainer.py | 113 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 113 insertions(+)
>   create mode 100755 scripts/add-maintainer.py
> 

