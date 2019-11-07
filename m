Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7605F3B6B
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfKGWcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 17:32:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35568 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKGWcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 17:32:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id d13so3446891pfq.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 14:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZDZxE3X2u0Q7iWpkFaFMXlQVwx+tT1FJavF2B89FPtQ=;
        b=QtH1+NFXJ0zzfuKxuEMoDpcPK9ve7QSvHogyfZ1LD7WbXf1vDvHk1gduDooLeS3gSa
         OQ3Iuy0iZC41baX078kKCIeaia9GMa3KjZi9B/3VjKahrxuaPICa6MWCXjekHjmiy0Y1
         SY2EiKmne3GXAJRmsBQsy2QSW4VDhhxYelSb5nKn8Oq0uZBjnmvBdve2KYmQ3tg6cpX9
         iDI5aqWNyVmHm4b5vPv1Fe+BH9/fNlR+2jpvh52/fjAPY4wfFFLhpwl5wwhwcMvyUiEg
         CT/ddVBror3UdtXZOJDJMDyl93GUbm3Cn/qDOnh6C7iuStCKkoIv03sv3cKV9P+MavEw
         Rc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZDZxE3X2u0Q7iWpkFaFMXlQVwx+tT1FJavF2B89FPtQ=;
        b=KCZpyH6OWYhwVYelyUdU22Pp8eIkpQl9ZHAqV37xSm+fetGcDBEU9Q5ewoGvX1qOox
         57hTn+OXnmBdYONQGsk1OvZdPTi8NCJtkyLXWrz0id/fCbBEuVmSTmFqz0jtzeJbhAB6
         5UFLhqGY8H/FGHPKbjSDvJSLz0t1eNAymkqvjNQN0aac0TmcvpoweKQfy87LiXDc03L6
         3Y9ilWA30KHHU50m2lgXjsz0R78dBbAGGn+L+TbTzhGPkJLD4LpaCdglZqGfUhf/nHfD
         5z9bVhygFC+m70Q6FxeN3PGRqJNTmmEdDAZPLLW312J5VMOXz7YZZmyTkTyOBicitujM
         19fQ==
X-Gm-Message-State: APjAAAVpOYy3kn5y4kq2THsnqcPWiBps8eAk/ppRx211WUBokp2PpYIy
        TUYYlcKr4xoxH9cVusrXzjyFpg==
X-Google-Smtp-Source: APXvYqwls8ddOTQNH1en07qze09B+ck+PA1CQw6LiSffpWOEx3b9mIFdJ4cJ6t90/fOVdQWQ78m/kg==
X-Received: by 2002:a63:8f5e:: with SMTP id r30mr7741111pgn.146.1573165923226;
        Thu, 07 Nov 2019 14:32:03 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w15sm3662519pfn.13.2019.11.07.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 14:32:02 -0800 (PST)
Date:   Thu, 7 Nov 2019 14:32:01 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        peter.maydell@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: power: reset: document the QEMU RISC-V
 virt machine poweroff device
In-Reply-To: <20191107212408.11857-2-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1911071431390.8918@viisi.sifive.com>
References: <20191107212408.11857-1-hch@lst.de> <20191107212408.11857-2-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Nov 2019, Christoph Hellwig wrote:

> Add the binding for the trivial Qemu RISC-V poweroff mechanism, which is

There's nothing RISC-V specific here.  This IP isn't defined in the RISC-V 
specifications, or anything like that.  

Apparently it's a SiFive IP block which now has a virtual IP 
implementation in QEMU in hw/riscv/sifive_test.c.  But since there's 
nothing RISC-V specific about this IP block, any QEMU system, with any CPU 
implementation, should be able to use this virtual IP, and this Linux 
driver.

For these reasons, it's better if "RISC-V" is just removed from everywhere 
in this driver.  If something needs to go in its place, "SiFive" may be 
better.


- Paul


> just a single MMIO register exposed through the DT.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../power/reset/qemu-riscv-virt-poweroff.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt b/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
> new file mode 100644
> index 000000000000..80ff6fd4e3b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
> @@ -0,0 +1,16 @@
> +QEMU RISC-V virt machine poweroff device
> +
> +This is a device in Qemu that can signal successful or error exit
> +by writing two magic numbers to a trivial mmio register.
> +A Linux poweroff is implemented as successful exit.
> +
> +Required Properties:
> +-compatible: "sifive,test0"
> +-reg: Specifies the physical address of the register
> +
> +Example:
> +
> +	test@100000 {
> +		compatible = "sifive,test0";
> +		reg = <0x100000 0x1000>;
> +	};
> -- 
> 2.20.1
> 
> 


- Paul
