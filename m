Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3A290600
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 15:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406032AbgJPNJ5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Oct 2020 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408197AbgJPNJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2020 09:09:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B96C0613D4
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:09:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n6so2809254wrm.13
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2020 06:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eyHBJddDTbNPFeEpW+RroYrsG4+cEx3Q/2uix0wzOfQ=;
        b=E9r8pmWqGNv7QdV+tX6/6JYGehMkG0K7T0kEJ6WtZgJWRJGjrtTAnbe+IP3139FQH1
         pmStuVpaB0g1MaCmOFsN2UclDZMzpUN1tLt007fD0IBnDezvtqaxabzZiZZMzs0yVnSM
         FmkAiigUXgmK177YJvOq0/1sTmPbB5JGk7r2uS4VsZmrvD2ZEznJD1d+mBStQF9yEOtZ
         kVCFpsoXd8gBvmVXB8ePrHyT0A0uyg+Cs/FghA+LZslDdJYh+CrAyjIqh502bf1MzRKP
         vHgve0jdyaKaeSgyGmyy+KTwwCqmBVZ9QLb9yI737edsqY+8oe7a5k0jYY5peDSuBXRT
         AfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eyHBJddDTbNPFeEpW+RroYrsG4+cEx3Q/2uix0wzOfQ=;
        b=giYtcu8Pec1YJrTCawqb/8+XkzBqyZmKNSFZxHR9BV/6I77RuKoQd+RDbstJmuqaZ7
         rNS9SMOPR0hEvXJO+yZPBDdRZZR8TJsRLlPNZsDbDNKiGCQgbHvpu8SMSFa2OEoX8akK
         Bw8HxCwXddRCilJdVLCLiRJdVgfB7O7qZ1ZDuGsIHE3MEKsIgw2kK4DC0AnE11WJjHyu
         gCOoudZ/cPufJvU//Ul9H9WTlrexLi558X1mpc6EbrF+6U8doYJfYYzNwe/o3gmX7Ulo
         OnrFERYFQEWKrrmDYCmgEBGX97shxz+LMCBl7o9Wk3aK2Ka5otEwy1PkmLPo+y4aBtM/
         8c9A==
X-Gm-Message-State: AOAM531M1uZODse1fMypH9fSs2yComfn8mm3yC9itpcfCnID9iyoinIP
        vdDNi0gqfxC4Fh8+xwuPWSgxIQ==
X-Google-Smtp-Source: ABdhPJyJx2ziKX8CMV9mtHGWssCPDzWgGWdhDq5rg06Ua4cfCHB0ZtCFKPT068dgSrnPDzX14r37mQ==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr3713627wrt.281.1602853749936;
        Fri, 16 Oct 2020 06:09:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id s1sm2694735wmh.22.2020.10.16.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 06:09:09 -0700 (PDT)
Date:   Fri, 16 Oct 2020 14:09:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 0/3] Clarify abstract scale usage for power values in
 Energy Model, EAS and IPA
Message-ID: <20201016130905.GA2426638@google.com>
References: <b19c1f12-b7cf-fcae-4ebb-617019effe2e@arm.com>
 <55d3fb0f-f7d8-63c5-2bdb-53eaa62380e0@linaro.org>
 <f660731e-132b-2514-f526-d7123ed3522c@arm.com>
 <d04019bd-9e85-5f3e-2a1b-66780b8df3dc@linaro.org>
 <3e3dd42c-48ac-7267-45c5-ca88205611bd@arm.com>
 <00ceec64-3273-bb4a-6f38-22de8d877ab5@linaro.org>
 <CAJZ5v0hV8fwRnADdjiiF=zapO3AE6=_W_PeOQ_WhUirCcFkgdA@mail.gmail.com>
 <e321191c-61d2-a15d-47c2-653b277984ca@linaro.org>
 <20201016121844.GA2420691@google.com>
 <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c6d7a5-0564-6e84-77ff-9afe10d7ee27@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday 16 Oct 2020 at 14:50:29 (+0200), Daniel Lezcano wrote:
> On 16/10/2020 14:18, Quentin Perret wrote:
> > On Friday 16 Oct 2020 at 13:48:33 (+0200), Daniel Lezcano wrote:
> >> If the SCMI is returning abstract numbers, the thermal IPA governor will
> >> use these numbers as a reference to mitigate the temperature at the
> >> specified sustainable power which is expressed in mW in the DT. So it
> >> does not work and we can not detect such conflict.
> >>
> >> That is why I'm advocating to keep mW for the energy model and make the
> >> SCMI and DT power numbers incompatible.
> > 
> > I think it's fair to say SCMI-provided number should only be compared to
> > other SCMI-provided numbers, so +1 on that. But what I don't understand
> > is why specifying the EM in mW helps with that?
> 
> It is already specified in mW. I'm just saying to not add the
> 'scale'/'abstract'/'bogoWatt' in the documentation.
> 
> > Can we not let the providers specify the unit? 
> 
> Yes, it is possible but the provider must give the 'unit' and the energy
> model must store this information along with the "power" numbers, so we
> can compare apple with apple.
> 
> Today, the energy model is using the mW unit only and the providers are
> not telling the 'unit', so both are missing.
> 
> Because both are missing, it does not make sense to talk about
> 'abstract' values in the energy model documentation until the above is
> fixed.

Right, so that sounds like a reasonable way forward with this series.

Lukasz would you be able to re-spin this with a first patch that allows
the EM provider to specify a unit? And perhaps we could use Doug's idea
for the sustained power DT binding and allow specifying a unit
explicitly there too, so we're sure to compare apples with apples.

Thanks,
Quentin
