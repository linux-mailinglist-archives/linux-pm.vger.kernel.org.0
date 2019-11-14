Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27380FBD97
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2019 02:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfKNBo2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 20:44:28 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38797 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNBo2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 20:44:28 -0500
Received: by mail-oi1-f193.google.com with SMTP id a14so3783594oid.5;
        Wed, 13 Nov 2019 17:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XksZDpsl+U9eidQT9vUr4VQK7VIl76Oi7Z4m7FmcSig=;
        b=eiGEAnKohzglrL+17a7LCbDm1IcEOgMAYqAgltZwgEb0N/JojEnxfjl4dyChthdIhM
         K1lpRMX5/UFYq0IhTSFpZ1qoM/C9NfqJcWFwOMDml2aNIpfInylEl9Tb3UaTv93iedQ1
         hOI3/AbE3xchVBao9hKQpo5u27iKne/oElr555fFG7WHi1N/9pZ2AfNZBFJDBoT/ic+e
         n5iF9E11hqcLvlFSztXaZBA++9FgZkXI++T8SAmLpJ845S69Ccdt3j/sbmSB8SwjRqN0
         OxKnXF1c6mKbUKQ/tJhssr2Pc1M+vWLwjUv43O2P9NVGuQBybuHg7BJ+01XkwaPovCdF
         AqYw==
X-Gm-Message-State: APjAAAULh32ryAhTitGP+KVmz4zg9YbBepVlOIzBiEigWEA1TEOb+QgL
        DjDaShGk1yATyZpdsr9hC4SJLdA=
X-Google-Smtp-Source: APXvYqx2Eeg+6EnhJgfdAOYmTb/PvPNHZCErIRw9s8XIEA97Diy6JQJHOsXE/C4FqFN6moMduEPhwQ==
X-Received: by 2002:aca:845:: with SMTP id 66mr1397732oii.137.1573695867242;
        Wed, 13 Nov 2019 17:44:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h79sm1303959oib.3.2019.11.13.17.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 17:44:26 -0800 (PST)
Date:   Wed, 13 Nov 2019 19:44:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        peter.maydell@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: power: reset: document the QEMU RISC-V
 virt machine poweroff device
Message-ID: <20191114014425.GA1748@bogus>
References: <20191107212408.11857-1-hch@lst.de>
 <20191107212408.11857-2-hch@lst.de>
 <alpine.DEB.2.21.9999.1911071431390.8918@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1911071431390.8918@viisi.sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 07, 2019 at 02:32:01PM -0800, Paul Walmsley wrote:
> On Thu, 7 Nov 2019, Christoph Hellwig wrote:
> 
> > Add the binding for the trivial Qemu RISC-V poweroff mechanism, which is
>
> There's nothing RISC-V specific here.  This IP isn't defined in the RISC-V 
> specifications, or anything like that.  

Does the VM have a spec or anything? Would be nice if it did. Would be 
nicer still to just copy Arm's virt machine.

> Apparently it's a SiFive IP block which now has a virtual IP 
> implementation in QEMU in hw/riscv/sifive_test.c.  But since there's 
> nothing RISC-V specific about this IP block, any QEMU system, with any CPU 
> implementation, should be able to use this virtual IP, and this Linux 
> driver.
> 
> For these reasons, it's better if "RISC-V" is just removed from everywhere 
> in this driver.  If something needs to go in its place, "SiFive" may be 
> better.

IIRC, there's already syscon poweroff binding. You could probably use 
that.

> 
> 
> - Paul
> 
> 
> > just a single MMIO register exposed through the DT.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  .../power/reset/qemu-riscv-virt-poweroff.txt     | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt b/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
> > new file mode 100644
> > index 000000000000..80ff6fd4e3b7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/reset/qemu-riscv-virt-poweroff.txt
> > @@ -0,0 +1,16 @@
> > +QEMU RISC-V virt machine poweroff device
> > +
> > +This is a device in Qemu that can signal successful or error exit
> > +by writing two magic numbers to a trivial mmio register.
> > +A Linux poweroff is implemented as successful exit.
> > +
> > +Required Properties:
> > +-compatible: "sifive,test0"
> > +-reg: Specifies the physical address of the register
> > +
> > +Example:
> > +
> > +	test@100000 {
> > +		compatible = "sifive,test0";
> > +		reg = <0x100000 0x1000>;
> > +	};
> > -- 
> > 2.20.1
> > 
> > 
> 
> 
> - Paul
