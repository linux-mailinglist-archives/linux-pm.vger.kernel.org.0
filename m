Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7920A2D1DD1
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 23:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgLGWzR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgLGWzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 17:55:16 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033DC061749;
        Mon,  7 Dec 2020 14:54:36 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id ce23so18129309ejb.8;
        Mon, 07 Dec 2020 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ikuMuHs5sNrFUz6htSqwiN7XutHKhUqKTs5+seLKDDA=;
        b=r4XXVvTtW8qVgdH+lr2X9o/eRIuTnkCt6Rp0UoXKX1NE7nHP6zvVXglUtB/hDsqMdP
         keR9QtEzzz3D57O8YTD2FlsKga3f8PXU0FauTx3jIDiLXTLl7efVTVJqFsseqKkQ+7x2
         q9mVXgVaNcxg86oZp/cuTjfwHyf/WaKmfsh7QPRzvPYZp+MMkBdFf02eeJK1xp3UdObq
         eyZDdW8aET630dobxC9DGrlACletOgaDmmubGilIqTYT8uzKfnBwtb4+fyVB1ukY1/i9
         HSxh7uwe961T3IQ+4798UaGssMrbV/OYajzqd8IW3286+mmNdIDTpRUQxCnjH6iNaSSi
         DSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ikuMuHs5sNrFUz6htSqwiN7XutHKhUqKTs5+seLKDDA=;
        b=ahiTcMngWypZcz/Lv5VbjOWM8i6xcnsikfAsPZJbBv6gBYe7iMWfunJDCeGhE8KYr+
         MEhoSMFK+/lPYeDq+BHJogWMTl4RQUYZy+zqvK/2VO0fsbqfLGjZgLtAnvP7QdxuvKJj
         +BBc3KIzR5bnni1v18H+3gwt/yeVF1rC4Z98/0SPwgduBLtGhfWviqtPMtSCI5PM2NUo
         oGD+u1UgGpQktLSFwr5jwXSvHgjISXD/3xRf3+dKeSeVBp2nWEzE1qLpIIZxQ35yslb5
         p836PICRKCilM5BgyfYaFdgLu2w5WonSsixK7eMSTD1wjsM/rN1hPa5ZF9B5ex2m6gFh
         kYAA==
X-Gm-Message-State: AOAM5305ecA8GZwudgJvkS3XXcLJT/xOm0RHLdqIOhvo6cjhClHyLJvt
        FekbFFPl6ThiWK1XRt6QiEU=
X-Google-Smtp-Source: ABdhPJwKktBwILNOPx2MY3e6qTpMPX89oQ4E9201+o8jMaTceW9TCfOW/PzMI0qbLyYCwJ15zqcrTQ==
X-Received: by 2002:a17:906:d8a1:: with SMTP id qc1mr20361704ejb.294.1607381675127;
        Mon, 07 Dec 2020 14:54:35 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id t26sm15197371edt.69.2020.12.07.14.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 14:54:34 -0800 (PST)
Date:   Tue, 8 Dec 2020 00:54:38 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/7] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20201207225438.GB250758@ubuntu2004>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f001986493a51fe591cb09a544770651bf589d35.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201207133003.GC5694@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207133003.GC5694@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 07, 2020 at 01:30:03PM +0000, Mark Brown wrote:
> On Sun, Dec 06, 2020 at 03:27:04AM +0200, Cristian Ciocaltea wrote:
> 
> > +/*
> > + * ATC2603C notes:
> > + * - LDO8 is not documented in datasheet (v2.4), but supported
> > + *   in the vendor's driver implementation (xapp-le-kernel).
> > + * - LDO12 mentioned in datasheet is not programmable, hence not
> > + *   handled in this driver.
> > + */
> 
> No reason not to include LDO12 here, the framework supports fixed
> regulators fine and the bindings should reflect the physical structure
> of the hardware - if something is being supplied by LDO12 on the PMIC
> then you'd expect the binding showing a connection from LDO12.

Totally agree, I will handle this in the next revision.

Thanks,
Cristi
