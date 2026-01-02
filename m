Return-Path: <linux-pm+bounces-40127-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 807F8CEE849
	for <lists+linux-pm@lfdr.de>; Fri, 02 Jan 2026 13:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B22305B59F
	for <lists+linux-pm@lfdr.de>; Fri,  2 Jan 2026 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4238030F814;
	Fri,  2 Jan 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajr0/a2S"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC330F7FE;
	Fri,  2 Jan 2026 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356479; cv=none; b=r4QqV1Kcx3vOPY1+eREeMkuZQk480FyegtX7vVGb7hPO7khJK9tO8OsXnZRr8Z0tDSd5hFwPTHAUefa4aQcR7ehwYjwa6WkEsDHU9bKwhG2Wjj8OjJZZW+f4x/WDr6Im0M5ouE2ebyL8ahhOAOm5sgm+5mXJZ/o1mqZT00Lsjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356479; c=relaxed/simple;
	bh=UHlQsLcaXWnyACvrjhEb45lh4+oW0nhffnIhnMdC96I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu7i2Ulp5XErDUVb75fm/txWL9qOtpsCU51QuEDr84qhQUe+2lciXNRhIWSxgKLIhBnld8j9Io+I+7l0y8IUz/2VWzGgENf4vs1CS07Lc5qLkn+pn7BkzpcjAR+19qkyMorpaiwTU3qJ9oSwNknraceCQEDAwhfEPl9hf4kC4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajr0/a2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56020C19421;
	Fri,  2 Jan 2026 12:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767356478;
	bh=UHlQsLcaXWnyACvrjhEb45lh4+oW0nhffnIhnMdC96I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajr0/a2SRrlWfK1kVMdMkEN8q1r5oNniCbx5pFlwKj9+xd/p537VjL40rqq7rbNdF
	 r4MmIrJVn+yZdrsWB/XqfSEXbOl2N2Lj8WcHt2Z+iMXq/AX3kDH3NKUPaPhgk61763
	 8u+fOEPthswj5vlgEmD8b2YAH28tRxXZ8Kikotjut/qCcZcEvu5DVDrLEuvzHk+V1J
	 obBuYzjMheibb3sqYjZ4d3zVUuKGKDGOPBmuUIKOg3To7zDOVFgUYEVh3yGvP4Ml7N
	 PiOWa/7I4Q4tUOx0Fwo1tOEDxrYl3xMYVhpxq1h5MuP32XKogITy64BEozw0u1a0UU
	 Sip0KeoTBqZ8g==
Date: Fri, 2 Jan 2026 13:21:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dmitry.torokhov@gmail.com, sre@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, 
	jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: power: supply: google,goldfish-battery:
 Convert to DT schema
Message-ID: <20260102-stereotyped-cunning-booby-a680c8@quoll>
References: <20251230181031.3191565-1-visitorckw@gmail.com>
 <20251230181031.3191565-5-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230181031.3191565-5-visitorckw@gmail.com>

On Tue, Dec 30, 2025 at 06:10:29PM +0000, Kuan-Wei Chiu wrote:
> +---
> +$id: http://devicetree.org/schemas/power/supply/google,goldfish-battery.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Android Goldfish Battery
> +
> +maintainers:
> +  - Kuan-Wei Chiu <visitorckw@gmail.com>
> +

Same comments.

Best regards,
Krzysztof


