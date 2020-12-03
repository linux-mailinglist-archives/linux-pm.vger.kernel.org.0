Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528542CD683
	for <lists+linux-pm@lfdr.de>; Thu,  3 Dec 2020 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgLCNSM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Dec 2020 08:18:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:18091 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgLCNSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2020 08:18:12 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 08:18:11 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607001319;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3Nu1/KDXbZdCZ8mVmAWptPuNQf7opDwxYPcP4pkq9T4=;
        b=H6noW9ajdeK0DlyZxXty58KEbgSVZ+YIs7zi091B4ifX5oLUB4tU9cJI5J5R39g6/t
        6aKfa3BFsTbyJrZROaqTWJKR04xGB9BYiNXtd0Pgyt72f5nCSihG6IlrgsFf31LNzTmG
        S1CGfSKdFtvv2XmraBdKQDTA0pBqw1nycHp9l+1QE7Z/GQEHuW5p1FTMlf4sSv7AXVB5
        UT5owN1+7mCa+wWCEp7hSu2AyBygXSe9RoibqVirmThVDrPGIiU5D4TBriWrE4Pk5rK4
        4/rISjnwSd50yTsD+6w0kB7lQbM2kiz0IO/dz95f8lmrpCAA7l/eAaU1OrF8V3C2beJP
        Cgzg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j+IcvFBg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id Z061efwB3D95qef
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 3 Dec 2020 14:09:05 +0100 (CET)
Date:   Thu, 3 Dec 2020 14:08:59 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Timon =?iso-8859-1?Q?B=E4tz?= <timon.baetz@protonmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH 3/3] ARM: dts: exynos: Fix charging regulator voltage and
 current for i9100
Message-ID: <X8jja0JGDjwQ9hnA@gerhold.net>
References: <20201202203516.43053-1-timon.baetz@protonmail.com>
 <20201202203516.43053-3-timon.baetz@protonmail.com>
 <20201202220430.GB135888@kozik-lap>
 <dDjo3R2SJ6CBCjg0YhsCPdh5JfEGhA--DHNNDqbWjVtTjZC5v7g7_523vqAzu_Ybf1Q-xfKeK47H483YQoVtpO3DI83OaR6c6mbvtC9S1Us=@protonmail.com>
 <20201203082301.GA3999@kozik-lap>
 <20201203095041.GA14508@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203095041.GA14508@kozik-lap>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 03, 2020 at 11:50:41AM +0200, Krzysztof Kozlowski wrote:
> 
> Unfortunately it seems Samsung started to remove most of older
> kernel source code from their OS compliance page. S1, S2 and S3 are
> mostly gone. I was able to find just few remaining sources and I am now
> updating my vendor-dump with them. I'll upload them later to
> https://github.com/krzk/linux-vendor-backup .
> 

I don't know why they keep removing older kernel sources (it's pretty
stupid), but so far they added all of them back within a couple of days
after I made an inquiry on https://opensource.samsung.com/requestInquiry
(Note: They remove them again after a while so backups are always
 necessary...)

Might be worth a try if you need some of them :)

Stephan
