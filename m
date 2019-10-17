Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4530CDA3F6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 04:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407391AbfJQCmF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 22:42:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407362AbfJQCmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 22:42:03 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so599359pfb.12
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 19:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w50KpVZhAwyoQK+bFJNDVlkqktJRIaTp8AHjS4MyY98=;
        b=wYvJATFs5UC+eRpmP71Wq2XbCsR7tcsWHcxFtdlx3c/ZSrm8bDgLAiP2yBfljypLH0
         jKTu0T9H+JxZgjiQCrFfL2ilZsRKKhNzw+ony7qUMN8c07VnWuTqlc/PHDNuRs3dKxtm
         vdkmkFyJ6LnEDEvXMJczBtvyQJ68Apm0HiZLT4Z95iPTJk2+Fu1c6qNv/mVoDZIlyhBr
         l+h9iFJyWXf+p11sj92brHslhxdk5mFiV16tMXkZVPag0e2XV57RukfnOLlyOtVK3DoM
         rnqnSE+IrVb7+KEKe9fOUzQsXPo07DOHEXynMuhZJtnw7CwNQ+XuCMCxGtOONbN2EpS2
         pNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w50KpVZhAwyoQK+bFJNDVlkqktJRIaTp8AHjS4MyY98=;
        b=S0JNAN6AY7BksQ/4h9m3O2Byf0cCEq9Vw5CIt3UUZJQXUlxYjY9DN7/n9O/wOhlGdv
         lGOtKGoF+771/2AXR30fQpObRA6DFpxn8SuvOfq9AOtoDQQLVT00M9ZWKdy0euqY0AjR
         i4ZofH8mRpC3v2o8rKeEhhtlIwv1zjvGPN/RgchL0qwwgPtdU+7ek7AR58EHOsw2Fqwf
         PEvy+wCegBAkm2pQ4Plh7N7cDXJCg4zq3bDp56+r+cn1ct3F6nUfBF8Lkxi1vL1QUmJV
         XPbSrgkay3qrq9pEms4WpQid/y2o60hSjiTqsUbNigq8U+2UlM7g8TwUH03eGeOw8XxI
         Tpmw==
X-Gm-Message-State: APjAAAUh02hqODKna3aXwCKMEdEAu5JcqEZWu+88sSP/VRECSiOvLE/5
        7s6JetCqi9btKHokxRJU2k9l2w==
X-Google-Smtp-Source: APXvYqy5bLPP7KyCo0QyKqOM7/aGjivBgkppI0PnQog7qm9zHjIGh6aAtVvKURTYzLJCTCNI22l7xQ==
X-Received: by 2002:a63:4e52:: with SMTP id o18mr1453491pgl.153.1571280122797;
        Wed, 16 Oct 2019 19:42:02 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id 192sm481026pfb.110.2019.10.16.19.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 19:42:01 -0700 (PDT)
Date:   Thu, 17 Oct 2019 08:12:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: simplify and remove lots of debug messages
Message-ID: <20191017024200.3hhak2wx7yvjifqh@vireshk-i7>
References: <20191016110344.15259-1-sudeep.holla@arm.com>
 <20191016110344.15259-4-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110344.15259-4-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-10-19, 12:03, Sudeep Holla wrote:
> cpufreq_arm_bL_ops is no longer needed after merging the generic
> arm_big_little and vexpress-spc driver. Remove cpufreq_arm_bL_ops
> and rename all the bL_* function names to ve_spc_*.
> 
> This driver have been used for year now and the extensive debug
> messages in the driver are not really required anymore.

This does lots of cleanup in this patch and not strictly what the commit log
says. Can you please create separate patches for remove ops, debug messages and
other formatting things ?

-- 
viresh
