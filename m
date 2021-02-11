Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB4A3185C4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Feb 2021 08:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhBKHix (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Feb 2021 02:38:53 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36803 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKHiu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Feb 2021 02:38:50 -0500
Received: by mail-wm1-f41.google.com with SMTP id i9so4428353wmq.1;
        Wed, 10 Feb 2021 23:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxKOIKQV5J6hSTwMNu2jSYURsf4f6bPJNoLyJbXs+QA=;
        b=BMNLX9xpfj+sY58Ib+LnAbFcEzS8eZfegvOzJ2V9UjdSUEnQVpeTNW0UqrjYQiRZY7
         iHu/NrCNfdP63xe+Y5Oy5oexKVLFEcZq739gLcCKatGe0iKoV73AaWFZOQcMSdXNB2TV
         r3f12BCtqMRSJQUhvFVjrTv8DlKv6yNM3ZH8OK9717SdeQ8E6QdzCTgimiQFfZTMRAXc
         UXnhOJrWa0Znmk9HOiHCuU1kyIeR38WKkL6WK8oSKErzqzanvYPFlHWFvx9zgiI2UrHr
         uRzSjqULgZmNiK2LzaGo0TarSybkz/AL14/Dym/6YQTtrzjj0UDqpeGQLrDEzX+m5iu/
         wRog==
X-Gm-Message-State: AOAM532mUUfA93MZPMPAShyXJ5fz0MXiSD7awbpS7KjZ+xt3UsJK1FNq
        UsCobSSeDLZ/qjxAfHl6ar/mKsWjO+k=
X-Google-Smtp-Source: ABdhPJw4Ad7tK2AjLYy0JTUCSdlcdh0DVe39DvnF/jD4WYYAIcgqXZVE/Ng70Z+0Ezx1HaIG60TuDg==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr3632791wmb.91.1613029089156;
        Wed, 10 Feb 2021 23:38:09 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z185sm9142925wmb.0.2021.02.10.23.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 23:38:08 -0800 (PST)
Date:   Thu, 11 Feb 2021 08:38:07 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: bq25980: Move props from battery
 node
Message-ID: <20210211073807.sh6uwv3dt3eqxyy7@kozik-lap>
References: <20210210225646.10055-1-r-rivera-matos@ti.com>
 <20210210225646.10055-2-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210210225646.10055-2-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Feb 10, 2021 at 04:56:46PM -0600, Ricardo Rivera-Matos wrote:
> Currently POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and
> 
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE are exposed on the battery node
> 
> and this is incorrect.
> 
> This patch exposes POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT and
> 
> POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE on the charger node rather
> 
> than the battery node.

Now it makes sense if you only formatted it in human-readable way.
Please fix your git/editor/email client/desktop unless you used such
formatting intentionally. If it was intentional, then please don't - do
like everyone else in Linux kernel (git log will help).

Best regards,
Krzysztof

> 
> Fixes: 5069185fc18e ("power: supply: bq25980: Add support for the BQ259xx family")
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  drivers/power/supply/bq25980_charger.c | 40 ++++++++------------------
>  1 file changed, 12 insertions(+), 28 deletions(-)
