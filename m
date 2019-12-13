Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5AE11EDBC
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 23:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLMW37 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Dec 2019 17:29:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34515 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMW37 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Dec 2019 17:29:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so918539otf.1;
        Fri, 13 Dec 2019 14:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rR+gZbOwT0EsEu0FOYdJuiAybFzLvdlDbKJo+AcjvAY=;
        b=C+U1C0tE55TCA8ZuEv9mz8dY7gaSC3q/Si3knElFZo1eq6sB4xHIobqpJaQxcgp4rA
         7Ur99e2pOyDLXquhyTIMci2XoPAN2je31Pm3iIukKbUf2C8zD0Oi3/5YRuxGE1htVmwP
         B1YJ5pwaYvTQp15zadZTxPbKw3fgj4LfMFUR58bUhP/zq5mVN6Xjg/nvjt963EZ0oZh5
         PHNrPuyQ9klTT48ukhNnlWrTjtc6yioo2C5Y6//nyQNU7xXeLd7XXhqDmsTzJuiUaRif
         +uUnGRuClkLXHJyLJdRVmheN/Mk9nFn6593TTYibRUa+iqwKK7JoohjD8SN44SwOKSJK
         b0Sw==
X-Gm-Message-State: APjAAAU95cILOtq4atSnI14+lr1PTT3jQwh8xT5aNugnncmMOvTA6ZYK
        FPCzt53SjqFA925UkjrTuxU8AW4=
X-Google-Smtp-Source: APXvYqz/BOJnsfjRa1QIsTdoyon+mgLtBUzCEcJlYdRndVcChgXQfvNXFKkQfnQ7B8mLoWutEbZ+oQ==
X-Received: by 2002:a05:6830:2006:: with SMTP id e6mr16336398otp.367.1576276198049;
        Fri, 13 Dec 2019 14:29:58 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm3807433otr.8.2019.12.13.14.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 14:29:57 -0800 (PST)
Date:   Fri, 13 Dec 2019 16:29:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>
Cc:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, jolly.shah@xilinx.com,
        tejas.patel@xilinx.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: xilinx: Add bindings
 for ipi mailbox
Message-ID: <20191213222956.GA10172@bogus>
References: <1574412258-17988-1-git-send-email-rajan.vaja@xilinx.com>
 <1575283131-9339-1-git-send-email-rajan.vaja@xilinx.com>
 <1575283131-9339-2-git-send-email-rajan.vaja@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575283131-9339-2-git-send-email-rajan.vaja@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon,  2 Dec 2019 02:38:50 -0800, Rajan Vaja wrote:
> Add IPI mailbox property and its example in xilinx zynqmp-power
> documentation.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
> Changes in v2:
>  - Correct order of tx and rx in mbox-names property.
>  - Add interrupts property in example.
> ---
>  .../bindings/power/reset/xlnx,zynqmp-power.txt     | 43 ++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
