Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4842833164F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 19:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhCHSjm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 13:39:42 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:38403 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhCHSj0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 13:39:26 -0500
Received: by mail-io1-f54.google.com with SMTP id k2so11055711ioh.5;
        Mon, 08 Mar 2021 10:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2vUMruKnMk/QUUYIf3u9nbHNj9rZrjwEcRZ9FnN9Gk=;
        b=LCW9Bs7X2fKmhKUJ3QC2ljQkayk087C9cSv0D1xnz0ux/igSvbrV0SNXdPqYgaO8c8
         hT58W7UxtuwBqmz6X5uCdo2Q3/MFS807Mg4kIJPNRKmZ2XYKea3V9229U814wu9KqYqQ
         55PdELeZE+v2LQsaUrYx3Je0WE7BrQg0MlcSqvHgOGfuHShVZEOD4bTQswfUuaRFtJIo
         4B0RYcVxPvJNUe0aY7UX6KGTYWDEaCvcv/G0aL8m86aJ66t4vQ+XfylEboyjJgUAnkRr
         whHYixg+LjCQVHrfQZy2oAxmQmHPobCsmNXjPCCIYhWj0+yTHyPim1I/332Xp4gZqRCS
         6v+Q==
X-Gm-Message-State: AOAM530lshWbn1hhSI0xo9LCZTFShi2y0yBKRfCkgKFLZRDU8GVj5Zxk
        cph2pwVAzEDDJykJu8iGDRWFzJmDtg==
X-Google-Smtp-Source: ABdhPJwc1VDMrO5IdEEYLRMeq6VpCXS5H+Bk9gqa1BpRVtVuoo1TpIe5H5QvsiBlO3a6XDgvYOSo4w==
X-Received: by 2002:a6b:5818:: with SMTP id m24mr19316588iob.144.1615228765710;
        Mon, 08 Mar 2021 10:39:25 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id a14sm6728773ilm.68.2021.03.08.10.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 10:39:25 -0800 (PST)
Received: (nullmailer pid 2761723 invoked by uid 1000);
        Mon, 08 Mar 2021 18:39:23 -0000
Date:   Mon, 8 Mar 2021 11:39:23 -0700
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Ryan Case <ryandcase@chromium.org>, devicetree@vger.kernel.org,
        Arvin Wang <arvin.wang@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@google.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V9 07/12] dt-bindings: interconnect: add MT6873
 interconnect dt-bindings
Message-ID: <20210308183923.GA2761689@robh.at.kernel.org>
References: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
 <1614656863-8530-8-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614656863-8530-8-git-send-email-henryc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 02 Mar 2021 11:47:38 +0800, Henry Chen wrote:
> Add interconnect provider dt-bindings for MT6873.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  include/dt-bindings/interconnect/mtk,mt6873-emi.h | 41 +++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt6873-emi.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
