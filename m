Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A6C3314AB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhCHRXY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 12:23:24 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:33931 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCHRXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 12:23:06 -0500
Received: by mail-io1-f54.google.com with SMTP id o11so10802886iob.1;
        Mon, 08 Mar 2021 09:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQjWqFD5wtkyfUIW1WZ9F3A9s4yaC+w0TsogpotfHXw=;
        b=YJqLXI+y1UycUiGHy7us+1mEtGNxS5TYtrlcqV52nobLZZWZgM5X/C8YdbLDW6UpfN
         0BLw3Q5cw/iJ3oTHCPuekVryQS0dbZJvJ2Rgrvl2jjG6yYkqKKKJO4utHq4yTOo2QBix
         SgRSeM1uT5SuKCSJt/NKPDV14RuqoX3NZJv8URmiFricGS647eM+STzxtbc7aJDa7hCe
         h9Vc2RvRrhScy2LqRKKYBE03OOTw00tUTon+DTbn3A1m20LTewVzoTGqYZrff21C2fkt
         I1o8EyqYyZbUOWPkZ5jjjIKtLdPDvKSwii2O2XftU2Pn31EfcOXwxzcV5ji8JLsK/W52
         RO9w==
X-Gm-Message-State: AOAM533E9BQoFCPjTcayuhG1+pNLAhsPRUvOnbA2dA1DtXmjhKf+hdZM
        SYCWL2FJmIQ0pbjS0PKI6g==
X-Google-Smtp-Source: ABdhPJwzjYZQ0iKrMYwPPyOUdQ4fQgPZWbVP5rBhyfkE9htYbReu0KOKQeZYX+M1L1juH8ezO0Mfag==
X-Received: by 2002:a5e:c809:: with SMTP id y9mr19991612iol.192.1615224185972;
        Mon, 08 Mar 2021 09:23:05 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id c16sm6471107ils.2.2021.03.08.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:23:05 -0800 (PST)
Received: (nullmailer pid 2657013 invoked by uid 1000);
        Mon, 08 Mar 2021 17:23:02 -0000
Date:   Mon, 8 Mar 2021 10:23:02 -0700
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        martin.botka@somainline.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        angelogioacchino.delregno@somainline.org,
        Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 15/41] arm64: dts: qcom: sdm630: Add TSENS node
Message-ID: <20210308172302.GA2656960@robh.at.kernel.org>
References: <20210226200414.167762-1-konrad.dybcio@somainline.org>
 <20210226200414.167762-16-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226200414.167762-16-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 26 Feb 2021 21:03:45 +0100, Konrad Dybcio wrote:
> This will enable temperature reporting for various SoC
> components.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../devicetree/bindings/thermal/qcom-tsens.yaml       |  1 +
>  arch/arm64/boot/dts/qcom/sdm630.dtsi                  | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
