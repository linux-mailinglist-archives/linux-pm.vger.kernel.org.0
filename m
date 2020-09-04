Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6376B25D09F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Sep 2020 06:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgIDEi6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Sep 2020 00:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDEi5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 00:38:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C9C061244
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 21:38:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so552249plk.13
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 21:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKTidWnwKMw/87YvP/dGXFFvii+sZrfhQX2pdgUJdtI=;
        b=DQf1WCSbvh8LYmj1RwJAM4L0XhBwekQFu+N0ulyWtHXptKWrBc+L2xqTlrjd5HhEhA
         KVjTkQBP8cwtzBx7YKImywEPPFQkmci4NSjwUr/Qt8YcnDxekDfTyKn81efv1iEgmXgX
         pYnkSJEvK+ssG5qzqL32QBuqIlP4Iw3X0OlXlZbB0ExyCtylrZDFcnB8PzrYz3MhwLyt
         WXPdPr/oJqEqnSk3Px6R2I61Paysm6hrM4AjMXSdc4XYxaMI8IVarnbnxoiIta2dq2Jb
         emFreT0HlGa1M4SB8fm8E3F/xs86KWYwY2Gmcdra0JeBz4LW/VCg8qOYPJNS5SFaqN6r
         BBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKTidWnwKMw/87YvP/dGXFFvii+sZrfhQX2pdgUJdtI=;
        b=WAQgMp4piP/sw/OGiXulzv6yWdW0CImbynWmCn7g5nd4rRV+ziMyUzww09VLYD31Sw
         sAbU+r2k8Mu/nyGbfny9Z179eh4Sjv6nEvRs6d+X88SOVHsifF5eFMC6/kwgq9SEVD5r
         lJLT0dU75uJY3369mdC0uqIxtH6nfEj3BQmf2SpRO3p2HoPfJDz7KpLVuSmt6sSdKdVD
         v9hKzF1WrReqhsCpqz6ZUH3+vMO4QhJuVArvtwLNFaEKmDS2tfcOVXPykkbYdGMv9KAD
         eGIavWsm/Z1xl6br43/0L9z+zZmGrYMkh59XRO4fUP+VhcHkW76oNxYXjJHR+UGmL7hp
         Yf2w==
X-Gm-Message-State: AOAM530tL2EHcoYsMK+Gu4k2gx7Fy+abXKIduIqCqb08ommHsootimrO
        6DJOHj7KwHrYmItLPmiWZpEDNA==
X-Google-Smtp-Source: ABdhPJxTg37soXGgDTI6jsVCoUh0jZdyWwZdRnirV7gCcasqpJbOVIuYIA43vleVX2nA+Ln5g5brXg==
X-Received: by 2002:a17:902:7606:: with SMTP id k6mr7287372pll.171.1599194335296;
        Thu, 03 Sep 2020 21:38:55 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id f10sm990844pfk.195.2020.09.03.21.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 21:38:54 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:08:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] cpufreq: improve frequency invariance support
Message-ID: <20200904043847.g4ss3o4uofwujnyk@vireshk-i7>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200903133203.GA29370@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903133203.GA29370@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-09-20, 14:32, Ionela Voinescu wrote:
> Hi Rafael, Viresh,
> 
> Would it be okay for you to apply this series, as the majority of
> changes are in cpufreq? For arch_topology and arm64 changes, they have
> been reviewed and acked-by Catalin and Sudeep.
> 
> Also, please let me know if I should send v6 with Sudeep's Reviewed-by/s
> applied.

No need to resend. Rafael will apply these with the tags.

-- 
viresh
