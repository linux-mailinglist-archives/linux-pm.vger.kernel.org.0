Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7B0247898
	for <lists+linux-pm@lfdr.de>; Mon, 17 Aug 2020 23:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHQVQg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Aug 2020 17:16:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44111 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgHQVQf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2020 17:16:35 -0400
Received: by mail-io1-f68.google.com with SMTP id v6so19004768iow.11;
        Mon, 17 Aug 2020 14:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rDCtiJKzaqe7DNdchc5HjGPeD1uFdGtYifNPXbA1BIU=;
        b=AA5727xdv6IIZDImBS845sBOLI/989XiTXFNwBEFP5nPrkkq7F2lHEwSi/c9aXHZRq
         m0N0wOPwz2RXjGiP3ji5WLUwyqbfv38TOIy/8jK+XkV2OLUqyjhRi1mbrSlwC4ro6Acb
         Or3dlA/OgfTYMkTGkIau5BPhonDsUF8H2QtY5YVnFybQslkhNRCkaGWGep+ayQPwnTPb
         NZFA/0rLMnQdNinMf14xX0FSO5KPQKYcDA/vtE2FYpb9anIL2paMQOyZoVKoegXpTp7E
         iBauoKUDIkiPjPhKUQMFDDEo0l6ZMAgXjrt0zvoqLgce95sr6fHYHyDX67ZTB79CbvtF
         ZCFw==
X-Gm-Message-State: AOAM531MSv40h1TMOxXJQ6NI6PZ1fG2MCq2yBRzmcMuQG8czHj7T4Mo/
        Dn2YWYQl2WayqRrDl+CeAQBJZQ07ww==
X-Google-Smtp-Source: ABdhPJyxLh1TGAwhI6LTSdEgU+MfCWvN5NYlMapCQapWFTFmwVbyIOM2oW72MEdk6lokq4mO2c8AMA==
X-Received: by 2002:a6b:8b87:: with SMTP id n129mr13338602iod.160.1597698994177;
        Mon, 17 Aug 2020 14:16:34 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id o1sm9927469ils.1.2020.08.17.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:16:33 -0700 (PDT)
Received: (nullmailer pid 1577042 invoked by uid 1000);
        Mon, 17 Aug 2020 21:16:31 -0000
Date:   Mon, 17 Aug 2020 15:16:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, jonathan@marek.ca, agross@kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: interconnect: Add OSM L3 DT binding on
 SM8150
Message-ID: <20200817211631.GA1576986@bogus>
References: <20200801123049.32398-1-sibis@codeaurora.org>
 <20200801123049.32398-2-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801123049.32398-2-sibis@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 01 Aug 2020 18:00:43 +0530, Sibi Sankar wrote:
> Add Operation State Manager (OSM) L3 interconnect provider binding on
> SM8150 SoCs.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
