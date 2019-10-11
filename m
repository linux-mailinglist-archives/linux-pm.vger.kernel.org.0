Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC4D442F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2019 17:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfJKP3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Oct 2019 11:29:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37149 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKP3T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2019 11:29:19 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so8345636oie.4;
        Fri, 11 Oct 2019 08:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0s3hufvwfwMdyJj0mwE2L9llFOTjdMrZMVagGqojKGE=;
        b=Q90x6icxmP90WcZa9MqLLwe6UG+Vx/UpC7IwuJKuZIzozPjx4TfuYBkGkNIzh+Hzr+
         QP7BG7BDIcdkivfeufNgYQ94Mop2YuTTlO/8lKtFp6rAdjfjaK6dUJ/bFgPgTq7nGJkD
         AScmi+U9UvYw62Y35+bZ4MwyrrHbE1Wj0HO55S2AcLXQIviSUzktwDXH5xYANE6s4XxO
         Nw/wrAN44bvU0bCuw61/Z/jalGT+xri+L1OwQntqjm+SnhantveeM9R1zLK1/nAhcYys
         fi6LSs9OWe+ildpFVLz0pTxdTutjF3GIklHDKBamfjfe9ytD6h4op/8n8poH1teMvls0
         GsXw==
X-Gm-Message-State: APjAAAUBj+2CqKQTlv22utPwEj8F2JBFavx6grwU8gaDH92QhLQenjxu
        NywO6uuzxPPdKkzJ5LezxyQSb6A=
X-Google-Smtp-Source: APXvYqxeDPc60Gv0vPS7Jk4X6ZnvVuf3tdXagFg2ciEOg66lig/oXXT0T5cR1LJ+l+65qGRarYvnIg==
X-Received: by 2002:a05:6808:249:: with SMTP id m9mr12789827oie.49.1570807758412;
        Fri, 11 Oct 2019 08:29:18 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 100sm2739791otl.48.2019.10.11.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 08:29:17 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:29:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     bjorn.andersson@linaro.org, georgi.djakov@linaro.org,
        agross@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: qcom: add msm8974
 bindings
Message-ID: <20191011152917.GA28441@bogus>
References: <20191005114605.5279-1-masneyb@onstation.org>
 <20191005114605.5279-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005114605.5279-2-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 05, 2019 at 07:46:04AM -0400, Brian Masney wrote:
> Add device tree bindings for the Qualcomm MSM8974 interconnect providers
> that support setting system bandwidth requirements between various
> network-on-chip fabrics.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Rob: I included in the next patch at the top a rough diagram showing the
> relationship between different buses. I wanted to include that diagram
> here, however I didn't since I assume that this document will be
> transformed into HTML. I've seen some of the text bindings in the IIO
> subsystem have nice ASCII-art diagrams, such as
> Documentation/devicetree/bindings/iio/dac/dpot-dac.txt. Do you have any
> suggestions for how this can go in the YAML bindings? Prefix the line
> with four spaces, similiar to what is done in markdown?

The long term plan (dream?) is to extract schema into rST and there's 
been some experimenting with embedded rST into description which seems 
to work. But I don't see that happening anytime soon really. We've got 
3500 bindings to convert...

So put whatever you like in the description as long as it's parseable 
yaml.

> 
> Changes since v1:
> - Don't include all compatibles in the examples. Removed interconnect
>   GPU client from example as well.
> - Dual license header file: BSD or GPL 2.0
> 
>  .../bindings/interconnect/qcom,msm8974.yaml   |  62 ++++++++
>  .../dt-bindings/interconnect/qcom,msm8974.h   | 146 ++++++++++++++++++
>  2 files changed, 208 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,msm8974.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,msm8974.h

Reviewed-by: Rob Herring <robh@kernel.org>
