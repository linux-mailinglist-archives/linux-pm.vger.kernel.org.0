Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6738CEF5D5
	for <lists+linux-pm@lfdr.de>; Tue,  5 Nov 2019 07:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbfKEG43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Nov 2019 01:56:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46985 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfKEG43 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Nov 2019 01:56:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id f19so13324844pgn.13
        for <linux-pm@vger.kernel.org>; Mon, 04 Nov 2019 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ov53IhqY+y2u5I+jv06ZVDSheZi0X6lfhJFxD0jJ1jY=;
        b=sYLkh9eJyOp3PyVAMRShFJBgV1u3OrLWHhznBG/lzdcqiGFWBpMogdewuNIZ3W3Aya
         ypLA2lOiSwS7Mha8F74R9we2LjzymNASflKZGpVmyMj53Piod7y5wFvSaOEFK8NTIqzX
         e98lI5w7K8FqOpp1Po8LPB+KCLElA32LZ59m8Q9kj09uLtL6/pZDGNms0qOh+stWZvZ7
         50KtkyGhiw2X9OTLkgY/wnVfuHo6DXt34Be2bWVmGsnb5BajtNdRyIo+awmobq0fbO6m
         /576r3DcKQV0OAk9cEOOfxTloL5WzxdlqLvM5aZ0rI5paZdh8hZIR4yK1bv1JeuiL5VE
         nllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ov53IhqY+y2u5I+jv06ZVDSheZi0X6lfhJFxD0jJ1jY=;
        b=SE+RMglkt8mBPEkZX/qSF/L7I1C8SCt14p1xmOV+ZP1X+J4ssfI1+AFczh5NleiQCG
         8oA/KhlCilZqZyxEQAH+TSU8nrtPa60mqmr23QBJ7Qm7cbCKdTYlXcxhGmnPEt/T982l
         t0wsJIC/oVCCPTVGsloSgZU+ByUfxh3+LoRdqAFiBIKOE7LTE1zB+v6VUtUn7J/aVSt7
         l3THogk1qoZoB1eKELtLcJ0Cda28goCvj8avpNio7jdlh3fPfRFyQVI4bm6dZTszOSU6
         4QmldlEMc7EV00EvsnEyHXZd3u9q6q9pl9/wZpXPR3a7Fwtw9LLDgK12aSczb1zucfOO
         eDmg==
X-Gm-Message-State: APjAAAV4rvq6cy2oJfvFSygJjtiDszTvv7FmK8lP87dWwoQm3YlOKnUU
        rCuAyiQlM6S0AG/o+42MBDXBPA==
X-Google-Smtp-Source: APXvYqziJLDh7KltXxceWTUbGJJMReFbby2FRl5eOFtHFG7ihNZWZjPXD1U+iFBCnM+RPj2q5kPBAw==
X-Received: by 2002:a62:61c4:: with SMTP id v187mr35889736pfb.23.1572936988079;
        Mon, 04 Nov 2019 22:56:28 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id y16sm19426905pfo.62.2019.11.04.22.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 22:56:27 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:26:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Andrew-sh Cheng =?utf-8?B?KOmEreW8j+WLsyk=?= 
        <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [v4, 6/8] PM / OPP: Support adjusting OPP voltages at runtime
Message-ID: <20191105065621.iq6lp74tydrneshk@vireshk-i7>
References: <1565703113-31479-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190819111836.5cu245xre6ky6xav@vireshk-i7>
 <1572595738.6939.7.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572595738.6939.7.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01-11-19, 16:08, Roger Lu wrote:
> I've studied opp/core.c and still don't know meaning of triplet here.
> Could you give me more hints (reference API?) about how to take a
> triplet instead? Thanks in advance.

I was hoping you to follow this thread :)

https://lore.kernel.org/linux-arm-kernel/20191016145756.16004-2-s.nawrocki@samsung.com/

I already applied this patch to the OPP tree.

-- 
viresh
