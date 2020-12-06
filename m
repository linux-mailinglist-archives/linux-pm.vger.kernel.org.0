Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF95C2D054C
	for <lists+linux-pm@lfdr.de>; Sun,  6 Dec 2020 14:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbgLFNol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 6 Dec 2020 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFNok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2020 08:44:40 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DBAC0613D1;
        Sun,  6 Dec 2020 05:44:00 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b73so10784397edf.13;
        Sun, 06 Dec 2020 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K3LhEesmWv5BmeOieMFYtK0OjNdZwovFc4Fkys5J8eY=;
        b=TBvCtZExc2F4bqx0+RmEfpihQd4j2OvwXLIkCn1+OFfJDl6fxUtfbz7rh1VgxjRYhX
         M2tWwxX4MMCGPW3sSJllp67bweNps04xkRtoYSNGZQE5oy6RKn08HKs6sgDQX+NKXh2r
         QlfpXn9+UgHePMOkVU2oXztiTfBtpYIKHii714jwzFLJEFcpCYLTHEZ/Yd/2tJVn1l90
         V86RKa9+vb+ub+e5nbYSEdH1HUDS9u/dM2DD2GS7xYRaFTB7SJ9HzbQLdm7tMhg5dS/z
         42CJ71+UH1GjSgEfKKFElZAFoawM8TsR/bbPd6Xo1fQIbjCcjy1b6HDc5MrOqnG/+ehT
         60OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K3LhEesmWv5BmeOieMFYtK0OjNdZwovFc4Fkys5J8eY=;
        b=sPdhN8Wm37JFWMWUOPS7yEexAaUTLMqR1+xbqWlrtJcG94Faf9XereZreMaMPpaotN
         //EBXbdaAYI8bW/tprK5bFVUKKSzOgIUnFSnSUlarbwEYzXLr5zBQUaGceMn8B04Lclq
         9ESbmkIpR+eS15Fc477pZPlri5Pu53eKfM733BB0jJQkbt3uHnsUG7hxozefK8dZZ657
         bod/yLcgzdrsu8IDcawXrZIPnuwRgbnR3QRVqbO+0px9//hJK4UAm1CQJ7eTpaopfxOn
         QVf6OMrY1L2P+ajB6DenMv5LrbkwzuotAcxedpjduFZPVdwD4ZdtrLJ+1PvuNtsqSxe/
         ML+A==
X-Gm-Message-State: AOAM533SFtv06LV2HTLkc4HOKeGfMaiSDPykLCTa/cu5xhs3mptJyr4i
        MzYEQRgs5NX/4g64vxv88jAUy7mIjQU4xw==
X-Google-Smtp-Source: ABdhPJzJchVLZzukVDULqSwbn/ZttMrtqlgFoo20F2MG5PcA08+ds/HNj4nzW6aw5jb+n9SzacQGqw==
X-Received: by 2002:aa7:c1c6:: with SMTP id d6mr16024798edp.275.1607262239156;
        Sun, 06 Dec 2020 05:43:59 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id c23sm8927929eds.88.2020.12.06.05.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 05:43:58 -0800 (PST)
Date:   Sun, 6 Dec 2020 15:44:00 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/7] input: atc260x: Add onkey driver for ATC260x PMICs
Message-ID: <20201206134400.GA201906@ubuntu2004>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <fb61c36b7a8449d76767f148f2d43447294d5038.1607216141.git.cristian.ciocaltea@gmail.com>
 <X8xMTwaUYx+s1BG7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8xMTwaUYx+s1BG7@google.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Dec 05, 2020 at 07:13:19PM -0800, Dmitry Torokhov wrote:
> On Sun, Dec 06, 2020 at 03:27:06AM +0200, Cristian Ciocaltea wrote:
> > The Actions Semi ATC260x PMICs are able to manage an onkey button.
> > This driver exposes the ATC260x onkey as an input device. It can also
> > be configured to force a system reset on a long key-press with an
> > adjustable duration.
> > 
> > The currently supported chip variants are ATC2603C and ATC2609A.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> > Changes in v3: 
> >  - Integrated Dmitry's review:
> >    * Dropped the logic around the check for 'pdev->dev.of_node'
> >    * Renamed 'ret' variable in 'atc260x_onkey_probe()' to 'error'
> >    * Used 'dev_dbg' instead of 'dev_info' on status KEY_RESET_DISABLED
> >    * Dropped 'input_dev->evbit[0] = BIT_MASK(EV_KEY);'
> >    * Removed IRQF_TRIGGER_HIGH flag on 'devm_request_threaded_irq()'
> >    * Implemented open/close to mitigate the racing issue in
> >      'atc260x_onkey_remove()' which has been dropped now
> >  - Removed the unnecessary driver compatibles
> >  - Used 'reset-time-sec' property of the parent device instead of
> >    'actions,reset-time-sec' of now obsolete and removed 'onkey' DT node
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Please merge with the rest through MFD I suppose.
> 
> Thanks.
> 
> -- 
> Dmitry

Thank you, Dmitry!
