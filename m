Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B68C362378
	for <lists+linux-pm@lfdr.de>; Fri, 16 Apr 2021 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbhDPPFD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Apr 2021 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245350AbhDPPFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Apr 2021 11:05:03 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6BEC061756
        for <linux-pm@vger.kernel.org>; Fri, 16 Apr 2021 08:04:38 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id h2-20020a4ad7420000b02901e5901169a5so5975369oot.8
        for <linux-pm@vger.kernel.org>; Fri, 16 Apr 2021 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUh+u+nqEBI0lfqypy6G8Hh4WRA6wxa0dr6fuVWGoKc=;
        b=dZ+uBO3JsAvR2lPkYnItHlaJ/WSfi+0CwWrJBqPgvbE85qZHRNrqCObqdtF9yKoD2l
         W54MAskpev0Tu3aHH/QhZBfEzeeyKXBgIayjtoE3dlmFrKsuAOjcnfPy5jYcjJkWG6PU
         d8gkTh+/n1BJyop8JGu6baX/7NpXcMykd0CU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUh+u+nqEBI0lfqypy6G8Hh4WRA6wxa0dr6fuVWGoKc=;
        b=oFAbrH7rBsEBFA67hf+n2i1I263eyrGQ6yHisOAR2TGWDruQQm4yS5sWtHWnb0YGHm
         +U3WsNA8NPOncC7pb7vTq9Mqmawvyx2PgegvW3WC05tOzOhIIlqkllxmS5MlSqP6VMoz
         oQzO29OrTe7VIGbDG44MiiYAwdZyOM/ZQfquZycZFLhheRDUma9G4glMdo6cDu7AHNBu
         TUUv0oGIkxxgW9QmaQAj6Kx//VxLQzzuIGA6CmKpoyzJ73F2WzuIv2JEcgxIQ2D6VReV
         EHylEMc9QZOrcChmDc3CPPTlPq9cZuCC3/iwrPmPHB6yHCvnRFzXsXmA0BR3GS8k4wKZ
         uu6A==
X-Gm-Message-State: AOAM531GdAhg+gZnKycdeyJvOMlKHJUVHcq6Vdl+3l9IPXZmqaefs6U/
        CfEqzfpFNt62xbTaY+80MD89NQ==
X-Google-Smtp-Source: ABdhPJwTgqyZ6JRliUbHITUp1ndVQDavg+k9vUlNdu4nZtMR2dinX5s9br90F6gsFA/FokJYsjoeLA==
X-Received: by 2002:a05:6820:34b:: with SMTP id m11mr3665780ooe.49.1618585477468;
        Fri, 16 Apr 2021 08:04:37 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w84sm1456945oig.20.2021.04.16.08.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 08:04:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] cpupower: fix amd cpu (family >= 0x17) active
 state issue
To:     =?UTF-8?B?5b6Q56aP5rW3?= <xufuhai1992@gmail.com>
Cc:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org,
        xufuhai <xufuhai@kuaishou.com>, lishujin@kuaishou.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <20210324082838.41462-2-xufuhai1992@gmail.com> <1717786.6COvnHc5Zm@c100>
 <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
 <6de2b9d1-435d-99a2-c733-4f49483f8f57@gmail.com>
 <79f26f6b-f9f8-36ac-6f43-6329935ba9e4@gmail.com>
 <8e5195be-1ab7-60b7-d7c8-ed1cbc9ad986@linuxfoundation.org>
 <CAOkq_BcdvS1NtKJ9=peRWHc00kGjfvdE+Cyz7vqvH0+kermfhQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <b86e0fde-ad5c-5378-234a-7191179741c8@linuxfoundation.org>
Date:   Fri, 16 Apr 2021 09:04:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAOkq_BcdvS1NtKJ9=peRWHc00kGjfvdE+Cyz7vqvH0+kermfhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 4/15/21 9:45 PM, 徐福海 wrote:
> hi Shuah,
> Thanks for applying my patch.
> and another whether needing to email a new patch such as v3 to you for 
> merging into mainline？or v2 patch has been ok?

I didn't apply your patch. I don't have it in my Inbox as I mentioned
in my email yesterday.

Please run get_maintainers.pl - refer to the following for information
on how to submit patches:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

thanks,
-- Shuah
