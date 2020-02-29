Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89CB1743F8
	for <lists+linux-pm@lfdr.de>; Sat, 29 Feb 2020 01:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgB2Avi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 19:51:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54101 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgB2Avi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 19:51:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id i11so1892284pju.3
        for <linux-pm@vger.kernel.org>; Fri, 28 Feb 2020 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4tgEyFArklK0C2NkHJ4Ev1DbekboBTuLVXflJ8Bdmg=;
        b=YEZrilU5Emz9Z8Ec+wHK4LiI7fQQzdfCcue2M/IsGBDlntu9mx1MWRLDNRF2DkbyzK
         R2lwOWZhgB6mzNpT1Pu/aYGOixkKd67bWXduwxC7akBPX2iYuMwBeOQ5JBnJ3PoP/sm+
         fwHlgE5NWc/QcaNpgQ1v36FCjFUNaQ0QzZjXLhJBB7HSyakmk/gogoPqwcbqcHALKGWF
         LEwHUDu3Vt5k84kgM8atzhoarq3m2Hp+ubtvEsIOjJSEjTqa8HV47MN06DuHfs+WThz5
         AS+PNvVOGiAiXvalk95ELB6qY6CzHUNlqNZ8cCZ8Kyzz7tO0GspqtRYJOBiBc4omlRU0
         Jamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4tgEyFArklK0C2NkHJ4Ev1DbekboBTuLVXflJ8Bdmg=;
        b=BEsKws3WLmDjNmlrAP+oQXxE4nFag9IIJeQgrwlI5/R0fHGyUOr8ambldP//7wJL/k
         A4MUfJIjs4cUsAyuCi4OVoY4Kk4c1g08diCy69XoS+RWj4XGJQ8t+OHs/PZU6RbI3MtJ
         R+yQXymqUyI83kCzYLOU586ZWB9lGb9SAzx6OYRQ9nmUe7RhlEvf2W5jLlIHSVhmF97V
         GbktzsKGzR3PtXIIUzt6qcE8jghB5pcoaPxjW3CIsg5BPmf9IAiNXn2/Mv+rHxSntwyp
         qWXKPnG9ns9QwTqOtGMmxcaGIOyZPPgACrHaP5xez4HXdm9BH1Oi23YZxBmhbiJXK/Vq
         YmUw==
X-Gm-Message-State: APjAAAWMIiXBzCfHnDFQopP0gpobfvSRmfe3Hyme1qdg94R3GWHIrMDV
        oewafWSZrYNNBCGHoO8e8GlvIg==
X-Google-Smtp-Source: APXvYqy82naI/lVAZlOJvZdl3C/jjyr3KkWwvalv9/HybDbYSHFf9yfSUJEYY3U/VEuNZhjYcVENGg==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id x13mr7344279pjn.97.1582937496771;
        Fri, 28 Feb 2020 16:51:36 -0800 (PST)
Received: from google.com ([2620:15c:211:202:ae26:61fb:e2f3:92e7])
        by smtp.gmail.com with ESMTPSA id y16sm12339385pfn.177.2020.02.28.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 16:51:36 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:51:31 -0800
From:   Marco Ballesio <balejs@google.com>
To:     tj@kernel.org, guro@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, corbet@lwn.net, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, minchan@google.com, surenb@google.com,
        dancol@google.com
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200229005131.GB9813@google.com>
References: <20200219183231.50985-1-balejs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219183231.50985-1-balejs@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

did anyone have time to look into my proposal and, in case, are there
any suggestions, ideas or comments about it?

Marco
