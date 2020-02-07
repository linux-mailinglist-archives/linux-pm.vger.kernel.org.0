Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C221551C9
	for <lists+linux-pm@lfdr.de>; Fri,  7 Feb 2020 06:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgBGFX0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Feb 2020 00:23:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45280 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBGFX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Feb 2020 00:23:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so506768pls.12
        for <linux-pm@vger.kernel.org>; Thu, 06 Feb 2020 21:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JFpy5PW00eEOV0mr2R1XHLYoFiyeQV5xiNLC3FbHn7I=;
        b=EzURvtDf5f+0jQdBWS4X/DFmmUEZ7ya/hQSUUW0oWmIpTMDk08H7PpVsKypPuK65j9
         hbgfwTN1NM4Ukgg8AQcei+jwFNgRgPFAusiPPzE4x3Qnv/Pn2gvasVC/+aDSsAB8nYVS
         T0km/x8GTLLvUR0zMsZFJIWHAFVC6rGogj9HSrdHxv/F73/b55at4HHLQlv92MWRaFB/
         J9Euu9hDfP5vrgqynZ4ZneAsRZi5WeC/ItA/TH3cAXcauyPNsMnrPynFHSMqSptxnPr1
         sp2dKuTfKdWxTRM3CMyrc3JFR4uhZtR0Y0wwcAs9qIG989GxBus/h9f6OCyMAORto0sP
         N+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JFpy5PW00eEOV0mr2R1XHLYoFiyeQV5xiNLC3FbHn7I=;
        b=JnxnLU9w17u0+oOlM+cJ7hO5CQ5KX/auJcw0AYaC7RRfCsUHi4lI9tR2Lh5sc2LraM
         s+Lj6r1517GH+ILIgimwRzgVN+Q5k2h8NLRiSFtiKgDrlm+XpgFzB/0TNZU1SPT3pWmm
         Xm0NmLuMJYDFJCyrD49UmM8BkPjcaE8COVNIGsyJyYVjA7QdQn/VcsRBcs+r8MqFqHsW
         nk00MYMRu0EC8n8SRNJ6HgvvC4n6irU7zH92C7RpI8YIribm6MEpQqPb8D3doUP+ZbPF
         Uf5fA8iXGRUMP1oGqzZMb4h93jvIjYjGLat16bMpWjfpswk7ysAIXDldQO34tRhftJhC
         R5Kg==
X-Gm-Message-State: APjAAAW1BYzo7pWrXuqCCWHw4zQh2gn4SBmCJLF3vgvqtErlPn2GqaCC
        fhIZGwjYcPX2W5Ru6WnSN76oEly5o4A=
X-Google-Smtp-Source: APXvYqwpgraqiE1aRZ9+cmzqMgyH60JBqFpNNR9s58JW8q2mauDuJF8Hf6FUaCEMi6UTCfUDV1HN4A==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr1828830pjv.73.1581053004505;
        Thu, 06 Feb 2020 21:23:24 -0800 (PST)
Received: from localhost ([122.172.141.204])
        by smtp.gmail.com with ESMTPSA id b10sm913720pjo.32.2020.02.06.21.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 21:23:23 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:53:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andy Tang <andy.tang@nxp.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: Ask for help about cpufreq issue
Message-ID: <20200207052321.povhuxrlm25ueoak@vireshk-i7>
References: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4333D45D033CB8E33CB9070FF31C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07-02-20, 05:09, Andy Tang wrote:
> Hi Viresh,
> 
> Cpufreq failed to work on our board. CPU frequency keeps at the lowest frequency whatever governor I choose.

Have you tried performance governor ? Freq should move to highest freq
there for sure.

How do you check the frequency ? Without significant load you won't
see the freq movement.

Also have a look at the policy0/stats/ directory. It will show the
details of freq switching properly, include the transitions that have
happened.

> Hardware platform: ls1043ardb board (4 cores arm64 arch)
> Software: linux kernel v5.4.3 + ubuntu 1804.
> 
> Test log:
> root@localhost:~# echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
> root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
> 500000
> root@localhost:~# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
> 1600000 1000000 800000 500000
> 
> All the parameters you may need:
> root@localhost:~# for entry in `ls /sys/devices/system/cpu/cpufreq/policy0/` ; do echo $entry;  cat  /sys/devices/system/cpu/cpufreq/policy0/$entry; done
> affected_cpus
> 0 1 2 3
> cpuinfo_cur_freq
> 500000
> cpuinfo_max_freq
> 1600000
> cpuinfo_min_freq
> 500000
> cpuinfo_transition_latency
> 31
> related_cpus
> 0 1 2 3
> scaling_available_frequencies
> 1600000 1000000 800000 500000
> scaling_available_governors
> userspace ondemand performance schedutil
> scaling_cur_freq
> 500000
> scaling_driver
> qoriq_cpufreq
> scaling_governor
> performance
> scaling_max_freq
> 500000
> scaling_min_freq
> 500000
> scaling_setspeed
> <unsupported>
> stats
> cat: /sys/devices/system/cpu/cpufreq/policy0/stats: Is a directory
> 
> 
> Could you please instruct me how to investigate this issue?
> 
> BR,
> Andy

-- 
viresh
