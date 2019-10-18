Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2321DBC99
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504358AbfJRFHQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:07:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44029 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504332AbfJRFHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 01:07:16 -0400
Received: by mail-pl1-f194.google.com with SMTP id f21so2247821plj.10
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 22:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BN38U1tWSQycIwUtKvgVS41nw2Y5xmAR6qADXcgIN/E=;
        b=Or1S1NJBS21mZ3T0kRuw3+pg9/9vA19tlOBKzPCu+VJOzUGorap9nhyIFOs7X2qgrg
         zvJDJQwIS1BW+6v7Hpb7lsxv4M+N1QE5YfJhC/1Fj5/SMhEmHI+miSmHuYfJPzUy6eFa
         GC0iDI+pBneF36jZra4sKjv7DLrI/2YleI/qLkqhHXu5iCL7IzKssn9od150fmLSzfsz
         LCOOYySKfikf3B2ZqQcd/I/6X7u97Zel3TIjOM8ZSAJdp2jpXC24fyV1GimkEn+jQcpD
         jBnPpOKMTIiYCrVbDyuUNr2v1+bDc60g12qFOhDG8ORiKRo/fqfAbqCIaTrPDAbvhTUO
         GGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BN38U1tWSQycIwUtKvgVS41nw2Y5xmAR6qADXcgIN/E=;
        b=AF6X1V2Z2vMXrLehtaQKpxoImA2eQf8bJVWNQ/qyyEt1jkXCP+j5vnFOPY+musbCib
         Xr/PsJf5IWz6EoawD4BnTu92JD2n6ucZiQJTSZLGGhRON0ticy37IK0Sl7WyMBt3pAT+
         MS5aWomqNmRT0desJIkCqfoPqNze6T8d9gZLiIxTgYTUxI7fBQFidnqkaGtuZJ4gHGwP
         SdM8v0dS/DQupR9GqT84ASZLQKCK6vY854YxU9GuPHbl+SXafUvNZzQ+dS5tbRUT8YlI
         zoCa9LLwFx0pVokrN5v34/J26XyNk1Qgs6HdbOytaSekqa77k4mSx0jydDybtKGG/G6o
         /ZNA==
X-Gm-Message-State: APjAAAU6WMU4yVLqB71MiYhg2PIzdnA+Wx59BGrPUOJ1Pprs/8W9kyOv
        1s9UloukGX3RdRgLXLSbdeNJ4A==
X-Google-Smtp-Source: APXvYqzkRC1EwPpxmXJHKXXdNdXNMqjA0MEl0CEAzz/4I6yX9UtNA1XEwdpB6tAX43Fk+9Ejz7Ry3Q==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr7882591plz.182.1571375235738;
        Thu, 17 Oct 2019 22:07:15 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 74sm4821485pfy.78.2019.10.17.22.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 22:07:14 -0700 (PDT)
Date:   Fri, 18 Oct 2019 10:37:12 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] cpufreq: powernv: fix stack bloat and NR_CPUS
 limitation
Message-ID: <20191018050712.qr2axffmbms5h4xb@vireshk-i7>
References: <20191018045539.3765565-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018045539.3765565-1-jhubbard@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-10-19, 21:55, John Hubbard wrote:
> The following build warning occurred on powerpc 64-bit builds:
> 
> drivers/cpufreq/powernv-cpufreq.c: In function 'init_chip_info':
> drivers/cpufreq/powernv-cpufreq.c:1070:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This is due to putting 1024 bytes on the stack:
> 
>     unsigned int chip[256];
> 
> ...and while looking at this, it also has a bug: it fails with a stack
> overrun, if CONFIG_NR_CPUS > 256.
> 
> Fix both problems by dynamically allocating based on CONFIG_NR_CPUS.
> 
> Fixes: 053819e0bf840 ("cpufreq: powernv: Handle throttling due to Pmax capping at chip level")
> Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> Changes since v1: includes Viresh's review commit fixes.
> 
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
