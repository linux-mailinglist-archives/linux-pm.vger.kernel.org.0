Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7BB3ACB03
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhFRMdD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 08:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbhFRMcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 08:32:31 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B4BC0613A2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 05:30:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q20so16450609lfo.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Jun 2021 05:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/hgJ/IpeM8Acz8X3cETsndAcP4SBtdB2NKP7XSPmuyU=;
        b=cKWBJL/pN9U49beNK74dbR+9dM3IEiiUF+Y662z8bgKBTHLYyYAWejz/NqTv1lywAQ
         DYEcil/exwH365+/fBO/So5bN4PoOf761WJ6JMs6pssnMceLY16xh6++nHbDmuB7Bibr
         ZTxErmPhqDvrjN/L+KD/l2Wvw1zxIKOmzHwu6eFMbHXLChw/r2Ahy5unr4rYClZjzdZc
         9fxBqNbjpgb9MFZpLHteYIcAOjJMs9Y0ayyw/u/bNolCrD11dihaKauPDpQ94kr+GvEE
         2pt5b3GPBinr4MFxJ72LYD13HR/vqVmxzPScohecL2KHqprjYiW8faLB1zjcyAE2b2lw
         SQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/hgJ/IpeM8Acz8X3cETsndAcP4SBtdB2NKP7XSPmuyU=;
        b=KukQ63G1Eq5GxFLTxNL990zKSRrn4Nke/xZTTacY7MdA7CYC3MsmGs5JbgMGEF4cCv
         /1w+IwW0o6wJNxr/DQv6nxnqnXxRyAvIrNSZMaqDufpYzuXhdNlkQ3h58q4bVzDWQXw6
         aApDx6Z/yJPxdCEI5rA75IbDlEiaCMNQKLCrfPF7wfLf5KWwPLpNJwRljW/7QXWeIEWc
         dGeHWbPRJQYzQxP37dnZzKgzG5EO5c3yuXMIwwgF0ENPF/S6QsPeuXd2ehDqZ4KkPqia
         wexH9nv64+FpNYS2ZsYD50jiR5BssY4R1WbRIff8EmxLKbTq4cZ7xLheacTDCQ/sj6ds
         C6uQ==
X-Gm-Message-State: AOAM531GtUzCfszRtbZGDRSh9pME+Xyl85Q5pNzBKSuMZeXt2UcuydMx
        1gSWNtAaqhTvpHnMpesFntefH4RmIf4=
X-Google-Smtp-Source: ABdhPJxw8MefQjlI/sbiM8qg7tBlJ5eIzTpC1fEZvqPJvCTKiBA2SCPEcfmjhI48ih5FFI92kndGOA==
X-Received: by 2002:a05:6512:a87:: with SMTP id m7mr3026269lfu.30.1624019420816;
        Fri, 18 Jun 2021 05:30:20 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id i124sm897281lfd.62.2021.06.18.05.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:30:20 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 15ICUHMR010732;
        Fri, 18 Jun 2021 15:30:18 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 15ICUHmx010731;
        Fri, 18 Jun 2021 15:30:17 +0300
Date:   Fri, 18 Jun 2021 15:30:17 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Martin Ashby <martin@ashbysoft.com>
Cc:     t.schramm@manjaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
Message-ID: <20210618123017.GA10695@home.paul.comp>
References: <20210218124250.128008-1-martin@ashbysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218124250.128008-1-martin@ashbysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Martin,

On Thu, Feb 18, 2021 at 07:42:50AM -0500, Martin Ashby wrote:
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		val->intval = cw_bat->battery.charge_full_design_uah;
> +		val->intval = val->intval * cw_bat->soc / 100;

Are you sure the chip reports current state of charge relative to the
full design capacity rather than to the latest auto-calibrated full
capacity? That would mean that over time as the cells wear out
cw_bat->soc (PROP_CAPACITY) is never going to be reaching 100; does
this match your experience?

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
