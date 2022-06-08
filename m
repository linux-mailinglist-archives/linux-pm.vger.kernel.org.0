Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A515438D9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jun 2022 18:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245452AbiFHQ0r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jun 2022 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245214AbiFHQ0n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2022 12:26:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8092013F3E
        for <linux-pm@vger.kernel.org>; Wed,  8 Jun 2022 09:26:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l2-20020a05600c1d0200b0039c35ef94c4so9419243wms.4
        for <linux-pm@vger.kernel.org>; Wed, 08 Jun 2022 09:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlENWwzlCM90o/vUAucZ/2PTf41RpbELMXSIvxOkRsg=;
        b=kUamzuMZKjBGedJ41D2CVba2W72DHDvLXgAu+IRALCFkrP3w078R1o53D+vRCSe01F
         rNkY2vVwnVV2VRLzYbzS3O+P9k5lDvVgJ5mKk0zXBbWb6hvTVl/V8nJzd0Lu6k2UhewB
         bsL613wbo/x5NaZd+K7hm5wT4WUp6zMhwLUQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PlENWwzlCM90o/vUAucZ/2PTf41RpbELMXSIvxOkRsg=;
        b=CTfzZ3U/VpxzcUe5MZJMwovRXc8bB5AgFK6QUGMl7iEBzWwt8hoqf9m89oQQ0quCm4
         uyCJL1DVS66sH8+NOKLniPNarDWZhmS5xfBSDrlSwDbY4fLSeaq6580Ha0RT/0SdBGeE
         OKpP3XWIBm9qG7OoIj8Dalwm56q4UH2TYKOURX2DYExrG+Lrey4IpJrTLMJbUjD9iYpf
         kF3mfVwQvY8mLqyFf66ZkLd4YypoRCKP10lNYb3xx0qDqnvZhgpiibH+PwdDqJDFNGQM
         BX/C6xTAXAHeJmr/pS6Tlh2JoJLxWaqjCIJ84HrStG2DcF8MRIZlNRzQC0e+avigmF0k
         EcDw==
X-Gm-Message-State: AOAM531wgeDKYLrsxNWjm00eptMnHIP2P+Xqe9bKUYDA9irrPfIKn+J5
        F781BMbzmcOnhUeECHGsO9+Sew==
X-Google-Smtp-Source: ABdhPJyf8Brmkv7/K+wwJLIHpp3flqMDoBonSFPbtVBOY+CiA4pt1qQf2htU+BvHHGfYnZWx/UoWTA==
X-Received: by 2002:a05:600c:a42:b0:393:d831:bf05 with SMTP id c2-20020a05600c0a4200b00393d831bf05mr33885940wmq.187.1654705597681;
        Wed, 08 Jun 2022 09:26:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id e7-20020adff347000000b0020ff4b8efc6sm21701293wrp.80.2022.06.08.09.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:26:36 -0700 (PDT)
Date:   Wed, 8 Jun 2022 18:26:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] video: fbdev: Convert from PCI to generic power
 management
Message-ID: <YqDNuhopLfpHkTS7@phenom.ffwll.local>
Mail-Followup-To: Bjorn Helgaas <helgaas@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220607231112.354165-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607231112.354165-1-helgaas@kernel.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 07, 2022 at 06:11:10PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
> deprecated.  If drivers implement power management, they should use the
> generic power management framework, not the PCI-specific hooks.
> 
> No fbdev drivers actually implement PCI power management, but there are a
> cirrusfb has some commented-out references to it and skeletonfb has
> examples of it.  Remove these.

Is this holding up some cleanup on your side and so would be easier to
merge these through the pci tree? If so

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

for merging through your tree. Otherwise I guess Helge will get around to
pile them up for 5.20 (or 6.0) eventually.

Cheers, Daniel
> 
> Bjorn Helgaas (2):
>   video: fbdev: cirrusfb: Remove useless reference to PCI power
>     management
>   video: fbdev: skeletonfb: Convert to generic power management
> 
>  drivers/video/fbdev/cirrusfb.c   |  6 ------
>  drivers/video/fbdev/skeletonfb.c | 13 +++++++------
>  2 files changed, 7 insertions(+), 12 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
