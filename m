Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8A182D2C
	for <lists+linux-pm@lfdr.de>; Thu, 12 Mar 2020 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCLKMm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Mar 2020 06:12:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43152 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLKMm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2020 06:12:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id u12so2833366pgb.10
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2020 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g2ic8RCgE8xfXSotQsLJPMX+SIIxXdgAWghsG0UmqWY=;
        b=G+UNAh6wj/c0SGz5GhPSr+VYq88055m5ZZtvU0lGNrZyPFoDBu4p2FqlJVbHL/0EUl
         6ARFETg2dQqDIZvvCsZcC4vZgzQ/u3QoEqcHtqMHvJUDVrmr3IDXqXgtNF8Jk2zJj0Bo
         SkAT9oTLszdsWdZwcJ1HgX6P1ICWSXNQdtu/iGNnBZyYFIPlEeqB33DuXHZ9T1e6nCNm
         qsdslFvy+BKwlPpw7fWakLpmb321bPsUvyvoOvrkrCz7G/hpLnLamMC3W3UN4XnrgEoL
         SJ/l+N9kwwd6BEVVF+n3HteQBjQY1arEZRxvnFSreA83IHR9Q9hU6IEvl6EZDs+yDaji
         uUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2ic8RCgE8xfXSotQsLJPMX+SIIxXdgAWghsG0UmqWY=;
        b=eP+vnUyMjNm4rXE14mHYnqfDeBzZRSdF72l1riWOxEAyhw5vV535NttIEMYCh4Qkri
         RumiZz4rdx7yXA+F42AqvlOrwe/EKXTnmG9dAP1KkEM8b+E1kqFLnB1I9NpmAqoaA9rT
         K0YbIYuzMBEb3WDqvkkiA8uAF6XkTeot0NXaPAZHuzfKHw8hwO/ejrKJEpwDZvlokYuU
         DC3uPi5pmXQemvJa07udq8e/Vo9IJts6He3fRprnPmMip00X9PdhGAQsO00dAWe+85KQ
         T60HmbKUqPYAt297OVTxhqPegn8+G1BBFHoCx7lwLvraMihLFNr0+ZAZ7bTldw/WsxDh
         E1UA==
X-Gm-Message-State: ANhLgQ0km+exOWMjOUdFgLv23BAIcGrE+it/E7m8SubFaz7eGdY/pvHL
        etM6ZwlYEzDo7Q/NQjMuge4t/g==
X-Google-Smtp-Source: ADFU+vsNpY0Hm54zBz9SHVmV3vmk513jLZGv0nsBMg1SxW2mhGr4zvQGzyTXRNQMCzGHjdW03YDzuA==
X-Received: by 2002:a63:b216:: with SMTP id x22mr6869446pge.198.1584007960467;
        Thu, 12 Mar 2020 03:12:40 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id k5sm8173410pju.29.2020.03.12.03.12.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 03:12:39 -0700 (PDT)
Date:   Thu, 12 Mar 2020 15:42:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom: Add support for krait based socs
Message-ID: <20200312101232.fmjs3zjl3gud5myh@vireshk-i7>
References: <20200219205546.6800-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219205546.6800-1-ansuelsmth@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-02-20, 21:55, Ansuel Smith wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> 
> The required OPP related data is determined based on
> the efuse value. This is similar to the existing code for
> kryo cores. So adding support for krait cores here.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       |   3 +-
>  drivers/cpufreq/Kconfig.arm                   |   2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c          |   5 +
>  drivers/cpufreq/qcom-cpufreq-nvmem.c          | 181 ++++++++++++++++--
>  4 files changed, 173 insertions(+), 18 deletions(-)

Can someone from Qcom team review this ?

-- 
viresh
