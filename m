Return-Path: <linux-pm+bounces-39426-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FAFCB49E2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 04:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3644F300E01D
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 03:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A1921D590;
	Thu, 11 Dec 2025 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiDjJDVF"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E40433A6;
	Thu, 11 Dec 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765423400; cv=none; b=dPzQv3P/q+06HgihA6sm40zxOxb/9VxCCFdTxuvmSL0gsnMQqPz2WcmMzodntxvCkJY9SmkD+L45YTbGrIEKaaEvpjlzvQGt7yrMzGdYDIEdwVhkGjptjJsVTI9fokkSq/OWn7EvlhSjBrGQhERygL2PJ6MbQ3T9gS0ZAdlVPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765423400; c=relaxed/simple;
	bh=a0Epa1us7wO6a0BPZ/bo7QqH9zJkTuAwclOeQKiSfno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKiSAmpzMMgK185sTvSPhQ82D996OwgVIab9l6FlHPI3V6zUzw1KGRj7++wPno6J/6w2s3FK3zRNaBOYJI7qakGDeR0pGYK5ONLycszLhnWC8vmEB0FulqSrTZ7PyzezynrHkKQUk0o8X9riV0TNTnIK/L9QWLxg+C5O719wgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiDjJDVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8457DC4CEFB;
	Thu, 11 Dec 2025 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765423399;
	bh=a0Epa1us7wO6a0BPZ/bo7QqH9zJkTuAwclOeQKiSfno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiDjJDVFQ6AaZidE0Fizdtb+qH891QQics9CdLa2R+SA3x5SGBqSKEeQ7PQlBhUE4
	 XvolnX/0pASSY/WRFHZRDhhss37KAPJotO8LwH6+FvHz4183XOzkGKs8IxHgh0A2qE
	 GmL8xYl/qeAK73dTyrr1q/62HfXwd+AA2d1UbtI9nQvtYVTvhMw3oQdD3L/Ujr5v4I
	 d+cMVZSq21eYW4dUOJGkZXpFvLRBL7ogNtt/ahHSi3MZRtgo6eWeeQpDiER7lp5iHB
	 WL/Kqqp5TbdYGrLL8sdPClRR7ov1j+p9Bcsg502JzhQqiJMgXe840g6zpgi9cC664R
	 B+kWyrR6kwQEQ==
Date: Wed, 10 Dec 2025 21:23:16 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Pavel Pisa <pisa@fel.cvut.cz>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] cpufreq: dt-platdev: Fix creating device on OPPv1
 platforms
Message-ID: <20251211032316.GA3866149-robh@kernel.org>
References: <20251210051718.132795-2-krzysztof.kozlowski@oss.qualcomm.com>
 <rcnqsevjxtyfu56pcw5wfjh7wvg4q32xu2xkol7tfvaozewrxz@3qn5qbjc5mpd>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rcnqsevjxtyfu56pcw5wfjh7wvg4q32xu2xkol7tfvaozewrxz@3qn5qbjc5mpd>

On Wed, Dec 10, 2025 at 12:00:22PM +0530, Viresh Kumar wrote:
> On 10-12-25, 06:17, Krzysztof Kozlowski wrote:
> > Commit 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with
> > of_machine_get_match_data()") broke several platforms which did not have
> > OPPv2 proprety, because it incorrectly checked for device match data
> > after first matching from "allowlist".  Almost all of "allowlist" match
> > entries do not have match data and it is expected to create platform
> > device for them with empty data.
> > 
> > Fix this by first checking if platform is on the allowlist with
> > of_machine_device_match() and only then taking the match data.  This
> > duplicates the number of checks (we match against the allowlist twice),
> > but makes the code here much smaller.
> > 
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes: https://lore.kernel.org/all/CAMuHMdVJD4+J9QpUUs-sX0feKfuPD72CO0dcqN7shvF_UYpZ3Q@mail.gmail.com/
> > Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
> > Closes: https://lore.kernel.org/all/6hnk7llbwdezh74h74fhvofbx4t4jihel5kvr6qwx2xuxxbjys@rmwbd7lkhrdz/
> > Fixes: 6ea891a6dd37 ("cpufreq: dt-platdev: Simplify with of_machine_get_match_data()")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > ---
> >  drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index a1d11ecd1ac8..b06a43143d23 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -219,11 +219,12 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
> >  
> >  static int __init cpufreq_dt_platdev_init(void)
> >  {
> > -	const void *data;
> > +	const void *data = NULL;
> >  
> > -	data = of_machine_get_match_data(allowlist);
> > -	if (data)
> > +	if (of_machine_device_match(allowlist)) {
> > +		data = of_machine_get_match_data(allowlist);
> >  		goto create_pdev;
> > +	}
> >  
> >  	if (cpu0_node_has_opp_v2_prop() && !of_machine_device_match(blocklist))
> >  		goto create_pdev;
> 
> Pavel, please give this a try as well.
> 
> Since the original patch went via your tree, take this one too please:

Applied.

Rob

