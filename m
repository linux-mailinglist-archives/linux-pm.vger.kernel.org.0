Return-Path: <linux-pm+bounces-14392-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD097B8F7
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 10:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6110B1F21665
	for <lists+linux-pm@lfdr.de>; Wed, 18 Sep 2024 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71916DEA5;
	Wed, 18 Sep 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrdFhOaQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999C15853D
	for <linux-pm@vger.kernel.org>; Wed, 18 Sep 2024 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726646877; cv=none; b=amWy9Aui6XiIrmxdJDJfuSwxG5dem806WUNHPdR5M18Tml8Uy3Sp3QVGN4Iu5ryOw9kuMmJJ+YMGpiVK8xvJMMMPdNaaNyHEpcCAB+n1yS3JA6A2cXjdAlNNgTgX1C8y3a8Osq6NBS6v1rqxlhHdyb/Z+j31IlV6eJ53EKkiC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726646877; c=relaxed/simple;
	bh=S8oIi2bROLBwKCgEI9vSDgbdsEnKE46i+jgERGTIKIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6h8VU8HOrUqTcxUu15pmETeQ7ZZBAxFHQgVWC//diqsseEZHRf8voUr/uz5MPt0vqxK5G7NcBkEB22VM59n4ND6+RFWzSEjykzK14DpVCrSWXW527saKAvyQquhKmRKWr9FGckfIj1pAnqdOrUZuY6FjHSbHdegxR7BdgTrNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrdFhOaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D6CC4CEC3;
	Wed, 18 Sep 2024 08:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726646877;
	bh=S8oIi2bROLBwKCgEI9vSDgbdsEnKE46i+jgERGTIKIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZrdFhOaQj620vBulCPhHahiXApN2x3W5PGoy9TMM2P13UKuCzqGP6FIelC0WcrWFA
	 J6/MrY1GePTHDWfVioM+qMacztddbHL0alyjZXABSeGq0dhDkPVoK03Evo07QCYyXe
	 /fqo/Q4+QOqp2cEz2z+5kQXVDAMg1cgwktSM7X2pf0Ks4BCiQGwFgeAMtVhp+W1jWO
	 scoVRLikUIW9FFxsb7r88H4nBeMNfqIj5Z13AvsCd/qn6KXRsLb1htuvQDAKXzP1ym
	 4uoBUHFSRC294M3bXt1P8+KoYNflVpK2YCp05xNQ1gElJjydKZKYOhh8Hs/esm7onH
	 TXZNZnHxLJ3Iw==
Date: Wed, 18 Sep 2024 10:07:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH] power: supply: core: Remove might_sleep() from
 power_supply_put()
Message-ID: <hsfakjq4qoc5ms43duendygrrwj4kqrswgxocmcsgz4ut7wgsk@v66x2emhqxzw>
References: <20240917193914.47566-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917193914.47566-1-bvanassche@acm.org>

On Tue, Sep 17, 2024 at 12:39:14PM -0700, Bart Van Assche wrote:
> The put_device() call in power_supply_put() may call
> power_supply_dev_release(). The latter function does not sleep so
> power_supply_put() doesn't sleep either. Hence, remove the might_sleep()
> call from power_supply_put(). This patch suppresses false positive
> complaints about calling a sleeping function from atomic context if
> power_supply_put() is called from atomic context.
> 
> Cc: Kyle Tso <kyletso@google.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 1a352462b537 ("power_supply: Add power_supply_put for decrementing device reference counter")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/power/supply/power_supply_core.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


