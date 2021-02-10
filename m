Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A3831661E
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 13:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhBJMKN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 07:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:36370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231235AbhBJMIK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 07:08:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E74F264DC3;
        Wed, 10 Feb 2021 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612958849;
        bh=cQGtFE4aZovlxrzFhV+ZYf3V3W61OJ8W6QnkpvS4GPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7IvWr4IUPq9YlK9l9MHeOzJOXDVgoYkBwIGl8kPp52cG+3Hp41LoWyvNICmCDZiS
         D+LY4683mlXFCOPmfW1iR1y/9vsYY4CeAqhQppyAuu/cZDEYRUBlRCpylg4Of92lS8
         zVkwA0lWCaU3Po5vPwtb9Wmd0tJgxqXequTZTO/b9/CJrNKf2EeuMSk7idveChCoSb
         FjUD6Mj2SExSQaSpBhVVpllEej4I4hVk14JIafVIsIl6RQXcBkYuunX9/LD/vM60Cs
         cRvFd37cusCbKEoE30fJhhyKfK7XZ8gi2a1irqk81Y+xc3QSexpAcXvCIr8rQjw8og
         7BgvHA1YHKXrg==
Date:   Wed, 10 Feb 2021 17:37:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM8350 DT
 bindings
Message-ID: <20210210120725.GE2774@vkoul-mobl.Dlink>
References: <20210210104724.340991-1-vkoul@kernel.org>
 <30719cbd-6702-4b1e-2117-e5b8f11fd68d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30719cbd-6702-4b1e-2117-e5b8f11fd68d@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Gerogi,

On 10-02-21, 13:30, Georgi Djakov wrote:

> > +#define SM8350_MASTER_LLCC_DISP				1000
> > +#define SM8350_MASTER_MNOC_HF_MEM_NOC_DISP		1001
> > +#define SM8350_MASTER_MNOC_SF_MEM_NOC_DISP		1002
> > +#define SM8350_MASTER_MDP0_DISP				1003
> > +#define SM8350_MASTER_MDP1_DISP				1004
> > +#define SM8350_MASTER_ROTATOR_DISP			1005
> > +#define SM8350_SLAVE_EBI1_DISP				1512
> > +#define SM8350_SLAVE_LLCC_DISP				1513
> > +#define SM8350_SLAVE_MNOC_HF_MEM_NOC_DISP		1514
> > +#define SM8350_SLAVE_MNOC_SF_MEM_NOC_DISP		1515
> 
> Why are you using these big numbers? They are used as array indexes
> and we will be wasting a lot of memory for unnecessary large arrays.

Thanks for the explanation, yes that would be the case. I will split it
up and send v2

-- 
~Vinod
