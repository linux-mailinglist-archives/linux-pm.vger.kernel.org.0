Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67867884E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 11:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfG2JY6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 05:24:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfG2JY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 05:24:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so27718738pfq.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 02:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NHaPbEIE3GnLl8EEhfWosdb00OPf2b+fWo8SdgJJxo=;
        b=Xy2kFbWELNQCgQRQoASfnRppp4kufLgsSg0GLfeZ2QYeQqHU5mpLuekUESnWJ6W4au
         cLKGPGdF7k7MGl2BbkbWfnGBvmSrjg18z9HjryerP+YE8FPFW8Vp938laWSMBwMBElOx
         kyyCtoKg5txpKw0B0jCj1acEcdB5a91vD2r5wicbDw1sqElfH0LBlsirDz0zJ19dQnY2
         OjpK4ItIOlxl/PUMzlt4Q37vSX42BMPQWJ4lNjSvE+9kofdH8gKLTwTyMplTmwQaHb56
         Ch5ZcOhm5zTPnd+CrFwGsggzriGxMtbhx+erQvGfVQnkJhitKfOaaCp8TulgvSWufC7+
         6h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NHaPbEIE3GnLl8EEhfWosdb00OPf2b+fWo8SdgJJxo=;
        b=a5PDUBE1t+mii2yUsfzaZRz8AXNuXLP+9L/eO9LXfbP/qJgCiyVzJB/v7/2+MbfRg/
         JfgpW/5paMasfhsSvi9eS/pcBSWSyPEDcjWwhABkgEbIyUbdEkFD6GznTRkuai27z2F5
         V6j19Nt1XPiknzJAe7EovYYi+/0A3fJoaWlCieoiQ2ev7YDp9Y3rCQUVJjJhbAN8LPdK
         TDB30dHzvUX3b0FbSb/DV5FQoxCrnEx7g67IZfri+IErIIql6rFNBDzE4kDGItCkFu4J
         qYGvoBQcRYLfJSAdXlRmSCKi4AewegmOS7AmX1TWbHIGclpP/Uptb85fe9FTWsK+AlYC
         kLRg==
X-Gm-Message-State: APjAAAW6xBnjRrG/ju5cMV//a8ildD5JyC4mpD/RAq0JyluB/SF6PMJj
        gO7Vb5xeNpRhIoQyEgIyCmH1Pg==
X-Google-Smtp-Source: APXvYqyXnV7F+k6oUvgbf58oAVK1IH6CZXv9DBBx+BcsjmdeUAZr2vtTHZFtwqBx4mKuZrWjbNouhQ==
X-Received: by 2002:a65:6406:: with SMTP id a6mr66039326pgv.393.1564392297055;
        Mon, 29 Jul 2019 02:24:57 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id r12sm39768662pgb.73.2019.07.29.02.24.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:24:56 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:54:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] Introduce Bandwidth OPPs for interconnect paths
Message-ID: <20190729092454.6lfqzmhkvrhpimsp@vireshk-i7>
References: <20190703011020.151615-1-saravanak@google.com>
 <20190717103220.f7cys267hq23fbsb@vireshk-i7>
 <CAGETcx-tbjVzRKW8D-564zgNOhrA_z-NC1q5U70bhoUDBhp6VA@mail.gmail.com>
 <20190718053746.64drmonk72vwnt4s@vireshk-i7>
 <CAGETcx_-=b3An9YdxLUnZap=0iaeczvWTEnw65FMLU8BwA3HfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_-=b3An9YdxLUnZap=0iaeczvWTEnw65FMLU8BwA3HfQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-07-19, 21:12, Saravana Kannan wrote:
> On Wed, Jul 17, 2019 at 10:37 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > I would like
> > to put this data in the GPU OPP table only. What about putting a
> > range in the GPU OPP table for the Bandwidth if it can change so much
> > for the same frequency.
> 
> I don't think the range is going to work.

Any specific reason for that ?

> If a GPU is doing purely
> computational work, it's not unreasonable for it to vote for the
> lowest bandwidth for any GPU frequency.

I think that is fine, but if the GPU is able to find how much
bandwidth it needs why can't it just pass that value without needing
to have another OPP table for the path ?

The interconnect can then take all the requests and have its own OPP
table to get help on deciding what stable bandwidth to use.

-- 
viresh
