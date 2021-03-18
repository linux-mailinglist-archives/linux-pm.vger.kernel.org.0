Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6673401C2
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCRJRx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhCRJRt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Mar 2021 05:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0D2E64E45;
        Thu, 18 Mar 2021 09:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616059068;
        bh=RHPm0aTDhQQOUl3GmYCviNCWiJxKMZNtLqVWKMLsZgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbdC7EWzfslFEFB3CQQeuuBecoTomFIwZAQ/LN9XyjMHVKDtVsq+FfgZvrSRHr3HC
         ST73UC+bt9FN8wPo0A4GMuPb5U01nyfPUflLZamoGyuVw/gri2LX7rrr92TtOGtA3x
         9/+50sgzwdtFBIIgUZN/G+3QJDI+hC0As3QCq6+z6sqlmUKNsdjr2BwbuYK7ar8Yfp
         R+ql6S96rxDFKOHIn8GmQcEGAviRXHgl7lRoIMA/ANtmRDjuNlezHYRvNRGWAe6NfO
         xpkRm7+koY2c+D/lrrjO+RJqOYDA+m1dI5t3psSzXFE6w0gSeG7d/3qYPu8ZJEWxTD
         Icd0ZKhr22UPw==
Date:   Thu, 18 Mar 2021 14:47:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] interconnect: qcom: Add SM8350 interconnect
 provider driver
Message-ID: <YFMauIq/L83Trvv6@vkoul-mobl.Dlink>
References: <20210302134323.2822076-1-vkoul@kernel.org>
 <20210302134323.2822076-3-vkoul@kernel.org>
 <0c405a3c-1759-34f3-08c6-116444479b09@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c405a3c-1759-34f3-08c6-116444479b09@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-03-21, 09:08, Georgi Djakov wrote:
> Hi Vinod,
> 
> On 3/2/21 15:43, Vinod Koul wrote:
> > Add driver for the Qualcomm interconnect buses found in SM8i350 based
> 
> Still SM8i350? Have you checked my comments on v1?

Oops missed to fix the commit log :(


> > +config INTERCONNECT_QCOM_SM8350
> > +	tristate "Qualcomm SM8350 interconnect driver"
> > +	depends on INTERCONNECT_QCOM
> > +	depends on (QCOM_RPMH && QCOM_COMMAND_DB && OF) || COMPILE_TEST
> 
> Again: depends on INTERCONNECT_QCOM_RPMH_POSSIBLE

fixed now

> > +#include <linux/device.h>
> > +#include <linux/interconnect.h>
> > +#include <linux/interconnect-provider.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> 
> Is this used?

I need either of_device or of_platform, not both :)

I decided to keep of_device and also get rid of device.h

Also checked we can remove interconnect.h as interconnect-provider.h
already has it. So will send these in next version shortly

-- 
~Vinod
