Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2C340183
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCRJKu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhCRJKh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Mar 2021 05:10:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3650464E77;
        Thu, 18 Mar 2021 09:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616058637;
        bh=2q10myDUvY1eCJGq9Sk8X1//samYf8apCjWPE+Bjc5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQImKRej3wh+wRps3xcunfhrAs+saK5uuNqP/gl+9CCADodD3/m0EFAxNb9zgt9FM
         zuYlJVVBJtIujNT9qUuqvxTp8+csY1UUw1drU4LOXTFzOKqNkrgUSm8RJ9CiDNc1VP
         1kTl2uCFZdVc7k0goxuTxnH9w2y+o6xSiem16t4umlxThw1loF+ELQD67Q7DTGbSg0
         Uac83VlPsfbTCDgFgmXaLzzPjffvRbF3XwpEsn/YjDTO9jMXQ1mnq6KDN1o+SRXK7K
         m3JixLNGWeciLI0NCkqESPcCKFOodHIpkn8KeeMiCh5jGLwgH+h8fcM+tgeIbhuOIM
         dI+48IQ6x2LzQ==
Date:   Thu, 18 Mar 2021 14:40:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add Qualcomm SM8350 DT
 bindings
Message-ID: <YFMZCQFOWEtiuljK@vkoul-mobl.Dlink>
References: <20210302134323.2822076-1-vkoul@kernel.org>
 <20210302134323.2822076-2-vkoul@kernel.org>
 <369beb35-e743-c653-0637-c895368362ef@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <369beb35-e743-c653-0637-c895368362ef@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Georgi,

On 18-03-21, 09:08, Georgi Djakov wrote:
> Hi Vinod,

> > +#define MASTER_GEM_NOC_CNOC		1
> 
> Maybe start from zero?

Yeah not sure how that got missed

> > +#define MASTER_CAMNOC_HF		0
> > +#define MASTER_CAMNOC_ICP		2
> 
> Why jump from 0 to 2?

Fixed now
-- 
~Vinod
