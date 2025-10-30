Return-Path: <linux-pm+bounces-37133-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB87C21D37
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D81A25E59
	for <lists+linux-pm@lfdr.de>; Thu, 30 Oct 2025 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAF36CE07;
	Thu, 30 Oct 2025 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLS6lk95"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6623BD17;
	Thu, 30 Oct 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850165; cv=none; b=anNF7MWk6BJ7OYKI3BEN0WECRQbpCWohslvgu0a1/vHaINusBhPJTkxTyaBPz0aZDSEKucQ++J1tRiv5gzyg2a8QyKCtcMdLn0Gj1q8gyWXSoNNxM7wdD6WTbhA+8BXwVJs6PJNacxk3bjJPemtG313UFQmWOlbqAwKXuzNA0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850165; c=relaxed/simple;
	bh=4oXOhHBxwdbDeXzDYmyJ+caQW71LMaPdRWRu40QvJUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3vy490nSenm/w9G674XvkMZ7952aphNjYwhvCLpy0f/h14OkCkqowa0R7Gmn5hYahJr32hB8RdY/+FOS78xnn6xW/ixUcAZ8VgvGpBn5Nx5kQMGG51vgpa6L9miiRDqZjU4QbhxxgTyxNfL9yHj20Fs/bsQSfL8E9DSGkWwxIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLS6lk95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84457C4CEF1;
	Thu, 30 Oct 2025 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761850164;
	bh=4oXOhHBxwdbDeXzDYmyJ+caQW71LMaPdRWRu40QvJUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLS6lk95NeWvb6iL++I8ubzTuVcjuAn4fF3OzeUkxke+62H2uzg7AaQSaNk8psWct
	 8wI6QElBI+nfKa7qWbo1q8wZhf34Gqd5EeLPFgqDOOjR5/rcDnF3MReP/GHxXvP0Uc
	 yZTBqTEnZFFa6WmQV8TckJtCCyUDmauyI8dlWz0R5/tLkRzB1YSt/2Xar512C76ULg
	 MlMHksnx0bstGbFPSwfWhO3FzPUKUwnD+F+Axg/a0x3lswUa5JeDl4/lCvhb0B9YBR
	 qxSfRrC46+wPeTNyfZNNXz6k/Y4XDvLv7W7Ipwrf0CIbcKva6g9JmkVN/xqnxHUOEz
	 FmQodTlLw/phA==
Date: Thu, 30 Oct 2025 13:52:33 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Georgi Djakov <djakov@kernel.org>, Yassine Oudjana <y.oudjana@protonmail.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8996: add interconnect paths to
 USB2 controller
Message-ID: <siil3r5vj4afnwvo4pp53kj2gjontwb6q7jvl3vixceydhxwlf@vx7mqqd6hyji>
References: <20251002-fix-msm8996-icc-v1-0-a36a05d1f869@oss.qualcomm.com>
 <20251002-fix-msm8996-icc-v1-2-a36a05d1f869@oss.qualcomm.com>
 <7ef8ba74-4e9e-4b19-998e-40917d997ca8@oss.qualcomm.com>
 <hlj6cyeybsct4flwvm22t4u5coeyrlwcwfol2cuzab2fjkluwi@frs6m2sjyksp>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hlj6cyeybsct4flwvm22t4u5coeyrlwcwfol2cuzab2fjkluwi@frs6m2sjyksp>

On Thu, Oct 30, 2025 at 08:24:29PM +0200, Dmitry Baryshkov wrote:
> On Mon, Oct 06, 2025 at 11:30:52AM +0200, Konrad Dybcio wrote:
> > On 10/2/25 10:53 AM, Dmitry Baryshkov wrote:
> > > Add the missing interconnects to the USB2 host. The Fixes tag points to
> > > the commit which broke probing of the USB host on that platform.
> > > 
> > > Fixes: 130733a10079 ("interconnect: qcom: msm8996: Promote to core_initcall")
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > > 
> > > ---
> > > Note: without the previous patch applying this one can result in the
> > > kernel stuck at booting because of the EPROBE_DEFER loop. I suggest
> > > applying them through the same tree in order to make sure that the tree
> > > is not broken (or using an immutable tag for the icc commit).
> > > ---
> > 
> > There seems to be syntax for this, at least for stable patches
> > (which we should probably either use or add +noautosel):
> > 
> > * Specify any additional patch prerequisites for cherry picking::
> > 
> >     xCxc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> >     xCxc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
> >     xCxc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
> >     xCxc: <stable@vger.kernel.org> # 3.3.x
> >     xSxixgxxnxexd-oxfxf-xbxy: Ingo Molnar <mingo@elte.hu>
> > 
> > (deliberatelly added a bunch of 'x'-es to not interrupt the maintainers'
> > b4 workflow)
> 
> Bjorn, Georgi, Konrad, how should we proceed with this series?
> 

I agree with you on the Cc part, that doesn't affect how these patches
shows up in torvalds/master during the merge window. So merging them in
the same branch would be the way.

@Georgi, I'm fine with doing this in either tree, if you prefer to pick
the two patches:

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> -- 
> With best wishes
> Dmitry

