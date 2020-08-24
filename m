Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172F724F73B
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHXJLY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 05:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgHXJLT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 05:11:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682E9C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:11:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 31so2008498pgy.13
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YNxY4kfLHU4NI5WKAgDu+DEPuEBGxlooKlqn38YKqQM=;
        b=YB4jM4MosToH/mDNnWjV5zQyDng5Ybc2G22Wi0KNgl/VwAamvernQ4ydNQOfclYFqR
         jI6EoeF52j6ZODBHCwrTc221nROMTRlQD0prm0BOWlcxJ0CxgljFHLDtnFVzwNWt0bDn
         AaN+qY1UWTbyLit5nOdUj1LXe4WwBD6Rfefa4yVsE/2HSJxV5YzwBmocZ0YCgMtTSnsO
         XWzWShhaT0pIe4DNP+n++owwwFj+WzUiXUAIWuKfhq/YGukadWvs3b3swq2MI44QyRsV
         1YO48QAcLsov+TbxYX7FkyVS7SpBiVsagnJKc8yUdvL/6FCWZXmH+JMegBSVxpmPB45I
         ZkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YNxY4kfLHU4NI5WKAgDu+DEPuEBGxlooKlqn38YKqQM=;
        b=jaxtkoiwkwxKzD3Tll4qZRpXccdrKoUAl707ecdAlxBsCT85mNpWtsiXUD6mub6tNA
         Dv+5OP4FKZoIgFH7MKImEdwn3g6F/2DNODMvsC9Z+JZ8CdgLv/zfsQrsCAIummCJUQdm
         b15+c7Ll5YACibsWqGQiYkGyFeqcdOsUMUh53fgPDHy+NcqUIgDqMBc3cSgketllQFEV
         /nTKqYD96kmsHQSpUTTdjHTBS55RKFFm+0eQlA/tgHED3ONbDdTZpAhjhL7Hs5wHEoO3
         Gx+kLAvP++su3Xok/Vhw+w8yCk9RxWQUrNhh4G819ACbXrtKQo2eYFdZXS3pm5M7MLII
         m/CA==
X-Gm-Message-State: AOAM533AipfPpm6dQ4cmsfhg6ehM5fVzYQ5t20KU2xAZiuWjFTJLmnx9
        91tK8Tm4U2fm+BDfzX2GLXKLFg==
X-Google-Smtp-Source: ABdhPJyCLKjG8Jw0aVnUr6DrPqJTZOe8+DOo5xokZWSfVfKz6DoRfx+QN8xCclGwg6DhcFYV/yTnhg==
X-Received: by 2002:aa7:9a1c:: with SMTP id w28mr3369115pfj.116.1598260277962;
        Mon, 24 Aug 2020 02:11:17 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id z77sm10919535pfc.199.2020.08.24.02.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 02:11:17 -0700 (PDT)
Date:   Mon, 24 Aug 2020 14:41:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/2] opp: Allow dev_pm_opp_get_opp_table() to return
 -EPROBE_DEFER
Message-ID: <20200824091115.ljsaoaaui5kbykpi@vireshk-i7>
References: <20200727093047.8274-1-stephan@gerhold.net>
 <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq9bbMZD7ifF=ipfBD3ayiLuc6RPwW8_RWZBxMGv_WZkw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-08-20, 11:10, Ulf Hansson wrote:
> On Mon, 27 Jul 2020 at 11:31, Stephan Gerhold <stephan@gerhold.net> wrote:
> > I wasn't sure if the changes in drivers/base/power/domain.c
> > should be made in a separate commit, but they need to be made together
> > with the other changes.
> 
> I would suggest to move the changes in drivers/base/power/domain.c
> into a separate patch, still part of the series, but let it preceed
> $subject patch.

That can't be done as the return type of a routine was changing and that needs
to be sorted out in the same patch.

-- 
viresh
