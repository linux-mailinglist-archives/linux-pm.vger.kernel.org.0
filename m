Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928653156F3
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 20:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhBITjo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 14:39:44 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42385 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhBIT0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 14:26:05 -0500
Received: by mail-ot1-f47.google.com with SMTP id q4so8889830otm.9;
        Tue, 09 Feb 2021 11:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lCKSYN1S/BMKGDmQxUAKaGzQhreo9bxAbsTabQriVq0=;
        b=f2zXT5ZULBvInFxM4HK4YVTSndaH8nce4GGxPp4Kj/qfvhHvtSZJoZ7AKwyJPTKwIm
         3GXiSLNWDJ4zQB7tk0h+RGWdB1o8CX51NmEEUrcNvTR66VMB3yMUrZZIpypJUDiHhpga
         QDaVyyY+elZh9PI9vpmCzteoth9nharMDDoX480v3UQQZID/qlsT/ekxZty1v8et6G53
         Gj509WiNX97mOuJsSxwkdwkUoFtg0QF2Rm04/ZlqwbRe9IWtpScJsk9fbtdLWBZWCJj4
         GTsy4Q5FVsujFKZxteRge5DfAMryKpPK9EMO+f+Z1R3d244vnqIQTqsCbuwTLS/vwPVT
         sUXw==
X-Gm-Message-State: AOAM533TNs/yd4bSCR/FRn2sQEJ8EABNXdw111jXs3b6quh1hA/U4WNi
        UNph4+MmiGwomm6eCDJRew==
X-Google-Smtp-Source: ABdhPJx6BPlprKBUC+xb/5qwJuVzUFsGtm4/bQfhNhu+3WhtLx7/Y0mh++ghwg3JoeR3YOsrjneqAg==
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr17119409otj.311.1612898517920;
        Tue, 09 Feb 2021 11:21:57 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l110sm4513430otc.25.2021.02.09.11.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:21:56 -0800 (PST)
Received: (nullmailer pid 4191780 invoked by uid 1000);
        Tue, 09 Feb 2021 19:21:55 -0000
Date:   Tue, 9 Feb 2021 13:21:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thermal: qcom: tsens-v0_1: Add support for MDM9607
Message-ID: <20210209192155.GA4191751@robh.at.kernel.org>
References: <20210127182506.52311-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127182506.52311-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Jan 2021 19:25:05 +0100, Konrad Dybcio wrote:
> MDM9607 TSENS IP is very similar to the one of MSM8916, with
> minor adjustments to various tuning values.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v1:
> - Move the defines so as not to cut into the middle of 8974 regs
> 
>  .../bindings/thermal/qcom-tsens.yaml          |   2 +
>  drivers/thermal/qcom/tsens-v0_1.c             | 100 +++++++++++++++++-
>  drivers/thermal/qcom/tsens.c                  |   3 +
>  drivers/thermal/qcom/tsens.h                  |   2 +-
>  4 files changed, 105 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
