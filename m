Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4928ACBE
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 06:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgJLET6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 00:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbgJLET5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 00:19:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226D8C0613D0
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2020 21:19:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id y14so13037591pgf.12
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2020 21:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d+sLnvZTeiN7/c8MjJpzLtaNxN7gU2/mrKXXOJoa83I=;
        b=KZNllpqNv5xOOyaT+G76rND+p88FGMLQDwK/cKeOaH0uaaFMeS/R2t/RDbnFjojLn6
         w3hgXLVskRRdm4HZzepz2AWIxtY3A+S7ZcR/XGzLerA5Lk19lufAV2U/mRlqmm+/cdQr
         290KuNWsojQRMc8HK5QdcUGyV0KzwahuRZTM4bhE18hiw/gRN7JubTomi2KxG0Qsnp9o
         t6qI3WrIrhHJtGKqntnM4+IMW90BR988wMzW/TpWaXbloatA8wYUZ53dClTQdEEBXCaC
         RiHroE/nO6QMJcF3ORz21df3TbOYtzcI/prP0Y3vFmys8Gu9uYnQ7slnpdS4DybE3qus
         CZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+sLnvZTeiN7/c8MjJpzLtaNxN7gU2/mrKXXOJoa83I=;
        b=D9JD3pB0fMrlm93JqAKtmurha3Zgo3BcmB/2P8I8AqN1SLC3jRnkJ9Uzsyjekaj74n
         prkI6Kz19CjVUhxXy9Sce9dEyjo9efzsZ6uPJU6pHqT39kQ1TgG0tjL9GgU411157L5E
         RrZhb8k08gWiOgJtZaT7sGGmB7RWj+LV0XjS0jlrPJ3DfpHwteYZplL4IYf5d5NDLC85
         zT5ThCcPOaeqs6As6rytIv0PH5NpB1K4KQmRfVb31avhwOPnLPI230UwlpSAcPHbIq0J
         hGdXb70yK4o0Af2cfO5ftxJoy6lhV8G7R3Mt22wIvroFKsLhe4sY0DC7EpslxZqcg+ZF
         T6WQ==
X-Gm-Message-State: AOAM531L+rrLQBvkchIIZ+czJO97xIl2wpVzlgIQNZkGujmoJt6Q+HvB
        AxySxMhTyg6p/D0ou5tAeslr2Q==
X-Google-Smtp-Source: ABdhPJwzZau3S/gIoJSK5Yx87xenSxCIZ61I1KDOdlIEpr0ycGp+oIrV+pYht3gAa9PS7YL4RjIgGA==
X-Received: by 2002:aa7:9358:0:b029:152:b349:8af8 with SMTP id 24-20020aa793580000b0290152b3498af8mr22989089pfn.9.1602476395311;
        Sun, 11 Oct 2020 21:19:55 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id e21sm15513630pfl.22.2020.10.11.21.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 21:19:54 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:49:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201012041951.4qytnhuqvvzjionh@vireshk-i7>
References: <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
 <20201009140141.GA4048593@bogus>
 <88f46cd0-226a-fb3c-0bd7-59688a566ea4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f46cd0-226a-fb3c-0bd7-59688a566ea4@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-10-20, 16:28, Nicola Mazzucato wrote:
> @Viresh
> I am sorry I misread your reply earlier thus I did not pay attention on that
> property.
> And yes, it is exactly as how you have described :)
> In the case 1 (different opps, different clk) and case 2 (same opps, different
> clk) we provide v/f points. In case 3, we add 'opp-shared' property in opp table
> to tell that the cpus with this opp table share a clock line.
> 
> Here are my thoughts on this 3rd case:
> - the information of 'share the same clock line' comes correctly from DT as it's
> purely a hw description. The same applies for cpu-perf-dependencies.
> - because the opp table can come from any firmware, we won't have any opp table
> in DT, thus we won't be able to take advantage of 'opp-shared' I am afraid.

I wonder if we should use an empty OPP table just for parsing this
information.

-- 
viresh
