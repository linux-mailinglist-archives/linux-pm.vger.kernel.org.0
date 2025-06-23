Return-Path: <linux-pm+bounces-29262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA96AE3928
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 10:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43B6F188CDDA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 08:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5E22F769;
	Mon, 23 Jun 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3diSoL0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6516679F2;
	Mon, 23 Jun 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669088; cv=none; b=tYtdVOsIMJkl7Fum95VO30/DI1hDmg21/kqRJWBPZCBsDSTEyvwZtZI26uXTY5ioBaSOI32f1OsV6yAcCwrt1go6VVaBdJknfQZWcuf5y7Gi0p5A1jCyzNRLIS/lHSVnPSYIIfQY0rhcvbX6aIsNZ5F5rNFus0HdTTnrKotl9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669088; c=relaxed/simple;
	bh=GKBcbdFXtelcJamN7yeYxZa6oeTkseBIbNXavrEE34M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZSre6WUTzA1jc8Gdb3sa5HK8kETe+45Gn+8mclUm2xqB+895gNk+hCwRKxaBqmuAio4u1H/vAkIDYObxvi1vJlcbyc3SrBJqWYK6j50l+1tTlvnTd+Mk8f7uwH8x4K6wGkASLMDMNZgJAT1aLgXpY9gbxj4SCoZU4+my2vZMz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3diSoL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D800CC4CEEA;
	Mon, 23 Jun 2025 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669087;
	bh=GKBcbdFXtelcJamN7yeYxZa6oeTkseBIbNXavrEE34M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3diSoL03mA8/7AfLCg64ovP09oup6HXb7nuUmKai18/zBrUSiE0DSLb1sBBXJ/V3
	 T3CkT3FNadp8o+kHx3JT3GZyxzMLvvMiG525fVSJxo7p0P84+FCzFfPoFi4rNwlIka
	 Gn+7ZcD0NtXA0xKPG5sQetAJ/c43U+Am8tbkjctYCnr3h9tXOdNhoXCpg90nK6iPYr
	 puM+4fr76nPPOPxxNPqGAhD3c4TE4esJK+s55fsJ4Ca5imQmc4ewZ6LwBmZiFutqsJ
	 Jczbg36RnhP9SdGed7YHHl1oKHUrxm0vlwrKwo+gME1bNCUCEhOn4dBlPc8wHfAazI
	 Va5T9gv+Cdokw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uTd05-0000000009p-2vHQ;
	Mon, 23 Jun 2025 10:58:02 +0200
Date: Mon, 23 Jun 2025 10:58:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aFkXGUgM9R_MmcB0@hovoldconsulting.com>
References: <20250618-icc-bw-lockdep-v2-1-3223da346765@gmail.com>
 <aFPhdWoZDOrdrbQz@hovoldconsulting.com>
 <90bfae80-f3d3-4c1e-9a5c-9f8205bf90b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90bfae80-f3d3-4c1e-9a5c-9f8205bf90b9@gmail.com>

[ +CC: Bjorn ]

On Thu, Jun 19, 2025 at 03:03:50PM +0200, Gabor Juhos wrote:
> 2025. 06. 19. 12:07 keltezéssel, Johan Hovold írta:
> > On Wed, Jun 18, 2025 at 09:58:31PM +0200, Gabor Juhos wrote:
> >> The 'icc_bw_lock' mutex is introduced in commit af42269c3523
> >> ("interconnect: Fix locking for runpm vs reclaim") in order
> >> to decouple serialization of bw aggregation from codepaths
> >> that require memory allocation.
> >>
> >> However commit d30f83d278a9 ("interconnect: core: Add dynamic
> >> id allocation support") added a devm_kasprintf() call into a
> >> path protected by the 'icc_bw_lock' which causes this lockdep
> >> warning (at least on the IPQ9574 platform):
> >>
> >>     ======================================================
> >>     WARNING: possible circular locking dependency detected
> >>     6.15.0-next-20250529 #0 Not tainted
> > 
> >> Move the memory allocation part of the code outside of the protected
> >> path to eliminate the warning, and add a note about why it is moved
> >> to there. Also add memory allocation failure handling, while we are
> >> at it.
> >>
> >> Fixes: d30f83d278a9 ("interconnect: core: Add dynamic id allocation support")
> >> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> >> ---
> >> Changes in v2:
> >>   - move memory allocation outside of icc_lock
> >>   - issue a warning and return without modifying the node name in case of
> >>     memory allocation failure, and adjust the commit description
> >>   - remove offered tags from Johan and Bryan
> >>     Note: since I was not sure that that the added WARN_ON() is a substantial
> >>     change or not, I have removed the offered tags intentionally to be on the
> >>     safe side
> > 
> > Bah, what a mess (thanks for dropping the tags).
> > 
> > This dynamic id feature looks like a very ad-hoc and badly designed
> > interface.
> > 
> > icc_node_add() should not be allocating memory in the first place as it
> > is not designed to ever fail (e.g. does not return errors).
> > 
> > Generating the name could have been done as part of of
> > icc_node_create_dyn() or yet another helper for the caller could have
> > been added for that. In any case, it should be done before calling
> > icc_node_add().
> > 
> > Perhaps the best minimal fix of the regression is to move the allocation
> > into the two users of this interface. They already handle both dynamic
> > and non-dynamic node allocation explicitly.
> 
> Ok, I will change the patch. Just to be clear, do you mean the
> qcom_icc_rpmh_probe() and qcom_osm_l3_probe() functions, right?

Yes, indeed.

Apparently this is how it was done in the first six iterations of the
series adding this and then the author was asked to generalise the name
generation. That can still be done as a follow up (by the Qualcomm
folks) after fixing the immediate issues:

	https://lore.kernel.org/all/lm6gvcrnd2pcphex4pugxie7m47qlvrgvsvuf75w4uumwoouew@qcuvxeb3u72s

> > Then whoever cares about this code can come up with a common interface
> > for allocating the name (e.g. move it into icc_node_create_dyn() or add
> > a new icc_node_init() helper or similar).

Johan

