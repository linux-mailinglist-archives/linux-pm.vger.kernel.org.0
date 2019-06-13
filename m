Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61FED44E08
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2019 23:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbfFMVC0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 17:02:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39078 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfFMVCZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 17:02:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so59056qta.6;
        Thu, 13 Jun 2019 14:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4D3K00XMnwOrgjwZ4txSn7Ot39nTRqP9zyoKgXBDU8=;
        b=sr2GHgj2JaKIofB2P5//4hs9oLdSOV0JCUgQrcVopn8XmZJewxZbZc4f77RPNIeThF
         qWZ9i6wVw5tl+CoAYZDuK83XiZbSnAXL/aAMfs4Q8PvOtUYa+ZPm81eFU/vc/DrJif3V
         o0uKbDVG1DOOyzPeLpTFvb1Ro2Qu7ist1z/7y6v9mNVF7esqgre2nDgD94/6QZWMaIpm
         e4QNnO5VPLJyyWlF/I7qvd3ROYL6q7IQa1Vtq/EMbjFeE7kCq9iAjHZN6NY9EQ8dcL9d
         +DeglQiEZOd2a/l92BHJoHYWdicaSVOGQnG2NAXxll0a2vSvHRximKOFTC+5PWybi2S4
         fEdQ==
X-Gm-Message-State: APjAAAV7qkJQpwkYgtrNQLtL7shiCHJjbK/BxZCNETZb7MajJ8hcJvtU
        UjssgTomVUihD4IJSinCf2pLONY=
X-Google-Smtp-Source: APXvYqw3jpkOGC7fTi2PVz55HQGHU7E+aqDfj1jMVMm3+mwsQghkEuDi28fcljJXyO7U9oxR7j/0YA==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr77044173qtm.291.1560459744579;
        Thu, 13 Jun 2019 14:02:24 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id 102sm313401qte.52.2019.06.13.14.02.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 14:02:23 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:02:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Han Nandor <nandor.han@vaisala.com>
Cc:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Han Nandor <nandor.han@vaisala.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: power: reset: add document for NVMEM
  based reboot-mode
Message-ID: <20190613210221.GA13947@bogus>
References: <20190515104658.25535-1-nandor.han@vaisala.com>
 <20190515104658.25535-3-nandor.han@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515104658.25535-3-nandor.han@vaisala.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 May 2019 10:47:15 +0000, Han Nandor wrote:
> Add the device tree bindings document for the NVMEM based reboot-mode
> driver.
> 
> Signed-off-by: Nandor Han <nandor.han@vaisala.com>
> ---
>  .../power/reset/nvmem-reboot-mode.txt         | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
