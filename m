Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D371E9F68
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 09:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFAHme (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 03:42:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C3C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2020 00:42:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w20so3104084pga.6
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lr8AWK8ekg5LQtfn3WMY4E/YqUVLNTDZlmCtQ6qowqs=;
        b=tPVjQUcSWjGau/zQSPuXd/p1Ebjza0LeZ634qd43THcxn5c2wa5keYDpYxuJPac7lV
         b7TQttHlQC/MX5vDRSsGma12/CS3BLh8t74HGBNEJigMlfTE/zOjpG8yX79L6wQruPZA
         sykdxRf1meTEqE6NEOZnppzigFGkKOppktHUTY5S+b/Plq5yN8iJL+hkphDEIrLaVkJw
         X4upkI7n5oa5hMcPOgOlfMktp9FECICIlZABJbmEbeLoUvO5DZ6WbE1910kT1aT1lO+H
         RoyamkHyHKB3nWMGZfnsIAtDOyiWSXwLgUQcDK55H5ahGtQOTFFCYZepcAZjlXgBQtOA
         Pmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lr8AWK8ekg5LQtfn3WMY4E/YqUVLNTDZlmCtQ6qowqs=;
        b=I088naOMLeMIDKAatOeAcmWsCE0H6IYMkx+Og6wexSvhXZIgyXww1UvEfIC82srW96
         63HJXPrsZqLt8+XVtRm3uIRDG76KUPJmXFffY657HUHVI2XzmNklTEM+9SDcPWKsPHYe
         Cl5Gk7etdvT+2jM+zwXGzx6/gqCmICX/klpORVw68dOv8/9EgR4tQ44LfCg+/FOsYSrt
         0/FO+DkgGZ1V1ViiycxwtIXYgxR8BSO5UWRKi6kXi/nSDBAPVFTnkZhYgzPlwnaaYSMQ
         CkQjl5lVmnar3r+C3BIRqqRzbT0b3si0DL8YXJ+yRXb+iUbhcAvMqPXAofTT/Fx9AmsJ
         oktA==
X-Gm-Message-State: AOAM532mNqbXF9Vj5bDV0WCIIkRD9WepwgEnL5ftyTY/bxXScool8BHR
        LMpFy84Fm7ZRgTGzh4BOzYiHDVL2k6E=
X-Google-Smtp-Source: ABdhPJykV1Td/mzdMWw955iAXbvfwsNR6xAOqlDB5kSijXrD7/Dujt0pr0hAAdV2UvdvhrGgzl7Vcw==
X-Received: by 2002:a63:f856:: with SMTP id v22mr18698380pgj.64.1590997353129;
        Mon, 01 Jun 2020 00:42:33 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id ds11sm5768171pjb.0.2020.06.01.00.42.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 00:42:32 -0700 (PDT)
Date:   Mon, 1 Jun 2020 13:12:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>, rnayak@codeaurora.org
Subject: Re: [GIT PULL] OPP changes for 5.8
Message-ID: <20200601074230.xflri4k5tmrbyezo@vireshk-i7>
References: <20200601043440.c5oiuucf7wuqeasd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601043440.c5oiuucf7wuqeasd@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-06-20, 10:04, Viresh Kumar wrote:
> Hi Rafael,
> 
> This pull request contains:
> 
> - support for interconnect bandwidth in the OPP core (Georgi Djakov,
>   Saravana Kannan, Sibi Sankar, Viresh Kumar).
> 
> - support for regulator enable/disable (Kamil Konieczny).
> 
> This is based on three patches from the interconnect tree which shall
> get merged via Greg's tree.
> 
> -------------------------8<-------------------------
> 
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> 
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next
> 
> for you to fetch changes up to 264c280442847ac7ed0bb89ac3a1e2e8859f25d8:
> 
>   opp: Don't parse icc paths unnecessarily (2020-06-01 09:37:45 +0530)
> 

Had to modify the top commit a bit, here are the pull details:

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/linux-next

for you to fetch changes up to 45679f9b508f10c12a1e93cf2bdccbc1c594aa39:

  opp: Don't parse icc paths unnecessarily (2020-06-01 13:10:15 +0530)


-- 
viresh
