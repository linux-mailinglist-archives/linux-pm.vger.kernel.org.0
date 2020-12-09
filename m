Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8195F2D3B16
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgLIF4O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 00:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgLIF4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 00:56:14 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9384C0613D6
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 21:55:33 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v1so291944pjr.2
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 21:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e+/KQo/7uYAtbWbl+7BBpmpDWpKdkf167C04AOH3Dok=;
        b=JX1CgT0rcU5I83EAMxlQQlIn2P+TZTwzT8eH1WZazen5EDzUw+Qypzs2cPZSnP5Zgo
         bQ68RYrm2IrLIekpTJJYqgg4cRU1jJKExl0lfDXeEBFhc8pK8RmfSZqx/bWjwOGlxMwE
         isiZakFhiscmIhH3DMi9tYMwpcUGMn84frNV1t/BZem5k0zmESMocz3Q3tgUWvsYF35L
         C5ngT03ykjA1NLBnvPAss2j/2tMT5JdLoznFzCG9xaU8eYGKQXv4AUmxcxgt2NWAlHuO
         McIPYcgetMPGoOBgD79WqB3h1mzsQQEgrVdASSblYbUAn6cWFtV5lO1oJCI7DxIe2MM2
         Dwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e+/KQo/7uYAtbWbl+7BBpmpDWpKdkf167C04AOH3Dok=;
        b=dUVOncgB/SSqAxrjiJAHn8slXeMGyKZrqhDsem5NqwwNmzYL5tK03cLb937S5hyTCV
         DZ2W1aWN993o4xuN65ZWo471eYb3L3qkOla1x4Ofwt8jP699so4l1zwzUYqKajXT1+qc
         VYGGQF3AGFf42QKXWlsrD2IrJ+sl9j2tzv0D6BvHqBF/KcPyWm0hPgZZ1lNfYnWOv2xR
         SXQgY5If6dc0V7A3aV+2Vlsh/rzWqPC3Y1FLSwNuHMYjyRmnWjedYccIBMoo/zivXK27
         IGaxxXNQjGT6o+l0rrxExNRN1T1kfJFfWUBjuLFTNd6pCWXPJPAAvGQSfhBQMUBry8rh
         famg==
X-Gm-Message-State: AOAM532gkmIWymMOZzmM3LIyeCsf4tMOa58/g3ADrVFsG/CPSeH1UO7W
        1hL3l6ld+5ZES4j8DhWd40fnjw==
X-Google-Smtp-Source: ABdhPJw/8dukRiEihHvoiCsLY5JEfe36xkD1kg7KpFx5zfiiMEXG33LbbGxomBfMnr+8CmGdVnoZWw==
X-Received: by 2002:a17:90a:474c:: with SMTP id y12mr595152pjg.175.1607493333244;
        Tue, 08 Dec 2020 21:55:33 -0800 (PST)
Received: from localhost ([122.172.136.109])
        by smtp.gmail.com with ESMTPSA id u24sm827666pfm.51.2020.12.08.21.55.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 21:55:32 -0800 (PST)
Date:   Wed, 9 Dec 2020 11:25:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com,
        daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com
Subject: Re: [PATCH v5 0/4] CPUFreq: Add support for opp-sharing cpus
Message-ID: <20201209055530.gadaie5lttpdprc6@vireshk-i7>
References: <20201208174229.24323-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208174229.24323-1-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-12-20, 17:42, Nicola Mazzucato wrote:
> Hi All,
> 
> In this V5 posting I have addressed suggestions on opp/of and scmi-cpufreq
> driver.
> 
> This is to support systems where exposed cpu performance controls are more
> fine-grained that the platform's ability to scale cpus independently.
> 
> Nicola Mazzucato (3):
>   dt-bindings: opp: Allow empty OPP tables
>   opp/of: Allow empty opp-table with opp-shared

Applied these two for now. Please rework the other patches based on
the feedback given on the other thread. Thanks.

-- 
viresh
