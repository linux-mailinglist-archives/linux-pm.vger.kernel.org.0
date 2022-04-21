Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B727750A3A2
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 17:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389875AbiDUPH6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389867AbiDUPH4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 11:07:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EBC193D5
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 08:05:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso6070684wme.5
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=E15M9Ws9rPTsezqPUu5FPX35Ipux/TcBsX6BpW7X7Mc=;
        b=AITr5RnwDxY5IpwPra9w2ksKNUuSqTH7IVfpHD8VTH5aL8oRt0tlPRC795QKxcXho3
         V48Ael5YBf8nTu1aM5DmbsbaErIHF1Lr5hU/0xREThm2sTjVsUU3d+eyRZM+dGyQoLTA
         enZLQStav9Xck7aYA0FWtfA1thm+CiQosv5sUFs94xqHUhcEKt+Fa3kFzXK7dK+TrGhj
         uQsRTqi50G5R6nycUOXBt2Td94u0HY9znZLbl4JeUO7MMXxdVxmILh3ezdVP+BMGio+A
         hY7Cke1BuzrJtGi5QvE1SM+PjB4/afX1pf9LnxB2euCwEyu2Z5KGjCgfWTRFUp9KT7qD
         9amA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=E15M9Ws9rPTsezqPUu5FPX35Ipux/TcBsX6BpW7X7Mc=;
        b=3NnjOX2SU8SqMAEn4Qhnbg3zAnR5WgkxWE6TvJIVSMPHvN+o4w/IO8n1HtXeTkeI3a
         OSeatYpgi0lAsVq+R15SRhszYvdLvMIfcCswvmxyo1eohsaMeYM1miPn5fNovh8X35kp
         T9aricWqENOSa3fv/FGBERPjiz/DNU/3ZE6SgTBrz8jmmZ0YUUTWOguFLso8OB65LUou
         6J0ruzP+jILlrWxKbPPAUQeaJEuuHFaStgkFBDl/sHCzMwQZNo00/UqaaWAyFCcHJKwQ
         Xl0mG9ccGvNBPBxLpRwnMtIMpNLxBQld1PkpxpPFMyhVvfNC9tslVDS7peTglgXP7KMp
         uZrw==
X-Gm-Message-State: AOAM531M4hhjK6VdoTqt6O1rI/dNf5MTZeiAjAusohwyarn4/YlJqkjd
        9MC/3OSPGfKGds/L/AlGwqdCbw==
X-Google-Smtp-Source: ABdhPJwTQ+9A9qQhbowMT6ITAZESTr+JAZ57+aJU0Gok1/P01kUj2CpfBFcvhWOpWAV3HNG+gO3qaw==
X-Received: by 2002:a05:600c:19c9:b0:391:d98d:2cf3 with SMTP id u9-20020a05600c19c900b00391d98d2cf3mr9137192wmq.136.1650553504458;
        Thu, 21 Apr 2022 08:05:04 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id a4-20020a056000188400b0020a9ec6e8e3sm2875350wri.55.2022.04.21.08.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 08:05:03 -0700 (PDT)
Message-ID: <e10b3f13-75b6-c19b-9a27-d75e2e80054a@linaro.org>
Date:   Thu, 21 Apr 2022 17:05:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/4] tools/thermal: thermal library and tools
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220420160933.347088-1-daniel.lezcano@linaro.org>
 <8610206dac7bf538eaf8fa81569741a91e4b8dc7.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8610206dac7bf538eaf8fa81569741a91e4b8dc7.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/04/2022 05:59, srinivas pandruvada wrote:
> On Wed, 2022-04-20 at 18:09 +0200, Daniel Lezcano wrote:

[ ... ]

> But I still see these errors in applying patches:
> 
> Applying: tools/lib/thermal: Add a thermal library
> Applying: tools/thermal: Add util library
> Applying: tools/thermal: Add a temperature capture tool
> .git/rebase-apply/patch:809: space before tab in indent.
> 	      	polling = 100; }
> .git/rebase-apply/patch:90: new blank line at EOF.
> +
> .git/rebase-apply/patch:221: new blank line at EOF.
> +
> warning: 3 lines add whitespace errors.
> Applying: tools/thermal: Add thermal daemon skeleton
> .git/rebase-apply/patch:86: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

Ok, I'll apply it with --whitespace=fix

I did a try and it fixes the trailing whitespace

Is ok for you Rafael ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
