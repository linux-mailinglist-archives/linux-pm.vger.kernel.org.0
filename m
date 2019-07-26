Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841FB75F65
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfGZG7n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 02:59:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41826 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfGZG7n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 02:59:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so24290063pls.8
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCRqDgGf7sKXskPLrVhm05S+BTBlIF9UyZs1GvTrm9g=;
        b=mRKZEYiemsMOst46Lta0e4Kf/qyIYoKy1SxAhwgYk5s9Bhb3sUBIFRvfqPkrnjTfly
         fB+Yx1jbyxEKGeI6gW0gTRkHkzZpyKIYNDhW/LVRH+yFslpA3qRYYQu0sPY57VrVu/oq
         /zA0S4VsCpb97qcysfkdO7+tGnI8/QKDlNM4tMIdPmE9Zr5A7YTG+vFGYkX/qi3Ovfij
         lpYM1DYSVx6rFVxKQfPBzl15RjLt5SkATGQPlmPDFIibsrE1nAc5zwU+FiDGVUxDGmz1
         dcaGuiDBQjCf5pJ9Tcl2R2WWFfO+2khZfRQB+KEkqxnm9z/nrJuLK1HsuGpnNkOzDuy2
         I5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCRqDgGf7sKXskPLrVhm05S+BTBlIF9UyZs1GvTrm9g=;
        b=ctKr4hmGknRsc7TAAjptkX/Vy7C2wN+TBYGzP4wrEF6h5CyC/s7uWza4oVcLeu1vLn
         vkYAc+BsS8AwtNCi2C6LjqPPf03PBxwbAibqkohCBX68kfjKgp/AfxKinneM9WkptCa9
         2WLFh7LGtwgkWFWPsvz+aCNe01kS6d13bp1PPBIJ9RTjaXIuk8KxY0N9iFC5bSsqyxOt
         rwnw7JUa3dXzNi985ixxPK/thoDq+GrnDcjXBMdu5gCLDyQx3oWvLSPTcsskD5LG7kLJ
         lFAZkSK5BQ18kcKVLLcMej/+S2CVg5oYXPe71nbjRloqIQ5SkKOJvnEIHjDdWdSlwb0y
         FSGQ==
X-Gm-Message-State: APjAAAV2XfKgcvISsMyaTIaOO1EWd34Hs0atMSMvvX+gi8K7uyifxUhs
        foznFkAXUfpXpqFvToctl3yiew==
X-Google-Smtp-Source: APXvYqw05J1myt3HAmsydEPvF99WYIt3aQYbFUIG8WM/rwk7V/ehYqbwPOQukswXctUYjKmlrzFgrQ==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr88686237plb.319.1564124382989;
        Thu, 25 Jul 2019 23:59:42 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o32sm49160891pje.9.2019.07.25.23.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 23:59:42 -0700 (PDT)
Date:   Fri, 26 Jul 2019 12:29:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] PM / OPP: Correct Documentation about library location
Message-ID: <20190726065939.lvvmd23wna5sf3e5@vireshk-i7>
References: <20190726060747.8700-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726060747.8700-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 26-07-19, 14:07, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> OPP library is now located in drivers/opp/ directory.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  Documentation/power/opp.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
> index b3cf1de..209c761 100644
> --- a/Documentation/power/opp.rst
> +++ b/Documentation/power/opp.rst
> @@ -46,7 +46,7 @@ We can represent these as three OPPs as the following {Hz, uV} tuples:
>  ----------------------------------------
>  
>  OPP library provides a set of helper functions to organize and query the OPP
> -information. The library is located in drivers/base/power/opp.c and the header
> +information. The library is located in drivers/opp/ directory and the header
>  is located in include/linux/pm_opp.h. OPP library can be enabled by enabling
>  CONFIG_PM_OPP from power management menuconfig menu. OPP library depends on
>  CONFIG_PM as certain SoCs such as Texas Instrument's OMAP framework allows to

Applied. Thanks.

-- 
viresh
