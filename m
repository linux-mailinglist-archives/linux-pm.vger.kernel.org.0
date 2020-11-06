Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAAF2A9D9B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 20:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgKFTKj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 14:10:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43659 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgKFTKj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:10:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id b9so2344608edu.10;
        Fri, 06 Nov 2020 11:10:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gqirjaMt4D6SKqcnUi2BGgbSRPE0IdYDv6GFpHhWUvI=;
        b=ZTmLWhtjHVByjrjV5XKVrq7O76F8KvzF1RQimo5acS98QM66Y1e+PvhRKyIGVEAS24
         p4hsIqK2zw+l3AhF/NUX+br1XPhyk9zu+dP61Lbtq4XbghKj5BpJsZveGaG9GBxfK9ie
         RxfoZbNV34pMU8/cKU+D6uxMRaxDqG5JW86c+JpkzXVD6nmFP8AzGVQoubqo3EWtLBCj
         puKPK5e3u8q0N78FX4FBuYDZ3qAXQ1Vent2sOjFHjbWA3Rgbu+9E3bbVF60TPE4rfHez
         kmnphrpF20eg3D0B911NbXud5d9jw9/IY9sGSDotP8rbo7F9oOywUOC0LGza9n+gZ3gU
         XbFQ==
X-Gm-Message-State: AOAM533cAwZ9WQOh4oRPNBYz/0AE+iOIYBFuPevLxGMDK9YTKtemuqq9
        3JGlPEUwDoM1loMkd0x0mRQ=
X-Google-Smtp-Source: ABdhPJxxua5gAL0oui3IMgo8hZd9sh5JMCTalWVuc/s/2mSaFDEPMiMOSp49pEiaN9sG5rNOJidI+Q==
X-Received: by 2002:a05:6402:22c6:: with SMTP id dm6mr3612186edb.139.1604689837124;
        Fri, 06 Nov 2020 11:10:37 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l12sm1666653edt.46.2020.11.06.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:10:35 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:10:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 35/47] memory: tegra20: Support interconnect framework
Message-ID: <20201106191033.GA65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-36-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-36-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:11PM +0300, Dmitry Osipenko wrote:
> Now Internal and External Memory Controllers are memory interconnection
> providers. This allows us to use interconnect API for tuning of memory
> configuration. EMC driver now supports OPPs and DVFS.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |   3 +-
>  drivers/memory/tegra/tegra20-emc.c | 310 ++++++++++++++++++++++++++++-
>  drivers/memory/tegra/tegra20.c     |  77 +++++++
>  3 files changed, 386 insertions(+), 4 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

