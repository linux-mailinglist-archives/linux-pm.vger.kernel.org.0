Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4ABD74344
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 04:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389111AbfGYC00 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Jul 2019 22:26:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42223 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389109AbfGYC00 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2019 22:26:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so21880420pff.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2019 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrZNwnZZDnzjES6SEI5e3v0h9KCl3zyfb3LQV1fN1NY=;
        b=fPPUjV33twSI6jWM3NalnygQKLY88z0AMl5ULNzbzt2vA8vcf6Cwkv2M7PPr8skYJz
         ek6z2Lq7mXEQAPfhOqEo2GEqExdwTxFcI0S3EPRB9mApFV0JE/dk/PfdGOvtAEQAMF9t
         O5HUxpAQziE1Pv0GN5B/TK5LsiQZEhU34Qmx5qF1Nd72JdJgv6UjpFVUogCVyoL3127z
         W67taQ2WJWOIEnWyX/tV970/OeWr6zxgz/OsZ3gksZ3nAdkezpDzq2de1EgElszcS/Sa
         ACEfZi+qe0hMmn2+7pH1k4wSr8R8DmGsiF30O1M753bzVlQeZTSLFvzQijsmCZcr7nU9
         eunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrZNwnZZDnzjES6SEI5e3v0h9KCl3zyfb3LQV1fN1NY=;
        b=eavV5wqIXddkGc3oHmLkxVSAvRskY/LvbU6KziudCsP9qrJs+DJy9WWEvYqma/s58R
         oa8WJO+CG90DqaSuYXBmzCh3CUvkG523jnze+0ETh0En5yl4IdqVvX9VnTpBbHG20q5R
         y+gwRVaOT3i4jIJbffPu1pqeGFKM72oa6EqKUKjQ/tFEAiOqwHtlp79cuwq6kqhzrD9m
         ModhqhMEf/qirRkJ8UJo4cyAc3IU0RbUeh76ItuVt7M2YsnAt1sYVuIt+gqhCkd7B6FD
         dVY84PiflRk0YTLH+IfvfIRwsSKv7Pz4LnFzoJvNGHLP/LMNDDup5uiV0Yrmy3BucLq9
         ZYdg==
X-Gm-Message-State: APjAAAU5oH4WYzjjGOQWgWlnAzb1jn2BNaiR3Cs8vwXI3vmxEyevLiaT
        z9hkYyPp5rT2pKkugi43uSLLBQ==
X-Google-Smtp-Source: APXvYqyz15XsrgLrT3lZPRcmtKpwhIzfYvP6grfI4vt4riBNM2PXT1g9+Gyg/b4bALGpFG7nx0soFw==
X-Received: by 2002:a62:642:: with SMTP id 63mr14374079pfg.257.1564021585985;
        Wed, 24 Jul 2019 19:26:25 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id g4sm61046934pfo.93.2019.07.24.19.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 19:26:25 -0700 (PDT)
Date:   Thu, 25 Jul 2019 07:56:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson.Huang@nxp.com
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, p.zabel@pengutronix.de, ping.bai@nxp.com,
        daniel.baluta@nxp.com, l.stach@pengutronix.de, abel.vesa@nxp.com,
        angus@akkea.ca, andrew.smirnov@gmail.com, ccaione@baylibre.com,
        agx@sigxcpu.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/4] opp: of: Support multiple suspend OPPs defined in
 DT
Message-ID: <20190725022623.jzrlsxkppa35kljz@vireshk-i7>
References: <20190709080015.43442-1-Anson.Huang@nxp.com>
 <20190709080015.43442-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709080015.43442-2-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09-07-19, 16:00, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> With property "opp-supported-hw" introduced, the OPP table
> in DT could be a large OPP table and ONLY a subset of OPPs
> are available, based on the version of the hardware running
> on. That introduces restriction of using "opp-suspend"
> property to define the suspend OPP, as we are NOT sure if the
> OPP containing "opp-suspend" property is available for the
> hardware running on, and the of opp core does NOT allow multiple
> suspend OPPs defined in DT OPP table.
> 
> To eliminate this restrition, make of opp core allow multiple
> suspend OPPs defined in DT, and pick the OPP with highest rate
> and with "opp-suspend" property present to be suspend OPP, it
> can speed up the suspend/resume process.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  drivers/opp/of.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh
