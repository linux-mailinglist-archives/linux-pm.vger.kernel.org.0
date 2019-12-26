Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452B112ADF5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Dec 2019 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfLZSsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Dec 2019 13:48:06 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35829 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfLZSsG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Dec 2019 13:48:06 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so20797968ild.2;
        Thu, 26 Dec 2019 10:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c7RGWu0p8lbIsNI9E7gie8Qmz5Oc4gSU1eH+CTzBx1w=;
        b=gvhIPRwxbWnD/3rxq1igj07Yp26JxKX17NiPjU8lFJqcA5fTC+rbkyQo2taE6Vhrf9
         POgBjztv3udjr+icz77m/tF8BE/sE9UPpAZVS+DALPxG8gahpIk6uCluzpvvXzMhQMFA
         +G033r4COy4BdKjOzQikSX+vkSJyKcWp57ByXPZ4E/9NJPBaFsNWbKGDaCGnZ+kfnH/d
         vwp2rJ+1/U8boPbM9TlfSLla84O05oZdQpRlpMxOA2yri+irPz0eodQWijMxnIk04bvY
         bXdx0UGg2fOkdbYoMG8xXmHIaqHK8YlMaby8k4peP/inKaqi27JetS5Dfd1EAhLPmOD+
         RIPA==
X-Gm-Message-State: APjAAAWwf+xe9h3I7T2nOIJP/vRg1ZXPPMA/itamR9QtObTAfzOCimr+
        x+cMQfYTFC0Q9o7g/frwJQ==
X-Google-Smtp-Source: APXvYqzKkaWjyzChh+lwhXUm5XiDaXN/ONQ3pHPRyouH/yxHGBRhbsRuX3MClJdhh85El/7XDOT5Zg==
X-Received: by 2002:a92:5b49:: with SMTP id p70mr39327056ilb.209.1577386085085;
        Thu, 26 Dec 2019 10:48:05 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v64sm12509395ila.36.2019.12.26.10.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 10:48:04 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:48:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, sboyd@kernel.org, ilina@codeaurora.org,
        seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 3/4] interconnect: qcom: sdm845: Split qnodes into
 their respective NoCs
Message-ID: <20191226184803.GA26712@bogus>
References: <1576475925-20601-1-git-send-email-daidavid1@codeaurora.org>
 <1576475925-20601-4-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576475925-20601-4-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 15, 2019 at 09:58:44PM -0800, David Dai wrote:
> In order to better represent the hardware and its different Network-On-Chip
> devices, split the sdm845 provider driver into NoC specific providers.
> Remove duplicate functionality already provided by the icc rpmh and
> bcm voter drivers to calculate and commit bandwidth requests to hardware.
 
This breaks backwards compatibility. Is that okay for all 845 users?

> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> ---
>  drivers/interconnect/qcom/sdm845.c             | 1122 ++++++++++--------------
>  include/dt-bindings/interconnect/qcom,sdm845.h |  263 +++---
>  2 files changed, 606 insertions(+), 779 deletions(-)
