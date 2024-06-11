Return-Path: <linux-pm+bounces-8945-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA9903B59
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 14:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35086B262AB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC5017838A;
	Tue, 11 Jun 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJJ/zKWv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2017623D;
	Tue, 11 Jun 2024 12:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107341; cv=none; b=TYcmAWF7HlArEzlhTOKTzW7Qdy5GR7ryZodbnEdKvVsgGTl35j/Na1UnY2VuXF9TCKmFvGgZp+zvSrm24f6oVPTNavJ51Bt9sMut2RGx17/SiyCgdHYwwzwxipb457nCEd9IJowDyV4uSEiKkJaWErXZSm0A0Ie4j59sKQ493DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107341; c=relaxed/simple;
	bh=CVnXtj7dn7R4jP36tYffAg5QjTJwaLN8wgb/nx5uVVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhcCuMXijHDKG1B6fS9Lr4fMELpFuhA0snUbiF2Kh4CIsyN/Cz6BSpTbF6ES0LBK3MF1uAZo4J12qFHBnC3LVjKjVXGRoVyil38exOZVytVDK/axhZ0TWRGU03lKspssbhpfdpTzKvo9XPLVxIWEIcF/1VkRTt0fskLfZSZTN3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJJ/zKWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB0BC32789;
	Tue, 11 Jun 2024 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718107341;
	bh=CVnXtj7dn7R4jP36tYffAg5QjTJwaLN8wgb/nx5uVVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJJ/zKWvRiyqgeI+ApQhnRndzGu9PygAixIX0q/qDR8eRcwJG0wY1hW+Osb/iuqbq
	 lDotrOT+lklfU6UGVcKy4bfqPhyXHW9tgEBi5QWPV8xeI/VTn3t34Ufmy0AoPzsoQ+
	 c0g3rdr9IHuGozdVDEzk2Wbq/fgf4Ul7Y+1Q5tFZ4riDaH75fH8Cc/JQR2oNkaqmf/
	 N4ysbZ5rBYb2OmBi38sB9tHrKVPW7+IHZ9QwaZiMdsPa/7P0ZaeeGz/N4JyuLbnzR1
	 fM/Cji6L+TAX48aJqIKG9oDazxcNYO3bltbrn7U+y2428eiRmqjxVXfyUn1iZIQ5lS
	 3aZ4x3x7gE2PQ==
Received: from johan by theta with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sH0Cd-000000008k4-1zj5;
	Tue, 11 Jun 2024 14:02:15 +0200
Date: Tue, 11 Jun 2024 14:02:15 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Steev Klimaszewski <steev@kali.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: cpufreq/thermal regression in 6.10
Message-ID: <Zmg8x6JXQW1dqOr4@hovoldconsulting.com>
References: <ZmVfcEOxmjUHZTSX@hovoldconsulting.com>
 <CAJZ5v0gVnjVyd_O6KgXy2sXr3b3M3vyTLyUCasyxP0GrAXro4Q@mail.gmail.com>
 <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iz7gwhpvT53CH0ZEA_q3U=dnn6XR8HdLk6LpP3ye4Zkg@mail.gmail.com>

On Tue, Jun 11, 2024 at 12:54:25PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 10, 2024 at 1:17 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Sun, Jun 9, 2024 at 9:53 AM Johan Hovold <johan@kernel.org> wrote:

> > > Steev reported to me off-list that the CPU frequency of the big cores on
> > > the Lenovo ThinkPad X13s sometimes appears to get stuck at a low
> > > frequency with 6.10-rc2.
> > >
> > > I just confirmed that once the cores are fully throttled (using the
> > > stepwise thermal governor) due to the skin temperature reaching the
> > > first trip point, scaling_max_freq gets stuck at the next OPP:
> > >
> > >         cpu4/cpufreq/scaling_max_freq:940800
> > >         cpu5/cpufreq/scaling_max_freq:940800
> > >         cpu6/cpufreq/scaling_max_freq:940800
> > >         cpu7/cpufreq/scaling_max_freq:940800
> > >
> > > when the temperature drops again.

> If this is the step-wise governor, the problem might have been
> introduced by commit
> 
> 042a3d80f118 thermal: core: Move passive polling management to the core
> 
> which removed passive polling count updates from that governor, so if
> the thermal zone in question has passive polling only and no regular
> polling, temperature updates may stop coming before the governor drops
> the cooling device states to the "no target" level.
> 
> So please test the attached partial revert of the above commit when you can.

Thanks for the quick fix. The partial revert seems to do the trick:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan

