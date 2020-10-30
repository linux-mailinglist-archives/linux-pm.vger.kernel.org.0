Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97E2A0C41
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 18:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgJ3RNt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgJ3RNs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2020 13:13:48 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EB6C0613CF
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 10:13:48 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u62so8257101iod.8
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2020 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=szMBELtKzxhB5vLQY6nxOOzk0TwbzjSvsZ1JzLhDTHA=;
        b=JpyR7lxktxfr3/YD/6xwXxm05y5jNPrsXLiJegDHwonoSCqIAk2lEuNHqIbvcdtDsO
         BgdxMYv2cd++kiv+rCWkSjtRxn/nqTUI21yQ5PtEf0uQ9IPaj2eOHTDqOjattOXdrmlx
         IG2NbG4Gf41pP6W724rMLpZ0KN1/0UhZG0ixQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szMBELtKzxhB5vLQY6nxOOzk0TwbzjSvsZ1JzLhDTHA=;
        b=HatoBzAfxP2aE/W7gw1NKjSQ3IPDaVZJRWKPrSxTKqSG1BBR6vN3bb+y0biXbL12DM
         6yInZpDKr6IR5dhkTC3JE9UMqvC5fRUDRWu5HFvWwXpHYR0S62DEQABFTBgU6Row3iuL
         T9gYhQVoNcd+e6wsDDTPNpP5EsS6TYLoE2PNJa05dmBUfiL+c0LJcDlfsLN18pm1a7Pf
         9prLd53e6Tk9BfNAogEN1Jjrs7QD1qH9SlVO0q/Bm6AAiSYUa8MZbVPB01klHvz3pFXX
         1QCTVJOuvI1QRyJ3d2iUaCommwaWxTHk9Rhfkf6CZo7atF97W5d3yKPUkYV+DudJKZw0
         13EA==
X-Gm-Message-State: AOAM532LLaYzNJMsj3b29SORUGQKcC2vfXhSGYegrgw3KhBDgfCBY1S/
        4gYbeXwzybpdwbMqUY1Nb7KcxQ==
X-Google-Smtp-Source: ABdhPJwR/vg8mQM9eAwkk849NXVDcx1hD8BS8XYHU3zHgKwqHAGUB6c+au2wXZij9PQCOQKCd9v2Gg==
X-Received: by 2002:a6b:3c10:: with SMTP id k16mr2671008iob.209.1604078028191;
        Fri, 30 Oct 2020 10:13:48 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k8sm5259666ilh.8.2020.10.30.10.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 10:13:47 -0700 (PDT)
Subject: Re: [PATCH v1 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201029190259.3476-1-bp@alien8.de>
 <20201029190259.3476-2-bp@alien8.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d6da5f48-5f50-a201-1f6c-5084466f81ee@linuxfoundation.org>
Date:   Fri, 30 Oct 2020 11:13:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029190259.3476-2-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/29/20 1:02 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... instead of poking at the MSR. For that, move the accessor functions
> to misc.c and add a sysfs-writing function too.
> 
> There should be no functional changes resulting from this.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>   tools/power/cpupower/lib/cpupower.c          | 23 +++++++++-
>   tools/power/cpupower/lib/cpupower_intern.h   |  5 ++
>   tools/power/cpupower/utils/cpupower-info.c   |  2 +-
>   tools/power/cpupower/utils/cpupower-set.c    |  2 +-
>   tools/power/cpupower/utils/helpers/helpers.h |  8 ++--
>   tools/power/cpupower/utils/helpers/misc.c    | 48 ++++++++++++++++++++
>   tools/power/cpupower/utils/helpers/msr.c     | 28 ------------
>   7 files changed, 81 insertions(+), 35 deletions(-)
> 

Thanks. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
