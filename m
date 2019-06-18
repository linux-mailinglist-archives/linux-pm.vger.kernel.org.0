Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFF49F42
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2019 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfFRLeF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Jun 2019 07:34:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35423 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLeF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2019 07:34:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so7557166pgl.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2019 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xZHZFfBGAguz2tt/aDclYAU0MMkB/zuIOCSv36kPYTM=;
        b=bNVvSbgfHNdbARu+Qps70R8iY9LClJKO2ADtLd+/YN5r3gA2/gsGz3cjvm9Eb8Iw6w
         zDaXp+DYV6wrFRc+vzVGteYaDYzHNqgF36MUVedEJcFlHmNtxJAe2yQLtMYJm0QV5bSw
         j2AMk0Sc7aMdkGTJtpi/hCag2hkiJ4G0lZFdh3mAeNIiJnLJ/KS8/xpu2vxaSp1sne+U
         MCI9hxvVegVHuCtOQvABHO34gWp0O7zZpj2Sp9YyK5I2GIVSt6Pu0U3v8LwbDr1fJKFJ
         w3bgFUB3Qko3gm0HOwWsNNA2YakYdgk9A3MGGQ8Y13XIumiHX/ZH2VQA/LogSgvIdtRj
         8bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xZHZFfBGAguz2tt/aDclYAU0MMkB/zuIOCSv36kPYTM=;
        b=Qk53XMesJjMkNupOmP457NLqokQMg5EUBbrY8s7bPSbz7sJHMo6xWlNsD4tsBbTvMS
         +UwGaKD+BH8FLdHe7lY+eVIdwpLKJs8jVEAMhmg37aTPwptjjOAQakOpCbSjdXhfRFJb
         KPMKtDPf07W+sVGs/7fSh7N2TfB5ihuXC+Pfu9YColOLOwk7Z5tMHeIN4afPnk6lA13m
         PoIcPq0cJ8CbtokwtidQuv3QyDUXt8o9i/1p5HYR1TInxNT2dH5eebXbB5EMsxdFuRFF
         jZmx07uKF2nD4mazFz1ZNZqHuTbdifxDfrFaZ+w6Jke089BfXD4Dilevm2yqgLkBzI8d
         Wl0w==
X-Gm-Message-State: APjAAAWB2FInFnpHuJ8NtxYVNp/rSiXgPWzo90zj0jK6MchTRj0uAApN
        S7cpT6E2u27askU9LTMtw+z4Yg==
X-Google-Smtp-Source: APXvYqx9A8qcsDI8yw+Nf7x+9EFx7IT9gMXaWuX8lHS0a2qtKDYTHX/RNHxnvpEjdWFk/6vvTmn/3Q==
X-Received: by 2002:a63:3141:: with SMTP id x62mr2294788pgx.282.1560857644690;
        Tue, 18 Jun 2019 04:34:04 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id p68sm14234589pfb.80.2019.06.18.04.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 04:34:04 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:04:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190618113401.ybs7k7k3oxkl2ql4@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
 <1794396.RVx65QvVqq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794396.RVx65QvVqq@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-06-19, 01:37, Rafael J. Wysocki wrote:
> One more thing.
> 
> handle_update() is very similar to cpufreq_update_freq_work().
> 
> Why are both of them needed?

I probably did that because of locking required in cpufreq_update_freq_work()
but maybe I can do better. Lemme try and come back on it.

-- 
viresh
