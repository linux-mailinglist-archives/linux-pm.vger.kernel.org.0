Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E7E2BBB45
	for <lists+linux-pm@lfdr.de>; Sat, 21 Nov 2020 01:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgKUAq0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Nov 2020 19:46:26 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37241 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727149AbgKUAq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2020 19:46:26 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 58CD15C00F8;
        Fri, 20 Nov 2020 19:46:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 20 Nov 2020 19:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ucYJrYfTfYw67KZqLBN1lebNfBZ
        QfLofYDO7kwicGFo=; b=UmV6t3wWY/CvGzSDs7Je7vNPHUbdR0537tQDO0WYH6V
        8feS+S510CvsTzwNCCasS+NtBEBr2qKUyfObM3Ry0m7Z+x7OdDwDwI3xsj1w0B71
        Gj6q7IwBHAm/uj2UGlGuG9dKbXs/Y+ek/ZcoDiBvvA+i1nPMMtvj0VPkA8F7C5ge
        NhAPUCoZxeAJwh64gioQKolBEfpwofJOIgjow8dgi1tFP+E37mz+4TgIm/zBEU6M
        38h/U3hHjvj1i+WqONqKoAWN4vMAlS8/ooRUVHX7tT321m9mDFCZgEfqnNPdZJwB
        vQEag29m/YEY0izE8Ae9buwFYmPp/DteliMTw4Yqm/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ucYJrY
        fTfYw67KZqLBN1lebNfBZQfLofYDO7kwicGFo=; b=Tw/OQkizawECArtejrOegf
        nFdHFI3gQkQZg2BLT84qAEnJKnJVe3ToPEz2HvJSIcwCCAEAbKdTVHOinB5OcZXl
        q7c+yNLKrj91OwP4z94gtO/Z/hCvClwvVSXIFEBhvIccaRt07gsVaqXRtRTDOzK0
        +MJphOQFAeE4fWjrW8upiqB7oK4nwdC+wyFmej7TlWn4VGkKC5FPDdmesNfcAifS
        PoWAD9zEsT7pL0s9Z51iovGXdD3soU42HMnftsgyBQIuiolhEDjMpxJGUA2QM9jL
        1aqfEzr6KFnF/PGqMUd5z6HjOGuYWC+0fIx1EslVP5dIrxEqR/b3mJEtsZybdXbw
        ==
X-ME-Sender: <xms:YGO4XyC18F-2mJA1JBa8rjq4Rzw436itXcJrJ1_Lq_eWdedCq8wNGw>
    <xme:YGO4X8j6rR3yrIy21WxsQPqQbHxBVpDgeE9smJxMpS7LkLpD3VhkI6QeTjrDhx2s7
    eMh_43ALUPdQTUrvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeguddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtffrrg
    htthgvrhhnpedvtdeuhefgtdehleeljeeffffhudfhudeikeehgeejjeduleejkeevvddv
    feffhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeijedrudeitddrvd
    dujedrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:YGO4X1nPI4p0XgyaMSQCDfDx-hiV5WBOFIqMa4TKpRpmKjPAKqoqtQ>
    <xmx:YGO4XwyreJbLfFjKgMiWz25KFn0AsZfK6Hue1Nc62ttkcu5WzNwpbQ>
    <xmx:YGO4X3RgYc6E4Q5qtE7sxpib0GjMwVbNBxna-vQ8hFtFgZ2Bg8N_kg>
    <xmx:YWO4XxcMNJzQwqC_f6_hpDNvuVzA08jiG_Obe3XAfP6Ha-FSPVLJ6A>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD5013280064;
        Fri, 20 Nov 2020 19:46:24 -0500 (EST)
Date:   Fri, 20 Nov 2020 16:46:23 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Tushar Dave <tushar.n.dave@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
Message-ID: <20201121004623.mgbcn5ddo7hjdpfq@alap3.anarazel.de>
References: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
 <20201113204916.1144907-1-andres@anarazel.de>
 <116a81e6-7989-8077-1fc4-c9f047256e9a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <116a81e6-7989-8077-1fc4-c9f047256e9a@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 2020-11-16 10:28:04 +0100, Daniel Lezcano wrote:
> On 13/11/2020 21:49, Andres Freund wrote:
> > I noticed that I couldn't read the PCH temperature on my workstation
> > (C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to go
> > through IPMI. Looking at the data sheet, it looks to me like the
> > existing intel PCH thermal driver should work without changes for
> > Lewisburg.
> > 
> > I suspect there's some other PCI IDs missing. But I hope somebody at
> > Intel would have an easier time figuring that out than I...
> > 
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Tushar Dave <tushar.n.dave@intel.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Link: https://lore.kernel.org/lkml/20200115184415.1726953-1-andres@anarazel.de/
> > Signed-off-by: Andres Freund <andres@anarazel.de>
> > ---
> 
> Applied, thanks

Thanks for review and applying.

Greetings,

Andres Freund
