Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA54615832E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2020 20:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgBJTBe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Feb 2020 14:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgBJTBd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Feb 2020 14:01:33 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F1862080C;
        Mon, 10 Feb 2020 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581361293;
        bh=hfd+qk1h5SK9bd1Ir48S/em+hSG8dzRp5pZAPDAAMIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ojh684A1y1NmPWSzbUM54xdXc/WNHGWox35GRur1T+b0ouLumY3A6m2a+iltPQVRc
         17gRdhIrC70KqY/Ei19dRx0+aQYcQOxdZxZtZQGPB3xh/cu8yjruisN0jayque3gNW
         fyo4qu5bEQs+tucceMMTA4cST9nXBWFWnXaT0H0I=
Date:   Mon, 10 Feb 2020 11:01:32 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, linux-crypto@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] debugfs: regset32: Add Runtime PM support
Message-ID: <20200210190132.GB1058087@kroah.com>
References: <20200124132957.15769-1-geert+renesas@glider.be>
 <20200124132957.15769-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124132957.15769-2-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 24, 2020 at 02:29:56PM +0100, Geert Uytterhoeven wrote:
> Hardware registers of devices under control of power management cannot
> be accessed at all times.  If such a device is suspended, register
> accesses may lead to undefined behavior, like reading bogus values, or
> causing exceptions or system locks.
> 
> Extend struct debugfs_regset32 with an optional field to let device
> drivers specify the device the registers in the set belong to.  This
> allows debugfs_show_regset32() to make sure the device is resumed while
> its registers are being read.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  fs/debugfs/file.c       | 8 ++++++++
>  include/linux/debugfs.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index dede25247b81f72a..5e52d68421c678f2 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/atomic.h>
>  #include <linux/device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/poll.h>
>  #include <linux/security.h>
>  
> @@ -1057,7 +1058,14 @@ static int debugfs_show_regset32(struct seq_file *s, void *data)
>  {
>  	struct debugfs_regset32 *regset = s->private;
>  
> +	if (regset->dev)
> +		pm_runtime_get_sync(regset->dev);
> +
>  	debugfs_print_regs32(s, regset->regs, regset->nregs, regset->base, "");
> +
> +	if (regset->dev)
> +		pm_runtime_put(regset->dev);
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> index bf9b6cafa4c26a68..5d0783ae09f365ac 100644
> --- a/include/linux/debugfs.h
> +++ b/include/linux/debugfs.h
> @@ -35,6 +35,7 @@ struct debugfs_regset32 {
>  	const struct debugfs_reg32 *regs;
>  	int nregs;
>  	void __iomem *base;
> +	struct device *dev;	/* Optional device for Runtime PM */
>  };
>  
>  extern struct dentry *arch_debugfs_dir;

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
