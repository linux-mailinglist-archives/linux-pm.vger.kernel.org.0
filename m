Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EFF27B4BD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgI1Srs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 14:47:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43192 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1Srs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 14:47:48 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so1952621ota.10;
        Mon, 28 Sep 2020 11:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ceCsarVOwip01r20h2NbRA2yfWJhyTjG+hv4ywi1tA=;
        b=fxTL5cflyuj7HroWJFH9su3bfRiJ+tc4iOj+q1HpwSzSUqmVQ8lckG0N90ey+r46no
         xwcJRmCA6oIft8tcwpV6K82dBXRpLfNMqDjDGhEXA2HKmnbwevesheaECdo+DqToILth
         EZKlQD8/8oQDO0TuHtVjF+55scbMib3N2PMf2p498+a6X5g9aZ5FVxlgX1t1ZK35vG/A
         5fpVtULCOxFd9nX1iApH1c9uZ6iWxTinZ5xKOs9UnsdKKY/f/zJuiwqxFObRy2GMKPuK
         mYyvOzpHvSTJhGBd/L+8dlkc96oBNxyw7HvHeRF7f0p3i9hHiimKfswGKPPoMu56ZxrG
         w6Xg==
X-Gm-Message-State: AOAM532fXvsdNk8YEnbDHnboHInx3oIy/qbOdcWlkEQuyqmPfSWHDn0a
        DVctswVa6MWsOqHUNxIyVw==
X-Google-Smtp-Source: ABdhPJxkyxlSVtjur50ZDPinR+4AM9QhETbNIL0l48ojZuecdey3UuesRBe25BG5ek0bW57rxHErJw==
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr277121oti.144.1601318866869;
        Mon, 28 Sep 2020 11:47:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i6sm393029oib.17.2020.09.28.11.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:47:46 -0700 (PDT)
Received: (nullmailer pid 3064388 invoked by uid 1000);
        Mon, 28 Sep 2020 18:47:45 -0000
Date:   Mon, 28 Sep 2020 13:47:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     dmurphy@ti.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sre@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: power: Add the bq256xx dt bindings
Message-ID: <20200928184745.GA3064331@bogus>
References: <20200923152416.24822-1-r-rivera-matos@ti.com>
 <20200923152416.24822-2-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152416.24822-2-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 23 Sep 2020 10:24:15 -0500, Ricardo Rivera-Matos wrote:
> Add the bindings for the bq256xx series of battery charging ICs.
> 
> Datasheets:
> - https://www.ti.com/lit/ds/symlink/bq25600.pdf
> - https://www.ti.com/lit/ds/symlink/bq25601.pdf
> - https://www.ti.com/lit/ds/symlink/bq25600d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25601d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25611d.pdf
> - https://www.ti.com/lit/ds/symlink/bq25618.pdf
> - https://www.ti.com/lit/ds/symlink/bq25619.pdf
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> 
> ---
> 
> v4 - documents monitored-battery and interrupts, fixes example for
> ti,watchdog-timeout-ms
> 
>  .../bindings/power/supply/bq256xx.yaml        | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq256xx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
