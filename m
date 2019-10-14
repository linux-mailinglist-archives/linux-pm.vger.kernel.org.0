Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D70D5D5B61
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfJNG0x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 02:26:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37815 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbfJNG0x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 02:26:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so9471928pgi.4
        for <linux-pm@vger.kernel.org>; Sun, 13 Oct 2019 23:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VdgH+nFnpDPa9juK1t6otWCG6Xaqbuih2fXaylHvPvE=;
        b=B3zqYCPzpZ53dHXN8oDf/c08zmMGZ8dmuzZiRkVq/9ljeb+rZZkYTdxuoxbcUWbZop
         VmrCIMbg+3apzEPWk17eaXHpVqhbm64eJ34zysSrPb3lTg4WKc6RcjsNAbRTeynPy/Ef
         XmUb816R5xT5xDAh1R5LvB+Pl6+n9iG2Sjrzl2HXVZ7by/oeflZ9lOgiR38IbZBHpR+4
         qkcQt+jHx5Gn1PGK+7sWCRkKceC7kSnYcRB3iskJnCLt+o+GClf4qVPnH/Ovhi7KytrE
         O0hZj1fr0LCnwn9q3aedbpxFQ90LJpjpC1adrXHy8eaxIYQRvt5MgLITp+zt6ilwwO/m
         Netw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VdgH+nFnpDPa9juK1t6otWCG6Xaqbuih2fXaylHvPvE=;
        b=WtkFSUedeNJxa3B9Qy/340tp6j1aKIGSeXDXx4V0LOjX4gtVMQDpD2GhPR69FtSDKE
         qIJstzuuq0nP17E+LVKEGReQSkscY2Jk/NJDrCb8Oz7N3Ltg+FY6Q7i9leBEz3ZAr3go
         UXrNHQzAHQWB1Y8cd9HiONTdonbcWiY/nykckhBkxGTEFgyyfd083NAqTjwf5n49YJXr
         oHU2++kF7alxexsHVz6f5tRg2rhV6o2Ktnbx0sqN3ZowlDuVsfwCpP2KdpAeM1E8hjgA
         t4mLQZ/wa+VEqmUbYwSZCRP1rTeZev6zHRfT+fzvmLQIcHYBJlqVt07xjYaEuvOTb1R4
         cEkQ==
X-Gm-Message-State: APjAAAUT+RyS1KOftBkNM3Gk2PCVtSjarCA178AMtUQiXqGxqbV/giUr
        3j+pp1D81CzwmTbFBDvg7m5Rzw==
X-Google-Smtp-Source: APXvYqze9R1UhejFkkerzxsIc4d4k9w/R6mIFU5o7LQ/TGuP24hrQzTovg/lsOwESRWK134nKAgrzw==
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr29391368pfd.151.1571034412588;
        Sun, 13 Oct 2019 23:26:52 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id r28sm20393311pfg.62.2019.10.13.23.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Oct 2019 23:26:51 -0700 (PDT)
Date:   Mon, 14 Oct 2019 11:56:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, vireshk@kernel.org,
        robh+dt@kernel.org, kgene@kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 1/6] opp: Handle target/min/max voltage in
 dev_pm_opp_adjust_voltage()
Message-ID: <20191014062649.oegc2rwigmdv6kju@vireshk-i7>
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
 <CGME20190910123636eucas1p250ec04901f227b947cc38936563f63b2@eucas1p2.samsung.com>
 <20190910123618.27985-2-s.nawrocki@samsung.com>
 <20191002143310.GA15898@pi3>
 <ada1bb2f-a824-c34e-6561-04a35782a9b8@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada1bb2f-a824-c34e-6561-04a35782a9b8@samsung.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02-10-19, 17:54, Sylwester Nawrocki wrote:
> On 10/2/19 16:33, Krzysztof Kozlowski wrote:
> > On Tue, Sep 10, 2019 at 02:36:13PM +0200, Sylwester Nawrocki wrote:
> >> To be squashed with patch "PM / OPP: Support adjusting OPP voltages
> >> at runtime".
> >>
> >> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> ---
> >>
> >>  drivers/opp/core.c     | 10 ++++++++--
> >>  include/linux/pm_opp.h |  3 ++-
> >>  2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > I'll take the ASV driver via samsung-soc but I see it depends on this
> > one.  Please provide me a stable tag with it or an Ack.
> 
> There is further dependency on patch 
> "[PATCH v4 6/8] PM / OPP: Support adjusting OPP voltages at runtime"
> https://lore.kernel.org/linux-arm-kernel/1565703113-31479-7-git-send-email-andrew-sh.cheng@mediatek.com
> 
> Viresh, what are your plans WRT to those patches?

I am waiting for Andrew to send me the next set of patches. You depend
on only one of the patches ? In that case you can just pick that patch
from his series, keep his authorship intact and make changes from 1/6
and send along with your series.

-- 
viresh
