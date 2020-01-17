Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664F2141421
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 23:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgAQWag (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jan 2020 17:30:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728760AbgAQWaf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Jan 2020 17:30:35 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD842072B;
        Fri, 17 Jan 2020 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579300235;
        bh=og/YFyt537egSptixheev7EftOvsv54ApMpBX5xX5GY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TItraTI1e79l3S7N20Yfi4Pff6u1MWR1PlK4ZUloA0q8rl6UOuiezq36vB93EvSc9
         69qzXigyO8JzcZYSvpGdbQBEfLL1VLl5bgTAcmF06RBXVNahV7QqMkquV6TvdinqE0
         aeyyO4RS2XqCdIoB6/gofdDaTPLPIiwU7GxLWROs=
Subject: Re: [PATCH v3] cpupower: Revert library ABI changes from commit
 ae2917093fb60bdc1ed3e
To:     Thomas Renninger <trenn@suse.de>
Cc:     Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        shuah <shuah@kernel.org>
References: <1835520.PWyA4J24ZB@skinner.arch.suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <ea49dbb2-6c57-08fc-472d-46055166de30@kernel.org>
Date:   Fri, 17 Jan 2020 15:30:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1835520.PWyA4J24ZB@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/17/20 12:55 AM, Thomas Renninger wrote:
> Commit ae2917093fb60bdc1ed3e modified the library function:
>      
> struct cpufreq_available_frequencies
> *cpufreq_get_available_frequencies(unsigned int cpu)
> 
> to
> struct cpufreq_frequencies
> *cpufreq_get_frequencies(const char *type, unsigned int cpu)
> 
> This patch recovers the old API and implements the new functionality
> in a newly introduce method:
> struct cpufreq_boost_frequencies
> *cpufreq_get_available_frequencies(unsigned int cpu)
> 
> 
> This one should get merged into stable kernels back to 5.0 when
> commit ae2917093fb60bdc1ed3e had been introduced.
> 
> Fixes: ae2917093fb6 ("tools/power/cpupower: Display boost frequency
> separately")
> 
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Thomas Renninger <trenn@suse.de>
> 
> v3: - Add Signed-off tag
> v2: - Add fixes: tag
>      - Add [PATCH] and cpupower in title
> 

Applied to

git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git cpupower

for 5.6-rc1 pull request to Rafael.

I fixed up the changelog to get around the following checkpatch
errors.

ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'Commit ae2917093fb6 
("tools/power/cpupower: Display boost frequency separately")'
#44:


ERROR: Please use git commit description style 'commit <12+ chars of 
sha1> ("<title line>")' - ie: 'commit ae2917093fb6 
("tools/power/cpupower: Display boost frequency separately")'
#60:
commit ae2917093fb6 had been introduced.

thanks,
-- Shuah
