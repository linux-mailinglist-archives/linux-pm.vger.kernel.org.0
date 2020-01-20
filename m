Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EDD1422CD
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2020 06:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgATF20 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jan 2020 00:28:26 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55444 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbgATF2Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 00:28:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so6197291pjz.5
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2020 21:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTBoug2POge5IUv+BODbtuxgixi9XfhzZTWyFSqFGs8=;
        b=EmffSu1Ekm1BEOdjUqNZPrbufY1BxZZsbLp0EIIgqSsKbdU1Y/QhUZ0CFI6Jvu8BAb
         aok3M/fFGKuzC7xOkaqjTyJ2mnCTYKXjxBgMKJN1PHe2JLiCUC3LkFQKpPyICcRCYMYR
         3MOBr5YIQpCU5NoJfe5Vmq3J0JJZ4PKyXmfZ+Jjf45sTPc+aKaAB1ML3RIgJ9eD31lKy
         HfDLgUPMH4Ijh0iCSDeykSExAV84SAE31vOPmFRLDXvY3G+YoIln8ZIEkAJ14UWx0GlM
         nVJdWNi/G1VfDywJqHu9EmCRwykzlARFuq2gaR0z8/mgJEy9xl/uXpoDjdTV9ZIRKRBr
         bNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTBoug2POge5IUv+BODbtuxgixi9XfhzZTWyFSqFGs8=;
        b=Smp2ky18Dv+9dM8hfiMbqVVuyoAkqQPUVJeKLLWq2YSq3IWzmYeobWg5EkBifWtBq1
         4HPcBr9TlWWJT2xhQRfKnsVXw6njxKXnBrvs5ET/pR1/TRaS2e0Cv/ML4HEQe09jAFZF
         UBX8SW4FfJnJdjY93vNRs8F4dTMU15bHlzA/BcWkJBJqQWIota9FDYiuzWqegt+hjW/k
         uE/NyBl+DETo0bXp+k6o5prIqQ9Sj9m8UdPchJeN6Uu+l77vOsat6brpipa8PhNPjEa9
         5WdLkQFirNb7I6yZ/D3HizjbvQN8Jg1N7x49FRi9jkJn4etieGEP3ysgnXtdDuYePf57
         v9Fg==
X-Gm-Message-State: APjAAAVTlk47ThXBZeQeSIFju5iJtWoCVzQRUVzqkMfKkm1ucqYV8dy8
        OWHbHb4xMAKX4hcQXhAJRtElWRQsr7E=
X-Google-Smtp-Source: APXvYqyPVXId1vEjcr+tOT7Z4v8U9ypwhS2c/1vLrgL2t0SNuRIJzHadRuOhZQXz3K1rsfAmRcv2nw==
X-Received: by 2002:a17:902:b48e:: with SMTP id y14mr13300276plr.260.1579498104970;
        Sun, 19 Jan 2020 21:28:24 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id s26sm37402702pfe.166.2020.01.19.21.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 21:28:23 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:58:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     qiwu chen <qiwuchen55@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: s3c: fix unbalances of cpufreq policy
 refcount
Message-ID: <20200120052821.tvijbt3bzkn76yz6@vireshk-i7>
References: <1578383599-11207-1-git-send-email-qiwuchen55@gmail.com>
 <20200107080145.7c4gxilnjjxjfqpc@vireshk-i7>
 <CAD1-QrohtJFLWDMCYmVs2G5WDcDN_E8xcsNZqJ428cEkohcB0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD1-QrohtJFLWDMCYmVs2G5WDcDN_E8xcsNZqJ428cEkohcB0Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-01-20, 10:25, qiwu chen wrote:
> Hi
> Any progress about this patch?

I already applied it in my tree, it will be part for v5.5-rc1.

-- 
viresh
