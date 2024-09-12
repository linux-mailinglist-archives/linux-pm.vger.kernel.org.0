Return-Path: <linux-pm+bounces-14074-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DD97639A
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 09:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CCCB21940
	for <lists+linux-pm@lfdr.de>; Thu, 12 Sep 2024 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511CA18F2DD;
	Thu, 12 Sep 2024 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RE4Jpos0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035FA18E349;
	Thu, 12 Sep 2024 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127732; cv=none; b=dacyhsAvLjOykFXReeU6h9OecENu81642d0tVC5M5Nm4A18QHAjt6g6990Bnqpar/RGvlHQA2LSkXKIBsqD5mrwTQODaiRLKXbNWX0TBCWugVeVQGL1St4SyhKUwjcI0TIeOMTEHDDE/0dYQcIvyEOaR6DOYITRPuXeupX2TNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127732; c=relaxed/simple;
	bh=4s+VuwhVbNSAVesYDsrgOzVFuC3dn4Fh96NjWQHHSd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6c1sWxW5fA2B1SCV5IYRE/M97KXKOLAexRDTrIf17CQUHWmvnfRe6FQIoPmsD0HPKH3tqmqpx7zGyPJf6ClV7B5S3lWkVSZkvQUOkWdpJaSVebTbRRcwaOjjhN/VbKPFlYjDO6HgLFA2XHJYy84rQsYYenCm4IfA7u+vX5R7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RE4Jpos0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDB5C4CEC3;
	Thu, 12 Sep 2024 07:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726127730;
	bh=4s+VuwhVbNSAVesYDsrgOzVFuC3dn4Fh96NjWQHHSd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RE4Jpos0PNEzX+j4gvv4HnNOrUggjKzwMILkyBwl0ysVmjqAOlVX/mQhrIQNly6u5
	 D4cMLo65bYBMzWlE/3MbcvaGJgeSBNYdVepAt76I+DLSY7juHCYtKFtFSF+NxXRLnf
	 nw0U9baOT3m36ADEOMsC52DEtH41CuFRaJgFalbX5iXcl4IyQp85V7KiijKjx0cNGT
	 6KayroEwMI5tGGbabloSBt1YK8gCKXHgprPzBlO8p/mD27xX6IExuLkytas4cCy+Lx
	 FeyB97LCD7R1E9Adejrws3/2lIKYd4KEQJJgQvTdJ/MZTah6JaIHWY/t17UQPpDuJl
	 ey2Ge3BBptu3g==
Date: Thu, 12 Sep 2024 08:55:23 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Junhao Xie <bigfoot@classfun.cn>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Chukun Pan <amadeus@jmu.edu.cn>, Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <linux@roeck-us.net>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: Re: [PATCH 1/9] mfd: Add driver for Photonicat power management MCU
Message-ID: <20240912075523.GB24460@google.com>
References: <20240906093630.2428329-2-bigfoot@classfun.cn>
 <de5c9c27-56fa-4163-98e1-9a98400d2408@web.de>
 <43918eda-c4e8-471a-9de4-ea72bb090803@classfun.cn>
 <917ac8d8-a483-422c-a408-cdd44793e910@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <917ac8d8-a483-422c-a408-cdd44793e910@kernel.org>

On Sun, 08 Sep 2024, Krzysztof Kozlowski wrote:

> On 07/09/2024 16:33, Junhao Xie wrote:
> > On 2024/9/7 16:44, Markus Elfring wrote:
> >> …
> >>> +++ b/include/linux/mfd/photonicat-pmu.h
> >>> @@ -0,0 +1,86 @@
> >> …
> >>> +#ifndef _PHOTONICAT_PMU_H
> >>> +#define _PHOTONICAT_PMU_H
> >> …
> >>
> >> I suggest to omit leading underscores from such identifiers.
> >> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier
> >>
> >> Regards,
> >> Markus
> > 
> > Thanks for your suggestion, does this look better?
> > #ifndef MFD_PHOTONICAT_PMU_H
> > #define MFD_PHOTONICAT_PMU_H

Yes, this is better.

> <form letter>
> Feel free to ignore all comments from Markus, regardless whether the
> suggestion is reasonable or not. This person is banned from LKML and
> several maintainers ignore Markus' feedback, because it is just a waste
> of time.
> </form letter>

If you really _must_ do this, at least keep it factual.

To the best of my knowledge Markus is not banned from LKML.

-- 
Lee Jones [李琼斯]

