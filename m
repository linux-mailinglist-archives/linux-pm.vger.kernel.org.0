Return-Path: <linux-pm+bounces-34610-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C1B56CE3
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 00:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EA484E0F17
	for <lists+linux-pm@lfdr.de>; Sun, 14 Sep 2025 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACBC1DBB2E;
	Sun, 14 Sep 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1YDF8RJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498C918FC86;
	Sun, 14 Sep 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757889164; cv=none; b=h6lb2hVnLBoNvdXUDla+POPVVB1vQ/GnGULuqkpzECfQErSeSIMLv2YkipdXkxZlKIbYc3M8g5FF/4UIaCVLbmu6TSF9uEQixef57vPpZznLayqapLpm4BZNRLN/JgnnoTu8vRMqWk3lg922b+1dOFzvXxB9F3BlBF0/sosBTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757889164; c=relaxed/simple;
	bh=wXyCnLrX0fLmiL09ceBL+O0pB03rFyh3riUHh0WJl+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLMifQ34zDMcJFRfMp9O4Hv6hz+tENILhZDV0pRiKExwaVQrJMu5k1XJD4cYUn2Cop2KkZMTfvxODDTBUUi+QPnfjMRAToDGqZKv/98eQcmJb5V+YvQeKijA0sVff9Q/ZZIp39G/4fqHV2jfmNZ5Qk0eviGuFw2lWA6OMPthpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1YDF8RJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E377CC4CEF0;
	Sun, 14 Sep 2025 22:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757889164;
	bh=wXyCnLrX0fLmiL09ceBL+O0pB03rFyh3riUHh0WJl+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1YDF8RJMkIJQkyU1B3O4sFY2gxa9DYzWsRotO2Q03ol7Fn0I/CbRNkMqNMbylCtv
	 yu4+xbKUSOY8oNrl3+QOLkse76kBNGSa+SvcdKYEWmsQfDNKIA00HIITIuPeOIsjk5
	 DN8yAGcna9Yfb16v1n9vgI3nN5Ymeu6Qg0DvtJhe1ty21Xx8mHU5T23kbm872mbiIT
	 oRkiavFbj1zS4FJqIv7j0oxHeGDPpJiK0gLxOH6DPPl/pRllNxEvgebYfwS2lg/cKX
	 YA9LQ9k6IEQO32PNS4j+LPAGPmNmhGxH4MLDPmo25ONozdu28NvhTJ3MFLlHNufl8S
	 w9koWYAdcur2Q==
Date: Sun, 14 Sep 2025 17:32:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1 1/1] dt-bindings: power: supply: bq27xxx: document
 optional interrupt
Message-ID: <175788916249.2105203.16922867831737172160.robh@kernel.org>
References: <20250909143432.121323-1-clamor95@gmail.com>
 <20250909143432.121323-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909143432.121323-2-clamor95@gmail.com>


On Tue, 09 Sep 2025 17:34:32 +0300, Svyatoslav Ryhel wrote:
> Document an optional interrupt found in some controllers of BQ27xxx
> series. The pin to which the interrupt is connected is called SOC_INT or
> GPOUT.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/bq27xxx.yaml        | 37 +++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


