Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054AC6B58B
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 06:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbfGQE1B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jul 2019 00:27:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46670 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQE1A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2019 00:27:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so11218081plz.13
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 21:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WCoUs4Hb3/orTt0/DRrzcBNTaD0Ae5/zpkSi1tZIxVE=;
        b=IiereG+0BCAa0XdwaQHy24zNuCtVxyNA8YYg1B/rOL7rToEYoFyLQ6dmh7K8T5iP65
         KM2xMoG+2xMnWcf9Pjz19BorYKLoMK3P3X7Mudx5mDh1p2XVN0WvSl2r9sjpF2jMox6e
         iSCKvrYrDQ1hxiYdXRJwOg7j883Kq0s2OwoT0QbBOL0j+lMEHlPqV6R3BebAqoPQy+Ch
         MJdr5XaxXbNwzpX0AfyWf8OCAS2qK+kyrVZHdEMu9QJV0MXwfB6BIJ4VGA/04sGGt7Cf
         1NNXOmO12/XdJoYR7mIFBlDVaqN8oAZ7wKwOdQ5qHijwffZYkLpJ+ysqq54Bft2WMwfQ
         9OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCoUs4Hb3/orTt0/DRrzcBNTaD0Ae5/zpkSi1tZIxVE=;
        b=Td7gF8NQf9dtaJEavpcKMVx/T1nyx6DtjWmbJP/K31K8eKG6IMYe48FIodY9OywC8n
         fNQDfYa4T4SiyldDmFeSuO+EYg2YORy+TBTWrzpYblaM2N77roY6NvyIyJdae+X+KbVH
         kIOqSDL+zOlepOYMyfURhEHhYjBEGp4xCCg5gcgMXm7l7LuPY6g0Dq9Fbks8xS2F/OkA
         mW41dF2WQC7V/0DsJ5XMPS9cgakHzBlaJspTtykw+NMf6tGntruQa7OHr7KRm48E0+cp
         RnTYMuQaFqSl5Q7UbpAJ7LeqVOsj414gISVU0bVi+Iz8q0ZHkRRNNp/ALJDWjWazXR8/
         S1Jw==
X-Gm-Message-State: APjAAAV1EmOOEzTa7jmRaz6vi87BFEzRZPNwWmjh41RPQE/VWNXoqjQ8
        6V4cXXjhFu52PPPcsY9P7ca54Q==
X-Google-Smtp-Source: APXvYqzn00yoFOY6V0VVSZoXn809wajh7dZLsAzML9/Buf6OjvFE8aIcmdRSdethJ0XKQGYosUCTQg==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr9764548plb.28.1563337620108;
        Tue, 16 Jul 2019 21:27:00 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c26sm21187405pfr.172.2019.07.16.21.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 21:26:58 -0700 (PDT)
Date:   Wed, 17 Jul 2019 09:56:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190717042655.jmiblv5mhg55s7la@vireshk-i7>
References: <1563335704-25562-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563335704-25562-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-07-19, 11:55, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f6 ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v7: adapt to commit ("cpufreq: Make cpufreq_generic_init() return void")
> v6: keep the blank line and fix warning: label 'out_unmap_sdcpwr' defined but not used.
> v5: put together the code to get, use, and release cpu device_node.
> v4: restore the blank line.
> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
