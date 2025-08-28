Return-Path: <linux-pm+bounces-33249-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A2B39B02
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6F51885E6C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469330C61B;
	Thu, 28 Aug 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x9GfOVyw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C141F4CAF;
	Thu, 28 Aug 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379235; cv=none; b=U/AzuM8eaDXzZwE9e7Pg5SV2RF2X9itSw1/Yt9BWd3tlyI4G7aDvoC9b0Mzs74aBFo1GElu5Pgq4gUeXRj83skwBhO2i2w11kelh3bAvFqt35tewebq9Y5Ca+pJzjHkecKNt3tvj2Zju5fKbWOlDklfeU3U2C/qDCTpFPLPz9zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379235; c=relaxed/simple;
	bh=Azv4ohzdARRa6uGnEwoC67fTOgWZYWIdsIJ0un0crY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfaTfLRaYvm4azL2GB4iL6wQtbiMcbIe3kzmnX6Nkg+okkIzew/9qXISzzSEv6UaF1cTr1Ewc47RhKyPvCSigccsPk3qsgB1mJsegHTGsqr0IGmfNNQl+ohj/X9Mncn9Dp2OrxOv69Raw67CDOIVsp5TtJDwEwBZ8LMhE0X0Hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x9GfOVyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D4FC4CEEB;
	Thu, 28 Aug 2025 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756379234;
	bh=Azv4ohzdARRa6uGnEwoC67fTOgWZYWIdsIJ0un0crY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x9GfOVywmxB9/ON3yP/7Nwe8fxbQ4c8L9ew5jaUjqwOKsnn3qfPjrSdEByU5MrLDh
	 VmlLpLj87G5QnToxvmV4odDEiqtD1tiDCclortx+iYZ+TuMgcr9hQQTum3Xefcwvpv
	 CU1DQYGUlQp2g/HPF35LEqdLnEIZ4s9m6btIHYCY=
Date: Thu, 28 Aug 2025 13:07:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v1 0/2] driver core/PM: Two updates related to power.no_pm
Message-ID: <2025082851-progress-unsliced-ade4@gregkh>
References: <12749467.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12749467.O9o76ZdvQC@rafael.j.wysocki>

On Thu, Aug 28, 2025 at 12:55:50PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> Applying this series will cause power.no_pm to be set for faux devices (so they
> don't get processed unnecessarily during system-wide suspend/resume transitions)
> and power.no_callbacks to be set along with power.no_pm (for consistency).

Oh, nice!  I forgot about that entirely.  Should these be backported to
older kernels as well?

thanks,

greg k-h

