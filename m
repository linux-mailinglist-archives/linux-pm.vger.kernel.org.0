Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370AE14618D
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 06:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgAWFcz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 00:32:55 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46369 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgAWFcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 00:32:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so964835pff.13
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2020 21:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olcNFoFN1XXIUl/h/J5YSDSjEz+dlCu/0pWI28fy02Q=;
        b=jUpnAm84r9pUqF9Xu8lwVDVPb4Q0SRJNzxeioAK4yHXPnfOFRa4nbDsIBTKpJcwpTw
         QDRaIHb/x/1Zyn4ln6/aVpRJkeEofXoM2wSl+O9ohWWiokIwMyN80801O1e0QUtEwe5K
         +Atis93gqDMRkvdkZual5xlzaxtqFqYsvFcieb9OJU/u0t17jjC+lX+8QlrR5bcYAZmL
         2ESd1GLTk7Pe8jUBxGQXEDLgB153BNv63Kicx/zshBi27Q4b7QyYWxTtyYl5QqEbXxDZ
         uJ+F1NEM3dY+rCHfb/rTZYvfQ4lIMWr75mreOXm3PaYqdVmNfXQC6CweIH2AR5KYf9m4
         1b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olcNFoFN1XXIUl/h/J5YSDSjEz+dlCu/0pWI28fy02Q=;
        b=YW1JYtS8w3eM75+cCvu7W1uPJTP352lyUpfCiYQQyDDEvDul1OBKagiehiwT6OucFh
         oK3yuMkNo9QmFQlZMpHJl6czZVOqPOOBoD+gPSCV+LhnFW+ZXQ2bWUjUkqOWA2EXqqDp
         z0mn7B5ZDT8hgGLqMVzxjYOcFqAUNZVqjadTZilYpYXXtZSNkFJirquVua8CIdrmnvGJ
         UloTdrW35XtVaQFYinfmdTvW/zFe9ZTOVrYwtp3JfyoBnQ7i2gQC1oVzdXPWBj2ILnhh
         qemO/yMcoyHe+4d7Hu/2M7eFn2PkqMkye3oFfTb5D2nYO3BROIkWT9NlMSdpj6HHiQ2p
         iMPA==
X-Gm-Message-State: APjAAAWY5lQ+wLkRwaHNyT1IWDV1nE+rlnbEHIWWWuXH2gtH9B59jr9O
        Zius606BDWEBkln6J0dUxo+e0w==
X-Google-Smtp-Source: APXvYqxL6WeD/cuMHW0iO6kFFQhDXGmz4F/jTs8JqzJ4Mhlg1nQXubIy+ed4mw7b90/EdBb5r7BReQ==
X-Received: by 2002:a63:447:: with SMTP id 68mr2206538pge.364.1579757574804;
        Wed, 22 Jan 2020 21:32:54 -0800 (PST)
Received: from localhost ([122.167.18.14])
        by smtp.gmail.com with ESMTPSA id j5sm772505pfn.180.2020.01.22.21.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 21:32:53 -0800 (PST)
Date:   Thu, 23 Jan 2020 11:02:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] cpufreq: Avoid creating excessively large stack frames
Message-ID: <20200123053251.3j7muofewhfidplw@vireshk-i7>
References: <2523300.pfpGjzY74h@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2523300.pfpGjzY74h@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23-01-20, 00:16, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In the process of modifying a cpufreq policy, the cpufreq core makes
> a copy of it including all of the internals which is stored on the
> CPU stack.  Because struct cpufreq_policy is relatively large, this
> may cause the size of the stack frame to exceed the 2 KB limit and
> so the GCC complains when -Wframe-larger-than= is used.
> 
> In fact, it is not necessary to copy the entire policy structure
> in order to modify it, however.
> 
> First, because cpufreq_set_policy() obtains the min and max policy
> limits from frequency QoS now, it is not necessary to pass the limits
> to it from the callers.  The only things that need to be passed to it
> from there are the new governor pointer or (if there is a built-in
> governor in the driver) the "policy" value representing the governor
> choice.  They both can be passed as individual arguments, though, so
> make cpufreq_set_policy() take them this way and rework its callers
> accordingly.  This avoids making copies of cpufreq policies in the
> callers of cpufreq_set_policy().
> 
> Second, cpufreq_set_policy() still needs to pass the new policy
> data to the ->verify() callback of the cpufreq driver whose task
> is to sanitize the min and max policy limits.  It still does not
> need to make a full copy of struct cpufreq_policy for this purpose,
> but it needs to pass a few items from it to the driver in case they
> are needed (different drivers have different needs in that respect
> and all of them have to be covered).  For this reason, introduce
> struct cpufreq_policy_data to hold copies of the members of
> struct cpufreq_policy used by the existing ->verify() driver
> callbacks and pass a pointer to a temporary structure of that
> type to ->verify() (instead of passing a pointer to full struct
> cpufreq_policy to it).
> 
> While at it, notice that intel_pstate doesn't really need to verify
> the "policy" value in struct cpufreq_policy, so drop that check from
> it to avoid copying "policy" into struct cpufreq_policy_data (which
> allows it to be slightly smaller).
> 
> Also while at it fix up white space in a couple of places and make
> cpufreq_set_policy() static (as it can be so).
> 
> Fixes: 3000ce3c52f8 ("cpufreq: Use per-policy frequency QoS")
> Link: https://lore.kernel.org/linux-pm/CAMuHMdX6-jb1W8uC2_237m8ctCpsnGp=JCxqt8pCWVqNXHmkVg@mail.gmail.com
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c     |    2 
>  drivers/cpufreq/cpufreq-nforce2.c  |    2 
>  drivers/cpufreq/cpufreq.c          |  147 +++++++++++++++++--------------------
>  drivers/cpufreq/freq_table.c       |    4 -
>  drivers/cpufreq/gx-suspmod.c       |    2 
>  drivers/cpufreq/intel_pstate.c     |   38 ++++-----
>  drivers/cpufreq/longrun.c          |    2 
>  drivers/cpufreq/pcc-cpufreq.c      |    2 
>  drivers/cpufreq/sh-cpufreq.c       |    2 
>  drivers/cpufreq/unicore2-cpufreq.c |    2 
>  include/linux/cpufreq.h            |   32 +++++---
>  11 files changed, 119 insertions(+), 116 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
