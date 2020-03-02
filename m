Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E01764C1
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 21:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCBUP6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 15:15:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40569 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgCBUP5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Mar 2020 15:15:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so594731otp.7;
        Mon, 02 Mar 2020 12:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y8fx18mkjGrgWEeE52j2Dvkr7haAr57O85Z+l9O0SuQ=;
        b=W3F8UNKMZ6LAWeyxNnB7DFRXat73fn/UGjxHbQDite/W8TwbaZJTMwn+++Atv1+BmU
         w2WschwkbFzUDB+9LHEOUdz/rT6pPzFH408LFJaghKDTSjX6GHOUAchRkpf5rWJ+gvwe
         e0LDc7u36AALgG9dX1M+DKWg9ClMZmWkCMloGG2FPR4bwqEVVoUQy2oJdDkg3F/PNsXQ
         4YMYdi09hpT3uYQievHmCJ+dK0z9ZVQgjTTZs9EEXnqsW8AGUa/gueX7JDmN2kMZXcqv
         flrE/15Nw2FTC0H5n7rsKy4jtValPHEg0nKVhFepeN0/ddmRZ+PeFAZ5jREfvoXnyz7a
         dBCw==
X-Gm-Message-State: ANhLgQ0ZW+eq4bnHGeYlc3yxlMeN0RvI+i99VzlRKjes+1IaJcXdT2Jn
        aBM3AbbTFTSfcgP0Lbpv3A==
X-Google-Smtp-Source: ADFU+vtgqX6cTADKczY5cFP2sR6fKyifwr4RheTfsww81BtyoobjL4ONEbBcXkiHA69G160yLrxN1w==
X-Received: by 2002:a9d:5e9:: with SMTP id 96mr688518otd.307.1583180155388;
        Mon, 02 Mar 2020 12:15:55 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm6701124oif.47.2020.03.02.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 12:15:54 -0800 (PST)
Received: (nullmailer pid 22216 invoked by uid 1000);
        Mon, 02 Mar 2020 20:15:54 -0000
Date:   Mon, 2 Mar 2020 14:15:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        SoC Team <soc@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
Message-ID: <20200302201554.GA22028@bogus>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2 Mar 2020 23:54:08 +0800, Jianxin Pan wrote:
> Missing ';' in the end of secure-monitor example node.
> 
> Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
