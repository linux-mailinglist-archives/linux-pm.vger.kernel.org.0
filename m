Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6532630F201
	for <lists+linux-pm@lfdr.de>; Thu,  4 Feb 2021 12:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhBDLYZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Feb 2021 06:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhBDLYS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2021 06:24:18 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59973C061573
        for <linux-pm@vger.kernel.org>; Thu,  4 Feb 2021 03:23:38 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id f63so1907820pfa.13
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2021 03:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kWktwHkmNgbcrakKHA5kohP3/z9DUgGEOz8CKK3eeS0=;
        b=DgduVr8cJzmFsXHxTvzZFKTJ2Jza9sJB0Tqh3chYu4pQENxomVBAM2I84I9xAKtqrX
         zXC4x3T/8Bo/fOih9/nCZVnk6GA+bUljjMJsaFZV54ABRJOK3GrmXP1bRN1fgl74OWZg
         ttf+CDj5QkxAwpVvw040NYGDReKKyNbTw3jSlD8qkGKbpX2pijzcGgBUJoWHWSgno6/g
         qI2ZyuckNSI9aZbNse3gE4MEZ7TpVJAuoXlxxzQ9PyEF+i2fNSfnPNybW2+/l5jugChq
         qNXi2paUkp2O9q7P4lnWvnTVdjqtZkftEts3re2vnptNOVy/udWm3ajyPl5stbVGcLAl
         uwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWktwHkmNgbcrakKHA5kohP3/z9DUgGEOz8CKK3eeS0=;
        b=dbBVLK5qVTRNburh56AEoJSLjZEl/AL3GEgn+bpNnNZccklMVnntaB7sadV0xPQRVb
         axbhG5Qt2A2u96p1/hkzr/+PckejIe677blqciXgNsEyhthiQ0m5gbkQuP05i+xqeFWg
         7RgAx+CAumhEW9spqUlpZAPPicgFPdCuaopTHeZKXzfkjDB2d/Qur0KJGL1uamXrUWHz
         sgtxOJ8aFjdywJkVorZbii5EkpFvSsZPG/eyzQnySAYyIV4XHNp0y3UtuGpRDqkuuOf+
         tS8+F7N6Rp+xZr0+Mk9Ge6SWmhxug7C7y/QZNTnSsQs2ZmasJmbyW4YNVBZ9nLGPRFiw
         YRBw==
X-Gm-Message-State: AOAM533rxUUCbLThLmbJ8x7Ha7xCwyEcmubfqFr929xrM4onyRf6TSKe
        RWhrHrMENRX35WCtzfUG257nXQ==
X-Google-Smtp-Source: ABdhPJz2/skTqDVjYgyRSAEPr3+lkCmhFQf7c13jBGOkXYVn/svO6CGmftRXcBH+sx7oyHXa9oqsDQ==
X-Received: by 2002:a63:bd4a:: with SMTP id d10mr8429807pgp.18.1612437817964;
        Thu, 04 Feb 2021 03:23:37 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id f76sm5160507pfa.150.2021.02.04.03.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 03:23:37 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:53:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v6 0/3] Add required-opps support to devfreq passive gov
Message-ID: <20210204112335.wcmhgleh3vpts52h@vireshk-i7>
References: <20210204081424.2219311-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204081424.2219311-1-hsinyi@chromium.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-02-21, 16:14, Hsin-Yi Wang wrote:
> Saravana Kannan (3):
>   OPP: Add function to look up required OPP's for a given OPP
>   PM / devfreq: Cache OPP table reference in devfreq
>   PM / devfreq: Add required OPPs support to passive governor

I have applied all the patches with significant modifications, please
check the OPP tree and see if everything looks fine.

-- 
viresh
