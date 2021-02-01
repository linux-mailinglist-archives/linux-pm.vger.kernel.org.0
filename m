Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8477A30B126
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 21:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhBAUAz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 15:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhBAUAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 15:00:46 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA9AC061573;
        Mon,  1 Feb 2021 12:00:06 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a25so21211080ljn.0;
        Mon, 01 Feb 2021 12:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hOzp9dKg4UKG8FZldWN87A/tbuRpEsmEZrrD9v4UlfY=;
        b=qJHCqmXK0dlvHHiKZLnBwCSoBZd2EogJkmkxRGCF4VYmCi24hw5Tt49uekvQg011A2
         +MRUotGhfysCLwHX57RQHg6F7c8tmOoKXhycD1ar7tlWkSYDMEwggkc8lRR6u2pOzTvP
         69pDpJMO/9ctm0WSLf/LOuGycRxzyVmgh0uyN4HEBKlTAPihgb76h06kvzDS9rddGT7x
         ZsMtXEtMJftI6eoi832IkbSk3qOVd45dX3ybc5MwDGK0hFwe5wyPxGAmPvtYDKEolrRY
         54XfCx4VNfLZxk/8CyAGNpaprXcmeEzgOHje108LdK+7mvPUNZtsN5BjEnDoGDtre5RU
         oHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hOzp9dKg4UKG8FZldWN87A/tbuRpEsmEZrrD9v4UlfY=;
        b=oTH3uJTjPEWw6R61RjLV2magcG7s7v6gh0taydvk8fUEcbONo28yprzkHXjVu1vUnT
         qycsXnbvuY1+NAkj5n2TK4TEFogV3HUE6dnIHFVs4nGO6MEvb+nzJa//lmkfKLvygtCo
         HOVCOK/RDUwgXhn1KWUfRLI5fxk9t/VL1KdcEiNqOYTT8yYGcCTrvKWhPhqN1c40fR9e
         V9apn8CfGNdTFi/GBQ7AoQ5ozvnM9EzowusSlZOop1oXKewgXmf80rpA5s0n1WtBE6sM
         bZDwEsQtX8+ESdAeBk6cWD4asmmlhYhCoHsEINYBjd12AfhVrdefAm0YUp4u1y6gtYnk
         8y9Q==
X-Gm-Message-State: AOAM531PYAtIiQ+8PPEv3QhLkeInQ8IgL7tfg0AI4APmNvF1TE24gBy9
        L6F1TTRIUApFIEME41mzZLZuHKDL8Io=
X-Google-Smtp-Source: ABdhPJxYXOWJObqy82JafN2Nb8skTfPNIa+gbfPcp3gwGnUzaUeUJqrjHHT3/I4Yo00XrYXUxIZbcg==
X-Received: by 2002:a05:651c:1114:: with SMTP id d20mr10765983ljo.396.1612209604533;
        Mon, 01 Feb 2021 12:00:04 -0800 (PST)
Received: from ?IPv6:2a00:1370:814d:ea25:a10:76ff:fe69:21b6? ([2a00:1370:814d:ea25:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id 134sm3076810lfm.205.2021.02.01.12.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 12:00:04 -0800 (PST)
Subject: Re: [PATCH V2 3/3] opp: Add dev_pm_opp_of_add_table_noclk()
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
References: <1b58a72fa4d6aadc9542a66f8150150534752d81.1611817096.git.viresh.kumar@linaro.org>
 <a251d7a7245a2ded97b282b8dfda95359698bf22.1611817096.git.viresh.kumar@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <72a546c5-8a7b-af8c-43aa-5344073f8623@gmail.com>
Date:   Mon, 1 Feb 2021 23:00:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <a251d7a7245a2ded97b282b8dfda95359698bf22.1611817096.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

28.01.2021 10:00, Viresh Kumar пишет:
> A few drivers have device's clk but they don't want the OPP core to
> handle that. Add a new helper for them, dev_pm_opp_of_add_table_noclk().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Split this into a separate patch.
> 
>  drivers/opp/of.c       | 18 ++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 24 insertions(+)

For the all current/latest OPP patches:

Tested-by: Dmitry Osipenko <digetx@gmail.com>
