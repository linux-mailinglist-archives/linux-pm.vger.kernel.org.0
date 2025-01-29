Return-Path: <linux-pm+bounces-21077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D3A21821
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 08:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944F17A2DFB
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CE2199239;
	Wed, 29 Jan 2025 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4EfT3Ub"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E6F1991D2;
	Wed, 29 Jan 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738135806; cv=none; b=LFoEyY9KUwZA5O3WFTYbany+VmYSuH7qn6KXWesvLrliYpIiolQOXpiRIqy2isP7cwWvRJ0ciUMZDs2ZV5pmCwF1KSDL/fjnqbCynCcUUDWhwBUryA5rNeqbhz+DwGHQZLr/o6RPkik2nA6tuEwD9c5w1ahJiQ2FkQIRVbOzMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738135806; c=relaxed/simple;
	bh=YP70k3CuKOov2UxqgnQYgL5HUHj0EryZS8nauAe2jjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsOo6V59n4qklq11DoBKWkHtqZDuEu4D2ifjJoO98azjqd1ezbXxqo1TyoOhGw8hptY3EQM//upR0EHRgcRK2zP25zLRhqRT9QkwA90RG4gqoA1nWQxY7x9eLvkqCDowk3R7Xl/qWGINgxAwBNV31dXlNc+02C8dUKKMpcVZd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4EfT3Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B43FC4CED3;
	Wed, 29 Jan 2025 07:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738135805;
	bh=YP70k3CuKOov2UxqgnQYgL5HUHj0EryZS8nauAe2jjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4EfT3UbNbTuywP7/eWQWkq9G1EmPjDzLGf+l/fPzYmwz7ipoY3s25dKEfMgMYoiU
	 iPxUqFxFMhxzmN+hmKnGnRRNXQB1J5TkayoVCdixsAGt/3/B8mqzGIDQTer/Kp6qnb
	 Hi+f/CEIIDhACy/LfW/w7IwYpsV/Bd+2PhHVS6bWg0aLyG0OnZwDrafhQ9svsiu8hQ
	 nfvt0HmzBZH97DHv3hqCodcMO/qzfPbudlzAPuG8DQydryTz/Mg7Y6YhLpZs+KkUKs
	 shUny9WTbVOLVJ9ZOeMUUhBlviZFLVqorJNsG4gf9kgGBjg3TBKpJOvkSFe90Lv7Kr
	 /H04vnOdkwVkg==
Date: Wed, 29 Jan 2025 08:30:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, 
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com, 
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org, 
	jszhang@kernel.org, p.zabel@pengutronix.de, m.szyprowski@samsung.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 03/18] dt-bindings: firmware: thead,th1520: Add
 support for firmware node
Message-ID: <20250129-marten-of-incredible-gallantry-604baa@krzk-bin>
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
 <CGME20250128194829eucas1p279fb146417854b28366378793087694a@eucas1p2.samsung.com>
 <20250128194816.2185326-4-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250128194816.2185326-4-m.wilczynski@samsung.com>

On Tue, Jan 28, 2025 at 08:48:01PM +0100, Michal Wilczynski wrote:
> The kernel communicates with the E902 core through the mailbox
> transport using AON firmware protocol. Add dt-bindings to document it
> the dt node.
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  .../bindings/firmware/thead,th1520-aon.yaml   | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


