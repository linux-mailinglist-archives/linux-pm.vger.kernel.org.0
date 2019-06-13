Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0844EF6
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 00:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfFMWHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 18:07:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:47094 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfFMWHc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 18:07:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id x18so400393qkn.13;
        Thu, 13 Jun 2019 15:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhWdQ+n9lb5V8igkIdjlDGkO+bOshDClHntzHo4xkx4=;
        b=pB8ZQhLWydN7xaJSbR0D7SlL/nA6gyRv96uz10UScA+WoCvpn7fjWrqtlEFr0yZVOA
         2stJzMuVMJg+dWmZDFI+kw3yKZCKyjGza3X9ZSKfTe/0XoaHqEbQ4uG1GRgIXIXfcfk+
         cZH781VT2lUFcGyFEAAAh/+XLJWO5E/dRnx8mLx+HTf8eSJSfqATq6d523izP75RROJ1
         Da8gHmb/p/rfdxl1/y/QxTR3NXJMA4/Xgmjx4wHJ1NWD1SyFzzYQF0LkUjhDurgfL4q5
         UETq1WCB1dgUDZ2IkceOjMcUJIl1RatDFA0hoEpmDGfsp8qQkZoubz37swFV6enAYvAh
         v4hw==
X-Gm-Message-State: APjAAAVF7fVuQSZgobzul++G9TT1Hrw8snyz/c3/KIcxfdvmWu3mYaLT
        pRJAVAqR+NVp5AQ2ByMJjA==
X-Google-Smtp-Source: APXvYqzlg3l0HADoNTIkv5SXk7nuuzVo6Jw7oSlbsAolVM+MxEBgZazQrw5oWThYP2sbSY8L9PzBsg==
X-Received: by 2002:a37:6512:: with SMTP id z18mr73992402qkb.158.1560463650992;
        Thu, 13 Jun 2019 15:07:30 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id t8sm708240qtc.80.2019.06.13.15.07.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 15:07:30 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:07:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: Add 'little-endian'
 and update Chassis define
Message-ID: <20190613220729.GA29761@bogus>
References: <20190517024748.15534-1-ran.wang_1@nxp.com>
 <20190517024748.15534-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517024748.15534-2-ran.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 17 May 2019 10:47:47 +0800, Ran Wang wrote:
> By default, QorIQ SoC's RCPM register block is Big Endian. But
> there are some exceptions, such as LS1088A and LS2088A, are Little
> Endian. So add this optional property to help identify them.
> 
> Actually LS2021A and other Layerscapes won't totally follow Chassis
> 2.1, so separate them from powerpc SoC.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
