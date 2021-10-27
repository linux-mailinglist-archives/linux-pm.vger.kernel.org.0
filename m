Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DD143D2EA
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhJ0Uh7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Oct 2021 16:37:59 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43628 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240876AbhJ0Uh7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Oct 2021 16:37:59 -0400
Received: by mail-ot1-f42.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so5361041ote.10;
        Wed, 27 Oct 2021 13:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CyGyYZdhYAxTp2bbhNRVqGd+98xW6EZ+Baip4Aw2eW8=;
        b=iMuuix7ZodzOZo2ERfhA59EActs4bQh4sTcYjacR5Mw8t9XhtqIeWurYOxUGUg21IR
         JrwO7R03WqC0V/Xhrz3y8SHtrJDTVVhSRhkfegfYsDDbp/6XlUQ9EbxAdlDfmXp59XlI
         RDl7pifdLyKei84PT3PuXTnD9eZ8i3OdGImnxtN0Y4jdpoPfFzPLa+RRJuP44tI0uAfL
         ETQ9PrrESRZzDQ+q3XTo6IFvinIJC9kytbuYhDPpqAn7lgqwwZTH9tZBbR590AJwR+ZR
         Hh3yZL5FUs/xHaBPDQ0FRDXr/XMC1r0LvGvL6q/umXkONxfliK1OKFHWuU4ENcG1ZapC
         x9nQ==
X-Gm-Message-State: AOAM532Er1EzeNRuNUJJi0+zJJLt7/mHs1giqnSsDZYU95fsRkLYu7fS
        woZ7qOkFhnofRelYiPcaIyyS3lRV2Q==
X-Google-Smtp-Source: ABdhPJzIzAAGsUj6XwSFuF9o4E/LSFkzNu3ITGDixh2XBXxTAFF8hU7P3IMZv06Py4H11765HxvAcA==
X-Received: by 2002:a9d:bab:: with SMTP id 40mr2786oth.274.1635366933241;
        Wed, 27 Oct 2021 13:35:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m13sm357996oou.25.2021.10.27.13.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:35:32 -0700 (PDT)
Received: (nullmailer pid 2107680 invoked by uid 1000);
        Wed, 27 Oct 2021 20:35:31 -0000
Date:   Wed, 27 Oct 2021 15:35:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RESEND v5 1/5] dt-bindings: interconnect: Combine SDM660
 bindings into RPM schema
Message-ID: <YXm4E9d2QrKbfKpO@robh.at.kernel.org>
References: <20211021132329.234942-1-y.oudjana@protonmail.com>
 <20211021132329.234942-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021132329.234942-2-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Oct 2021 13:24:25 +0000, Yassine Oudjana wrote:
> SDM660 interconnect bindings are similar to other RPM interconnect
> providers, and now it shares the same common driver with them, so
> it is better to combine them into qcom,rpm.yaml.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/interconnect/qcom,rpm.yaml       | 103 +++++++++-
>  .../bindings/interconnect/qcom,sdm660.yaml    | 185 ------------------
>  2 files changed, 95 insertions(+), 193 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm660.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
