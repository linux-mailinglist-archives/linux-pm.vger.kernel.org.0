Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B132F3AC1
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 22:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKGVxA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 16:53:00 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41419 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGVxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 16:53:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id p26so3368122pfq.8
        for <linux-pm@vger.kernel.org>; Thu, 07 Nov 2019 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1ZmP3Rg7HzABUgxKqQ/4jGQaai0OdMM5UHRs2UoA2Us=;
        b=l3vjWLydFjCtnlYdjNGzXOljrsJTHX7IERVD5wJFYO/t45yCELfuaDoGwYeNyVpB+n
         XJY0CrCVjHDn4tgOv41UjW04q89qVSuKyrmw3WyN+SUF2+WhB1Z2CVsZO9mXZ+3Gm0Fk
         XITUMqVoXa1++r+JUrAoyVzBswTQkxIKvy0zryDeeGCLem79epiacJJYmY4qHsYvj965
         eV0qb3WtRvntvfMLHk/3wf5DBA4WxPbPUWk18Iy2O0Fr7EYaoHFJuqkegWXJjPGLodU7
         CRMK5eKfjf8Vu2scccHhiMkieOf4DnxBcKR95/NlZ1ZoSPvrIT8aTsVKRuBoFZEizlmd
         +A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1ZmP3Rg7HzABUgxKqQ/4jGQaai0OdMM5UHRs2UoA2Us=;
        b=YhXsRpZOMuNzfXipiZCEg/HL9G9qa2CdLey4JNopw9OARxPj5DR2l2b8vZh/kiF9A0
         iggk21AAb4JF28DLblp3w+CdRimn06DWM96a9unMinidcbm0BNlK9GLXwb8wdU7vnSzK
         2V2OdWt+dKDeLtCVf5Fjn9C12uQrDNWGnnIM4iRpSuL/uCsjenLNBqxZnTnDboya+8Xd
         I5RTEe7zTd59QYT1eCnKdc84fjeIaillqDNdZ++lB/b59h2O7dq7JM3mjJwXr88PWgg3
         hSCYxdv3hYTWi5TDvY04V4+2m7VLeF0ekCxLFnt6B/FeYL4DayojrixhCj3g05eSVFFN
         E47w==
X-Gm-Message-State: APjAAAUqr/SIq5S16vbLFKnBrGgCWRy1mLImwyHMbooaB1HJCqyGwAY7
        ynAoBN7NJl3Wii5sFzBEygX8zQ==
X-Google-Smtp-Source: APXvYqzzcZmDI/kaSp6LdK1qm0znVJ6nCHWBAR7hkCC2Zt7lvAHXwwzIgNfPrMwN/CstJOHouv4T7w==
X-Received: by 2002:a63:955a:: with SMTP id t26mr7618796pgn.280.1573163579261;
        Thu, 07 Nov 2019 13:52:59 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f13sm3338842pgs.83.2019.11.07.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 13:52:58 -0800 (PST)
Date:   Thu, 07 Nov 2019 13:52:58 -0800 (PST)
X-Google-Original-Date: Thu, 07 Nov 2019 13:45:27 PST (-0800)
Subject:     Re: [PATCH 1/2] dt-bindings: power: reset: document the QEMU RISC-V virt machine poweroff device
In-Reply-To: <20191107212408.11857-2-hch@lst.de>
CC:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-5b9f028d-0839-42e5-8d6f-7fb00ac9f39d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 07 Nov 2019 13:24:07 PST (-0800), Christoph Hellwig wrote:
> Add the binding for the trivial Qemu RISC-V poweroff mechanism, which is
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

There's a third value that reboots the system, but it's only implemented in 
qemu-4.2 (not released yet) and above.  It'll be 'compatible = "sifive,test1", 
"sifive,test0";' (or at least will be when I merge my patch to do so).

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

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
