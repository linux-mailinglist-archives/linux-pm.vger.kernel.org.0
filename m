Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219541C4CB5
	for <lists+linux-pm@lfdr.de>; Tue,  5 May 2020 05:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEEDiV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 23:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgEEDiU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 23:38:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA7C061A41
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 20:38:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id z6so261460plk.10
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 20:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBwKtkgcj7e3nr8p0Kt5Si9efTL9Ko6MemGJAknCtRU=;
        b=SwyhJPUNhCcc7Tp4Jp7nd/nAqeRejEiNeEGtWuuX7TZ22IFY86p2KuTYasfPuh9fys
         epsXKL0C+e63zY3sqCXmUBZwl2XuiFE87/HWQ7VsDUKhU+7sHSoXc7CdrwvHEZjY94+h
         hJWUn/YxzT9Z0N12I4nbO+eoWm31RL04sSOuHWG5FKJf83kMSAI/OzLdcfGr3uRgMolm
         UtNgXgZr6tlOh08IDhoZ7zvO02iIlVDQGzunbXFTDemrwtHI0Bx8faVAcDZQC5v8tUFR
         +Van6kAal4wXxATTiBVnnZdDJkP2lyEsjFmSIPFscUytZFmIG/GaMOuQ7+/9rsAtiY/U
         j5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBwKtkgcj7e3nr8p0Kt5Si9efTL9Ko6MemGJAknCtRU=;
        b=JKq1rjgD/8WZfDcCMKeDoueCl0gtdQLU675PyHKgKfGcVf0HUi8EhJn5z2g+f4QO+h
         2w9nRng+Us+K5FN/RkDknCYGGw7u3yJG1DU1CUGEcSFHWKWAUwV9iDPUQiwZR1iwIyjM
         v708JoOnV1L6vZ4grgvtyHBw5MpBTppwKXSWeoHlwHde47UIGVrzggXi00pMLq8vtq1m
         6g04myDz8cujmBMTXRa+OO78cPIbpVBV7DM6nMIlzttN8PGlFpEDRkSMrCrFhyNvESvx
         j/GG53WY+FBV0PJtBpZnDcOPrBVEYUpCWFmdiajgTJFCa387qXIwLe3uMZQ4fg4LxMbu
         ONvQ==
X-Gm-Message-State: AGi0PuaRGlMkJMmAdNpSaBgFvf7hPjVAuh5yAPI+zSmOyP8uRos/vYK7
        G+iferV+y6zu5Ajv2YICXmjGkA==
X-Google-Smtp-Source: APiQypLicexy0ehqN8xOj3LloaEOyPRjQ2nyZrfaqjqvvZbZfaw2Ycgy1LAXgKlbnmF7NhSiqpM/Og==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr442033pjb.59.1588649898205;
        Mon, 04 May 2020 20:38:18 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id p19sm543124pfn.19.2020.05.04.20.38.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 20:38:17 -0700 (PDT)
Date:   Tue, 5 May 2020 09:08:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 6/7] OPP: Update the bandwidth on OPP frequency changes
Message-ID: <20200505033815.kz7mhjmsbkaux7av@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-7-georgi.djakov@linaro.org>
 <CAGETcx9iAJRW9Y9orHNF-fC53nNob_vZKYUNEpwf_AeAdWCOjw@mail.gmail.com>
 <20200430060901.j7jjw6soo5h5xoul@vireshk-i7>
 <CAGETcx_zH_KJ7_A7Ofc2M5GfHKX_J__URJB127MSMcTeaqyzjw@mail.gmail.com>
 <20200430075356.rjtctfuenirvhxgn@vireshk-i7>
 <CAGETcx-W5XjNtgjDz2Ma_miN=cUBb5LFfhzYtKRpf6iAi4bXNw@mail.gmail.com>
 <20200504050017.nsd7fp7gtxxwt3d7@vireshk-i7>
 <CAGETcx_3ZrTigJ+CxJFA+N1xZaG9Vg6m0egew+kb-h4jSMsk2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_3ZrTigJ+CxJFA+N1xZaG9Vg6m0egew+kb-h4jSMsk2Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-05-20, 14:01, Saravana Kannan wrote:
> Fair enough. But don't "voltage corner" based devices NEED to use OPP
> framework to set their frequencies?

No. Anyone can call dev_pm_genpd_set_performance_state().

-- 
viresh
