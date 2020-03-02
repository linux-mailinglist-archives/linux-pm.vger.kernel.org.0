Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80C817668A
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 23:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgCBWA6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 17:00:58 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41191 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWA6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 17:00:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so846515oie.8;
        Mon, 02 Mar 2020 14:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=REUIC2AfAnGT+owqjgQK+odBaQ6CyNbOXlKApYyt3Y0=;
        b=WskOJGRtGyKfIkUUGO6jN9fXDu62GCRIVzUSBbOLBveVIdzipt5wnpEYsB8t9J+M/h
         UfVaV3olYvMG+8gUpsLxoQTETOzBLn/peTGGanfU2RTmpjkocSjUdpUQnbSBPkO13NNY
         GriZg18j4IzxxDZG8fCU6ECwzcvpr7Fr/Inqers+etVBq9SUrtuoPgbu0hVE7bPt6h5l
         r5xonn6Jh+FRUdyXiDUrYmIgpAViffyXnaMQb5GLLCFgVJizmkoxGWIWgwA8fDdMAz9s
         D1z1j5Au8Il8+P5OOAI/cjl8aXfMHTWLelOcWCVL+rGRHuMfTX+I0IWIOExx8+lyJtpE
         tmdw==
X-Gm-Message-State: ANhLgQ0uWRnZ9lrI7dj9Ys3INDBRGcmv2b2XLVnsLDKO7VI+OUcizR9m
        zC66RakLni3zLPABsvAqxg==
X-Google-Smtp-Source: ADFU+vvazweio8K6m4k3TUYFDYIvkV5M8sfuFvTaUiCHYZwjPTfgp2PcKt8UtITcY8R71ZKIO35YoA==
X-Received: by 2002:aca:75c1:: with SMTP id q184mr369725oic.35.1583186457287;
        Mon, 02 Mar 2020 14:00:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 67sm6819519oid.30.2020.03.02.14.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:00:56 -0800 (PST)
Received: (nullmailer pid 6837 invoked by uid 1000);
        Mon, 02 Mar 2020 22:00:55 -0000
Date:   Mon, 2 Mar 2020 16:00:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        Sebastian Reichel <sre@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 1/9] dt-bindings: battery: add new battery parameters
Message-ID: <20200302220055.GA6779@bogus>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
 <a834eda9015145e978da16d89857b78669a2b9c8.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a834eda9015145e978da16d89857b78669a2b9c8.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 25 Feb 2020 10:52:04 +0200, Matti Vaittinen wrote:
> Add:
> 
>  - trickle-charge-current-microamp:
> 
> Some chargers have 3 charging stages. First one when battery is almost
> empty is often called as trickle-charge. Last state when battery has been
> "woken up" is usually called as fast-charge. In addition to this some
> chargers have a 'middle state' which ROHM BD99954 data-sheet describes as
> pre-charge. Some batteries can benefit from this 3-phase charging
> [citation needed].
> 
> Introduce trickle-charge-current-microamp so that batteries can give
> charging current limit for all three states.
> 
>  - precharge-upper-limit-microvolt:
> 
> When battery voltage has reached certain limit we change from
> trickle-charge to next charging state (pre-charge for BD99954). Allow
> battery to specify this limit.
> 
>  - re-charge-voltage-microvolt:
> 
> Allow giving a battery specific voltage limit for chargers which can
> automatically re-start charging when battery has discharghed down to
> this limit.
> 
> - over-voltage-threshold-microvolt
> 
> Allow specifying voltage threshold after which the battery is assumed to
> be faulty.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> 
> Changes from rfc-v3:
>   Fixed typo in commit message battry => battery
> 
>  Documentation/devicetree/bindings/power/supply/battery.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
