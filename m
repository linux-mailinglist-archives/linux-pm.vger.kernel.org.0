Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21C4F184D08
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCMQzi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 12:55:38 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55085 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgCMQzi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 12:55:38 -0400
Received: by mail-pj1-f68.google.com with SMTP id np16so4434496pjb.4
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2020 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbZ4dSo0yJ+mEzE8KOiBQP+F7VWDBbmSG3yIbewX/cU=;
        b=X2aAWYClYrEic+m4wO6Rkp+ungpARsa8Cf6E72AE5uVtHEG8VXD+e+sI9HFiOH4URs
         vdNbBdO5fLjIQi5PwoKMQdiP6uxq8R0n9v18dPUHM6obDIj+xXn6MO+4jDPo4FWyliqZ
         6nvZ6jY4ff4RRv5GHGGbeiLpQGBj7Wpa7LRkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbZ4dSo0yJ+mEzE8KOiBQP+F7VWDBbmSG3yIbewX/cU=;
        b=GzPzz9fwLGRgHFruF6t7xceRr2VDJuvBfRrZjdiE8calY2mP5lF5SwUkgB9dwK+0wH
         JJm2swwetT4CW/aryIaoDx0kCcxqVH/alSZVMgMkoUwQnRP5/xL+ztp+Dg9iMr/uVtlm
         BULcVThoVDsjymWhU1UppSu7GU6xnP0kq2mjvSACH1BRpeQhymsEqTbjBKGpZqRIBuX9
         IUsllF3RAcnUDFY49Ja/A1xZ0vXg8KXjtRgfBMYAjp/wgHyYDIxG4/kQfS1v3vBXPT07
         /WeOFXAgscOpGHAxMjmsw9t9wsRvSffVZz6KX5DgUX+C/fxvN9U91Y/iu83eRXa4UC6A
         85sQ==
X-Gm-Message-State: ANhLgQ216udkNpJ54eUcciycdB/3Aeq4tHF/fAQqOE/+KU3QMdpp001B
        nhoJP2DTLiZmo5O+mu63pPBNJQ==
X-Google-Smtp-Source: ADFU+vsZXLGxVNcXxugjf7JZA+Vtpnh9QLR8E+B5WWdPb/xHZ7USp/t0BvIAE6rb8ObhgtQilCHFWQ==
X-Received: by 2002:a17:90a:8:: with SMTP id 8mr10779352pja.130.1584118537308;
        Fri, 13 Mar 2020 09:55:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id j24sm29314647pfi.55.2020.03.13.09.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 09:55:36 -0700 (PDT)
Date:   Fri, 13 Mar 2020 09:55:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] thermal: devfreq_cooling: Use PM QoS to set frequency
 limits
Message-ID: <20200313165535.GI144492@google.com>
References: <20200312113416.v3.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312113416.v3.1.I146403d05b9ec82f48b807efd416a57f545b447a@changeid>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 12, 2020 at 11:34:20AM -0700, Matthias Kaehlcke wrote:
> Now that devfreq supports limiting the frequency range of a device
> through PM QoS make use of it instead of disabling OPPs that should
> not be used.
> 
> The switch from disabling OPPs to PM QoS introduces a subtle behavioral
> change in case of conflicting requests (min > max): PM QoS gives
> precedence to the MIN_FREQUENCY request, while higher OPPs disabled
> with dev_pm_opp_disable() would override MIN_FREQUENCY.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

I just noticed that I forgot to add Chanwoo's 'Reviewed-by' tag from v2.
Dunno if patchwork will allow this, but I can try:

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
