Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42332A9C70
	for <lists+linux-pm@lfdr.de>; Fri,  6 Nov 2020 19:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKFSiN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Nov 2020 13:38:13 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46224 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFSiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:38:13 -0500
Received: by mail-ed1-f65.google.com with SMTP id t11so2242128edj.13;
        Fri, 06 Nov 2020 10:38:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgaaduNWhBtGCGTi0Ry8Q0coZRaawbsMQyKl/2UIEgo=;
        b=pp/sXCD9BgDiLEcETvzd0oatKdTEZtX8625MQgswZd6yCWHRJOMUJv2l9znsQiLWWE
         1JXGNUr0rOLts9GcTzzxS56eMfWIYrMr7vojVvoO6fpaNESu+Jm35kZA38h1Dk7ojqMJ
         xRCspbySf1JGhIrIcrZhHRtaDuV+pitYjW7cIErTo3tpA/vV2p6SJwzK6NghgT9+7U8n
         wgFcZYENPY6b7RBYt8GCYsOsG3nauM37Ansp204CldYRuZ1YBUxY6vYmD6h7K1o+OSq/
         JdrCp84aNz6EKgcH7GOpwSA29zbqiCd8NrrTsGUQd8PK4Ja/rfHkL7NZmVLcrIvBkb2/
         EAMg==
X-Gm-Message-State: AOAM530aQ+fSxMR6w5vQcWQZegKpkCNstexDirhXS3b8lkoVW78fTgAH
        ByPSbW4dbdldLlp0lmKSSXY=
X-Google-Smtp-Source: ABdhPJy4HtbN7vYJA2lNpLeh4AOM6cl6mWGJG37W4W7pBtW9Cbp8CePA8JE/iAbGlQ2/RzLAUdYZuA==
X-Received: by 2002:a05:6402:22c6:: with SMTP id dm6mr3472585edb.139.1604687890665;
        Fri, 06 Nov 2020 10:38:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b24sm1594165edt.68.2020.11.06.10.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:38:09 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:38:07 +0100
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
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <20201106183807.GQ65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-18-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

