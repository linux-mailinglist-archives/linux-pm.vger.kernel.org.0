Return-Path: <linux-pm+bounces-19039-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC27F9ED230
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79685164DED
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC01DD886;
	Wed, 11 Dec 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5EYCr7B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4DA748A;
	Wed, 11 Dec 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935044; cv=none; b=WTtI/yD6VRLhvCm7gIO/G/TYS7daLyK0jxh+OVDHrpigAJSCH6/itzfTByAjaeH5hiqJkMIslnnyZMhisD+d/rN123b/pdFoy8VS4VlVEK9xXJpV2hWaxDgRfNcxgGUirV+3ObyAlu8kHpKAMfJ95DsuqysseFnkwg9aBvu0x1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935044; c=relaxed/simple;
	bh=8eA9BJX3oFLeozHhMdBrICHXFRV2fuAROPLxJNk6lUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuBh0/zC2aGdxqwtYN+GBDciMGsQ6VKrFnkS4Kg6ZBQ4RnKywVoHIKfSa2+4I+HJRMuCXvNrBRmMJQBIPWWmkrrz7qbI683jwNOmO85/FsKPa38nbaOTFpy+0B/O+PO4Rbrab7g5mQSPCgVgJ8StbWOhiB6M8N/to254pnebvns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5EYCr7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F52C4CED7;
	Wed, 11 Dec 2024 16:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733935043;
	bh=8eA9BJX3oFLeozHhMdBrICHXFRV2fuAROPLxJNk6lUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5EYCr7BqnWJ0CEsAN7uY0ekYvJx0hzWo36sqoka1qlxDZebe2Am8u2Z2sQM+4L1/
	 rbGISmg/vznvKUkEu8EtNtu0dP5gaZiepJI0FcceA5hymSvklNzu0zrv9Xi0Axc3Ry
	 YFmGWrqFR9HgjvO1CJSBjx7lpS32SkpjYEORdAdRsO1t8BwOAHJeYguyXGzl+LqCh/
	 CGXe7h8AbX+TkhSQhu4Wt+KuwB8CbS/0ENWJgKg4QDQJ8EklFI5wlqdFWlr1KMyqmS
	 5JBkPKRSx+lvjNt60tGazC64YcZQR3o5EamQVFiXUFU5OgXPbz/tqyeMoTRwV4i86g
	 goFUs/j1S2Jiw==
Date: Wed, 11 Dec 2024 10:37:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, upstream@airoha.com,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: cpufreq: Document support for Airoha
 EN7581 CPUFreq
Message-ID: <173393504106.3264222.5725746620417782948.robh@kernel.org>
References: <20241206211145.2823-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206211145.2823-1-ansuelsmth@gmail.com>


On Fri, 06 Dec 2024 22:11:24 +0100, Christian Marangi wrote:
> On newer Airoha SoC, CPU Frequency is scaled indirectly with SMC commands
> to ATF.
> 
> A virtual clock is exposed. This virtual clock is a get-only clock and
> is used to expose the current global CPU clock. The frequency info comes
> by the output of the SMC command that reports the clock in MHz.
> 
> The SMC sets the CPU clock by providing an index, this is modelled as
> performance states in a power domain.
> 
> CPUs can't be individually scaled as the CPU frequency is shared across
> all CPUs and is global.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Changes v7:
> - Add more info to the description for usage of clock and
>   performance-domain
> - Drop redundant nodes from example
> Changes v6:
> - No changes
> Changes v5:
> - Add Reviewed-by tag
> - Fix OPP node name error
> - Rename cpufreq node name to power-domain
> - Rename CPU node power domain name to perf
> - Add model and compatible to example
> Changes v4:
> - Add this patch
> 
>  .../cpufreq/airoha,en7581-cpufreq.yaml        | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/airoha,en7581-cpufreq.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


