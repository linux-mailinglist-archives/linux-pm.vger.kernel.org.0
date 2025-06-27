Return-Path: <linux-pm+bounces-29646-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E302AEB32B
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB80317CAD5
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D150293C6D;
	Fri, 27 Jun 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n23E/N/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D625F78A;
	Fri, 27 Jun 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017408; cv=none; b=ITtE5WYMin4iDIOYZ2t8i/fLJDBHi8bMdbDE3l56NWU0ntf94Hp+9EVxxOOzWgwXB28HVjLvj6lVj1gAMNEs14ZpvC0vnvuOQRAIjE4Ejlbp/L0OYVEpjWgtXo5DneANwIs/ioOFefp6FEabOfHcwudnVWjrGDyNk5iix/CMeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017408; c=relaxed/simple;
	bh=ngQ6R8Q7RFtEfkc0s81vKQLJQh7gq65r5WAROHbGqPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6AHpuiB9x2r3m05qdXGeXmDAtN2K5nzBde5vrbKbkajGuIwJwXNNDSX/ElHpXmG10vdJBCUbHtuY/TlUQftKM3NFrwYemAl1McdWXeM1X85dqO5h53n6nzRVLSRTKya25lJ8irSZjTXBFOUmqZnx7AjcthOoKICUuvqsAAJts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n23E/N/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66DCC4CEE3;
	Fri, 27 Jun 2025 09:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751017407;
	bh=ngQ6R8Q7RFtEfkc0s81vKQLJQh7gq65r5WAROHbGqPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n23E/N/GoDphO9m5at0H5Ohu/mB4/Lyn7IXvno7I3e12cZfUUf1y9yA4BOmlB8QGT
	 mpnMMoTgdPyfUY4fZJLS5D3rDzPkMBBXhxg/UKe2DYNVDf9BWFuOTyTQE2QxtIBtoG
	 fgRg3oxCVUeiUirEij94ch9QE0DcCHceByoQUhX+Etw7w+RlY30sFyekBLX8GmHlns
	 b0ZwcW/CvPYk6/HUpYmiU5la90TuWpLNGKwFCOLj+Bp0dTtirdwlC1l3djuMEKAlar
	 dcX5m6dZDtUeM6ebC3AptqAwYSvDmLcoQaLwgLT00lEWexaVtrde+0gZpmPMwvjYIL
	 GUIISfTng1p9w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uV5cF-000000000Ug-2baj;
	Fri, 27 Jun 2025 11:43:28 +0200
Date: Fri, 27 Jun 2025 11:43:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Georgi Djakov <djakov@kernel.org>,
	Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: avoid memory allocation when
 'icc_bw_lock' is held
Message-ID: <aF5nv6TQoyfh7wKS@hovoldconsulting.com>
References: <20250625-icc-bw-lockdep-v3-1-2b8f8b8987c4@gmail.com>
 <aFvr1zSkf4KmIcMT@hovoldconsulting.com>
 <aFvuiVX0kMIqXQtZ@hovoldconsulting.com>
 <84b94649-a248-46b0-a401-772aeb8777a2@gmail.com>
 <aFwBYRF0wJwVDdeX@hovoldconsulting.com>
 <ac5ba192-b538-457e-acc4-c2d358b1fd0e@gmail.com>
 <aF0TIWfDI4M1azzc@hovoldconsulting.com>
 <3b90caec-b4c0-47d8-bdd7-1a7abd5e69d9@gmail.com>
 <aF5EPhd5smrmB38Q@hovoldconsulting.com>
 <b960680d-6c5a-4130-b2dd-4ddf1f800430@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b960680d-6c5a-4130-b2dd-4ddf1f800430@gmail.com>

On Fri, Jun 27, 2025 at 11:36:26AM +0200, Gabor Juhos wrote:
> 2025. 06. 27. 9:11 keltezéssel, Johan Hovold írta:
> > On Thu, Jun 26, 2025 at 05:00:42PM +0200, Gabor Juhos wrote:

> >> Despite the note above, your proposal looks good to me. Would you like to
> >> send it as a formal patch, or shall I do it?
> > 
> > I can post it in a bit.
> 
> Great, just saw the final patch. Thank you!

Here it is for reference:

	https://lore.kernel.org/lkml/20250627075854.26943-1-johan+linaro@kernel.org/

It looks like Georgi picked up the patch from this thread yesterday,
which should be fine as well as I only changed the commit message
(replacing the ipc splat with one from sc8280xp) before posting it as
v4.

Johan

