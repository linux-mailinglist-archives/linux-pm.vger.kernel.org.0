Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69FF2104A93
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 07:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfKUGIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 01:08:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUGIR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 01:08:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so1123566pff.2
        for <linux-pm@vger.kernel.org>; Wed, 20 Nov 2019 22:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qO7u8hMCBA9SR1J8X70ILGB8LRQbTCIm17ibyeXRY3c=;
        b=TyrzdxQXnNUgWQc1dpvekmYvS/uKbLc1vemjBPsTKuV73FDqDCSImOhogREpg5aGs5
         KX524hE43gkQ+ThP5OqT7ZzIPehYhI9IDZ1i6JORbhkyFvMn3oJUbt5JijCLaMIXqflk
         tLZ/1frRKDHBRZlMWuVDzRaNB2+8ZI9R0GeXS9nkyyJdl+Gb2zMCYvh8mqT3MbPe3BBh
         nF4ErfriXVVhYs1jnI2983PTr00uFZBISu5BwDI2FMZDud9H7j98U2BEZSwV1nZID0e/
         BNND+yABoFY0g3cvhUkjAT2CgwSqguAPIXm4uFHWT/f3ha0NSdnFeiZWu3ujfnJGvmuz
         xgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qO7u8hMCBA9SR1J8X70ILGB8LRQbTCIm17ibyeXRY3c=;
        b=W2tgR7XnjUWRwX4IIv8m+2JgZmcsXem/DaqtEgA/VI4OJWUFaNu5OPv8VLZAscUmdq
         hYf9BehueGmalVD7Xp9RRuHy/1KibNobvA+3a9ge26NhdiAgGXG0NdMDCm64e4eY1n7C
         BhNRThOZmwLeefR9NKFFJVr8i+Iyp1rSq0RbTi4aA3K85gqLE3RZoAD3ai8wY0tPw40M
         cxg63Fer5LQkroKFFE+/e6EvlI0cBCE7e/qOBrWcxY1gHw23W2BJdL5hBWWRlr9PWCed
         C0hYPMsWLOAO31E+BUVPLTeY95NjJ+PQJthhoiHEs3TOqCZQ8vbDZROb8fiMsMnwaojw
         K0xw==
X-Gm-Message-State: APjAAAWJ8qZcJlCy8wYzO+FMCbgHDLBGPIGyN/G5JIHKewrDk2BPs7sH
        hnTdXuIV18r/XyQgg8nXkK0Ibg==
X-Google-Smtp-Source: APXvYqxDShr6iCwpcYfxVnrwCEYPFKwevNfQ4b3B5HfbCIH+GrMWSCxT6cdvpx0gPiliheSK79rerw==
X-Received: by 2002:a62:83ca:: with SMTP id h193mr8625885pfe.218.1574316495041;
        Wed, 20 Nov 2019 22:08:15 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id w62sm1598080pfb.15.2019.11.20.22.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 22:08:14 -0800 (PST)
Date:   Thu, 21 Nov 2019 11:38:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sasha Levin <sashal@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Cc:     tomeu.vizoso@collabora.com, guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
Subject: Re: stable/linux-4.14.y bisection: boot on odroid-x2
Message-ID: <20191121060811.mvzzh4zlfzlubzlv@vireshk-i7>
References: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-11-19, 18:52, kernelci.org bot wrote:
> commit 714ab224a8db6e8255c61a42613de9349ceb0bba
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Fri Aug 3 07:05:21 2018 +0530
> 
>     OPP: Protect dev_list with opp_table lock
>     
>     [ Upstream commit 3d2556992a878a2210d3be498416aee39e0c32aa ]
>     
>     The dev_list needs to be protected with a lock, else we may have
>     simultaneous access (addition/removal) to it and that would be racy.
>     Extend scope of the opp_table lock to protect dev_list as well.
>     
>     Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
>     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

@Sasha: Please drop this patch for now.

-- 
viresh
