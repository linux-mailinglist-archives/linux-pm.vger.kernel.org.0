Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0856F1F47A9
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbgFIUCC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 16:02:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46910 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFIUCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 16:02:02 -0400
Received: by mail-il1-f196.google.com with SMTP id h3so21572427ilh.13;
        Tue, 09 Jun 2020 13:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ELH9Be8+gsKdPlrt+pdF1SGavvBGmA9LnuUEzWNi+6g=;
        b=CHOc8+QJrn/5WqMMg8YRiB3zcAfYtVhxV5HXKC0YpvfngKn0tEyqL0KHsi2E7PD6+A
         bkM1L+/U5l9x65d9M9CM6ISAQCykSjP4sYskYnu//mY11bmS14KX08WfFDHXXLyqRnYx
         KpYlTauTcPq+coaXiel9C55rIvH03MrevWKITA4gRtyp24s23dgLDi9RmegieP3DDJ9e
         1/RFvoFj0uFCdUd75Gnqbod7+IUUyvOspQlnhpVhk9MhNaGAznPDusZoN5+9F/rPGrjs
         7QCVdO+uV6j4Uo/rUbXN1M0z42IYI0drh8RrUeexL9FGEekA+L9VjJAZZ7xOe7wfrvQY
         7CIQ==
X-Gm-Message-State: AOAM532acxCxnD3Gu6iZ9w8lRfm8+8OcT1uoxXmu+K8jQ/dSRjjiqZfH
        0zuOOn+gyzONqlSQlo6SWA==
X-Google-Smtp-Source: ABdhPJzzN9h/0yFH/jDM7Lc0O27CSSrGvQPkicYGBRLDyugbScvihBoQuG1yDC/Qmm+eVczJTsZiSQ==
X-Received: by 2002:a92:854a:: with SMTP id f71mr28102764ilh.28.1591732921382;
        Tue, 09 Jun 2020 13:02:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g64sm7823853iof.5.2020.06.09.13.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:02:00 -0700 (PDT)
Received: (nullmailer pid 1358678 invoked by uid 1000);
        Tue, 09 Jun 2020 20:01:59 -0000
Date:   Tue, 9 Jun 2020 14:01:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-pm@vger.kernel.org,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        dri-devel@lists.freedesktop.org,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 23/39] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <20200609200159.GA1358512@bogus>
References: <20200607185530.18113-1-digetx@gmail.com>
 <20200607185530.18113-24-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607185530.18113-24-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 07 Jun 2020 21:55:14 +0300, Dmitry Osipenko wrote:
> Each memory client have a unique hardware ID, this patch adds these IDs.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

