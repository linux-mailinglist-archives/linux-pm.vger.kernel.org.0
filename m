Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0748285184
	for <lists+linux-pm@lfdr.de>; Tue,  6 Oct 2020 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgJFSTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 14:19:40 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:43197 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSTk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 14:19:40 -0400
Received: by mail-oo1-f68.google.com with SMTP id w25so3420645oos.10;
        Tue, 06 Oct 2020 11:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BJWbJD2f71Np9nV5SqEsQ+f8lbMmKTYWc1i1BZ6eq58=;
        b=PYYYZ1nNYPucm9eR/p5eizeUA8MmHER68Kjj5hpRnxNq8WnDao82AAnGBUMYm1BY99
         BdJZvVaQhr/IXN0usxfvjZuiOFrTdPhmHbvZxHdsA9o4SfK3B5pYdZrio2i3ctXKC+ua
         pOEGu0D0AgSFs7JhpbTjTt+v0pXcWcv+Z7BeDMVIFFlUY3Ss5zjB0i+neKq3uCCh8gZE
         KoJqYNsafDNoeV3Xxy3L8RhJsjIuXzLcu4VfeCHPyLXZ0aS8AZrQOxqlzG/x3Ghy7QqX
         dSPPftGjREqCF2Xo3bOZzrZ/dhLPJHiHAnLEIGZwu5uqcj6S7dcaLPKnvGzg7uW/W/Yi
         4Zbw==
X-Gm-Message-State: AOAM533ZO28l5Lk6/Snn8dCJzzBfTTWDYtet40FHj1CmSobj0lWp6Gg0
        zS3DQc5VyRAyBi4YCaQejA==
X-Google-Smtp-Source: ABdhPJwFL4l3f1wRexJyo8j2AuIR3ZQtB3DQa+PNN69rLAGMCtIaGFZl8KBStXM7MZMo3OrJBwy+jA==
X-Received: by 2002:a4a:3954:: with SMTP id x20mr3995362oog.6.1602008379203;
        Tue, 06 Oct 2020 11:19:39 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q8sm1331026otf.7.2020.10.06.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 11:19:38 -0700 (PDT)
Received: (nullmailer pid 2573852 invoked by uid 1000);
        Tue, 06 Oct 2020 18:19:37 -0000
Date:   Tue, 6 Oct 2020 13:19:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     kholk11@gmail.com
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        georgi.djakov@linaro.org, marijns95@gmail.com,
        konradybcio@gmail.com, martin.botka1@gmail.com,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] interconnect: qcom: Add SDM660 interconnect
 provider driver
Message-ID: <20201006181937.GA2572634@bogus>
References: <20200928195853.40084-1-kholk11@gmail.com>
 <20200928195853.40084-2-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928195853.40084-2-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 28, 2020 at 09:58:52PM +0200, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Introduce a driver for the Qualcomm interconnect busses found in
> the SDM630/SDM636/SDM660 SoCs.
> The topology consists of several NoCs that are controlled by a
> remote processor that collects the aggregated bandwidth for each
> master-slave pairs.
> 
> On a note, these chips are managing the "bus QoS" in a "hybrid"
> fashion: some of the paths in the topology are managed through
> (and by, of course) the RPM uC, while some others are "AP Owned",
> meaning that the AP shall do direct writes to the appropriate
> QoS registers for the specific paths and ports, instead of sending
> an indication to the RPM and leaving the job to that one.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  drivers/interconnect/qcom/Kconfig             |   9 +
>  drivers/interconnect/qcom/Makefile            |   2 +
>  drivers/interconnect/qcom/sdm660.c            | 919 ++++++++++++++++++
>  .../dt-bindings/interconnect/qcom,sdm660.h    | 116 +++

This goes with the binding.

>  4 files changed, 1046 insertions(+)
>  create mode 100644 drivers/interconnect/qcom/sdm660.c
>  create mode 100644 include/dt-bindings/interconnect/qcom,sdm660.h
