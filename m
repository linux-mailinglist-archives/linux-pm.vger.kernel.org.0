Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFB3ED431
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhHPMoA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbhHPMnu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 08:43:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C40C0612A9
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 05:43:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v4so16283030wro.12
        for <linux-pm@vger.kernel.org>; Mon, 16 Aug 2021 05:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aaqMhNXX5ubcTauA21rytC20lDdDTc2pBDU8Tws378M=;
        b=LE16v6TCB3R8x/JSsQ7r6FmB+89ifjlh74osEFVgEqQWluYtyPvQEF9Z96ySPzgxDf
         JAkR0Lnk3wSIRuQ+lCZXYvM1IbOGE6usgHiy3LTaKzdnxPUy6T0satAQTH2FLTE8AVbc
         dSlNOIyOUcweeKCt2suIEC+E9k7IGfcR7XkBpK+7i084ZrV5zkD1WmWwbuGXQ0EzE9Z0
         CrTCcwP77eqNkWC3Ric2kmPhsp/pBZSTjbQgTiU2h39UlppZ/c1igwB9tNgyguIFC+7G
         /AWz1bXzcTPxNeQOD0le82vyd+WHTHV8SpC+KdMyFVu9fIwNPB2Zgr7MLxcmZrcnwrTI
         nvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aaqMhNXX5ubcTauA21rytC20lDdDTc2pBDU8Tws378M=;
        b=VUlcIOq4QuTxjvPx+BhzQ0dydvcNMQGkDF8WMlRbTeODNl8vtvvPLIHca26dnpNvOw
         PUL2hk7LK+Yi24oR4nrHVaCUXXB+dzsCwzpZ9/kXNoOV54II5y1xAmIfncqX/+KMsaCb
         2iLqyoRGW3RlXfOWHotuXgrkLeBLW3dJNpFCA0wq2AlPV3aciYSiE+K2NpbPDQq+zC+5
         XuLUiEHfuzPXSegxKhtUQiT2cMh4/XMmhfbTLvNIVgmt8FXyca+gHjydENHcPatFzSIM
         R4oEJsq+UIWVuzDQvDU9tHoVHOLBXfR5dhzVLt517XqETpGx560TTNTknAhYwWQ5l4og
         HWeA==
X-Gm-Message-State: AOAM530CQPFA510qw7SalLXyI2JyOCG4O/iWMauFs8+bnZkF87p7AVkY
        uIWSQLmW/bXMyaR0GN1qnea+sA==
X-Google-Smtp-Source: ABdhPJyT6u7dVvahjForRQ0K3vfkjtwg2RcUcbZOzHF5a9EYRBv3p6aMkDnJ8Bj+fG9+IfyiF5oCqQ==
X-Received: by 2002:a5d:4808:: with SMTP id l8mr18532304wrq.349.1629117786981;
        Mon, 16 Aug 2021 05:43:06 -0700 (PDT)
Received: from google.com ([2.31.167.59])
        by smtp.gmail.com with ESMTPSA id t1sm10744498wma.25.2021.08.16.05.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:43:06 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:43:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] mfd/cpuidle: ux500: Rename driver symbol
Message-ID: <YRpdWBnLkh5v3O58@google.com>
References: <20210806091404.3521189-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210806091404.3521189-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 06 Aug 2021, Linus Walleij wrote:

> The PRCMU driver defines this as a DT node but there are no bindings
> for it and it needs no data from the device tree. Just spawn the
> device directly in the same way as the watchdog.
> 
> Name it "db8500-cpuidle" since there are no ambitions to support any
> more SoCs than this one.
> 
> This rids this annoying boot message:
> [    0.032610] cpuidle-dbx500: Failed to locate of_node [id: 0]
> 
> However I think the device still spawns and work just fine, despite
> not finding a device tree node.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: linux-pm@vger.kernel.org
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Use MFD_CELL_NAME()
> - Collect Daniel's ACK.
> ---
>  drivers/cpuidle/cpuidle-ux500.c | 2 +-
>  drivers/mfd/db8500-prcmu.c      | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
