Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58DD19782C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgC3J64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 05:58:56 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51271 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgC3J64 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2020 05:58:56 -0400
Received: by mail-pj1-f66.google.com with SMTP id w9so7345114pjh.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2020 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DmLiFkHsrWw2W5ZST6R5SB9z1KVD8jOd9o3JzW6oIFE=;
        b=RfpjGEAPHLupfgmWfSQ0PuZKGf0nWWJdmQO8TLKYdatCIZWUWsMbicPfiCWdhjzmtt
         tkG9oSExzxFJsrh94ePID+mtrKKw+Dp/sYMbu2FBt96Glike/oRu2svpLZlZRwf02s9W
         SMehH13DY6bOrwQUYrPdK7azSjLe1PbbZqIM7fMYdU0tfRz9xg0OuPpL7vJXpZnIVu9v
         vnq2M7JoOwHlB6ruSaG46Kx1jjEGoP6eZDOi322WHfO1CNzUB1aHwCJe6AP9eVphI5F1
         ASilehCzBCUH1I3oO4vBsZ//qB1mW3OA4ANGtxCSM/Rht6mLDFIz3UB016yW67EUJ6m2
         wAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmLiFkHsrWw2W5ZST6R5SB9z1KVD8jOd9o3JzW6oIFE=;
        b=LXRa986SxFhwqgm8A4+6Sk4o9oH/ntGORPpMgY25vx40GK/HeJmskWDK9vC2tCihym
         u6amf8LCB/h44E0WWaUMBn8gx70a9ONigQ94DHFnurXurQAkwwrc1AY2ZRW0S4xRS+8J
         sAx7JfPf7YP+fZb9Emk8UR/fEX2SiYwgLsFCnJitFSf+9YauoAMrtJR3TDubz3vYI1ci
         Ge8S13KQ4M7pnt3TSt0o/7DlUB820vn3cB3N0stZKE+uKt4gz3m1ZRFyQdt6L6MKw79S
         fL6tUFL8H2Asp6R+q/vfT49R1TTtuE12bD3VEEFxQIpyslKAWzem51cPJAYYnoP99aVS
         dHOA==
X-Gm-Message-State: AGi0PubfvqJk4slQgGrRoob3adelHpcaBLtJA8StIexFJNUnq+n1HuOk
        MDnYWZe98N809hjnUf7q8l+z4w==
X-Google-Smtp-Source: APiQypLnKZ3xN9AFDHzHFAAPbbpb9oinpHGq2sYaHpvUcthVDaY7ujqFyrSQVJ37Az6cWG5GYnkfzg==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr2894873pls.324.1585562335553;
        Mon, 30 Mar 2020 02:58:55 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id r9sm5074256pfg.2.2020.03.30.02.58.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 02:58:54 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:28:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, robh@kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] thermal/drivers/cpuidle_cooling: Change the
 registration function
Message-ID: <20200330095852.rn2kxxenykm74664@vireshk-i7>
References: <20200329220324.8785-1-daniel.lezcano@linaro.org>
 <20200329220324.8785-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329220324.8785-3-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-03-20, 00:03, Daniel Lezcano wrote:
> Today, there is no user for the cpuidle cooling device. The targetted
> platform is ARM and ARM64.
> 
> The cpuidle and the cpufreq cooling device are based on the device tree.
> 
> As the cpuidle cooling device can have its own configuration depending
> on the platform and the available idle states. The DT node description
> will give the optional properties to set the cooling device up.
> 
> Do no longer rely on the CPU node which is prone to error and will
> lead to a confusion in the DT because the cpufreq cooling device is
> also using it. Let initialize the cpuidle cooling device with the DT
> binding.
> 
> This was tested on:
>  - hikey960
>  - hikey6220
>  - rock960
>  - db845c
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/cpuidle_cooling.c | 58 +++++++++++++++++++++++++------
>  include/linux/cpu_cooling.h       |  7 ----
>  2 files changed, 47 insertions(+), 18 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
