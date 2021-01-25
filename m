Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E642302CF7
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 21:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbhAYUwD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 15:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732333AbhAYUvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jan 2021 15:51:33 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910BC061573;
        Mon, 25 Jan 2021 12:50:52 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id dj23so17166726edb.13;
        Mon, 25 Jan 2021 12:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wgzp00i02Hl+13MLFnCJWHYWHztGINjgHTUzqZGqu4o=;
        b=sDhgkeP9Q7KCAMmjicx39uJ8q2xIFhZiHb1aIOhKvnCQT8oCSziU3U79QK0qYph8/7
         gyDR3Ynb400gVB1bXAVoF9/RiaRF3I/fbri3O+DS89u6ZUSNFDooIsv+73/O2RnYlqbl
         V/1b1xByyTnnBVV6JsU2IWdtU9uXrCOwSgqlNEmVHRUXklgiPsZeGJElT1U2ZxFdOXn0
         s85qmT2nT4FNk0dtsXScAbWt998TkAKySTh36VqdZos1ijRaQNGo7y26bQN5ouMnJTVM
         gzWM9PYDp+f0J3uJJl4TQM22XWguyN1kZWknGn/kTqor4MU7HiAYG7TpIAZW0KA9uEKl
         BbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgzp00i02Hl+13MLFnCJWHYWHztGINjgHTUzqZGqu4o=;
        b=Pg5Gbcc5zOIvLI58NlUsij/XKf+v6mQm6ZPKoQYmQarZeRSf8iNzXdBmaraKLQ8olD
         xNMg2OUuR3n0f6AqND2alV2exD2V696PkvJqxH6+mYWdUxChlY0Hj2qJFFqwd7gL/ozo
         ELli0Rs3sJoTdJTWnAuHMy8Aq/xBwtCjHDspBmdiRr7LCabvemSd+rm5A/us+zAZGpX6
         56vvGagEqICX6kKTrQBYI6QiJMZv0Fa3b9D9ze41olzC3L0fpr/QPrrZRQOMIdgO3FAL
         YY1PwR4IeK4rsacV2Sn5inXmmytvnem8qOBd9kz+AcMYPii3GOaup60vPDkuypAfqsCZ
         4hog==
X-Gm-Message-State: AOAM532oVIOYGfNekX9Y4oF9KT6f3sv8Fc7X4wf2dU1yHsMy5lnl3fy9
        au7/tlI/j+qXc8Bgn1Zn4ls=
X-Google-Smtp-Source: ABdhPJy7WrCv24lqmNPb08ytTFlma4Mx2zuJ0qXLaxX0K66lXj7ntLwmMlUDYymPG/DUEFyzv5DgfQ==
X-Received: by 2002:a50:ef06:: with SMTP id m6mr1965086eds.216.1611607851552;
        Mon, 25 Jan 2021 12:50:51 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id m22sm11235290edp.81.2021.01.25.12.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:50:50 -0800 (PST)
Date:   Mon, 25 Jan 2021 22:50:48 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 4/7] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20210125205048.GA1066705@BV030612LT>
References: <cover.1611165200.git.cristian.ciocaltea@gmail.com>
 <3f48e9f8114cac0557abca88d4437849423793bb.1611165200.git.cristian.ciocaltea@gmail.com>
 <20210125192311.GC4510@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125192311.GC4510@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Mark,

On Mon, Jan 25, 2021 at 07:23:11PM +0000, Mark Brown wrote:
> On Wed, Jan 20, 2021 at 08:23:29PM +0200, Cristian Ciocaltea wrote:
> > Add support for the DC-DC converters and LDO regulators found in
> > the ATC2603C and ATC2609A chip variants of the Actions Semi ATC260x
> > family of PMICs.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

The patches applied to 'for-next' branches were not modified, but I have
(wrongly) assumed I need to keep them in the series until they are
eventually merged into master.

So, if I understand correctly, I should have dropped them from the patch
series as soon as they had been queued, and only if they need some
additional work, I can re-add them as incremental updates.

Thanks,
Cristi
