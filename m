Return-Path: <linux-pm+bounces-14630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81327984BF0
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 22:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF61F245F2
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3491313777F;
	Tue, 24 Sep 2024 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBsG1ohG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3912FF72;
	Tue, 24 Sep 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208700; cv=none; b=mY6R2XX54rx9H1MIKDSQdst0DwCZumn/u209E1ZS0E8kk0m4r4GkkZm/jfjlOMgn7ll11k9DLxcSt/COt5Hw/GinaqLbCi4rsm3kp9qOrFACLYTOeZOhVGhByhdHDFuDEvX+beyiUoGMmUUNOgBxp5lflKusITPRL4+CW+M7MFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208700; c=relaxed/simple;
	bh=BpM3L2fJi40cQNfIVH/3sRVNGhX/2TnD4+srh5tJsoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMbmQLxZf6DzZcnO3hUyjh7NuEsVMbCajQaQi1PmfivQhiuwPkgLwl8LJvkRy/Parp5NPbKPBp49AOJ1lLvQ3dMgg1FnJ3K5KYCL0BvC2O/YSv/IP9oAuncjamRZYZcpzLkRyqMdWabFxvev895x1E++QE+aQ8DnZCOD4zpAMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBsG1ohG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B16FC4CEC4;
	Tue, 24 Sep 2024 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727208699;
	bh=BpM3L2fJi40cQNfIVH/3sRVNGhX/2TnD4+srh5tJsoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBsG1ohGyn7Y76rCX8gQdF7haDHzuNshMGip9bS5YhzFZY8BNdUrYHdKorXZgcUG+
	 4R7tH0AxIrYSQ9Ipannc8zzOen6pUDvujS4EuhMEqUbM+qo7Fzlsm2KvBmW+u84udZ
	 F26E26xu6DY7/+dK9m/N2xV7c3gbVkIAE60m2WlozMN9deKlK3g96eNeRXaUFiRJ5r
	 Z8kQEwsO1fF1jPWK863cCBla+9flcjhdXbFy2+EHZHPkg5s/J2/2jIgpSKOaMt0EtH
	 hwpq+4UoLOmc5YB4cZxRB9NCXAB5F7QMl1F18FI1JnVJ2r1/wLfY1ibX3xVz+Ix/hc
	 VOL4Eq6QAyIHw==
Date: Tue, 24 Sep 2024 15:11:38 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-pm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5] dt-bindings: opp: operating-points-v2-ti-cpu:
 Describe opp-supported-hw
Message-ID: <172720869759.222696.1265461647431110381.robh@kernel.org>
References: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919-b4-opp-dt-binding-fix-v5-1-199216dc0991@ti.com>


On Thu, 19 Sep 2024 18:43:40 +0530, Dhruva Gole wrote:
> It seems like we missed migrating the complete information from the old
> DT binding where we had described what the opp-supported-hw is supposed
> to describe. Hence, bring back the description from the previous binding
> to the current one along with a bit more context on what the values are
> supposed to be.
> 
> Fixes: e576a9a8603f ("dt-bindings: cpufreq: Convert ti-cpufreq to json schema")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> Changes in v5:
> - Fix the new lines inserted to seperate paragraphs.
> - /eg./example,/
> - Fix Odd line wrapping
> - Link to v4: https://lore.kernel.org/all/20240918173431.GA1833339-robh@kernel.org/
> 
> Changes in v4:
> - Fix dt_binding_check errors on previous revision.
> - As per Rob's suggestion, used a blank line in between description
>   and the paragraph.
> - Reworded the description a bit.
> - Link to v3: https://lore.kernel.org/all/20240917095252.1292321-1-d-gole@ti.com/
> 
> Changes in v3:
> - Use the items: and then provide description for both required items.
>   This tries to address Rob's comments on previous revision.
> - I've not use min/max Items as the 2 descriptions items implicitly
>   imply that number of bitfields needed are 2.
> - Link to v2: https://lore.kernel.org/all/20240905-b4-opp-dt-binding-fix-v2-1-1e3d2a06748d@ti.com/
> 
> Changes in v2:
> - Drop the patch where I updated Maintainers since it's already picked
>   by Viresh.
> - Add more details of how to populate the property based on device
>   documents like TRM/ datasheet.
> - Link to v1: https://lore.kernel.org/r/20240903-b4-opp-dt-binding-fix-v1-0-f7e186456d9f@ti.com
> ---
>  .../bindings/opp/operating-points-v2-ti-cpu.yaml     | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


