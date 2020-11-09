Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7C2AC5AF
	for <lists+linux-pm@lfdr.de>; Mon,  9 Nov 2020 21:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgKIUCw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Nov 2020 15:02:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44253 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIUCw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 15:02:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id t16so11541952oie.11;
        Mon, 09 Nov 2020 12:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCVxkwJSjblEAMus7aM6jYiFxtP7zlKllx7unS2iVPs=;
        b=jxvc3UbNiGF5ByXg+KRE3TFcqtpGwfhWZJSVnkpf2ru0mLJwuHpu1xEVv13GzYRp6N
         yzmH4g7gQxofjiGoqnmdiFSJQnshtL7GwOGDS7QUb0zcX/uW0wfLmWlQqfrTiCb1ciZZ
         uvcdL3rzqLVY9cAraBIZGIocEZJd1Fk10Nbj0MvEiVskVGiRkp3vokgS960UHt69GKmf
         2xv8MKOFcab6B41TR8BrCFQ8uePWG+WAlPAFOUwo6YtTVBbTX2fScoNnCTpEQhUfOrlG
         LcpvYCcwOtGWakaY+nbj5ud7WkJgUVsKBw3VNdSDFSzCMKbEixb6/ODZFNH9AfRwfH+f
         NRPQ==
X-Gm-Message-State: AOAM533u4SkL9h86zFlGQ5qLEQY0jNT/6oUp+cOrLwsVjfxWOQC2kdEU
        qksGPOASNFO5D52wJbgkNOf10Uw5FQ==
X-Google-Smtp-Source: ABdhPJwn27+eOjtnJjQ5ATRNjK+SDHOiGGYK3kmlfv548H1YxyZIWpsxI8cVlnH6k5jjTgSBplMsmQ==
X-Received: by 2002:aca:ac8f:: with SMTP id v137mr541401oie.134.1604952171042;
        Mon, 09 Nov 2020 12:02:51 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s193sm2607862oos.21.2020.11.09.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:02:50 -0800 (PST)
Received: (nullmailer pid 1673284 invoked by uid 1000);
        Mon, 09 Nov 2020 20:02:48 -0000
Date:   Mon, 9 Nov 2020 14:02:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, mdtipton@codeaurora.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: sdm845: Add IDs for the
 QUP ports
Message-ID: <20201109200248.GA1673248@bogus>
References: <20201105135211.7160-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105135211.7160-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 05 Nov 2020 15:52:09 +0200, Georgi Djakov wrote:
> The QUP ports exist in the topology, but are not exposed as an
> endpoints in DT. Fix this by creating IDs and attach them to their
> NoCs, so that the various QUP drivers (i2c/spi/uart etc.) are able
> to request their interconnect paths and scale their bandwidth.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  include/dt-bindings/interconnect/qcom,sdm845.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
