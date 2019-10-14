Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03CD683B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 19:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfJNRTD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Oct 2019 13:19:03 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40867 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbfJNRTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Oct 2019 13:19:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id y39so14446447ota.7;
        Mon, 14 Oct 2019 10:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oawtn+ZtULQjiLVim+vckZa5eaPMWsScI+Ob1030FAs=;
        b=lPbImLFcLWmJa7pEc6i+5n62mB+Ph+vqCpAL2oHYX6RgvTIOAsRi0QUVsfhDYdc8+L
         6VYI4vWJsqTUXw00lamV4DfIzHNuYqAYg6KRiqAn8MORFiGmj5WETFLgrdENFTDKhTUl
         RkGCZHuJYLlBw0/XdrEhFu4Cuv5GCPULV2I9YPZxggODsaDHABsyLcSy0pgvcW8ZU28a
         hiccvEzpN9HCdKNXsneSS3i2GLPQW8L2WVZCdLMUFAs+/MMx0Z+/f3jZCmcIYOm8oUgg
         WknN6Pgs2xvcVCZgfNdZSfYjx7J8iecwwmWlFtnPewM5ivTWjrO5KFux24y06cbrItRn
         5moA==
X-Gm-Message-State: APjAAAVTk7rjllK2lGLztOU1/2hOX3kOr+j/I3Ym3hLRUwAzmXi8mD6x
        GcM4eqN4ExT24jsJLKDdTN7We7M=
X-Google-Smtp-Source: APXvYqyPtnEO4APY3yw1HpmCGICMIlAbQFIjbEAo3JeIS6WLqjZNALfT21r09YAL7iS9fjzlr9BLKQ==
X-Received: by 2002:a9d:7993:: with SMTP id h19mr4679414otm.226.1571073542158;
        Mon, 14 Oct 2019 10:19:02 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c19sm5576940oib.21.2019.10.14.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 10:19:01 -0700 (PDT)
Date:   Mon, 14 Oct 2019 12:19:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] dt-bindings: thermal: Convert stm32 thermal bindings
 to json-schema
Message-ID: <20191014171900.GA8680@bogus>
References: <20191014092200.24179-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014092200.24179-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 14 Oct 2019 11:22:00 +0200, Benjamin Gaignard wrote:
> Convert the STM32 thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> changes in v3:
> - use (GPL-2.0-only OR BSD-2-Clause) license
> - fix indentation
> - add additionalProperties: false
> - add #thermal-sensor-cells property 
> 
>  .../bindings/thermal/st,stm32-thermal.yaml         | 79 ++++++++++++++++++++++
>  .../devicetree/bindings/thermal/stm32-thermal.txt  | 61 -----------------
>  2 files changed, 79 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/st,stm32-thermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/stm32-thermal.txt
> 

Applied, thanks.

Rob
