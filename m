Return-Path: <linux-pm+bounces-36653-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD6BFC4B9
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 15:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A158C623CBC
	for <lists+linux-pm@lfdr.de>; Wed, 22 Oct 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB5221ABB1;
	Wed, 22 Oct 2025 13:37:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA3326ED5D;
	Wed, 22 Oct 2025 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140255; cv=none; b=JDZGAc2kaozmEn+49xvjyfGtPi2YG0XCTWHt0br4MMIhqg28GMl0tpqyuMZnXHU47zCuYB+WqSqApvzzkDPAxXCbWQrig9K00YIMeWQfFqvUXP0iRlr5K87THn1Ho1glqkXf9ZvNb09qYgDijrdVqB5MG1/oc+qGvGRbJqmTrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140255; c=relaxed/simple;
	bh=2/Zr8EbiNzvQGrIqKwIzmh9iQkSL/0y2Bs+hfNheya8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSxoWmQ1Y+zHo3OFoaFQmLjI0AfHcKzsgE3CuxQHvu7kyGgGO6Ne2i86Shcud4qWHLWGyrUMPCboJeiCtNAkXR4/uIG8lOKeNYFkGuhM2r7P7gYY0fgwiDHVyfKc+oG7eJE6/LOVPfVeGJYP7LJWnskgh59yAcAKUnDRHQrn5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 08959BB9EA;
	Wed, 22 Oct 2025 13:37:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 29F4920024;
	Wed, 22 Oct 2025 13:37:22 +0000 (UTC)
Message-ID: <703531ba0d3183ffc77e5a76922099564848091e.camel@perches.com>
Subject: Re: [PATCH] OPP: Initialize scope-based pointers inline
From: Joe Perches <joe@perches.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"	
 <rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon
 <nm@ti.com>,  Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org
Date: Wed, 22 Oct 2025 06:37:15 -0700
In-Reply-To: <45a64ff434a027c296d1d5c35f442e51378c9425.1761128347.git.viresh.kumar@linaro.org>
References: 
	<45a64ff434a027c296d1d5c35f442e51378c9425.1761128347.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 29F4920024
X-Stat-Signature: nujp71fqdoj4py6c5dr64q4sf7x9awtb
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18nA0GPMNuaN2fS6qCjOtF2RsNNe/yEmPo=
X-HE-Tag: 1761140242-393872
X-HE-Meta: U2FsdGVkX19AYZm+QcHlGSPJSlcc4ebFpZdzUIOeHj3GNN3ARM9viy93reD0WqIPrWlajPMh/8pA28to2CMA3RiuUfRIgammdcs0VUA5KVnm+KEq42dA7vLqZJIuQijYgmqxdk1aWOCjNXatLYhibBD8GhP9c/fAOkw7VBS9K/PbuYjNblGBjk9jMOkMJAKh9eVJ9F88lHSC7vpNX1F20dxhPmGKHNLaRPUFrF2cT+lFgGLVuobydAOzmF0XJOMjr61YlEED5vWOL5yaDoRnOCeYt0TAfsWCFMk7d3aG0Ye0Q9bAIajhY3TImcFWP4ha

On Wed, 2025-10-22 at 15:49 +0530, Viresh Kumar wrote:
> Uninitialized pointers with `__free` attribute can cause undefined
> behaviour as the memory allocated to the pointer is freed automatically
> when the pointer goes out of scope.
[]
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
[]
> @@ -309,9 +309,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_is_turbo);
>   */
>  unsigned long dev_pm_opp_get_max_clock_latency(struct device *dev)
>  {
> -	struct opp_table *opp_table __free(put_opp_table);
> -
> -	opp_table =3D _find_opp_table(dev);
> +	struct opp_table *opp_table __free(put_opp_table) =3D
> +		_find_opp_table(dev);

Style trivia:

It's common to include a blank line after the definitions.

> @@ -327,7 +326,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_max_clock_latency);
>   */
>  unsigned long dev_pm_opp_get_max_volt_latency(struct device *dev)
>  {
> -	struct opp_table *opp_table __free(put_opp_table);
>  	struct dev_pm_opp *opp;
>  	struct regulator *reg;
>  	unsigned long latency_ns =3D 0;
> @@ -337,7 +335,8 @@ unsigned long dev_pm_opp_get_max_volt_latency(struct =
device *dev)
>  		unsigned long max;
>  	} *uV;
> =20
> -	opp_table =3D _find_opp_table(dev);
> +	struct opp_table *opp_table __free(put_opp_table) =3D
> +		_find_opp_table(dev);

here too etc...

>  	if (IS_ERR(opp_table))
>  		return 0;
> =20

