Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F07184353
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgCMJKm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:10:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40417 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgCMJKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:10:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so3943339plk.7
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtkM+yZ5+lxvRbR9JLka9INk2b+8sAQT2vc0MdMcdF0=;
        b=R4Eg+CqTJ0CA4+mX+Q0HT1tcnR6NS4q4j5dn6d8VDy7Wz394wQUwvT/NaDJrrFoRkR
         O4/q4o8nR8aYr9LiZjCjS7mE1Zfot+KRD4H1e72uNXjMpENOJ3vSrzA5e/rgHS2aYJt/
         BaKX921yAoqhLuHWhyjVZwWDx6d1rQow8LiWogRoqoq5Ed1jrZ5gmHxTleTjyMQZ8CKs
         T+ypxEPiziHju+YAqbmPXZgW3yTKrcT7Suk/VWNVnzOZBXvpyetDTnzJ6oSWvSHDjPYA
         8QMe+yOkIm+I3kT1Poq2VSQAD5vtvUNRuCXLrRBzA4wiXWN3t1vy/UNExwtyBq89ThAc
         hzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtkM+yZ5+lxvRbR9JLka9INk2b+8sAQT2vc0MdMcdF0=;
        b=HRq1QPEbe0HCK3W3xiqa0qK3Dy4gri6/+C2wL+acLIbMaoKS1cSZqIr9HNQkzmnVqF
         wdgOnLg/1eWEpIabOQY2nIzy2YFIaWRXMTTUutrBo1uq5WaV9r/nJVU2yKSfj1rQdXYi
         yCV5ygAdMTZw1uTNQkyMjRTRv+p2iXLWROMbKmoOXvDIbzLZ9EmwEO/MsU9+U8nurgvV
         cDJH0QvbLVqsg25BlQLCYPplrWqU9BspKljMeZYl2xWKmdhSrlTSULqao+buPxn30x9J
         5oCIdthwmftQanl6659W+y9kIMfO1gWNuz+XLoTf1zH9HETh5SBt6XQl+q5S4E/EBIcc
         Whlg==
X-Gm-Message-State: ANhLgQ2iPbMjEiAKddFx8yO0bbUyx4pcCmxC8AbnjJ0hVhhukdvxrVJe
        JwQhwPSdg6NPehqNUdLnE9UXsg==
X-Google-Smtp-Source: ADFU+vueMkKxf9i4W6oJIJHRrSOEaNDdoKCVYBJIRGmkg6vmX/eRdo6zNqs5xJmNtBnSly4IqRo2Fg==
X-Received: by 2002:a17:902:7485:: with SMTP id h5mr11624298pll.13.1584090640801;
        Fri, 13 Mar 2020 02:10:40 -0700 (PDT)
Received: from localhost ([122.171.122.128])
        by smtp.gmail.com with ESMTPSA id c8sm4233902pfj.108.2020.03.13.02.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 02:10:39 -0700 (PDT)
Date:   Fri, 13 Mar 2020 14:40:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v5, PATCH 4/5] cpufreq: mediatek: add opp notification for SVS
 support
Message-ID: <20200313091038.q7q7exiowoah4nk4@vireshk-i7>
References: <1574769046-28449-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1574769046-28449-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20191127083619.etocnhpyyut3hzwq@vireshk-i7>
 <1575874588.13494.4.camel@mtksdaap41>
 <20191210064319.f4ksrxozp3gv4xry@vireshk-i7>
 <1583827865.4840.1.camel@mtksdaap41>
 <20200311060616.62nh7sfwtjwvrjfr@vireshk-i7>
 <1584084154.7753.3.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584084154.7753.3.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13-03-20, 15:22, andrew-sh.cheng wrote:
> I have something want to consult you.
> For your previous comment, you suggest use read-write lock to replace
> mutex lock.
> Will it be more efficiently even when all are write lock?
> (all lock region are "setting VProc voltage")

The data to be protected here isn't the VProc voltage but the list of
valid OPPs. My idea was if we can make the target() routine run a bit
faster as it really matters as it is called from scheduler hot path.

It won't be wrong to use the mutex the way you have used it right now,
but I think the read lock is much faster, though the read/write lock
is more beneficial in case where there are multiple readers and fewer
writers. The target() routine gets called multiple times here, not
in parallel, and the OPP change notifier won't be called so often.

-- 
viresh
