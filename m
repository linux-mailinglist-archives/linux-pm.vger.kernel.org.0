Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B019126C122
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIPJwo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIPJwj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 05:52:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F235C06174A
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 02:52:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so3622883pfg.13
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sJeQpySpr2/Cg7PhopRLYFwLmukLvBLeAiNxpR8vIw8=;
        b=ZBC033qR/zJT4vCGMRQTH1LWGsTCF9TB8cEQHJXwHZuSONSUItbX+VLqtRA3Vhngem
         pFtScUlyKVWRSxANtli1MfeIjPYB64qklAPpysZQ3IjEeob/jADBx4JUWCWaaoXFAfAA
         Kyjr1PPVotHWPMt21luVQNqc532NUHDI95RbUi27FSxvKCUJhmpl6KBQTz61fjmPMlyE
         4782j1Xwb41P4BGDDORNXPHjL/InNboeZbmRMmn1s0WYT0MVWem37k/H8g0jI9PTSQ38
         du67ll0dojCMp+eoMtnQyRR4zVHAoOOpJuW59VVtciRv3NOWT7QFY3o/T0GAbjw80RLN
         Ix0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sJeQpySpr2/Cg7PhopRLYFwLmukLvBLeAiNxpR8vIw8=;
        b=dH4OnEseVRDTihTmsJ2iUV9TbPhu0mPxcZePpQpOuuM7YkNCynrblM5K6ufiB/ueCq
         Wi6gTjdTE+2Z0vYqXx7WcYwGnQ+1+QEG9ygfqGMfXAvBO9e1CCH04iv3TZ8ShEhWSZyU
         Klrlsrqsn9Jcb9gB3pqpNqEqDloDxPIAkFDgMPXrUPEaQ3K/iu8+1tfngNd8DJbKE1pT
         lu4OnbDSlIjd3X/TgE6/1XqllZlG1tJMNorHAaGUMbiK0vI+rWcyzK5dhRN8sz5mO8CM
         1Z0ZpirXXU16aMCAJSTRFoYV5mh+K9wjDtQXg0DqycehfHUNZ680/BueTI6UIhMQf8RW
         Aidw==
X-Gm-Message-State: AOAM530CwbMuqvHTI7DyEduLoqaBH7VXN+e822m90os+px55bvS/dJGU
        BycpRxeICBMbGYjLBZS6Ja8OIw==
X-Google-Smtp-Source: ABdhPJwzZFOwCUCV3nhWvQGjFOjBueE4nd5EViKbUhIu3xcHb87/vja/HKPEVo/JJBpn+EZRQtdobg==
X-Received: by 2002:a63:e057:: with SMTP id n23mr16800523pgj.87.1600249959118;
        Wed, 16 Sep 2020 02:52:39 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t24sm16538902pfq.37.2020.09.16.02.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 02:52:38 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:22:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: qcom: Don't add frequencies without an OPP
Message-ID: <20200916095235.gixejqmyt6ajj5as@vireshk-i7>
References: <20200915101007.1.Iebcd373535de8eb0aa304ad22b062a5bbc88a665@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915101007.1.Iebcd373535de8eb0aa304ad22b062a5bbc88a665@changeid>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-09-20, 10:10, Matthias Kaehlcke wrote:
> The driver currently adds all frequencies from the hardware LUT to
> the cpufreq table, regardless of whether the corresponding OPP
> exists. This prevents devices from disabling certain OPPs through
> the device tree and can result in CPU frequencies for which the
> interconnect bandwidth can't be adjusted. Only add frequencies
> with an OPP entry.
> 
> Fixes: 55538fbc79e9 ("cpufreq: qcom: Read voltage LUT and populate OPP")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Applied. Thanks.

-- 
viresh
