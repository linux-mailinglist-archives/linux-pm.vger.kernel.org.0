Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5849EDCCB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfD2H01 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 03:26:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34616 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2H01 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 03:26:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id c13so3758622pgt.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oG44mZKAe7UcszkggzK4V9bM9F+JOsHTk/7MwfVkDN4=;
        b=fh7kl1ZWwVoP2wr5nIW9e35+2LFpqR+eD2Gh86jorR6UJjH4uI6Ar4gWsm2yVAzzAl
         9b7wdUwCQHUKCAfpotZBzuo7MRs8FADsf3g6/IKnzxCA57sYT0ECPvIQWM8u3AuoXPN3
         5b4diMuH0PBasvk1xP8asnhRVlaJbTXGFYmxFAAfWzD9SLeNGKMFfAPPlfv1RE3LSt1T
         VMsCMi89IsDEwCtiq30MzoedpeckppUOgcGgBR0LUk18yLVT7W4jeF4T290kKq38Ap6p
         soJbFyF+0qDa66zLplybi0usDgc5sOffkKG/UWqRIX8Bs/8pWWh60Z/vqKc2yh5Srn3I
         TUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oG44mZKAe7UcszkggzK4V9bM9F+JOsHTk/7MwfVkDN4=;
        b=SECufgYbPhLLpkAwshYxhA7VJ9zSgUrasbH6SnyYpNvUaeYoh75ofgc0+f7gMi6+W1
         J9sbFs2g8i9ezZEcTPPD1v7Pd/2wQiYXDwnrtP3Yz0UgRPycdj4lK0d7BW3O9SBjW7ZX
         T+rKUTjNRNbpEvba5d2k3KKTs8fbub/gY3LHNY9iDJDzhZPhJtfqUw+OgnBFrvG3D+eW
         YDLgmZzHmiAw78+arA7EZlkMs/ahcJr2tp2OeeCoaQgqh4R4QR+L7WoFIT+YZY06Eotk
         7RTdzxpjAndFOWxPp07Ar+YjkajtI0Jyktn2ioUH/ribS47i9UCE+RFIXISjDhb9tQEW
         99iw==
X-Gm-Message-State: APjAAAWsK5b1Ppj0uMY7NAUiO3/JOOI005a6d0sIodJByZy9NvPPF9K0
        UD1reXPdF8GWkQK7aE6ZAxiqKj7hMig=
X-Google-Smtp-Source: APXvYqym6ZIMon7AuOn4v+eWg871R6FoXimUzhH4/IlNA2SVlZba4Hx3f7LnwA9BAhpLkwtX0Rc6yQ==
X-Received: by 2002:a63:cc0c:: with SMTP id x12mr55523078pgf.336.1556522786843;
        Mon, 29 Apr 2019 00:26:26 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id l26sm47812129pfb.20.2019.04.29.00.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 00:26:25 -0700 (PDT)
Date:   Mon, 29 Apr 2019 12:56:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH v3] cpufreq: Don't find governor for setpolicy drivers in
 cpufreq_init_policy()
Message-ID: <20190429072623.y6mlyfz5lmh2ombq@vireshk-i7>
References: <20190429072418.7860-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429072418.7860-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-04-19, 15:24, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> In cpufreq_init_policy() we will check if there's last_governor for target
> and setpolicy type. However last_governor is set only if has_target() is
> true in cpufreq_offline(). That means find last_governor for setpolicy
> type is pointless. Also new_policy.governor will not be used if ->setpolicy
> callback is set in cpufreq_set_policy().
> 
> Moreover, there's duplicate ->setpolicy check in using default policy path.
> Let's add a new helper function to avoid it. Also update a little comment.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
> v2: fix ->setplicy typo.
> v3:
>   - let cpufreq_parse_governor() only handle !set_policy.
>   - fix using {} in the if block.
>   - change helper function name.
>   - update comment, commit message.
> 
>  drivers/cpufreq/cpufreq.c | 116 ++++++++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 51 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
