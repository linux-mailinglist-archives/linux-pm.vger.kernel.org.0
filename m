Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21E331E6EE
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 08:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBRH12 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 02:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhBRHY4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 02:24:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC4C061574
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 23:23:50 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q20so691886pfu.8
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2021 23:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XZ+7cyfIAMa4qybTYJPAFZXKgOwCxm2f1fhL0vcgILs=;
        b=zcxNV4rPUkqxVIFX2+P/FTys8pW1F4mnkWDnGADI+Q7Tis+cADSwa1UOZtgCkKASKK
         CYUn3vaV+t9ey7m29lQ3IsB4A2DAdIigVTKb/iVwLZMZDwyUODjXXkJ9ngm5ghs0xY3n
         Hrn6M0brC/CxGhMw2J0+tgnSCG5rnMjHKzNATniq1eeXwPesUP/8JtoE32bg/LdispEY
         xIB2ie6BKy+aU0LybOt91BZEbGixq1SJzyb/IlT19r5lwNzSyMuQf+pLZU/1pwiHrGmG
         TcgUZJDI0mtF5mBwvpwn1odWmGjrHEKJfYH30+8NhGkcBk8E0lpePdk6+gKwUOPX6IND
         QVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ+7cyfIAMa4qybTYJPAFZXKgOwCxm2f1fhL0vcgILs=;
        b=uGxZlUVy05D/v596fh1XXRc4NsUiEhx+6IUc5IAQu57bkld9wqT8nbnnbNBtmWGgMe
         Tu+bRO9Vup7Tphc9NPsreFsrlZ1DpJ2VcLef5l1dFlKUCWReN9pg9s+vXTvCMk8DmPwM
         w0YS5Njo3li7c938F8dDSVDHIB9Ns9+ynZ0UFow53SI52Wqt6ofBGv53MXUHlcysb23O
         IBuqplHHpS+o7L8uoQYBZQakfh6xuLhuh2JVRmqj/7iX164RR50UVnOGJ6zygb7S8xA7
         Jn1tCQIV3wntf3znqZ2EBva3qzgTuftrWRSHjWVvZr94Gy4cELep/OgfTXq5GX8mJGFH
         YxyA==
X-Gm-Message-State: AOAM531aN7IYVb9QrumDiMgBLieHWnbOcqUKkSA4Z1j2VkIAk8EWL3OA
        7Qq7aCHhe3oRH5oNe6G31fnZWw==
X-Google-Smtp-Source: ABdhPJyay5kfbTBaholo6asX0wF7iLAKXd37i762FtCcYsP3JZWMTcmGy+pyGz15MHaOgt+sI+Tj4Q==
X-Received: by 2002:a63:1519:: with SMTP id v25mr2932024pgl.217.1613633029702;
        Wed, 17 Feb 2021 23:23:49 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id u10sm4580386pjr.27.2021.02.17.23.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2021 23:23:49 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:53:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 1/2] topology: Allow multiple entities to provide
 sched_freq_tick() callback
Message-ID: <20210218072346.5lvymba35ezuz2do@vireshk-i7>
References: <cover.1611829953.git.viresh.kumar@linaro.org>
 <d398729676f3d2b0d2ab024a2c9ea6e9ee1d0dca.1611829953.git.viresh.kumar@linaro.org>
 <20210203114521.GA6380@arm.com>
 <20210205091424.3od3tme3f7mh7ebp@vireshk-i7>
 <20210217002422.GA17422@arm.com>
 <20210217042558.o4anjdkayzgqny55@vireshk-i7>
 <20210217113011.GA22176@arm.com>
 <20210217114027.ashqh67hrfk4hwib@vireshk-i7>
 <20210217115726.GA25441@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217115726.GA25441@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17-02-21, 11:57, Ionela Voinescu wrote:
> See a very useful comment someone added recently :) :
> 
> """
> +	/*
> +	 * We don't need to handle CPUFREQ_REMOVE_POLICY event as the AMU
> +	 * counters don't have any dependency on cpufreq driver once we have
> +	 * initialized AMU support and enabled invariance. The AMU counters will
> +	 * keep on working just fine in the absence of the cpufreq driver, and
> +	 * for the CPUs for which there are no counters available, the last set
> +	 * value of freq_scale will remain valid as that is the frequency those
> +	 * CPUs are running at.
> +	 */
> """

Lol... 

-- 
viresh
