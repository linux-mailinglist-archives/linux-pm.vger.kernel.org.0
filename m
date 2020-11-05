Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82342A863B
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbgKESlt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:41:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44007 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKESlt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:41:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id y22so2363608oti.10;
        Thu, 05 Nov 2020 10:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fVIXgOjh1eyqtxfD4XlNDuxmpl9wotMuEsmesaZnpu4=;
        b=Wk0ydcPTDsuQG/jhdrk5BySdP10Mw0FQzqQ+t0dz1+ygBTsR1MeFQGgU4t3KXQ1/xa
         aoh8jcpY9ycpQrBPUe3YjYSH1E0LNnd8NWZ4PZPblSWZ7IjiCrG0PpulAuxFbCnNl6MT
         veiBUFz58bns5IiZkiqvN5xomahpvNh1ppg9f1qDXCXjLCfE0zSTsf3zOEQl2F97Ioqb
         2bG+b8Ui0w+W3Kp607vyz6CmHn/lgxmDpgbpWkp/W8d8j5NDFNlPPzJk+QHztQmgcm49
         0f16qUi9T4QnzJnoN5bhrgnKHse4+aKV+cUKSHYLv0Qf6tzTWzgmC9ATE8mkgkxKyEyu
         c7qQ==
X-Gm-Message-State: AOAM530V+9jYFrj/TwQMwgbG0voFnn6rPEkbDp26MqUndCMY/2RJyfnZ
        4uerTUJGPOy/B6v9TygqLLyPt/FZL1xI
X-Google-Smtp-Source: ABdhPJzZQ/tAWP/1PQb5XVf3xhEi4as92wDjlH/a7C5VtUByOPCUJbSuvwN6BQSLzKzy0Cgz28WhSA==
X-Received: by 2002:a9d:1727:: with SMTP id i39mr2461476ota.96.1604601707771;
        Thu, 05 Nov 2020 10:41:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l9sm494838otn.53.2020.11.05.10.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:41:47 -0800 (PST)
Received: (nullmailer pid 1611249 invoked by uid 1000);
        Thu, 05 Nov 2020 18:41:46 -0000
Date:   Thu, 5 Nov 2020 12:41:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-pm@vger.kernel.org, sre@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: power/supply: Add ltc4162-l-charger
Message-ID: <20201105184146.GA1611189@bogus>
References: <20201103083706.29380-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103083706.29380-1-mike.looijmans@topic.nl>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 03 Nov 2020 09:37:06 +0100, Mike Looijmans wrote:
> Add support for the LTC4162-L Li-Ion battery charger. The driver allows
> reading back telemetry and to set some charging options like the input
> current limit.
> 
> This adds the devicetree bindings.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: Use microohms, add lltc,cell-count
> v3: Fix example dts to match description
> v4: Update "required" list to include micro-ohms
> 
>  .../bindings/power/supply/ltc4162-l.yaml      | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc4162-l.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
