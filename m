Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18E48104E79
	for <lists+linux-pm@lfdr.de>; Thu, 21 Nov 2019 09:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKUIze (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 03:55:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45417 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfKUIzd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 03:55:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id z4so1311536pfn.12
        for <linux-pm@vger.kernel.org>; Thu, 21 Nov 2019 00:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JDh4J7txYc3naAMlVPRKqlgsc0Gi2de9J0u9I07SRgE=;
        b=SXf6MqbSDeg/fVx0sGott9QiNL08dk+gq2qyuQhjIDe6mEC8Eew7jE/+g6gizVdTBy
         UrRWnukkMQShx2l1Vg65R5P8ZeXHRnugHpon0heqD1m7M+rEGCgvzxkq/E1ElFSq91/7
         Bclf2FqGosWV0kCmy6IGf8niCABAl0CR9Em1GviJnK2XDoUOwv4OmqhE6K8x8d7fwU+l
         zfjVpbPyMGGKc8KrWTpSD8FLayEZW8DsCgsfU+w8x4yb19kYyHuCetCISCRuBdEKLL4J
         5R54IypEaOOh3JkG4xqLS4R6VzjOFUZFSAP255kEaFcSFTiQS2dBpp3QLyYL9+DRP7rF
         5TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JDh4J7txYc3naAMlVPRKqlgsc0Gi2de9J0u9I07SRgE=;
        b=aTeQ6Ya04Y+Y+ithke0H57GvNWAOSSn/O/r3jHrryNaeWMqA+sDt0p8mfTlikDeqyw
         Yf+2Fcf3IGls3QYT09zDvcQeIMFS/mqapNw27D5eU/+DpY0qLG3eVGh1/x1CrHAe6Y+o
         3WZ7/cRlyTvsMDAShE0ImhpJjYatdh9T81TcVJuc64sJiAU41ErmHtaYyGjTiFO7tBdk
         jv9ekk+rad08ZdpZTJQUbbLbg7qOGQxaw+0DBnEXyE/LCT5rOXah2Mfih7HclcqeZdFw
         n6HpEHQ7qoUUp9qRy5wclAVjquoDpogWX0aYxwitHpIl1UD5sh+ROhVlv6o68jbeOpnj
         VQtw==
X-Gm-Message-State: APjAAAUPNWpPLzgfi4uLkdUYO4Wox8cUfQtFxtf1RaDj6gL85/GpHxwt
        OiItWYjZ4uNNkWAjeqAgUCtaLA==
X-Google-Smtp-Source: APXvYqwImatb0/SQFGgTcvIX7x0xGvkXF5uKVkbBIQ3LaNfl9s6ckC4vLLVKjdh/XkqeXoOliNxiVw==
X-Received: by 2002:a63:6b82:: with SMTP id g124mr8313475pgc.178.1574326531905;
        Thu, 21 Nov 2019 00:55:31 -0800 (PST)
Received: from localhost ([223.226.74.76])
        by smtp.gmail.com with ESMTPSA id s2sm2044089pgv.48.2019.11.21.00.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:55:31 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:25:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
Subject: Re: stable/linux-4.14.y bisection: boot on odroid-x2
Message-ID: <20191121085529.qjmj7pwew4wjmggu@vireshk-i7>
References: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
 <20191121060811.mvzzh4zlfzlubzlv@vireshk-i7>
 <20191121065821.GA344102@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121065821.GA344102@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-11-19, 07:58, Greg Kroah-Hartman wrote:
> On Thu, Nov 21, 2019 at 11:38:11AM +0530, Viresh Kumar wrote:
> > On 20-11-19, 18:52, kernelci.org bot wrote:
> > > commit 714ab224a8db6e8255c61a42613de9349ceb0bba
> > > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > > Date:   Fri Aug 3 07:05:21 2018 +0530
> > > 
> > >     OPP: Protect dev_list with opp_table lock
> > >     
> > >     [ Upstream commit 3d2556992a878a2210d3be498416aee39e0c32aa ]
> > >     
> > >     The dev_list needs to be protected with a lock, else we may have
> > >     simultaneous access (addition/removal) to it and that would be racy.
> > >     Extend scope of the opp_table lock to protect dev_list as well.
> > >     
> > >     Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
> > >     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > @Sasha: Please drop this patch for now.
> 
> Drop it from 4.14 and 4.19?

Yes.

-- 
viresh
