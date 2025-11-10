Return-Path: <linux-pm+bounces-37700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F605C44B34
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 02:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5603AFBFC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 01:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B201EE7C6;
	Mon, 10 Nov 2025 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6nNA9XW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC8286A4;
	Mon, 10 Nov 2025 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736588; cv=none; b=GZdm5uwFusb0n9fMQGz8anuDP0d5oR95UCQomJRzr6GP0gcmIFC9ZzcjBZpjlRd2uZHcAy9jgxJaU6LGmWaH5cjsI6y+Q9QGMXmVsycf2ubrMIfy5JxITD42UWhwF1OaptQSADL8mSeCPB170RPjB/PvQ/Is1NKkClkFZ8SE3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736588; c=relaxed/simple;
	bh=9gONua8THbFl1jXOVI3saF1mGxHRiv8WjayiJxmWh0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYj6S7y2SOMDP18r8fwme7S2s4dYzug7YSHzAfxjfxPZaFTb12/fw9DQpi7XdOvuFfU9/4oOdtHJszjvpLamZLjpaujkSE0W8PM/ziYNGy0wNTChJF2RZZWmQPaxtvIGcKK1nJ1e6AbHhwDQx4XjqzeG8SSyj0tA1PmJ961j8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6nNA9XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8766BC113D0;
	Mon, 10 Nov 2025 01:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762736587;
	bh=9gONua8THbFl1jXOVI3saF1mGxHRiv8WjayiJxmWh0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6nNA9XWvOuh6Sbtu4Famk+GcVbVSqCZp7CML7xvVZmLr7Y0KzarHk8eCM+9GuE7N
	 4e0wQn+UkLo7FOpsYWBRCcoavfOr9WGqEn8uTcFXgeJX/KS1/kF2JydncDDifsceC2
	 FwWuHXn8AByWTX4q19SFZIpEtMLu4i++JP05WZBx/Ueko7Pk1SNFv+AbpyUTfwNqLn
	 DkQpmGj8Z/lyAer3l2htFq+PVYamNpA8Zac4K0/w2gPsp7FI6LFcsYvMd0UgAmaIot
	 D/h4WhJintFsP2VqUZ6dUk4uOFyiEkP2iOzJT2rmDfOMKL3X67ae9rvaat3m2Hw607
	 1RLmdoL33s7jg==
Date: Sun, 9 Nov 2025 19:03:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: Drop db8500-thermal.txt
Message-ID: <176273658529.2481060.8480391910495897172.robh@kernel.org>
References: <20251030195234.439141-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030195234.439141-1-robh@kernel.org>


On Thu, 30 Oct 2025 14:52:33 -0500, Rob Herring (Arm) wrote:
> The binding is already defined in mfd/stericsson,db8500-prcmu.yaml and none
> of 'the tripN.*' properties appear to be in use.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/thermal/db8500-thermal.txt       | 44 -------------------
>  1 file changed, 44 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/db8500-thermal.txt
> 

Applied, thanks!


