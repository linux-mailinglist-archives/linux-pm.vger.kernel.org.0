Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B9643723B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Oct 2021 08:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJVGwt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Oct 2021 02:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhJVGwt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Oct 2021 02:52:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8838CC061766
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 23:50:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls18so2238933pjb.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Oct 2021 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WZ+ype5zlW+h8bFNZ2YEMsUet/zXlWYw0zBHW07P/JU=;
        b=PlHArJGZkVc2JunuB9TYLN4D+5Ov9sm9BsrmHWNkShf+kyxPWYPlbP5dnnAJCuKagu
         NEex02MH3cWJb0TNad1yrsM1Ja5AR6PSMFt6v2PFXP6Hetq2ShgA89vqrnP3vGske0Uv
         h1bsoYOamJkyCxa7x58RquA25wfXSGqQop6WC6rqu2d6XZjMMiZmiGKyBxhQPGck2zTt
         KDLHACMI0VG9J0pbINLTDtxAzrbCuM0/GRtpjN2rWKlmUJRDcVh16GKB+FRNV00W/vqu
         9zjLh7tb762N6IhAP3WGSYMaBS+maU2yVcla60IFHUJe4dCWYSJRsSN6gNjH5VxjdvrK
         nDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WZ+ype5zlW+h8bFNZ2YEMsUet/zXlWYw0zBHW07P/JU=;
        b=nFCQouU9z9IiOA2/qastSEKumpq9X44Wfamf22IMT71FfxUmUCn5iKOKNbs6wsHQXI
         fcqXkwtOC2AAsYPcbXkPZgSyQxb5s5/NmfUs5ZTMg5jPTLsIfo6pCC1Zu5GQYwvUjSvn
         5ENKIg0HACWkBdVc2JTgYhFdCIrjEen/Gf/IQjdahavtPhtmhDNiVaBY2ILd8e2C/LNa
         U4i/ckrXb+bG/6s9dt1lQYt935VoZbF229WGt0y+fBON9n/tj+a9nlfhyzfkLAikwAvM
         R5E/p+R13cX4Oq4Iu99RyHqBC1RzTBU2dzn15SdPXJ1aSrKnn1Yq5luMAlykmAg8kV2A
         zKMg==
X-Gm-Message-State: AOAM5319tfW70MRBdW3IVV6ct+8hcO9F5nQ21GjTkyF4RntYTaXWHtcK
        jSxA3PMMqCA1vprMqVEnShgEzg==
X-Google-Smtp-Source: ABdhPJxQMjnCGTaknosIvlVPyTMdNa0CFzWJY6NyS1nvx/0OeI0uuhyCBQOcxv/Eo1m8QiMod18Abw==
X-Received: by 2002:a17:902:6bc5:b0:13f:f585:4087 with SMTP id m5-20020a1709026bc500b0013ff5854087mr8495827plt.32.1634885431977;
        Thu, 21 Oct 2021 23:50:31 -0700 (PDT)
Received: from localhost ([106.201.113.61])
        by smtp.gmail.com with ESMTPSA id me18sm8407427pjb.33.2021.10.21.23.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 23:50:31 -0700 (PDT)
Date:   Fri, 22 Oct 2021 12:20:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: opp: Allow multi-worded node names
Message-ID: <20211022065029.x5a5oh7mh2sjofey@vireshk-i7>
References: <20211019231905.2974-1-digetx@gmail.com>
 <YXAr4OlhucAibMlH@robh.at.kernel.org>
 <20211022044334.4yn3i4kwinbrjicd@vireshk-i7>
 <48de7f40-deda-739d-96ca-e61ec5a0b257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48de7f40-deda-739d-96ca-e61ec5a0b257@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-10-21, 09:40, Dmitry Osipenko wrote:
> 22.10.2021 07:43, Viresh Kumar пишет:
> > On 20-10-21, 09:46, Rob Herring wrote:
> >> On Wed, Oct 20, 2021 at 02:19:05AM +0300, Dmitry Osipenko wrote:
> >>> Not all OPP table names and OPP entries consist of a single word. In
> >>> particular NVIDIA Tegra OPP tables use multi-word names. Allow OPP node
> >>> and OPP entry name to have multi-worded names to silence DT checker
> >>> warnings about the multi-word names separated by hyphen.
> >>>
> >>> Reviewed-by: David Heidelberg <david@ixit.cz>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> >>> index ae3ae4d39843..298cf24af270 100644
> >>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> >>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> >>> @@ -22,7 +22,7 @@ select: false
> >>>  
> >>>  properties:
> >>>    $nodename:
> >>> -    pattern: '^opp-table(-[a-z0-9]+)?$'
> >>> +    pattern: '^opp-table(-[a-z0-9]+)*$'
> >>
> >> I don't see how this helps you. What I see needed upstream is a prefix:
> >>
> >> '-?opp-table(-[0-9]+)?$'
> > 
> > I wonder if we should disallow that to keep naming more 
> 
> I also think that postfix variant should be disallowed for consistency.
> I sent out patches for both variants.
> 
> V2 uses pattern that supports both naming schemes. If V2 is less
> appropriate, then please take this V1.

I didn't like V2, we can mandate to keep it like opp-* and opp-table-*.

This patch looked okay to me, lets see what Rob has to say.

-- 
viresh
