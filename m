Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E01C2EB0A9
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbhAEQ4P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 11:56:15 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46150 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbhAEQ4O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 11:56:14 -0500
Received: by mail-wr1-f45.google.com with SMTP id d13so36811715wrc.13;
        Tue, 05 Jan 2021 08:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lly2danYiTb182H8D8avthszPR0+tG65HNd1JQEsbI=;
        b=HCkl2FtFY5FNxod7qZtBctkCHsuOzup68d7IP2GeF6z9dd+p5B2gmS978t4vzAGdIF
         wDRoD1bZ0N5aUyl4SvgbjRIRreTxXj3kWZ06RZtvIR9Ce5ZA9cID5Ol+YTjKFD8aS7Ah
         sPz2WPkqUDrLS+VItLsMWorYVw7h/dD543rk4hfdGLPvU9u7JsnfcU+UNi3o3ED7MRzo
         hCD6lBZhA6M5DadzoVEdTA5XsFtZuniO/ltffwfC4sj3FxgwfTA5nWHHtu2UN23fYIHP
         GJ9ccU2wsszmmcPQ8rQwSAUoAdYGRKsP8vBXGtpbAyAPl6GVbQ2YCY5TFLry43C+OJ+c
         xTMg==
X-Gm-Message-State: AOAM530BA+GYe+vJYSXYO6sFmnVkKIn1en5V5dwjeKJqa45Zucax/snP
        +iS23rTZBxJ9GV/WYUhiGlc=
X-Google-Smtp-Source: ABdhPJzX4fvNgU7hZQaXgWYzHyNSexu7jTttqQRxXT2CO39QS18z96tCMzayhO0xxYI//56QjYAo1A==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr500791wrn.208.1609865732300;
        Tue, 05 Jan 2021 08:55:32 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id o125sm118260wmo.30.2021.01.05.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 08:55:31 -0800 (PST)
Date:   Tue, 5 Jan 2021 17:55:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20210105165529.GB20401@kozik-lap>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
 <20210104181825.GB27043@kozik-lap>
 <20210104182734.GH5645@sirena.org.uk>
 <20210104183821.GA29033@kozik-lap>
 <20210104212449.GJ5645@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104212449.GJ5645@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 04, 2021 at 09:24:49PM +0000, Mark Brown wrote:
> On Mon, Jan 04, 2021 at 07:38:21PM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Jan 04, 2021 at 06:27:34PM +0000, Mark Brown wrote:
> 
> > > We can indicate the presence of features without adding new compatible
> > > strings, that's just encoding the way Linux currently divides things up
> > > into the bindings.  For example having an extcon property seems like it
> > > should be enough to figure out if we're using extcon.
> 
> > It won't be enough because MFD will create device for extcon and bind
> > the driver. The same for the charger. We have a board where max8997 is
> > used only as PMIC (providing regulators) without battery and USB
> > connectivity.
> 
> I'm not sure I follow, sorry?  Either the core driver can parse the
> bindings enough to know what children it has or (probably better) it can
> instantiate the children unconditionally and then the function drivers
> can figure out if they need to do anything.

Currently the MFD parent/core driver will instantiate children
unconditionally.  It would have to be adapted. With proposed bindings -
nothing to change.  MFD core already does the thing.

The point is that function drivers should not be even bound, should not
start to probe. Otherwise if they probe and fail, they will pollute the
dmesg/probe log with failure. With the failure coming from looking for
missing of_node or any other condition from parent/core driver.

> > Another point, is that this reflects the real hardware. The same as we
> > model entire SoC as multiple children of soc node (with their own
> > properties), here we represent smaller chip which also has
> > sub-components.
> 
> Components we're calling things like "extcon"...

I am rather thinking about charger, but yes, extcon as well. Either you
have USB socket (and want to use associated logic) or not.

Best regards,
Krzysztof


