Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8AF2E1C4A
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 13:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLWMez (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgLWMey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 07:34:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F10C0613D3
        for <linux-pm@vger.kernel.org>; Wed, 23 Dec 2020 04:34:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id y17so18463730wrr.10
        for <linux-pm@vger.kernel.org>; Wed, 23 Dec 2020 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent:content-language;
        bh=46s9iCozNdwklFRP9JAUtjF3UizZ0VgnsLK944MzeQA=;
        b=AIfxhgWzlR35+vH7QotuaW/iEHUPQbqrwNJlpdrmYnTHhSA+E+Xizja8tXSv8yumNW
         FmWlJU+hiPjh7OheGEOFB7RZefUT6vwPfIz/FTfOU+MK1fHuXpdnO4ZySgiPI5iQtPeq
         yPVzcsLmKd1jfC+6ASw4V1Pe7SpqPBZIhfJQUXMgOzSCYQYNJ5fluRSmWD7GkmaeFfTv
         geVDzBZTnkjD7KA+MXEumxBNrmcQC8wI2OCbpRBR9aBXkJZ9X+Al6QGDMP32Ew1oTvQE
         wNFFrXtsDJMSrXVMWIloEPmFy53koesH7EuGG/fK+N0d+3FpBpgHX5cW90O+79vJxDvS
         y9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:content-language;
        bh=46s9iCozNdwklFRP9JAUtjF3UizZ0VgnsLK944MzeQA=;
        b=Fannzq0WSVEr890iMGLxZtJ5MK0XnQ/dX24F63A1iJRq4XCCLGp3eBWllI39pYfHt4
         TG4/qHYztVP1EfLlFHSC494Qd1i+FBGcpDPyyZxfZj1b+9fbd1jo8g8j4/8Duh/gKbWp
         oE9GHfxPWfpXqAqkVk+lqtOl97qOPuH5kogjJUQE2/PsCTcco9gucvEAnqFfBA7TIrK9
         0TGxTYOX/A5t609vLRlQhc4OBaG8H39iKocKj6Pahyvgq43SR6bIyFmmTPtMsE6tAL9A
         7vtqvao3C/+nHYIL+hKpvMnN9aCpdOVF3xt++4VYo2D5LC3/1YvX2ty4R8kMWdgJJ/+7
         WvAg==
X-Gm-Message-State: AOAM533FDuSzrrgex/0xZKv4R83B3fe3WOxWg6rCjzOq3mJ8VqA+pSfv
        hGvBIMCA36sAMULO2KZ4mwcVcw==
X-Google-Smtp-Source: ABdhPJwOkSM8Qc8pGGgU1U4SiH/0CnCXZ3kVzavCyqdHyvPoWRa06GmRQrbNHpV201JI6MGhft6XOA==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr30207013wrq.189.1608726852733;
        Wed, 23 Dec 2020 04:34:12 -0800 (PST)
Received: from linaro.org (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.gmail.com with ESMTPSA id j9sm35164716wrm.14.2020.12.23.04.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 04:34:12 -0800 (PST)
Date:   Wed, 23 Dec 2020 13:34:09 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH v5 0/4] powercap/dtpm: Add the DTPM framework
Message-ID: <784894c4-36d3-7eae-ac82-ca0ef68772a2@linaro.org>
References: <20201208164145.19493-1-daniel.lezcano@linaro.org>
 <ba9c6f75-3964-3ee9-c849-17db5ae51501@linaro.org>
 <CAJZ5v0infKumCmn77nzAN80G4bmF+_ZzgGkdaeMvczC_VyjyGg@mail.gmail.com>
 <CAJZ5v0hbeeVHPAhm01W4NKNBNQo1xS0Dqa6C2h=zoo4hCjGPew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hbeeVHPAhm01W4NKNBNQo1xS0Dqa6C2h=zoo4hCjGPew@mail.gmail.com>
X-Identity-Key: id8
X-Account-Key: account12
X-Enigmail-Draft-Status: N11100
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=4
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Language: en-US
X-TUID: ARMoOqCpfDUp
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22/12/2020 19:52, Rafael J. Wysocki wrote:
> On Fri, Dec 11, 2020 at 8:15 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Dec 11, 2020 at 11:41 AM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>>
>>>
>>> Hi Rafael,
>>>
>>> I believe I took into account all the comments, do you think it is
>>> possible to merge this series ?
>>
>> It should be, unless more changes are requested.
>>
>> I will be taking care of it next week and, if all goes well, it should
>> be possible to push it during the second half of the merge window.
> 
> Applied as 5.11-rc material now, sorry for the delay.

No problem, thank you for taking care of the series.

I did not want to add another entry in the MAINTAINER file as you are
the maintainer of the powercap framework and that is fine.

However the get_maintainer script (and default cccmd) does not return me
as part of the maintainer/author of the dtpm or idle_inject. I would
like to be at least Cc'ed to review the changes related to those files
to make sure they stay aligned with the direction we are taking.

Is it possible to be automatically Cc'ed for the proposed changes in these
files ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
