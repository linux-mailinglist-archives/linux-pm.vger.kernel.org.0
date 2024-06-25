Return-Path: <linux-pm+bounces-9934-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E19B916017
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 09:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C831B1F21344
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5706146A76;
	Tue, 25 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQJ5m3aM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC08F146A62;
	Tue, 25 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300863; cv=none; b=X52An+GZK/RqEAtp3v4iVtQaxLnqopnj4NBPFCEedMYVT87N5+kn/QZV7TQp4zEzfk1t4kqrdAbcjRRu8mYkjXn7b0NAcxinyD7SrBGBHDy4+qOQdK8sAhGpC83o+611p7TRVdVpS3UEhM5H+oS/vZW6K89RPh2njlZ2ZEdQ+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300863; c=relaxed/simple;
	bh=aQn+ehoD607LXRrXdzk73NDqXYMJXf+HWCrrj77xtWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shTggmMAqKsO9+hpZpJWUAc6PaqS4RQWKyiyR/FNbMykLCIn1tsNrPTtdsRmzl7nBQBySYMtp7vczsVjlKQt/KEdbvKG+zHc0uS7TbIAuzrcKu90GinGrpius7e6/szRz4ZWMteC1pTR+5U5dcPHpIcKnGR9gmnrmtb6U+qIEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQJ5m3aM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38463C32781;
	Tue, 25 Jun 2024 07:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719300863;
	bh=aQn+ehoD607LXRrXdzk73NDqXYMJXf+HWCrrj77xtWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQJ5m3aMrpZ+cK9AV7gLoVuzznKtemjFXAnfUQmTj4ABAOO+HH2G54gwdXAq2q5XL
	 ZcQ0EWQm0DRRtz2Wtbn6Rl5N5k8vGJzfsZXlgMqtMhzcaSsNxjsCqlO45BWfPsOrA6
	 LZAwEVzNMJ/mJQuyYFGbiFHyo1MRtgsdkyb+B5684Hbnk7t0XGooVQZIjZ1eN2WwA3
	 At+gv3z3t+ZU94VUeH3oFZF5WJl0YrUwh7EcWqY4k7dCblmleXnm1kCESmr+/jALAQ
	 sht9VWir9roEYSNGJvaS3LsjjgU80cvSeES4Grhc2/rCnuhxXnWtPXdyDL21FlZT90
	 vtE8BAirxfwPw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sM0hC-000000002Ao-3FZ2;
	Tue, 25 Jun 2024 09:34:30 +0200
Date: Tue, 25 Jun 2024 09:34:30 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	Steev Klimaszewski <steev@kali.org>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v1] thermal: gov_step_wise: Go straight to
 instance->lower when mitigation is over
Message-ID: <ZnpzBuWbKxbrKvoR@hovoldconsulting.com>
References: <12464461.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12464461.O9o76ZdvQC@rjwysocki.net>

On Sat, Jun 22, 2024 at 02:26:33PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit b6846826982b ("thermal: gov_step_wise: Restore passive polling
> management") attempted to fix a Step-Wise thermal governor issue
> introduced by commit 042a3d80f118 ("thermal: core: Move passive polling
> management to the core"), which caused the governor to leave cooling
> devices in high states, by partially revering that commit.

typo: reverting 
 
> However, this turns out to be insufficient on some systems due to
> interactions between the governor code restored by commit b6846826982b
> and the passive polling management in the thermal core.

Care to elaborate on what went wrong here? In my test of the previous
fix I saw the frequency ramping up in steps as expected when the
temperature dropped. Under what circumstances would that fail to happen?

> For this reason, revert commit b6846826982b and make the governor set
> the target cooling device state to the "lower" one as soon as the zone
> temperature falls below the threshold of the trip point corresponding
> to the given thermal instance, which means that thermal mitigation is
> not necessary any more.
> 
> Before this change the "lower" cooling device state would be reached in
> steps through the passive polling mechanism which was questionable for
> three reasons: (1) cooling device were kept in high states when that was
> not necessary (and it could adversely impact performance), (2) it only
> worked for thermal zones with nonzero passive_delay_jiffies value, and
> (3) passive polling belongs to the core and should not be hijacked by
> governors for their internal purposes.

I've tested this patch on the Lenovo ThinkPad X13s, where I could
reproduce the rc1 regression, and things works as intended with the
fix applied to rc5:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

The CPU frequency still oscillates heavily but now with a more
sawtoothed curve.

Not sure if it helps with performance, though, as running the CPU at
full speed as soon as we drop below the threshold (with hysteresis)
also means that we get back to running at the lowest frequency even
faster.

Johan

