Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC2DA3FE
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbfJQCnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:43:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41410 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbfJQCnV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:43:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id t10so363808plr.8
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yrqLYMo728235YBWz2v13YUKhg9+UyvipsJm/DfRcsU=;
        b=KRNCLJb5VccX6YbkyBGLsjizRwutMxkJvqbOSEwLHZcbFZ/MC2xT6oQyeYv9kHx3a5
         SIw6ymVVh5WR2KDSpUwWsyC5U8+mQrvW2yhX8VHGz68x02gbVIdivs78/pT3nFJJ4ees
         1B8sTSmuEiURIOkLYN2RoHc+SwBmmQ5YPp8SvKDOZFnU8uwpZS+jcZNo070uJGmdmt72
         upnkJ8pzw+v2BhUmhG5VTQSvai4pBSo/0xge8yX/S3RyJo5LQCPGud+wCekEwUJwHyqg
         BSuw8pL2Sur5K2nD7WPERt/A8p6zLMDeAAPSm4reMyN41Y8IHjPxnStvRSVhFvS+84g0
         aSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yrqLYMo728235YBWz2v13YUKhg9+UyvipsJm/DfRcsU=;
        b=UTgZTv5ZvyxBieHTCiMl7geMJzgL4J03e8IQSag9b64yn2zb+HMOj2yvskqUeHFc4A
         fzMwMoI4FAuAeAWPhxKla05PghIRHIVE+iELQjkGCDoFV3czKLb/ZJsgRZ+YPxZvo9wg
         5nTkeX7TWtkUjR915Df7mgFLqFzUEZD2HDiADrorKYRGHP1bqV0YWC2Vet1TZayLoPBe
         HPSz165dhv9CWoicbBkPr4wXEVizsZQsRMqmb1x7E4Yqr+YPBHcABplTQBqtNcxCI+3s
         c8SyXeQMJ9cieY7XNMtyg48MBoBYBxhMnMve6ltpCbDA/SGN2vn3AlzFJuFzTiEzNpE7
         spIw==
X-Gm-Message-State: APjAAAUf2YFhVnjUF9qFod+X3b/yLqFf7nPu8c4Z7IbuwxSCRWDUaZSe
        T2UGG8yGE5KeCN2BtjjKpeJgJA==
X-Google-Smtp-Source: APXvYqzBSm5KQJhD1bgMwV0FdJUZEJEIfD+nzymxlKuEgr074kmwn3aWvd/ylkFk2SznWsMkZyei7w==
X-Received: by 2002:a17:902:a5c9:: with SMTP id t9mr1380197plq.99.1571280200592;
        Wed, 16 Oct 2019 19:43:20 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id d20sm473357pfq.88.2019.10.16.19.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:43:19 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:13:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>, nico@fluxnic.net
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017024318.axs37rs4zy2wb5xh@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110344.15259-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Nico in case he has any issues with this series.

On 16-10-19, 12:03, Sudeep Holla wrote:
> Hi,
> 
> Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
> there's no point in keeping it separate anymore. I wanted to post these
> patches for ages but kept postponing for no reason.
> 
> Regards,
> Sudeep
> 
> Sudeep Holla (3):
>   cpufreq: scpi: remove stale/outdated comment about the driver
>   cpufreq: merge arm_big_little and vexpress-spc
>   cpufreq: simplify and remove lots of debug messages
> 
>  MAINTAINERS                            |   5 +-
>  drivers/cpufreq/Kconfig.arm            |  12 +-
>  drivers/cpufreq/Makefile               |   2 -
>  drivers/cpufreq/arm_big_little.c       | 658 -------------------------
>  drivers/cpufreq/arm_big_little.h       |  43 --
>  drivers/cpufreq/scpi-cpufreq.c         |   2 -
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 559 ++++++++++++++++++++-
>  7 files changed, 539 insertions(+), 742 deletions(-)
>  delete mode 100644 drivers/cpufreq/arm_big_little.c
>  delete mode 100644 drivers/cpufreq/arm_big_little.h
> 
> --
> 2.17.1

-- 
viresh
