Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C6F44FC4
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfFMXDs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jun 2019 19:03:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44327 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMXDs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jun 2019 19:03:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id x47so353931qtk.11;
        Thu, 13 Jun 2019 16:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Any9+xhgAdf8Tj2YQiAeCpNAF5TdMk3cjHofJsaCPp8=;
        b=RBsd/kD11P6KMzthnpJYN124DqyUcnl14xQjo8w8DhgSxQCaSa1KfRkLTv6xfwoN7L
         +Wyuv3i4nojZgm3Fjl7Ay26ybwidM3+eWLBdZmIyz8/C/Tloy/uJ1mxRUce4/SS8HY81
         iPO8ikaKZ+xuSOS75Es6d5ZNwK028IuumI7JbmefRGirhaz5dR+ttgu2Rqx6MtE5R5ZV
         HeV27BlkBL9oRJ1eD7tY0Gn54VkvF5aKWO73zY4gR6PWhdKnDf/4RQlCNJy8Yhzs13e4
         f/7uNNHSwGVxnlGxFew0GXcAD9CQDdEPreekXS0tPhqD797OGf0V6lfiYSBd0kBLX4MY
         nFHg==
X-Gm-Message-State: APjAAAVcZTids1H2cYrguE4/a0sxWOyu1lQH3K1sGiDgnJ72RTn6hq/a
        4DZAkrAtYXAUNhbGCuvsow==
X-Google-Smtp-Source: APXvYqwP6BVE4QQ6PLKz0SdGsY6PHtqwDv2ToI4H2dca/xQK2tVqH95A1g32hz8XmVu9TPpzIdEW+A==
X-Received: by 2002:ac8:4919:: with SMTP id e25mr9443342qtq.214.1560467026455;
        Thu, 13 Jun 2019 16:03:46 -0700 (PDT)
Received: from localhost ([64.188.179.243])
        by smtp.gmail.com with ESMTPSA id i17sm508437qkl.71.2019.06.13.16.03.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 16:03:45 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:03:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH v4 2/3] Documentation: dt: binding: fsl: Add
 'little-endian' and update Chassis define
Message-ID: <20190613230344.GA6005@bogus>
References: <20190520095238.29210-1-ran.wang_1@nxp.com>
 <20190520095238.29210-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520095238.29210-2-ran.wang_1@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 20 May 2019 17:52:37 +0800, Ran Wang wrote:
> By default, QorIQ SoC's RCPM register block is Big Endian. But
> there are some exceptions, such as LS1088A and LS2088A, are Little
> Endian. So add this optional property to help identify them.
> 
> Actually LS2021A and other Layerscapes won't totally follow Chassis
> 2.1, so separate them from powerpc SoC.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v4:
> 	- Adjust indectation of 'ls1021a, ls1012a, ls1043a, ls1046a'.
> 
> Change in v3:
> 	- None.
> 
> Change in v2:
> 	- None.
> 
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
