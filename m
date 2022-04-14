Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76F500350
	for <lists+linux-pm@lfdr.de>; Thu, 14 Apr 2022 02:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbiDNBCF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 21:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiDNBCE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 21:02:04 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B635859
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 17:59:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id b16so3838167ioz.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zgsbBJZkETT0T4G/ueHuTUOQ6+Pb56JNHVRc8ZA6wiM=;
        b=h6aCTyM6FGlhXQAJtWqJNW6VuJC9v8fnE/94b/W0u7BOpJ8xSgcPjb+fuQbJV+H8P5
         MT85ReN9aTHg+Tan++dYOGLjSIrwYqRhkQJmiRPVnAdjzP33iMqQ6KpRPzHioaBeNcmB
         01QX2PYvCsZ1RzbLi6XMlaCemVqFXN4vcGhRJ1+5zznv0I83UG8yYPmNxn8z+GSzCwdk
         zKaWtf4dq9jSZiY117kwXuZpzf5u7nPWDg11sDx9jtpZyD5fUxikL5f76oJP3uURVurU
         GPcSQdwFsKmc+awmlSADWgW9DYd/szfOzAtV780aCu31YjPdQQ3FRUoMm2l0upAHzFxy
         ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zgsbBJZkETT0T4G/ueHuTUOQ6+Pb56JNHVRc8ZA6wiM=;
        b=NWlxxjOE0fXH473txzVOOyrN11KTPNtFltM/7HsTbs68eEpfNJP07CfvzbkXujChN4
         h64IRCYQxpNCD3uSICPqwnkbNgcjcgxCgyOOJVFisRtC8VrWwlU4knE5fYuLz06RFIUp
         8+9kcRkwcRyfpQh840k6kgxUKOGQcCStEWw6c3bZdsKcHJKgcjEHu4KQc5v4UtPA2wrP
         sJWlvOUY1aJQ6CZOEtdJ5pd811AyX6zZtXlTi72OZjoBYjLgKdWbF39IYTC4dwcr24+H
         pe+sIjFOAT1eIwvmUw9I9cfl+RFqZVkHEyZYsCOGqaa1dEdG0PqTqLZCVP/kKpPAvozi
         M6Lw==
X-Gm-Message-State: AOAM532E8M0AhkUXua/J21JOZHZaAozJFjnxwXsRqhHG13yijHtwGCZT
        jvqrbpHIiuY7xcAp4FfGvii/gw==
X-Google-Smtp-Source: ABdhPJyWahwxvucjjkEGSAhpTl3vClrpDhozag1zQo9Of9HtltZCGt9GdEiRwIkIBr2xIVICUJu/bQ==
X-Received: by 2002:a05:6602:1409:b0:5e7:487:133c with SMTP id t9-20020a056602140900b005e70487133cmr159722iov.196.1649897979377;
        Wed, 13 Apr 2022 17:59:39 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id n12-20020a92dd0c000000b002cac22690b6sm284770ilm.0.2022.04.13.17.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 17:59:38 -0700 (PDT)
Message-ID: <a293481e-3454-74fd-7183-973a9b80acc0@linaro.org>
Date:   Wed, 13 Apr 2022 19:59:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] interconnect: qcom: sc7180: Drop IP0 interconnects
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
References: <20220412220033.1273607-1-swboyd@chromium.org>
 <20220412220033.1273607-2-swboyd@chromium.org>
 <CAD=FV=UFbOhs0ggxDbVwKM_8x=ELT85zFd-Wk6dJ_M+Awz+Pxw@mail.gmail.com>
 <d80ece40-fdd7-f304-3989-47ae152d5ac9@linaro.org>
 <CAE-0n53kebRHTogSkiAOcA4tMpA+EcXQHtNX0Zzut-xE2vCkpw@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <CAE-0n53kebRHTogSkiAOcA4tMpA+EcXQHtNX0Zzut-xE2vCkpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/13/22 6:14 PM, Stephen Boyd wrote:
>> Stephen, I think you should re-spin the series and add the
>> proper change to the binding.  You can keep the tags I gave
>> before.
> I will not combine the removal of the binding from this patch. This
> patch is good as is and fixes the problem while ignoring the DT binding
> and that larger discussion.

OK, and I concur it's better to make the change in the kernel only,
without changing the DTB.  It doesn't hurt to permit (define) those
other definitions in the binding, even if we agree to never use them.

					-Alex



