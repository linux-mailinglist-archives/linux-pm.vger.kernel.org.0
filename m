Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6435A2574C0
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHaHyb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 03:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHy2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 03:54:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCDC061573;
        Mon, 31 Aug 2020 00:54:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so5570718ljc.3;
        Mon, 31 Aug 2020 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ySzm6C/N6GusO8+WhnjxU91a+LGFeV0ennCZHd0ftc=;
        b=MEdOC3oE13B00ncD1A6e6iOxKon2hzwKox6osA0eizVeUIreNnL8oos+aiT/XyJqKk
         hltR48w4oCofK42giql4vItyWqwFd8FuOjCPnHnhMbYAN2hbVTMXAmANej0HnVkcA7rq
         xJXwSXnPtIzhRhmWznurRyJs9m0NDozyp46DYhsvmkuiDg1ZugsDAr+fKOsp1YPC6AhK
         S0tQBl12Joo7m3hL9meJoFTDXyUdHVb4Rl+h+/D/4q7CCqJk/zR9EKAzlZJaEQMJtLR3
         Wg0C9djknj4KMQHagDYOdiTcRuUHz/IkaAjdctGvgglq3TxjNnSmIyuMrox5scjWE1Nw
         qBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ySzm6C/N6GusO8+WhnjxU91a+LGFeV0ennCZHd0ftc=;
        b=lCJDsVZl0vkAD38DW2FcTbLVnS6C68esi0bcukzGpNORChRHa27BJfZQ9qXUsx9fOj
         +nMl6rXDEalHchSc9yfxzRJfWgG+0eooL3sF7/q+ifsz3DnAGmO4qgGpZ/2b/5gWR+wZ
         Fzfzvjr6m+WlHt03d8tC4fy1nFjouePiBd1uTbsaed7gxVTQzXBFp3uqdECDy0v/ZOTE
         GOFnTmGTY/ayIV3s22gxfcwqi3bkDeBWT35gKNz95ecwZsoQU0ojzt2bzn+aUlNIv3ZH
         Gj7yhEvRde62RpMW7J/OSdkDYUIDBso3S/SGKEKgESqodWBTf8okJ/Yi2dBybUnyl3Xr
         AcOQ==
X-Gm-Message-State: AOAM531vzIuwaEEA7hwJuwyjpAF/xnGS30KJrqF+6raLUP+ArC17cA55
        FjpvgsbzzD0xLfYhTKSPNQu03HarsvQ=
X-Google-Smtp-Source: ABdhPJyfAmv+rH3T+J72qv5jTB//Lv7QImhS4MJT95CpUpBllj6cC+IS0RzeX3pMInMMiuJqUVsJ2w==
X-Received: by 2002:a2e:a28b:: with SMTP id k11mr63428lja.405.1598860466583;
        Mon, 31 Aug 2020 00:54:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t25sm1805516lfq.7.2020.08.31.00.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 00:54:25 -0700 (PDT)
Subject: Re: [PATCH 3/3] ARM: tegra: Pass multiple versions in
 opp-supported-hw property
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1598442485.git.viresh.kumar@linaro.org>
 <b13f1b112532fe0189d1f7bbb50903d9e1defb07.1598442485.git.viresh.kumar@linaro.org>
 <b0763074-859f-fccb-dde4-03d1a50ea021@gmail.com>
 <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0da380c2-9161-d450-afd2-4b159c8cfb7d@gmail.com>
Date:   Mon, 31 Aug 2020 10:54:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831043908.mtw4dglybcmcabjb@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.08.2020 07:39, Viresh Kumar пишет:
...
>>> Dmitry, I think there is further scope of simplifying stuff here by
>>> using the opp-microvolt-<name> property and corresponding
>>> dev_pm_opp_set_prop_name() call.
> 
> Any inputs on this Dmitry ?

Could you please give an example?
