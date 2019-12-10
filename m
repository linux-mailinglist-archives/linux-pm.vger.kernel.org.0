Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D024117F8E
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 06:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfLJFV3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 00:21:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39757 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfLJFV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 00:21:29 -0500
Received: by mail-pj1-f65.google.com with SMTP id v93so6904229pjb.6
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 21:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UwrjfcwYOpJ2xyBggWtxzeNIKMmDC1O3C+UcOTm1Xww=;
        b=udFUdL8CSxus6OzfB/32Akgca8iH+TWrJcNBC/YP+Q0AJlC8f3KAaeUq4ScXEQYuDj
         dF+3ht1yZMp6VyZmBC7jD+TjluEHT7toSwbUQCnf3yQPBTK98aEhnTpfXwb+Lw6+pFsw
         jylyk+mQtGNdMW2zWkDBJ8EDUbPl9JxWn4q2lSoLNhT+MGd15m5upQbDbodDolGRQow9
         OIKZEhJcurBjpKIqHhZApr7If3y83ALUiNL2jWHc7SdomEZ39WG6ExFafeGjZLvfGakr
         c1WmU6MSmqEOMk/lfJIBE5QTA+v4JbrQBDcGIpfEMKAytoLYNxTUTsA4v3RW+uYPyyrk
         19YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UwrjfcwYOpJ2xyBggWtxzeNIKMmDC1O3C+UcOTm1Xww=;
        b=snTDQyVjEx8R8ZuUXv3pC8SdX9YBfydRfM3MeOhDqc6CXdg0/HVg57Cwz/bD7/Qdr0
         aRz1hFo9Cc9AWDAJ5TWwk1KcJ+25gfwm1DCwFl1oQAzWZ7vgGLx8yS/lQ8dfvTbQwexD
         AsENRn3Ojc55lY9F+sSlljxFvCD4RaLqk7srtjjfsJSw0XNFPXTo2LXE68cXGgNeWI+H
         kQnXOKKK3o8japGFDD4wqPh89IlABKLvTav/tVSeCpHZ3+iUp6R93IWd4WaisvEm2Cxr
         t2Fhgx6J6F5QHjYivNPmNm1tVBfQUQbqsPcyxWjS2p5HkOh1nx2D9vXMpfDyjn1/e7o6
         ApPA==
X-Gm-Message-State: APjAAAXgf6WnETxPV4YKf1fO9LLa+WbCjv3CbIRnrttgRLvJdKR2EPUZ
        clnKH1jXsBqx4Pl4O7MZRoRS6A==
X-Google-Smtp-Source: APXvYqwMzFhVumk/TT/0klj6VgiAr4+TABdqJa4cB/e2LE3l4VmhXXIHNFhdSTEQZ65fOSqgnKLDXQ==
X-Received: by 2002:a17:90a:86c7:: with SMTP id y7mr3405878pjv.102.1575955288349;
        Mon, 09 Dec 2019 21:21:28 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id v7sm1075946pjs.2.2019.12.09.21.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 21:21:27 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:51:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] OPP: Improve require-opps linking
Message-ID: <20191210052125.qg7zlbxo5ag6er2g@vireshk-i7>
References: <20190717222340.137578-1-saravanak@google.com>
 <20190717222340.137578-4-saravanak@google.com>
 <20191125112812.26jk5hsdwqfnofc2@vireshk-i7>
 <20191125112952.uwrmeukppkqu4hvm@vireshk-i7>
 <CAGETcx_uohJknvW8pDb6XXBkZveFqMvt5wRyecV5sye5a8vLpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_uohJknvW8pDb6XXBkZveFqMvt5wRyecV5sye5a8vLpQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-12-19, 11:11, Saravana Kannan wrote:
> On Mon, Nov 25, 2019 at 3:29 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 25-11-19, 16:58, Viresh Kumar wrote:
> > > Message-Id: <8df083ca64d82ff57f778689271cc1be75aa99c4.1574681211.git.viresh.kumar@linaro.org>
> > > From: Viresh Kumar <viresh.kumar@linaro.org>
> > > Date: Mon, 25 Nov 2019 13:57:58 +0530
> > > Subject: [PATCH] opp: Allow lazy-linking of required-opps
> >
> > Forgot to mention that this is based of pm/linux-next + following series
> >
> > https://lore.kernel.org/lkml/befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org/
> 
> Thanks Viresh. Is there a git I can pull a branch that has your lazy
> linking patch series and whatever dependencies it has?

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/lazy-linking

-- 
viresh
