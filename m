Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C58DA3ED
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392198AbfJQCjk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:39:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39592 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbfJQCjk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:39:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id p12so399730pgn.6
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 19:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zEFefyCYvjEsaVVPS2qn/8n4VOwk3cwSj8+ZMD6emik=;
        b=o3f848n8kbDlHt5KBM6BXMuHOO1zMriF51e1YO2oquFVRSWl+42FqCRhHdlFOXs7E0
         htfMHEtwXke3pWQMe0kQgl6GMwdSrOkuxPtkfvRV89PfS3/EY4I75fKsxwaf3y9gYAlE
         HmN0NiMJRG4aiPIY0LIKOsrh1jjJBu+OMahIjB2n9NpdGqPoYZhAFyWwfkQGJYL49Y44
         rNHpgMSIHpFvnG5A/nma2/D+350Oja329tWqeeKTUtm9yBmO6qJ0mELVvJvMOjE3XMzX
         VEJ4yem+QkGzr0CxIRcyXz70mSKzXXqVD/ny5ci01XHOqTAcuBH6elHvn9lcjLcY+3vK
         6zEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zEFefyCYvjEsaVVPS2qn/8n4VOwk3cwSj8+ZMD6emik=;
        b=oKNx0nOIFgCeFWez8DJHLRm3TpF2aU73bnsKLKOErmsaayM2aXhjsv/gN9yl4HhFDZ
         8wxJ73laiHLcZjoeoExMXV1w9TD3a4ZhCk1/YJiREAazCmNcv37AyhvelFBw/m88cfbi
         WJhyP6B5N5hjOcdJ06imPEsXIg8q5VYl+3db11EdcPM177FLvRAII3svtnHDWK2TzB8z
         Q9HKfX/yuu/4TPRM3lesdn3vVsgm2LqDhHHYp5bFRJoWgHAnghJt6BzX0z0IEgXpvRRe
         b2fJNz0L/MfuKcxXutZ6GCUu2DCqOaaiNH7vVPs2h/RjelmKHTzNI2rsDOEbZhVlLxWl
         6c9Q==
X-Gm-Message-State: APjAAAXO3cX1e3h5E+CP/nWYtdQat+S7iiTkdVtMgrZ3wSnK1yhEFuSt
        m1OlTvKal2a8FjUaanASNfoH0Q==
X-Google-Smtp-Source: APXvYqzdrRZBIUMnzPMVc2UOR1CHHTWtq4YXpulhQnyUqCEvFi6i5kz49j3bwFbo8NvjTfpRESnM7Q==
X-Received: by 2002:aa7:970b:: with SMTP id a11mr972230pfg.37.1571279979302;
        Wed, 16 Oct 2019 19:39:39 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id z12sm494571pfj.41.2019.10.16.19.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:39:38 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:09:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: merge arm_big_little and vexpress-spc
Message-ID: <20191017023936.vgkdfnyaz3r4k74z@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110344.15259-3-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 12:03, Sudeep Holla wrote:
> arm_big_little cpufreq driver was designed as a generic big little
> driver that could be used by any platform and make use of bL switcher.
> Over years alternate solutions have be designed and merged to deal with
> bL/HMP systems like EAS.
> 
> Also since no other driver made use of generic arm_big_little cpufreq
> driver except Vexpress SPC, we can merge them together as vexpress-spc
> driver used only on Vexpress TC2(CA15_CA7) platform.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  MAINTAINERS                            |   5 +-
>  drivers/cpufreq/Kconfig.arm            |  12 +-
>  drivers/cpufreq/Makefile               |   2 -
>  drivers/cpufreq/arm_big_little.c       | 658 ------------------------
>  drivers/cpufreq/arm_big_little.h       |  43 --
>  drivers/cpufreq/vexpress-spc-cpufreq.c | 661 ++++++++++++++++++++++++-
>  6 files changed, 652 insertions(+), 729 deletions(-)
>  delete mode 100644 drivers/cpufreq/arm_big_little.c
>  delete mode 100644 drivers/cpufreq/arm_big_little.h

The delta produced here is enormous probably because you copy/pasted things. I
am wondering if using git mv to rename arm_big_little.c and then move spc bits
into it will make this delta smaller to review ?

-- 
viresh
