Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574762E9CE9
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 19:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhADSTK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 13:19:10 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39292 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbhADSTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2021 13:19:10 -0500
Received: by mail-wm1-f45.google.com with SMTP id 3so127537wmg.4;
        Mon, 04 Jan 2021 10:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+NTvbLk4IzzMQK1/SZQ7lLpxAYEqAF6MOVXtS7spWg=;
        b=AsMwAr/K7cyLetQtcPFpqs/NqKQabPftA/pVy0Wiu/KAq4PpwmK4msAZH1aN0QoBXN
         ZXM7Xj/NFoZISFhjP46zxMksV+YTqZaxappTzgpZFjo+go83E1mEShg4Cy6895gIWdl2
         q0kmq81inI8rw9rOPTlQhXEo/PMAs+rIcKr2Ov3a8zyfK5Bg9eY96uV9jdD8WaAm9ORH
         9vUsQsAK0htmHmhBHAct6Qbh5DOF6DdHXS9TIlRnBreob3uQafRLMdDYgiI9fXZjTh36
         G6EXatwzCzePU5sq+9P7TssECoiW+HrFbpFi7cLPcAfy0YQyLeoQkRTH3HJcNH2qj3iQ
         +NTQ==
X-Gm-Message-State: AOAM533Q57kutc8TeDN7MtU3TUl/n2XCVZDmstjqfK74m0/P1cf6fWCH
        9cAS37TiYTowWykSDMxQtSI=
X-Google-Smtp-Source: ABdhPJyxaw81/VsDm31di+CjRZDa5b043/h6CfX6p+2JizDxYrVRkfy8Dr09rKnqvDo/5ZkHa0Uyug==
X-Received: by 2002:a1c:4483:: with SMTP id r125mr143991wma.80.1609784308269;
        Mon, 04 Jan 2021 10:18:28 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x7sm210739wmi.11.2021.01.04.10.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jan 2021 10:18:27 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:18:25 +0100
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
Message-ID: <20210104181825.GB27043@kozik-lap>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104135156.GB5645@sirena.org.uk>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 04, 2021 at 01:51:56PM +0000, Mark Brown wrote:
> On Wed, Dec 30, 2020 at 08:52:07PM +0000, Timon Baetz wrote:
> 
> > +- charger: Node for configuring the charger driver.
> > +  Required properties:
> > +  - compatible: "maxim,max8997-battery"
> > +  Optional properties:
> > +  - extcon: extcon specifier for charging events
> > +  - charger-supply: regulator node for charging current
> > +
> > +- muic: Node used only by extcon consumers.
> > +  Required properties:
> > +  - compatible: "maxim,max8997-muic"
> 
> Why do these need to appear in the DT binding?  We know these features
> are there simply from knowing this is a max8997.

If you refer to children nodes, then we do not know these entirely
because the features could be disabled (pins not connected).  In such
case these subnodes can be disabled and MFD framework will not
instantiate children devices.

If you mean "the properties" like extcon or charger, then indeed it's a
good question. In theory, wires still could be routed differently, e.g.
different charging regulator used as a charger.
In practice this is highly unlikely, however such DT design allows
easier hooking up of different devices and even potential re-usage of
kernel drivers (also unlikely...).

Best regards,
Krzysztof

