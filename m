Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6745566357
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jul 2022 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiGEGoW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jul 2022 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGEGoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jul 2022 02:44:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761365F50
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 23:44:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r14so10280135wrg.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 23:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1xyjL8uVi4oUWM4NxyVLfSq7f5Oq55Jjs2ZuqXwoovg=;
        b=HHtqiYfa34sLF/w4kuG7IpCfJKs5H8S2BQi0DB/toNXW5ZjTeF9pN6cQib8Qbrfg2J
         CXJ0KSOaYpmWgCEaAgaZSfiBWzGWqcY0dms8clqD9gb7HnPNokAFJYBrK/kso0rXQGnn
         0uLuX3Fib2sxm3g9QshwNh60IsSyg2KrP0Fi5PNOEDstPQqF+PEx+8OqysT4lgqtijQ7
         1FDpmcWCStE1PGBeINfP0u7oSHgmRbElXeW6SYCuZMRifBqRsg/Fv1DWe9EQ+ouZFPcW
         jbkRYAmk2WAh4vAzdzD6jEsBwh5w2FzTdpMVpwiLX1iq6nT7Pr3v1VPHAGWhS0p6X+k+
         Gi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1xyjL8uVi4oUWM4NxyVLfSq7f5Oq55Jjs2ZuqXwoovg=;
        b=wogKO43F6pRymL/eLq2LMzByLjOlnyKfIqMNBkLq30gurYS3WWExL5+sSrHpZBS2Lh
         OUxavgiw6Qa1jevwYVrkbVr2Ar6/VHhEiJsAhIfiauskskkrreaQZZWS4uN7Hq43yhFf
         JcvoO7ksoEclUWo9cRhL8R+jAngdQU7rp/Y1XWRVb8Bn8GSOkDJ1EGTL41RJzrCnTXbs
         rKosR484mDnJWiw25fdzbK+TMmncSQ06jkjaKVhm6sAIFdK0AEawH0gfV9mZSxC4YRzg
         YR/3ChTvpUcn1hWKiY9EmADQIYbSnNoqR95MTPspqurN40x1zDiPxCkevCc35/XVrefl
         XWIg==
X-Gm-Message-State: AJIora/X9JbENIVcfn0EBjcDmpOIiLZo+pFxszP9fKQB/E4kqt1y4yC7
        VVi5upqLJ7Ymb0F7IRMEVhyfNgrOWdTUuw==
X-Google-Smtp-Source: AGRyM1vybu38jG39FWVZVthCnVWGJGdI1MdMyHsvjn1rrZ5exauM4Covm67WvgWzhaFm/M0VKmbbqg==
X-Received: by 2002:adf:f48e:0:b0:21d:6562:4717 with SMTP id l14-20020adff48e000000b0021d65624717mr11438288wro.428.1657003456933;
        Mon, 04 Jul 2022 23:44:16 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm31416242wrr.101.2022.07.04.23.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 23:44:16 -0700 (PDT)
Message-ID: <af7463e7-4ec3-8a26-fbc1-aa73bda2e434@linaro.org>
Date:   Tue, 5 Jul 2022 08:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 11/12] thermal/of: Use thermal trips stored in the
 thermal zone
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linexp.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-12-daniel.lezcano@linexp.org>
 <6c7e1865e7e68ac0f035680044eb878ced715a1b.camel@intel.com>
 <f16d855b-28b0-b4ee-0e42-7293d0e61c21@linexp.org>
 <0c525d16f34bedd1ea4ee4b7516c9dee5a92d419.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <0c525d16f34bedd1ea4ee4b7516c9dee5a92d419.camel@intel.com>
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

On 05/07/2022 03:20, Zhang Rui wrote:

[ ... ]

>> There is no difference between those functions. There are 34 more
>> patches in the pipe to be sent after this series to do more cleanups
>> and
>> remove code duplication.
>>
> Good to know.
> 
> It would be nice to have a cover letter to describe the whole picture,
> including this patch series and the following patches in your queue.

https://lore.kernel.org/lkml/20220703183059.4133659-4-daniel.lezcano@linexp.org/T/

You will Cc'ed next time ;)


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
