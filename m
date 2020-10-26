Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDEF2995B0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 19:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781154AbgJZStA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 14:49:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781130AbgJZSs7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 14:48:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id k18so13536163wmj.5
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2020 11:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTa3qzBfjfO3fupd3BnS4ZZoXR8ThRJTTlcwcEE0TEc=;
        b=YW50LAX+bb8u8ygC3Jx9FFIBJVTQ4y3hcs8Ug6IXC4X5DIMNM5pqiH5kuRRilM1Gvj
         bL7IO6croLQZ1IMy3QoXFOm4v948vnBe5WnDYE1qe+3LhyGVMHYoMCBBYDSJ5XLZ6Srm
         BAlxtsMJhNixpMf01ONSle7wd3zeP57g4JZlrX6pKjdCLcM8oW2tcpAzCr3WxgBdyLdt
         MScanx0uWFQ+aSdMtegIzi1SvNk5OiaHjSmrAtiizzhQy/B8MSYinf15bLyL4QzzePoS
         xmYmj9bMDGtBPHFIC9sHPVcpS0YlAZYwsSbDJYr5kwT0sVUECIw56ieG7I29q1ATTav5
         ulxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTa3qzBfjfO3fupd3BnS4ZZoXR8ThRJTTlcwcEE0TEc=;
        b=sVAa4DKeC+vET6Ie8+qFIkcueeOOPXo1SQ6wbdORZ+BdbME22WvjTK8myw6kF68zAX
         Ff6d8jUxtVdpj+yCHgarHE2wb6L9rpNtK3eGmA0cwQQioWuGjMEms7X+8mE2fGBxGbk5
         /QyhhjxAB4VzonrXH028i6H1HYqjpUAngMtT/kWUK+ksnLJ7WreBIJK215dzeb4CRP2Q
         XawbkukW9ZM0RuATZ5mJe6UjsL5N/aLsa23pk6ATDEtMpByv1gEMTtwFEkz4bl2AxKLN
         RWH2zPQglmaas8fqWyVkysg1rGRYnwK6FE4ZlWRfUjbsqqJMgc5FwVBAlp2q/9ZosnUk
         DkfA==
X-Gm-Message-State: AOAM531vkbtOIYMviHnJ+rLJgsErxp0O3ckOjwtlU3EIghJey6uf2D2S
        K56o/u1mqXbJkjqOOt6tR89FGw==
X-Google-Smtp-Source: ABdhPJzGA5pjDsLggSCcMVH9c0IEnEe7XZRCpc5Ul1C/Fu74L0JMBEZofYzEoWSPtR0z7J3PDwW2RQ==
X-Received: by 2002:a1c:7f97:: with SMTP id a145mr18185230wmd.160.1603738136430;
        Mon, 26 Oct 2020 11:48:56 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id q7sm23253863wrr.39.2020.10.26.11.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:48:55 -0700 (PDT)
Subject: Re: [Resend][PATCH] drivers/thermal: remove unnecessary structure
 members allocated_tzp
To:     Bernard <bernard@vivo.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <APAAJwCGDWnQvuJmRuA5r4pv.1.1603677021468.Hmail.bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0d4e0753-c565-3ba5-852a-32156a0ca067@linaro.org>
Date:   Mon, 26 Oct 2020 19:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <APAAJwCGDWnQvuJmRuA5r4pv.1.1603677021468.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26/10/2020 02:50, Bernard wrote:
> Struct power_allocator_params element allocated_tzp is only used
> in unbind to kfree the kzalloc space.
> Maybe we don’t have to need this member to mark, also, kfree will
> handle NULL point, there is no risk.
> This change is to make the code run a bit fast.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Applied, thanks

[ ... ]

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
