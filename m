Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675C633DA8
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 06:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfFDED2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 00:03:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfFDED2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 00:03:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so6049332pls.13
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2019 21:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f+q8eC1oiPgskruXaD+lspZshT3DmysyCU4e5tlyJjQ=;
        b=PiqMpK43hy+ZR1dHjSMjo96+17tuIuN5HH32kvTcLbSyEtz417yLi/xM2Vwho6JqM4
         1lGnBHIw8zkZJun7qWrPkc2vbORsLIlvB2I/4P0zndCq3csZylWmWq+7zA4RpaZq5Yx/
         zCjR21x2u0bOtrwfKymJzTptoNBTTv63izIHleLACD+2Eud5Nq2GtoejJY+ZW8/zzzrv
         WllsQ9qulkia+37jLN7algupIoPuUy7/VgtNbaY23XAOfmKrzObetXyXz0xtP/79W5Bq
         mbSHWqZACJ7FBI1aaUDsg2YH9Aj6Magje6JiHRHoyGRJx1snURU3rjECHPe32HcDYO3q
         FHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f+q8eC1oiPgskruXaD+lspZshT3DmysyCU4e5tlyJjQ=;
        b=AnP6tzzMk0sgeUPxmRwwe7w9jXFpm4yhmLD/qtxwN8RAFq0/kj8SBHME1fnqaBvKP/
         LPlgBUE7HCcGtKTYFX/Pj0huwOXsXuip64pahsMSF8N+Y7mRubBxTilFtvLSudSyLt3f
         hcIB0hWqMkxstPtHuSpxx+MgCNKaGgvza6LM75RlHuG06qRp6h/UR5f80kPDmRpRFRCj
         CjMZHIrCg80WLyrnxhvutDHR0LQyioglojHI65YZO/yuQZHl38/6mhVu3kgH91dddN/L
         2fspNq/OvtZf4mE++m7nt7AusmB9Ko5xuuDgBeip8gMnAi/KO0ft4AqumxsGWvtIwbV7
         +W4w==
X-Gm-Message-State: APjAAAWujEyDce5Dp72ARpufBIXByMYVxHRKZKuDtXJhH+yACIA6t2r/
        iopvaOmlDu9kDm1kOaoKyFGi9Q==
X-Google-Smtp-Source: APXvYqwiYYNeL6yX8LBntiessg9e2/wQoMr5l0ZNyv/tZHZlDbqLoD3Gv+ai7+HDa9fvLwX3+pDpFQ==
X-Received: by 2002:a17:902:f20b:: with SMTP id gn11mr34004883plb.126.1559621007496;
        Mon, 03 Jun 2019 21:03:27 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id m123sm16735468pfm.39.2019.06.03.21.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 21:03:25 -0700 (PDT)
Date:   Tue, 4 Jun 2019 09:33:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <code@mmayer.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM STB AVS CPUFREQ DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "open list:BROADCOM STB AVS CPUFREQ DRIVER" 
        <linux-pm@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/2] cpufreq: brcmstb-avs-cpufreq: Couple fixes
Message-ID: <20190604040323.vzunculbiqgkemrx@vireshk-i7>
References: <20190522184547.31791-1-f.fainelli@gmail.com>
 <3734641.73qX0VsHyn@kreacher>
 <013ec7c0-0984-cfc9-ea3a-0180719f5ac4@gmail.com>
 <CAGt4E5tZ1YLbtCDJDXTTZrH5S4Jmw_BVOfz+i-KF=TUjA=yvkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGt4E5tZ1YLbtCDJDXTTZrH5S4Jmw_BVOfz+i-KF=TUjA=yvkQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-19, 12:55, Markus Mayer wrote:
> On Wed, 29 May 2019 at 10:02, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 5/27/19 3:51 AM, Rafael J. Wysocki wrote:
> > > On Wednesday, May 22, 2019 8:45:45 PM CEST Florian Fainelli wrote:
> > >> Hi Rafael, Viresh,
> > >>
> > >> These patch series contains two minor fixes for the brcmstb-avs-cpufreq
> > >> driver.
> > >>
> > >> Florian Fainelli (2):
> > >>   cpufreq: brcmstb-avs-cpufreq: Fix initial command check
> > >>   cpufreq: brcmstb-avs-cpufreq: Fix types for voltage/frequency
> 
> To both of these
> 
> Acked-by: Markus Mayer <mmayer@broadcom.com>

Applied. Thanks.

-- 
viresh
