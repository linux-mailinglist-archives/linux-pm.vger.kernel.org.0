Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92127B4DD
	for <lists+linux-pm@lfdr.de>; Mon, 28 Sep 2020 20:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgI1S6L (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Sep 2020 14:58:11 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:38226 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgI1S6L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Sep 2020 14:58:11 -0400
Received: by mail-oo1-f67.google.com with SMTP id r10so600505oor.5;
        Mon, 28 Sep 2020 11:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VlxqxH24WEJogVbYmNyI0XBntrebIN0nleBQLFM2PBU=;
        b=cpqAwYxfHRBHlci1Qm58ySpXKISWX9YVUqntu4r5cN9H/4S/3OzDraI4lmzk/7aj7h
         bWPeVLHQaC00FEab6SwCJ74qs4TWysa35XXdheQqNj2K8zhsxveuFl6dGGZ8sIqBsluv
         BUJpJ4QmDpSMh4YEvdOnzBtBnwzvHl7/kZsfKpeWyIgckLgZffNv0Beo1muU97xhggFh
         YOOy8mOuHm+VRmyyxCsXABw4CoAQs4H8mmGVRhZzey50GKaqQZbdczSya6E3kF6Bcvs7
         OR3OEu9lskOHqWd9d+z8F61dSWIaK+y12sy8Ysffpv8Bf+FXCV9jhoVh7KRSaeKZrFOZ
         tYVQ==
X-Gm-Message-State: AOAM5328H8DIB3nvAwXIenQM9fKI4z2boS8z1YLwMHW6s3NggzOKm0gG
        SIKDPtMQF+RZZ150z1tDyA==
X-Google-Smtp-Source: ABdhPJyrk1od3/oBE+mU6P1bPqJLVVHHvQBDfq+YHBprH7X/AyOr8Q6Iclpi8G2HTlaMr/5stDL+5g==
X-Received: by 2002:a4a:e616:: with SMTP id f22mr1870745oot.11.1601319490492;
        Mon, 28 Sep 2020 11:58:10 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b1sm2278068oop.47.2020.09.28.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:58:09 -0700 (PDT)
Received: (nullmailer pid 3078228 invoked by uid 1000);
        Mon, 28 Sep 2020 18:58:09 -0000
Date:   Mon, 28 Sep 2020 13:58:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Angus Ainslie <angus@akkea.ca>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Re: [PATCH v4 1/2] power: bq25890: document IBAT compensation DT
 properties
Message-ID: <20200928185809.GA3078178@bogus>
References: <cover.1601146802.git.mirq-linux@rere.qmqm.pl>
 <edd68202c51088d6f5f539a7d8464fff049ff837.1601146802.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edd68202c51088d6f5f539a7d8464fff049ff837.1601146802.git.mirq-linux@rere.qmqm.pl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 26 Sep 2020 21:05:34 +0200, Michał Mirosław wrote:
> Document new properties for IBAT compensation feature.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
> v2: initial version
> v4: renamed properties applying property-suffix
> ---
>  Documentation/devicetree/bindings/power/supply/bq25890.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
