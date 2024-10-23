Return-Path: <linux-pm+bounces-16308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEE9AD06F
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC67E1F233A3
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2024 16:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810081D07BC;
	Wed, 23 Oct 2024 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkVjSHUY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C91D0797;
	Wed, 23 Oct 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700764; cv=none; b=mSk498X5nVivEpKco3tsvwKANCP44B0v0t8GVLNprZO12ElnMFPAHwpTWqw7612fl+8Qb8VJSxMD8OAucXE2r0cvbLHvRoTlgVfgh6vmbfwn08T8QldKWmeolRZnLaN7cKRpm+3x262yq1iBPIZ39ZjvVFZAhva7x0XePeztqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700764; c=relaxed/simple;
	bh=ZnAYm2TJOCxsEMUg1iKlsmwaRxpZn2CUIxr94dEYTEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLRbfEkygVZ7mwEX986mSabH+55DBTemnBCU+Da+CxKe40SUv3o4dxfNMfutpEHT5KuYjMgFQ2qGg14lr1JDF6dZZnBs/GFOTdFqfevZ9BNRhAoWQJ9P+MMKAS+m+grXjWAsj6GYq+pCkBuupLcdKI19OPgAcy9z6JtKgYGm2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkVjSHUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6636C4CEC6;
	Wed, 23 Oct 2024 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729700763;
	bh=ZnAYm2TJOCxsEMUg1iKlsmwaRxpZn2CUIxr94dEYTEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkVjSHUYFWclSNvqyA9MWWrL9LSNsnCLeltO+unH9duOufiWkrRs4PiDsrAaXaykm
	 n6sFngrTGkv0VSIcWz9qJgUQeOaHczqi124qBatb0MnCB1w866W18RW4bjAdqBiDlw
	 ev6K7gnRgeTa98D9PFAWmxVOV8Own4ZKSs+DumtO1m1uuKzulus/X7B07rQAGjDQn+
	 ggIRAH7kNzXeDtPhEq+dycS9rLeuaZ3GFG0uaVkcuJNCC47vVE0yy5Yfq487Vix6oO
	 R1GRk3FVuSzKo4wc26oGSqhh2OocxfAVAJo5LbMz5XI1iL8bTEGcV6/i1/IKoPJD+v
	 dwXe2TIhSw2zA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t3eBc-000000006FX-37sy;
	Wed, 23 Oct 2024 18:26:16 +0200
Date: Wed, 23 Oct 2024 18:26:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, ulf.hansson@linaro.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org,
	linux-pm@vger.kernel.org, tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>

On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
> On 10/10/24 20:32, Johan Hovold wrote:
> > On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> >> The series addresses the kernel warnings reported by Johan at [1] and are
> >> are required to X1E cpufreq device tree changes [2] to land.
> >>
> >> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> >> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> >>
> >> The following warnings remain unadressed:
> >> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > 
> > Are there any plans for how to address these?

> Sorry missed replying to this. The error implies that duplicate
> opps are reported by the SCP firmware and appear once during probe.

I only see it at boot, but it shows up four times here with the CRD:

[    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
[    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
[    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
[    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16

> This particular error can be fixed only by a firmware update and you
> should be able to test it out soon on the CRD first.

Can you explain why this can only be fixed by a firmware update? Why
can't we suppress these warnings as well, like we did for the other
warnings related to the duplicate entries?

IIUC the firmware is not really broken, but rather describes a feature
that Linux does not (yet) support, right?

Johan

