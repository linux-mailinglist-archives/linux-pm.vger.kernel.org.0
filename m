Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C72097183
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2019 07:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHUF0Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 01:26:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43139 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfHUF0Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 01:26:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so629985pfn.10
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2019 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AbgNFdtNiAHc3P9dNg3Cl9n2STrQ5D8oYPMR42M6k4o=;
        b=g89urCuDkhMGyZzEXrRZ37obKQXCa1XnlXt/Hk6+A6ohfMQnchNzu0R4bXKm9QgvFf
         /R09pOzrLs7VDW143XnAO9DrtBPp6CPSLBBXKYVhe9E6XevH/qMnrRdlnrtkKSbxz/Xf
         MxyXcENFbtESYyodxxTLAaYsDjgiymLW+s1mQO5Ii1UuzdptKI4CBIIyNIIPWZ1dJV6C
         X47cpnU+VMbC2xW762i8bjEAvX/hJBT6Pngaq/8/NJaw5mSzrUdMRtedkZZzbc70rr8G
         GkwPMZYC7DXMU28a/q/8NRp2p6wzZelT/XogjlYTUiWdbSRz7VOlnxchLAvWnKflSqey
         4vDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AbgNFdtNiAHc3P9dNg3Cl9n2STrQ5D8oYPMR42M6k4o=;
        b=byJWGfXbRtckM6kVraI4s5sYPpm3ug+oOfk09d4ZPN/ElqduWIl+sZUQ9/ZhQF/xs4
         iTiZKNFLCcnviXwNjhKUMo4ONfEXizEb6didRqRAEZ+obZE5yKEp6cnrWWbMIO7aJ1P2
         lFWMaVlPY4fzIn2Z57gfwfgTw01LraTae9cal9gTC+cy7Fm2x7LGpedy1yhlApeWMSrC
         zfvBxp8CKVgqqDkGS/kKMYxO2Xkncfjb77I3Icy/yLmYDP6NTwf5RNZ5Ie6XQEgy1Ehu
         lS3CI+7+zV5bEZo5bWwyUnrZhOa/WYf9dltcdq6mitLTYa+w29hF+TDsTiCeZTU6GtAW
         C+ww==
X-Gm-Message-State: APjAAAUTsQqPTAFYuDSIoK4aJFsMgDINL/DIv9ZIbKkyQX66M7ueQ1T8
        xxjhgFBnjNgVXVCCEapPXOlhsw==
X-Google-Smtp-Source: APXvYqyn2YA8uDjld3bhjyDoV7CO7b/hNWNkRim3P08wu6STtwkFv3KR6GHMDfhcLgB4DPe6jb+8Iw==
X-Received: by 2002:a17:90a:d146:: with SMTP id t6mr3636385pjw.76.1566365183880;
        Tue, 20 Aug 2019 22:26:23 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id o67sm16966864pfb.39.2019.08.20.22.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 22:26:23 -0700 (PDT)
Date:   Wed, 21 Aug 2019 10:56:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] OPP: Add support for bandwidth OPP tables
Message-ID: <20190821052621.ftvxivls6tdf6vnx@vireshk-i7>
References: <20190807223111.230846-1-saravanak@google.com>
 <20190807223111.230846-3-saravanak@google.com>
 <20190820061300.wa2dirylb7fztsem@vireshk-i7>
 <CAGETcx9BV9qj17LY30vgAaLtz+3rXt_CPpu4wB_AQCC5M7qOdA@mail.gmail.com>
 <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-xQika2MgTgA3Gft3u2_uXgvoYThXwEpW_G03QTEh-yQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20-08-19, 15:36, Saravana Kannan wrote:
> On Tue, Aug 20, 2019 at 3:27 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Mon, Aug 19, 2019 at 11:13 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 07-08-19, 15:31, Saravana Kannan wrote:
> 
> > > > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +     new_opp->rate = (unsigned long) bw;
> > > > +
> > > > +     ret = of_property_read_u32(np, "opp-avg-kBps", &bw);
> > > > +     if (!ret)
> > > > +             new_opp->avg_bw = (unsigned long) bw;

Why is this casting required ? If you really want a 64 bit value for bw, then
make it 64 bit in bindings as well, like opp-hz. And then you can simply do:

of_property_read_u32(np, "opp-avg-kBps", &new_opp->avg_bw);


> > >
> > > If none of opp-hz/level/peak-kBps are available, print error message here
> > > itself..
> >
> > But you don't print any error for opp-level today. Seems like it's optional?
> >
> > >
> > > > +
> > > > +     return 0;
> > >
> > > You are returning 0 on failure as well here.
> >
> > Thanks.
> 
> Wait, no. This is not actually a failure. opp-avg-kBps is optional. So
> returning 0 is the right thing to do. If the mandatory properties
> aren't present an error is returned before you get to th end.
> 
> -Saravana

-- 
viresh
