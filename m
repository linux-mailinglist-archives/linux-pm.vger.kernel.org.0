Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D86A470
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 11:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbfGPJAM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 05:00:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38662 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfGPJAL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 05:00:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id f5so275600pgu.5
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lkUFnw3tfRAr3e/K9WKPjwIamFFWJ4GH53aBPdA3SN4=;
        b=iE9qoOLowk11gGQyNUKy6hX3dzsZULEYSEE9OPgqI7mSLLicdUlU32aTXLzaosOv7o
         Ps4O6zFWL2zCMd3qvOz+NPOOvxudpA4ZoNz1iW7Kfm742WMhzcJgBCItjvxhdXUFEpyJ
         q1nV6IR/pVSafAW3UgifsGzWyaCK13P0JoqyXGZf1ENQ7sW90oBo9k5SJQtD9weyR/nM
         F6NcPidmAxKSquh6UC12UiEPXBGITyV41xeCRd0q7nCLS66gdldBCos0dPIjm88xzghm
         mu0cB9pSTFbkVmGX1VOZzW3LHyZtMnr/kUgpnQ82ctfG0dTDhC3nwPBAwZiAkRnO8wZh
         OCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lkUFnw3tfRAr3e/K9WKPjwIamFFWJ4GH53aBPdA3SN4=;
        b=ahd29nHbw2lhgUuxLPrcDIW7dhE9QZp8+smnmv6CIr7p4VE8s0O8AEw0yxwMSGrSYx
         kVLpjzMCOF2oAK1/Ipi93slPHQzuWiLplKhIANs2FiOJ23vpw/73pNA9LoedVmM9rTYG
         AheoBM9gCPytGbGtDkZjIYcwcTt+PBqDLyQpwN44jICaLe7hRfbJaOEKwf+npRc/kLlG
         LiHcSyTLd1C2ZHkE2clgYFTSWDJbsxeT+JbLIQAP4vgmek1lP9UqUJCKSKh8k1bFOR39
         BTe8+OIo4kfMxuEhfjGWlhsKSSdyyqb58HkDcmvkZGfypcNdPKCKVbdDuEnfpB+ySgWE
         qd/w==
X-Gm-Message-State: APjAAAUO6TEUWxDFkx7UderxNhWNbgIJho4+nLIfdT4DLdHrWPEy0J8L
        zalHDEjCcP+fSUjpN1Ghxc7AlSXgF3s=
X-Google-Smtp-Source: APXvYqyRYVnjwsmXfuDGrvTUNw/8KnmANGhR7WhUa8xiZz7T5T2fm77xuJxrapWCLvklzQ79FgDmQw==
X-Received: by 2002:a63:6c46:: with SMTP id h67mr22406939pgc.248.1563267611013;
        Tue, 16 Jul 2019 02:00:11 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r6sm12769971pgl.74.2019.07.16.02.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 02:00:10 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:30:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     wen.yang99@zte.com.cn
Cc:     rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, mpe@ellerman.id.au
Subject: Re: [PATCH v6] cpufreq/pasemi: fix an use-after-free
 inpas_cpufreq_cpu_init()
Message-ID: <20190716090008.pgddadjzribgbaxw@vireshk-i7>
References: <20190712034409.zyl6sskrr6ra5nd3@vireshk-i7>
 <201907161626465333445@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907161626465333445@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-07-19, 16:26, wen.yang99@zte.com.cn wrote:
> Okay thank you.
> Now this patch
> (https://lore.kernel.org/lkml/ee8cf5fb4b4a01fdf9199037ff6d835b935cfd13.1562902877.git.viresh.kumar@linaro.org/) 
> seems to have not been merged into the linux-next.
> 
> In order to avoid code conflicts, we will wait until this patch is merged in and then send v7.

Please rebase on PM tree's linux-next branch instead and resend your
patch.

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

-- 
viresh
