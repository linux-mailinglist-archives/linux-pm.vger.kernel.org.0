Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4A7160F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbfGWK2q (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 06:28:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38513 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388963AbfGWK2q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 06:28:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so10391107pgu.5
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2019 03:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZcYL9/P3n49g6DqKaLI+RkNcE4jpTV+/tkfkwu+pd/I=;
        b=VICLIGiHz6hhtuPRSMN0Rn4Tq2DcV/1P1Ybg1HBXsAWiuA6vj61xyt0mLNzXme8kX3
         esV/scccE8LpryajCPPfFBXnjPrKeAfJpPYYXOO6IW9+HYl4svcS/Y5bpmOLY0Uftt2S
         5lFx89MMXOr21qlPkt4ka9KBp2D079ldrslJgvwcjjuyjPrGHOzlrlivBj6mjXlhxhWI
         ZpgzNr5HE0JS+u9CBkfSQoBRLij9HcAJ2Lv6cVc+74Qo7Ost3lLBR8f8Djm3dvW2bg31
         Sog1WcS19jK5z/9s31Oghgd2HpIL7BrU7MLg369l9M6T43hRdswMk/ps9QRPkTFIm1pr
         9kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZcYL9/P3n49g6DqKaLI+RkNcE4jpTV+/tkfkwu+pd/I=;
        b=bAUljCH7X2J8DIQAV3Ekx5qpoTVGtcc3jSU6/hy1iTqmM2pXJEBp7kiGjnB4ZVeAbZ
         qT9AUboPuKjO8bwNhLbWi2yjK1O4Y+P6DRPMZABKYcwR2IHovKkVxBoW+SYaQSHwkMej
         ywANEiCCMd/WpMawTcQfKUisyPOvcXGMh10mRRhZGhKp4O1DcqvY2N5xnROupUTHXuT4
         4Kl+tirIv+Mp26pGvCEkaJKbTn4y08nGRRO1blPfzGWzaqiaptOqYtaygnoHG/ap0C7a
         YewAM3lLMPOBi40nA3MX6x+FWLAgVAtgcWXMxYfCO8aq4/9kgabwDv0igJmbd/GQnd6V
         0TCQ==
X-Gm-Message-State: APjAAAWScW09x3e0ATpn8A7iNLzkLewNx2/LNq6rTSjJUPfyJ1Ug/lFY
        cfUNKWRr90Nmf/G0QEuXrMyB2w==
X-Google-Smtp-Source: APXvYqwxsaovs/FNtGL33P4TAqXSECDawb04HoVxvIb3gVkUD3njtpvqpCDo33LTTPS8jCX086ZLPg==
X-Received: by 2002:a65:4489:: with SMTP id l9mr78187922pgq.207.1563877725327;
        Tue, 23 Jul 2019 03:28:45 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id o24sm80368031pfp.135.2019.07.23.03.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 03:28:44 -0700 (PDT)
Date:   Tue, 23 Jul 2019 15:58:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>, kernel-team@android.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20190723102842.t2s45zzylsjuccm4@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717222340.137578-4-saravanak@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

$subject doesn't have correct property name.

On 17-07-19, 15:23, Saravana Kannan wrote:
> Currently, the linking of required-opps fails silently if the
> destination OPP table hasn't been added before the source OPP table is
> added. This puts an unnecessary requirement that the destination table
> be added before the source table is added.
> 
> In reality, the destination table is needed only when we try to
> translate from source OPP to destination OPP. So, instead of
> completely failing, retry linking the tables when the translation is
> attempted.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/core.c | 32 +++++++++++-----
>  drivers/opp/of.c   | 91 ++++++++++++++++++++++------------------------
>  drivers/opp/opp.h  |  5 +++
>  3 files changed, 71 insertions(+), 57 deletions(-)

Here is the general feedback and requirements I have:

- We shouldn't do it from _set_required_opps() but way earlier, it
  shouldn't affect the fast path (where we change the frequency).

- Programming required-opps for half of the properties isn't correct,
  i.e. in case only few of the required-opps are parsed until now. So
  setting of rate shouldn't even start unless the OPP table is fully
  initialized with all required-opps in it.

-- 
viresh
