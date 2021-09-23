Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F704165F2
	for <lists+linux-pm@lfdr.de>; Thu, 23 Sep 2021 21:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242842AbhIWTap (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Sep 2021 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242796AbhIWTao (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Sep 2021 15:30:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC7C061574;
        Thu, 23 Sep 2021 12:29:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so7682000pjb.2;
        Thu, 23 Sep 2021 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6wi+PDo5klJHw0C07TYcvmIShMs9WeafBIfQi4IbTI=;
        b=diooHl3J32d5dKqleEMHH5OoZsDHa8H0WdR/QbIs2hkuzrIX2GhYOEFIIoPph4jH1Q
         zT+YUe/QyJLOgiQrRGGYLhuzCU5KrF3PloUgs1Cyf32gEpxRY41AEIljPAXfkzKWF1mo
         ogXvIqcb2wrY/es95vnsuUSl8ka59aRiDwvLLMmxGQ+OxznhGRdbpbftxs+bWwrYsaRE
         hXXfNTMuLC1IjA8pxyGQuKjT8qiac0eF+GKXtIv8gi0W3FAYVH6k38XAJTcPL+SnggoI
         A1B6omVja5nj33FMvnuGHLfGtrfG71qJM9006o3XFOTaMMGtf4MjONVj2+4pA5ec2uxr
         apoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6wi+PDo5klJHw0C07TYcvmIShMs9WeafBIfQi4IbTI=;
        b=zm3om1WIYYYLsHJHOpP1KfNDDgUHHX3O0kTBVtK2VBQ1dRAwrdOs7X/WWXer8rkDDg
         OyzWKHI9UgL+PPh6GGPnMTGLRsPjBb2nPYXYVoYxjNi7UgABOsqUn5pgwPJFUahx62Y1
         8COfXodeJQb7x6IoY/XnbkGHhST0Pgrhp5tuwk0nseMEx/kpNEECnQlUm6qZvamXJSL1
         c98GhPTJNVrtbV4kq8HepdXzQkT8jRJbrihjSdvTljHaxqKlrXpRpo4sED0MIIIPwqJr
         yqBdvLBElmaF6igRqVVoyoJFwFVZLXmssvVii4jOI7SHLglvt83cMBRffVFCF9Tw4Ic7
         +HiQ==
X-Gm-Message-State: AOAM532Ub9CXWwPSkZJkUWO2rwhQxWE+YETTKSc+jIhrzNQLuk2IT05F
        ha3SwpTceIuC9o9aM0t85+e2iYA8ErA=
X-Google-Smtp-Source: ABdhPJxWhRPq9I/MTUwE3mVMN7DpYM4OEOiy++cfwd/fv3w+Apb1Zc18qS/R/22ndhA2pHpUzBiZFg==
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id q13-20020a170902bd8d00b0013a08c8a2b2mr5614865pls.89.1632425351980;
        Thu, 23 Sep 2021 12:29:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n22sm7608344pgc.55.2021.09.23.12.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 12:29:11 -0700 (PDT)
Subject: Re: [PATCH] PM / Suspend: Avoid soft lockup warning with suspend_test
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
References: <20210923185106.501848-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <0b44f2c0-bab6-5e6a-e4fb-d9aa89038675@gmail.com>
Date:   Thu, 23 Sep 2021 12:29:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923185106.501848-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/23/21 11:51 AM, Florian Fainelli wrote:
> When testing with a large (>= 22 seconds) pm_test_delay we can see the
> NMI soft lockup barfing at us because a task has been blocked for too
> long. This can be reproduced with:
> 
> 	echo devices > /sys/power/pm_test
> 	echo 30 > /sys/module/suspend/parameters/pm_test_delay
> 
> Unroll the loop and touch the NMI watchdog every 1s to avoid the lockup
> warnings.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Looks like I cannot reproduce the NMI soft lockup warnings with 5.10 and
newer, however I can easily trigger RCU stalls. Let me sleep on it for a
bit and see what needs fixing in 5.15 and newer. Any feedback welcome.
-- 
Florian
